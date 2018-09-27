Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A45BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02EA62159D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02EA62159D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeI0Us4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:48:56 -0400
Received: from foss.arm.com ([217.140.101.70]:35568 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbeI0Us4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:48:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28E737A9;
        Thu, 27 Sep 2018 07:30:23 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEA6E3F5BD;
        Thu, 27 Sep 2018 07:30:21 -0700 (PDT)
Subject: Re: [PATCH 3/5] dma-direct: refine dma_direct_alloc zone selection
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20180920185247.20037-1-hch@lst.de>
 <20180920185247.20037-4-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <fd524731-a0aa-b970-d320-fe209b9c68f6@arm.com>
Date:   Thu, 27 Sep 2018 15:30:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180920185247.20037-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/18 19:52, Christoph Hellwig wrote:
> We need to take the DMA offset and encryption bit into account when
> selecting a zone.  User the opportunity to factor out the zone
> selection into a helper for reuse.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/direct.c | 31 +++++++++++++++++++++----------
>   1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 81b73a5bba54..3c404e33d946 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -68,6 +68,22 @@ u64 dma_direct_get_required_mask(struct device *dev)
>   	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
>   }
>   
> +static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
> +		u64 *phys_mask)
> +{
> +	if (force_dma_unencrypted())
> +		*phys_mask = __dma_to_phys(dev, dma_mask);
> +	else
> +		*phys_mask = dma_to_phys(dev, dma_mask);

Maybe make phys_to_dma_direct() take u64 instead of phys_addr_t so we 
can reuse it here?

> +	/* GFP_DMA32 and GFP_DMA are no ops without the corresponding zones: */
> +	if (*phys_mask <= DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
> +		return GFP_DMA;

If we don't have ZONE_DMA it would in theory be a tiny bit better to 
fall back to GFP_DMA32 instead of returning 0 here, but I'm not sure 
it's worth the bother.

> +	if (*phys_mask <= DMA_BIT_MASK(32))
> +		return GFP_DMA32;
> +	return 0;
> +}
> +
>   static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
>   {
>   	return phys_to_dma_direct(dev, phys) + size - 1 <=
> @@ -80,17 +96,13 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>   	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>   	int page_order = get_order(size);
>   	struct page *page = NULL;
> +	u64 phys_mask;
>   	void *ret;
>   
>   	/* we always manually zero the memory once we are done: */
>   	gfp &= ~__GFP_ZERO;
> -
> -	/* GFP_DMA32 and GFP_DMA are no ops without the corresponding zones: */
> -	if (dev->coherent_dma_mask <= DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
> -		gfp |= GFP_DMA;
> -	if (dev->coherent_dma_mask <= DMA_BIT_MASK(32) && !(gfp & GFP_DMA))
> -		gfp |= GFP_DMA32;
> -
> +	gfp |= __dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
> +			&phys_mask);
>   again:
>   	/* CMA can be used only in the context which permits sleeping */
>   	if (gfpflags_allow_blocking(gfp)) {
> @@ -109,15 +121,14 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>   		page = NULL;
>   
>   		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
> -		    dev->coherent_dma_mask < DMA_BIT_MASK(64) &&
> +		    phys_mask < DMA_BIT_MASK(64) &&
>   		    !(gfp & (GFP_DMA32 | GFP_DMA))) {
>   			gfp |= GFP_DMA32;
>   			goto again;

Ah right, in that situation we should probably end up here anyway, so 
that's good enough - definitely not worth any more #ifdeffery above. 
Nits aside,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   		}
>   
>   		if (IS_ENABLED(CONFIG_ZONE_DMA) &&
> -		    dev->coherent_dma_mask < DMA_BIT_MASK(32) &&
> -		    !(gfp & GFP_DMA)) {
> +		    phys_mask < DMA_BIT_MASK(32) && !(gfp & GFP_DMA)) {
>   			gfp = (gfp & ~GFP_DMA32) | GFP_DMA;
>   			goto again;
>   		}
> 
