Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC70C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E921B21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfBTTYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 14:24:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:59839 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfBTTYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 14:24:06 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 11:24:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,392,1544515200"; 
   d="scan'208";a="127998904"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga003.jf.intel.com with ESMTP; 20 Feb 2019 11:24:04 -0800
Date:   Wed, 20 Feb 2019 11:24:05 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     john.hubbard@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 4/6] mm/gup: track gup-pinned pages
Message-ID: <20190220192405.GA12114@iweiny-DESK2.sc.intel.com>
References: <20190204052135.25784-1-jhubbard@nvidia.com>
 <20190204052135.25784-5-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204052135.25784-5-jhubbard@nvidia.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 03, 2019 at 09:21:33PM -0800, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 

[snip]

>  
> +/*
> + * GUP_PIN_COUNTING_BIAS, and the associated functions that use it, overload
> + * the page's refcount so that two separate items are tracked: the original page
> + * reference count, and also a new count of how many get_user_pages() calls were
> + * made against the page. ("gup-pinned" is another term for the latter).
> + *
> + * With this scheme, get_user_pages() becomes special: such pages are marked
> + * as distinct from normal pages. As such, the new put_user_page() call (and
> + * its variants) must be used in order to release gup-pinned pages.
> + *
> + * Choice of value:
> + *
> + * By making GUP_PIN_COUNTING_BIAS a power of two, debugging of page reference
> + * counts with respect to get_user_pages() and put_user_page() becomes simpler,
> + * due to the fact that adding an even power of two to the page refcount has
> + * the effect of using only the upper N bits, for the code that counts up using
> + * the bias value. This means that the lower bits are left for the exclusive
> + * use of the original code that increments and decrements by one (or at least,
> + * by much smaller values than the bias value).
> + *
> + * Of course, once the lower bits overflow into the upper bits (and this is
> + * OK, because subtraction recovers the original values), then visual inspection
> + * no longer suffices to directly view the separate counts. However, for normal
> + * applications that don't have huge page reference counts, this won't be an
> + * issue.
> + *
> + * This has to work on 32-bit as well as 64-bit systems. In the more constrained
> + * 32-bit systems, the 10 bit value of the bias value leaves 22 bits for the
> + * upper bits. Therefore, only about 4M calls to get_user_page() may occur for
> + * a page.
> + *
> + * Locking: the lockless algorithm described in page_cache_gup_pin_speculative()
> + * and page_cache_gup_pin_speculative() provides safe operation for

Did you mean:

page_cache_gup_pin_speculative and __ page_cache_get_speculative __?

Just found this while looking at your branch.

Sorry,
Ira

> + * get_user_pages and page_mkclean and other calls that race to set up page
> + * table entries.
> + */
> +#define GUP_PIN_COUNTING_BIAS (1UL << 10)
> +
> +int get_gup_pin_page(struct page *page);
> +
> +void put_user_page(struct page *page);
> +void put_user_pages_dirty(struct page **pages, unsigned long npages);
> +void put_user_pages_dirty_lock(struct page **pages, unsigned long npages);
> +void put_user_pages(struct page **pages, unsigned long npages);
> +
> +/**
> + * page_gup_pinned() - report if a page is gup-pinned (pinned by a call to
> + *			get_user_pages).
> + * @page:	pointer to page to be queried.
> + * @Returns:	True, if it is likely that the page has been "gup-pinned".
> + *		False, if the page is definitely not gup-pinned.
> + */
> +static inline bool page_gup_pinned(struct page *page)
> +{
> +	return (page_ref_count(page)) > GUP_PIN_COUNTING_BIAS;
> +}
> +
>  static inline void get_page(struct page *page)
>  {
>  	page = compound_head(page);
> @@ -993,30 +1050,6 @@ static inline void put_page(struct page *page)
>  		__put_page(page);
>  }
>  
> -/**
> - * put_user_page() - release a gup-pinned page
> - * @page:            pointer to page to be released
> - *
> - * Pages that were pinned via get_user_pages*() must be released via
> - * either put_user_page(), or one of the put_user_pages*() routines
> - * below. This is so that eventually, pages that are pinned via
> - * get_user_pages*() can be separately tracked and uniquely handled. In
> - * particular, interactions with RDMA and filesystems need special
> - * handling.
> - *
> - * put_user_page() and put_page() are not interchangeable, despite this early
> - * implementation that makes them look the same. put_user_page() calls must
> - * be perfectly matched up with get_user_page() calls.
> - */
> -static inline void put_user_page(struct page *page)
> -{
> -	put_page(page);
> -}
> -
> -void put_user_pages_dirty(struct page **pages, unsigned long npages);
> -void put_user_pages_dirty_lock(struct page **pages, unsigned long npages);
> -void put_user_pages(struct page **pages, unsigned long npages);
> -
>  #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
>  #define SECTION_IN_PAGE_FLAGS
>  #endif
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 5c8a9b59cbdc..5f5b72ba595f 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -209,6 +209,11 @@ static inline int page_cache_add_speculative(struct page *page, int count)
>  	return __page_cache_add_speculative(page, count);
>  }
>  
> +static inline int page_cache_gup_pin_speculative(struct page *page)
> +{
> +	return __page_cache_add_speculative(page, GUP_PIN_COUNTING_BIAS);
> +}
> +
>  #ifdef CONFIG_NUMA
>  extern struct page *__page_cache_alloc(gfp_t gfp);
>  #else
> diff --git a/mm/gup.c b/mm/gup.c
> index 05acd7e2eb22..3291da342f9c 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -25,6 +25,26 @@ struct follow_page_context {
>  	unsigned int page_mask;
>  };
>  
> +/**
> + * get_gup_pin_page() - mark a page as being used by get_user_pages().
> + * @page:	pointer to page to be marked
> + * @Returns:	0 for success, -EOVERFLOW if the page refcount would have
> + *		overflowed.
> + *
> + */
> +int get_gup_pin_page(struct page *page)
> +{
> +	page = compound_head(page);
> +
> +	if (page_ref_count(page) >= (UINT_MAX - GUP_PIN_COUNTING_BIAS)) {
> +		WARN_ONCE(1, "get_user_pages pin count overflowed");
> +		return -EOVERFLOW;
> +	}
> +
> +	page_ref_add(page, GUP_PIN_COUNTING_BIAS);
> +	return 0;
> +}
> +
>  static struct page *no_page_table(struct vm_area_struct *vma,
>  		unsigned int flags)
>  {
> @@ -157,8 +177,14 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
>  		goto retry;
>  	}
>  
> -	if (flags & FOLL_GET)
> -		get_page(page);
> +	if (flags & FOLL_GET) {
> +		int ret = get_gup_pin_page(page);
> +
> +		if (ret) {
> +			page = ERR_PTR(ret);
> +			goto out;
> +		}
> +	}
>  	if (flags & FOLL_TOUCH) {
>  		if ((flags & FOLL_WRITE) &&
>  		    !pte_dirty(pte) && !PageDirty(page))
> @@ -497,7 +523,10 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
>  		if (is_device_public_page(*page))
>  			goto unmap;
>  	}
> -	get_page(*page);
> +
> +	ret = get_gup_pin_page(*page);
> +	if (ret)
> +		goto unmap;
>  out:
>  	ret = 0;
>  unmap:
> @@ -1429,11 +1458,11 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>  		page = pte_page(pte);
>  		head = compound_head(page);
>  
> -		if (!page_cache_get_speculative(head))
> +		if (!page_cache_gup_pin_speculative(head))
>  			goto pte_unmap;
>  
>  		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
> -			put_page(head);
> +			put_user_page(head);
>  			goto pte_unmap;
>  		}
>  
> @@ -1488,7 +1517,11 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
>  		}
>  		SetPageReferenced(page);
>  		pages[*nr] = page;
> -		get_page(page);
> +		if (get_gup_pin_page(page)) {
> +			undo_dev_pagemap(nr, nr_start, pages);
> +			return 0;
> +		}
> +
>  		(*nr)++;
>  		pfn++;
>  	} while (addr += PAGE_SIZE, addr != end);
> @@ -1569,15 +1602,14 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>  	} while (addr += PAGE_SIZE, addr != end);
>  
>  	head = compound_head(pmd_page(orig));
> -	if (!page_cache_add_speculative(head, refs)) {
> +	if (!page_cache_gup_pin_speculative(head)) {
>  		*nr -= refs;
>  		return 0;
>  	}
>  
>  	if (unlikely(pmd_val(orig) != pmd_val(*pmdp))) {
>  		*nr -= refs;
> -		while (refs--)
> -			put_page(head);
> +		put_user_page(head);
>  		return 0;
>  	}
>  
> @@ -1607,15 +1639,14 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
>  	} while (addr += PAGE_SIZE, addr != end);
>  
>  	head = compound_head(pud_page(orig));
> -	if (!page_cache_add_speculative(head, refs)) {
> +	if (!page_cache_gup_pin_speculative(head)) {
>  		*nr -= refs;
>  		return 0;
>  	}
>  
>  	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
>  		*nr -= refs;
> -		while (refs--)
> -			put_page(head);
> +		put_user_page(head);
>  		return 0;
>  	}
>  
> @@ -1644,15 +1675,14 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
>  	} while (addr += PAGE_SIZE, addr != end);
>  
>  	head = compound_head(pgd_page(orig));
> -	if (!page_cache_add_speculative(head, refs)) {
> +	if (!page_cache_gup_pin_speculative(head)) {
>  		*nr -= refs;
>  		return 0;
>  	}
>  
>  	if (unlikely(pgd_val(orig) != pgd_val(*pgdp))) {
>  		*nr -= refs;
> -		while (refs--)
> -			put_page(head);
> +		put_user_page(head);
>  		return 0;
>  	}
>  
> diff --git a/mm/swap.c b/mm/swap.c
> index 7c42ca45bb89..39b0ddd35933 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -133,6 +133,27 @@ void put_pages_list(struct list_head *pages)
>  }
>  EXPORT_SYMBOL(put_pages_list);
>  
> +/**
> + * put_user_page() - release a gup-pinned page
> + * @page:            pointer to page to be released
> + *
> + * Pages that were pinned via get_user_pages*() must be released via
> + * either put_user_page(), or one of the put_user_pages*() routines
> + * below. This is so that eventually, pages that are pinned via
> + * get_user_pages*() can be separately tracked and uniquely handled. In
> + * particular, interactions with RDMA and filesystems need special
> + * handling.
> + */
> +void put_user_page(struct page *page)
> +{
> +	page = compound_head(page);
> +
> +	VM_BUG_ON_PAGE(page_ref_count(page) < GUP_PIN_COUNTING_BIAS, page);
> +
> +	page_ref_sub(page, GUP_PIN_COUNTING_BIAS);
> +}
> +EXPORT_SYMBOL(put_user_page);
> +
>  typedef int (*set_dirty_func)(struct page *page);
>  
>  static void __put_user_pages_dirty(struct page **pages,
> -- 
> 2.20.1
> 
