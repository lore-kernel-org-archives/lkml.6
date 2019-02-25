Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5387EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179EF20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfBYGqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 01:46:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfBYGqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 01:46:00 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9008F5945F;
        Mon, 25 Feb 2019 06:45:59 +0000 (UTC)
Received: from xz-x1 (ovpn-12-105.pek2.redhat.com [10.72.12.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B8ACB5C221;
        Mon, 25 Feb 2019 06:45:50 +0000 (UTC)
Date:   Mon, 25 Feb 2019 14:45:47 +0800
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
Subject: Re: [PATCH v2 10/26] userfaultfd: wp: add UFFDIO_COPY_MODE_WP
Message-ID: <20190225064547.GB28121@xz-x1>
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-11-peterx@redhat.com>
 <20190221172919.GJ2813@redhat.com>
 <20190222071106.GI8904@xz-x1>
 <20190222151546.GC7783@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190222151546.GC7783@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 25 Feb 2019 06:45:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 10:15:47AM -0500, Jerome Glisse wrote:
> On Fri, Feb 22, 2019 at 03:11:06PM +0800, Peter Xu wrote:
> > On Thu, Feb 21, 2019 at 12:29:19PM -0500, Jerome Glisse wrote:
> > > On Tue, Feb 12, 2019 at 10:56:16AM +0800, Peter Xu wrote:
> > > > From: Andrea Arcangeli <aarcange@redhat.com>
> > > > 
> > > > This allows UFFDIO_COPY to map pages wrprotected.
> > > > 
> > > > Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > 
> > > Minor nitpick down below, but in any case:
> > > 
> > > Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> > > 
> > > > ---
> > > >  fs/userfaultfd.c                 |  5 +++--
> > > >  include/linux/userfaultfd_k.h    |  2 +-
> > > >  include/uapi/linux/userfaultfd.h | 11 +++++-----
> > > >  mm/userfaultfd.c                 | 36 ++++++++++++++++++++++----------
> > > >  4 files changed, 35 insertions(+), 19 deletions(-)
> > > > 
> > > 
> > > [...]
> > > 
> > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > index d59b5a73dfb3..73a208c5c1e7 100644
> > > > --- a/mm/userfaultfd.c
> > > > +++ b/mm/userfaultfd.c
> > > > @@ -25,7 +25,8 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
> > > >  			    struct vm_area_struct *dst_vma,
> > > >  			    unsigned long dst_addr,
> > > >  			    unsigned long src_addr,
> > > > -			    struct page **pagep)
> > > > +			    struct page **pagep,
> > > > +			    bool wp_copy)
> > > >  {
> > > >  	struct mem_cgroup *memcg;
> > > >  	pte_t _dst_pte, *dst_pte;
> > > > @@ -71,9 +72,9 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
> > > >  	if (mem_cgroup_try_charge(page, dst_mm, GFP_KERNEL, &memcg, false))
> > > >  		goto out_release;
> > > >  
> > > > -	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
> > > > -	if (dst_vma->vm_flags & VM_WRITE)
> > > > -		_dst_pte = pte_mkwrite(pte_mkdirty(_dst_pte));
> > > > +	_dst_pte = pte_mkdirty(mk_pte(page, dst_vma->vm_page_prot));
> > > > +	if (dst_vma->vm_flags & VM_WRITE && !wp_copy)
> > > > +		_dst_pte = pte_mkwrite(_dst_pte);
> > > 
> > > I like parenthesis around around and :) ie:
> > >     (dst_vma->vm_flags & VM_WRITE) && !wp_copy
> > > 
> > > I feel it is easier to read.
> > 
> > Yeah another one. Though this line will be changed in follow up
> > patches, will fix anyways.
> > 
> > > 
> > > [...]
> > > 
> > > > @@ -416,11 +418,13 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
> > > >  	if (!(dst_vma->vm_flags & VM_SHARED)) {
> > > >  		if (!zeropage)
> > > >  			err = mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma,
> > > > -					       dst_addr, src_addr, page);
> > > > +					       dst_addr, src_addr, page,
> > > > +					       wp_copy);
> > > >  		else
> > > >  			err = mfill_zeropage_pte(dst_mm, dst_pmd,
> > > >  						 dst_vma, dst_addr);
> > > >  	} else {
> > > > +		VM_WARN_ON(wp_copy); /* WP only available for anon */
> > > 
> > > Don't you want to return with error here ?
> > 
> > Makes sense to me.  Does this looks good to you to be squashed into
> > current patch?
> > 
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 73a208c5c1e7..f3ea09f412d4 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -73,7 +73,7 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
> >                 goto out_release;
> >  
> >         _dst_pte = pte_mkdirty(mk_pte(page, dst_vma->vm_page_prot));
> > -       if (dst_vma->vm_flags & VM_WRITE && !wp_copy)
> > +       if ((dst_vma->vm_flags & VM_WRITE) && !wp_copy)
> >                 _dst_pte = pte_mkwrite(_dst_pte);
> >  
> >         dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
> > @@ -424,7 +424,10 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
> >                         err = mfill_zeropage_pte(dst_mm, dst_pmd,
> >                                                  dst_vma, dst_addr);
> >         } else {
> > -               VM_WARN_ON(wp_copy); /* WP only available for anon */
> > +               if (unlikely(wp_copy))
> > +                       /* TODO: WP currently only available for anon */
> > +                       return -EINVAL;
> > +
> >                 if (!zeropage)
> >                         err = shmem_mcopy_atomic_pte(dst_mm, dst_pmd,
> >                                                      dst_vma, dst_addr,
> 
> I would keep a the VM_WARN_ON or maybe a ONCE variant so that we at
> least have a chance to be inform if for some reasons that code path
> is taken. With that my r-b stands.

Yeah *ONCE() is good to me too (both can avoid DOS attack from
userspace) and I don't have strong opinion on whether we should fail
on this specific ioctl if it happens.  For now I'll just take the
advise and the r-b together.  Thanks,

-- 
Peter Xu
