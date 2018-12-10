Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681C2C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384D82086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384D82086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeLJMDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:03:45 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52518 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbeLJMDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 07:03:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E40A415AD;
        Mon, 10 Dec 2018 04:03:43 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5885E3F6A8;
        Mon, 10 Dec 2018 04:03:42 -0800 (PST)
Subject: Re: [PATCH v4] iommu/dma: Use NUMA aware memory allocations in
 __iommu_dma_alloc_pages()
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org
Cc:     will.deacon@arm.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, ganapatrao.kulkarni@cavium.com,
        hch@lst.de, m.szyprowski@samsung.com, linuxarm@huawei.com
References: <1543576440-222098-1-git-send-email-john.garry@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f973d8ea-66b4-68bd-c5e9-af0c94c85c11@arm.com>
Date:   Mon, 10 Dec 2018 12:03:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543576440-222098-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2018 11:14, John Garry wrote:
> From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> 
> Change function __iommu_dma_alloc_pages() to allocate pages for DMA from
> respective device NUMA node. The ternary operator which would be for
> alloc_pages_node() is tidied along with this.
> 
> The motivation for this change is to have a policy for page allocation
> consistent with direct DMA mapping, which attempts to allocate pages local
> to the device, as mentioned in [1].
> 
> In addition, for certain workloads it has been observed a marginal
> performance improvement. The patch caused an observation of 0.9% average
> throughput improvement for running tcrypt with HiSilicon crypto engine.
> 
> We also include a modification to use kvzalloc() for kzalloc()/vzalloc()
> combination.
> 
> [1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1692998.html

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> [JPG: Added kvzalloc(), drop pages ** being device local, remove ternary operator, update message]
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
> Difference:
> v1->v2:
> - Add Ganapatrao's tag and change author
> 
> v2->v3:
> - removed ternary operator
> - stopped making pages ** allocation local to device
> 
> v3->v4:
> - Update commit message to include motivation for patch, including
>    headline performance improvement for test.
> 
> Some notes:
> This patch was originally posted by Ganapatrao in [2].
> 
> However, after initial review, it was never reposted (due to lack of
> cycles, I think). In addition, the functionality in its sibling patches
> were merged through patches, as mentioned in [2]; this also refers to a
> discussion on device local allocations vs CPU local allocations for DMA
> pool, and which is better [1].
> 
> However, as mentioned in [1], dma_alloc_coherent() uses the locality
> information from the device - as in direct DMA - so this patch is just
> applying this same policy.
> 
> And from some testing, mentioned in commit message, shows marginal
> improvement.
> 
> [2] https://lore.kernel.org/patchwork/patch/833004/
> [3] https://lkml.org/lkml/2018/8/22/391
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index d1b0475..4afb1a8 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -449,20 +449,17 @@ static void __iommu_dma_free_pages(struct page **pages, int count)
>   	kvfree(pages);
>   }
>   
> -static struct page **__iommu_dma_alloc_pages(unsigned int count,
> -		unsigned long order_mask, gfp_t gfp)
> +static struct page **__iommu_dma_alloc_pages(struct device *dev,
> +		unsigned int count, unsigned long order_mask, gfp_t gfp)
>   {
>   	struct page **pages;
> -	unsigned int i = 0, array_size = count * sizeof(*pages);
> +	unsigned int i = 0, nid = dev_to_node(dev);
>   
>   	order_mask &= (2U << MAX_ORDER) - 1;
>   	if (!order_mask)
>   		return NULL;
>   
> -	if (array_size <= PAGE_SIZE)
> -		pages = kzalloc(array_size, GFP_KERNEL);
> -	else
> -		pages = vzalloc(array_size);
> +	pages = kvzalloc(count * sizeof(*pages), GFP_KERNEL);
>   	if (!pages)
>   		return NULL;
>   
> @@ -481,10 +478,12 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
>   		for (order_mask &= (2U << __fls(count)) - 1;
>   		     order_mask; order_mask &= ~order_size) {
>   			unsigned int order = __fls(order_mask);
> +			gfp_t alloc_flags = gfp;
>   
>   			order_size = 1U << order;
> -			page = alloc_pages((order_mask - order_size) ?
> -					   gfp | __GFP_NORETRY : gfp, order);
> +			if (order_mask > order_size)
> +				alloc_flags |= __GFP_NORETRY;
> +			page = alloc_pages_node(nid, alloc_flags, order);
>   			if (!page)
>   				continue;
>   			if (!order)
> @@ -569,7 +568,8 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>   		alloc_sizes = min_size;
>   
>   	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -	pages = __iommu_dma_alloc_pages(count, alloc_sizes >> PAGE_SHIFT, gfp);
> +	pages = __iommu_dma_alloc_pages(dev, count, alloc_sizes >> PAGE_SHIFT,
> +					gfp);
>   	if (!pages)
>   		return NULL;
>   
> 
