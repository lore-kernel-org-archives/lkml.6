Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753274AbeE1FZC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 01:25:02 -0400
Received: from vps01.wiesinger.com ([46.36.37.179]:53346 "EHLO
        vps01.wiesinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753137AbeE1FZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 01:25:00 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com w4S5OqbU008017
Subject: Re: B53 DSA switch problem on Banana Pi-R1 on Fedora 26 -
 systemd-networkd problem
To: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        initramfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <3bdb712d-38bd-e2ca-63cf-8406a7b5689d@wiesinger.com>
 <20180522201632.GB4396@lunn.ch>
 <59d6b55f-d50a-063c-90a9-31a758e01383@gmail.com>
 <fa5c2615-40b3-62bc-3dda-59f9ef574686@wiesinger.com>
 <76c3f5ec-0ab2-c06d-98e8-277284bb1a8e@gmail.com>
 <779f2be3-3e74-e650-5240-efaf1003d77c@wiesinger.com>
 <4f7c5173-019d-ba0e-70b3-addf64a6a9fa@gmail.com>
 <aba2788a-ba54-dbc8-dd60-e862ba31d66d@wiesinger.com>
 <53c9272a-0e1a-e8fb-a3e4-b4e23e77be10@gmail.com>
 <ba1a6179-48ff-ca2b-bb3c-f99f8376df50@wiesinger.com>
 <18ca17a1-4673-2ace-7142-d4aef6854bc4@wiesinger.com>
 <219eaac0-3d76-005a-f8d6-c54ea21f205e@wiesinger.com>
 <485b3a0e-23d6-c90c-6f41-8d9f33b1ad1f@wiesinger.com>
 <6c93d27e-66dc-02a9-f8f9-f349f27dfec6@gmail.com>
From: Gerhard Wiesinger <lists@wiesinger.com>
Message-ID: <bf9f5db4-7fb8-2ccd-7ba3-f31da6c344ce@wiesinger.com>
Date: Mon, 28 May 2018 07:24:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <6c93d27e-66dc-02a9-f8f9-f349f27dfec6@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.05.2018 22:35, Florian Fainelli wrote:
> Le 05/27/18 à 12:18, Gerhard Wiesinger a écrit :
>> On 27.05.2018 21:01, Gerhard Wiesinger wrote:
>>> On 24.05.2018 08:22, Gerhard Wiesinger wrote:
>>>> On 24.05.2018 07:29, Gerhard Wiesinger wrote:
>>>>> After some analysis with Florian (thnx) we found out that the
>>>>> current implementation is broken:
>>>>>
>>>>> https://patchwork.ozlabs.org/patch/836538/
>>>>> https://github.com/torvalds/linux/commit/c499696e7901bda18385ac723b7bd27c3a4af624#diff-a2b6f8d89e18de600e873ac3ac43fa1d
>>>>>
>>>>>
>>>>> Florians comment:
>>>>>
>>>>> c499696e7901bda18385ac723b7bd27c3a4af624 ("net: dsa: b53: Stop using
>>>>> dev->cpu_port incorrectly") since it would result in no longer setting
>>>>> the CPU port as tagged for a specific VLAN. Easiest way for you right
>>>>> now is to just revert it, but this needs some more thoughts for a
>>>>> proper
>>>>> upstream change. I will think about it some more.
>>>> Can confirm 4.14.18-200.fc26.armv7hl works, 4.15.x should be broken.
>>>>
>>>> # Kernel 4.14.x ok
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/log/drivers/net/dsa/b53?h=v4.14.43
>>>>
>>>> # Kernel 4.15.x should be NOT ok
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/log/drivers/net/dsa/b53?h=v4.15.18
>>>>
>>>
>> Forgot to mention: What's also strange is that the VLAN ID is very high:
>>
>> # 4.14.18-300.fc27.armv7hl, iproute-4.15.0-1.fc28.armv7hl
>> ip -d link show eth0.101 | grep "vlan protocol"
>>      vlan protocol 802.1Q id 3069279796 <REORDER_HDR>
>> ip -d link show eth0.102 | grep "vlan protocol"
>>      vlan protocol 802.1Q id 3068673588 <REORDER_HDR>
>>
>> On older kernels this looks ok: 4.12.8-200.fc25.armv7hl,
>> iproute-4.11.0-1.fc25.armv7hl:
>>   ip -d link show eth0.101 | grep "vlan protocol"
>>      vlan protocol 802.1Q id 101 <REORDER_HDR>
>> ip -d link show eth0.102 | grep "vlan protocol"
>>      vlan protocol 802.1Q id 102 <REORDER_HDR>
>>
>> Ideas?
> That is quite likely a kernel/iproute2 issue, if you configured the
> switch through bridge vlan to have the ports in VLAN 101 and VLAN 102
> and you do indeed see frames entering eth0 with these VLAN IDs, then
> clearly the bridge -> switchdev -> dsa -> b53 part is working just fine
> and what you are seeing is some for of kernel header/netlink
> incompatibility.

Yes, sniffing on eth0 shows the correct VLAN IDs, e.g. 101.

Yes, my guess is that tools are wrong and have random values on 2 calls 
in different values (e.g. alsopromiscuity ) , see below ....

Who can fix it?

BTW: On FC27 same issue with same kernel version, but guess older 
iproute version.

Ciao,

Gerhard


ip -d link show eth0.101

13: eth0.101@eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc 
noqueue master br0 state UP mode DEFAULT group default qlen 1000
     link/ether 02:18:09:ab:cd:ef brd ff:ff:ff:ff:ff:ff promiscuity 
3068661300
     vlan protocol 802.1Q id 3068661300 <REORDER_HDR>
     bridge_slave state forwarding priority 32 cost 4 hairpin off guard 
off root_block off fastleave off learning on flood on port_id 0x8005 
port_no 0x5 designa
ted_port 3068661300 designated_cost 3068661300 designated_bridge 
8000.66:5d:a2:ab:cd:ef designated_root 8000.66:5d:a2:ab:cd:ef 
hold_timer    0.00 message_age_tim
er    0.00 forward_delay_timer    0.00 topology_change_ack 3068661300 
config_pending 3068661300 proxy_arp off proxy_arp_wifi off mcast_router 
3068661300 mcast_
fast_leave off mcast_flood on vlan_tunnel off addrgenmode eui64 
numtxqueues 3068661300 numrxqueues 3068661300 gso_max_size 3068661300 
gso_max_segs 3068661300

ip -d link show eth0.101
13: eth0.101@eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc 
noqueue master br0 state UP mode DEFAULT group default qlen 1000
     link/ether 02:18:09:ab:cd:ef brd ff:ff:ff:ff:ff:ff promiscuity 
3068735028
     vlan protocol 802.1Q id 3068735028 <REORDER_HDR>
     bridge_slave state forwarding priority 32 cost 4 hairpin off guard 
off root_block off fastleave off learning on flood on port_id 0x8005 
port_no 0x5 designa
ted_port 3068735028 designated_cost 3068735028 designated_bridge 
8000.66:5d:ab:cd:ef designated_root 8000.66:5d:a2:ab:cd:ef hold_timer    
0.00 message_age_tim
er    0.00 forward_delay_timer    0.00 topology_change_ack 3068735028 
config_pending 3068735028 proxy_arp off proxy_arp_wifi off mcast_router 
3068735028 mcast_
fast_leave off mcast_flood on vlan_tunnel off addrgenmode eui64 
numtxqueues 3068735028 numrxqueues 3068735028 gso_max_size 3068735028 
gso_max_segs 3068735028
