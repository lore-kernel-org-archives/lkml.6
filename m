Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4648FC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C225218EA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbfBAPYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:24:49 -0500
Received: from foss.arm.com ([217.140.101.70]:33326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729955AbfBAPYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:24:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 133CE80D;
        Fri,  1 Feb 2019 07:24:48 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFAC53F71E;
        Fri,  1 Feb 2019 07:24:46 -0800 (PST)
Subject: Re: [PATCH 03/19] dma-iommu: don't use a scatterlist in
 iommu_dma_alloc
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190114094159.27326-1-hch@lst.de>
 <20190114094159.27326-4-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5145b2f7-6fc8-6ed9-4cf2-9b7e1d33b0fe@arm.com>
Date:   Fri, 1 Feb 2019 15:24:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190114094159.27326-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/2019 09:41, Christoph Hellwig wrote:
> Directly iterating over the pages makes the code a bit simpler and
> prepares for the following changes.

It also defeats the whole purpose of __iommu_dma_alloc_pages(), so I'm 
not really buying the simplification angle - you've *seen* that code, 
right? ;)

If you want simple, get rid of the pages array entirely. However, as 
I've touched on previously, it's all there for a reason, because making 
the individual iommu_map() calls as large as possible gives significant 
performance/power benefits in many cases which I'm not too keen to 
regress. In fact I still have the spark of an idea to sort the filled 
pages array for optimal physical layout, I've just never had the free 
time to play with it. FWIW, since iommu_map_sg() was new and promising 
at the time, using sg_alloc_table_from_pages() actually *was* the 
simplification over copying arch/arm's __iommu_create_mapping() logic.

Robin.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/dma-iommu.c | 40 +++++++++++++++++----------------------
>   1 file changed, 17 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index d19f3d6b43c1..4f5546a103d8 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -30,6 +30,7 @@
>   #include <linux/mm.h>
>   #include <linux/pci.h>
>   #include <linux/scatterlist.h>
> +#include <linux/highmem.h>
>   #include <linux/vmalloc.h>
>   
>   struct iommu_dma_msi_page {
> @@ -549,9 +550,9 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>   	struct iova_domain *iovad = &cookie->iovad;
>   	struct page **pages;
> -	struct sg_table sgt;
>   	dma_addr_t iova;
> -	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
> +	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap, i;
> +	size_t mapped = 0;
>   
>   	*handle = DMA_MAPPING_ERROR;
>   
> @@ -576,32 +577,25 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>   	if (!iova)
>   		goto out_free_pages;
>   
> -	if (sg_alloc_table_from_pages(&sgt, pages, count, 0, size, GFP_KERNEL))
> -		goto out_free_iova;
> +	for (i = 0; i < count; i++) {
> +		phys_addr_t phys = page_to_phys(pages[i]);
>   
> -	if (!(prot & IOMMU_CACHE)) {
> -		struct sg_mapping_iter miter;
> -		/*
> -		 * The CPU-centric flushing implied by SG_MITER_TO_SG isn't
> -		 * sufficient here, so skip it by using the "wrong" direction.
> -		 */
> -		sg_miter_start(&miter, sgt.sgl, sgt.orig_nents, SG_MITER_FROM_SG);
> -		while (sg_miter_next(&miter))
> -			flush_page(dev, miter.addr, page_to_phys(miter.page));
> -		sg_miter_stop(&miter);
> -	}
> +		if (!(prot & IOMMU_CACHE)) {
> +			void *vaddr = kmap_atomic(pages[i]);
>   
> -	if (iommu_map_sg(domain, iova, sgt.sgl, sgt.orig_nents, prot)
> -			< size)
> -		goto out_free_sg;
> +			flush_page(dev, vaddr, phys);
> +			kunmap_atomic(vaddr);
> +		}
> +
> +		if (iommu_map(domain, iova + mapped, phys, PAGE_SIZE, prot))
> +			goto out_unmap;
> +		mapped += PAGE_SIZE;
> +	}
>   
>   	*handle = iova;
> -	sg_free_table(&sgt);
>   	return pages;
> -
> -out_free_sg:
> -	sg_free_table(&sgt);
> -out_free_iova:
> +out_unmap:
> +	iommu_unmap(domain, iova, mapped);
>   	iommu_dma_free_iova(cookie, iova, size);
>   out_free_pages:
>   	__iommu_dma_free_pages(pages, count);
> 
