Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310ADC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0137E20673
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0137E20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeLAGP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:15:59 -0500
Received: from foss.arm.com ([217.140.101.70]:35196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbeLAGP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:15:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 860A61684;
        Fri, 30 Nov 2018 11:05:43 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27EFC3F575;
        Fri, 30 Nov 2018 11:05:42 -0800 (PST)
Subject: Re: [PATCH 6/9] dma-remap: support DMA_ATTR_NO_KERNEL_MAPPING
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181105121931.13481-1-hch@lst.de>
 <20181105121931.13481-7-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e993440c-53bf-8071-b1b6-06d022d39e4e@arm.com>
Date:   Fri, 30 Nov 2018 19:05:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105121931.13481-7-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2018 12:19, Christoph Hellwig wrote:
> Do not waste vmalloc space on allocations that do not require a mapping
> into the kernel address space.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/remap.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
> index 8f1fca34b894..10a545126b0b 100644
> --- a/kernel/dma/remap.c
> +++ b/kernel/dma/remap.c
> @@ -200,7 +200,8 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   
>   	size = PAGE_ALIGN(size);
>   
> -	if (!gfpflags_allow_blocking(flags)) {
> +	if (!gfpflags_allow_blocking(flags) &&
> +	    !(attrs & DMA_ATTR_NO_KERNEL_MAPPING)) {
>   		ret = dma_alloc_from_pool(size, &page, flags);
>   		if (!ret)
>   			return NULL;
> @@ -215,6 +216,9 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   	/* remove any dirty cache lines on the kernel alias */
>   	arch_dma_prep_coherent(page, size);
>   
> +	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING)
> +		return page; /* opaqueue cookie */

Best to preempt the inevitable patch fixing that typo in 3 months' time. 
Otherwise,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> +
>   	/* create a coherent mapping */
>   	ret = dma_common_contiguous_remap(page, size, VM_USERMAP,
>   			arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs),
> @@ -227,7 +231,10 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   void arch_dma_free(struct device *dev, size_t size, void *vaddr,
>   		dma_addr_t dma_handle, unsigned long attrs)
>   {
> -	if (!dma_free_from_pool(vaddr, PAGE_ALIGN(size))) {
> +	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING) {
> +		/* vaddr is a struct page cookie, not a kernel address */
> +		__dma_direct_free_pages(dev, size, vaddr);
> +	} else if (!dma_free_from_pool(vaddr, PAGE_ALIGN(size))) {
>   		phys_addr_t phys = dma_to_phys(dev, dma_handle);
>   		struct page *page = pfn_to_page(__phys_to_pfn(phys));
>   
> 
