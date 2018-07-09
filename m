Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D509C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145F32087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145F32087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932844AbeGINJj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:09:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:51404 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932595AbeGINJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:09:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 252C5AE61;
        Mon,  9 Jul 2018 13:09:36 +0000 (UTC)
Date:   Mon, 9 Jul 2018 15:09:31 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Nazarewicz <mina86@mina86.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Zankel <chris@zankel.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 1/2] mm/cma: remove unsupported gfp_mask parameter from
 cma_alloc()
Message-ID: <20180709130931.GL22049@dhcp22.suse.cz>
References: <20180709121956.20200-1-m.szyprowski@samsung.com>
 <CGME20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29@eucas1p2.samsung.com>
 <20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29~-sqTPJKij2939229392eucas1p2j@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29~-sqTPJKij2939229392eucas1p2j@eucas1p2.samsung.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-07-18 14:19:55, Marek Szyprowski wrote:
> cma_alloc() function doesn't really support gfp flags other than
> __GFP_NOWARN, so convert gfp_mask parameter to boolean no_warn parameter.
> 
> This will help to avoid giving false feeling that this function supports
> standard gfp flags and callers can pass __GFP_ZERO to get zeroed buffer,
> what has already been an issue: see commit dd65a941f6ba ("arm64:
> dma-mapping: clear buffers allocated with FORCE_CONTIGUOUS flag").
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks! This makes perfect sense to me. If there is a real need for the
gfp_mask then we should start by defining the semantic first.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/powerpc/kvm/book3s_hv_builtin.c       | 2 +-
>  drivers/s390/char/vmcp.c                   | 2 +-
>  drivers/staging/android/ion/ion_cma_heap.c | 2 +-
>  include/linux/cma.h                        | 2 +-
>  kernel/dma/contiguous.c                    | 3 ++-
>  mm/cma.c                                   | 8 ++++----
>  mm/cma_debug.c                             | 2 +-
>  7 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
> index d4a3f4da409b..fc6bb9630a9c 100644
> --- a/arch/powerpc/kvm/book3s_hv_builtin.c
> +++ b/arch/powerpc/kvm/book3s_hv_builtin.c
> @@ -77,7 +77,7 @@ struct page *kvm_alloc_hpt_cma(unsigned long nr_pages)
>  	VM_BUG_ON(order_base_2(nr_pages) < KVM_CMA_CHUNK_ORDER - PAGE_SHIFT);
>  
>  	return cma_alloc(kvm_cma, nr_pages, order_base_2(HPT_ALIGN_PAGES),
> -			 GFP_KERNEL);
> +			 false);
>  }
>  EXPORT_SYMBOL_GPL(kvm_alloc_hpt_cma);
>  
> diff --git a/drivers/s390/char/vmcp.c b/drivers/s390/char/vmcp.c
> index 948ce82a7725..0fa1b6b1491a 100644
> --- a/drivers/s390/char/vmcp.c
> +++ b/drivers/s390/char/vmcp.c
> @@ -68,7 +68,7 @@ static void vmcp_response_alloc(struct vmcp_session *session)
>  	 * anymore the system won't work anyway.
>  	 */
>  	if (order > 2)
> -		page = cma_alloc(vmcp_cma, nr_pages, 0, GFP_KERNEL);
> +		page = cma_alloc(vmcp_cma, nr_pages, 0, false);
>  	if (page) {
>  		session->response = (char *)page_to_phys(page);
>  		session->cma_alloc = 1;
> diff --git a/drivers/staging/android/ion/ion_cma_heap.c b/drivers/staging/android/ion/ion_cma_heap.c
> index 49718c96bf9e..3fafd013d80a 100644
> --- a/drivers/staging/android/ion/ion_cma_heap.c
> +++ b/drivers/staging/android/ion/ion_cma_heap.c
> @@ -39,7 +39,7 @@ static int ion_cma_allocate(struct ion_heap *heap, struct ion_buffer *buffer,
>  	if (align > CONFIG_CMA_ALIGNMENT)
>  		align = CONFIG_CMA_ALIGNMENT;
>  
> -	pages = cma_alloc(cma_heap->cma, nr_pages, align, GFP_KERNEL);
> +	pages = cma_alloc(cma_heap->cma, nr_pages, align, false);
>  	if (!pages)
>  		return -ENOMEM;
>  
> diff --git a/include/linux/cma.h b/include/linux/cma.h
> index bf90f0bb42bd..190184b5ff32 100644
> --- a/include/linux/cma.h
> +++ b/include/linux/cma.h
> @@ -33,7 +33,7 @@ extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>  					const char *name,
>  					struct cma **res_cma);
>  extern struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
> -			      gfp_t gfp_mask);
> +			      bool no_warn);
>  extern bool cma_release(struct cma *cma, const struct page *pages, unsigned int count);
>  
>  extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data);
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index d987dcd1bd56..19ea5d70150c 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -191,7 +191,8 @@ struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
>  	if (align > CONFIG_CMA_ALIGNMENT)
>  		align = CONFIG_CMA_ALIGNMENT;
>  
> -	return cma_alloc(dev_get_cma_area(dev), count, align, gfp_mask);
> +	return cma_alloc(dev_get_cma_area(dev), count, align,
> +			 gfp_mask & __GFP_NOWARN);
>  }
>  
>  /**
> diff --git a/mm/cma.c b/mm/cma.c
> index 5809bbe360d7..4cb76121a3ab 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -395,13 +395,13 @@ static inline void cma_debug_show_areas(struct cma *cma) { }
>   * @cma:   Contiguous memory region for which the allocation is performed.
>   * @count: Requested number of pages.
>   * @align: Requested alignment of pages (in PAGE_SIZE order).
> - * @gfp_mask:  GFP mask to use during compaction
> + * @no_warn: Avoid printing message about failed allocation
>   *
>   * This function allocates part of contiguous memory on specific
>   * contiguous memory area.
>   */
>  struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
> -		       gfp_t gfp_mask)
> +		       bool no_warn)
>  {
>  	unsigned long mask, offset;
>  	unsigned long pfn = -1;
> @@ -447,7 +447,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>  		pfn = cma->base_pfn + (bitmap_no << cma->order_per_bit);
>  		mutex_lock(&cma_mutex);
>  		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA,
> -					 gfp_mask);
> +				     GFP_KERNEL | (no_warn ? __GFP_NOWARN : 0));
>  		mutex_unlock(&cma_mutex);
>  		if (ret == 0) {
>  			page = pfn_to_page(pfn);
> @@ -466,7 +466,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>  
>  	trace_cma_alloc(pfn, page, count, align)>  
> -	if (ret && !(gfp_mask & __GFP_NOWARN)) {
> +	if (ret && !no_warn) {
>  		pr_err("%s: alloc failed, req-size: %zu pages, ret: %d\n",
>  			__func__, count, ret);
>  		cma_debug_show_areas(cma);
> diff --git a/mm/cma_debug.c b/mm/cma_debug.c
> index f23467291cfb..ad6723e9d110 100644
> --- a/mm/cma_debug.c
> +++ b/mm/cma_debug.c
> @@ -139,7 +139,7 @@ static int cma_alloc_mem(struct cma *cma, int count)
>  	if (!mem)
>  		return -ENOMEM;
>  
> -	p = cma_alloc(cma, count, 0, GFP_KERNEL);
> +	p = cma_alloc(cma, count, 0, false);
>  	if (!p) {
>  		kfree(mem);
>  		return -ENOMEM;
> -- 
> 2.17.1
> 

-- 
Michal Hocko
SUSE Labs
