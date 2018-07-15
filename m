Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6D4ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 12:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FCC20870
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 12:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FCC20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nocrew.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbeGOMvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 08:51:20 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:57018 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeGOMvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 08:51:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 19B583F62D;
        Sun, 15 Jul 2018 14:28:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NhE8xLTxCYaV; Sun, 15 Jul 2018 14:28:29 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 92DCB3F3F9;
        Sun, 15 Jul 2018 14:28:28 +0200 (CEST)
Date:   Sun, 15 Jul 2018 14:28:27 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        JuergenUrban@gmx.de
Subject: Re: [PATCH] dma-mapping: Relax warnings for per-device areas
Message-ID: <20180715122826.GB2342@localhost.localdomain>
References: <1f8262d206c6886072d04cc93454f6e3f812bd20.1530623284.git.robin.murphy@arm.com>
 <20180705193613.GA28905@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180705193613.GA28905@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph, Robin,

On Thu, Jul 05, 2018 at 09:36:13PM +0200, Christoph Hellwig wrote:
> > -	BUG_ON(!ops);
> > -	WARN_ON_ONCE(dev && !dev->coherent_dma_mask);
> > -
> >  	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
> >  		return cpu_addr;
> >  
> > +	BUG_ON(!ops);
> > +	WARN_ON_ONCE(dev && !dev->coherent_dma_mask);
> 
> I think doing dma on a device without ops is completely broken no matter
> what you think of it, so I very much disagree with that part of the change.
> 
> Also while I don't think not having a dma mask is a good idea even for
> a driver purely using dma coherent pools.  If the pools really are on
> the device itself I can see why it might not matter, but for the case
> commonly used on some ARM SOCs where we just reserve memory for certain
> devices from a system pool it very much does matter.
> 
> There really is no good excuse to not set a coherent mask in the drivers.

Here are three other regressions related to the coherent mask WARN_ON_ONCE:

WARNING: CPU: 0 PID: 382 at ./include/linux/dma-mapping.h:516 .dma_pool_alloc+0xb8/0x238
Modules linked in: ehci_hcd(+) usbcore usb_common
CPU: 0 PID: 382 Comm: modprobe Not tainted 4.18.0-rc3-00022-g06ddb9e4cfce #52
NIP:  c00000000018f540 LR: c00000000018f4f4 CTR: c00000000018f488
REGS: c00000000d536f20 TRAP: 0700   Not tainted  (4.18.0-rc3-00022-g06ddb9e4cfce)
MSR:  8000000000028032 <SF,EE,IR,DR,RI>  CR: 24024242  XER: 20000000
IRQMASK: 0 
GPR00: c00000000018f4f4 c00000000d5371a0 c000000000a81e00 c00000000d52a858 
GPR04: 0000000000001000 c00000000d34c318 0000000000000001 c00000000e517290 
GPR08: 000000000dbbb000 c0000000004d5b00 0000000000000000 d00000000027f6f0 
GPR12: c00000000018f488 c000000000b0b000 c000000000636bd0 0000000000000000 
GPR16: c000000000680ab0 0000000000000100 0000000000000000 c000000000a11848 
GPR20: 00000000006000c0 c0000000004d8210 c00000000d572400 d000000000281850 
GPR24: c00000000d5372c0 c00000000d39a610 0000000000000000 00000000006000c0 
GPR28: c00000000d39a600 006000c0006000c0 c00000000d39a600 c00000000d34c300 
NIP [c00000000018f540] .dma_pool_alloc+0xb8/0x238
LR [c00000000018f4f4] .dma_pool_alloc+0x6c/0x238
Call Trace:
[c00000000d5371a0] [c00000000018f4f4] .dma_pool_alloc+0x6c/0x238 (unreliable)
[c00000000d537250] [d0000000002765ec] .ehci_qh_alloc+0x4c/0xd4 [ehci_hcd]
[c00000000d5372f0] [d00000000027b7f0] .ehci_setup+0x1f4/0x554 [ehci_hcd]
[c00000000d537380] [d00000000027bb7c] .ps3_ehci_hc_reset+0x2c/0x6c [ehci_hcd]
[c00000000d537400] [d000000000216740] .usb_add_hcd+0x31c/0x82c [usbcore]
[c00000000d5374d0] [d00000000027b1dc] .ps3_ehci_probe+0x124/0x1d8 [ehci_hcd]
[c00000000d537570] [c00000000005b350] .ps3_system_bus_probe+0x64/0x80
[c00000000d5375e0] [c00000000033fa7c] .driver_probe_device+0x298/0x384
[c00000000d537680] [c00000000033fc14] .__driver_attach+0xac/0xf4
[c00000000d537710] [c00000000033d7c8] .bus_for_each_dev+0x84/0xb0
[c00000000d5377b0] [c00000000033f394] .driver_attach+0x24/0x38
[c00000000d537820] [c00000000033edb4] .bus_add_driver+0x1e4/0x224
[c00000000d5378c0] [c000000000340580] .driver_register+0xe0/0x124
[c00000000d537940] [c00000000005ba48] .ps3_system_bus_driver_register+0x20/0x34
[c00000000d5379b0] [d00000000027ecb4] .ehci_hcd_init+0x8c/0xbc [ehci_hcd]
[c00000000d537a30] [c00000000000beb0] .do_one_initcall+0xac/0x1c0
[c00000000d537b00] [c0000000000e06ec] .do_init_module+0x6c/0x1fc
[c00000000d537ba0] [c0000000000dfd18] .load_module+0x1fbc/0x2164
[c00000000d537d20] [c0000000000e0048] .__se_sys_finit_module+0x94/0xa4
[c00000000d537e30] [c00000000000a2a4] system_call+0x5c/0x70
Instruction dump:
e89e0038 39200000 2fa30000 419e0008 e92301f8 7d2a0074 794ad182 0b0a0000 
419e0014 e9430208 2faa0000 409e0008 <0fe00000> e9290000 57a6045e 2fa90000 
---[ end trace 9066c3fd23e9bf8f ]---

WARNING: CPU: 0 PID: 382 at ./include/linux/dma-mapping.h:516 .ehci_setup+0x294/0x554 [ehci_hcd]
Modules linked in: ehci_hcd(+) usbcore usb_common
CPU: 0 PID: 382 Comm: modprobe Tainted: G        W         4.18.0-rc3-00022-g06ddb9e4cfce #52
NIP:  d00000000027b890 LR: d00000000027b844 CTR: c00000000018f058
REGS: c00000000d537070 TRAP: 0700   Tainted: G        W          (4.18.0-rc3-00022-g06ddb9e4cfce)
MSR:  8000000000028032 <SF,EE,IR,DR,RI>  CR: 28024242  XER: 00000000
IRQMASK: 0 
GPR00: d00000000027b844 c00000000d5372f0 d000000000288a00 c00000000d52a858 
GPR04: 0000000000000800 c00000000d3b8bc0 0000000000000000 c00000000d32e480 
GPR08: 0000000000000000 c0000000004d5b00 0000000000000000 d00000000027f000 
GPR12: c00000000018f058 c000000000b0b000 c000000000636bd0 0000000000000000 
GPR16: c000000000680ab0 0000000000000100 0000000000000000 c000000000a11848 
GPR20: 00000000006000c0 c0000000004d8210 c00000000d572400 d000000000281850 
GPR24: d0000000002379b0 0000000000000031 d000000000237b00 d000000000237b30 
GPR28: d000000000281b80 c00000000d3b8a70 0000000000000016 c00000000d3b8800 
NIP [d00000000027b890] .ehci_setup+0x294/0x554 [ehci_hcd]
LR [d00000000027b844] .ehci_setup+0x248/0x554 [ehci_hcd]
Call Trace:
[c00000000d5372f0] [d00000000027b844] .ehci_setup+0x248/0x554 [ehci_hcd] (unreliable)
[c00000000d537380] [d00000000027bb7c] .ps3_ehci_hc_reset+0x2c/0x6c [ehci_hcd]
[c00000000d537400] [d000000000216740] .usb_add_hcd+0x31c/0x82c [usbcore]
[c00000000d5374d0] [d00000000027b1dc] .ps3_ehci_probe+0x124/0x1d8 [ehci_hcd]
[c00000000d537570] [c00000000005b350] .ps3_system_bus_probe+0x64/0x80
[c00000000d5375e0] [c00000000033fa7c] .driver_probe_device+0x298/0x384
[c00000000d537680] [c00000000033fc14] .__driver_attach+0xac/0xf4
[c00000000d537710] [c00000000033d7c8] .bus_for_each_dev+0x84/0xb0
[c00000000d5377b0] [c00000000033f394] .driver_attach+0x24/0x38
[c00000000d537820] [c00000000033edb4] .bus_add_driver+0x1e4/0x224
[c00000000d5378c0] [c000000000340580] .driver_register+0xe0/0x124
[c00000000d537940] [c00000000005ba48] .ps3_system_bus_driver_register+0x20/0x34
[c00000000d5379b0] [d00000000027ecb4] .ehci_hcd_init+0x8c/0xbc [ehci_hcd]
[c00000000d537a30] [c00000000000beb0] .do_one_initcall+0xac/0x1c0
[c00000000d537b00] [c0000000000e06ec] .do_init_module+0x6c/0x1fc
[c00000000d537ba0] [c0000000000dfd18] .load_module+0x1fbc/0x2164
[c00000000d537d20] [c0000000000e0048] .__se_sys_finit_module+0x94/0xa4
[c00000000d537e30] [c00000000000a2a4] system_call+0x5c/0x70
Instruction dump:
39200000 2fa30000 78841764 419e0008 e92301f8 7d2a0074 794ad182 0b0a0000 
419e0014 e9430208 2faa0000 409e0008 <0fe00000> e9290000 2fa90000 409e006c 
---[ end trace 9066c3fd23e9bf90 ]---

WARNING: CPU: 1 PID: 397 at ./include/linux/dma-mapping.h:516 .ohci_init+0x224/0x498 [ohci_hcd]
Modules linked in: ohci_hcd(+) ehci_hcd usbcore usb_common
CPU: 1 PID: 397 Comm: modprobe Tainted: G        W         4.18.0-rc3-00022-g06ddb9e4cfce #52
NIP:  d0000000002a6ac0 LR: d0000000002a6a80 CTR: c0000000000c6e40
REGS: c00000000d4c70e0 TRAP: 0700   Tainted: G        W          (4.18.0-rc3-00022-g06ddb9e4cfce)
MSR:  8000000000028032 <SF,EE,IR,DR,RI>  CR: 28022222  XER: 20000000
IRQMASK: 0 
GPR00: d0000000002a6a80 c00000000d4c7360 d0000000002b3100 c00000000d52a458 
GPR04: d0000000002ab980 c00000000d8ee298 0000000000000000 0000000000000000 
GPR08: ffffffffffffffff c0000000004d5b00 0000000000000000 d0000000002a8ff8 
GPR12: c0000000000c6e40 c000000007fffc00 c000000000636bd0 0000000000000000 
GPR16: c000000000680ab0 0000000000000100 0000000000000000 c000000000a11848 
GPR20: 00000000006000c0 c0000000004d8210 c00000000d8dce80 d0000000002ac1d0 
GPR24: d0000000002379b0 0000000000000033 d000000000237b00 d000000000237b30 
GPR28: 0000000000000000 c00000000d8ee138 d0000000002ac500 c00000000d8ee270 
NIP [d0000000002a6ac0] .ohci_init+0x224/0x498 [ohci_hcd]
LR [d0000000002a6a80] .ohci_init+0x1e4/0x498 [ohci_hcd]
Call Trace:
[c00000000d4c7360] [d0000000002a6a80] .ohci_init+0x1e4/0x498 [ohci_hcd] (unreliable)
[c00000000d4c73f0] [d000000000216740] .usb_add_hcd+0x31c/0x82c [usbcore]
[c00000000d4c74c0] [d0000000002a3650] .ps3_ohci_probe+0x120/0x1dc [ohci_hcd]
[c00000000d4c7560] [c00000000005b350] .ps3_system_bus_probe+0x64/0x80
[c00000000d4c75d0] [c00000000033fa7c] .driver_probe_device+0x298/0x384
[c00000000d4c7670] [c00000000033fc14] .__driver_attach+0xac/0xf4
[c00000000d4c7700] [c00000000033d7c8] .bus_for_each_dev+0x84/0xb0
[c00000000d4c77a0] [c00000000033f394] .driver_attach+0x24/0x38
[c00000000d4c7810] [c00000000033edb4] .bus_add_driver+0x1e4/0x224
[c00000000d4c78b0] [c000000000340580] .driver_register+0xe0/0x124
[c00000000d4c7930] [c00000000005ba48] .ps3_system_bus_driver_register+0x20/0x34
[c00000000d4c79a0] [d0000000002a8c80] .ohci_hcd_mod_init+0x8c/0xfc [ohci_hcd]
[c00000000d4c7a30] [c00000000000beb0] .do_one_initcall+0xac/0x1c0
[c00000000d4c7b00] [c0000000000e06ec] .do_init_module+0x6c/0x1fc
[c00000000d4c7ba0] [c0000000000dfd18] .load_module+0x1fbc/0x2164
[c00000000d4c7d20] [c0000000000e0048] .__se_sys_finit_module+0x94/0xa4
[c00000000d4c7e30] [c00000000000a2a4] system_call+0x5c/0x70
Instruction dump:
913f0438 39200000 2fa30000 419e0008 e92301f8 7d2a0074 794ad182 0b0a0000 
419e0014 e9430208 2faa0000 409e0008 <0fe00000> e9290000 2fa90000 409e0138 
---[ end trace 9066c3fd23e9bf91 ]---

Fredrik
