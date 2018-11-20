Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A43C18E01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D2720851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D2720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbeKUAuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:50:22 -0500
Received: from foss.arm.com ([217.140.101.70]:49738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbeKUAuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:50:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F329EBD;
        Tue, 20 Nov 2018 06:20:59 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 137263F5A0;
        Tue, 20 Nov 2018 06:20:57 -0800 (PST)
Subject: Re: [PATCH v2] iommu/dma: Use NUMA aware memory allocations in
 __iommu_dma_alloc_pages()
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org
Cc:     will.deacon@arm.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, ganapatrao.kulkarni@cavium.com,
        hch@lst.de, m.szyprowski@samsung.com
References: <1542721320-233109-1-git-send-email-john.garry@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f9a91b43-ae77-ced5-3afc-57366e5126cb@arm.com>
Date:   Tue, 20 Nov 2018 14:20:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542721320-233109-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2018 13:42, John Garry wrote:
> From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> 
> Change function __iommu_dma_alloc_pages() to allocate memory/pages
> for DMA from respective device NUMA node.
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> [JPG:  Modifed to use kvzalloc() and fixed indentation]
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
> Difference v1->v2:
> - Add Ganapatrao's tag and change author
> 
> This patch was originally posted by Ganapatrao in [1].
> 
> However, after initial review, it was never reposted (due to lack of
> cycles, I think). In addition, the functionality in its sibling patches
> were merged through patches, as mentioned in [2]; this also refers to a
> discussion on device local allocations vs CPU local allocations for DMA
> pool, and which is better [3].
> 
> However, as mentioned in [3], dma_alloc_coherent() uses the locality
> information from the device - as in direct DMA - so this patch is just
> applying this same policy.
> 
> [1] https://lore.kernel.org/patchwork/patch/833004/
> [2] https://lkml.org/lkml/2018/8/22/391
> [3] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1692998.html
> 
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index d1b0475..ada00bc 100644
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
> +	pages = kvzalloc_node(count * sizeof(*pages), GFP_KERNEL, nid);

The pages array is only accessed by the CPU servicing the 
iommu_dma_alloc() call, and is usually freed again before that call even 
returns. It's certainly never touched by the device, so forcing it to a 
potentially non-local node doesn't make a great deal of sense.

>   	if (!pages)
>   		return NULL;
>   
> @@ -483,8 +480,10 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
>   			unsigned int order = __fls(order_mask);
>   
>   			order_size = 1U << order;
> -			page = alloc_pages((order_mask - order_size) ?
> -					   gfp | __GFP_NORETRY : gfp, order);
> +			page = alloc_pages_node(nid,
> +						(order_mask - order_size) ?
> +						gfp | __GFP_NORETRY : gfp,
> +						order);

If we're touching this, can we sort out that horrendous ternary? FWIW I 
found I have a local version of the original patch which I tweaked at 
the time, and apparently I reworked this hunk as below, which does seem 
somewhat nicer for the same diffstat.

Robin.


@@ -446,10 +443,12 @@ static struct page 
**__iommu_dma_alloc_pages(unsigned int count,
                 for (order_mask &= (2U << __fls(count)) - 1;
                      order_mask; order_mask &= ~order_size) {
                         unsigned int order = __fls(order_mask);
+                       gfp_t alloc_flags = gfp;

                         order_size = 1U << order;
-                       page = alloc_pages((order_mask - order_size) ?
-                                          gfp | __GFP_NORETRY : gfp, 
order);
+                       if (order_size < order_mask)
+                               alloc_flags |= __GFP_NORETRY;
+                       page = alloc_pages_node(nid, alloc_flags, order);
                         if (!page)
                                 continue;
                         if (!order)
