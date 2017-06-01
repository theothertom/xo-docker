FROM debian:sid

MAINTAINER Tom Grace <tom@deathybycomputers.co.uk>

RUN apt-get update; apt-get dist-upgrade -y; apt-get install -y curl build-essential redis-server libpng-dev git python-minimal apt-transport-https

#Install "n"
RUN curl -o /usr/local/bin/n https://raw.githubusercontent.com/visionmedia/n/master/bin/n
RUN chmod +x /usr/local/bin/n
RUN n lts

#Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update; apt-get -y install yarn

#Update NPM
#RUN npm i -g semver are-we-there-yet
#RUN npm i -g npm

RUN git clone -b next-release http://github.com/vatesfr/xo-server
RUN git clone -b next-release http://github.com/vatesfr/xo-web

RUN cd xo-server; yarn && yarn run build
RUN cd xo-web; yarn && yarn run build
COPY xo-server.yaml /xo-server/.xo-server.yaml
