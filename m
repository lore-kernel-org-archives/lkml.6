Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C863C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1CA820658
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CA820658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbeJLBey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 21:34:54 -0400
Received: from foss.arm.com ([217.140.101.70]:41948 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbeJLBex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 21:34:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A9E5ED1;
        Thu, 11 Oct 2018 11:06:34 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E99033F5D3;
        Thu, 11 Oct 2018 11:06:32 -0700 (PDT)
Subject: Re: [PATCH 03/10] swiotlb: do not panic on mapping failures
To:     Christoph Hellwig <hch@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-4-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ff847d0d-a2a1-65ba-ed18-aa71f632194d@arm.com>
Date:   Thu, 11 Oct 2018 19:06:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008080246.20543-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/18 09:02, Christoph Hellwig wrote:
> All properly written drivers now have error handling in the
> dma_map_single / dma_map_page callers.  As swiotlb_tbl_map_single already
> prints a useful warning when running out of swiotlb pool swace we can
> also remove swiotlb_full entirely as it serves no purpose now.

$ git grep -l 'dma_map_\(page\|single\)' drivers/ | wc -l
385
$ git grep -l dma_mapping_error drivers/ | wc -l
396

Close enough, to first approximation :D

I agree the other (non-fatal) warning seems sufficient, and frankly the 
panic can be a bit of a pain for development sometimes.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/swiotlb.c | 33 +--------------------------------
>   1 file changed, 1 insertion(+), 32 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 26d3af52956f..69bf305ee5f8 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -761,34 +761,6 @@ static bool swiotlb_free_buffer(struct device *dev, size_t size,
>   	return true;
>   }
>   
> -static void
> -swiotlb_full(struct device *dev, size_t size, enum dma_data_direction dir,
> -	     int do_panic)
> -{
> -	if (swiotlb_force == SWIOTLB_NO_FORCE)
> -		return;
> -
> -	/*
> -	 * Ran out of IOMMU space for this operation. This is very bad.
> -	 * Unfortunately the drivers cannot handle this operation properly.
> -	 * unless they check for dma_mapping_error (most don't)
> -	 * When the mapping is small enough return a static buffer to limit
> -	 * the damage, or panic when the transfer is too big.
> -	 */
> -	dev_err_ratelimited(dev, "DMA: Out of SW-IOMMU space for %zu bytes\n",
> -			    size);
> -
> -	if (size <= io_tlb_overflow || !do_panic)
> -		return;
> -
> -	if (dir == DMA_BIDIRECTIONAL)
> -		panic("DMA: Random memory could be DMA accessed\n");
> -	if (dir == DMA_FROM_DEVICE)
> -		panic("DMA: Random memory could be DMA written\n");
> -	if (dir == DMA_TO_DEVICE)
> -		panic("DMA: Random memory could be DMA read\n");
> -}
> -
>   /*
>    * Map a single buffer of the indicated size for DMA in streaming mode.  The
>    * physical address to use is returned.
> @@ -817,10 +789,8 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
>   
>   	/* Oh well, have to allocate and map a bounce buffer. */
>   	map = map_single(dev, phys, size, dir, attrs);
> -	if (map == SWIOTLB_MAP_ERROR) {
> -		swiotlb_full(dev, size, dir, 1);
> +	if (map == SWIOTLB_MAP_ERROR)
>   		return __phys_to_dma(dev, io_tlb_overflow_buffer);
> -	}
>   
>   	dev_addr = __phys_to_dma(dev, map);
>   
> @@ -948,7 +918,6 @@ swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl, int nelems,
>   			if (map == SWIOTLB_MAP_ERROR) {
>   				/* Don't panic here, we expect map_sg users
>   				   to do proper error handling. */
> -				swiotlb_full(hwdev, sg->length, dir, 0);
>   				attrs |= DMA_ATTR_SKIP_CPU_SYNC;
>   				swiotlb_unmap_sg_attrs(hwdev, sgl, i, dir,
>   						       attrs);
> 
