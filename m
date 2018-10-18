Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BACC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93703204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93703204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeJSBzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:55:14 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41894 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbeJSBzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:55:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11432341;
        Thu, 18 Oct 2018 10:53:10 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFF913F5D3;
        Thu, 18 Oct 2018 10:53:08 -0700 (PDT)
Subject: Re: [PATCH 06/10] swiotlb: use swiotlb_map_page in
 swiotlb_map_sg_attrs
To:     Christoph Hellwig <hch@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-7-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3ffc4e16-979c-7d04-2d6c-f784be583b70@arm.com>
Date:   Thu, 18 Oct 2018 18:53:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008080246.20543-7-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/18 09:02, Christoph Hellwig wrote:
> No need to duplicate the code - map_sg is equivalent to map_page
> for each page in the scatterlist.

Even better, this will also make map_sg actually fire the tracepoint 
(which I've certainly found handy in the past for debugging a mask 
cockup that led to excessive bouncing).

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/swiotlb.c | 34 ++++++++++++----------------------
>   1 file changed, 12 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 15335f3a1bf3..15755d7a5242 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -845,37 +845,27 @@ swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
>    * same here.
>    */
>   int
> -swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl, int nelems,
> +swiotlb_map_sg_attrs(struct device *dev, struct scatterlist *sgl, int nelems,
>   		     enum dma_data_direction dir, unsigned long attrs)
>   {
>   	struct scatterlist *sg;
>   	int i;
>   
> -	BUG_ON(dir == DMA_NONE);
> -
>   	for_each_sg(sgl, sg, nelems, i) {
> -		phys_addr_t paddr = sg_phys(sg);
> -		dma_addr_t dev_addr = phys_to_dma(hwdev, paddr);
> -
> -		if (swiotlb_force == SWIOTLB_FORCE ||
> -		    !dma_capable(hwdev, dev_addr, sg->length)) {
> -			phys_addr_t map = map_single(hwdev, sg_phys(sg),
> -						     sg->length, dir, attrs);
> -			if (map == SWIOTLB_MAP_ERROR) {
> -				/* Don't panic here, we expect map_sg users
> -				   to do proper error handling. */
> -				attrs |= DMA_ATTR_SKIP_CPU_SYNC;
> -				swiotlb_unmap_sg_attrs(hwdev, sgl, i, dir,
> -						       attrs);
> -				sg_dma_len(sgl) = 0;
> -				return 0;
> -			}
> -			sg->dma_address = __phys_to_dma(hwdev, map);
> -		} else
> -			sg->dma_address = dev_addr;
> +		sg->dma_address = swiotlb_map_page(dev, sg_page(sg), sg->offset,
> +				sg->length, dir, attrs);
> +		if (sg->dma_address == DIRECT_MAPPING_ERROR)
> +			goto out_error;
>   		sg_dma_len(sg) = sg->length;
>   	}
> +
>   	return nelems;
> +
> +out_error:
> +	swiotlb_unmap_sg_attrs(dev, sgl, i, dir,
> +			attrs | DMA_ATTR_SKIP_CPU_SYNC);
> +	sg_dma_len(sgl) = 0;
> +	return 0;
>   }
>   
>   /*
> 
