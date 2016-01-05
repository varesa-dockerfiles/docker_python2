FROM centos:latest

MAINTAINER Esa Varemo <esa@kuivanto.fi>

EXPOSE 22


# Install packages
RUN yum update -y
RUN yum install -y bzip2-devel gcc git libffi-devel make openssh-server openssl-devel python-setuptools sqlite-devel wget

# Install Python2
RUN mkdir /src/
WORKDIR /src/

ENV PY_VER=2.7.11

RUN wget -O - https://www.python.org/ftp/python/$PY_VER/Python-$PY_VER.tar.xz | xzcat | tar xv

WORKDIR /src/Python-$PY_VER/

RUN ./configure && make -j3 && make install -j3
RUN python -m ensurepip


RUN useradd user

# Run
ADD entrypoint_ssh.sh /entrypoint_ssh.sh
CMD bash
