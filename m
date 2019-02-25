Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2789C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937B620663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfBYPc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:32:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727515AbfBYPc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:32:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F1A49300207F;
        Mon, 25 Feb 2019 15:32:57 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 54E9C60140;
        Mon, 25 Feb 2019 15:32:41 +0000 (UTC)
Date:   Mon, 25 Feb 2019 10:32:39 -0500
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
Message-ID: <20190225153239.GB3336@redhat.com>
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-15-peterx@redhat.com>
 <20190221180423.GN2813@redhat.com>
 <20190222084603.GK8904@xz-x1>
 <20190222153508.GE7783@redhat.com>
 <20190225071336.GC28121@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225071336.GC28121@xz-x1>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 25 Feb 2019 15:32:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 03:13:36PM +0800, Peter Xu wrote:
> On Fri, Feb 22, 2019 at 10:35:09AM -0500, Jerome Glisse wrote:
> > On Fri, Feb 22, 2019 at 04:46:03PM +0800, Peter Xu wrote:
> > > On Thu, Feb 21, 2019 at 01:04:24PM -0500, Jerome Glisse wrote:
> > > > On Tue, Feb 12, 2019 at 10:56:20AM +0800, Peter Xu wrote:
> > > > > This allows uffd-wp to support write-protected pages for COW.
> > 
> > [...]
> > 
> > > > > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > > > > index 9d4433044c21..ae93721f3795 100644
> > > > > --- a/mm/mprotect.c
> > > > > +++ b/mm/mprotect.c
> > > > > @@ -77,14 +77,13 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
> > > > >  		if (pte_present(oldpte)) {
> > > > >  			pte_t ptent;
> > > > >  			bool preserve_write = prot_numa && pte_write(oldpte);
> > > > > +			struct page *page;
> > > > >  
> > > > >  			/*
> > > > >  			 * Avoid trapping faults against the zero or KSM
> > > > >  			 * pages. See similar comment in change_huge_pmd.
> > > > >  			 */
> > > > >  			if (prot_numa) {
> > > > > -				struct page *page;
> > > > > -
> > > > >  				page = vm_normal_page(vma, addr, oldpte);
> > > > >  				if (!page || PageKsm(page))
> > > > >  					continue;
> > > > > @@ -114,6 +113,46 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
> > > > >  					continue;
> > > > >  			}
> > > > >  
> > > > > +			/*
> > > > > +			 * Detect whether we'll need to COW before
> > > > > +			 * resolving an uffd-wp fault.  Note that this
> > > > > +			 * includes detection of the zero page (where
> > > > > +			 * page==NULL)
> > > > > +			 */
> > > > > +			if (uffd_wp_resolve) {
> > > > > +				/* If the fault is resolved already, skip */
> > > > > +				if (!pte_uffd_wp(*pte))
> > > > > +					continue;
> > > > > +				page = vm_normal_page(vma, addr, oldpte);
> > > > > +				if (!page || page_mapcount(page) > 1) {
> > > > 
> > > > This is wrong, if you allow page to be NULL then you gonna segfault
> > > > in wp_page_copy() down below. Are you sure you want to test for
> > > > special page ? For anonymous memory this should never happens ie
> > > > anon page always are regular page. So if you allow userfaulfd to
> > > > write protect only anonymous vma then there is no point in testing
> > > > here beside maybe a BUG_ON() just in case ...
> > > 
> > > It's majorly for zero pages where page can be NULL.  Would this be
> > > clearer:
> > > 
> > >   if (is_zero_pfn(pte_pfn(old_pte)) || (page && page_mapcount(page)))
> > > 
> > > ?
> > > 
> > > Now we treat zero pages as normal COW pages so we'll do COW here even
> > > for zero pages.  I think maybe we can do special handling on all over
> > > the places for zero pages (e.g., we don't write protect a PTE if we
> > > detected that this is the zero PFN) but I'm uncertain on whether
> > > that's what we want, so I chose to start with current solution at
> > > least to achieve functionality first.
> > 
> > You can keep the vm_normal_page() in that case but split the if
> > between page == NULL and page != NULL with mapcount > 1. As other-
> > wise you will segfault below.
> 
> Could I ask what's the segfault you mentioned?  My understanding is
> that below code has taken page==NULL into consideration already, e.g.,
> we only do get_page() if page!=NULL, and inside wp_page_copy() it has
> similar considerations.

In my memory wp_page_copy() would have freak out on NULL page but
i check that code again and it is fine. So yes you can take that
branch for NULL page too. Sorry i trusted my memory too much.


> > > > > +					struct vm_fault vmf = {
> > > > > +						.vma = vma,
> > > > > +						.address = addr & PAGE_MASK,
> > > > > +						.page = page,
> > > > > +						.orig_pte = oldpte,
> > > > > +						.pmd = pmd,
> > > > > +						/* pte and ptl not needed */
> > > > > +					};
> > > > > +					vm_fault_t ret;
> > > > > +
> > > > > +					if (page)
> > > > > +						get_page(page);
> > > > > +					arch_leave_lazy_mmu_mode();
> > > > > +					pte_unmap_unlock(pte, ptl);
> > > > > +					ret = wp_page_copy(&vmf);
> > > > > +					/* PTE is changed, or OOM */
> > > > > +					if (ret == 0)
> > > > > +						/* It's done by others */
> > > > > +						continue;
> > > > > +					else if (WARN_ON(ret != VM_FAULT_WRITE))
> > > > > +						return pages;
> > > > > +					pte = pte_offset_map_lock(vma->vm_mm,
> > > > > +								  pmd, addr,
> > > > > +								  &ptl);
> > > > 
> > > > Here you remap the pte locked but you are not checking if the pte is
> > > > the one you expect ie is it pointing to the copied page and does it
> > > > have expect uffd_wp flag. Another thread might have raced between the
> > > > time you called wp_page_copy() and the time you pte_offset_map_lock()
> > > > I have not check the mmap_sem so maybe you are protected by it as
> > > > mprotect is taking it in write mode IIRC, if so you should add a
> > > > comments at very least so people do not see this as a bug.
> > > 
> > > Thanks for spotting this.  With nornal uffd-wp page fault handling
> > > path we're only with read lock held (and I would suspect it's racy
> > > even with write lock...).  I agree that there can be a race right
> > > after the COW has done.
> > > 
> > > Here IMHO we'll be fine as long as it's still a present PTE, in other
> > > words, we should be able to tolerate PTE changes as long as it's still
> > > present otherwise we'll need to retry this single PTE (e.g., the page
> > > can be quickly marked as migrating swap entry, or even the page could
> > > be freed beneath us).  Do you think below change look good to you to
> > > be squashed into this patch?
> > 
> > Ok, but below if must be after arch_enter_lazy_mmu_mode(); not before.
> 
> Oops... you are right. :)
> 
> Thanks,
> 
> > 
> > > 
> > > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > > index 73a65f07fe41..3423f9692838 100644
> > > --- a/mm/mprotect.c
> > > +++ b/mm/mprotect.c
> > > @@ -73,6 +73,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,                                                              
> > >         flush_tlb_batched_pending(vma->vm_mm);
> > >         arch_enter_lazy_mmu_mode();
> > >         do {
> > > +retry_pte:
> > >                 oldpte = *pte;
> > >                 if (pte_present(oldpte)) {
> > >                         pte_t ptent;
> > > @@ -149,6 +150,13 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,                                                           
> > >                                         pte = pte_offset_map_lock(vma->vm_mm,
> > >                                                                   pmd, addr,
> > >                                                                   &ptl);
> > > +                                       if (!pte_present(*pte))
> > > +                                               /*
> > > +                                                * This PTE could have
> > > +                                                * been modified when COW;
> > > +                                                * retry it
> > > +                                                */
> > > +                                               goto retry_pte;
> > >                                         arch_enter_lazy_mmu_mode();
> > >                                 }
> > >                         }
> 
> -- 
> Peter Xu
