Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6360C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC2320827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC2320827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387606AbeKFQZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 11:25:33 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:49870 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387469AbeKFQZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 11:25:33 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07437118|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01e01534;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.DECBElK_1541487701;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.DECBElK_1541487701)
          by smtp.aliyun-inc.com(10.147.41.120);
          Tue, 06 Nov 2018 15:01:41 +0800
Date:   Tue, 6 Nov 2018 15:01:41 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] csky: use the generic remapping dma alloc
 implementation
Message-ID: <20181106070140.GA6232@guoren-Inspiron-7460>
References: <20181105121931.13481-1-hch@lst.de>
 <20181105121931.13481-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105121931.13481-10-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 01:19:31PM +0100, Christoph Hellwig wrote:
> The csky code was largely copied from arm/arm64, so switch to the
> generic arm64-based implementation instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/csky/Kconfig          |   2 +-
>  arch/csky/mm/dma-mapping.c | 142 +------------------------------------
>  2 files changed, 3 insertions(+), 141 deletions(-)
> 
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index c0cf8e948821..ea74f3a9eeaf 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -8,7 +8,7 @@ config CSKY
>  	select CLKSRC_MMIO
>  	select CLKSRC_OF
>  	select DMA_DIRECT_OPS
> -	select DMA_REMAP
> +	select DMA_DIRECT_REMAP
>  	select IRQ_DOMAIN
>  	select HANDLE_DOMAIN_IRQ
>  	select DW_APB_TIMER_OF
> diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
> index ad4046939713..80783bb71c5c 100644
> --- a/arch/csky/mm/dma-mapping.c
> +++ b/arch/csky/mm/dma-mapping.c
> @@ -14,73 +14,13 @@
>  #include <linux/version.h>
>  #include <asm/cache.h>
>  
> -static struct gen_pool *atomic_pool;
> -static size_t atomic_pool_size __initdata = SZ_256K;
> -
> -static int __init early_coherent_pool(char *p)
> -{
> -	atomic_pool_size = memparse(p, &p);
> -	return 0;
> -}
> -early_param("coherent_pool", early_coherent_pool);
> -
>  static int __init atomic_pool_init(void)
>  {
> -	struct page *page;
> -	size_t size = atomic_pool_size;
> -	void *ptr;
> -	int ret;
> -
> -	atomic_pool = gen_pool_create(PAGE_SHIFT, -1);
> -	if (!atomic_pool)
> -		BUG();
> -
> -	page = alloc_pages(GFP_KERNEL, get_order(size));
> -	if (!page)
> -		BUG();
> -
> -	ptr = dma_common_contiguous_remap(page, size, VM_ALLOC,
> -					  pgprot_noncached(PAGE_KERNEL),
> -					  __builtin_return_address(0));
> -	if (!ptr)
> -		BUG();
> -
> -	ret = gen_pool_add_virt(atomic_pool, (unsigned long)ptr,
> -				page_to_phys(page), atomic_pool_size, -1);
> -	if (ret)
> -		BUG();
> -
> -	gen_pool_set_algo(atomic_pool, gen_pool_first_fit_order_align, NULL);
> -
> -	pr_info("DMA: preallocated %zu KiB pool for atomic coherent pool\n",
> -		atomic_pool_size / 1024);
> -
> -	pr_info("DMA: vaddr: 0x%x phy: 0x%lx,\n", (unsigned int)ptr,
> -		page_to_phys(page));
> -
> -	return 0;
> +	return dma_atomic_pool_init(GFP_KERNEL, pgprot_noncached(PAGE_KERNEL));
>  }
>  postcore_initcall(atomic_pool_init);
Seems also could remove atomic_pool_init from csky, why not put them in
common?

>  
> -static void *csky_dma_alloc_atomic(struct device *dev, size_t size,
> -				   dma_addr_t *dma_handle)
> -{
> -	unsigned long addr;
> -
> -	addr = gen_pool_alloc(atomic_pool, size);
> -	if (addr)
> -		*dma_handle = gen_pool_virt_to_phys(atomic_pool, addr);
> -
> -	return (void *)addr;
> -}
> -
> -static void csky_dma_free_atomic(struct device *dev, size_t size, void *vaddr,
> -				 dma_addr_t dma_handle, unsigned long attrs)
> -{
> -	gen_pool_free(atomic_pool, (unsigned long)vaddr, size);
> -}
> -
> -static void __dma_clear_buffer(struct page *page, size_t size)
> +void arch_dma_prep_coherent(struct page *page, size_t size)
>  {
>  	if (PageHighMem(page)) {
>  		unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> @@ -107,84 +47,6 @@ static void __dma_clear_buffer(struct page *page, size_t size)
>  	}
>  }
>  
> -static void *csky_dma_alloc_nonatomic(struct device *dev, size_t size,
> -				      dma_addr_t *dma_handle, gfp_t gfp,
> -				      unsigned long attrs)
> -{
> -	void  *vaddr;
> -	struct page *page;
> -	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -
> -	if (DMA_ATTR_NON_CONSISTENT & attrs) {
> -		pr_err("csky %s can't support DMA_ATTR_NON_CONSISTENT.\n", __func__);
> -		return NULL;
> -	}
> -
> -	if (IS_ENABLED(CONFIG_DMA_CMA))
> -		page = dma_alloc_from_contiguous(dev, count, get_order(size),
> -						 gfp);
> -	else
> -		page = alloc_pages(gfp, get_order(size));
> -
> -	if (!page) {
> -		pr_err("csky %s no more free pages.\n", __func__);
> -		return NULL;
> -	}
> -
> -	*dma_handle = page_to_phys(page);
> -
> -	__dma_clear_buffer(page, size);
> -
> -	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING)
> -		return page;
> -
> -	vaddr = dma_common_contiguous_remap(page, PAGE_ALIGN(size), VM_USERMAP,
> -		pgprot_noncached(PAGE_KERNEL), __builtin_return_address(0));
> -	if (!vaddr)
> -		BUG();
> -
> -	return vaddr;
> -}
> -
> -static void csky_dma_free_nonatomic(
> -	struct device *dev,
> -	size_t size,
> -	void *vaddr,
> -	dma_addr_t dma_handle,
> -	unsigned long attrs
> -	)
> -{
> -	struct page *page = phys_to_page(dma_handle);
> -	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -
> -	if ((unsigned int)vaddr >= VMALLOC_START)
> -		dma_common_free_remap(vaddr, size, VM_USERMAP);
> -
> -	if (IS_ENABLED(CONFIG_DMA_CMA))
> -		dma_release_from_contiguous(dev, page, count);
> -	else
> -		__free_pages(page, get_order(size));
> -}
> -
> -void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
> -		     gfp_t gfp, unsigned long attrs)
> -{
> -	if (gfpflags_allow_blocking(gfp))
> -		return csky_dma_alloc_nonatomic(dev, size, dma_handle, gfp,
> -						attrs);
> -	else
> -		return csky_dma_alloc_atomic(dev, size, dma_handle);
> -}
> -
> -void arch_dma_free(struct device *dev, size_t size, void *vaddr,
> -		   dma_addr_t dma_handle, unsigned long attrs)
> -{
> -	if (!addr_in_gen_pool(atomic_pool, (unsigned int) vaddr, size))
> -		csky_dma_free_nonatomic(dev, size, vaddr, dma_handle, attrs);
> -	else
> -		csky_dma_free_atomic(dev, size, vaddr, dma_handle, attrs);
> -}
> -
>  static inline void cache_op(phys_addr_t paddr, size_t size,
>  			    void (*fn)(unsigned long start, unsigned long end))
>  {
> -- 
> 2.19.1

Reviewed-by: Guo Ren <ren_guo@c-sky.com>

Compile is OK, qemu boot OK. Functions are the same and just move to common.

Looks good for me.

 Guo Ren

