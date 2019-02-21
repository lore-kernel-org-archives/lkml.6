Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155E5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F342083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbfBUSEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:04:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728554AbfBUSEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:04:33 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E921307DAC1;
        Thu, 21 Feb 2019 18:04:32 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 017945C297;
        Thu, 21 Feb 2019 18:04:25 +0000 (UTC)
Date:   Thu, 21 Feb 2019 13:04:24 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>, Shaohua Li <shli@fb.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 14/26] userfaultfd: wp: handle COW properly for uffd-wp
Message-ID: <20190221180423.GN2813@redhat.com>
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-15-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212025632.28946-15-peterx@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 21 Feb 2019 18:04:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:56:20AM +0800, Peter Xu wrote:
> This allows uffd-wp to support write-protected pages for COW.
> 
> For example, the uffd write-protected PTE could also be write-protected
> by other usages like COW or zero pages.  When that happens, we can't
> simply set the write bit in the PTE since otherwise it'll change the
> content of every single reference to the page.  Instead, we should do
> the COW first if necessary, then handle the uffd-wp fault.
> 
> To correctly copy the page, we'll also need to carry over the
> _PAGE_UFFD_WP bit if it was set in the original PTE.
> 
> For huge PMDs, we just simply split the huge PMDs where we want to
> resolve an uffd-wp page fault always.  That matches what we do with
> general huge PMD write protections.  In that way, we resolved the huge
> PMD copy-on-write issue into PTE copy-on-write.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Few comments see below.

> ---
>  mm/memory.c   |  2 ++
>  mm/mprotect.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 54 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 32d32b6e6339..b5d67bafae35 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2291,6 +2291,8 @@ vm_fault_t wp_page_copy(struct vm_fault *vmf)
>  		}
>  		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
>  		entry = mk_pte(new_page, vma->vm_page_prot);
> +		if (pte_uffd_wp(vmf->orig_pte))
> +			entry = pte_mkuffd_wp(entry);
>  		entry = maybe_mkwrite(pte_mkdirty(entry), vma);

This looks wrong to me, isn't the uffd_wp flag clear on writeable pte ?
If so it would be clearer to have something like:

 +		if (pte_uffd_wp(vmf->orig_pte))
 +			entry = pte_mkuffd_wp(entry);
 +		else
 + 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 -		entry = maybe_mkwrite(pte_mkdirty(entry), vma);

>  		/*
>  		 * Clear the pte entry and flush it first, before updating the
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 9d4433044c21..ae93721f3795 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -77,14 +77,13 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  		if (pte_present(oldpte)) {
>  			pte_t ptent;
>  			bool preserve_write = prot_numa && pte_write(oldpte);
> +			struct page *page;
>  
>  			/*
>  			 * Avoid trapping faults against the zero or KSM
>  			 * pages. See similar comment in change_huge_pmd.
>  			 */
>  			if (prot_numa) {
> -				struct page *page;
> -
>  				page = vm_normal_page(vma, addr, oldpte);
>  				if (!page || PageKsm(page))
>  					continue;
> @@ -114,6 +113,46 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  					continue;
>  			}
>  
> +			/*
> +			 * Detect whether we'll need to COW before
> +			 * resolving an uffd-wp fault.  Note that this
> +			 * includes detection of the zero page (where
> +			 * page==NULL)
> +			 */
> +			if (uffd_wp_resolve) {
> +				/* If the fault is resolved already, skip */
> +				if (!pte_uffd_wp(*pte))
> +					continue;
> +				page = vm_normal_page(vma, addr, oldpte);
> +				if (!page || page_mapcount(page) > 1) {

This is wrong, if you allow page to be NULL then you gonna segfault
in wp_page_copy() down below. Are you sure you want to test for
special page ? For anonymous memory this should never happens ie
anon page always are regular page. So if you allow userfaulfd to
write protect only anonymous vma then there is no point in testing
here beside maybe a BUG_ON() just in case ...

> +					struct vm_fault vmf = {
> +						.vma = vma,
> +						.address = addr & PAGE_MASK,
> +						.page = page,
> +						.orig_pte = oldpte,
> +						.pmd = pmd,
> +						/* pte and ptl not needed */
> +					};
> +					vm_fault_t ret;
> +
> +					if (page)
> +						get_page(page);
> +					arch_leave_lazy_mmu_mode();
> +					pte_unmap_unlock(pte, ptl);
> +					ret = wp_page_copy(&vmf);
> +					/* PTE is changed, or OOM */
> +					if (ret == 0)
> +						/* It's done by others */
> +						continue;
> +					else if (WARN_ON(ret != VM_FAULT_WRITE))
> +						return pages;
> +					pte = pte_offset_map_lock(vma->vm_mm,
> +								  pmd, addr,
> +								  &ptl);

Here you remap the pte locked but you are not checking if the pte is
the one you expect ie is it pointing to the copied page and does it
have expect uffd_wp flag. Another thread might have raced between the
time you called wp_page_copy() and the time you pte_offset_map_lock()
I have not check the mmap_sem so maybe you are protected by it as
mprotect is taking it in write mode IIRC, if so you should add a
comments at very least so people do not see this as a bug.


> +					arch_enter_lazy_mmu_mode();
> +				}
> +			}
> +
>  			ptent = ptep_modify_prot_start(mm, addr, pte);
>  			ptent = pte_modify(ptent, newprot);
>  			if (preserve_write)
> @@ -183,6 +222,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
>  	unsigned long pages = 0;
>  	unsigned long nr_huge_updates = 0;
>  	struct mmu_notifier_range range;
> +	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
>  
>  	range.start = 0;
>  
> @@ -202,7 +242,16 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
>  		}
>  
>  		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
> -			if (next - addr != HPAGE_PMD_SIZE) {
> +			/*
> +			 * When resolving an userfaultfd write
> +			 * protection fault, it's not easy to identify
> +			 * whether a THP is shared with others and
> +			 * whether we'll need to do copy-on-write, so
> +			 * just split it always for now to simply the
> +			 * procedure.  And that's the policy too for
> +			 * general THP write-protect in af9e4d5f2de2.
> +			 */
> +			if (next - addr != HPAGE_PMD_SIZE || uffd_wp_resolve) {

Using parenthesis maybe ? :)
            if ((next - addr != HPAGE_PMD_SIZE) || uffd_wp_resolve) {
