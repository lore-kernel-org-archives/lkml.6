Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40048C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF0420868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF0420868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbeLGR57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:57:59 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:37952 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726083AbeLGR57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:57:59 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A5720B7DA52CF;
        Sat,  8 Dec 2018 01:57:56 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Sat, 8 Dec 2018
 01:57:48 +0800
Subject: Re: [PATCH v4] iommu/dma: Use NUMA aware memory allocations in
 __iommu_dma_alloc_pages()
To:     <joro@8bytes.org>
References: <1543576440-222098-1-git-send-email-john.garry@huawei.com>
CC:     <robin.murphy@arm.com>, <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <ganapatrao.kulkarni@cavium.com>, <hch@lst.de>,
        <m.szyprowski@samsung.com>, <linuxarm@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <df449701-5ecb-26c7-cb17-b3fe03cc29e7@huawei.com>
Date:   Fri, 7 Dec 2018 17:57:42 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1543576440-222098-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2018 11:14, John Garry wrote:
> From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>

Hi Joerg,

A friendly reminder. Can you please let me know your position on this patch?

Cheers,
John

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
>
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
>   headline performance improvement for test.
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
>  	kvfree(pages);
>  }
>
> -static struct page **__iommu_dma_alloc_pages(unsigned int count,
> -		unsigned long order_mask, gfp_t gfp)
> +static struct page **__iommu_dma_alloc_pages(struct device *dev,
> +		unsigned int count, unsigned long order_mask, gfp_t gfp)
>  {
>  	struct page **pages;
> -	unsigned int i = 0, array_size = count * sizeof(*pages);
> +	unsigned int i = 0, nid = dev_to_node(dev);
>
>  	order_mask &= (2U << MAX_ORDER) - 1;
>  	if (!order_mask)
>  		return NULL;
>
> -	if (array_size <= PAGE_SIZE)
> -		pages = kzalloc(array_size, GFP_KERNEL);
> -	else
> -		pages = vzalloc(array_size);
> +	pages = kvzalloc(count * sizeof(*pages), GFP_KERNEL);
>  	if (!pages)
>  		return NULL;
>
> @@ -481,10 +478,12 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
>  		for (order_mask &= (2U << __fls(count)) - 1;
>  		     order_mask; order_mask &= ~order_size) {
>  			unsigned int order = __fls(order_mask);
> +			gfp_t alloc_flags = gfp;
>
>  			order_size = 1U << order;
> -			page = alloc_pages((order_mask - order_size) ?
> -					   gfp | __GFP_NORETRY : gfp, order);
> +			if (order_mask > order_size)
> +				alloc_flags |= __GFP_NORETRY;
> +			page = alloc_pages_node(nid, alloc_flags, order);
>  			if (!page)
>  				continue;
>  			if (!order)
> @@ -569,7 +568,8 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>  		alloc_sizes = min_size;
>
>  	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -	pages = __iommu_dma_alloc_pages(count, alloc_sizes >> PAGE_SHIFT, gfp);
> +	pages = __iommu_dma_alloc_pages(dev, count, alloc_sizes >> PAGE_SHIFT,
> +					gfp);
>  	if (!pages)
>  		return NULL;
>
>


