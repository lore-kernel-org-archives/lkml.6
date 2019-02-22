Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF26C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B8C20823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfBVHbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 02:31:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbfBVHbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 02:31:50 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 28B593082B6C;
        Fri, 22 Feb 2019 07:31:49 +0000 (UTC)
Received: from xz-x1 (ovpn-12-57.pek2.redhat.com [10.72.12.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B7C05600C2;
        Fri, 22 Feb 2019 07:31:38 +0000 (UTC)
Date:   Fri, 22 Feb 2019 15:31:35 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Jerome Glisse <jglisse@redhat.com>
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
Subject: Re: [PATCH v2 12/26] userfaultfd: wp: apply _PAGE_UFFD_WP bit
Message-ID: <20190222073135.GJ8904@xz-x1>
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-13-peterx@redhat.com>
 <20190221174401.GL2813@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190221174401.GL2813@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 22 Feb 2019 07:31:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 12:44:02PM -0500, Jerome Glisse wrote:
> On Tue, Feb 12, 2019 at 10:56:18AM +0800, Peter Xu wrote:
> > Firstly, introduce two new flags MM_CP_UFFD_WP[_RESOLVE] for
> > change_protection() when used with uffd-wp and make sure the two new
> > flags are exclusively used.  Then,
> > 
> >   - For MM_CP_UFFD_WP: apply the _PAGE_UFFD_WP bit and remove _PAGE_RW
> >     when a range of memory is write protected by uffd
> > 
> >   - For MM_CP_UFFD_WP_RESOLVE: remove the _PAGE_UFFD_WP bit and recover
> >     _PAGE_RW when write protection is resolved from userspace
> > 
> > And use this new interface in mwriteprotect_range() to replace the old
> > MM_CP_DIRTY_ACCT.
> > 
> > Do this change for both PTEs and huge PMDs.  Then we can start to
> > identify which PTE/PMD is write protected by general (e.g., COW or soft
> > dirty tracking), and which is for userfaultfd-wp.
> > 
> > Since we should keep the _PAGE_UFFD_WP when doing pte_modify(), add it
> > into _PAGE_CHG_MASK as well.  Meanwhile, since we have this new bit, we
> > can be even more strict when detecting uffd-wp page faults in either
> > do_wp_page() or wp_huge_pmd().
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Few comments but still:
> 
> Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

Thanks!

> 
> > ---
> >  arch/x86/include/asm/pgtable_types.h |  2 +-
> >  include/linux/mm.h                   |  5 +++++
> >  mm/huge_memory.c                     | 14 +++++++++++++-
> >  mm/memory.c                          |  4 ++--
> >  mm/mprotect.c                        | 12 ++++++++++++
> >  mm/userfaultfd.c                     |  8 ++++++--
> >  6 files changed, 39 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> > index 8cebcff91e57..dd9c6295d610 100644
> > --- a/arch/x86/include/asm/pgtable_types.h
> > +++ b/arch/x86/include/asm/pgtable_types.h
> > @@ -133,7 +133,7 @@
> >   */
> >  #define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		\
> >  			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |	\
> > -			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP)
> > +			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP | _PAGE_UFFD_WP)
> >  #define _HPAGE_CHG_MASK (_PAGE_CHG_MASK | _PAGE_PSE)
> 
> This chunk needs to be in the earlier arch specific patch.

Indeed.  I'll move it over.

> 
> [...]
> 
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 8d65b0f041f9..817335b443c2 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> 
> [...]
> 
> > @@ -2198,6 +2208,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
> >  				entry = pte_mkold(entry);
> >  			if (soft_dirty)
> >  				entry = pte_mksoft_dirty(entry);
> > +			if (uffd_wp)
> > +				entry = pte_mkuffd_wp(entry);
> >  		}
> >  		pte = pte_offset_map(&_pmd, addr);
> >  		BUG_ON(!pte_none(*pte));
> 
> Reading that code and i thought i would be nice if we could define a
> pte_mask that we can or instead of all those if () entry |= ... but
> that is just some dumb optimization and does not have any bearing on
> the present patch. Just wanted to say that outloud.

(I agree; though I'll just concentrate on the series for now)

> 
> 
> > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > index a6ba448c8565..9d4433044c21 100644
> > --- a/mm/mprotect.c
> > +++ b/mm/mprotect.c
> > @@ -46,6 +46,8 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
> >  	int target_node = NUMA_NO_NODE;
> >  	bool dirty_accountable = cp_flags & MM_CP_DIRTY_ACCT;
> >  	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
> > +	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
> > +	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
> >  
> >  	/*
> >  	 * Can be called with only the mmap_sem for reading by
> > @@ -117,6 +119,14 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
> >  			if (preserve_write)
> >  				ptent = pte_mk_savedwrite(ptent);
> >  
> > +			if (uffd_wp) {
> > +				ptent = pte_wrprotect(ptent);
> > +				ptent = pte_mkuffd_wp(ptent);
> > +			} else if (uffd_wp_resolve) {
> > +				ptent = pte_mkwrite(ptent);
> > +				ptent = pte_clear_uffd_wp(ptent);
> > +			}
> > +
> >  			/* Avoid taking write faults for known dirty pages */
> >  			if (dirty_accountable && pte_dirty(ptent) &&
> >  					(pte_soft_dirty(ptent) ||
> > @@ -301,6 +311,8 @@ unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
> >  {
> >  	unsigned long pages;
> >  
> > +	BUG_ON((cp_flags & MM_CP_UFFD_WP_ALL) == MM_CP_UFFD_WP_ALL);
> 
> Don't you want to abort and return here if both flags are set ?

Here I would slightly prefer BUG_ON() because current code (any
userspace syscalls) cannot trigger this without changing the kernel
(currently the only kernel user of these two flags will be
mwriteprotect_range but it'll definitely only pass one flag in).  This
line will be only useful when we add new kernel code (or writting new
kernel drivers) and it can be used to detect programming errors. In
that case IMHO BUG_ON() would be more straightforward.

Thanks,

-- 
Peter Xu
