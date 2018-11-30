Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69259C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA5620673
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA5620673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeLAGPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:15:44 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35158 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbeLAGPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:15:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF3411682;
        Fri, 30 Nov 2018 11:05:28 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16C7A3F575;
        Fri, 30 Nov 2018 11:05:25 -0800 (PST)
Subject: Re: [PATCH 4/9] dma-mapping: move the arm64 ncoherent alloc/free
 support to common code
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181105121931.13481-1-hch@lst.de>
 <20181105121931.13481-5-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5526bc61-57a3-54ff-60c6-e9963230af22@arm.com>
Date:   Fri, 30 Nov 2018 19:05:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105121931.13481-5-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2018 12:19, Christoph Hellwig wrote:
> The arm64 codebase to implement coherent dma allocation for architectures
> with non-coherent DMA is a good start for a generic implementation, given
> that is uses the generic remap helpers, provides the atomic pool for
> allocations that can't sleep and still is realtively simple and well
> tested.  Move it to kernel/dma and allow architectures to opt into it
> using a config symbol.  Architectures just need to provide a new
> arch_dma_prep_coherent helper to writeback an invalidate the caches
> for any memory that gets remapped for uncached access.

It's a bit yuck that we now end up with arch_* hooks being a mix of arch 
code and not-actually-arch-code, but I guess there's some hope of coming 
back and streamlining things in future once all the big moves are done.

I can't really be bothered to nitpick the typos above and the slight 
inconsistencies in some of the cosmetic code changes, but one worthwhile 
thing stands out...

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/arm64/Kconfig              |   2 +-
>   arch/arm64/mm/dma-mapping.c     | 184 ++------------------------------
>   include/linux/dma-mapping.h     |   5 +
>   include/linux/dma-noncoherent.h |   2 +
>   kernel/dma/Kconfig              |   6 ++
>   kernel/dma/remap.c              | 158 ++++++++++++++++++++++++++-
>   6 files changed, 181 insertions(+), 176 deletions(-)

[...]

> +void *dma_alloc_from_pool(size_t size, struct page **ret_page, gfp_t flags)
> +{
> +	unsigned long val;
> +	void *ptr = NULL;
> +
> +	if (!atomic_pool) {
> +		WARN(1, "coherent pool not initialised!\n");
> +		return NULL;
> +	}
> +
> +	val = gen_pool_alloc(atomic_pool, size);
> +	if (val) {
> +		phys_addr_t phys = gen_pool_virt_to_phys(atomic_pool, val);
> +
> +		*ret_page = phys_to_page(phys);

Looks like phys_to_page() isn't particularly portable, so we probably 
want an explicit pfn_to_page(__phys_to_pfn(phys)) here. Otherwise, the 
fundamental refactoring looks OK.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

[ In fact, looking at phys_to_page(), microblaze, riscv, unicore and 
csky (by the end of this series if it's fixed here) don't need to define 
it at all; s390 defines it for the sake of a single call in a single 
driver; it's used in two other places in arm-related drivers but at 
least one of those is clearly wrong. All in all it's quite the sorry mess. ]

> +		ptr = (void *)val;
> +		memset(ptr, 0, size);
> +	}
> +
> +	return ptr;
> +}
> +
> +bool dma_free_from_pool(void *start, size_t size)
> +{
> +	if (!dma_in_atomic_pool(start, size))
> +		return false;
> +	gen_pool_free(atomic_pool, (unsigned long)start, size);
> +	return true;
> +}
> +
> +void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
> +		gfp_t flags, unsigned long attrs)
> +{
> +	struct page *page = NULL;
> +	void *ret, *kaddr;
> +
> +	size = PAGE_ALIGN(size);
> +
> +	if (!gfpflags_allow_blocking(flags)) {
> +		ret = dma_alloc_from_pool(size, &page, flags);
> +		if (!ret)
> +			return NULL;
> +		*dma_handle = phys_to_dma(dev, page_to_phys(page));
> +		return ret;
> +	}
> +
> +	kaddr = dma_direct_alloc_pages(dev, size, dma_handle, flags, attrs);
> +	if (!kaddr)
> +		return NULL;
> +	page = virt_to_page(kaddr);
> +
> +	/* remove any dirty cache lines on the kernel alias */
> +	arch_dma_prep_coherent(page, size);
> +
> +	/* create a coherent mapping */
> +	ret = dma_common_contiguous_remap(page, size, VM_USERMAP,
> +			arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs),
> +			__builtin_return_address(0));
> +	if (!ret)
> +		dma_direct_free_pages(dev, size, kaddr, *dma_handle, attrs);
> +	return ret;
> +}
> +
> +void arch_dma_free(struct device *dev, size_t size, void *vaddr,
> +		dma_addr_t dma_handle, unsigned long attrs)
> +{
> +	if (!dma_free_from_pool(vaddr, PAGE_ALIGN(size))) {
> +		void *kaddr = phys_to_virt(dma_to_phys(dev, dma_handle));
> +
> +		vunmap(vaddr);
> +		dma_direct_free_pages(dev, size, kaddr, dma_handle, attrs);
> +	}
> +}
> +
> +long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
> +		dma_addr_t dma_addr)
> +{
> +	return __phys_to_pfn(dma_to_phys(dev, dma_addr));
> +}
> +#endif /* CONFIG_DMA_DIRECT_REMAP */
> 
