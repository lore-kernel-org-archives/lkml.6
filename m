Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D027EC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 06:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875BB22473
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 06:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875BB22473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nocrew.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753141AbeGGGcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 02:32:48 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:33688 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752825AbeGGGcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 02:32:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 252C43F418;
        Sat,  7 Jul 2018 08:32:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8l4d-w7kMZIt; Sat,  7 Jul 2018 08:32:44 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id C30943F414;
        Sat,  7 Jul 2018 08:32:43 +0200 (CEST)
Date:   Sat, 7 Jul 2018 08:32:42 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] dma-mapping: Relax warnings for per-device areas
Message-ID: <20180707063240.GA14409@localhost.localdomain>
References: <1f8262d206c6886072d04cc93454f6e3f812bd20.1530623284.git.robin.murphy@arm.com>
 <20180705193613.GA28905@lst.de>
 <5811ebe5-b2bd-efc1-bf54-a8f05432c4f8@arm.com>
 <20180706141926.GA2313@localhost.localdomain>
 <bd63815c-260e-078f-4184-561c8e54e636@arm.com>
 <20180706205449.GB2313@localhost.localdomain>
 <trinity-b6608404-d325-4007-9480-1cb7947516b2-1530920102234@3c-app-gmx-bs19>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <trinity-b6608404-d325-4007-9480-1cb7947516b2-1530920102234@3c-app-gmx-bs19>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jürgen, Robin,

> Don't forget that the SIF DMA packets are limited and the kernel will
> block/reschedule when it is out of SIF DMA packets. The allocation is
> implemented inside the SBIOS. You may easily get a deadlock or a livelock
> when you just let it run without thinking about the design. When you use
> the old CDVD driver on IOP, the RPC code inside SBIOS tries to simulate
> the interface like the new CDVD driver. The problem is that this is done
> by a busy loop waiting for a free SIF DMA packet. This would block the
> complete Linux kernel for an unknown time.
>
> As I understand you, you wanted to move the SBIOS code inside the Linux
> kernel. I am not sure whether you already have done it. When you do this,
> it is easier to fix the CDVD problem, but you need to think about booting
> using the official RTE disc from Sony for Linux, because it loads
> different modules and a different SBIOS. As this is the official way to
> start Linux on the PS2 which is supported by Sony, we should also support
> this in the official Linux kernel. Kernelloader can partially simulate it,
> but you need the files from the RTE disc.

The kernel no longer needs or uses the SBIOS, partly due to the issues
with having binary blobs of code that do kernel services. SBIOS memory is
reclaimed, so the SBIOS does not even exist when the kernel is running.

DMA is therefore only limited by the hardware design, which supports both
multiple simultaneously interconnected DMA controllers via memory or FIFOs,
and chained (scatter-gather) transfers.

Robin, does the kernel DMA subsystem support interconnected DMA controllers?
That involves arbitration of hardware FIFO resources (for example the SIF).

The Kernelloader boot program is not needed either, for any service, because 
the IOP is reset and initialised by the kernel itself. Booting the kernel is
much faster and reliable without using the Kernelloader which frequently
crashes or refuses to load IOP modules.

The Kernelloader can still be used, if one wishes, but it's optional and not
a requirement.

> At least on some models I think you can desolder the RAM and replace it by
> a larger memory up to 4GB, because the 1394 Lead Vehicle Manual lists a
> feature:
>
> "Hardware generated response to received read or write requests in a
> designated 4GB address range without CPU involvment."
>
> The 1394 Lead Vehicle is not used in the PS2, but it is very similar to
> the IOP and it is the only manual we have about IOP. So I think the DMA
> mask for the device must be at least 32 Bits, because the device is able
> to access full 32 Bit. The EE where Linux is running may only be able to
> access a part of it directly. I think SIF DMA is always able to access it
> completely, as this is an official feature which is documented. The
> mapping at 0x1c000000-0x1c200000 seems just to be good luck, because it is
> not documented. As this is no official interface Sony is able to remove
> this mapping at any time in a new model. I don't know where the border of
> the mapping is, but in my experiements I have seen some hints that it can
> be different depending on which hardware or software is used. It looks
> like the more stuff is integrated into one single chip, the lower is the
> border, because I have seen strange behaviour and exceptions when
> accessing this memory on newer PS2 model. I limited the memory to 256KB
> for USB OHCI because of this strange behaviour on some models, but I
> wasn't able to figure out what was the real cause of the problem. I just
> recognized that it was stable with the 256KB limit.

Perhaps we need to invent a memory map zone within the IOP. I hope that we
can make full use of the DMA hardware, because DMA is by a wide margin the
most efficient kind of transfer.

> So the question is: What is the purpose of the DMA mask in Linux? Is it
> the area which can be accessed by the device? Or is it the area which can
> be accessed by the CPU? For the device it is 32 Bit. For the CPU it
> depends on the software and hardware and can be 0, because nothing may be
> shared with the CPU.

That's a good question. The DMA mapping updates that cause regressions need
some kind of mask, but I agree, it's unclear what that mask actually means.
Especially considering that the kernel cannot allocate normal memory for IOP
DMA anyway, so what is the purpose of the mask then?

> Even with DMA mask 0, the SIF DMA is still able to access the full 32 Bit.
> Each memory access by the OHCI driver can't be done directly and needs
> first to be transferred to IOP memory via SIF DMA before it can be
> accessed by OHCI DMA. This is what you called linked DMA transfer.

Right. So the IOP has DMA controllers that are also capable of simultaneously
interconnected (linked) transfers such as device<->memory<->SIF? That would
be very fortunate. A slight complication is that the SIF eventually needs
arbitration to support simultaneous transfers for multiple devices such as
the OHIC, ATA, iLink, Ethernet, etc.

Are you aware of any documentation describing the IOP DMA controllers?

> As far as I remember the USB sub-system and the OHCI driver was not
> written to handle memory which can't be written by the CPU at all. So I
> assume that you first need to allocate some temporary memory which is used
> to copy the data to or from the IOP DMA memory.

Exactly, that OHCI design is still used. Also important, we need to
investigate why OHCI interrupts sometimes are lost. Do you have any idea?

> Then I think you can increase the 256KB limit without getting an unstable
> system.

I would like to learn more about the source of this problem. I'm considering
making an IOP device driver, so that it can be examined more easily.

> I heard someone talking about problems in the SMMU which were fixed by
> increasing the DMA mask. This lets me believe that the DMA mask is
> something which is required by SMMU and therefore 32 Bit should be
> correct. But when a hardware designer tries to add an IOMMU to the PS2,
> there would be at least 3 different IOMMUs needed, because we have 3
> different buses (for EE, IOP and GS).

I'm not sure what you mean with SMMU, since this is not ARM hardware? Also,
the Graphics Synthesizer (GS) is a serial interface and not really as bus,
isn't it?

> The original approach for USB OHCI in Linux 2.4 was that IOP memory is
> handled as PCI memory. I.e. the driver was "thinking" that it allocates
> PCI memory, but indeed there was IOP memory allocated. All DMA ops where
> implemented in the PCI ops and so it was just working like a PCI card with
> device local memory.

Is PCI a good or valid model for the IOP?

Fredrik
