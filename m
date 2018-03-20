Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751817AbeCTQXh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:23:37 -0400
Received: from foss.arm.com ([217.140.101.70]:42598 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751712AbeCTQXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:23:32 -0400
Date: Tue, 20 Mar 2018 16:23:27 +0000
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
Message-ID: <20180320162327.4cixyuhqc62bfh3n@armageddon.cambridge.arm.com>
References: <20180319103826.12853-1-hch@lst.de>
 <20180319103826.12853-13-hch@lst.de>
 <dd05dd14-9969-7985-826e-f440c3fc4c08@arm.com>
 <20180319152442.GA27915@lst.de>
 <5316b479-7e75-d62f-6b17-b6bece55187c@arm.com>
 <20180319154832.GD14916@arm.com>
 <20180319160343.GA29002@lst.de>
 <20180319180141.w5o6lhknhd6q7ktq@armageddon.cambridge.arm.com>
 <20180319194930.GA3255@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319194930.GA3255@lst.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 08:49:30PM +0100, Christoph Hellwig wrote:
> On Mon, Mar 19, 2018 at 06:01:41PM +0000, Catalin Marinas wrote:
> > I don't particularly like maintaining an arm64-specific dma-direct.h
> > either but arm64 seems to be the only architecture that needs to
> > potentially force a bounce when cache_line_size() > ARCH_DMA_MINALIGN
> > and the device is non-coherent.
> 
> mips is another likely candidate, see all the recent drama about
> dma_get_alignmet().  And I'm also having major discussion about even
> exposing the cache line size architecturally for RISC-V, so changes
> are high it'll have to deal with this mess sooner or later as they
> probably can't agree on a specific cache line size.

On Arm, the cache line size varies between 32 and 128 on publicly
available hardware (and I wouldn't exclude higher numbers at some
point). In addition, the cache line size has a different meaning in the
DMA context, we call it "cache writeback granule" on Arm which is
greater than or equal the minimum cache line size.

So the aim is to have L1_CACHE_BYTES small enough for acceptable
performance numbers and ARCH_DMA_MINALIGN the maximum from a correctness
perspective (the latter is defined by some larger cache lines in L2/L3).

To make things worse, there is no clear definition in the generic kernel
on what cache_line_size() means and the default definition returns
L1_CACHE_BYTES. On arm64, we define it to the hardware's cache
writeback granule (CWG), if available, with a fallback on
ARCH_DMA_MINALIGN. The network layer, OTOH, seems to assume that
SMP_CACHE_BYTES is sufficient for DMA alignment (L1_CACHE_BYTES in
arm64's case).

> > As I said above, adding a check in swiotlb.c for
> > !is_device_dma_coherent(dev) && (ARCH_DMA_MINALIGN < cache_line_size())
> > feels too architecture specific.
> 
> And what exactly is architecture specific about that?  It is a totally
> generic concept, which at this point also seems entirely theoretical
> based on the previous mail in this thread.

The concept may be generic but the kernel macros/functions used here
aren't. is_device_dma_coherent() is only defined on arm and arm64. The
relation between ARCH_DMA_MINALIGN, L1_CACHE_BYTES and cache_line_size()
seems to be pretty ad-hoc. ARCH_DMA_MINALIGN is also only defined for
some architectures and, while there is dma_get_cache_alignment() which
returns this constant, it doesn't seem to be used much.

I'm all for fixing this in a generic way but I think we first need
swiotlb.c to become aware of non-cache-coherent DMA devices.

-- 
Catalin
