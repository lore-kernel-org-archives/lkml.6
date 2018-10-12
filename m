Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF30C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDE32086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CDE32086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbeJLUdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 16:33:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51116 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbeJLUdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 16:33:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A0BFED1;
        Fri, 12 Oct 2018 06:01:03 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A122F3F5D3;
        Fri, 12 Oct 2018 06:01:01 -0700 (PDT)
Subject: Re: [PATCH 10/10] arm64: use the generic swiotlb_dma_ops
To:     Christoph Hellwig <hch@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-11-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8ae57670-ced9-5ebb-caf5-cc99f15fdf22@arm.com>
Date:   Fri, 12 Oct 2018 14:01:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008080246.20543-11-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/18 09:02, Christoph Hellwig wrote:
> Now that the generic swiotlb code supports non-coherent DMA we can switch
> to it for arm64.  For that we need to refactor the existing
> alloc/free/mmap/pgprot helpers to be used as the architecture hooks,
> and implement the standard arch_sync_dma_for_{device,cpu} hooks for
> cache maintaincance in the streaming dma hooks, which also implies
> using the generic dma_coherent flag in struct device.
> 
> Note that we need to keep the old is_device_dma_coherent function around
> for now, so that the shared arm/arm64 Xen code keeps working.

OK, so when I said last night that it boot-tested OK, that much was 
true, but then I shut the board down as I left and got a megasplosion of 
bad page state BUGs, e.g.:

[ 3312.848182] BUG: Bad page state in process llvmpipe-5  pfn:8a78e
[ 3312.854138] page:ffff7e000029e380 count:2 mapcount:1 
mapping:ffff800034019268 index:0xd3
[ 3312.862170] flags: 0x10028(uptodate|lru|mappedtodisk)
[ 3312.867176] raw: 0000000000010028 ffff7e0000dc5508 ffff7e0000c7bb48 
ffff800034019268
[ 3312.874883] raw: 00000000000000d3 0000000000000000 0000000200000000 
ffff800036b91000
[ 3312.882608] page dumped because: page still charged to cgroup
[ 3312.888352] page->mem_cgroup:ffff800036b91000
[ 3312.892714] bad because of flags: 0x20(lru)
[ 3312.896959] Modules linked in:
[ 3312.900042] CPU: 0 PID: 283 Comm: llvmpipe-5 Tainted: G    B 
    4.19.0-rc3+ #801
[ 3312.908136] Hardware name: ARM LTD ARM Juno Development Platform/ARM 
Juno Development Platform, BIOS EDK II Jul 10 2018
[ 3312.918810] Call trace:
[ 3312.921236]  dump_backtrace+0x0/0x1f0
[ 3312.924860]  show_stack+0x14/0x20
[ 3312.928142]  dump_stack+0x9c/0xbc
[ 3312.931422]  bad_page+0xe8/0x150
[ 3312.934615]  free_pages_check_bad+0x9c/0xa8
[ 3312.938754]  __free_pages_ok+0x27c/0x288
[ 3312.942635]  __free_pages+0x30/0x48
[ 3312.946086]  free_pages.part.22+0x1c/0x28
[ 3312.950053]  free_pages+0x14/0x20
[ 3312.953333]  dma_direct_free_pages+0x5c/0x68
[ 3312.957560]  arch_dma_free+0x5c/0x70
[ 3312.961095]  dma_direct_free+0x20/0x28
[ 3312.964805]  drm_gem_cma_free_object+0xb0/0x150
[ 3312.969290]  drm_gem_object_free+0x1c/0x58
[ 3312.973343]  drm_gem_object_put_unlocked+0x70/0x98
[ 3312.978084]  drm_gem_object_handle_put_unlocked+0x64/0xc0
[ 3312.983426]  drm_gem_object_release_handle+0x54/0x90
[ 3312.988339]  idr_for_each+0x70/0x130
[ 3312.991876]  drm_gem_release+0x28/0x40
[ 3312.995584]  drm_file_free.part.0+0x214/0x288
[ 3312.999895]  drm_release+0x94/0x118
[ 3313.003347]  __fput+0x8c/0x1c0
[ 3313.006368]  ____fput+0xc/0x18
[ 3313.009390]  task_work_run+0x98/0xb8
[ 3313.012927]  do_exit+0x2b8/0x970
[ 3313.016119]  do_group_exit+0x38/0xa0
[ 3313.019656]  get_signal+0xfc/0x4b0
[ 3313.023021]  do_signal+0x1a0/0x2a8
[ 3313.026386]  do_notify_resume+0xe8/0x128
[ 3313.030267]  work_pending+0x8/0x10
...
[ 3313.972527] BUG: Bad page state in process llvmpipe-5  pfn:8a794
[ 3313.978605] page:ffff7e000029e500 count:0 mapcount:-128 
mapping:0000000000000000 index:0x1
[ 3313.986845] flags: 0x0()
[ 3313.989393] raw: 0000000000000000 ffff7e0000185908 ffff7e0000933b08 
0000000000000000
[ 3313.997116] raw: 0000000000000001 0000000000000002 00000000ffffff7f 
0000000000000000
[ 3314.004824] page dumped because: nonzero mapcount
[ 3314.009523] Modules linked in:
[ 3314.012623] CPU: 0 PID: 283 Comm: llvmpipe-5 Tainted: G    B 
    4.19.0-rc3+ #801
[ 3314.020718] Hardware name: ARM LTD ARM Juno Development Platform/ARM 
Juno Development Platform, BIOS EDK II Jul 10 2018
[ 3314.031390] Call trace:
[ 3314.033810]  dump_backtrace+0x0/0x1f0
[ 3314.037434]  show_stack+0x14/0x20
[ 3314.040713]  dump_stack+0x9c/0xbc
[ 3314.043993]  bad_page+0xe8/0x150
[ 3314.047186]  free_pages_check_bad+0x70/0xa8
[ 3314.051325]  __free_pages_ok+0x27c/0x288
[ 3314.055205]  __free_pages+0x30/0x48
[ 3314.058656]  free_pages.part.22+0x1c/0x28
[ 3314.062623]  free_pages+0x14/0x20
[ 3314.065902]  dma_direct_free_pages+0x5c/0x68
[ 3314.070127]  arch_dma_free+0x5c/0x70
[ 3314.073663]  dma_direct_free+0x20/0x28
[ 3314.077371]  drm_gem_cma_free_object+0xb0/0x150
[ 3314.081854]  drm_gem_object_free+0x1c/0x58
[ 3314.085906]  drm_gem_object_put_unlocked+0x70/0x98
[ 3314.090647]  drm_gem_object_handle_put_unlocked+0x64/0xc0
[ 3314.095990]  drm_gem_object_release_handle+0x54/0x90
[ 3314.100902]  idr_for_each+0x70/0x130
[ 3314.104439]  drm_gem_release+0x28/0x40
[ 3314.108148]  drm_file_free.part.0+0x214/0x288
[ 3314.112458]  drm_release+0x94/0x118
[ 3314.115909]  __fput+0x8c/0x1c0
[ 3314.118930]  ____fput+0xc/0x18
[ 3314.121950]  task_work_run+0x98/0xb8
[ 3314.125486]  do_exit+0x2b8/0x970
[ 3314.128678]  do_group_exit+0x38/0xa0
[ 3314.132214]  get_signal+0xfc/0x4b0
[ 3314.135579]  do_signal+0x1a0/0x2a8
[ 3314.138945]  do_notify_resume+0xe8/0x128
[ 3314.142825]  work_pending+0x8/0x10
...

and hundreds more with various different reasons.

AFAICS there's something about coherent allocations causing page 
corruptions (it doesn't seem triggerable without the DRM framebuffer 
being allocated, at least with the method I've been using). Predictably, 
though somewhat unhelpfully, it bisects to this commit, so the apparent 
alloc_coherent connection is as far as I can narrow it down for the moment.

Robin.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/arm64/Kconfig                   |   4 +
>   arch/arm64/include/asm/device.h      |   1 -
>   arch/arm64/include/asm/dma-mapping.h |   7 +-
>   arch/arm64/mm/dma-mapping.c          | 257 +++++----------------------
>   4 files changed, 56 insertions(+), 213 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1b1a0e95c751..c4db5131d837 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -11,6 +11,8 @@ config ARM64
>   	select ARCH_CLOCKSOURCE_DATA
>   	select ARCH_HAS_DEBUG_VIRTUAL
>   	select ARCH_HAS_DEVMEM_IS_ALLOWED
> +	select ARCH_HAS_DMA_COHERENT_TO_PFN
> +	select ARCH_HAS_DMA_MMAP_PGPROT
>   	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
>   	select ARCH_HAS_ELF_RANDOMIZE
>   	select ARCH_HAS_FAST_MULTIPLIER
> @@ -24,6 +26,8 @@ config ARM64
>   	select ARCH_HAS_SG_CHAIN
>   	select ARCH_HAS_STRICT_KERNEL_RWX
>   	select ARCH_HAS_STRICT_MODULE_RWX
> +	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> +	select ARCH_HAS_SYNC_DMA_FOR_CPU
>   	select ARCH_HAS_SYSCALL_WRAPPER
>   	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>   	select ARCH_HAVE_NMI_SAFE_CMPXCHG
> diff --git a/arch/arm64/include/asm/device.h b/arch/arm64/include/asm/device.h
> index 5a5fa47a6b18..3dd3d664c5c5 100644
> --- a/arch/arm64/include/asm/device.h
> +++ b/arch/arm64/include/asm/device.h
> @@ -23,7 +23,6 @@ struct dev_archdata {
>   #ifdef CONFIG_XEN
>   	const struct dma_map_ops *dev_dma_ops;
>   #endif
> -	bool dma_coherent;
>   };
>   
>   struct pdev_archdata {
> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
> index b7847eb8a7bb..c41f3fb1446c 100644
> --- a/arch/arm64/include/asm/dma-mapping.h
> +++ b/arch/arm64/include/asm/dma-mapping.h
> @@ -44,10 +44,13 @@ void arch_teardown_dma_ops(struct device *dev);
>   #define arch_teardown_dma_ops	arch_teardown_dma_ops
>   #endif
>   
> -/* do not use this function in a driver */
> +/*
> + * Do not use this function in a driver, it is only provided for
> + * arch/arm/mm/xen.c, which is used by arm64 as well.
> + */
>   static inline bool is_device_dma_coherent(struct device *dev)
>   {
> -	return dev->archdata.dma_coherent;
> +	return dev->dma_coherent;
>   }
>   
>   #endif	/* __KERNEL__ */
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index eee6cfcfde9e..3c75d69b54e7 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -25,6 +25,7 @@
>   #include <linux/slab.h>
>   #include <linux/genalloc.h>
>   #include <linux/dma-direct.h>
> +#include <linux/dma-noncoherent.h>
>   #include <linux/dma-contiguous.h>
>   #include <linux/vmalloc.h>
>   #include <linux/swiotlb.h>
> @@ -32,16 +33,6 @@
>   
>   #include <asm/cacheflush.h>
>   
> -static int swiotlb __ro_after_init;
> -
> -static pgprot_t __get_dma_pgprot(unsigned long attrs, pgprot_t prot,
> -				 bool coherent)
> -{
> -	if (!coherent || (attrs & DMA_ATTR_WRITE_COMBINE))
> -		return pgprot_writecombine(prot);
> -	return prot;
> -}
> -
>   static struct gen_pool *atomic_pool __ro_after_init;
>   
>   #define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
> @@ -91,18 +82,16 @@ static int __free_from_pool(void *start, size_t size)
>   	return 1;
>   }
>   
> -static void *__dma_alloc(struct device *dev, size_t size,
> -			 dma_addr_t *dma_handle, gfp_t flags,
> -			 unsigned long attrs)
> +void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
> +		gfp_t flags, unsigned long attrs)
>   {
>   	struct page *page;
>   	void *ptr, *coherent_ptr;
> -	bool coherent = is_device_dma_coherent(dev);
> -	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, false);
> +	pgprot_t prot = pgprot_writecombine(PAGE_KERNEL);
>   
>   	size = PAGE_ALIGN(size);
>   
> -	if (!coherent && !gfpflags_allow_blocking(flags)) {
> +	if (!gfpflags_allow_blocking(flags)) {
>   		struct page *page = NULL;
>   		void *addr = __alloc_from_pool(size, &page, flags);
>   
> @@ -116,10 +105,6 @@ static void *__dma_alloc(struct device *dev, size_t size,
>   	if (!ptr)
>   		goto no_mem;
>   
> -	/* no need for non-cacheable mapping if coherent */
> -	if (coherent)
> -		return ptr;
> -
>   	/* remove any dirty cache lines on the kernel alias */
>   	__dma_flush_area(ptr, size);
>   
> @@ -138,125 +123,50 @@ static void *__dma_alloc(struct device *dev, size_t size,
>   	return NULL;
>   }
>   
> -static void __dma_free(struct device *dev, size_t size,
> -		       void *vaddr, dma_addr_t dma_handle,
> -		       unsigned long attrs)
> -{
> -	void *swiotlb_addr = phys_to_virt(dma_to_phys(dev, dma_handle));
> -
> -	size = PAGE_ALIGN(size);
> -
> -	if (!is_device_dma_coherent(dev)) {
> -		if (__free_from_pool(vaddr, size))
> -			return;
> -		vunmap(vaddr);
> -	}
> -	dma_direct_free_pages(dev, size, swiotlb_addr, dma_handle, attrs);
> -}
> -
> -static dma_addr_t __swiotlb_map_page(struct device *dev, struct page *page,
> -				     unsigned long offset, size_t size,
> -				     enum dma_data_direction dir,
> -				     unsigned long attrs)
> -{
> -	dma_addr_t dev_addr;
> -
> -	dev_addr = swiotlb_map_page(dev, page, offset, size, dir, attrs);
> -	if (!is_device_dma_coherent(dev) &&
> -	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
> -		__dma_map_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
> -
> -	return dev_addr;
> -}
> -
> -
> -static void __swiotlb_unmap_page(struct device *dev, dma_addr_t dev_addr,
> -				 size_t size, enum dma_data_direction dir,
> -				 unsigned long attrs)
> +void arch_dma_free(struct device *dev, size_t size, void *vaddr,
> +		dma_addr_t dma_handle, unsigned long attrs)
>   {
> -	if (!is_device_dma_coherent(dev) &&
> -	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
> -		__dma_unmap_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
> -	swiotlb_unmap_page(dev, dev_addr, size, dir, attrs);
> +	if (__free_from_pool(vaddr, PAGE_ALIGN(size)))
> +		return;
> +	vunmap(vaddr);
> +	dma_direct_free_pages(dev, size, vaddr, dma_handle, attrs);
>   }
>   
> -static int __swiotlb_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
> -				  int nelems, enum dma_data_direction dir,
> -				  unsigned long attrs)
> +long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
> +		dma_addr_t dma_addr)
>   {
> -	struct scatterlist *sg;
> -	int i, ret;
> -
> -	ret = swiotlb_map_sg_attrs(dev, sgl, nelems, dir, attrs);
> -	if (!is_device_dma_coherent(dev) &&
> -	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
> -		for_each_sg(sgl, sg, ret, i)
> -			__dma_map_area(phys_to_virt(dma_to_phys(dev, sg->dma_address)),
> -				       sg->length, dir);
> -
> -	return ret;
> +	return __phys_to_pfn(dma_to_phys(dev, dma_addr));
>   }
>   
> -static void __swiotlb_unmap_sg_attrs(struct device *dev,
> -				     struct scatterlist *sgl, int nelems,
> -				     enum dma_data_direction dir,
> -				     unsigned long attrs)
> +pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
> +		unsigned long attrs)
>   {
> -	struct scatterlist *sg;
> -	int i;
> -
> -	if (!is_device_dma_coherent(dev) &&
> -	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
> -		for_each_sg(sgl, sg, nelems, i)
> -			__dma_unmap_area(phys_to_virt(dma_to_phys(dev, sg->dma_address)),
> -					 sg->length, dir);
> -	swiotlb_unmap_sg_attrs(dev, sgl, nelems, dir, attrs);
> +	if (!dev_is_dma_coherent(dev) || (attrs & DMA_ATTR_WRITE_COMBINE))
> +		return pgprot_writecombine(prot);
> +	return prot;
>   }
>   
> -static void __swiotlb_sync_single_for_cpu(struct device *dev,
> -					  dma_addr_t dev_addr, size_t size,
> -					  enum dma_data_direction dir)
> +void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
> +		size_t size, enum dma_data_direction dir)
>   {
> -	if (!is_device_dma_coherent(dev))
> -		__dma_unmap_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
> -	swiotlb_sync_single_for_cpu(dev, dev_addr, size, dir);
> +	__dma_map_area(phys_to_virt(paddr), size, dir);
>   }
>   
> -static void __swiotlb_sync_single_for_device(struct device *dev,
> -					     dma_addr_t dev_addr, size_t size,
> -					     enum dma_data_direction dir)
> +void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
> +		size_t size, enum dma_data_direction dir)
>   {
> -	swiotlb_sync_single_for_device(dev, dev_addr, size, dir);
> -	if (!is_device_dma_coherent(dev))
> -		__dma_map_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
> +	__dma_unmap_area(phys_to_virt(paddr), size, dir);
>   }
>   
> -static void __swiotlb_sync_sg_for_cpu(struct device *dev,
> -				      struct scatterlist *sgl, int nelems,
> -				      enum dma_data_direction dir)
> +static int __swiotlb_get_sgtable_page(struct sg_table *sgt,
> +				      struct page *page, size_t size)
>   {
> -	struct scatterlist *sg;
> -	int i;
> -
> -	if (!is_device_dma_coherent(dev))
> -		for_each_sg(sgl, sg, nelems, i)
> -			__dma_unmap_area(phys_to_virt(dma_to_phys(dev, sg->dma_address)),
> -					 sg->length, dir);
> -	swiotlb_sync_sg_for_cpu(dev, sgl, nelems, dir);
> -}
> +	int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
>   
> -static void __swiotlb_sync_sg_for_device(struct device *dev,
> -					 struct scatterlist *sgl, int nelems,
> -					 enum dma_data_direction dir)
> -{
> -	struct scatterlist *sg;
> -	int i;
> +	if (!ret)
> +		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
>   
> -	swiotlb_sync_sg_for_device(dev, sgl, nelems, dir);
> -	if (!is_device_dma_coherent(dev))
> -		for_each_sg(sgl, sg, nelems, i)
> -			__dma_map_area(phys_to_virt(dma_to_phys(dev, sg->dma_address)),
> -				       sg->length, dir);
> +	return ret;
>   }
>   
>   static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
> @@ -277,74 +187,6 @@ static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
>   	return ret;
>   }
>   
> -static int __swiotlb_mmap(struct device *dev,
> -			  struct vm_area_struct *vma,
> -			  void *cpu_addr, dma_addr_t dma_addr, size_t size,
> -			  unsigned long attrs)
> -{
> -	int ret;
> -	unsigned long pfn = dma_to_phys(dev, dma_addr) >> PAGE_SHIFT;
> -
> -	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot,
> -					     is_device_dma_coherent(dev));
> -
> -	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
> -		return ret;
> -
> -	return __swiotlb_mmap_pfn(vma, pfn, size);
> -}
> -
> -static int __swiotlb_get_sgtable_page(struct sg_table *sgt,
> -				      struct page *page, size_t size)
> -{
> -	int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> -
> -	if (!ret)
> -		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
> -
> -	return ret;
> -}
> -
> -static int __swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
> -				 void *cpu_addr, dma_addr_t handle, size_t size,
> -				 unsigned long attrs)
> -{
> -	struct page *page = phys_to_page(dma_to_phys(dev, handle));
> -
> -	return __swiotlb_get_sgtable_page(sgt, page, size);
> -}
> -
> -static int __swiotlb_dma_supported(struct device *hwdev, u64 mask)
> -{
> -	if (swiotlb)
> -		return swiotlb_dma_supported(hwdev, mask);
> -	return 1;
> -}
> -
> -static int __swiotlb_dma_mapping_error(struct device *hwdev, dma_addr_t addr)
> -{
> -	if (swiotlb)
> -		return dma_direct_mapping_error(hwdev, addr);
> -	return 0;
> -}
> -
> -static const struct dma_map_ops arm64_swiotlb_dma_ops = {
> -	.alloc = __dma_alloc,
> -	.free = __dma_free,
> -	.mmap = __swiotlb_mmap,
> -	.get_sgtable = __swiotlb_get_sgtable,
> -	.map_page = __swiotlb_map_page,
> -	.unmap_page = __swiotlb_unmap_page,
> -	.map_sg = __swiotlb_map_sg_attrs,
> -	.unmap_sg = __swiotlb_unmap_sg_attrs,
> -	.sync_single_for_cpu = __swiotlb_sync_single_for_cpu,
> -	.sync_single_for_device = __swiotlb_sync_single_for_device,
> -	.sync_sg_for_cpu = __swiotlb_sync_sg_for_cpu,
> -	.sync_sg_for_device = __swiotlb_sync_sg_for_device,
> -	.dma_supported = __swiotlb_dma_supported,
> -	.mapping_error = __swiotlb_dma_mapping_error,
> -};
> -
>   static int __init atomic_pool_init(void)
>   {
>   	pgprot_t prot = __pgprot(PROT_NORMAL_NC);
> @@ -500,10 +342,6 @@ EXPORT_SYMBOL(dummy_dma_ops);
>   
>   static int __init arm64_dma_init(void)
>   {
> -	if (swiotlb_force == SWIOTLB_FORCE ||
> -	    max_pfn > (arm64_dma_phys_limit >> PAGE_SHIFT))
> -		swiotlb = 1;
> -
>   	WARN_TAINT(ARCH_DMA_MINALIGN < cache_line_size(),
>   		   TAINT_CPU_OUT_OF_SPEC,
>   		   "ARCH_DMA_MINALIGN smaller than CTR_EL0.CWG (%d < %d)",
> @@ -528,7 +366,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
>   				 dma_addr_t *handle, gfp_t gfp,
>   				 unsigned long attrs)
>   {
> -	bool coherent = is_device_dma_coherent(dev);
> +	bool coherent = dev_is_dma_coherent(dev);
>   	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
>   	size_t iosize = size;
>   	void *addr;
> @@ -569,7 +407,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
>   			addr = NULL;
>   		}
>   	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
> -		pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, coherent);
> +		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
>   		struct page *page;
>   
>   		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
> @@ -596,7 +434,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
>   						    size >> PAGE_SHIFT);
>   		}
>   	} else {
> -		pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, coherent);
> +		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
>   		struct page **pages;
>   
>   		pages = iommu_dma_alloc(dev, iosize, gfp, attrs, ioprot,
> @@ -658,8 +496,7 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
>   	struct vm_struct *area;
>   	int ret;
>   
> -	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot,
> -					     is_device_dma_coherent(dev));
> +	vma->vm_page_prot = arch_dma_mmap_pgprot(dev, vma->vm_page_prot, attrs);
>   
>   	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
>   		return ret;
> @@ -709,11 +546,11 @@ static void __iommu_sync_single_for_cpu(struct device *dev,
>   {
>   	phys_addr_t phys;
>   
> -	if (is_device_dma_coherent(dev))
> +	if (dev_is_dma_coherent(dev))
>   		return;
>   
>   	phys = iommu_iova_to_phys(iommu_get_domain_for_dev(dev), dev_addr);
> -	__dma_unmap_area(phys_to_virt(phys), size, dir);
> +	arch_sync_dma_for_cpu(dev, phys, size, dir);
>   }
>   
>   static void __iommu_sync_single_for_device(struct device *dev,
> @@ -722,11 +559,11 @@ static void __iommu_sync_single_for_device(struct device *dev,
>   {
>   	phys_addr_t phys;
>   
> -	if (is_device_dma_coherent(dev))
> +	if (dev_is_dma_coherent(dev))
>   		return;
>   
>   	phys = iommu_iova_to_phys(iommu_get_domain_for_dev(dev), dev_addr);
> -	__dma_map_area(phys_to_virt(phys), size, dir);
> +	arch_sync_dma_for_device(dev, phys, size, dir);
>   }
>   
>   static dma_addr_t __iommu_map_page(struct device *dev, struct page *page,
> @@ -734,7 +571,7 @@ static dma_addr_t __iommu_map_page(struct device *dev, struct page *page,
>   				   enum dma_data_direction dir,
>   				   unsigned long attrs)
>   {
> -	bool coherent = is_device_dma_coherent(dev);
> +	bool coherent = dev_is_dma_coherent(dev);
>   	int prot = dma_info_to_prot(dir, coherent, attrs);
>   	dma_addr_t dev_addr = iommu_dma_map_page(dev, page, offset, size, prot);
>   
> @@ -762,11 +599,11 @@ static void __iommu_sync_sg_for_cpu(struct device *dev,
>   	struct scatterlist *sg;
>   	int i;
>   
> -	if (is_device_dma_coherent(dev))
> +	if (dev_is_dma_coherent(dev))
>   		return;
>   
>   	for_each_sg(sgl, sg, nelems, i)
> -		__dma_unmap_area(sg_virt(sg), sg->length, dir);
> +		arch_sync_dma_for_cpu(dev, sg_phys(sg), sg->length, dir);
>   }
>   
>   static void __iommu_sync_sg_for_device(struct device *dev,
> @@ -776,18 +613,18 @@ static void __iommu_sync_sg_for_device(struct device *dev,
>   	struct scatterlist *sg;
>   	int i;
>   
> -	if (is_device_dma_coherent(dev))
> +	if (dev_is_dma_coherent(dev))
>   		return;
>   
>   	for_each_sg(sgl, sg, nelems, i)
> -		__dma_map_area(sg_virt(sg), sg->length, dir);
> +		arch_sync_dma_for_device(dev, sg_phys(sg), sg->length, dir);
>   }
>   
>   static int __iommu_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
>   				int nelems, enum dma_data_direction dir,
>   				unsigned long attrs)
>   {
> -	bool coherent = is_device_dma_coherent(dev);
> +	bool coherent = dev_is_dma_coherent(dev);
>   
>   	if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
>   		__iommu_sync_sg_for_device(dev, sgl, nelems, dir);
> @@ -879,9 +716,9 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>   			const struct iommu_ops *iommu, bool coherent)
>   {
>   	if (!dev->dma_ops)
> -		dev->dma_ops = &arm64_swiotlb_dma_ops;
> +		dev->dma_ops = &swiotlb_dma_ops;
>   
> -	dev->archdata.dma_coherent = coherent;
> +	dev->dma_coherent = coherent;
>   	__iommu_setup_dma_ops(dev, dma_base, size, iommu);
>   
>   #ifdef CONFIG_XEN
> 
