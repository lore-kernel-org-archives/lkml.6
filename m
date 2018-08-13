Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43520C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F10BB21761
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10BB21761
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbeHMQif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 12:38:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59172 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728509AbeHMQie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 12:38:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2FB880D;
        Mon, 13 Aug 2018 06:56:10 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB4FB3F5BC;
        Mon, 13 Aug 2018 06:56:08 -0700 (PDT)
Subject: Re: [PATCH v2] iommu/iova: Optimise attempts to allocate iova from
 32bit address range
To:     Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     tomasz.nowicki@cavium.com, jnair@caviumnetworks.com,
        Robert.Richter@cavium.com, Vadim.Lomovtsev@cavium.com,
        Jan.Glauber@cavium.com, gklkml16@gmail.com
References: <20180813080037.27097-1-ganapatrao.kulkarni@cavium.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <becdc45b-860d-6a9d-6c4d-df7d129bbe96@arm.com>
Date:   Mon, 13 Aug 2018 14:56:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180813080037.27097-1-ganapatrao.kulkarni@cavium.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/18 09:00, Ganapatrao Kulkarni wrote:
> As an optimisation for PCI devices, there is always first attempt
> been made to allocate iova from SAC address range. This will lead
> to unnecessary attempts, when there are no free ranges
> available. Adding fix to track recently failed iova address size and
> allow further attempts, only if requested size is lesser than a failed
> size. The size is updated when any replenish happens.
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
> 
> v2: update with comments [2] from Robin Murphy <robin.murphy@arm.com>
> 
> [2] https://lkml.org/lkml/2018/8/7/166
> 
> v1: Based on comments from Robin Murphy <robin.murphy@arm.com>
> for patch [1]
> 
> [1] https://lkml.org/lkml/2018/4/19/780
> 
> 
>   drivers/iommu/iova.c | 22 +++++++++++++++-------
>   include/linux/iova.h |  1 +
>   2 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 83fe262..543ac79 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -56,6 +56,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>   	iovad->granule = granule;
>   	iovad->start_pfn = start_pfn;
>   	iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
> +	iovad->max32_alloc_size = iovad->dma_32bit_pfn;
>   	iovad->flush_cb = NULL;
>   	iovad->fq = NULL;
>   	iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
> @@ -139,8 +140,10 @@ __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
>   
>   	cached_iova = rb_entry(iovad->cached32_node, struct iova, node);
>   	if (free->pfn_hi < iovad->dma_32bit_pfn &&
> -	    free->pfn_lo >= cached_iova->pfn_lo)
> +	    free->pfn_lo >= cached_iova->pfn_lo) {
>   		iovad->cached32_node = rb_next(&free->node);
> +		iovad->max32_alloc_size += (free->pfn_hi - free->pfn_lo);

pfn_hi is inclusive, so I don't think this is actually working as 
intended - if a full space is being freed one page at a time, this will 
never move the limit at all (because it's adding 0).

As I mentioned before, though, I'm really not convinced that it's worth 
trying to be even this clever here - we don't know that the IOVA we're 
freeing is contiguous with other free space, so the only benefit of 
doing this calculation instead of simply resetting the limit to max 
(i.e. dma_32bit_pfn) is that a subsequent allocation larger than 
(max_32_alloc_size + iova_size(free)) pages will still fail early 
instead of late. My gut feeling is that that case will be rare enough 
that it won't make a noticeable difference to realistic workloads, so we 
may as well stick with the simplest possible "almost boolean" approach 
and not bother with a calculation at all.

> +	}
>   
>   	cached_iova = rb_entry(iovad->cached_node, struct iova, node);
>   	if (free->pfn_lo >= cached_iova->pfn_lo)
> @@ -190,6 +193,10 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>   
>   	/* Walk the tree backwards */
>   	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> +	if (limit_pfn <= iovad->dma_32bit_pfn &&
> +			size >= iovad->max32_alloc_size)
> +		goto iova32_full;
> +
>   	curr = __get_cached_rbnode(iovad, limit_pfn);
>   	curr_iova = rb_entry(curr, struct iova, node);
>   	do {
> @@ -200,10 +207,8 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>   		curr_iova = rb_entry(curr, struct iova, node);
>   	} while (curr && new_pfn <= curr_iova->pfn_hi);
>   
> -	if (limit_pfn < size || new_pfn < iovad->start_pfn) {
> -		spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> -		return -ENOMEM;
> -	}
> +	if (limit_pfn < size || new_pfn < iovad->start_pfn)
> +		goto iova32_full;
>   
>   	/* pfn_lo will point to size aligned address if size_aligned is set */
>   	new->pfn_lo = new_pfn;
> @@ -214,9 +219,12 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>   	__cached_rbnode_insert_update(iovad, new);
>   
>   	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> -
> -
>   	return 0;
> +
> +iova32_full:
> +	iovad->max32_alloc_size = size;
> +	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> +	return -ENOMEM;
>   }
>   
>   static struct kmem_cache *iova_cache;
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index 928442d..66dff73 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -75,6 +75,7 @@ struct iova_domain {
>   	unsigned long	granule;	/* pfn granularity for this domain */
>   	unsigned long	start_pfn;	/* Lower limit for this domain */
>   	unsigned long	dma_32bit_pfn;
> +	unsigned long	max32_alloc_size;

This probably still warrants a brief comment to help document the exact 
meaning, maybe something like "/* Size of last failed allocation */"?

For a while I've had the feeling that it might be possible to do 
something clever with an augmented rbtree to fundamentally optimise the 
search for a free area, but for now I reckon that - modulo those last 
couple of comments - this is a good enough solution for the current problem.

Thanks,
Robin.

>   	struct iova	anchor;		/* rbtree lookup anchor */
>   	struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];	/* IOVA range caches */
>   
> 
