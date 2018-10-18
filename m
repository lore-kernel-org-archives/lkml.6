Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B3BC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BC52145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BC52145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbeJSBqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:46:37 -0400
Received: from foss.arm.com ([217.140.101.70]:41682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbeJSBqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:46:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 937B3341;
        Thu, 18 Oct 2018 10:44:35 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DA643F5D3;
        Thu, 18 Oct 2018 10:44:34 -0700 (PDT)
Subject: Re: [PATCH 05/10] swiotlb: merge swiotlb_unmap_page and unmap_single
To:     Christoph Hellwig <hch@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-6-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <04683c71-b1a2-4a61-f46c-cd450ac80627@arm.com>
Date:   Thu, 18 Oct 2018 18:44:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008080246.20543-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/18 09:02, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/swiotlb.c | 15 ++++-----------
>   1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 11dbcd80b4a6..15335f3a1bf3 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -765,9 +765,9 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
>    * After this call, reads by the cpu to the buffer are guaranteed to see
>    * whatever the device wrote there.
>    */
> -static void unmap_single(struct device *hwdev, dma_addr_t dev_addr,
> -			 size_t size, enum dma_data_direction dir,
> -			 unsigned long attrs)
> +void swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
> +			size_t size, enum dma_data_direction dir,
> +			unsigned long attrs)
>   {
>   	phys_addr_t paddr = dma_to_phys(hwdev, dev_addr);
>   
> @@ -790,13 +790,6 @@ static void unmap_single(struct device *hwdev, dma_addr_t dev_addr,
>   	dma_mark_clean(phys_to_virt(paddr), size);
>   }
>   
> -void swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
> -			size_t size, enum dma_data_direction dir,
> -			unsigned long attrs)
> -{
> -	unmap_single(hwdev, dev_addr, size, dir, attrs);
> -}
> -
>   /*
>    * Make physical memory consistent for a single streaming mode DMA translation
>    * after a transfer.
> @@ -900,7 +893,7 @@ swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
>   	BUG_ON(dir == DMA_NONE);

In passing, I notice that this BUG_ON(), and its friends elsewhere in 
the file, appear entirely pointless, since the wrappers in dma-mapping.h 
have already made the equivalent check.

For this patch, though,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   
>   	for_each_sg(sgl, sg, nelems, i)
> -		unmap_single(hwdev, sg->dma_address, sg_dma_len(sg), dir,
> +		swiotlb_unmap_page(hwdev, sg->dma_address, sg_dma_len(sg), dir,
>   			     attrs);
>   }
>   
> 
