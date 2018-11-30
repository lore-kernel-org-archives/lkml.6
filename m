Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D22DC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA1D20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA1D20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbeLAGO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:14:59 -0500
Received: from foss.arm.com ([217.140.101.70]:35064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbeLAGO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:14:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B611165C;
        Fri, 30 Nov 2018 11:04:44 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7AFA3F575;
        Fri, 30 Nov 2018 11:04:42 -0800 (PST)
Subject: Re: [PATCH 1/9] dma-direct: provide page based alloc/free helpers
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181105121931.13481-1-hch@lst.de>
 <20181105121931.13481-2-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3b6439f3-fb7e-aaf7-01b9-b0fb03a27a69@arm.com>
Date:   Fri, 30 Nov 2018 19:04:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105121931.13481-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2018 12:19, Christoph Hellwig wrote:
> Some architectures support remapping highmem into DMA coherent
> allocations.  To use the common code for them we need variants of
> dma_direct_{alloc,free}_pages that do not use kernel virtual addresses.

FWIW it's as much about non-cacheable remapping of lowmem as it is about 
highmem. Regardless, the diff looks OK to me.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/dma-direct.h |  3 +++
>   kernel/dma/direct.c        | 32 ++++++++++++++++++++++----------
>   2 files changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index bd73e7a91410..5a7a3bbb912f 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -67,6 +67,9 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>   		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs);
>   void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
>   		dma_addr_t dma_addr, unsigned long attrs);
> +struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
> +		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs);
> +void __dma_direct_free_pages(struct device *dev, size_t size, struct page *page);
>   dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
>   		unsigned long offset, size_t size, enum dma_data_direction dir,
>   		unsigned long attrs);
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 22a12ab5a5e9..680287779b0a 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -103,14 +103,13 @@ static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
>   			min_not_zero(dev->coherent_dma_mask, dev->bus_dma_mask);
>   }
>   
> -void *dma_direct_alloc_pages(struct device *dev, size_t size,
> +struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
>   		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>   {
>   	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>   	int page_order = get_order(size);
>   	struct page *page = NULL;
>   	u64 phys_mask;
> -	void *ret;
>   
>   	if (attrs & DMA_ATTR_NO_WARN)
>   		gfp |= __GFP_NOWARN;
> @@ -150,11 +149,22 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>   		}
>   	}
>   
> +	return page;
> +}
> +
> +void *dma_direct_alloc_pages(struct device *dev, size_t size,
> +		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
> +{
> +	struct page *page;
> +	void *ret;
> +
> +	page = __dma_direct_alloc_pages(dev, size, dma_handle, gfp, attrs);
>   	if (!page)
>   		return NULL;
> +
>   	ret = page_address(page);
>   	if (force_dma_unencrypted()) {
> -		set_memory_decrypted((unsigned long)ret, 1 << page_order);
> +		set_memory_decrypted((unsigned long)ret, 1 << get_order(size));
>   		*dma_handle = __phys_to_dma(dev, page_to_phys(page));
>   	} else {
>   		*dma_handle = phys_to_dma(dev, page_to_phys(page));
> @@ -163,20 +173,22 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>   	return ret;
>   }
>   
> -/*
> - * NOTE: this function must never look at the dma_addr argument, because we want
> - * to be able to use it as a helper for iommu implementations as well.
> - */
> +void __dma_direct_free_pages(struct device *dev, size_t size, struct page *page)
> +{
> +	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> +
> +	if (!dma_release_from_contiguous(dev, page, count))
> +		__free_pages(page, get_order(size));
> +}
> +
>   void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
>   		dma_addr_t dma_addr, unsigned long attrs)
>   {
> -	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>   	unsigned int page_order = get_order(size);
>   
>   	if (force_dma_unencrypted())
>   		set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
> -	if (!dma_release_from_contiguous(dev, virt_to_page(cpu_addr), count))
> -		free_pages((unsigned long)cpu_addr, page_order);
> +	__dma_direct_free_pages(dev, size, virt_to_page(cpu_addr));
>   }
>   
>   void *dma_direct_alloc(struct device *dev, size_t size,
> 
