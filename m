Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95408C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610B620834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610B620834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbeLAGPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:15:51 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35178 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbeLAGPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:15:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EE1C165C;
        Fri, 30 Nov 2018 11:05:36 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA4F63F575;
        Fri, 30 Nov 2018 11:05:34 -0800 (PST)
Subject: Re: [PATCH 5/9] dma-mapping: support highmem in the generic remap
 allocator
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181105121931.13481-1-hch@lst.de>
 <20181105121931.13481-6-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <449e0631-aa32-d4a8-9fa9-07234ae1e533@arm.com>
Date:   Fri, 30 Nov 2018 19:05:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105121931.13481-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2018 12:19, Christoph Hellwig wrote:
> By using __dma_direct_alloc_pages we can deal entirely with struct page
> instead of having to derive a kernel virtual address.

Simple enough :)

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/remap.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
> index bc42766f52df..8f1fca34b894 100644
> --- a/kernel/dma/remap.c
> +++ b/kernel/dma/remap.c
> @@ -196,7 +196,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   		gfp_t flags, unsigned long attrs)
>   {
>   	struct page *page = NULL;
> -	void *ret, *kaddr;
> +	void *ret;
>   
>   	size = PAGE_ALIGN(size);
>   
> @@ -208,10 +208,9 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   		return ret;
>   	}
>   
> -	kaddr = dma_direct_alloc_pages(dev, size, dma_handle, flags, attrs);
> -	if (!kaddr)
> +	page = __dma_direct_alloc_pages(dev, size, dma_handle, flags, attrs);
> +	if (!page)
>   		return NULL;
> -	page = virt_to_page(kaddr);
>   
>   	/* remove any dirty cache lines on the kernel alias */
>   	arch_dma_prep_coherent(page, size);
> @@ -221,7 +220,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   			arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs),
>   			__builtin_return_address(0));
>   	if (!ret)
> -		dma_direct_free_pages(dev, size, kaddr, *dma_handle, attrs);
> +		__dma_direct_free_pages(dev, size, page);
>   	return ret;
>   }
>   
> @@ -229,10 +228,11 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
>   		dma_addr_t dma_handle, unsigned long attrs)
>   {
>   	if (!dma_free_from_pool(vaddr, PAGE_ALIGN(size))) {
> -		void *kaddr = phys_to_virt(dma_to_phys(dev, dma_handle));
> +		phys_addr_t phys = dma_to_phys(dev, dma_handle);
> +		struct page *page = pfn_to_page(__phys_to_pfn(phys));
>   
>   		vunmap(vaddr);
> -		dma_direct_free_pages(dev, size, kaddr, dma_handle, attrs);
> +		__dma_direct_free_pages(dev, size, page);
>   	}
>   }
>   
> 
