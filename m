Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B5BECDE3D
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 07:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3152083E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 07:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3152083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbeJUPzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 11:55:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40621 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbeJUPzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 11:55:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id z204-v6so7277099wmc.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 00:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rzN/8kthXSWeNM4H67LMyrGoBwfM2ARtA7EYl707aks=;
        b=jgQkEquiITto7Re+hw7bHwEmu9om8f6scurQjY/60gxlsvdaHZYzUpA3yPRGiCpv/v
         bgxXXgsAKqAxm7GWe5UdAtUG3PkUh+vP2dCkRm8okVncWuHljnt9k8mex/DH2oyLH7ma
         NNo5xK87xBbD10wSw33Lj6xOyf/5z25bZVSwj+pqpZBVR3wGbha7UZjcjNEhz0Vz2Ysc
         F848dD77IKWABqCqAY+sg/OwBrBJYXMY8ntwLcogtaP7s+pU3MazIYWgqn3j+jDAlGh0
         N+C4nbLJUhCkKAwgEmW00CyhS5J7vUAhrinXumFjPyuIfTl3HVqtug6GbFOmfkj3SteL
         1X0A==
X-Gm-Message-State: ABuFfogQSPcIIkgfMdUTJRdDIbn0NgI2n5Ip81nokxKlo1M+octZw0tm
        gCC5XtvlmpZOMtR1c9Rxc1fyZPEseqGnu1El5ns=
X-Google-Smtp-Source: ACcGV61l1CgQWcGdz30nPlfS3D6lc8yHNUzIZlCHjbyXarIWPkqd0Ae+oiNRzFVc+7D1/e9eLosNzA==
X-Received: by 2002:a1c:c58b:: with SMTP id v133-v6mr10806259wmf.139.1540107704048;
        Sun, 21 Oct 2018 00:41:44 -0700 (PDT)
Received: from [10.15.242.27] ([109.144.221.236])
        by smtp.gmail.com with ESMTPSA id d6-v6sm10762968wrq.27.2018.10.21.00.41.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 00:41:43 -0700 (PDT)
Subject: Re: [PATCH] dma-mapping: move the remap helpers to a separate file
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20181014181651.22971-1-hch@lst.de>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <e2a05b3e-7306-4710-1591-0a39278b5002@redhat.com>
Date:   Sun, 21 Oct 2018 00:41:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181014181651.22971-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/2018 11:16 AM, Christoph Hellwig wrote:
> The dma remap code only really makes sense for not cache coherent
> architectures, and currently is only used by arm, arm64 and xtensa.
> Split it out into a separate file with a separate Kconfig symbol.
> 
> [Laura: you wrote this code back then, do you have a sensible
>   copyright statement to add, given that the mapping.c statement
>   obviously does not match your code that was written much later]
> 

Hmmmmm, that was written and committed via my codeaurora.org e-mail
address. Probably best to use "Copyright (c) 2014, The Linux Foundation"
since that was the standard. If you want,

Acked-by: Laura Abbott <labbott@redhat.com>

Thanks,
Laura

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/arm/Kconfig     |  1 +
>   arch/arm64/Kconfig   |  1 +
>   arch/xtensa/Kconfig  |  1 +
>   kernel/dma/Kconfig   |  4 +++
>   kernel/dma/Makefile  |  2 +-
>   kernel/dma/mapping.c | 84 -------------------------------------------
>   kernel/dma/remap.c   | 85 ++++++++++++++++++++++++++++++++++++++++++++
>   7 files changed, 93 insertions(+), 85 deletions(-)
>   create mode 100644 kernel/dma/remap.c
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e8cd55a5b04c..cf54e572dafd 100644
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
> index 1b1a0e95c751..179994b67d11 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -77,6 +77,7 @@ config ARM64
>   	select CPU_PM if (SUSPEND || CPU_IDLE)
>   	select DCACHE_WORD_ACCESS
>   	select DMA_DIRECT_OPS
> +	select DMA_REMAP
>   	select EDAC_SUPPORT
>   	select FRAME_POINTER
>   	select GENERIC_ALLOCATOR
> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
> index 9a7c654a7654..d57abe4cad0f 100644
> --- a/arch/xtensa/Kconfig
> +++ b/arch/xtensa/Kconfig
> @@ -10,6 +10,7 @@ config XTENSA
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
> index 000000000000..33dff4096d46
> --- /dev/null
> +++ b/kernel/dma/remap.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0
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

