Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CF1C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77FF2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbfBZFJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 00:09:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfBZFJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 00:09:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 691A583F51;
        Tue, 26 Feb 2019 05:09:57 +0000 (UTC)
Received: from xz-x1 (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F64F600C0;
        Tue, 26 Feb 2019 05:09:45 +0000 (UTC)
Date:   Tue, 26 Feb 2019 13:09:42 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
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
Subject: Re: [PATCH v2 10/26] userfaultfd: wp: add UFFDIO_COPY_MODE_WP
Message-ID: <20190226050942.GF13653@xz-x1>
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-11-peterx@redhat.com>
 <20190225155836.GD24917@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190225155836.GD24917@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 26 Feb 2019 05:09:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 05:58:37PM +0200, Mike Rapoport wrote:
> On Tue, Feb 12, 2019 at 10:56:16AM +0800, Peter Xu wrote:
> > From: Andrea Arcangeli <aarcange@redhat.com>
> > 
> > This allows UFFDIO_COPY to map pages wrprotected.
>                                        write protected please :)

Sure!

> > 
> > Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Except for two additional nits below
> 
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> 
> > ---
> >  fs/userfaultfd.c                 |  5 +++--
> >  include/linux/userfaultfd_k.h    |  2 +-
> >  include/uapi/linux/userfaultfd.h | 11 +++++-----
> >  mm/userfaultfd.c                 | 36 ++++++++++++++++++++++----------
> >  4 files changed, 35 insertions(+), 19 deletions(-)
> > 
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index b397bc3b954d..3092885c9d2c 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -1683,11 +1683,12 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
> >  	ret = -EINVAL;
> >  	if (uffdio_copy.src + uffdio_copy.len <= uffdio_copy.src)
> >  		goto out;
> > -	if (uffdio_copy.mode & ~UFFDIO_COPY_MODE_DONTWAKE)
> > +	if (uffdio_copy.mode & ~(UFFDIO_COPY_MODE_DONTWAKE|UFFDIO_COPY_MODE_WP))
> >  		goto out;
> >  	if (mmget_not_zero(ctx->mm)) {
> >  		ret = mcopy_atomic(ctx->mm, uffdio_copy.dst, uffdio_copy.src,
> > -				   uffdio_copy.len, &ctx->mmap_changing);
> > +				   uffdio_copy.len, &ctx->mmap_changing,
> > +				   uffdio_copy.mode);
> >  		mmput(ctx->mm);
> >  	} else {
> >  		return -ESRCH;
> > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> > index c6590c58ce28..765ce884cec0 100644
> > --- a/include/linux/userfaultfd_k.h
> > +++ b/include/linux/userfaultfd_k.h
> > @@ -34,7 +34,7 @@ extern vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason);
> > 
> >  extern ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
> >  			    unsigned long src_start, unsigned long len,
> > -			    bool *mmap_changing);
> > +			    bool *mmap_changing, __u64 mode);
> >  extern ssize_t mfill_zeropage(struct mm_struct *dst_mm,
> >  			      unsigned long dst_start,
> >  			      unsigned long len,
> > diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> > index 48f1a7c2f1f0..297cb044c03f 100644
> > --- a/include/uapi/linux/userfaultfd.h
> > +++ b/include/uapi/linux/userfaultfd.h
> > @@ -203,13 +203,14 @@ struct uffdio_copy {
> >  	__u64 dst;
> >  	__u64 src;
> >  	__u64 len;
> > +#define UFFDIO_COPY_MODE_DONTWAKE		((__u64)1<<0)
> >  	/*
> > -	 * There will be a wrprotection flag later that allows to map
> > -	 * pages wrprotected on the fly. And such a flag will be
> > -	 * available if the wrprotection ioctl are implemented for the
> > -	 * range according to the uffdio_register.ioctls.
> > +	 * UFFDIO_COPY_MODE_WP will map the page wrprotected on the
> > +	 * fly. UFFDIO_COPY_MODE_WP is available only if the
> > +	 * wrprotection ioctl are implemented for the range according
> 
>                              ^ is

Will fix.

> 
> > +	 * to the uffdio_register.ioctls.
> >  	 */
> > -#define UFFDIO_COPY_MODE_DONTWAKE		((__u64)1<<0)
> > +#define UFFDIO_COPY_MODE_WP			((__u64)1<<1)
> >  	__u64 mode;
> > 
> >  	/*
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index d59b5a73dfb3..73a208c5c1e7 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -25,7 +25,8 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
> >  			    struct vm_area_struct *dst_vma,
> >  			    unsigned long dst_addr,
> >  			    unsigned long src_addr,
> > -			    struct page **pagep)
> > +			    struct page **pagep,
> > +			    bool wp_copy)
> >  {
> >  	struct mem_cgroup *memcg;
> >  	pte_t _dst_pte, *dst_pte;
> > @@ -71,9 +72,9 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
> >  	if (mem_cgroup_try_charge(page, dst_mm, GFP_KERNEL, &memcg, false))
> >  		goto out_release;
> > 
> > -	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
> > -	if (dst_vma->vm_flags & VM_WRITE)
> > -		_dst_pte = pte_mkwrite(pte_mkdirty(_dst_pte));
> > +	_dst_pte = pte_mkdirty(mk_pte(page, dst_vma->vm_page_prot));
> > +	if (dst_vma->vm_flags & VM_WRITE && !wp_copy)
> > +		_dst_pte = pte_mkwrite(_dst_pte);
> > 
> >  	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
> >  	if (dst_vma->vm_file) {
> > @@ -399,7 +400,8 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
> >  						unsigned long dst_addr,
> >  						unsigned long src_addr,
> >  						struct page **page,
> > -						bool zeropage)
> > +						bool zeropage,
> > +						bool wp_copy)
> >  {
> >  	ssize_t err;
> > 
> > @@ -416,11 +418,13 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
> >  	if (!(dst_vma->vm_flags & VM_SHARED)) {
> >  		if (!zeropage)
> >  			err = mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma,
> > -					       dst_addr, src_addr, page);
> > +					       dst_addr, src_addr, page,
> > +					       wp_copy);
> >  		else
> >  			err = mfill_zeropage_pte(dst_mm, dst_pmd,
> >  						 dst_vma, dst_addr);
> >  	} else {
> > +		VM_WARN_ON(wp_copy); /* WP only available for anon */
> >  		if (!zeropage)
> >  			err = shmem_mcopy_atomic_pte(dst_mm, dst_pmd,
> >  						     dst_vma, dst_addr,
> > @@ -438,7 +442,8 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
> >  					      unsigned long src_start,
> >  					      unsigned long len,
> >  					      bool zeropage,
> > -					      bool *mmap_changing)
> > +					      bool *mmap_changing,
> > +					      __u64 mode)
> >  {
> >  	struct vm_area_struct *dst_vma;
> >  	ssize_t err;
> > @@ -446,6 +451,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
> >  	unsigned long src_addr, dst_addr;
> >  	long copied;
> >  	struct page *page;
> > +	bool wp_copy;
> > 
> >  	/*>  	 * Sanitize the command parameters:
> > @@ -502,6 +508,14 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
> >  	    dst_vma->vm_flags & VM_SHARED))
> >  		goto out_unlock;
> > 
> > +	/*
> > +	 * validate 'mode' now that we know the dst_vma: don't allow
> > +	 * a wrprotect copy if the userfaultfd didn't register as WP.
> > +	 */
> > +	wp_copy = mode & UFFDIO_COPY_MODE_WP;
> > +	if (wp_copy && !(dst_vma->vm_flags & VM_UFFD_WP))
> > +		goto out_unlock;

[1]

> > +
> >  	/*
> >  	 * If this is a HUGETLB vma, pass off to appropriate routine
> >  	 */
> 
> I think for hugetlb we should return an error if wp_copy==true.
> It might be worth adding wp_copy parameter to __mcopy_atomic_hugetlb() in
> advance and return the error from there, in a hope it will also support
> UFFD_WP some day :)

Now we should have failed even earlier if someone wants to register a
hugetlbfs VMA with UFFD_WP because now vma_can_userfault() only allows
anonymous memory for it:

static inline bool vma_can_userfault(struct vm_area_struct *vma,
				     unsigned long vm_flags)
{
	/* FIXME: add WP support to hugetlbfs and shmem */
	return vma_is_anonymous(vma) ||
		((is_vm_hugetlb_page(vma) || vma_is_shmem(vma)) &&
		 !(vm_flags & VM_UFFD_WP));
}

And, as long as a VMA is not tagged with UFFD_WP, the page copy will
fail with -EINVAL directly above at [1] when setting the wp_copy flag.
So IMHO we should have already covered the case.

Considering these, I would think we could simply postpone the changes
to __mcopy_atomic_hugetlb() until adding hugetlbfs support on uffd-wp.
Mike, what do you think?

Thanks!

-- 
Peter Xu
