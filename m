Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA29C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F8D2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="FWDDM5b6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfAQMLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:11:01 -0500
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:42814 "EHLO
        forwardcorp1g.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726007AbfAQMLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 07:11:01 -0500
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1g.cmail.yandex.net (Yandex) with ESMTP id E80D920273;
        Thu, 17 Jan 2019 15:10:49 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id dJu7GztBYK-AnJKkEEk;
        Thu, 17 Jan 2019 15:10:49 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1547727049; bh=axfM5D+ow9KLAgZX7yGrDORGVAwo0SZNTnTXzgFrQzg=;
        h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To;
        b=FWDDM5b6AFgRjrIt8Cq2d5hwTEJQi8oQHIFo873tiZkN2uiLyEKdIFr9r3kwCkKCC
         XwcwMgQTJyOKRRwxCcVp7GYco2w/1an1JdLQj+IhLwKfZAuOCZ9etcL35HY065kTcF
         5cWBHvz5VM9NVvShyNV8D2N09NHYxSthMUwAaEdo=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d61:94ee:8ddd:e2ce])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id l0jjRsMaug-Ani4RSMZ;
        Thu, 17 Jan 2019 15:10:49 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: fix cyclic resets at link up
 with active tx
To:     "Neftin, Sasha" <sasha.neftin@intel.com>, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
References: <154747257030.250168.12931902291381446144.stgit@buzz>
 <031e1689-e133-5398-ad00-8f45f679ffff@intel.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <942e559e-32ee-9e05-1489-823662d0dfe9@yandex-team.ru>
Date:   Thu, 17 Jan 2019 15:10:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <031e1689-e133-5398-ad00-8f45f679ffff@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.01.2019 10:57, Neftin, Sasha wrote:
> On 1/14/2019 15:29, Konstantin Khlebnikov wrote:
>> I'm seeing series of e1000e resets (sometimes endless) at system boot
>> if something generates tx traffic at this time. In my case this is
>> netconsole who sends message "e1000e 0000:02:00.0: Some CPU C-states
>> have been disabled in order to enable jumbo frames" from e1000e itself.
>> As result e1000_watchdog_task sees used tx buffer while carrier is off
>> and start this reset cycle again.
>>
>> [   17.794359] e1000e: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
>> [   17.794714] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
>> [   22.936455] e1000e 0000:02:00.0 eth1: changing MTU from 1500 to 9000
>> [   23.033336] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
>> [   26.102364] e1000e: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
>> [   27.174495] 8021q: 802.1Q VLAN Support v1.8
>> [   27.174513] 8021q: adding VLAN 0 to HW filter on device eth1
>> [   30.671724] cgroup: cgroup: disabling cgroup2 socket matching due to net_prio or net_cls activation
>> [   30.898564] netpoll: netconsole: local port 6666
>> [   30.898566] netpoll: netconsole: local IPv6 address 2a02:6b8:0:80b:beae:c5ff:fe28:23f8
>> [   30.898567] netpoll: netconsole: interface 'eth1'
>> [   30.898568] netpoll: netconsole: remote port 6666
>> [   30.898568] netpoll: netconsole: remote IPv6 address 2a02:6b8:b000:605c:e61d:2dff:fe03:3790
>> [   30.898569] netpoll: netconsole: remote ethernet address b0:a8:6e:f4:ff:c0
>> [   30.917747] console [netcon0] enabled
>> [   30.917749] netconsole: network logging started
>> [   31.453353] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
>> [   34.185730] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
>> [   34.321840] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
>> [   34.465822] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
>> [   34.597423] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
>> [   34.745417] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
>> [   34.877356] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
>> [   35.005441] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
>> [   35.157376] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
>> [   35.289362] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
>> [   35.417441] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
>> [   37.790342] e1000e: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
>>
>> This patch flushes tx buffers only once when carrier is off
>> rather than at each watchdog iteration.
>>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> ---
>>   drivers/net/ethernet/intel/e1000e/netdev.c |   15 ++++++---------
>>   1 file changed, 6 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
>> index 189f231075c2..d10083beec83 100644
>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>> @@ -5309,8 +5309,13 @@ static void e1000_watchdog_task(struct work_struct *work)
>>               /* 8000ES2LAN requires a Rx packet buffer work-around
>>                * on link down event; reset the controller to flush
>>                * the Rx packet buffer.
>> +             *
>> +             * If the link is lost the controller stops DMA, but
>> +             * if there is queued Tx work it cannot be done.  So
>> +             * reset the controller to flush the Tx packet buffers.
>>                */
>> -            if (adapter->flags & FLAG_RX_NEEDS_RESTART)
>> +            if ((adapter->flags & FLAG_RX_NEEDS_RESTART) ||
>> +                e1000_desc_unused(tx_ring) + 1 < tx_ring->count)
>>                   adapter->flags |= FLAG_RESTART_NOW;
>>               else
>>                   pm_schedule_suspend(netdev->dev.parent,
>> @@ -5333,14 +5338,6 @@ static void e1000_watchdog_task(struct work_struct *work)
>>       adapter->gotc_old = adapter->stats.gotc;
>>       spin_unlock(&adapter->stats64_lock);
>> -    /* If the link is lost the controller stops DMA, but
>> -     * if there is queued Tx work it cannot be done.  So
>> -     * reset the controller to flush the Tx packet buffers.
>> -     */
>> -    if (!netif_carrier_ok(netdev) &&
>> -        (e1000_desc_unused(tx_ring) + 1 < tx_ring->count))
>> -        adapter->flags |= FLAG_RESTART_NOW;
>> -
>>       /* If reset is necessary, do it outside of interrupt context. */
>>       if (adapter->flags & FLAG_RESTART_NOW) {
>>           schedule_work(&adapter->reset_task);
>>
>> _______________________________________________
>> Intel-wired-lan mailing list
>> Intel-wired-lan@osuosl.org
>> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
>>
> What is the HW setup you encountered this issue? Could you try to disable the jumbo frame and recheck? We cannot allow the low CPU states 
> when the jumbo feature is enabled. This is HW design.
> We will try to review this patch next week. Please, be patient.

Without jumbo frames there will be no message about disabled c-states.
Thus tx queue will be likely empty and nothing will trigger that cyclic restart.

Sequence might depend on uplink switch reaction - how fast carrier signal appears.


$ lscpu
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                24
On-line CPU(s) list:   0-23
Thread(s) per core:    2
Core(s) per socket:    6
Socket(s):             2
NUMA node(s):          2
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 44
Model name:            Intel(R) Xeon(R) CPU           E5645  @ 2.40GHz
Stepping:              2
CPU MHz:               1600.037
BogoMIPS:              4800.19
Virtualization:        VT-x
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              12288K
NUMA node0 CPU(s):     0-5,12-17
NUMA node1 CPU(s):     6-11,18-23
Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm 
pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq 
dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 popcnt aes lahf_lm epb tpr_shadow vnmi flexpriority ept 
vpid dtherm ida arat


$ lspci
00:00.0 Host bridge: Intel Corporation 5500 I/O Hub to ESI Port (rev 22)
00:01.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 1 (rev 22)
00:02.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 2 (rev 22)
00:03.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 3 (rev 22)
00:07.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 7 (rev 22)
00:08.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 8 (rev 22)
00:09.0 PCI bridge: Intel Corporation 7500/5520/5500/X58 I/O Hub PCI Express Root Port 9 (rev 22)
00:0a.0 PCI bridge: Intel Corporation 7500/5520/5500/X58 I/O Hub PCI Express Root Port 10 (rev 22)
00:10.0 PIC: Intel Corporation 7500/5520/5500/X58 Physical and Link Layer Registers Port 0 (rev 22)
00:10.1 PIC: Intel Corporation 7500/5520/5500/X58 Routing and Protocol Layer Registers Port 0 (rev 22)
00:11.0 PIC: Intel Corporation 7500/5520/5500 Physical and Link Layer Registers Port 1 (rev 22)
00:11.1 PIC: Intel Corporation 7500/5520/5500 Routing & Protocol Layer Register Port 1 (rev 22)
00:14.0 PIC: Intel Corporation 7500/5520/5500/X58 I/O Hub System Management Registers (rev 22)
00:14.1 PIC: Intel Corporation 7500/5520/5500/X58 I/O Hub GPIO and Scratch Pad Registers (rev 22)
00:14.2 PIC: Intel Corporation 7500/5520/5500/X58 I/O Hub Control Status and RAS Registers (rev 22)
00:14.3 PIC: Intel Corporation 7500/5520/5500/X58 I/O Hub Throttle Registers (rev 22)
00:16.0 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
00:16.1 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
00:16.2 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
00:16.3 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
00:16.4 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
00:16.5 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
00:16.6 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
00:16.7 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
00:1a.0 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #4
00:1a.1 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #5
00:1a.7 USB controller: Intel Corporation 82801JI (ICH10 Family) USB2 EHCI Controller #2
00:1c.0 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express Root Port 1
00:1c.4 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express Root Port 5
00:1c.5 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express Root Port 6
00:1d.0 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #1
00:1d.1 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #2
00:1d.2 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #3
00:1d.3 USB controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #6
00:1d.7 USB controller: Intel Corporation 82801JI (ICH10 Family) USB2 EHCI Controller #1
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 90)
00:1f.0 ISA bridge: Intel Corporation 82801JIR (ICH10R) LPC Interface Controller
00:1f.2 SATA controller: Intel Corporation 82801JI (ICH10 Family) SATA AHCI Controller
00:1f.3 SMBus: Intel Corporation 82801JI (ICH10 Family) SMBus Controller
01:01.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED Graphics Family (rev 10)
02:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
03:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
fe:00.0 Host bridge: Intel Corporation Xeon 5600 Series QuickPath Architecture Generic Non-core Registers (rev 02)
fe:00.1 Host bridge: Intel Corporation Xeon 5600 Series QuickPath Architecture System Address Decoder (rev 02)
fe:02.0 Host bridge: Intel Corporation Xeon 5600 Series QPI Link 0 (rev 02)
fe:02.1 Host bridge: Intel Corporation Xeon 5600 Series QPI Physical 0 (rev 02)
fe:02.2 Host bridge: Intel Corporation Xeon 5600 Series Mirror Port Link 0 (rev 02)
fe:02.3 Host bridge: Intel Corporation Xeon 5600 Series Mirror Port Link 1 (rev 02)
fe:02.4 Host bridge: Intel Corporation Xeon 5600 Series QPI Link 1 (rev 02)
fe:02.5 Host bridge: Intel Corporation Xeon 5600 Series QPI Physical 1 (rev 02)
fe:03.0 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Registers (rev 02)
fe:03.1 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Target Address Decoder (rev 02)
fe:03.2 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller RAS Registers (rev 02)
fe:03.4 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Test Registers (rev 02)
fe:04.0 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 0 Control (rev 02)
fe:04.1 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 0 Address (rev 02)
fe:04.2 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 0 Rank (rev 02)
fe:04.3 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 0 Thermal Control (rev 02)
fe:05.0 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 1 Control (rev 02)
fe:05.1 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 1 Address (rev 02)
fe:05.2 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 1 Rank (rev 02)
fe:05.3 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 1 Thermal Control (rev 02)
fe:06.0 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 2 Control (rev 02)
fe:06.1 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 2 Address (rev 02)
fe:06.2 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 2 Rank (rev 02)
fe:06.3 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 2 Thermal Control (rev 02)
ff:00.0 Host bridge: Intel Corporation Xeon 5600 Series QuickPath Architecture Generic Non-core Registers (rev 02)
ff:00.1 Host bridge: Intel Corporation Xeon 5600 Series QuickPath Architecture System Address Decoder (rev 02)
ff:02.0 Host bridge: Intel Corporation Xeon 5600 Series QPI Link 0 (rev 02)
ff:02.1 Host bridge: Intel Corporation Xeon 5600 Series QPI Physical 0 (rev 02)
ff:02.2 Host bridge: Intel Corporation Xeon 5600 Series Mirror Port Link 0 (rev 02)
ff:02.3 Host bridge: Intel Corporation Xeon 5600 Series Mirror Port Link 1 (rev 02)
ff:02.4 Host bridge: Intel Corporation Xeon 5600 Series QPI Link 1 (rev 02)
ff:02.5 Host bridge: Intel Corporation Xeon 5600 Series QPI Physical 1 (rev 02)
ff:03.0 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Registers (rev 02)
ff:03.1 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Target Address Decoder (rev 02)
ff:03.2 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller RAS Registers (rev 02)
ff:03.4 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Test Registers (rev 02)
ff:04.0 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 0 Control (rev 02)
ff:04.1 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 0 Address (rev 02)
ff:04.2 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 0 Rank (rev 02)
ff:04.3 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 0 Thermal Control (rev 02)
ff:05.0 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 1 Control (rev 02)
ff:05.1 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 1 Address (rev 02)
ff:05.2 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 1 Rank (rev 02)
ff:05.3 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 1 Thermal Control (rev 02)
ff:06.0 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 2 Control (rev 02)
ff:06.1 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 2 Address (rev 02)
ff:06.2 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 2 Rank (rev 02)
ff:06.3 Host bridge: Intel Corporation Xeon 5600 Series Integrated Memory Controller Channel 2 Thermal Control (rev 02)


full dmesg

[    0.000000] Linux version 4.19.15-test (khlebnikov@kernel1.search.yandex.net) (gcc version 5.4.0 20160609 (Ubuntu 
5.4.0-6ubuntu1~16.04.11)) #2 SMP Mon Jan 14 12:50:23 UTC 2019
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.19.15-test root=/dev/mapper/hdd-root ro pti=off spectre_v2=off consoleblank=0 
biosdevname=0 net.ifnames=0
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000100-0x000000000009ebff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009ec00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e4000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bf77ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bf78e000-0x00000000bf78ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bf790000-0x00000000bf79dfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000bf79e000-0x00000000bf7cffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bf7d0000-0x00000000bf7dffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bf7ec000-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffe00000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000000c3fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.5 present.
[    0.000000] DMI: System manufacturer System Product Name/Z8NR-D12, BIOS 1501    10/25/2011
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2399.962 MHz processor
[    0.002727] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.002730] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.002737] last_pfn = 0xc40000 max_arch_pfn = 0x400000000
[    0.002742] MTRR default type: uncachable
[    0.002743] MTRR fixed ranges enabled:
[    0.002744]   00000-9FFFF write-back
[    0.002745]   A0000-BFFFF uncachable
[    0.002746]   C0000-DFFFF write-protect
[    0.002747]   E0000-E7FFF write-through
[    0.002748]   E8000-FFFFF write-protect
[    0.002748] MTRR variable ranges enabled:
[    0.002750]   0 base 0000000000 mask FF80000000 write-back
[    0.002751]   1 base 0080000000 mask FFC0000000 write-back
[    0.002752]   2 base 00BF800000 mask FFFF800000 uncachable
[    0.002753]   3 base 0100000000 mask FF00000000 write-back
[    0.002754]   4 base 0200000000 mask FE00000000 write-back
[    0.002755]   5 base 0400000000 mask FC00000000 write-back
[    0.002756]   6 base 0800000000 mask FC00000000 write-back
[    0.002757]   7 base 0C00000000 mask FFC0000000 write-back
[    0.002757]   8 disabled
[    0.002758]   9 disabled
[    0.004742] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.005299] total RAM covered: 49144M
[    0.005812] Found optimal setting for mtrr clean up
[    0.005814]  gran_size: 64K 	chunk_size: 16M 	num_reg: 8  	lose cover RAM: 0G
[    0.007189] e820: update [mem 0xbf800000-0xffffffff] usable ==> reserved
[    0.007195] last_pfn = 0xbf780 max_arch_pfn = 0x400000000
[    0.018143] found SMP MP-table at [mem 0x000ff780-0x000ff78f] mapped at [(____ptrval____)]
[    0.026523] Scanning 1 areas for low memory corruption
[    0.026527] Base memory trampoline at [(____ptrval____)] 98000 size 24576
[    0.026530] Kernel/User page tables isolation: disabled on command line.
[    0.026533] Using GB pages for direct mapping
[    0.026536] BRK [0xc3fc01000, 0xc3fc01fff] PGTABLE
[    0.026539] BRK [0xc3fc02000, 0xc3fc02fff] PGTABLE
[    0.026541] BRK [0xc3fc03000, 0xc3fc03fff] PGTABLE
[    0.026855] BRK [0xc3fc04000, 0xc3fc04fff] PGTABLE
[    0.026912] BRK [0xc3fc05000, 0xc3fc05fff] PGTABLE
[    0.027021] RAMDISK: [mem 0xc3b387000-0xc3dffffff]
[    0.027034] ACPI: Early table checksum verification disabled
[    0.027143] ACPI: RSDP 0x00000000000FB410 000024 (v02 ACPIAM)
[    0.027148] ACPI: XSDT 0x00000000BF790100 000084 (v01 102511 XSDT1714 20111025 MSFT 00000097)
[    0.027157] ACPI: FACP 0x00000000BF790290 0000F4 (v03 102511 FACP1714 20111025 MSFT 00000097)
[    0.027163] ACPI BIOS Warning (bug): 32/64X length mismatch in FADT/Gpe0Block: 128/64 (20180810/tbfadt-569)
[    0.027169] ACPI: DSDT 0x00000000BF790540 005AE1 (v01 S0075  S0075001 00000001 INTL 20060113)
[    0.027174] ACPI: FACS 0x00000000BF79E000 000040
[    0.027177] ACPI: FACS 0x00000000BF79E000 000040
[    0.027181] ACPI: APIC 0x00000000BF790390 00011E (v01 102511 APIC1714 20111025 MSFT 00000097)
[    0.027186] ACPI: MCFG 0x00000000BF7904B0 00003C (v01 102511 OEMMCFG  20111025 MSFT 00000097)
[    0.027191] ACPI: SPMI 0x00000000BF7904F0 000041 (v05 102511 OEMSPMI  20111025 MSFT 00000097)
[    0.027195] ACPI: OEMB 0x00000000BF79E040 000072 (v01 102511 OEMB1714 20111025 MSFT 00000097)
[    0.027200] ACPI: HPET 0x00000000BF798540 000038 (v01 102511 OEMHPET  20111025 MSFT 00000097)
[    0.027204] ACPI: SRAT 0x00000000BF798580 000228 (v01 102511 OEMSRAT  00000001 INTL 00000001)
[    0.027209] ACPI: SSDT 0x00000000BF79F740 000363 (v01 DpgPmm CpuPm    00000012 INTL 20060113)
[    0.027213] ACPI: EINJ 0x00000000BF7987B0 000130 (v01 AMIER  AMI_EINJ 20111025 MSFT 00000097)
[    0.027218] ACPI: BERT 0x00000000BF798940 000030 (v01 AMIER  AMI_BERT 20111025 MSFT 00000097)
[    0.027223] ACPI: ERST 0x00000000BF798970 0001B0 (v01 AMIER  AMI_ERST 20111025 MSFT 00000097)
[    0.027227] ACPI: HEST 0x00000000BF798B20 0000A8 (v01 AMIER  ABC_HEST 20111025 MSFT 00000097)
[    0.027240] ACPI: Local APIC address 0xfee00000
[    0.027279] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.027281] SRAT: PXM 1 -> APIC 0x20 -> Node 1
[    0.027282] SRAT: PXM 0 -> APIC 0x02 -> Node 0
[    0.027283] SRAT: PXM 0 -> APIC 0x04 -> Node 0
[    0.027285] SRAT: PXM 0 -> APIC 0x10 -> Node 0
[    0.027286] SRAT: PXM 0 -> APIC 0x12 -> Node 0
[    0.027287] SRAT: PXM 0 -> APIC 0x14 -> Node 0
[    0.027288] SRAT: PXM 1 -> APIC 0x22 -> Node 1
[    0.027289] SRAT: PXM 1 -> APIC 0x24 -> Node 1
[    0.027291] SRAT: PXM 1 -> APIC 0x30 -> Node 1
[    0.027292] SRAT: PXM 1 -> APIC 0x32 -> Node 1
[    0.027293] SRAT: PXM 1 -> APIC 0x34 -> Node 1
[    0.027294] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.027295] SRAT: PXM 0 -> APIC 0x03 -> Node 0
[    0.027297] SRAT: PXM 0 -> APIC 0x05 -> Node 0
[    0.027298] SRAT: PXM 0 -> APIC 0x11 -> Node 0
[    0.027299] SRAT: PXM 0 -> APIC 0x13 -> Node 0
[    0.027300] SRAT: PXM 0 -> APIC 0x15 -> Node 0
[    0.027301] SRAT: PXM 1 -> APIC 0x21 -> Node 1
[    0.027303] SRAT: PXM 1 -> APIC 0x23 -> Node 1
[    0.027304] SRAT: PXM 1 -> APIC 0x25 -> Node 1
[    0.027305] SRAT: PXM 1 -> APIC 0x31 -> Node 1
[    0.027306] SRAT: PXM 1 -> APIC 0x33 -> Node 1
[    0.027307] SRAT: PXM 1 -> APIC 0x35 -> Node 1
[    0.027311] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0xbfffffff]
[    0.027313] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x63fffffff]
[    0.027314] ACPI: SRAT: Node 1 PXM 1 [mem 0x640000000-0xc3fffffff]
[    0.027317] NUMA: Node 0 [mem 0x00000000-0xbfffffff] + [mem 0x100000000-0x63fffffff] -> [mem 0x00000000-0x63fffffff]
[    0.027325] NODE_DATA(0) allocated [mem 0x63fffb000-0x63fffffff]
[    0.027330] NODE_DATA(1) allocated [mem 0xc3fffb000-0xc3fffffff]
[    0.154203] Zone ranges:
[    0.154209]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.154212]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.154214]   Normal   [mem 0x0000000100000000-0x0000000c3fffffff]
[    0.154215]   Device   empty
[    0.154217] Movable zone start for each node
[    0.154218] Early memory node ranges
[    0.154220]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
[    0.154221]   node   0: [mem 0x0000000000100000-0x00000000bf77ffff]
[    0.154222]   node   0: [mem 0x0000000100000000-0x000000063fffffff]
[    0.154223]   node   1: [mem 0x0000000640000000-0x0000000c3fffffff]
[    0.154230] Reserved but unavailable: 99 pages
[    0.154232] Initmem setup node 0 [mem 0x0000000000001000-0x000000063fffffff]
[    0.154235] On node 0 totalpages: 6289181
[    0.154236]   DMA zone: 64 pages used for memmap
[    0.154237]   DMA zone: 21 pages reserved
[    0.154238]   DMA zone: 3997 pages, LIFO batch:0
[    0.154919]   DMA32 zone: 12190 pages used for memmap
[    0.154920]   DMA32 zone: 780160 pages, LIFO batch:63
[    0.180889]   Normal zone: 86016 pages used for memmap
[    0.180892]   Normal zone: 5505024 pages, LIFO batch:63
[    0.348852] Initmem setup node 1 [mem 0x0000000640000000-0x0000000c3fffffff]
[    0.348858] On node 1 totalpages: 6291456
[    0.348859]   Normal zone: 98304 pages used for memmap
[    0.348860]   Normal zone: 6291456 pages, LIFO batch:63
[    0.546041] ACPI: PM-Timer IO Port: 0x808
[    0.546048] ACPI: Local APIC address 0xfee00000
[    0.546059] ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
[    0.546071] IOAPIC[0]: apic_id 6, version 32, address 0xfec00000, GSI 0-23
[    0.546077] IOAPIC[1]: apic_id 7, version 32, address 0xfec8a000, GSI 24-47
[    0.546080] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.546083] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.546085] ACPI: IRQ0 used by override.
[    0.546087] ACPI: IRQ9 used by override.
[    0.546091] Using ACPI (MADT) for SMP configuration information
[    0.546093] ACPI: HPET id: 0x8086a301 base: 0xfed00000
[    0.546104] smpboot: Allowing 24 CPUs, 0 hotplug CPUs
[    0.546128] [mem 0xc0000000-0xdfffffff] available for PCI devices
[    0.546130] Booting paravirtualized kernel on bare hardware
[    0.546134] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.819690] random: get_random_bytes called from start_kernel+0x94/0x551 with crng_init=0
[    0.819704] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_cpu_ids:24 nr_node_ids:2
[    0.821567] percpu: Embedded 44 pages/cpu @(____ptrval____) s142104 r8192 d29928 u262144
[    0.821588] pcpu-alloc: s142104 r8192 d29928 u262144 alloc=1*2097152
[    0.821589] pcpu-alloc: [0] 00 01 02 03 04 05 12 13 [0] 14 15 16 17 -- -- -- --
[    0.821597] pcpu-alloc: [1] 06 07 08 09 10 11 18 19 [1] 20 21 22 23 -- -- -- --
[    0.821649] Built 2 zonelists, mobility grouping on.  Total pages: 12384042
[    0.821651] Policy zone: Normal
[    0.821654] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.19.15-test root=/dev/mapper/hdd-root ro pti=off spectre_v2=off consoleblank=0 
biosdevname=0 net.ifnames=0
[    1.061324] Memory: 49390984K/50322548K available (12300K kernel code, 1435K rwdata, 3552K rodata, 3120K init, 2152K bss, 931564K 
reserved, 0K cma-reserved)
[    1.061738] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=24, Nodes=2
[    1.061749] ftrace: allocating 35866 entries in 141 pages
[    1.083258] rcu: Hierarchical RCU implementation.
[    1.083260] rcu: 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=24.
[    1.083262] 	Tasks RCU enabled.
[    1.083263] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=24
[    1.088283] NR_IRQS: 16640, nr_irqs: 1024, preallocated irqs: 16
[    1.088954] Console: colour dummy device 80x25
[    1.089200] console [tty0] enabled
[    1.092754] ACPI: Core revision 20180810
[    1.092825] ACPI BIOS Warning (bug): Incorrect checksum in table [OEMB] - 0xFF, should be 0xFC (20180810/tbprint-177)
[    1.093228] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    1.093240] hpet clockevent registered
[    1.093261] APIC: Switch to symmetric I/O mode setup
[    1.093266] Switched APIC routing to physical flat.
[    1.094011] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    1.113247] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x229813d283d, max_idle_ns: 440795313186 ns
[    1.113264] Calibrating delay loop (skipped), value calculated using timer frequency.. 4799.92 BogoMIPS (lpj=9599848)
[    1.113269] pid_max: default: 24576 minimum: 301
[    1.113820] Security Framework initialized
[    1.113826] AppArmor: AppArmor disabled by boot time parameter
[    1.129364] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes)
[    1.137165] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    1.137641] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    1.137890] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    1.139425] mce: CPU supports 9 MCE banks
[    1.139443] CPU0: Thermal monitoring enabled (TM1)
[    1.139452] process: using mwait in idle threads
[    1.139457] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
[    1.139460] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    1.139464] Spectre V2 : off selected on command line.
[    1.139467] Speculative Store Bypass: Vulnerable
[    1.146528] Freeing SMP alternatives memory: 36K
[    1.149252] smpboot: CPU0: Intel(R) Xeon(R) CPU           E5645  @ 2.40GHz (family: 0x6, model: 0x2c, stepping: 0x2)
[    1.149252] Performance Events: PEBS fmt1+, Westmere events, 16-deep LBR, Intel PMU driver.
[    1.149252] core: CPUID marked event: 'bus cycles' unavailable
[    1.149252] ... version:                3
[    1.149252] ... bit width:              48
[    1.149252] ... generic registers:      4
[    1.149252] ... value mask:             0000ffffffffffff
[    1.149252] ... max period:             000000007fffffff
[    1.149252] ... fixed-purpose events:   3
[    1.149252] ... event mask:             000000070000000f
[    1.149252] rcu: Hierarchical SRCU implementation.
[    1.149252] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    1.149252] smp: Bringing up secondary CPUs ...
[    1.149473] x86: Booting SMP configuration:
[    1.149478] .... node  #0, CPUs:        #1  #2  #3  #4  #5
[    1.167622] .... node  #1, CPUs:    #6  #7  #8  #9 #10 #11
[    1.267291] .... node  #0, CPUs:   #12 #13 #14 #15 #16 #17
[    1.289370] .... node  #1, CPUs:   #18 #19 #20 #21 #22 #23
[    1.311358] smp: Brought up 2 nodes, 24 CPUs
[    1.311358] smpboot: Max logical packages: 2
[    1.311358] smpboot: Total of 24 processors activated (115201.89 BogoMIPS)
[    1.321566] devtmpfs: initialized
[    1.321841] x86/mm: Memory block size: 128MB
[    1.341323] PM: Registering ACPI NVS region [mem 0xbf79e000-0xbf7cffff] (204800 bytes)
[    1.341586] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    1.341586] futex hash table entries: 8192 (order: 7, 524288 bytes)
[    1.342141]
[    1.342144] *************************************************************
[    1.342147] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **
[    1.342150] **                                                         **
[    1.342152] **  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL  **
[    1.342155] **                                                         **
[    1.342157] ** This means that this kernel is built to expose internal **
[    1.342160] ** IOMMU data structures, which may compromise security on **
[    1.342163] ** your system.                                            **
[    1.342165] **                                                         **
[    1.342168] ** If you see this message and you are not debugging the   **
[    1.342170] ** kernel, report this immediately to your vendor!         **
[    1.342173] **                                                         **
[    1.342175] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **
[    1.342178] *************************************************************
[    1.342178] NET: Registered protocol family 16
[    1.342178] audit: initializing netlink subsys (disabled)
[    1.345305] audit: type=2000 audit(1547472106.256:1): state=initialized audit_enabled=0 res=1
[    1.345648] cpuidle: using governor ladder
[    1.345648] cpuidle: using governor menu
[    1.345648] ACPI: bus type PCI registered
[    1.345648] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    1.346105] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    1.346113] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    1.346143] PCI: Using configuration type 1 for base access
[    1.357552] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    1.357552] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    1.357552] cryptd: max_cpu_qlen set to 1000
[    1.357694] ACPI: Added _OSI(Module Device)
[    1.357698] ACPI: Added _OSI(Processor Device)
[    1.357701] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.357703] ACPI: Added _OSI(Processor Aggregator Device)
[    1.357711] ACPI: Added _OSI(Linux-Dell-Video)
[    1.357717] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    1.396417] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    1.402387] ACPI: Dynamic OEM Table Load:
[    1.402400] ACPI: SSDT 0xFFFF888623B79000 000C69 (v01 PmRef  P001Cst  00003001 INTL 20060113)
[    1.407461] ACPI: Dynamic OEM Table Load:
[    1.407471] ACPI: SSDT 0xFFFF888623B7A000 000A0A (v01 PmRef  Cpu0Tst  00003000 INTL 20060113)
[    1.414439] ACPI: Interpreter enabled
[    1.414479] ACPI: (supports S0 S1 S5)
[    1.414483] ACPI: Using IOAPIC for interrupt routing
[    1.414745] HEST: Table parsing has been initialized.
[    1.414751] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.416164] ACPI: Enabled 11 GPEs in block 00 to 3F
[    1.473587] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    1.473605] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    1.473637] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    1.475546] PCI host bridge to bus 0000:00
[    1.475555] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    1.475561] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    1.475567] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    1.475573] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000dffff window]
[    1.475579] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xdfffffff window]
[    1.475585] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xfed8ffff window]
[    1.475592] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.475613] pci 0000:00:00.0: [8086:3403] type 00 class 0x060000
[    1.475695] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    1.476135] pci 0000:00:01.0: [8086:3408] type 01 class 0x060400
[    1.476208] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    1.476692] pci 0000:00:02.0: [8086:3409] type 01 class 0x060400
[    1.476761] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    1.477242] pci 0000:00:03.0: [8086:340a] type 01 class 0x060400
[    1.477320] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    1.477806] pci 0000:00:07.0: [8086:340e] type 01 class 0x060400
[    1.477878] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    1.478354] pci 0000:00:08.0: [8086:340f] type 01 class 0x060400
[    1.478422] pci 0000:00:08.0: PME# supported from D0 D3hot D3cold
[    1.478893] pci 0000:00:09.0: [8086:3410] type 01 class 0x060400
[    1.478962] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
[    1.479438] pci 0000:00:0a.0: [8086:3411] type 01 class 0x060400
[    1.479507] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
[    1.479984] pci 0000:00:10.0: [8086:3425] type 00 class 0x080000
[    1.480408] pci 0000:00:10.1: [8086:3426] type 00 class 0x080000
[    1.480823] pci 0000:00:11.0: [8086:3427] type 00 class 0x080000
[    1.481241] pci 0000:00:11.1: [8086:3428] type 00 class 0x080000
[    1.481659] pci 0000:00:14.0: [8086:342e] type 00 class 0x080000
[    1.482099] pci 0000:00:14.1: [8086:3422] type 00 class 0x080000
[    1.482535] pci 0000:00:14.2: [8086:3423] type 00 class 0x080000
[    1.482971] pci 0000:00:14.3: [8086:3438] type 00 class 0x080000
[    1.483389] pci 0000:00:16.0: [8086:3430] type 00 class 0x088000
[    1.483405] pci 0000:00:16.0: reg 0x10: [mem 0xfbcd8000-0xfbcdbfff 64bit]
[    1.483846] pci 0000:00:16.1: [8086:3431] type 00 class 0x088000
[    1.483862] pci 0000:00:16.1: reg 0x10: [mem 0xfbcdc000-0xfbcdffff 64bit]
[    1.484304] pci 0000:00:16.2: [8086:3432] type 00 class 0x088000
[    1.484319] pci 0000:00:16.2: reg 0x10: [mem 0xfbce0000-0xfbce3fff 64bit]
[    1.484758] pci 0000:00:16.3: [8086:3433] type 00 class 0x088000
[    1.484774] pci 0000:00:16.3: reg 0x10: [mem 0xfbce4000-0xfbce7fff 64bit]
[    1.485216] pci 0000:00:16.4: [8086:3429] type 00 class 0x088000
[    1.485232] pci 0000:00:16.4: reg 0x10: [mem 0xfbce8000-0xfbcebfff 64bit]
[    1.485684] pci 0000:00:16.5: [8086:342a] type 00 class 0x088000
[    1.485700] pci 0000:00:16.5: reg 0x10: [mem 0xfbcec000-0xfbceffff 64bit]
[    1.486148] pci 0000:00:16.6: [8086:342b] type 00 class 0x088000
[    1.486164] pci 0000:00:16.6: reg 0x10: [mem 0xfbcf0000-0xfbcf3fff 64bit]
[    1.486610] pci 0000:00:16.7: [8086:342c] type 00 class 0x088000
[    1.486625] pci 0000:00:16.7: reg 0x10: [mem 0xfbcf4000-0xfbcf7fff 64bit]
[    1.487076] pci 0000:00:1a.0: [8086:3a37] type 00 class 0x0c0300
[    1.487118] pci 0000:00:1a.0: reg 0x20: [io  0xa400-0xa41f]
[    1.487604] pci 0000:00:1a.1: [8086:3a38] type 00 class 0x0c0300
[    1.487647] pci 0000:00:1a.1: reg 0x20: [io  0xa480-0xa49f]
[    1.488132] pci 0000:00:1a.7: [8086:3a3c] type 00 class 0x0c0320
[    1.488153] pci 0000:00:1a.7: reg 0x10: [mem 0xfbcf8000-0xfbcf83ff]
[    1.488244] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    1.488690] pci 0000:00:1c.0: [8086:3a40] type 01 class 0x060400
[    1.488781] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.489256] pci 0000:00:1c.4: [8086:3a48] type 01 class 0x060400
[    1.489349] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    1.489816] pci 0000:00:1c.5: [8086:3a4a] type 01 class 0x060400
[    1.489907] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    1.490363] pci 0000:00:1d.0: [8086:3a34] type 00 class 0x0c0300
[    1.490405] pci 0000:00:1d.0: reg 0x20: [io  0xa800-0xa81f]
[    1.490880] pci 0000:00:1d.1: [8086:3a35] type 00 class 0x0c0300
[    1.490922] pci 0000:00:1d.1: reg 0x20: [io  0xa880-0xa89f]
[    1.491407] pci 0000:00:1d.2: [8086:3a36] type 00 class 0x0c0300
[    1.491450] pci 0000:00:1d.2: reg 0x20: [io  0xac00-0xac1f]
[    1.491925] pci 0000:00:1d.3: [8086:3a39] type 00 class 0x0c0300
[    1.491967] pci 0000:00:1d.3: reg 0x20: [io  0xb000-0xb01f]
[    1.492454] pci 0000:00:1d.7: [8086:3a3a] type 00 class 0x0c0320
[    1.492475] pci 0000:00:1d.7: reg 0x10: [mem 0xfbcf9000-0xfbcf93ff]
[    1.492565] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    1.493002] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    1.493503] pci 0000:00:1f.0: [8086:3a16] type 00 class 0x060100
[    1.493595] pci 0000:00:1f.0: quirk: [io  0x0800-0x087f] claimed by ICH6 ACPI/GPIO/TCO
[    1.493604] pci 0000:00:1f.0: quirk: [io  0x0500-0x053f] claimed by ICH6 GPIO
[    1.493610] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 2 PIO at 0ca0 (mask 0003)
[    1.493617] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 4 PIO at 0294 (mask 0003)
[    1.494066] pci 0000:00:1f.2: [8086:3a22] type 00 class 0x010601
[    1.494084] pci 0000:00:1f.2: reg 0x10: [io  0xb080-0xb087]
[    1.494090] pci 0000:00:1f.2: reg 0x14: [io  0xb880-0xb883]
[    1.494097] pci 0000:00:1f.2: reg 0x18: [io  0xb800-0xb807]
[    1.494104] pci 0000:00:1f.2: reg 0x1c: [io  0xb480-0xb483]
[    1.494111] pci 0000:00:1f.2: reg 0x20: [io  0xb400-0xb41f]
[    1.494118] pci 0000:00:1f.2: reg 0x24: [mem 0xfbcfa000-0xfbcfa7ff]
[    1.494168] pci 0000:00:1f.2: PME# supported from D3hot
[    1.494605] pci 0000:00:1f.3: [8086:3a30] type 00 class 0x0c0500
[    1.494623] pci 0000:00:1f.3: reg 0x10: [mem 0xfbcfb000-0xfbcfb0ff 64bit]
[    1.494642] pci 0000:00:1f.3: reg 0x20: [io  0x0400-0x041f]
[    1.495109] pci 0000:00:01.0: PCI bridge to [bus 0b]
[    1.495201] pci 0000:00:02.0: PCI bridge to [bus 0a]
[    1.495296] pci 0000:00:03.0: PCI bridge to [bus 09]
[    1.495388] pci 0000:00:07.0: PCI bridge to [bus 08]
[    1.495476] pci 0000:00:08.0: PCI bridge to [bus 07]
[    1.495565] pci 0000:00:09.0: PCI bridge to [bus 06]
[    1.495657] pci 0000:00:0a.0: PCI bridge to [bus 05]
[    1.495748] pci 0000:00:1c.0: PCI bridge to [bus 04]
[    1.495754] pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
[    1.495757] pci 0000:00:1c.0:   bridge window [mem 0xc0000000-0xc01fffff]
[    1.495761] pci 0000:00:1c.0:   bridge window [mem 0xc0200000-0xc03fffff 64bit pref]
[    1.495873] pci 0000:03:00.0: [8086:10d3] type 00 class 0x020000
[    1.495914] pci 0000:03:00.0: reg 0x10: [mem 0xfbee0000-0xfbefffff]
[    1.495945] pci 0000:03:00.0: reg 0x18: [io  0xec00-0xec1f]
[    1.495961] pci 0000:03:00.0: reg 0x1c: [mem 0xfbedc000-0xfbedffff]
[    1.496132] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    1.496364] pci 0000:00:1c.4: PCI bridge to [bus 03]
[    1.496370] pci 0000:00:1c.4:   bridge window [io  0xe000-0xefff]
[    1.496373] pci 0000:00:1c.4:   bridge window [mem 0xfbe00000-0xfbefffff]
[    1.496378] pci 0000:00:1c.4:   bridge window [mem 0xc0400000-0xc05fffff 64bit pref]
[    1.496492] pci 0000:02:00.0: [8086:10d3] type 00 class 0x020000
[    1.496533] pci 0000:02:00.0: reg 0x10: [mem 0xfbde0000-0xfbdfffff]
[    1.496564] pci 0000:02:00.0: reg 0x18: [io  0xdc00-0xdc1f]
[    1.496580] pci 0000:02:00.0: reg 0x1c: [mem 0xfbddc000-0xfbddffff]
[    1.496749] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    1.496979] pci 0000:00:1c.5: PCI bridge to [bus 02]
[    1.496985] pci 0000:00:1c.5:   bridge window [io  0xd000-0xdfff]
[    1.496988] pci 0000:00:1c.5:   bridge window [mem 0xfbd00000-0xfbdfffff]
[    1.496993] pci 0000:00:1c.5:   bridge window [mem 0xc0600000-0xc07fffff 64bit pref]
[    1.497015] pci_bus 0000:01: extended config space not accessible
[    1.497089] pci 0000:01:01.0: [1a03:2000] type 00 class 0x030000
[    1.497105] pci 0000:01:01.0: reg 0x10: [mem 0xfb000000-0xfb7fffff]
[    1.497114] pci 0000:01:01.0: reg 0x14: [mem 0xfafe0000-0xfaffffff]
[    1.497123] pci 0000:01:01.0: reg 0x18: [io  0xcc00-0xcc7f]
[    1.497202] pci 0000:01:01.0: supports D1 D2
[    1.497203] pci 0000:01:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.497371] pci 0000:00:1e.0: PCI bridge to [bus 01] (subtractive decode)
[    1.497377] pci 0000:00:1e.0:   bridge window [io  0xc000-0xcfff]
[    1.497380] pci 0000:00:1e.0:   bridge window [mem 0xfaf00000-0xfb7fffff]
[    1.497388] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
[    1.497393] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    1.497396] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    1.497399] pci 0000:00:1e.0:   bridge window [mem 0x000d0000-0x000dffff window] (subtractive decode)
[    1.497402] pci 0000:00:1e.0:   bridge window [mem 0xc0000000-0xdfffffff window] (subtractive decode)
[    1.497406] pci 0000:00:1e.0:   bridge window [mem 0xf0000000-0xfed8ffff window] (subtractive decode)
[    1.501795] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 *10 11 12 14 15), disabled.
[    1.502156] ACPI: PCI Interrupt Link [LNKB] (IRQs *5), disabled.
[    1.502514] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 10 *11 12 14 15), disabled.
[    1.502876] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 6 7 10 11 12 *14 15), disabled.
[    1.503235] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11 12 14 15) *0, disabled.
[    1.503603] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 *7 10 11 12 14 15), disabled.
[    1.503961] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 6 7 10 11 12 14 15) *0, disabled.
[    1.504321] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 6 7 10 11 12 14 *15), disabled.
[    1.505424] SCSI subsystem initialized
[    1.505509] libata version 3.00 loaded.
[    1.505509] ACPI: bus type USB registered
[    1.505509] usbcore: registered new interface driver usbfs
[    1.505509] usbcore: registered new interface driver hub
[    1.509258] usbcore: registered new device driver usb
[    1.509258] pps_core: LinuxPPS API ver. 1 registered
[    1.509258] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.509258] PTP clock support registered
[    1.509335] EDAC MC: Ver: 3.0.0
[    1.509528] PCI: Using ACPI for IRQ routing
[    1.512566] PCI: Discovered peer bus fe
[    1.512574] PCI: root bus fe: using default resources
[    1.512578] PCI: Probing PCI hardware (bus fe)
[    1.512672] PCI host bridge to bus 0000:fe
[    1.512678] pci_bus 0000:fe: root bus resource [io  0x0000-0xffff]
[    1.512684] pci_bus 0000:fe: root bus resource [mem 0x00000000-0xffffffffff]
[    1.512688] pci_bus 0000:fe: No busn resource found for root bus, will use [bus fe-ff]
[    1.512693] pci_bus 0000:fe: busn_res: can not insert [bus fe-ff] under domain [bus 00-ff] (conflicts with (null) [bus 00-ff])
[    1.512702] pci 0000:fe:00.0: [8086:2c70] type 00 class 0x060000
[    1.512838] pci 0000:fe:00.1: [8086:2d81] type 00 class 0x060000
[    1.512967] pci 0000:fe:02.0: [8086:2d90] type 00 class 0x060000
[    1.513096] pci 0000:fe:02.1: [8086:2d91] type 00 class 0x060000
[    1.513223] pci 0000:fe:02.2: [8086:2d92] type 00 class 0x060000
[    1.513357] pci 0000:fe:02.3: [8086:2d93] type 00 class 0x060000
[    1.513480] pci 0000:fe:02.4: [8086:2d94] type 00 class 0x060000
[    1.513603] pci 0000:fe:02.5: [8086:2d95] type 00 class 0x060000
[    1.513725] pci 0000:fe:03.0: [8086:2d98] type 00 class 0x060000
[    1.513847] pci 0000:fe:03.1: [8086:2d99] type 00 class 0x060000
[    1.513967] pci 0000:fe:03.2: [8086:2d9a] type 00 class 0x060000
[    1.514091] pci 0000:fe:03.4: [8086:2d9c] type 00 class 0x060000
[    1.514213] pci 0000:fe:04.0: [8086:2da0] type 00 class 0x060000
[    1.514336] pci 0000:fe:04.1: [8086:2da1] type 00 class 0x060000
[    1.514456] pci 0000:fe:04.2: [8086:2da2] type 00 class 0x060000
[    1.514579] pci 0000:fe:04.3: [8086:2da3] type 00 class 0x060000
[    1.514701] pci 0000:fe:05.0: [8086:2da8] type 00 class 0x060000
[    1.514824] pci 0000:fe:05.1: [8086:2da9] type 00 class 0x060000
[    1.514944] pci 0000:fe:05.2: [8086:2daa] type 00 class 0x060000
[    1.515067] pci 0000:fe:05.3: [8086:2dab] type 00 class 0x060000
[    1.515190] pci 0000:fe:06.0: [8086:2db0] type 00 class 0x060000
[    1.515316] pci 0000:fe:06.1: [8086:2db1] type 00 class 0x060000
[    1.515438] pci 0000:fe:06.2: [8086:2db2] type 00 class 0x060000
[    1.515561] pci 0000:fe:06.3: [8086:2db3] type 00 class 0x060000
[    1.515693] pci_bus 0000:fe: busn_res: [bus fe-ff] end is updated to fe
[    1.515695] pci_bus 0000:fe: busn_res: can not insert [bus fe] under domain [bus 00-ff] (conflicts with (null) [bus 00-ff])
[    1.515704] PCI: Discovered peer bus ff
[    1.515709] PCI: root bus ff: using default resources
[    1.515713] PCI: Probing PCI hardware (bus ff)
[    1.515800] PCI host bridge to bus 0000:ff
[    1.515806] pci_bus 0000:ff: root bus resource [io  0x0000-0xffff]
[    1.515812] pci_bus 0000:ff: root bus resource [mem 0x00000000-0xffffffffff]
[    1.515816] pci_bus 0000:ff: No busn resource found for root bus, will use [bus ff-ff]
[    1.515820] pci_bus 0000:ff: busn_res: can not insert [bus ff] under domain [bus 00-ff] (conflicts with (null) [bus 00-ff])
[    1.515829] pci 0000:ff:00.0: [8086:2c70] type 00 class 0x060000
[    1.515951] pci 0000:ff:00.1: [8086:2d81] type 00 class 0x060000
[    1.516071] pci 0000:ff:02.0: [8086:2d90] type 00 class 0x060000
[    1.516191] pci 0000:ff:02.1: [8086:2d91] type 00 class 0x060000
[    1.516308] pci 0000:ff:02.2: [8086:2d92] type 00 class 0x060000
[    1.516427] pci 0000:ff:02.3: [8086:2d93] type 00 class 0x060000
[    1.516544] pci 0000:ff:02.4: [8086:2d94] type 00 class 0x060000
[    1.516663] pci 0000:ff:02.5: [8086:2d95] type 00 class 0x060000
[    1.516780] pci 0000:ff:03.0: [8086:2d98] type 00 class 0x060000
[    1.516900] pci 0000:ff:03.1: [8086:2d99] type 00 class 0x060000
[    1.517023] pci 0000:ff:03.2: [8086:2d9a] type 00 class 0x060000
[    1.517151] pci 0000:ff:03.4: [8086:2d9c] type 00 class 0x060000
[    1.517280] pci 0000:ff:04.0: [8086:2da0] type 00 class 0x060000
[    1.517415] pci 0000:ff:04.1: [8086:2da1] type 00 class 0x060000
[    1.517543] pci 0000:ff:04.2: [8086:2da2] type 00 class 0x060000
[    1.517674] pci 0000:ff:04.3: [8086:2da3] type 00 class 0x060000
[    1.517794] pci 0000:ff:05.0: [8086:2da8] type 00 class 0x060000
[    1.517914] pci 0000:ff:05.1: [8086:2da9] type 00 class 0x060000
[    1.518032] pci 0000:ff:05.2: [8086:2daa] type 00 class 0x060000
[    1.518156] pci 0000:ff:05.3: [8086:2dab] type 00 class 0x060000
[    1.518277] pci 0000:ff:06.0: [8086:2db0] type 00 class 0x060000
[    1.518403] pci 0000:ff:06.1: [8086:2db1] type 00 class 0x060000
[    1.518525] pci 0000:ff:06.2: [8086:2db2] type 00 class 0x060000
[    1.518649] pci 0000:ff:06.3: [8086:2db3] type 00 class 0x060000
[    1.518778] pci_bus 0000:ff: busn_res: [bus ff] end is updated to ff
[    1.518781] pci_bus 0000:ff: busn_res: can not insert [bus ff] under domain [bus 00-ff] (conflicts with (null) [bus 00-ff])
[    1.518789] PCI: pci_cache_line_size set to 64 bytes
[    1.518908] e820: reserve RAM buffer [mem 0x0009ec00-0x0009ffff]
[    1.518913] e820: reserve RAM buffer [mem 0xbf780000-0xbfffffff]
[    1.519482] NetLabel: Initializing
[    1.519486] NetLabel:  domain hash size = 128
[    1.519488] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    1.519548] NetLabel:  unlabeled traffic allowed by default
[    1.521922] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    1.521929] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
[    1.525254] clocksource: Switched to clocksource tsc-early
[    1.588793] VFS: Disk quotas dquot_6.6.0
[    1.589142] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.589729] pnp: PnP ACPI init
[    1.590002] system 00:00: [mem 0xfbf00000-0xfbffffff] has been reserved
[    1.590012] system 00:00: [mem 0xfc000000-0xfcffffff] has been reserved
[    1.590020] system 00:00: [mem 0xfd000000-0xfdffffff] has been reserved
[    1.590029] system 00:00: [mem 0xfe000000-0xfebfffff] has been reserved
[    1.590039] system 00:00: [mem 0xfec8a000-0xfec8afff] could not be reserved
[    1.590047] system 00:00: [mem 0xfed10000-0xfed10fff] has been reserved
[    1.590060] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    1.590356] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.591596] pnp 00:02: [dma 0 disabled]
[    1.591807] pnp 00:02: Plug and Play ACPI device, IDs PNP0501 (active)
[    1.592919] system 00:03: [io  0x0290-0x029f] has been reserved
[    1.592933] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.593940] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    1.593951] system 00:04: [io  0x0ca0-0x0caf] could not be reserved
[    1.593960] system 00:04: [io  0x0800-0x087f] has been reserved
[    1.593968] system 00:04: [io  0x0500-0x057f] could not be reserved
[    1.593977] system 00:04: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    1.593985] system 00:04: [mem 0xfed20000-0xfed3ffff] has been reserved
[    1.593993] system 00:04: [mem 0xfed40000-0xfed8ffff] has been reserved
[    1.594006] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.594622] system 00:05: [mem 0xffc00000-0xffdfffff] has been reserved
[    1.594637] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.595868] pnp 00:06: [dma 0 disabled]
[    1.596121] pnp 00:06: Plug and Play ACPI device, IDs PNP0501 (active)
[    1.596912] system 00:07: [mem 0xfec00000-0xfec00fff] could not be reserved
[    1.596922] system 00:07: [mem 0xfee00000-0xfee00fff] has been reserved
[    1.596935] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.597688] system 00:08: [mem 0xe0000000-0xefffffff] has been reserved
[    1.597702] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.598760] system 00:09: [mem 0x00000000-0x0009ffff] could not be reserved
[    1.598771] system 00:09: [mem 0x000c0000-0x000cffff] could not be reserved
[    1.598779] system 00:09: [mem 0x000e0000-0x000fffff] could not be reserved
[    1.598788] system 00:09: [mem 0x00100000-0xbfffffff] could not be reserved
[    1.598796] system 00:09: [mem 0xfed90000-0xffffffff] could not be reserved
[    1.598808] system 00:09: Plug and Play ACPI device, IDs PNP0c01 (active)
[    1.599591] pnp: PnP ACPI: found 10 devices
[    1.609238] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    1.609547] pci 0000:00:01.0: PCI bridge to [bus 0b]
[    1.609559] pci 0000:00:02.0: PCI bridge to [bus 0a]
[    1.609568] pci 0000:00:03.0: PCI bridge to [bus 09]
[    1.609577] pci 0000:00:07.0: PCI bridge to [bus 08]
[    1.609586] pci 0000:00:08.0: PCI bridge to [bus 07]
[    1.609595] pci 0000:00:09.0: PCI bridge to [bus 06]
[    1.609604] pci 0000:00:0a.0: PCI bridge to [bus 05]
[    1.609614] pci 0000:00:1c.0: PCI bridge to [bus 04]
[    1.609618] pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
[    1.609624] pci 0000:00:1c.0:   bridge window [mem 0xc0000000-0xc01fffff]
[    1.609630] pci 0000:00:1c.0:   bridge window [mem 0xc0200000-0xc03fffff 64bit pref]
[    1.609637] pci 0000:00:1c.4: PCI bridge to [bus 03]
[    1.609641] pci 0000:00:1c.4:   bridge window [io  0xe000-0xefff]
[    1.609647] pci 0000:00:1c.4:   bridge window [mem 0xfbe00000-0xfbefffff]
[    1.609652] pci 0000:00:1c.4:   bridge window [mem 0xc0400000-0xc05fffff 64bit pref]
[    1.609659] pci 0000:00:1c.5: PCI bridge to [bus 02]
[    1.609663] pci 0000:00:1c.5:   bridge window [io  0xd000-0xdfff]
[    1.609669] pci 0000:00:1c.5:   bridge window [mem 0xfbd00000-0xfbdfffff]
[    1.609674] pci 0000:00:1c.5:   bridge window [mem 0xc0600000-0xc07fffff 64bit pref]
[    1.609682] pci 0000:00:1e.0: PCI bridge to [bus 01]
[    1.609685] pci 0000:00:1e.0:   bridge window [io  0xc000-0xcfff]
[    1.609691] pci 0000:00:1e.0:   bridge window [mem 0xfaf00000-0xfb7fffff]
[    1.609700] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    1.609702] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    1.609704] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    1.609705] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff window]
[    1.609706] pci_bus 0000:00: resource 8 [mem 0xc0000000-0xdfffffff window]
[    1.609708] pci_bus 0000:00: resource 9 [mem 0xf0000000-0xfed8ffff window]
[    1.609710] pci_bus 0000:04: resource 0 [io  0x1000-0x1fff]
[    1.609711] pci_bus 0000:04: resource 1 [mem 0xc0000000-0xc01fffff]
[    1.609712] pci_bus 0000:04: resource 2 [mem 0xc0200000-0xc03fffff 64bit pref]
[    1.609714] pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
[    1.609715] pci_bus 0000:03: resource 1 [mem 0xfbe00000-0xfbefffff]
[    1.609716] pci_bus 0000:03: resource 2 [mem 0xc0400000-0xc05fffff 64bit pref]
[    1.609718] pci_bus 0000:02: resource 0 [io  0xd000-0xdfff]
[    1.609719] pci_bus 0000:02: resource 1 [mem 0xfbd00000-0xfbdfffff]
[    1.609720] pci_bus 0000:02: resource 2 [mem 0xc0600000-0xc07fffff 64bit pref]
[    1.609721] pci_bus 0000:01: resource 0 [io  0xc000-0xcfff]
[    1.609723] pci_bus 0000:01: resource 1 [mem 0xfaf00000-0xfb7fffff]
[    1.609724] pci_bus 0000:01: resource 4 [io  0x0000-0x0cf7 window]
[    1.609725] pci_bus 0000:01: resource 5 [io  0x0d00-0xffff window]
[    1.609727] pci_bus 0000:01: resource 6 [mem 0x000a0000-0x000bffff window]
[    1.609728] pci_bus 0000:01: resource 7 [mem 0x000d0000-0x000dffff window]
[    1.609729] pci_bus 0000:01: resource 8 [mem 0xc0000000-0xdfffffff window]
[    1.609730] pci_bus 0000:01: resource 9 [mem 0xf0000000-0xfed8ffff window]
[    1.609919] pci_bus 0000:fe: resource 4 [io  0x0000-0xffff]
[    1.609921] pci_bus 0000:fe: resource 5 [mem 0x00000000-0xffffffffff]
[    1.609925] pci_bus 0000:ff: resource 4 [io  0x0000-0xffff]
[    1.609926] pci_bus 0000:ff: resource 5 [mem 0x00000000-0xffffffffff]
[    1.610214] NET: Registered protocol family 2
[    1.611173] tcp_listen_portaddr_hash hash table entries: 32768 (order: 7, 524288 bytes)
[    1.611471] TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
[    1.612462] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.612648] TCP: Hash tables configured (established 524288 bind 65536)
[    1.613006] UDP hash table entries: 32768 (order: 8, 1048576 bytes)
[    1.613265] UDP-Lite hash table entries: 32768 (order: 8, 1048576 bytes)
[    1.614214] NET: Registered protocol family 1
[    1.614235] NET: Registered protocol family 44
[    1.626925] PCI: CLS mismatch (256 != 64), using 64 bytes
[    1.626936] pci 0000:01:01.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    1.627146] Unpacking initramfs...
[    2.477623] Freeing initrd memory: 45540K
[    2.477657] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    2.477661] software IO TLB: mapped [mem 0xbb780000-0xbf780000] (64MB)
[    2.479356] Scanning for low memory corruption every 60 seconds
[    2.482475] Initialise system trusted keyrings
[    2.482588] workingset: timestamp_bits=40 max_order=24 bucket_order=0
[    2.493004] pstore: using deflate compression
[    2.495503] Key type asymmetric registered
[    2.495507] Asymmetric key parser 'x509' registered
[    2.495539] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[    2.495668] io scheduler noop registered
[    2.495672] io scheduler deadline registered
[    2.495847] io scheduler cfq registered (default)
[    2.495850] io scheduler mq-deadline registered
[    2.495853] io scheduler kyber registered
[    2.496009] io scheduler bfq registered
[    2.499857] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    2.499895] intel_idle: MWAIT substates: 0x1120
[    2.499896] intel_idle: v0.4.1 model 0x2C
[    2.504152] intel_idle: lapic_timer_reliable_states 0xffffffff
[    2.504388] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    2.504431] ACPI: Power Button [PWRB]
[    2.504572] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    2.504606] ACPI: Power Button [PWRF]
[    2.516388] ERST: Failed to get Error Log Address Range.
[    2.516492] [Firmware Warn]: GHES: Poll interval is 0 for generic hardware error source: 1, disabled.
[    2.516884] GHES: APEI firmware first mode is enabled by WHEA _OSC.
[    2.517153] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    2.537668] 00:02: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    2.558508] 00:06: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    2.564580] Linux agpgart interface v0.103
[    2.600179] loop: module loaded
[    2.601655] ahci 0000:00:1f.2: version 3.0
[    2.602777] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    2.602821] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
[    2.602827] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pmp pio slum part ccc ems sxs
[    2.663791] scsi host0: ahci
[    2.664940] scsi host1: ahci
[    2.665911] scsi host2: ahci
[    2.666866] scsi host3: ahci
[    2.667668] scsi host4: ahci
[    2.668623] scsi host5: ahci
[    2.669051] ata1: SATA max UDMA/133 abar m2048@0xfbcfa000 port 0xfbcfa100 irq 24
[    2.669056] ata2: SATA max UDMA/133 abar m2048@0xfbcfa000 port 0xfbcfa180 irq 24
[    2.669061] ata3: SATA max UDMA/133 abar m2048@0xfbcfa000 port 0xfbcfa200 irq 24
[    2.669065] ata4: SATA max UDMA/133 abar m2048@0xfbcfa000 port 0xfbcfa280 irq 24
[    2.669069] ata5: SATA max UDMA/133 abar m2048@0xfbcfa000 port 0xfbcfa300 irq 24
[    2.669073] ata6: SATA max UDMA/133 abar m2048@0xfbcfa000 port 0xfbcfa380 irq 24
[    2.669276] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.669289] ehci-pci: EHCI PCI platform driver
[    2.670123] ehci-pci 0000:00:1a.7: EHCI Host Controller
[    2.670152] ehci-pci 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    2.670174] ehci-pci 0000:00:1a.7: debug port 1
[    2.674091] ehci-pci 0000:00:1a.7: cache line size of 64 is not supported
[    2.674127] ehci-pci 0000:00:1a.7: irq 18, io mem 0xfbcf8000
[    2.689391] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    2.689556] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
[    2.689562] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.689566] usb usb1: Product: EHCI Host Controller
[    2.689569] usb usb1: Manufacturer: Linux 4.19.15-test ehci_hcd
[    2.689572] usb usb1: SerialNumber: 0000:00:1a.7
[    2.690048] hub 1-0:1.0: USB hub found
[    2.690075] hub 1-0:1.0: 4 ports detected
[    2.691370] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    2.691390] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 2
[    2.691408] ehci-pci 0000:00:1d.7: debug port 1
[    2.695331] ehci-pci 0000:00:1d.7: cache line size of 64 is not supported
[    2.695365] ehci-pci 0000:00:1d.7: irq 23, io mem 0xfbcf9000
[    2.709370] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    2.709571] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
[    2.709577] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.709581] usb usb2: Product: EHCI Host Controller
[    2.709584] usb usb2: Manufacturer: Linux 4.19.15-test ehci_hcd
[    2.709587] usb usb2: SerialNumber: 0000:00:1d.7
[    2.710112] hub 2-0:1.0: USB hub found
[    2.710138] hub 2-0:1.0: 8 ports detected
[    2.710777] ehci-platform: EHCI generic platform driver
[    2.710799] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.710810] ohci-pci: OHCI PCI platform driver
[    2.710845] ohci-platform: OHCI generic platform driver
[    2.710866] uhci_hcd: USB Universal Host Controller Interface driver
[    2.711635] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    2.711658] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    2.711672] uhci_hcd 0000:00:1a.0: detected 2 ports
[    2.711721] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000a400
[    2.711875] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[    2.711880] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.711884] usb usb3: Product: UHCI Host Controller
[    2.711887] usb usb3: Manufacturer: Linux 4.19.15-test uhci_hcd
[    2.711890] usb usb3: SerialNumber: 0000:00:1a.0
[    2.712369] hub 3-0:1.0: USB hub found
[    2.712394] hub 3-0:1.0: 2 ports detected
[    2.713563] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    2.713582] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[    2.713595] uhci_hcd 0000:00:1a.1: detected 2 ports
[    2.713641] uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000a480
[    2.713786] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[    2.713791] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.713795] usb usb4: Product: UHCI Host Controller
[    2.713798] usb usb4: Manufacturer: Linux 4.19.15-test uhci_hcd
[    2.713801] usb usb4: SerialNumber: 0000:00:1a.1
[    2.714349] hub 4-0:1.0: USB hub found
[    2.714374] hub 4-0:1.0: 2 ports detected
[    2.715419] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    2.715440] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 5
[    2.715453] uhci_hcd 0000:00:1d.0: detected 2 ports
[    2.715479] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000a800
[    2.715628] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[    2.715633] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.715637] usb usb5: Product: UHCI Host Controller
[    2.715640] usb usb5: Manufacturer: Linux 4.19.15-test uhci_hcd
[    2.715644] usb usb5: SerialNumber: 0000:00:1d.0
[    2.716147] hub 5-0:1.0: USB hub found
[    2.716172] hub 5-0:1.0: 2 ports detected
[    2.717309] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    2.717329] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 6
[    2.717342] uhci_hcd 0000:00:1d.1: detected 2 ports
[    2.717392] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000a880
[    2.717538] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[    2.717543] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.717547] usb usb6: Product: UHCI Host Controller
[    2.717550] usb usb6: Manufacturer: Linux 4.19.15-test uhci_hcd
[    2.717553] usb usb6: SerialNumber: 0000:00:1d.1
[    2.718067] hub 6-0:1.0: USB hub found
[    2.718092] hub 6-0:1.0: 2 ports detected
[    2.719136] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    2.719159] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 7
[    2.719173] uhci_hcd 0000:00:1d.2: detected 2 ports
[    2.719198] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000ac00
[    2.719349] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[    2.719355] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.719358] usb usb7: Product: UHCI Host Controller
[    2.719362] usb usb7: Manufacturer: Linux 4.19.15-test uhci_hcd
[    2.719365] usb usb7: SerialNumber: 0000:00:1d.2
[    2.719874] hub 7-0:1.0: USB hub found
[    2.719900] hub 7-0:1.0: 2 ports detected
[    2.720948] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[    2.720970] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 8
[    2.720983] uhci_hcd 0000:00:1d.3: detected 2 ports
[    2.721007] uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000b000
[    2.721158] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.19
[    2.721164] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.721167] usb usb8: Product: UHCI Host Controller
[    2.721171] usb usb8: Manufacturer: Linux 4.19.15-test uhci_hcd
[    2.721174] usb usb8: SerialNumber: 0000:00:1d.3
[    2.721695] hub 8-0:1.0: USB hub found
[    2.721720] hub 8-0:1.0: 2 ports detected
[    2.722152] i8042: PNP: No PS/2 controller found.
[    2.722156] i8042: Probing ports directly.
[    2.724937] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.725036] serio: i8042 AUX port at 0x60,0x64 irq 12
[    2.725464] mousedev: PS/2 mouse device common for all mice
[    2.726192] rtc_cmos 00:01: RTC can wake from S4
[    2.726607] rtc_cmos 00:01: registered as rtc0
[    2.726706] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    2.727227] softdog: initialized. soft_noboot=0 soft_margin=60 sec soft_panic=0 (nowayout=0)
[    2.727457] device-mapper: uevent: version 1.0.3
[    2.727837] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel@redhat.com
[    2.727927] hidraw: raw HID events driver (C) Jiri Kosina
[    2.728007] usbcore: registered new interface driver usbhid
[    2.728010] usbhid: USB HID core driver
[    2.729238] NET: Registered protocol family 10
[    2.730665] Segment Routing with IPv6
[    2.730704] NET: Registered protocol family 17
[    2.730928] 9pnet: Installing 9P2000 support
[    2.730990] Key type dns_resolver registered
[    2.737631] microcode: sig=0x206c2, pf=0x1, revision=0x14
[    2.739351] microcode: Microcode Update Driver: v2.2.
[    2.739382] SSE version of gcm_enc/dec engaged.
[    2.741624] sched_clock: Marking stable (2741022334, 595663)->(2894195291, -152577294)
[    2.753699] registered taskstats version 1
[    2.753732] Loading compiled-in X.509 certificates
[    2.757130] Loaded X.509 cert 'Build time autogenerated kernel key: 21712f2d003fcbb2b79eca54bcc739cd6c76842b'
[    2.757183] kmemleak: Kernel memory leak detector initialized
[    2.757185] kmemleak: Automatic memory scanning thread started
[    2.761103] Key type big_key registered
[    2.763134] Key type trusted registered
[    2.765145] Key type encrypted registered
[    2.767263] APEI: Can not request [mem 0xbf7988e0-0xbf798933] for APEI BERT registers
[    2.768539] rtc_cmos 00:01: setting system clock to 2019-01-14 13:21:47 UTC (1547472107)
[    3.025361] usb 1-3: new high-speed USB device number 2 using ehci-pci
[    3.145363] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.146438] ata1.00: ATA-8: WDC WD5003ABYX-01WERA0, 01.01S01, max UDMA/133
[    3.146447] ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 32), AA
[    3.147681] ata1.00: configured for UDMA/133
[    3.149784] scsi 0:0:0:0: Direct-Access     ATA      WDC WD5003ABYX-0 1S01 PQ: 0 ANSI: 5
[    3.150309] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[    3.150326] sd 0:0:0:0: [sda] Write Protect is off
[    3.150330] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.150345] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.150557] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    3.190121]  sda: sda1 sda2
[    3.192040] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.199307] usb 1-3: New USB device found, idVendor=046b, idProduct=ff01, bcdDevice= 1.00
[    3.199317] usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.199323] usb 1-3: Product: Generic Hub
[    3.199328] usb 1-3: Manufacturer: American Megatrends Inc.
[    3.199332] usb 1-3: SerialNumber: serial
[    3.200474] hub 1-3:1.0: USB hub found
[    3.200799] hub 1-3:1.0: 3 ports detected
[    3.489342] usb 1-3.1: new low-speed USB device number 3 using ehci-pci
[    3.489379] tsc: Refined TSC clocksource calibration: 2400.085 MHz
[    3.490496] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x229887d25b0, max_idle_ns: 440795264680 ns
[    3.490630] clocksource: Switched to clocksource tsc
[    3.611970] usb 1-3.1: New USB device found, idVendor=046b, idProduct=ff10, bcdDevice= 1.00
[    3.611980] usb 1-3.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.611987] usb 1-3.1: Product: Virtual Keyboard and Mouse
[    3.611992] usb 1-3.1: Manufacturer: American Megatrends Inc.
[    3.611997] usb 1-3.1: SerialNumber: serial
[    3.615035] input: American Megatrends Inc. Virtual Keyboard and Mouse as 
/devices/pci0000:00/0000:00:1a.7/usb1/1-3/1-3.1/1-3.1:1.0/0003:046B:FF10.0001/input/input5
[    3.615360] hid-generic 0003:046B:FF10.0001: input,hidraw0: USB HID v1.10 Keyboard [American Megatrends Inc. Virtual Keyboard and Mouse] 
on usb-0000:00:1a.7-3.1/input0
[    3.617227] input: American Megatrends Inc. Virtual Keyboard and Mouse as 
/devices/pci0000:00/0000:00:1a.7/usb1/1-3/1-3.1/1-3.1:1.1/0003:046B:FF10.0002/input/input6
[    3.617927] hid-generic 0003:046B:FF10.0002: input,hidraw1: USB HID v1.10 Mouse [American Megatrends Inc. Virtual Keyboard and Mouse] on 
usb-0000:00:1a.7-3.1/input1
[    3.625364] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.626587] ata2.00: ATA-8: WDC WD5003ABYX-01WERA0, 01.01S01, max UDMA/133
[    3.626596] ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 32), AA
[    3.627925] ata2.00: configured for UDMA/133
[    3.630038] scsi 1:0:0:0: Direct-Access     ATA      WDC WD5003ABYX-0 1S01 PQ: 0 ANSI: 5
[    3.630564] sd 1:0:0:0: [sdb] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[    3.630578] sd 1:0:0:0: [sdb] Write Protect is off
[    3.630582] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    3.630597] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.630828] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    3.673781]  sdb: sdb1 sdb2 sdb3
[    3.676054] sd 1:0:0:0: [sdb] Attached SCSI disk
[    4.105338] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    4.106597] ata3.00: ATA-8: WDC WD5003ABYX-01WERA0, 01.01S01, max UDMA/133
[    4.106605] ata3.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 32), AA
[    4.108018] ata3.00: configured for UDMA/133
[    4.110074] scsi 2:0:0:0: Direct-Access     ATA      WDC WD5003ABYX-0 1S01 PQ: 0 ANSI: 5
[    4.110602] sd 2:0:0:0: [sdc] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[    4.110617] sd 2:0:0:0: [sdc] Write Protect is off
[    4.110621] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    4.110635] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.110814] sd 2:0:0:0: Attached scsi generic sg2 type 0
[    4.158584]  sdc: sdc1 sdc2 sdc3
[    4.160880] sd 2:0:0:0: [sdc] Attached SCSI disk
[    4.585336] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    4.586590] ata4.00: ATA-8: WDC WD5003ABYX-01WERA0, 01.01S01, max UDMA/133
[    4.586599] ata4.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 32), AA
[    4.588022] ata4.00: configured for UDMA/133
[    4.590075] scsi 3:0:0:0: Direct-Access     ATA      WDC WD5003ABYX-0 1S01 PQ: 0 ANSI: 5
[    4.590594] sd 3:0:0:0: [sdd] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[    4.590608] sd 3:0:0:0: [sdd] Write Protect is off
[    4.590612] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    4.590626] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.590849] sd 3:0:0:0: Attached scsi generic sg3 type 0
[    4.632974]  sdd: sdd1 sdd2 sdd3
[    4.635127] sd 3:0:0:0: [sdd] Attached SCSI disk
[    4.905051] ata5: SATA link down (SStatus 0 SControl 300)
[    5.221052] ata6: SATA link down (SStatus 0 SControl 300)
[    5.229148] Freeing unused kernel image memory: 3120K
[    5.241546] Write protecting the kernel read-only data: 18432k
[    5.247968] Freeing unused kernel image memory: 2008K
[    5.249315] Freeing unused kernel image memory: 544K
[    5.249329] Run /init as init process
[    5.269776] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    5.269931] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    5.269951] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    5.445362] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    5.445369] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    5.446215] e1000e 0000:03:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    5.509680] [drm] Using P2A bridge for configuration
[    5.509690] [drm] AST 1100 detected
[    5.509698] [drm] Analog VGA only
[    5.509714] [drm] dram MCLK=204 Mhz type=0 bus_width=16 size=00800000
[    5.510025] [TTM] Zone  kernel: Available graphics memory: 24721116 kiB
[    5.510030] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    5.510033] [TTM] Initializing pool allocator
[    5.510076] [TTM] Initializing DMA pool allocator
[    5.511391] e1000e 0000:03:00.0 0000:03:00.0 (uninitialized): registered PHC clock
[    5.515154] fbcon: astdrmfb (fb0) is primary device
[    5.572320] e1000e 0000:03:00.0 eth0: (PCI Express:2.5GT/s:Width x1) bc:ae:c5:28:22:fd
[    5.572322] e1000e 0000:03:00.0 eth0: Intel(R) PRO/1000 Network Connection
[    5.572458] e1000e 0000:03:00.0 eth0: MAC: 3, PHY: 8, PBA No: FFFFFF-0FF
[    5.572915] e1000e 0000:02:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    5.573176] Console: switching to colour frame buffer device 128x48
[    5.592883] random: fast init done
[    5.613610] md0: detected capacity change from 0 to 64390955008
[    5.623024] md/raid1:md1: active with 2 out of 2 mirrors
[    5.623106] md1: detected capacity change from 0 to 38364250112
[    5.631682] ast 0000:01:01.0: fb0: astdrmfb frame buffer device
[    5.633022] e1000e 0000:02:00.0 0000:02:00.0 (uninitialized): registered PHC clock
[    5.645407] [drm] Initialized ast 0.1.0 20120228 for 0000:01:01.0 on minor 0
[    5.692749] e1000e 0000:02:00.0 eth1: (PCI Express:2.5GT/s:Width x1) bc:ae:c5:28:23:f8
[    5.692786] e1000e 0000:02:00.0 eth1: Intel(R) PRO/1000 Network Connection
[    5.692895] e1000e 0000:02:00.0 eth1: MAC: 3, PHY: 8, PBA No: FFFFFF-0FF
[    5.989325] raid6: sse2x1   gen()  5861 MB/s
[    6.057315] raid6: sse2x1   xor()  4574 MB/s
[    6.125329] raid6: sse2x2   gen()  6910 MB/s
[    6.193320] raid6: sse2x2   xor()  5372 MB/s
[    6.261333] raid6: sse2x4   gen()  7498 MB/s
[    6.329324] raid6: sse2x4   xor()  6005 MB/s
[    6.329341] raid6: using algorithm sse2x4 gen() 7498 MB/s
[    6.329361] raid6: .... xor() 6005 MB/s, rmw enabled
[    6.330094] raid6: using ssse3x2 recovery algorithm
[    6.344940] xor: measuring software checksum speed
[    6.385316]    prefetch64-sse: 10077.000 MB/sec
[    6.425316]    generic_sse:  8850.000 MB/sec
[    6.425997] xor: using function: prefetch64-sse (10077.000 MB/sec)
[    6.438419] async_tx: api initialized (async)
[    6.756899] random: crng init done
[    6.757738] random: 7 urandom warning(s) missed due to ratelimiting
[    7.083576] EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: (null)
[   10.355614] EXT4-fs (dm-0): re-mounted. Opts: barrier=1
[   11.246338] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[   12.244091] ACPI Warning: SystemIO range 0x0000000000000828-0x000000000000082F conflicts with OpRegion 
0x0000000000000800-0x000000000000084F (\PMRG) (20180810/utaddress-213)
[   12.244131] ACPI Warning: SystemIO range 0x0000000000000828-0x000000000000082F conflicts with OpRegion 
0x0000000000000828-0x000000000000082B (\_SB.PCI0.SBRG.GPE0) (20180810/utaddress-213)
[   12.244151] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   12.244890] lpc_ich: Resource conflict(s) found affecting gpio_ich
[   12.626199] EDAC MC1: Giving out device to module i7core_edac.c controller i7 core #1: DEV 0000:fe:03.0 (INTERRUPT)
[   12.626326] EDAC PCI0: Giving out device to module i7core_edac controller EDAC PCI controller: DEV 0000:fe:03.0 (POLLED)
[   12.628046] EDAC MC0: Giving out device to module i7core_edac.c controller i7 core #0: DEV 0000:ff:03.0 (INTERRUPT)
[   12.628317] EDAC PCI1: Giving out device to module i7core_edac controller EDAC PCI controller: DEV 0000:ff:03.0 (POLLED)
[   12.628368] EDAC i7core: Driver loaded, 2 memory controller(s) found.
[   12.667768] dca service started, version 1.12.1
[   12.681581] ipmi message handler version 39.2
[   12.722702] ipmi device interface
[   12.729599] gpiochip_find_base: found new base at 451
[   12.730067] gpio gpiochip0: (gpio_ich): added GPIO chardev (254:0)
[   12.730272] gpiochip_setup_dev: registered GPIOs 451 to 511 on device: gpiochip0 (gpio_ich)
[   12.730273] gpio_ich: GPIO from 451 to 511 on gpio_ich
[   12.758585] IPMI System Interface driver.
[   12.758623] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
[   12.758625] ipmi_si: SMBIOS: io 0xca2 regsize 1 spacing 1 irq 0
[   12.758629] ipmi_si: Adding SMBIOS-specified kcs state machine
[   12.758701] ipmi_si IPI0001:00: ipmi_platform: probing via ACPI
[   12.758802] ipmi_si IPI0001:00: [io  0x0ca2-0x0ca3] regsize 1 spacing 1 irq 0
[   12.758807] ipmi_si dmi-ipmi-si.0: Removing SMBIOS-specified kcs state machine in favor of ACPI
[   12.758808] ipmi_si: Adding ACPI-specified kcs state machine
[   12.758976] ipmi_si: Trying ACPI-specified kcs state machine at i/o address 0xca2, slave address 0x20, irq 0
[   12.790833] ioatdma: Intel(R) QuickData Technology Driver 4.00
[   12.925254] i5500_temp 0000:00:14.3: Sensor seems to be disabled
[   13.104195] ipmi_si IPI0001:00: Found new BMC (man_id: 0x001043, prod_id: 0x0943, dev_id: 0x20)
[   13.149790] ipmi_si IPI0001:00: IPMI kcs interface initialized
[   13.183524] IPMI SSIF Interface driver
[   13.507575] kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL does not work properly. Using workaround
[   13.976182] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Opts: barrier=1
[   14.199828] EXT4-fs (dm-2): mounted filesystem with ordered data mode. Opts: barrier=1
[   14.687189] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[   17.263617] Process accounting resumed
[   17.794359] e1000e: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
[   17.794714] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[   22.936455] e1000e 0000:02:00.0 eth1: changing MTU from 1500 to 9000
[   23.033336] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   26.102364] e1000e: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
[   27.174495] 8021q: 802.1Q VLAN Support v1.8
[   27.174513] 8021q: adding VLAN 0 to HW filter on device eth1
[   30.671724] cgroup: cgroup: disabling cgroup2 socket matching due to net_prio or net_cls activation
[   30.898564] netpoll: netconsole: local port 6666
[   30.898566] netpoll: netconsole: local IPv6 address 2a02:6b8:0:80b:beae:c5ff:fe28:23f8
[   30.898567] netpoll: netconsole: interface 'eth1'
[   30.898568] netpoll: netconsole: remote port 6666
[   30.898568] netpoll: netconsole: remote IPv6 address 2a02:6b8:b000:605c:e61d:2dff:fe03:3790
[   30.898569] netpoll: netconsole: remote ethernet address b0:a8:6e:f4:ff:c0
[   30.917747] console [netcon0] enabled
[   30.917749] netconsole: network logging started
[   31.453353] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   34.185730] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   34.321840] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   34.465822] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   34.597423] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   34.745417] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   34.877356] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   35.005441] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   35.157376] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   35.289362] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   35.417441] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   37.790342] e1000e: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None

