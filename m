Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933855AbeEWRaD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 13:30:03 -0400
Received: from vps01.wiesinger.com ([46.36.37.179]:36002 "EHLO
        vps01.wiesinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932667AbeEWRaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 13:30:02 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com w4NHTtET004227
Subject: Re: B53 DSA switch problem on Banana Pi-R1 on Fedora 26
To: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org
References: <3bdb712d-38bd-e2ca-63cf-8406a7b5689d@wiesinger.com>
 <20180522201632.GB4396@lunn.ch>
 <59d6b55f-d50a-063c-90a9-31a758e01383@gmail.com>
 <fa5c2615-40b3-62bc-3dda-59f9ef574686@wiesinger.com>
 <76c3f5ec-0ab2-c06d-98e8-277284bb1a8e@gmail.com>
 <e1b56677-50e5-94e0-86f0-b0c797c4897d@gmail.com>
From: Gerhard Wiesinger <lists@wiesinger.com>
Message-ID: <88af3639-f3f9-ed45-c6bd-b30021347633@wiesinger.com>
Date: Wed, 23 May 2018 19:29:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <e1b56677-50e5-94e0-86f0-b0c797c4897d@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.05.2018 17:50, Florian Fainelli wrote:
>
> On 05/23/2018 08:28 AM, Florian Fainelli wrote:
>>
>> On 05/22/2018 09:49 PM, Gerhard Wiesinger wrote:
>>> On 22.05.2018 22:42, Florian Fainelli wrote:
>>>> On 05/22/2018 01:16 PM, Andrew Lunn wrote:
>>>>>> Planned network structure will be as with 4.7.x kernels:
>>>>>>
>>>>>> br0 <=> eth0.101 <=> eth0 (vlan 101 tagged) <=> lan 1-lan4 (vlan 101
>>>>>> untagged pvid)
>>>>>>
>>>>>> br1 <=> eth0.102 <=> eth0 (vlan 102 tagged) <=> wan (vlan 102
>>>>>> untagged pvid)
>>>>> Do you even need these vlans?
>>>> Yes, remember, b53 does not currently turn on Broadcom tags, so the only
>>>> way to segregate traffic is to have VLANs for that.
>>>>
>>>>> Are you doing this for port separation? To keep lan1-4 traffic
>>>>> separate from wan? DSA does that by default, no vlan needed.
>>>>>
>>>>> So you can just do
>>>>>
>>>>> ip link add name br0 type bridge
>>>>> ip link set dev br0 up
>>>>> ip link set dev lan1 master br0
>>>>> ip link set dev lan2 master br0
>>>>> ip link set dev lan3 master br0
>>>>> ip link set dev lan4 master br0
>>>>>
>>>>> and use interface wan directly, no bridge needed.
>>>> That would work once Broadcom tags are turned on which requires turning
>>>> on managed mode, which requires work that I have not been able to get
>>>> done :)
>>> Setup with swconfig:
>>>
>>> #!/usr/bin/bash
>>>
>>>
>>> INTERFACE=eth0
>>>
>>> # Delete all IP addresses and get link up
>>> ip addr flush dev ${INTERFACE}
>>> ip link set ${INTERFACE} up
>>>
>>> # Lamobo R1 aka BPi R1 Routerboard
>>> #
>>> # Speaker | LAN1 | LAN2 | LAN3 | LAN4 || LAN5 | HDMI
>>> # SW-Port |  P2  |  P1  |  P0  |  P4  ||  P3  |
>>> # VLAN    |  11  |  12  |  13  |  14  ||ALL(t)|
>>> #
>>> # Switch-Port P8 - ALL(t) boards internal CPU Port
>>>
>>> # Setup switch
>>> swconfig dev ${INTERFACE} set reset 1
>>> swconfig dev ${INTERFACE} set enable_vlan 1
>>> swconfig dev ${INTERFACE} vlan 101 set ports '3 8t'
>>> swconfig dev ${INTERFACE} vlan 102 set ports '4 0 1 2 8t'
>>> swconfig dev ${INTERFACE} set apply 1
>>>
>>> How to achieve this setup CURRENTLY with DSA?
>> Your first email had the right programming sequence, but you did not
>> answer whether you have CONFIG_BRIDGE_VLAN_FILTERING enabled or not,
>> which is likely your problem.
> Here are some reference configurations that should work:
>
> https://github.com/armbian/build/issues/511#issuecomment-320473246

I know, some comments are from me but none of them worked, therefore on 
LKML :-)

/boot/config-4.16.7-100.fc26.armv7hl:CONFIG_BRIDGE_VLAN_FILTERING=y

so this can't be the issue, any further ideas?

On my 2nd Banana Pi-R1 still on Fedora 25 with kernel 
4.12.8-200.fc25.armv7hl the commands still work well, but I wanted to 
test the upgrade on another one.

/boot/config-4.12.8-200.fc25.armv7hl:CONFIG_BRIDGE_VLAN_FILTERING=y

Thnx.

Ciao,

Gerhard
