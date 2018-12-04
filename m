Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943A4C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FC720878
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MjtHPTSx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40FC720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbeLDKKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:10:10 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:33022 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbeLDKKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DngtDs3xglHGJCWya0z1rBDau6L08+tGX8e4XGKLDQA=; b=MjtHPTSx2CsjiKBucgM7TQLLy
        AWLXCGZgC9BR/IVDpwBajclmYHSDs5Hg8kW/9kWEiFQV/lf8Lb+nX5A8SvNy/gxQ4xeEsPWXzjU6b
        KdA0w2mql+NMS2AlPqiJCe4iN0qAfqseF+ILN6OJAkg2bqapuppXOF8Wf4f5xHAfcrICY=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:60412)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gU7eQ-0005Wh-MC; Tue, 04 Dec 2018 10:09:58 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gU7eO-0003bn-2V; Tue, 04 Dec 2018 10:09:56 +0000
Date:   Tue, 4 Dec 2018 10:09:54 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>,
        Laura Abbott <labbott@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/9] dma-mapping: move the arm64 ncoherent alloc/free
 support to common code
Message-ID: <20181204100954.GN30658@n2100.armlinux.org.uk>
References: <20181105121931.13481-1-hch@lst.de>
 <20181105121931.13481-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105121931.13481-5-hch@lst.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 01:19:26PM +0100, Christoph Hellwig wrote:
> The arm64 codebase to implement coherent dma allocation for architectures
> with non-coherent DMA is a good start for a generic implementation, given
> that is uses the generic remap helpers, provides the atomic pool for
> allocations that can't sleep and still is realtively simple and well
> tested.  Move it to kernel/dma and allow architectures to opt into it
> using a config symbol.  Architectures just need to provide a new
> arch_dma_prep_coherent helper to writeback an invalidate the caches
> for any memory that gets remapped for uncached access.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm64/Kconfig              |   2 +-
>  arch/arm64/mm/dma-mapping.c     | 184 ++------------------------------
>  include/linux/dma-mapping.h     |   5 +
>  include/linux/dma-noncoherent.h |   2 +
>  kernel/dma/Kconfig              |   6 ++
>  kernel/dma/remap.c              | 158 ++++++++++++++++++++++++++-
>  6 files changed, 181 insertions(+), 176 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 5d065acb6d10..2e645ea693ea 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -82,7 +82,7 @@ config ARM64
>  	select CRC32
>  	select DCACHE_WORD_ACCESS
>  	select DMA_DIRECT_OPS
> -	select DMA_REMAP
> +	select DMA_DIRECT_REMAP
>  	select EDAC_SUPPORT
>  	select FRAME_POINTER
>  	select GENERIC_ALLOCATOR
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index a3ac26284845..e2e7e5d0f94e 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -33,113 +33,6 @@
>  
>  #include <asm/cacheflush.h>
>  
> -static struct gen_pool *atomic_pool __ro_after_init;
> -
> -#define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
> -static size_t atomic_pool_size __initdata = DEFAULT_DMA_COHERENT_POOL_SIZE;
> -
> -static int __init early_coherent_pool(char *p)
> -{
> -	atomic_pool_size = memparse(p, &p);
> -	return 0;
> -}
> -early_param("coherent_pool", early_coherent_pool);
> -
> -static void *__alloc_from_pool(size_t size, struct page **ret_page, gfp_t flags)
> -{
> -	unsigned long val;
> -	void *ptr = NULL;
> -
> -	if (!atomic_pool) {
> -		WARN(1, "coherent pool not initialised!\n");
> -		return NULL;
> -	}
> -
> -	val = gen_pool_alloc(atomic_pool, size);
> -	if (val) {
> -		phys_addr_t phys = gen_pool_virt_to_phys(atomic_pool, val);
> -
> -		*ret_page = phys_to_page(phys);
> -		ptr = (void *)val;
> -		memset(ptr, 0, size);
> -	}
> -
> -	return ptr;
> -}
> -
> -static bool __in_atomic_pool(void *start, size_t size)
> -{
> -	return addr_in_gen_pool(atomic_pool, (unsigned long)start, size);
> -}
> -
> -static int __free_from_pool(void *start, size_t size)
> -{
> -	if (!__in_atomic_pool(start, size))
> -		return 0;
> -
> -	gen_pool_free(atomic_pool, (unsigned long)start, size);
> -
> -	return 1;
> -}
> -
> -void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
> -		gfp_t flags, unsigned long attrs)
> -{
> -	struct page *page;
> -	void *ptr, *coherent_ptr;
> -	pgprot_t prot = pgprot_writecombine(PAGE_KERNEL);
> -
> -	size = PAGE_ALIGN(size);
> -
> -	if (!gfpflags_allow_blocking(flags)) {
> -		struct page *page = NULL;
> -		void *addr = __alloc_from_pool(size, &page, flags);
> -
> -		if (addr)
> -			*dma_handle = phys_to_dma(dev, page_to_phys(page));
> -
> -		return addr;
> -	}
> -
> -	ptr = dma_direct_alloc_pages(dev, size, dma_handle, flags, attrs);
> -	if (!ptr)
> -		goto no_mem;
> -
> -	/* remove any dirty cache lines on the kernel alias */
> -	__dma_flush_area(ptr, size);
> -
> -	/* create a coherent mapping */
> -	page = virt_to_page(ptr);
> -	coherent_ptr = dma_common_contiguous_remap(page, size, VM_USERMAP,
> -						   prot, __builtin_return_address(0));
> -	if (!coherent_ptr)
> -		goto no_map;
> -
> -	return coherent_ptr;
> -
> -no_map:
> -	dma_direct_free_pages(dev, size, ptr, *dma_handle, attrs);
> -no_mem:
> -	return NULL;
> -}
> -
> -void arch_dma_free(struct device *dev, size_t size, void *vaddr,
> -		dma_addr_t dma_handle, unsigned long attrs)
> -{
> -	if (!__free_from_pool(vaddr, PAGE_ALIGN(size))) {
> -		void *kaddr = phys_to_virt(dma_to_phys(dev, dma_handle));
> -
> -		vunmap(vaddr);
> -		dma_direct_free_pages(dev, size, kaddr, dma_handle, attrs);
> -	}
> -}
> -
> -long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
> -		dma_addr_t dma_addr)
> -{
> -	return __phys_to_pfn(dma_to_phys(dev, dma_addr));
> -}
> -
>  pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
>  		unsigned long attrs)
>  {
> @@ -160,6 +53,11 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
>  	__dma_unmap_area(phys_to_virt(paddr), size, dir);
>  }
>  
> +void arch_dma_prep_coherent(struct page *page, size_t size)
> +{
> +	__dma_flush_area(page_address(page), size);
> +}
> +
>  #ifdef CONFIG_IOMMU_DMA
>  static int __swiotlb_get_sgtable_page(struct sg_table *sgt,
>  				      struct page *page, size_t size)
> @@ -191,67 +89,6 @@ static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
>  }
>  #endif /* CONFIG_IOMMU_DMA */
>  
> -static int __init atomic_pool_init(void)
> -{
> -	pgprot_t prot = __pgprot(PROT_NORMAL_NC);
> -	unsigned long nr_pages = atomic_pool_size >> PAGE_SHIFT;
> -	struct page *page;
> -	void *addr;
> -	unsigned int pool_size_order = get_order(atomic_pool_size);
> -
> -	if (dev_get_cma_area(NULL))
> -		page = dma_alloc_from_contiguous(NULL, nr_pages,
> -						 pool_size_order, false);
> -	else
> -		page = alloc_pages(GFP_DMA32, pool_size_order);
> -
> -	if (page) {
> -		int ret;
> -		void *page_addr = page_address(page);
> -
> -		memset(page_addr, 0, atomic_pool_size);
> -		__dma_flush_area(page_addr, atomic_pool_size);
> -
> -		atomic_pool = gen_pool_create(PAGE_SHIFT, -1);
> -		if (!atomic_pool)
> -			goto free_page;
> -
> -		addr = dma_common_contiguous_remap(page, atomic_pool_size,
> -					VM_USERMAP, prot, atomic_pool_init);
> -
> -		if (!addr)
> -			goto destroy_genpool;
> -
> -		ret = gen_pool_add_virt(atomic_pool, (unsigned long)addr,
> -					page_to_phys(page),
> -					atomic_pool_size, -1);
> -		if (ret)
> -			goto remove_mapping;
> -
> -		gen_pool_set_algo(atomic_pool,
> -				  gen_pool_first_fit_order_align,
> -				  NULL);
> -
> -		pr_info("DMA: preallocated %zu KiB pool for atomic allocations\n",
> -			atomic_pool_size / 1024);
> -		return 0;
> -	}
> -	goto out;
> -
> -remove_mapping:
> -	dma_common_free_remap(addr, atomic_pool_size, VM_USERMAP);
> -destroy_genpool:
> -	gen_pool_destroy(atomic_pool);
> -	atomic_pool = NULL;
> -free_page:
> -	if (!dma_release_from_contiguous(NULL, page, nr_pages))
> -		__free_pages(page, pool_size_order);
> -out:
> -	pr_err("DMA: failed to allocate %zu KiB pool for atomic coherent allocation\n",
> -		atomic_pool_size / 1024);
> -	return -ENOMEM;
> -}
> -
>  /********************************************
>   * The following APIs are for dummy DMA ops *
>   ********************************************/
> @@ -350,8 +187,7 @@ static int __init arm64_dma_init(void)
>  		   TAINT_CPU_OUT_OF_SPEC,
>  		   "ARCH_DMA_MINALIGN smaller than CTR_EL0.CWG (%d < %d)",
>  		   ARCH_DMA_MINALIGN, cache_line_size());
> -
> -	return atomic_pool_init();
> +	return dma_atomic_pool_init(GFP_DMA32, __pgprot(PROT_NORMAL_NC));
>  }
>  arch_initcall(arm64_dma_init);
>  
> @@ -397,7 +233,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
>  			page = alloc_pages(gfp, get_order(size));
>  			addr = page ? page_address(page) : NULL;
>  		} else {
> -			addr = __alloc_from_pool(size, &page, gfp);
> +			addr = dma_alloc_from_pool(size, &page, gfp);
>  		}
>  		if (!addr)
>  			return NULL;
> @@ -407,7 +243,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
>  			if (coherent)
>  				__free_pages(page, get_order(size));
>  			else
> -				__free_from_pool(addr, size);
> +				dma_free_from_pool(addr, size);
>  			addr = NULL;
>  		}
>  	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
> @@ -471,9 +307,9 @@ static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
>  	 *   coherent devices.
>  	 * Hence how dodgy the below logic looks...
>  	 */
> -	if (__in_atomic_pool(cpu_addr, size)) {
> +	if (dma_in_atomic_pool(cpu_addr, size)) {
>  		iommu_dma_unmap_page(dev, handle, iosize, 0, 0);
> -		__free_from_pool(cpu_addr, size);
> +		dma_free_from_pool(cpu_addr, size);
>  	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
>  		struct page *page = vmalloc_to_page(cpu_addr);
>  
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 15bd41447025..56ed94b99963 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -455,6 +455,11 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
>  			const void *caller);
>  void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags);
>  
> +int __init dma_atomic_pool_init(gfp_t gfp, pgprot_t prot);
> +bool dma_in_atomic_pool(void *start, size_t size);
> +void *dma_alloc_from_pool(size_t size, struct page **ret_page, gfp_t flags);
> +bool dma_free_from_pool(void *start, size_t size);
> +
>  /**
>   * dma_mmap_attrs - map a coherent DMA allocation into user space
>   * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
> diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
> index 9051b055beec..306557331d7d 100644
> --- a/include/linux/dma-noncoherent.h
> +++ b/include/linux/dma-noncoherent.h
> @@ -69,4 +69,6 @@ static inline void arch_sync_dma_for_cpu_all(struct device *dev)
>  }
>  #endif /* CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL */
>  
> +void arch_dma_prep_coherent(struct page *page, size_t size);
> +
>  #endif /* _LINUX_DMA_NONCOHERENT_H */
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index c92e08173ed8..fb045ebb0713 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -55,3 +55,9 @@ config SWIOTLB
>  config DMA_REMAP
>  	depends on MMU
>  	bool
> +
> +config DMA_DIRECT_REMAP
> +	bool
> +	depends on DMA_DIRECT_OPS
> +	select DMA_REMAP
> +
> diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
> index 456f7cc3414d..bc42766f52df 100644
> --- a/kernel/dma/remap.c
> +++ b/kernel/dma/remap.c
> @@ -1,8 +1,13 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> + * Copyright (C) 2012 ARM Ltd.
>   * Copyright (c) 2014 The Linux Foundation
>   */
> -#include <linux/dma-mapping.h>
> +#include <linux/dma-direct.h>
> +#include <linux/dma-noncoherent.h>
> +#include <linux/dma-contiguous.h>
> +#include <linux/init.h>
> +#include <linux/genalloc.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  
> @@ -86,3 +91,154 @@ void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
>  	unmap_kernel_range((unsigned long)cpu_addr, PAGE_ALIGN(size));
>  	vunmap(cpu_addr);
>  }
> +
> +#ifdef CONFIG_DMA_DIRECT_REMAP
> +static struct gen_pool *atomic_pool __ro_after_init;
> +
> +#define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
> +static size_t atomic_pool_size __initdata = DEFAULT_DMA_COHERENT_POOL_SIZE;
> +
> +static int __init early_coherent_pool(char *p)
> +{
> +	atomic_pool_size = memparse(p, &p);
> +	return 0;
> +}
> +early_param("coherent_pool", early_coherent_pool);
> +
> +int __init dma_atomic_pool_init(gfp_t gfp, pgprot_t prot)
> +{
> +	unsigned int pool_size_order = get_order(atomic_pool_size);
> +	unsigned long nr_pages = atomic_pool_size >> PAGE_SHIFT;
> +	struct page *page;
> +	void *addr;
> +	int ret;
> +
> +	if (dev_get_cma_area(NULL))
> +		page = dma_alloc_from_contiguous(NULL, nr_pages,
> +						 pool_size_order, false);
> +	else
> +		page = alloc_pages(gfp, pool_size_order);
> +	if (!page)
> +		goto out;
> +
> +	memset(page_address(page), 0, atomic_pool_size);

Note that this won't work if 'page' is a highmem page - should there
be a check for that, or a check for the gfp flags?

Also, is this memset() actually useful, or a waste of cycles - when we
allocate from this pool (see dma_alloc_from_pool()), we always memset()
the buffer.

> +	arch_dma_prep_coherent(page, atomic_pool_size);
> +
> +	atomic_pool = gen_pool_create(PAGE_SHIFT, -1);
> +	if (!atomic_pool)
> +		goto free_page;
> +
> +	addr = dma_common_contiguous_remap(page, atomic_pool_size, VM_USERMAP,
> +					   prot, __builtin_return_address(0));
> +	if (!addr)
> +		goto destroy_genpool;
> +
> +	ret = gen_pool_add_virt(atomic_pool, (unsigned long)addr,
> +				page_to_phys(page), atomic_pool_size, -1);
> +	if (ret)
> +		goto remove_mapping;
> +	gen_pool_set_algo(atomic_pool, gen_pool_first_fit_order_align, NULL);
> +
> +	pr_info("DMA: preallocated %zu KiB pool for atomic allocations\n",
> +		atomic_pool_size / 1024);
> +	return 0;
> +
> +remove_mapping:
> +	dma_common_free_remap(addr, atomic_pool_size, VM_USERMAP);
> +destroy_genpool:
> +	gen_pool_destroy(atomic_pool);
> +	atomic_pool = NULL;
> +free_page:
> +	if (!dma_release_from_contiguous(NULL, page, nr_pages))
> +		__free_pages(page, pool_size_order);
> +out:
> +	pr_err("DMA: failed to allocate %zu KiB pool for atomic coherent allocation\n",
> +		atomic_pool_size / 1024);
> +	return -ENOMEM;
> +}
> +
> +bool dma_in_atomic_pool(void *start, size_t size)
> +{
> +	return addr_in_gen_pool(atomic_pool, (unsigned long)start, size);
> +}
> +
> +void *dma_alloc_from_pool(size_t size, struct page **ret_page, gfp_t flags)
> +{
> +	unsigned long val;
> +	void *ptr = NULL;
> +
> +	if (!atomic_pool) {
> +		WARN(1, "coherent pool not initialised!\n");
> +		return NULL;
> +	}
> +
> +	val = gen_pool_alloc(atomic_pool, size);
> +	if (val) {
> +		phys_addr_t phys = gen_pool_virt_to_phys(atomic_pool, val);
> +
> +		*ret_page = phys_to_page(phys);
> +		ptr = (void *)val;
> +		memset(ptr, 0, size);
> +	}
> +
> +	return ptr;
> +}
> +
> +bool dma_free_from_pool(void *start, size_t size)
> +{
> +	if (!dma_in_atomic_pool(start, size))
> +		return false;
> +	gen_pool_free(atomic_pool, (unsigned long)start, size);
> +	return true;
> +}
> +
> +void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
> +		gfp_t flags, unsigned long attrs)
> +{
> +	struct page *page = NULL;
> +	void *ret, *kaddr;
> +
> +	size = PAGE_ALIGN(size);
> +
> +	if (!gfpflags_allow_blocking(flags)) {
> +		ret = dma_alloc_from_pool(size, &page, flags);
> +		if (!ret)
> +			return NULL;
> +		*dma_handle = phys_to_dma(dev, page_to_phys(page));
> +		return ret;
> +	}
> +
> +	kaddr = dma_direct_alloc_pages(dev, size, dma_handle, flags, attrs);
> +	if (!kaddr)
> +		return NULL;
> +	page = virt_to_page(kaddr);
> +
> +	/* remove any dirty cache lines on the kernel alias */
> +	arch_dma_prep_coherent(page, size);
> +
> +	/* create a coherent mapping */
> +	ret = dma_common_contiguous_remap(page, size, VM_USERMAP,
> +			arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs),
> +			__builtin_return_address(0));
> +	if (!ret)
> +		dma_direct_free_pages(dev, size, kaddr, *dma_handle, attrs);
> +	return ret;
> +}
> +
> +void arch_dma_free(struct device *dev, size_t size, void *vaddr,
> +		dma_addr_t dma_handle, unsigned long attrs)
> +{
> +	if (!dma_free_from_pool(vaddr, PAGE_ALIGN(size))) {
> +		void *kaddr = phys_to_virt(dma_to_phys(dev, dma_handle));
> +
> +		vunmap(vaddr);
> +		dma_direct_free_pages(dev, size, kaddr, dma_handle, attrs);
> +	}
> +}
> +
> +long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
> +		dma_addr_t dma_addr)
> +{
> +	return __phys_to_pfn(dma_to_phys(dev, dma_addr));
> +}
> +#endif /* CONFIG_DMA_DIRECT_REMAP */
> -- 
> 2.19.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
