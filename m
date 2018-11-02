Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E2DC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86D92081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86D92081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbeKCCB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 22:01:56 -0400
Received: from foss.arm.com ([217.140.101.70]:43962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbeKCCB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 22:01:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B52D0A78;
        Fri,  2 Nov 2018 09:54:09 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E47843F718;
        Fri,  2 Nov 2018 09:54:08 -0700 (PDT)
Subject: Re: [PATCH] iommu/dma: Zero pages manually in a length of scatterlist
To:     Nicolin Chen <nicoleotsuka@gmail.com>, joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20181101213500.21800-1-nicoleotsuka@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <63184c22-4587-be2b-8089-d2e4e0b5482d@arm.com>
Date:   Fri, 2 Nov 2018 16:54:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181101213500.21800-1-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2018 21:35, Nicolin Chen wrote:
> The __GFP_ZERO will be passed down to the generic page allocation
> routine which zeros everything page by page. This is safe to be a
> generic way but not efficient for iommu allocation that organizes
> contiguous pages using scatterlist.
> 
> So this changes drops __GFP_ZERO from the flag, and adds a manual
> memset after page/sg allocations, using the length of scatterlist.
> 
> My test result of a 2.5MB size allocation shows iommu_dma_alloc()
> takes 46% less time, reduced from averagely 925 usec to 500 usec.

Assuming this is for arm64, I'm somewhat surprised that memset() could 
be that much faster than clear_page(), since they should effectively 
amount to the same thing (a DC ZVA loop). What hardware is this on? 
Profiling to try and see exactly where the extra time goes would be 
interesting too.

> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>   drivers/iommu/dma-iommu.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index d1b04753b204..e48d995e65c5 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -551,10 +551,13 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>   	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>   	struct iova_domain *iovad = &cookie->iovad;
> +	struct scatterlist *s;
>   	struct page **pages;
>   	struct sg_table sgt;
>   	dma_addr_t iova;
>   	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
> +	bool gfp_zero = false;
> +	int i;
>   
>   	*handle = IOMMU_MAPPING_ERROR;
>   
> @@ -568,6 +571,15 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>   	if (attrs & DMA_ATTR_ALLOC_SINGLE_PAGES)
>   		alloc_sizes = min_size;
>   
> +	/*
> +	 * The generic zeroing in a length of one page size is slow,
> +	 * so do it manually in a length of scatterlist size instead
> +	 */
> +	if (gfp & __GFP_ZERO) {
> +		gfp &= ~__GFP_ZERO;
> +		gfp_zero = true;
> +	}

Or just mask it out in __iommu_dma_alloc_pages()?

> +
>   	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>   	pages = __iommu_dma_alloc_pages(count, alloc_sizes >> PAGE_SHIFT, gfp);
>   	if (!pages)
> @@ -581,6 +593,12 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>   	if (sg_alloc_table_from_pages(&sgt, pages, count, 0, size, GFP_KERNEL))
>   		goto out_free_iova;
>   
> +	if (gfp_zero) {
> +		/* Now zero all the pages in the scatterlist */
> +		for_each_sg(sgt.sgl, s, sgt.orig_nents, i)
> +			memset(sg_virt(s), 0, s->length);

What if the pages came from highmem? I know that doesn't happen on arm64 
today, but the point of this code *is* to be generic, and other users 
will arrive eventually.

Robin.

> +	}
> +
>   	if (!(prot & IOMMU_CACHE)) {
>   		struct sg_mapping_iter miter;
>   		/*
> 
