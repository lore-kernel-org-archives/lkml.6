Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DD9ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 21:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67809208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 21:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67809208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=prnet.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeIPCoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 22:44:14 -0400
Received: from extserverfr1.prnet.org ([188.165.208.21]:33546 "EHLO
        extserverfr1.prnet.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbeIPCoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 22:44:13 -0400
Received: from extserver.intern.prnet.org (extserver.prnet.org [192.168.11.1])
        by extserverfr1.prnet.org (8.14.9/8.14.9) with ESMTP id w8FLNkbU028311
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 23:23:46 +0200
Received: from [IPv6:2001:7e8:cf00:bc00:da50:e6ff:febb:ea28] ([IPv6:2001:7e8:cf00:bc00:da50:e6ff:febb:ea28])
        (authenticated bits=0)
        by extserver.intern.prnet.org (8.14.9/8.14.9) with ESMTP id w8FLNjDm001159
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 23:23:46 +0200
Subject: Re: kernel 4.18.5 Realtek 8111G network adapter stops responding
 under high system load
From:   David Arendt <admin@prnet.org>
To:     linux-kernel@vger.kernel.org
References: <d05d87f5-1458-f5ce-c644-566ff78e9fc1@prnet.org>
Message-ID: <4f54989b-9492-420e-374b-d8c9bddf0a7d@prnet.org>
Date:   Sat, 15 Sep 2018 23:23:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <d05d87f5-1458-f5ce-c644-566ff78e9fc1@prnet.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just a follow up:

In kernel 4.18.8 the behaviour is different.

The network is not reachable a number of times, but restarting to be
reachable by itself before it finally is no longer reachable at all.

Here the logging output:

Sep 15 17:44:43 server kernel: NETDEV WATCHDOG: enp3s0 (r8169): transmit
queue 0 timed out
Sep 15 17:44:43 server kernel: r8169 0000:03:00.0 enp3s0: link up
Sep 15 18:10:26 server kernel: r8169 0000:03:00.0 enp3s0: link up
Sep 15 18:12:24 server kernel: r8169 0000:03:00.0 enp3s0: link up
Sep 15 18:13:19 server kernel: r8169 0000:03:00.0 enp3s0: link up
Sep 15 18:14:48 server kernel: r8169 0000:03:00.0 enp3s0: link up
Sep 15 18:20:24 server kernel: r8169 0000:03:00.0 enp3s0: link up
Sep 15 18:34:19 server kernel: r8169 0000:03:00.0 enp3s0: link up
Sep 15 18:43:43 server kernel: r8169 0000:03:00.0 enp3s0: link up
Sep 15 18:46:26 server kernel: r8169 0000:03:00.0 enp3s0: link up
Sep 15 19:00:24 server kernel: r8169 0000:03:00.0 enp3s0: link up

From 17:44 ro 18:46 the network is recovering automatically. After the
up from 19:00, the network is no longer reachable without any additional
message.

If looking at ifconfig, the counter for TX packets is incrementing, the
counter for RX packets not.

Here again the driver from 4.17.14 is working flawlessly.

Thanks in advance,
David Arendt


On 9/4/18 8:19 AM, David Arendt wrote:
> Hi,
>
> When using kernel 4.18.5 the Realtek 8111G network adapter stops
> responding under high system load.
>
> Dmesg is showing no errors.
>
> Sometimes an ifconfig enp3s0 down followed by an ifconfig enp3s0 up is
> enough for the network adapter to restart responding. Sometimes a reboot
> is necessary.
>
> When copying r8169.c from 4.17.14 to the 4.18.5 kernel, networking works
> perfectly stable on 4.18.5 so the problem seems r8169.c related.
>
> Here the output from lshw:
>
>         *-pci:2
>              description: PCI bridge
>              product: 8 Series/C220 Series Chipset Family PCI Express
> Root Port #3
>              vendor: Intel Corporation
>              physical id: 1c.2
>              bus info: pci@0000:00:1c.2
>              version: d5
>              width: 32 bits
>              clock: 33MHz
>              capabilities: pci pciexpress msi pm normal_decode
> bus_master cap_list
>              configuration: driver=pcieport
>              resources: irq:18 ioport:d000(size=4096)
> memory:f7300000-f73fffff ioport:f2100000(size=1048576)
>            *-network
>                 description: Ethernet interface
>                 product: RTL8111/8168/8411 PCI Express Gigabit Ethernet
> Controller
>                 vendor: Realtek Semiconductor Co., Ltd.
>                 physical id: 0
>                 bus info: pci@0000:03:00.0
>                 logical name: enp3s0
>                 version: 0c
>                 serial: <hidden>
>                 size: 1Gbit/s
>                 capacity: 1Gbit/s
>                 width: 64 bits
>                 clock: 33MHz
>                 capabilities: pm msi pciexpress msix vpd bus_master
> cap_list ethernet physical tp mii 10bt 10bt-fd 100bt 100bt-fd 1000bt
> 1000bt-fd autonegotiation
>                 configuration: autonegotiation=on broadcast=yes
> driver=r8169 driverversion=2.3LK-NAPI duplex=full
> firmware=rtl8168g-2_0.0.1 02/06/13 latency=0 link=yes multicast=yes
> port=MII speed=1Gbit/s
>                 resources: irq:18 ioport:d000(size=256)
> memory:f7300000-f7300fff memory:f2100000-f2103fff
>
> Thanks in advance for looking into this,
>
> David Arendt
>
>

