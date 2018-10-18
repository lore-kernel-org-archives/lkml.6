Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04770C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCBE204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCBE204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbeJSCMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:12:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42200 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbeJSCMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:12:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A159341;
        Thu, 18 Oct 2018 11:09:56 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38B793F5D3;
        Thu, 18 Oct 2018 11:09:55 -0700 (PDT)
Subject: Re: [PATCH 07/10] swiotlb: refactor swiotlb_map_page
To:     Christoph Hellwig <hch@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-8-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <35016142-f06d-e424-5afe-6026b6d57eda@arm.com>
Date:   Thu, 18 Oct 2018 19:09:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008080246.20543-8-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/18 09:02, Christoph Hellwig wrote:
> Remove the somewhat useless map_single function, and replace it with a
> swiotlb_bounce_page handler that handles everything related to actually
> bouncing a page.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/swiotlb.c | 77 +++++++++++++++++++++-----------------------
>   1 file changed, 36 insertions(+), 41 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 15755d7a5242..4d7a4d85d71e 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -543,26 +543,6 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>   	return tlb_addr;
>   }
>   
> -/*
> - * Allocates bounce buffer and returns its physical address.
> - */
> -static phys_addr_t
> -map_single(struct device *hwdev, phys_addr_t phys, size_t size,
> -	   enum dma_data_direction dir, unsigned long attrs)
> -{
> -	dma_addr_t start_dma_addr;
> -
> -	if (swiotlb_force == SWIOTLB_NO_FORCE) {
> -		dev_warn_ratelimited(hwdev, "Cannot do DMA to address %pa\n",
> -				     &phys);
> -		return SWIOTLB_MAP_ERROR;
> -	}
> -
> -	start_dma_addr = __phys_to_dma(hwdev, io_tlb_start);
> -	return swiotlb_tbl_map_single(hwdev, start_dma_addr, phys, size,
> -				      dir, attrs);
> -}
> -
>   /*
>    * tlb_addr is the physical address of the bounce buffer to unmap.
>    */
> @@ -714,6 +694,34 @@ static bool swiotlb_free_buffer(struct device *dev, size_t size,
>   	return true;
>   }
>   
> +static dma_addr_t swiotlb_bounce_page(struct device *dev, phys_addr_t *phys,
> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	dma_addr_t dma_addr;
> +
> +	if (unlikely(swiotlb_force == SWIOTLB_NO_FORCE)) {
> +		dev_warn_ratelimited(dev,
> +			"Cannot do DMA to address %pa\n", phys);
> +		return DIRECT_MAPPING_ERROR;
> +	}
> +
> +	/* Oh well, have to allocate and map a bounce buffer. */
> +	*phys = swiotlb_tbl_map_single(dev, __phys_to_dma(dev, io_tlb_start),
> +			*phys, size, dir, attrs);
> +	if (*phys == SWIOTLB_MAP_ERROR)
> +		return DIRECT_MAPPING_ERROR;
> +
> +	/* Ensure that the address returned is DMA'ble */
> +	dma_addr = __phys_to_dma(dev, *phys);
> +	if (unlikely(!dma_capable(dev, dma_addr, size))) {
> +		swiotlb_tbl_unmap_single(dev, *phys, size, dir,
> +			attrs | DMA_ATTR_SKIP_CPU_SYNC);
> +		return DIRECT_MAPPING_ERROR;
> +	}
> +
> +	return dma_addr;
> +}
> +
>   /*
>    * Map a single buffer of the indicated size for DMA in streaming mode.  The
>    * physical address to use is returned.
> @@ -726,8 +734,8 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
>   			    enum dma_data_direction dir,
>   			    unsigned long attrs)
>   {
> -	phys_addr_t map, phys = page_to_phys(page) + offset;
> -	dma_addr_t dev_addr = phys_to_dma(dev, phys);
> +	phys_addr_t phys = page_to_phys(page) + offset;
> +	dma_addr_t dma_addr = phys_to_dma(dev, phys);
>   
>   	BUG_ON(dir == DMA_NONE);
>   	/*
> @@ -735,26 +743,13 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
>   	 * we can safely return the device addr and not worry about bounce
>   	 * buffering it.
>   	 */
> -	if (dma_capable(dev, dev_addr, size) && swiotlb_force != SWIOTLB_FORCE)
> -		return dev_addr;
> -
> -	trace_swiotlb_bounced(dev, dev_addr, size, swiotlb_force);
> -
> -	/* Oh well, have to allocate and map a bounce buffer. */
> -	map = map_single(dev, phys, size, dir, attrs);
> -	if (map == SWIOTLB_MAP_ERROR)
> -		return DIRECT_MAPPING_ERROR;
> -
> -	dev_addr = __phys_to_dma(dev, map);
> -
> -	/* Ensure that the address returned is DMA'ble */
> -	if (dma_capable(dev, dev_addr, size))
> -		return dev_addr;
> -
> -	attrs |= DMA_ATTR_SKIP_CPU_SYNC;
> -	swiotlb_tbl_unmap_single(dev, map, size, dir, attrs);
> +	if (!dma_capable(dev, dma_addr, size) ||
> +	    swiotlb_force == SWIOTLB_FORCE) {
> +		trace_swiotlb_bounced(dev, dma_addr, size, swiotlb_force);
> +		dma_addr = swiotlb_bounce_page(dev, &phys, size, dir, attrs);
> +	}

FWIW I prefer the inverse condition and early return of the original 
code here, which also then allows a tail-call to swiotlb_bounce_page() 
(and saves a couple of lines), but it's no biggie.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   
> -	return DIRECT_MAPPING_ERROR;
> +	return dma_addr;
>   }
>   
>   /*
> 
