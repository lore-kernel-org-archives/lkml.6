Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753934AbeEWEt5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 00:49:57 -0400
Received: from vps01.wiesinger.com ([46.36.37.179]:33670 "EHLO
        vps01.wiesinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbeEWEt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 00:49:56 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com w4N4nnal025926
Subject: Re: B53 DSA switch problem on Banana Pi-R1 on Fedora 26
To: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org
References: <3bdb712d-38bd-e2ca-63cf-8406a7b5689d@wiesinger.com>
 <20180522201632.GB4396@lunn.ch>
 <59d6b55f-d50a-063c-90a9-31a758e01383@gmail.com>
From: Gerhard Wiesinger <lists@wiesinger.com>
Message-ID: <fa5c2615-40b3-62bc-3dda-59f9ef574686@wiesinger.com>
Date: Wed, 23 May 2018 06:49:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <59d6b55f-d50a-063c-90a9-31a758e01383@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.05.2018 22:42, Florian Fainelli wrote:
> On 05/22/2018 01:16 PM, Andrew Lunn wrote:
>>> Planned network structure will be as with 4.7.x kernels:
>>>
>>> br0 <=> eth0.101 <=> eth0 (vlan 101 tagged) <=> lan 1-lan4 (vlan 101
>>> untagged pvid)
>>>
>>> br1 <=> eth0.102 <=> eth0 (vlan 102 tagged) <=> wan (vlan 102 untagged pvid)
>> Do you even need these vlans?
> Yes, remember, b53 does not currently turn on Broadcom tags, so the only
> way to segregate traffic is to have VLANs for that.
>
>> Are you doing this for port separation? To keep lan1-4 traffic
>> separate from wan? DSA does that by default, no vlan needed.
>>
>> So you can just do
>>
>> ip link add name br0 type bridge
>> ip link set dev br0 up
>> ip link set dev lan1 master br0
>> ip link set dev lan2 master br0
>> ip link set dev lan3 master br0
>> ip link set dev lan4 master br0
>>
>> and use interface wan directly, no bridge needed.
> That would work once Broadcom tags are turned on which requires turning
> on managed mode, which requires work that I have not been able to get
> done :)

Setup with swconfig:

#!/usr/bin/bash


INTERFACE=eth0

# Delete all IP addresses and get link up
ip addr flush dev ${INTERFACE}
ip link set ${INTERFACE} up

# Lamobo R1 aka BPi R1 Routerboard
#
# Speaker | LAN1 | LAN2 | LAN3 | LAN4 || LAN5 | HDMI
# SW-Port |  P2  |  P1  |  P0  |  P4  ||  P3  |
# VLAN    |  11  |  12  |  13  |  14  ||ALL(t)|
#
# Switch-Port P8 - ALL(t) boards internal CPU Port

# Setup switch
swconfig dev ${INTERFACE} set reset 1
swconfig dev ${INTERFACE} set enable_vlan 1
swconfig dev ${INTERFACE} vlan 101 set ports '3 8t'
swconfig dev ${INTERFACE} vlan 102 set ports '4 0 1 2 8t'
swconfig dev ${INTERFACE} set apply 1

How to achieve this setup CURRENTLY with DSA?

And in the future (time plan)?

Thank you.

Ciao,
Gerhard
