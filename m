Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6AEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D7B218E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbfBZXfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 18:35:53 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54824 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfBZXfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 18:35:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B45B2A78;
        Tue, 26 Feb 2019 15:35:52 -0800 (PST)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AC0B3F738;
        Tue, 26 Feb 2019 15:35:48 -0800 (PST)
Subject: Re: [PATCH] Revert "dma-contiguous: do not allocate a single page
 from CMA area"
To:     Nicolin Chen <nicoleotsuka@gmail.com>, hch@lst.de,
        m.szyprowski@samsung.com, tony@atomide.com
Cc:     vdumpa@nvidia.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, tomi.valkeinen@ti.com,
        laurent.pinchart@ideasonboard.com, sre@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20190226202327.5349-1-nicoleotsuka@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <1a3af95a-6e08-01fa-e4ef-07c1c1b6db69@arm.com>
Date:   Tue, 26 Feb 2019 23:35:44 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190226202327.5349-1-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-26 8:23 pm, Nicolin Chen wrote:
> This reverts commit d222e42e88168fd67e6d131984b86477af1fc256.
> 
> The original change breaks omap dss:
>      omapdss_dispc 58001000.dispc:
>          dispc_errata_i734_wa_init: dma_alloc_writecombine failed
> 
> Let's revert it first and then find a safer solution instead.

Ah, I think I see the problem - once arch/arm's __dma_alloc() has 
decided to use CMA (because dev_get_cma_area(dev) returns the global 
area), it then won't fall back to trying a regular page allocation if 
dma_alloc_from_contiguous() returns NULL. Thus anything on 32-bit Arm 
trying to allocate a single-page buffer in blockable context with a 
CMA-enabled config is just going to fail. Similarly, it looks like none 
of the DMA_ATTR_FORCE_CONTIGUOUS cases are prepared to handle this 
change either (amd_iommu appears technically affected, but is already 
using dma_alloc_from_contiguous() backwards compared to everyone else, hmm).

I guess the question is whether to add alloc_page()/free_page() 
fallbacks to those call sites, or stuff them directly into the CMA 
helpers here.

Robin.

> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
> Tony,
> 	
> Would you please test and verify? Thanks!
> 
>   kernel/dma/contiguous.c | 22 +++-------------------
>   1 file changed, 3 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 09074bd04793..b2a87905846d 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -186,32 +186,16 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
>    *
>    * This function allocates memory buffer for specified device. It uses
>    * device specific contiguous memory area if available or the default
> - * global one.
> - *
> - * However, it skips one-page size of allocations from the global area.
> - * As the addresses within one page are always contiguous, so there is
> - * no need to waste CMA pages for that kind; it also helps reduce the
> - * fragmentations in the CMA area. So a caller should be the rebounder
> - * in such case to allocate a normal page upon NULL return value.
> - *
> - * Requires architecture specific dev_get_cma_area() helper function.
> + * global one. Requires architecture specific dev_get_cma_area() helper
> + * function.
>    */
>   struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
>   				       unsigned int align, bool no_warn)
>   {
> -	struct cma *cma;
> -
>   	if (align > CONFIG_CMA_ALIGNMENT)
>   		align = CONFIG_CMA_ALIGNMENT;
>   
> -	if (dev && dev->cma_area)
> -		cma = dev->cma_area;
> -	else if (count > 1)
> -		cma = dma_contiguous_default_area;
> -	else
> -		return NULL;
> -
> -	return cma_alloc(cma, count, align, no_warn);
> +	return cma_alloc(dev_get_cma_area(dev), count, align, no_warn);
>   }
>   
>   /**
> 
