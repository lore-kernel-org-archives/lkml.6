Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF824C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE85320652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE85320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeJBSJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:09:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:54189 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbeJBSJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:09:14 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2018 04:26:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,331,1534834800"; 
   d="scan'208";a="75493044"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 02 Oct 2018 04:26:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 5817D161; Tue,  2 Oct 2018 14:26:23 +0300 (EEST)
Date:   Tue, 2 Oct 2018 14:26:23 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHv3 6/6] mm/gup: Cache dev_pagemap while pinning pages
Message-ID: <20181002112623.zlxtcclhtslfx3pa@black.fi.intel.com>
References: <20180921223956.3485-1-keith.busch@intel.com>
 <20180921223956.3485-7-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921223956.3485-7-keith.busch@intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 10:39:56PM +0000, Keith Busch wrote:
> Pinning pages from ZONE_DEVICE memory needs to check the backing device's
> live-ness, which is tracked in the device's dev_pagemap metadata. This
> metadata is stored in a radix tree and looking it up adds measurable
> software overhead.
> 
> This patch avoids repeating this relatively costly operation when
> dev_pagemap is used by caching the last dev_pagemap when getting user
> pages. The gup_benchmark reports this reduces the time to get user pages
> to as low as 1/3 of the previous time.
> 
> The cached value is combined with other output parameters into a context
> struct to keep the parameters fewer.
> 
> Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---

....

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a61ebe8ad4ca..79c80496dd50 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2534,15 +2534,28 @@ static inline vm_fault_t vmf_error(int err)
>  	return VM_FAULT_SIGBUS;
>  }
>  
> +struct follow_page_context {
> +	struct dev_pagemap *pgmap;
> +	unsigned int page_mask;
> +};
> +
>  struct page *follow_page_mask(struct vm_area_struct *vma,
>  			      unsigned long address, unsigned int foll_flags,
> -			      unsigned int *page_mask);
> +			      struct follow_page_context *ctx);
>  
>  static inline struct page *follow_page(struct vm_area_struct *vma,
>  		unsigned long address, unsigned int foll_flags)
>  {
> -	unsigned int unused_page_mask;
> -	return follow_page_mask(vma, address, foll_flags, &unused_page_mask);
> +	struct page *page;
> +	struct follow_page_context ctx = {
> +		.pgmap = NULL,
> +		.page_mask = 0,
> +	};
> +
> +	page = follow_page_mask(vma, address, foll_flags, &ctx);
> +	if (ctx.pgmap)
> +		put_dev_pagemap(ctx.pgmap);
> +	return page;
>  }

Do we still want to keep the function as inline? I don't think so.
Let's move it into mm/gup.c and make struct follow_page_context private to
the file.

>  
>  #define FOLL_WRITE	0x01	/* check pte is writable */
> diff --git a/mm/gup.c b/mm/gup.c
> index 1abc8b4afff6..124e7293e381 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -71,10 +71,10 @@ static inline bool can_follow_write_pte(pte_t pte, unsigned int flags)
>  }
>  
>  static struct page *follow_page_pte(struct vm_area_struct *vma,
> -		unsigned long address, pmd_t *pmd, unsigned int flags)
> +		unsigned long address, pmd_t *pmd, unsigned int flags,
> +		struct dev_pagemap **pgmap)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
> -	struct dev_pagemap *pgmap = NULL;
>  	struct page *page;
>  	spinlock_t *ptl;
>  	pte_t *ptep, pte;
> @@ -116,8 +116,8 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
>  		 * Only return device mapping pages in the FOLL_GET case since
>  		 * they are only valid while holding the pgmap reference.
>  		 */
> -		pgmap = get_dev_pagemap(pte_pfn(pte), NULL);
> -		if (pgmap)
> +		*pgmap = get_dev_pagemap(pte_pfn(pte), *pgmap);
> +		if (*pgmap)
>  			page = pte_page(pte);
>  		else
>  			goto no_page;

Hm. Shouldn't get_dev_pagemap() call be under if (!*pgmap)?

... ah, never mind. I've got confused by get_dev_pagemap() interface.

>  static bool vma_permits_fault(struct vm_area_struct *vma,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 533f9b00147d..9839bf91b057 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -851,13 +851,23 @@ static void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
>  		update_mmu_cache_pmd(vma, addr, pmd);
>  }
>  
> +static struct page *pagemap_page(unsigned long pfn, struct dev_pagemap **pgmap)

The function name doesn't reflect the fact that it takes pin on the page.
Maybe pagemap_get_page()?

> +{
> +	struct page *page;
> +
> +	*pgmap = get_dev_pagemap(pfn, *pgmap);
> +	if (!*pgmap)
> +		return ERR_PTR(-EFAULT);
> +	page = pfn_to_page(pfn);
> +	get_page(page);
> +	return page;
> +}
> +

-- 
 Kirill A. Shutemov
