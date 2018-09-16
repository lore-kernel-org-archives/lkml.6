Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF045ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 12:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F59208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 12:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F59208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=prnet.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbeIPSBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 14:01:18 -0400
Received: from extserverfr1.prnet.org ([188.165.208.21]:33570 "EHLO
        extserverfr1.prnet.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbeIPSBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 14:01:17 -0400
Received: from extserver.intern.prnet.org (extserver.prnet.org [192.168.11.1])
        by extserverfr1.prnet.org (8.14.9/8.14.9) with ESMTP id w8GCcHtP009814;
        Sun, 16 Sep 2018 14:38:18 +0200
Received: from [IPv6:2001:7e8:cf00:bc00:da50:e6ff:febb:ea28] ([IPv6:2001:7e8:cf00:bc00:da50:e6ff:febb:ea28])
        (authenticated bits=0)
        by extserver.intern.prnet.org (8.14.9/8.14.9) with ESMTP id w8GCcGvG030504
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
        Sun, 16 Sep 2018 14:38:17 +0200
Subject: Re: kernel 4.18.5 Realtek 8111G network adapter stops responding
 under high system load
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     linux-kernel@vger.kernel.org, nic_swsd@realtek.com,
        netdev@vger.kernel.org
References: <d05d87f5-1458-f5ce-c644-566ff78e9fc1@prnet.org>
 <4f54989b-9492-420e-374b-d8c9bddf0a7d@prnet.org>
 <6c14f6d0-ea61-b8e6-57a2-940d32330ed2@maciej.szmigiero.name>
From:   David Arendt <admin@prnet.org>
Message-ID: <236d01e8-865a-e5e8-7537-197657afb34b@prnet.org>
Date:   Sun, 16 Sep 2018 14:38:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <6c14f6d0-ea61-b8e6-57a2-940d32330ed2@maciej.szmigiero.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have applied the patch one hour ago. So far there are no problems but
because sometimes the problems only appeared after a few hours, I will
only definitively know tomorrow if the patch helped or not.

If not, I will try bisecting the problem.

For information here the differences from ethtool between the working
driver from 4.17.14 and the patched one fom 4.18.8:

--- working.txt 2018-09-16 14:14:00.544376935 +0200
+++ patched.txt 2018-09-16 14:20:09.445660915 +0200
@@ -5,2 +5,2 @@
-0x10: Dump Tally Counter Command   0xf900c000 0x00000007
-0x20: Tx Normal Priority Ring Addr 0xf3aa7000 0x00000007
+0x10: Dump Tally Counter Command   0xf9260000 0x00000007
+0x20: Tx Normal Priority Ring Addr 0xebb73000 0x00000007
@@ -17 +17 @@
-0x40: Tx Configuration                        0x4f000f80
+0x40: Tx Configuration                        0x4f000f00
@@ -31,2 +31,2 @@
-0x64: TBI control and status                  0x17ffff01
-0x68: TBI Autonegotiation advertisement (ANAR)    0xf70c
+0x64: TBI control and status                  0x00000000
+0x68: TBI Autonegotiation advertisement (ANAR)    0x0000
@@ -35 +35 @@
-0x84: PM wakeup frame 0            0x04000000 0x7c5b5c95
+0x84: PM wakeup frame 0            0x04000000 0x710b8deb
@@ -57 +57 @@
-0xE4: Rx Ring Addr                 0xf3b64000 0x00000007
+0xE4: Rx Ring Addr                 0xef9f0000 0x00000007

Thanks in advance,
David Arendt

On 9/16/18 1:54 AM, Maciej S. Szmigiero wrote:
> [ I've added Realtek Linux NIC and netdev mailing lists to CC ]
>
> Hi David,
>
> On 15.09.2018 23:23, David Arendt wrote:
>> Hi,
>>
>> just a follow up:
>>
>> In kernel 4.18.8 the behaviour is different.
>>
>> The network is not reachable a number of times, but restarting to be
>> reachable by itself before it finally is no longer reachable at all.
>>
>> Here the logging output:
>>
>> Sep 15 17:44:43 server kernel: NETDEV WATCHDOG: enp3s0 (r8169): transmit
>> queue 0 timed out
>> Sep 15 17:44:43 server kernel: r8169 0000:03:00.0 enp3s0: link up
>> Sep 15 18:10:26 server kernel: r8169 0000:03:00.0 enp3s0: link up
>> Sep 15 18:12:24 server kernel: r8169 0000:03:00.0 enp3s0: link up
>> Sep 15 18:13:19 server kernel: r8169 0000:03:00.0 enp3s0: link up
>> Sep 15 18:14:48 server kernel: r8169 0000:03:00.0 enp3s0: link up
>> Sep 15 18:20:24 server kernel: r8169 0000:03:00.0 enp3s0: link up
>> Sep 15 18:34:19 server kernel: r8169 0000:03:00.0 enp3s0: link up
>> Sep 15 18:43:43 server kernel: r8169 0000:03:00.0 enp3s0: link up
>> Sep 15 18:46:26 server kernel: r8169 0000:03:00.0 enp3s0: link up
>> Sep 15 19:00:24 server kernel: r8169 0000:03:00.0 enp3s0: link up
>>
>> From 17:44 ro 18:46 the network is recovering automatically. After the
>> up from 19:00, the network is no longer reachable without any additional
>> message.
>>
>> If looking at ifconfig, the counter for TX packets is incrementing, the
>> counter for RX packets not.
>>
>> Here again the driver from 4.17.14 is working flawlessly.
> Could you please try this patch on top of 4.18.8:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f74dd480cf4e31e12971c58a1d832044db945670
>
> In my case the problem fixed by the above commit was only limited to
> bad TX performance but my r8169 NIC models were different from what
> you have.
>
> If this does not help then try bisecting the issue
> (maybe limited to drivers/net/ethernet/realtek/r8169.c to save time).
> If the NIC dies after a heavy load it might be possible to generate
> such load quickly by in-kernel pktgen.
>
> If that's not possible then at please least compare NIC register
> values displayed by "ethtool -d enp3s0" between working and
> non-working kernels.
>
>> Thanks in advance,
>> David Arendt
> Maciej
>
>>
>> On 9/4/18 8:19 AM, David Arendt wrote:
>>> Hi,
>>>
>>> When using kernel 4.18.5 the Realtek 8111G network adapter stops
>>> responding under high system load.
>>>
>>> Dmesg is showing no errors.
>>>
>>> Sometimes an ifconfig enp3s0 down followed by an ifconfig enp3s0 up is
>>> enough for the network adapter to restart responding. Sometimes a reboot
>>> is necessary.
>>>
>>> When copying r8169.c from 4.17.14 to the 4.18.5 kernel, networking works
>>> perfectly stable on 4.18.5 so the problem seems r8169.c related.
>>>
>>> Here the output from lshw:
>>>
>>>         *-pci:2
>>>              description: PCI bridge
>>>              product: 8 Series/C220 Series Chipset Family PCI Express
>>> Root Port #3
>>>              vendor: Intel Corporation
>>>              physical id: 1c.2
>>>              bus info: pci@0000:00:1c.2
>>>              version: d5
>>>              width: 32 bits
>>>              clock: 33MHz
>>>              capabilities: pci pciexpress msi pm normal_decode
>>> bus_master cap_list
>>>              configuration: driver=pcieport
>>>              resources: irq:18 ioport:d000(size=4096)
>>> memory:f7300000-f73fffff ioport:f2100000(size=1048576)
>>>            *-network
>>>                 description: Ethernet interface
>>>                 product: RTL8111/8168/8411 PCI Express Gigabit Ethernet
>>> Controller
>>>                 vendor: Realtek Semiconductor Co., Ltd.
>>>                 physical id: 0
>>>                 bus info: pci@0000:03:00.0
>>>                 logical name: enp3s0
>>>                 version: 0c
>>>                 serial: <hidden>
>>>                 size: 1Gbit/s
>>>                 capacity: 1Gbit/s
>>>                 width: 64 bits
>>>                 clock: 33MHz
>>>                 capabilities: pm msi pciexpress msix vpd bus_master
>>> cap_list ethernet physical tp mii 10bt 10bt-fd 100bt 100bt-fd 1000bt
>>> 1000bt-fd autonegotiation
>>>                 configuration: autonegotiation=on broadcast=yes
>>> driver=r8169 driverversion=2.3LK-NAPI duplex=full
>>> firmware=rtl8168g-2_0.0.1 02/06/13 latency=0 link=yes multicast=yes
>>> port=MII speed=1Gbit/s
>>>                 resources: irq:18 ioport:d000(size=256)
>>> memory:f7300000-f7300fff memory:f2100000-f2103fff
>>>
>>> Thanks in advance for looking into this,
>>>
>>> David Arendt
>>>
>>>

