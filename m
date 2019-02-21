Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DE5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E052077B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbfBUQZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:25:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbfBUQZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:25:20 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E50913086275;
        Thu, 21 Feb 2019 16:25:19 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F341D282E4;
        Thu, 21 Feb 2019 16:25:12 +0000 (UTC)
Date:   Thu, 21 Feb 2019 11:25:11 -0500
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
Subject: Re: [PATCH v2 07/26] userfaultfd: wp: hook userfault handler to
 write protection fault
Message-ID: <20190221162510.GG2813@redhat.com>
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-8-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212025632.28946-8-peterx@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 21 Feb 2019 16:25:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:56:13AM +0800, Peter Xu wrote:
> From: Andrea Arcangeli <aarcange@redhat.com>
> 
> There are several cases write protection fault happens. It could be a
> write to zero page, swaped page or userfault write protected
> page. When the fault happens, there is no way to know if userfault
> write protect the page before. Here we just blindly issue a userfault
> notification for vma with VM_UFFD_WP regardless if app write protects
> it yet. Application should be ready to handle such wp fault.
> 
> v1: From: Shaohua Li <shli@fb.com>
> 
> v2: Handle the userfault in the common do_wp_page. If we get there a
> pagetable is present and readonly so no need to do further processing
> until we solve the userfault.
> 
> In the swapin case, always swapin as readonly. This will cause false
> positive userfaults. We need to decide later if to eliminate them with
> a flag like soft-dirty in the swap entry (see _PAGE_SWP_SOFT_DIRTY).
> 
> hugetlbfs wouldn't need to worry about swapouts but and tmpfs would
> be handled by a swap entry bit like anonymous memory.
> 
> The main problem with no easy solution to eliminate the false
> positives, will be if/when userfaultfd is extended to real filesystem
> pagecache. When the pagecache is freed by reclaim we can't leave the
> radix tree pinned if the inode and in turn the radix tree is reclaimed
> as well.

For real file system my generic page write protection patchset might
be of use. See my last year posting of it. I intend to repost it in
next few weeks as i am making steady progress on a cleaned and updated
version of it.

> 
> The estimation is that full accuracy and lack of false positives could
> be easily provided only to anonymous memory (as long as there's no
> fork or as long as MADV_DONTFORK is used on the userfaultfd anonymous
> range) tmpfs and hugetlbfs, it's most certainly worth to achieve it
> but in a later incremental patch.
> 
> v3: Add hooking point for THP wrprotect faults.
> 
> CC: Shaohua Li <shli@fb.com>
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

I have some comments on this patch.

> ---
>  mm/memory.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index e11ca9dd823f..00781c43407b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2483,6 +2483,11 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  
> +	if (userfaultfd_wp(vma)) {
> +		pte_unmap_unlock(vmf->pte, vmf->ptl);
> +		return handle_userfault(vmf, VM_UFFD_WP);
> +	}
> +
>  	vmf->page = vm_normal_page(vma, vmf->address, vmf->orig_pte);
>  	if (!vmf->page) {
>  		/*
> @@ -2800,6 +2805,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
>  	dec_mm_counter_fast(vma->vm_mm, MM_SWAPENTS);
>  	pte = mk_pte(page, vma->vm_page_prot);
> +	if (userfaultfd_wp(vma))
> +		vmf->flags &= ~FAULT_FLAG_WRITE;

This looks wrong to me by clearing FAULT_FLAG_WRITE you disable the
call to do_wp_page() which would have handled the userfault write
protect fault. It seems to me that you want to disable below code
path to happen so it would be better to change below

From
>  	if ((vmf->flags & FAULT_FLAG_WRITE) && reuse_swap_page(page, NULL)) {

To
>  	if (!userfaultfd_wp(vma) && (vmf->flags & FAULT_FLAG_WRITE) && reuse_swap_page(page, NULL)) {


>  		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
>  		vmf->flags &= ~FAULT_FLAG_WRITE;
> @@ -3684,8 +3691,11 @@ static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
>  /* `inline' is required to avoid gcc 4.1.2 build error */
>  static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf, pmd_t orig_pmd)
>  {
> -	if (vma_is_anonymous(vmf->vma))
> +	if (vma_is_anonymous(vmf->vma)) {
> +		if (userfaultfd_wp(vmf->vma))
> +			return handle_userfault(vmf, VM_UFFD_WP);
>  		return do_huge_pmd_wp_page(vmf, orig_pmd);
> +	}
>  	if (vmf->vma->vm_ops->huge_fault)
>  		return vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PMD);
>  
> -- 
> 2.17.1
> 
