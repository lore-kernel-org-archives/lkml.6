Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A1AC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B092A20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbfAUOF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:05:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:5857 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729659AbfAUOFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:05:55 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2076F80F98;
        Mon, 21 Jan 2019 14:05:54 +0000 (UTC)
Received: from redhat.com (ovpn-122-5.rdu2.redhat.com [10.10.122.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CE6156873A;
        Mon, 21 Jan 2019 14:05:38 +0000 (UTC)
Date:   Mon, 21 Jan 2019 09:05:35 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Emelyanov <xemul@parallels.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH RFC 06/24] userfaultfd: wp: support write protection for
 userfault vma range
Message-ID: <20190121140535.GD3344@redhat.com>
References: <20190121075722.7945-1-peterx@redhat.com>
 <20190121075722.7945-7-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190121075722.7945-7-peterx@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 21 Jan 2019 14:05:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 03:57:04PM +0800, Peter Xu wrote:
> From: Shaohua Li <shli@fb.com>
> 
> Add API to enable/disable writeprotect a vma range. Unlike mprotect,
> this doesn't split/merge vmas.

AFAICT it does not do that.

> 
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Pavel Emelyanov <xemul@parallels.com>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Shaohua Li <shli@fb.com>
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/userfaultfd_k.h |  2 ++
>  mm/userfaultfd.c              | 52 +++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index 38f748e7186e..e82f3156f4e9 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -37,6 +37,8 @@ extern ssize_t mfill_zeropage(struct mm_struct *dst_mm,
>  			      unsigned long dst_start,
>  			      unsigned long len,
>  			      bool *mmap_changing);
> +extern int mwriteprotect_range(struct mm_struct *dst_mm,
> +		unsigned long start, unsigned long len, bool enable_wp);
>  
>  /* mm helpers */
>  static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 458acda96f20..c38903f501c7 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -615,3 +615,55 @@ ssize_t mfill_zeropage(struct mm_struct *dst_mm, unsigned long start,
>  {
>  	return __mcopy_atomic(dst_mm, start, 0, len, true, mmap_changing);
>  }
> +
> +int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
> +	unsigned long len, bool enable_wp)
> +{
> +	struct vm_area_struct *dst_vma;
> +	pgprot_t newprot;
> +	int err;
> +
> +	/*
> +	 * Sanitize the command parameters:
> +	 */
> +	BUG_ON(start & ~PAGE_MASK);
> +	BUG_ON(len & ~PAGE_MASK);
> +
> +	/* Does the address range wrap, or is the span zero-sized? */
> +	BUG_ON(start + len <= start);
> +
> +	down_read(&dst_mm->mmap_sem);
> +
> +	/*
> +	 * Make sure the vma is not shared, that the dst range is
> +	 * both valid and fully within a single existing vma.
> +	 */
> +	err = -EINVAL;
> +	dst_vma = find_vma(dst_mm, start);
> +	if (!dst_vma || (dst_vma->vm_flags & VM_SHARED))
> +		goto out_unlock;
> +	if (start < dst_vma->vm_start ||
> +	    start + len > dst_vma->vm_end)
> +		goto out_unlock;
> +
> +	if (!dst_vma->vm_userfaultfd_ctx.ctx)
> +		goto out_unlock;
> +	if (!userfaultfd_wp(dst_vma))
> +		goto out_unlock;
> +
> +	if (!vma_is_anonymous(dst_vma))
> +		goto out_unlock;
> +
> +	if (enable_wp)
> +		newprot = vm_get_page_prot(dst_vma->vm_flags & ~(VM_WRITE));
> +	else
> +		newprot = vm_get_page_prot(dst_vma->vm_flags);
> +
> +	change_protection(dst_vma, start, start + len, newprot,
> +				!enable_wp, 0);

So setting dirty_accountable bring us to that code in mprotect.c:

    if (dirty_accountable && pte_dirty(ptent) &&
            (pte_soft_dirty(ptent) ||
             !(vma->vm_flags & VM_SOFTDIRTY))) {
        ptent = pte_mkwrite(ptent);
    }

My understanding is that you want to set write flag when enable_wp
is false and you want to set the write flag unconditionaly, right ?

If so then you should really move the change_protection() flags
patch before this patch and add a flag for setting pte write flags.

Otherwise the above is broken at it will only set the write flag
for pte that were dirty and i am guessing so far you always were
lucky because pte were all dirty (change_protection will preserve
dirtyness) when you write protected them.

So i believe the above is broken or at very least unclear if what
you really want is to only set write flag to pte that have the
dirty flag set.


Cheers,
Jérôme


> +
> +	err = 0;
> +out_unlock:
> +	up_read(&dst_mm->mmap_sem);
> +	return err;
> +}
> -- 
> 2.17.1
> 
