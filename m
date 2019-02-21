Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94BDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B132084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfBUSQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:16:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbfBUSQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:16:24 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4BED3082E8E;
        Thu, 21 Feb 2019 18:16:23 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A8711001DC5;
        Thu, 21 Feb 2019 18:16:21 +0000 (UTC)
Date:   Thu, 21 Feb 2019 13:16:19 -0500
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
Subject: Re: [PATCH v2 17/26] userfaultfd: wp: support swap and page migration
Message-ID: <20190221181619.GQ2813@redhat.com>
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-18-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212025632.28946-18-peterx@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 21 Feb 2019 18:16:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:56:23AM +0800, Peter Xu wrote:
> For either swap and page migration, we all use the bit 2 of the entry to
> identify whether this entry is uffd write-protected.  It plays a similar
> role as the existing soft dirty bit in swap entries but only for keeping
> the uffd-wp tracking for a specific PTE/PMD.
> 
> Something special here is that when we want to recover the uffd-wp bit
> from a swap/migration entry to the PTE bit we'll also need to take care
> of the _PAGE_RW bit and make sure it's cleared, otherwise even with the
> _PAGE_UFFD_WP bit we can't trap it at all.
> 
> Note that this patch removed two lines from "userfaultfd: wp: hook
> userfault handler to write protection fault" where we try to remove the
> VM_FAULT_WRITE from vmf->flags when uffd-wp is set for the VMA.  This
> patch will still keep the write flag there.

That part is confusing, you probably want to remove that code from
previous patch or at least address my comment in the previous patch
review.

> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/swapops.h | 2 ++
>  mm/huge_memory.c        | 3 +++
>  mm/memory.c             | 8 ++++++--
>  mm/migrate.c            | 7 +++++++
>  mm/mprotect.c           | 2 ++
>  mm/rmap.c               | 6 ++++++
>  6 files changed, 26 insertions(+), 2 deletions(-)
> 

[...]

> diff --git a/mm/memory.c b/mm/memory.c
> index c2035539e9fd..7cee990d67cf 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -736,6 +736,8 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  				pte = swp_entry_to_pte(entry);
>  				if (pte_swp_soft_dirty(*src_pte))
>  					pte = pte_swp_mksoft_dirty(pte);
> +				if (pte_swp_uffd_wp(*src_pte))
> +					pte = pte_swp_mkuffd_wp(pte);
>  				set_pte_at(src_mm, addr, src_pte, pte);
>  			}
>  		} else if (is_device_private_entry(entry)) {
> @@ -2815,8 +2817,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
>  	dec_mm_counter_fast(vma->vm_mm, MM_SWAPENTS);
>  	pte = mk_pte(page, vma->vm_page_prot);
> -	if (userfaultfd_wp(vma))
> -		vmf->flags &= ~FAULT_FLAG_WRITE;

So this is the confusing part with the previous patch that introduce
that code. It feels like you should just remove that code entirely
in the previous patch.

>  	if ((vmf->flags & FAULT_FLAG_WRITE) && reuse_swap_page(page, NULL)) {
>  		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
>  		vmf->flags &= ~FAULT_FLAG_WRITE;
> @@ -2826,6 +2826,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	flush_icache_page(vma, page);
>  	if (pte_swp_soft_dirty(vmf->orig_pte))
>  		pte = pte_mksoft_dirty(pte);
> +	if (pte_swp_uffd_wp(vmf->orig_pte)) {
> +		pte = pte_mkuffd_wp(pte);
> +		pte = pte_wrprotect(pte);
> +	}
>  	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
>  	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
>  	vmf->orig_pte = pte;

> diff --git a/mm/migrate.c b/mm/migrate.c
> index d4fd680be3b0..605ccd1f5c64 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -242,6 +242,11 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
>  		if (is_write_migration_entry(entry))
>  			pte = maybe_mkwrite(pte, vma);
>  
> +		if (pte_swp_uffd_wp(*pvmw.pte)) {
> +			pte = pte_mkuffd_wp(pte);
> +			pte = pte_wrprotect(pte);
> +		}

If the page was write protected prior to migration then it should never
end up as a write migration entry and thus the above should be something
like:
		if (is_write_migration_entry(entry)) {
			pte = maybe_mkwrite(pte, vma);
		} else if (pte_swp_uffd_wp(*pvmw.pte)) {
			pte = pte_mkuffd_wp(pte);
		}

[...]
