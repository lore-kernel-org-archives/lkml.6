Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970734AbeCSTte (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 15:49:34 -0400
Received: from verein.lst.de ([213.95.11.211]:32919 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S970355AbeCSTtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 15:49:31 -0400
Date: Mon, 19 Mar 2018 20:49:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, Muli Ben-Yehuda <mulix@mulix.org>,
        iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 12/14] dma-direct: handle the memory encryption bit in
        common code
Message-ID: <20180319194930.GA3255@lst.de>
References: <20180319103826.12853-1-hch@lst.de> <20180319103826.12853-13-hch@lst.de> <dd05dd14-9969-7985-826e-f440c3fc4c08@arm.com> <20180319152442.GA27915@lst.de> <5316b479-7e75-d62f-6b17-b6bece55187c@arm.com> <20180319154832.GD14916@arm.com> <20180319160343.GA29002@lst.de> <20180319180141.w5o6lhknhd6q7ktq@armageddon.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319180141.w5o6lhknhd6q7ktq@armageddon.cambridge.arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 06:01:41PM +0000, Catalin Marinas wrote:
> I don't particularly like maintaining an arm64-specific dma-direct.h
> either but arm64 seems to be the only architecture that needs to
> potentially force a bounce when cache_line_size() > ARCH_DMA_MINALIGN
> and the device is non-coherent.

mips is another likely candidate, see all the recent drama about
dma_get_alignmet().  And I'm also having major discussion about even
exposing the cache line size architecturally for RISC-V, so changes
are high it'll have to deal with this mess sooner or later as they
probably can't agree on a specific cache line size.

> Note that lib/swiotlb.c doesn't even
> deal with non-coherent DMA (e.g. map_sg doesn't have arch callbacks for
> cache maintenance), so not disrupting lib/swiotlb.c seems to be the
> least intrusive option.

No yet.  I have patches to consolidate the various swiotlb ops
that deal with cache flushing or barriers.  I was hoping to get them
in for this merge window, but it probably is too late now given that
I have a few other fires to fight.  But they are going to be out
early for the next merge window.

> > Nevermind that the commit should at least be three different patches:
> > 
> >  (1) revert the broken original commit
> >  (2) increase the dma min alignment
> 
> Reverting the original commit could, on its own, break an SoC which
> expects ARCH_DMA_MINALIGN == 128. So these two should be a single commit
> (my patch only reverts the L1_CACHE_BYTES change rather than
> ARCH_DMA_MINALIGN, the latter being correct as 128).

It would revert to the state before this commit.

> As I said above, adding a check in swiotlb.c for
> !is_device_dma_coherent(dev) && (ARCH_DMA_MINALIGN < cache_line_size())
> feels too architecture specific.

And what exactly is architecture specific about that?  It is a totally
generic concept, which at this point also seems entirely theoretical
based on the previous mail in this thread.
