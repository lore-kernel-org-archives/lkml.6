Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968552AbeCSSC6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 14:02:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56428 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030369AbeCSSBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:01:46 -0400
Date: Mon, 19 Mar 2018 18:01:41 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>,
        x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, Muli Ben-Yehuda <mulix@mulix.org>,
        iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 12/14] dma-direct: handle the memory encryption bit in
 common code
Message-ID: <20180319180141.w5o6lhknhd6q7ktq@armageddon.cambridge.arm.com>
References: <20180319103826.12853-1-hch@lst.de>
 <20180319103826.12853-13-hch@lst.de>
 <dd05dd14-9969-7985-826e-f440c3fc4c08@arm.com>
 <20180319152442.GA27915@lst.de>
 <5316b479-7e75-d62f-6b17-b6bece55187c@arm.com>
 <20180319154832.GD14916@arm.com>
 <20180319160343.GA29002@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319160343.GA29002@lst.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 05:03:43PM +0100, Christoph Hellwig wrote:
> On Mon, Mar 19, 2018 at 03:48:33PM +0000, Will Deacon wrote:
> > Why can't we just resolve the conflict by adding the underscores?
> 
> We can solve the conflict easily that way.  But that's not the point.
> 
> The point is that I've been fighting hard to consolidate dma code
> given that the behavior really is common and not arch specific.  And
> this one is another case like that:  the fact that the non-coherent
> dma boundary is bigger than the exposed size is something that can
> easily happen elsewhere, so there is no need to duplicate a lot
> of code for that.

I don't particularly like maintaining an arm64-specific dma-direct.h
either but arm64 seems to be the only architecture that needs to
potentially force a bounce when cache_line_size() > ARCH_DMA_MINALIGN
and the device is non-coherent. Note that lib/swiotlb.c doesn't even
deal with non-coherent DMA (e.g. map_sg doesn't have arch callbacks for
cache maintenance), so not disrupting lib/swiotlb.c seems to be the
least intrusive option.

> Nevermind that the commit should at least be three different patches:
> 
>  (1) revert the broken original commit
>  (2) increase the dma min alignment

Reverting the original commit could, on its own, break an SoC which
expects ARCH_DMA_MINALIGN == 128. So these two should be a single commit
(my patch only reverts the L1_CACHE_BYTES change rather than
ARCH_DMA_MINALIGN, the latter being correct as 128).

Anyway, it's queued already and we try not to rebase the branches we
published. Fix-ups on top are fine though.

>  (3) put the swiotlb workaround in place

As I said above, adding a check in swiotlb.c for
!is_device_dma_coherent(dev) && (ARCH_DMA_MINALIGN < cache_line_size())
feels too architecture specific. Adding yet another hook like
arch_dma_capable() doesn't feel right either since we already have the
possibility to override dma_capable() by selecting ARCH_HAS_PHYS_TO_DMA.

The "cleanest" I came up with for swiotlb.c was a new
DMA_ATTR_FORCE_BOUNCE attribute. However, it required more changes to
the arm64 dma-mapping.c than simply implementing an arch-specific
dma_capable().

-- 
Catalin
