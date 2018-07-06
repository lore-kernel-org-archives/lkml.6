Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5B0C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0B622AE3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0B622AE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nocrew.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934478AbeGFUy4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:54:56 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:13541 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933856AbeGFUyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:54:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 7256F3FCBD;
        Fri,  6 Jul 2018 22:54:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9-9CjWFi2HYs; Fri,  6 Jul 2018 22:54:52 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id D00EF3FC9F;
        Fri,  6 Jul 2018 22:54:51 +0200 (CEST)
Date:   Fri, 6 Jul 2018 22:54:50 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>, JuergenUrban@gmx.de
Subject: Re: [PATCH] dma-mapping: Relax warnings for per-device areas
Message-ID: <20180706205449.GB2313@localhost.localdomain>
References: <1f8262d206c6886072d04cc93454f6e3f812bd20.1530623284.git.robin.murphy@arm.com>
 <20180705193613.GA28905@lst.de>
 <5811ebe5-b2bd-efc1-bf54-a8f05432c4f8@arm.com>
 <20180706141926.GA2313@localhost.localdomain>
 <bd63815c-260e-078f-4184-561c8e54e636@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bd63815c-260e-078f-4184-561c8e54e636@arm.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

> > Does dma_set_coherent_mask want a device object representing the IOP? Such
> > a thing is currently not implemented, but can certainly be done.
> 
> Nope, just the same OHCI device as the dma_declare_coherent_memory() call.

Ah... and then some kind of dma_ops structure is needed to avoid -EIO?
Possibly using set_dma_ops()?

By the way, the DMA hardware supports executing device->{memory,FIFO},
{memory,FIFO}->device and FIFO<->memory simultaneously, with hardware stall
control, between different devices where memory or FIFOs act as intermediate
buffers. Memory can also be a source or a destination.

That might be a way to have the OHCI efficiently transfer data from/to main
memory. I suppose it would be two simultaneously linked DMA transfers such
as

	OHCI <-> SIF <-> main memory

or even three linked DMA transfers as in

	OHCI <-> IOP memory <-> SIF <-> main memory

where SIF is the IOP DMA interface, which is a bidirectional hardware FIFO.

Does the kernel DMA subsystem support simultaneously linked DMA transfers?
In addition, the DMA hardware also supports scatter-gather (chaining), so
memory need not be physically continuous.

> > As you noted, the kernel cannot and must not allocate any kind of normal
> > memory for this device. Typical DMA addresses 0-0x200000 are mapped to
> > 0x1c000000-0x1c200000 and is memory managed exclusively by the IOP. What
> > would be a suitable mask for that?
> 
> For the sake of accuracy, I guess maybe DMA_BIT_MASK(20) since that's what
> the OHCI's effective addressing capability is, even if it does happen to be
> to remote IOP RAM.

Isn't it 21 for 2 MiB? Hmm... I'm considering raising that to 8 MiB since
there are such devices too.

> Alternatively, there is perhaps some degree of argument
> for deliberately picking a nonzero but useless value like 1, although it
> looks like the MIPS allocator (at least the dma-default one) never actually
> checks whether the page it gets is within range of the device's coherent
> mask, which it probably should do.

Perhaps Maciej knows more about the details of the MIPS allocator?

Fredrik
