Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933863AbeCSPs6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 11:48:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54136 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933739AbeCSPsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:25 -0400
Date: Mon, 19 Mar 2018 15:48:33 +0000
From: Will Deacon <will.deacon@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, Muli Ben-Yehuda <mulix@mulix.org>,
        iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 12/14] dma-direct: handle the memory encryption bit in
 common code
Message-ID: <20180319154832.GD14916@arm.com>
References: <20180319103826.12853-1-hch@lst.de>
 <20180319103826.12853-13-hch@lst.de>
 <dd05dd14-9969-7985-826e-f440c3fc4c08@arm.com>
 <20180319152442.GA27915@lst.de>
 <5316b479-7e75-d62f-6b17-b6bece55187c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5316b479-7e75-d62f-6b17-b6bece55187c@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 03:37:20PM +0000, Robin Murphy wrote:
> On 19/03/18 15:24, Christoph Hellwig wrote:
> >On Mon, Mar 19, 2018 at 03:19:04PM +0000, Robin Murphy wrote:
> >>As a heads-up, I've just realised there's now a silent (but build-breaking)
> >>conflict with the current arm64 queue brewing here, as we've unfortunately
> >>had to reintroduce ARCH_HAS_PHYS_TO_DMA as a means of being safe against an
> >>ugly architectural corner case - currently commit 1f85b42a691c ("arm64:
> >>Revert L1_CACHE_SHIFT back to 6 (64-byte cache line size)") in -next.
> >
> >Please revert that arm64 commit.  This condition should be handled
> >in common code as it is not arm specific.  And next time please CC
> >the iommu list and dma-mapping maintainers before doing such a change.
> 
> There didn't seem enough justification to clutter up core SWIOTLB code with
> the ability to force bouncing on a per-device basis, but if you think there
> are real potential users out there then fair enough. For arm64, it's
> extremely unlikely that anyone will ever build a sufficiently wacky system
> to actually hit this code path; we really only implemented it for peace of
> mind per the letter of the architecture.

I'm less sure. We will certainly see systems with large writeback granules,
the real question is whether or not they will be expected to work with
non-coherent DMA. Having silent data corruption in those situations is just
about the worst possible behaviour, so I'd like to do *something* instead
of that. Falling back to swiotlb bouncing with a taint seems sensible to me.

Why can't we just resolve the conflict by adding the underscores?

Will
