Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753542AbeBFU3O (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 15:29:14 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:46871 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752962AbeBFU3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 15:29:05 -0500
Date: Tue, 6 Feb 2018 12:28:31 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
        mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
        benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
        sergey.senozhatsky.work@gmail.com,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
        npiggin@gmail.com, bsingharora@gmail.com,
        Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org
Subject: Re: [PATCH v7 04/24] mm: Dont assume page-table invariance during
 faults
Message-ID: <20180206202831.GB16511@bombadil.infradead.org>
References: <1517935810-31177-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1517935810-31177-5-git-send-email-ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517935810-31177-5-git-send-email-ldufour@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 05:49:50PM +0100, Laurent Dufour wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> One of the side effects of speculating on faults (without holding
> mmap_sem) is that we can race with free_pgtables() and therefore we
> cannot assume the page-tables will stick around.
> 
> Remove the reliance on the pte pointer.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> In most of the case pte_unmap_same() was returning 1, which meaning that
> do_swap_page() should do its processing. So in most of the case there will
> be no impact.
> 
> Now regarding the case where pte_unmap_safe() was returning 0, and thus
> do_swap_page return 0 too, this happens when the page has already been
> swapped back. This may happen before do_swap_page() get called or while in
> the call to do_swap_page(). In that later case, the check done when
> swapin_readahead() returns will detect that case.
> 
> The worst case would be that a page fault is occuring on 2 threads at the
> same time on the same swapped out page. In that case one thread will take
> much time looping in __read_swap_cache_async(). But in the regular page
> fault path, this is even worse since the thread would wait for semaphore to
> be released before starting anything.
> 
> [Remove only if !CONFIG_SPECULATIVE_PAGE_FAULT]
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

I have a great deal of trouble connecting all of the words above to the
contents of the patch.

>  
> +#ifndef CONFIG_SPECULATIVE_PAGE_FAULT
>  /*
>   * handle_pte_fault chooses page fault handler according to an entry which was
>   * read non-atomically.  Before making any commitment, on those architectures
> @@ -2311,6 +2312,7 @@ static inline int pte_unmap_same(struct mm_struct *mm, pmd_t *pmd,
>  	pte_unmap(page_table);
>  	return same;
>  }
> +#endif /* CONFIG_SPECULATIVE_PAGE_FAULT */
>  
>  static inline void cow_user_page(struct page *dst, struct page *src, unsigned long va, struct vm_area_struct *vma)
>  {
> @@ -2898,11 +2900,13 @@ int do_swap_page(struct vm_fault *vmf)
>  		swapcache = page;
>  	}
>  
> +#ifndef CONFIG_SPECULATIVE_PAGE_FAULT
>  	if (!pte_unmap_same(vma->vm_mm, vmf->pmd, vmf->pte, vmf->orig_pte)) {
>  		if (page)
>  			put_page(page);
>  		goto out;
>  	}
> +#endif
>  

This feels to me like we want:

#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
[current code]
#else
/*
 * Some words here which explains why we always want to return this
 * value if we support speculative page faults.
 */
static inline int pte_unmap_same(struct mm_struct *mm, pmd_t *pmd,
				pte_t *page_table, pte_t orig_pte)
{
	return 1;
}
#endif

instead of cluttering do_swap_page with an ifdef.
