Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBD5C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E5420673
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E5420673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeLAGPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:15:25 -0500
Received: from foss.arm.com ([217.140.101.70]:35114 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbeLAGPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:15:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47728165C;
        Fri, 30 Nov 2018 11:05:09 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E19EC3F575;
        Fri, 30 Nov 2018 11:05:07 -0800 (PST)
Subject: Re: [PATCH 3/9] dma-mapping: move the remap helpers to a separate
 file
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181105121931.13481-1-hch@lst.de>
 <20181105121931.13481-4-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <eec8d6ba-d41a-51d4-d5ed-39982fed095d@arm.com>
Date:   Fri, 30 Nov 2018 19:05:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105121931.13481-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2018 12:19, Christoph Hellwig wrote:
> The dma remap code only really makes sense for not cache coherent
> architectures,

And coherent ones with highmem, presumably? That can at least be the 
case on 32-bit Arm, where coherent LPAE systems do exist (e.g. Calxeda 
Midway).

> and currently is only used by arm, arm64 and xtensa.
> Split it out into a separate file with a separate Kconfig symbol,
> which gets the right copyright notice given that this code was
> written by Laura Abbott working for Code Aurora at that point.

Ignoring the further super-nitpick that the comments got subtle grammar 
fixes in some places but not others,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Laura Abbott <labbott@redhat.com>
> ---
>   arch/arm/Kconfig     |  1 +
>   arch/arm64/Kconfig   |  1 +
>   arch/csky/Kconfig    |  1 +
>   arch/xtensa/Kconfig  |  1 +
>   kernel/dma/Kconfig   |  4 ++
>   kernel/dma/Makefile  |  2 +-
>   kernel/dma/mapping.c | 84 ------------------------------------------
>   kernel/dma/remap.c   | 88 ++++++++++++++++++++++++++++++++++++++++++++
>   8 files changed, 97 insertions(+), 85 deletions(-)
>   create mode 100644 kernel/dma/remap.c
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 91be74d8df65..3b2852df6eb3 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -30,6 +30,7 @@ config ARM
>   	select CPU_PM if (SUSPEND || CPU_IDLE)
>   	select DCACHE_WORD_ACCESS if HAVE_EFFICIENT_UNALIGNED_ACCESS
>   	select DMA_DIRECT_OPS if !MMU
> +	select DMA_REMAP if MMU
>   	select EDAC_SUPPORT
>   	select EDAC_ATOMIC_SCRUB
>   	select GENERIC_ALLOCATOR
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 787d7850e064..5d065acb6d10 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -82,6 +82,7 @@ config ARM64
>   	select CRC32
>   	select DCACHE_WORD_ACCESS
>   	select DMA_DIRECT_OPS
> +	select DMA_REMAP
>   	select EDAC_SUPPORT
>   	select FRAME_POINTER
>   	select GENERIC_ALLOCATOR
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index cb64f8dacd08..8a30e006a845 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -9,6 +9,7 @@ config CSKY
>   	select CLKSRC_OF
>   	select DMA_DIRECT_OPS
>   	select DMA_NONCOHERENT_OPS
> +	select DMA_REMAP
>   	select IRQ_DOMAIN
>   	select HANDLE_DOMAIN_IRQ
>   	select DW_APB_TIMER_OF
> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
> index d29b7365da8d..239bfb16c58b 100644
> --- a/arch/xtensa/Kconfig
> +++ b/arch/xtensa/Kconfig
> @@ -11,6 +11,7 @@ config XTENSA
>   	select CLONE_BACKWARDS
>   	select COMMON_CLK
>   	select DMA_DIRECT_OPS
> +	select DMA_REMAP if MMU
>   	select GENERIC_ATOMIC64
>   	select GENERIC_CLOCKEVENTS
>   	select GENERIC_IRQ_SHOW
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index 645c7a2ecde8..c92e08173ed8 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -51,3 +51,7 @@ config SWIOTLB
>   	bool
>   	select DMA_DIRECT_OPS
>   	select NEED_DMA_MAP_STATE
> +
> +config DMA_REMAP
> +	depends on MMU
> +	bool
> diff --git a/kernel/dma/Makefile b/kernel/dma/Makefile
> index 7d581e4eea4a..f4feeceb8020 100644
> --- a/kernel/dma/Makefile
> +++ b/kernel/dma/Makefile
> @@ -7,4 +7,4 @@ obj-$(CONFIG_DMA_DIRECT_OPS)		+= direct.o
>   obj-$(CONFIG_DMA_VIRT_OPS)		+= virt.o
>   obj-$(CONFIG_DMA_API_DEBUG)		+= debug.o
>   obj-$(CONFIG_SWIOTLB)			+= swiotlb.o
> -
> +obj-$(CONFIG_DMA_REMAP)			+= remap.o
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 58dec7a92b7b..dfbc3deb95cd 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -262,87 +262,3 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
>   #endif /* !CONFIG_ARCH_NO_COHERENT_DMA_MMAP */
>   }
>   EXPORT_SYMBOL(dma_common_mmap);
> -
> -#ifdef CONFIG_MMU
> -static struct vm_struct *__dma_common_pages_remap(struct page **pages,
> -			size_t size, unsigned long vm_flags, pgprot_t prot,
> -			const void *caller)
> -{
> -	struct vm_struct *area;
> -
> -	area = get_vm_area_caller(size, vm_flags, caller);
> -	if (!area)
> -		return NULL;
> -
> -	if (map_vm_area(area, prot, pages)) {
> -		vunmap(area->addr);
> -		return NULL;
> -	}
> -
> -	return area;
> -}
> -
> -/*
> - * remaps an array of PAGE_SIZE pages into another vm_area
> - * Cannot be used in non-sleeping contexts
> - */
> -void *dma_common_pages_remap(struct page **pages, size_t size,
> -			unsigned long vm_flags, pgprot_t prot,
> -			const void *caller)
> -{
> -	struct vm_struct *area;
> -
> -	area = __dma_common_pages_remap(pages, size, vm_flags, prot, caller);
> -	if (!area)
> -		return NULL;
> -
> -	area->pages = pages;
> -
> -	return area->addr;
> -}
> -
> -/*
> - * remaps an allocated contiguous region into another vm_area.
> - * Cannot be used in non-sleeping contexts
> - */
> -
> -void *dma_common_contiguous_remap(struct page *page, size_t size,
> -			unsigned long vm_flags,
> -			pgprot_t prot, const void *caller)
> -{
> -	int i;
> -	struct page **pages;
> -	struct vm_struct *area;
> -
> -	pages = kmalloc(sizeof(struct page *) << get_order(size), GFP_KERNEL);
> -	if (!pages)
> -		return NULL;
> -
> -	for (i = 0; i < (size >> PAGE_SHIFT); i++)
> -		pages[i] = nth_page(page, i);
> -
> -	area = __dma_common_pages_remap(pages, size, vm_flags, prot, caller);
> -
> -	kfree(pages);
> -
> -	if (!area)
> -		return NULL;
> -	return area->addr;
> -}
> -
> -/*
> - * unmaps a range previously mapped by dma_common_*_remap
> - */
> -void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
> -{
> -	struct vm_struct *area = find_vm_area(cpu_addr);
> -
> -	if (!area || (area->flags & vm_flags) != vm_flags) {
> -		WARN(1, "trying to free invalid coherent area: %p\n", cpu_addr);
> -		return;
> -	}
> -
> -	unmap_kernel_range((unsigned long)cpu_addr, PAGE_ALIGN(size));
> -	vunmap(cpu_addr);
> -}
> -#endif
> diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
> new file mode 100644
> index 000000000000..456f7cc3414d
> --- /dev/null
> +++ b/kernel/dma/remap.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2014 The Linux Foundation
> + */
> +#include <linux/dma-mapping.h>
> +#include <linux/slab.h>
> +#include <linux/vmalloc.h>
> +
> +static struct vm_struct *__dma_common_pages_remap(struct page **pages,
> +			size_t size, unsigned long vm_flags, pgprot_t prot,
> +			const void *caller)
> +{
> +	struct vm_struct *area;
> +
> +	area = get_vm_area_caller(size, vm_flags, caller);
> +	if (!area)
> +		return NULL;
> +
> +	if (map_vm_area(area, prot, pages)) {
> +		vunmap(area->addr);
> +		return NULL;
> +	}
> +
> +	return area;
> +}
> +
> +/*
> + * remaps an array of PAGE_SIZE pages into another vm_area
> + * Cannot be used in non-sleeping contexts
> + */
> +void *dma_common_pages_remap(struct page **pages, size_t size,
> +			unsigned long vm_flags, pgprot_t prot,
> +			const void *caller)
> +{
> +	struct vm_struct *area;
> +
> +	area = __dma_common_pages_remap(pages, size, vm_flags, prot, caller);
> +	if (!area)
> +		return NULL;
> +
> +	area->pages = pages;
> +
> +	return area->addr;
> +}
> +
> +/*
> + * Remaps an allocated contiguous region into another vm_area.
> + * Cannot be used in non-sleeping contexts
> + */
> +void *dma_common_contiguous_remap(struct page *page, size_t size,
> +			unsigned long vm_flags,
> +			pgprot_t prot, const void *caller)
> +{
> +	int i;
> +	struct page **pages;
> +	struct vm_struct *area;
> +
> +	pages = kmalloc(sizeof(struct page *) << get_order(size), GFP_KERNEL);
> +	if (!pages)
> +		return NULL;
> +
> +	for (i = 0; i < (size >> PAGE_SHIFT); i++)
> +		pages[i] = nth_page(page, i);
> +
> +	area = __dma_common_pages_remap(pages, size, vm_flags, prot, caller);
> +
> +	kfree(pages);
> +
> +	if (!area)
> +		return NULL;
> +	return area->addr;
> +}
> +
> +/*
> + * Unmaps a range previously mapped by dma_common_*_remap
> + */
> +void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
> +{
> +	struct vm_struct *area = find_vm_area(cpu_addr);
> +
> +	if (!area || (area->flags & vm_flags) != vm_flags) {
> +		WARN(1, "trying to free invalid coherent area: %p\n", cpu_addr);
> +		return;
> +	}
> +
> +	unmap_kernel_range((unsigned long)cpu_addr, PAGE_ALIGN(size));
> +	vunmap(cpu_addr);
> +}
> 
