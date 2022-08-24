#!/bin/bash

############################################################
# CephAdmin Install Script for Debian 10, 11 (Bullseye)
# Note: this is for testing, not running
# run as sudo 
############################################################

# determine if we run as sudo
userid="${SUDO_USER:-$USER}"
if [ "$userid" == 'root' ]
  then 
    echo "Please run the setup as sudo and not as root!"
    exit 1
fi
if [ "$EUID" -ne 0 ]
  then 
    echo "Please run setup as sudo!"
    exit 1
fi

echo "###############################################"
echo " installing cephadm on deployment-host only...."
echo "###############################################"
curl --silent --remote-name --location https://raw.githubusercontent.com/ceph/ceph/quincy/src/cephadm/cephadm
mv cephadm /usr/local/bin
chmod +x /usr/local/bin/cephadm
mkdir -p /etc/ceph

# add ceph common tools
cephadm add-repo --release quincy
cephadm install ceph-common
