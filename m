Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9FCC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB43222B53
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB43222B53
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nocrew.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932688AbeGFO1v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:27:51 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:14013 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753630AbeGFO1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:27:50 -0400
X-Greylist: delayed 497 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Jul 2018 10:27:49 EDT
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id D933C3FB24;
        Fri,  6 Jul 2018 16:19:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wTahWr_WNnBS; Fri,  6 Jul 2018 16:19:30 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id D4BDC3F819;
        Fri,  6 Jul 2018 16:19:29 +0200 (CEST)
Date:   Fri, 6 Jul 2018 16:19:28 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>, JuergenUrban@gmx.de
Subject: Re: [PATCH] dma-mapping: Relax warnings for per-device areas
Message-ID: <20180706141926.GA2313@localhost.localdomain>
References: <1f8262d206c6886072d04cc93454f6e3f812bd20.1530623284.git.robin.murphy@arm.com>
 <20180705193613.GA28905@lst.de>
 <5811ebe5-b2bd-efc1-bf54-a8f05432c4f8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5811ebe5-b2bd-efc1-bf54-a8f05432c4f8@arm.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Fri, Jul 06, 2018 at 12:57:11PM +0100, Robin Murphy wrote:
> On 05/07/18 20:36, Christoph Hellwig wrote:
> > > -	BUG_ON(!ops);
> > > -	WARN_ON_ONCE(dev && !dev->coherent_dma_mask);
> > > -
> > >   	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
> > >   		return cpu_addr;
> > > +	BUG_ON(!ops);
> > > +	WARN_ON_ONCE(dev && !dev->coherent_dma_mask);
> > 
> > I think doing dma on a device without ops is completely broken no matter
> > what you think of it, so I very much disagree with that part of the change.
> > 
> > Also while I don't think not having a dma mask is a good idea even for
> > a driver purely using dma coherent pools.  If the pools really are on
> > the device itself I can see why it might not matter, but for the case
> > commonly used on some ARM SOCs where we just reserve memory for certain
> > devices from a system pool it very much does matter.
> > 
> > There really is no good excuse to not set a coherent mask in the drivers.
> 
> Right, I was rather on the fence about this - on the one hand it is
> objectively wrong per the API for drivers to call dma_alloc_coherent()
> without a prior successful dma_set_coherent_mask() call, but then I thought
> that in the case when they're *only* using it as a proxy for
> dma_alloc_from_dev_coherent() and explicitly don't want regular allocations
> from kernel memory to ever happen, then maybe it might be somewhat
> reasonable. But indeed I hadn't really given enough thought to the
> reserved-memory carveout case, where we definitely don't want to let a
> legitimate warning be hidden on a developer's machine but hit by users with
> different system configurations.
> 
> Fredrik, are you happy to fix up your driver to initialise a suitable mask
> at probe time?

The driver currently only uses dma_declare_coherent_memory and
dma_release_declared_memory. It allocates 256 KiB of DMA memory from the IOP
(a MIPS R3000 I/O processor that is separate from the main MIPS R5900) with

	iop_dma_addr = iop_alloc(size);

and then declares it with

	dma_declare_coherent_memory(dev,
		iop_bus_to_phys(iop_dma_addr),
		iop_dma_addr, size, flags);

where iop_bus_to_phys is:

#define IOP_MEMORY_BASE_ADDRESS 0x1c000000
phys_addr_t iop_bus_to_phys(iop_addr_t baddr)
{
	return (u32)baddr + IOP_MEMORY_BASE_ADDRESS;
}

Does dma_set_coherent_mask want a device object representing the IOP? Such
a thing is currently not implemented, but can certainly be done.

As you noted, the kernel cannot and must not allocate any kind of normal
memory for this device. Typical DMA addresses 0-0x200000 are mapped to
0x1c000000-0x1c200000 and is memory managed exclusively by the IOP. What
would be a suitable mask for that?

drivers/usb/host/ohci-sm501.c and drivers/usb/host/ohci-tmio.c are similar,
so I suppose they need to be fixed as well?

Fredrik
