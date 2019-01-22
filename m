Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286ACC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CEF2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfAVIzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:55:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbfAVIzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 03:55:36 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C1C3F9D42E;
        Tue, 22 Jan 2019 08:55:34 +0000 (UTC)
Received: from xz-x1 (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 38EFC60123;
        Tue, 22 Jan 2019 08:55:24 +0000 (UTC)
Date:   Tue, 22 Jan 2019 16:55:22 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
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
Message-ID: <20190122085522.GE14907@xz-x1>
References: <20190121075722.7945-1-peterx@redhat.com>
 <20190121075722.7945-7-peterx@redhat.com>
 <20190121102035.GC19725@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190121102035.GC19725@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 22 Jan 2019 08:55:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 12:20:35PM +0200, Mike Rapoport wrote:
> On Mon, Jan 21, 2019 at 03:57:04PM +0800, Peter Xu wrote:
> > From: Shaohua Li <shli@fb.com>
> > 
> > Add API to enable/disable writeprotect a vma range. Unlike mprotect,
> > this doesn't split/merge vmas.
> > 
> > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > Cc: Pavel Emelyanov <xemul@parallels.com>
> > Cc: Rik van Riel <riel@redhat.com>
> > Cc: Kirill A. Shutemov <kirill@shutemov.name>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Shaohua Li <shli@fb.com>
> > Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/linux/userfaultfd_k.h |  2 ++
> >  mm/userfaultfd.c              | 52 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 54 insertions(+)
> > 
> > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> > index 38f748e7186e..e82f3156f4e9 100644
> > --- a/include/linux/userfaultfd_k.h
> > +++ b/include/linux/userfaultfd_k.h
> > @@ -37,6 +37,8 @@ extern ssize_t mfill_zeropage(struct mm_struct *dst_mm,
> >  			      unsigned long dst_start,
> >  			      unsigned long len,
> >  			      bool *mmap_changing);
> > +extern int mwriteprotect_range(struct mm_struct *dst_mm,
> > +		unsigned long start, unsigned long len, bool enable_wp);
> > 
> >  /* mm helpers */
> >  static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 458acda96f20..c38903f501c7 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -615,3 +615,55 @@ ssize_t mfill_zeropage(struct mm_struct *dst_mm, unsigned long start,
> >  {
> >  	return __mcopy_atomic(dst_mm, start, 0, len, true, mmap_changing);
> >  }
> > +
> > +int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
> > +	unsigned long len, bool enable_wp)
> > +{
> > +	struct vm_area_struct *dst_vma;
> > +	pgprot_t newprot;
> > +	int err;
> > +
> > +	/*
> > +	 * Sanitize the command parameters:
> > +	 */
> > +	BUG_ON(start & ~PAGE_MASK);
> > +	BUG_ON(len & ~PAGE_MASK);
> > +
> > +	/* Does the address range wrap, or is the span zero-sized? */
> > +	BUG_ON(start + len <= start);
> > +
> > +	down_read(&dst_mm->mmap_sem);
> > +
> > +	/*
> > +	 * Make sure the vma is not shared, that the dst range is
> > +	 * both valid and fully within a single existing vma.
> > +	 */
> > +	err = -EINVAL;
> 
> In non-cooperative mode, there can be a race between VM layout changes and
> mcopy_atomic [1]. I believe the same races are possible here, so can we
> please make err = -ENOENT for consistency with mcopy?

Sure.

> 
> > +	dst_vma = find_vma(dst_mm, start);
> > +	if (!dst_vma || (dst_vma->vm_flags & VM_SHARED))
> > +		goto out_unlock;
> > +	if (start < dst_vma->vm_start ||
> > +	    start + len > dst_vma->vm_end)
> > +		goto out_unlock;
> > +
> > +	if (!dst_vma->vm_userfaultfd_ctx.ctx)
> > +		goto out_unlock;
> > +	if (!userfaultfd_wp(dst_vma))
> > +		goto out_unlock;
> > +
> > +	if (!vma_is_anonymous(dst_vma))
> > +		goto out_unlock;
> 
> The sanity checks here seem to repeat those in mcopy_atomic(). I'd suggest
> splitting them out to a helper function.

It's a good suggestion.  Thanks!

> 
> > +	if (enable_wp)
> > +		newprot = vm_get_page_prot(dst_vma->vm_flags & ~(VM_WRITE));
> > +	else
> > +		newprot = vm_get_page_prot(dst_vma->vm_flags);
> > +
> > +	change_protection(dst_vma, start, start + len, newprot,
> > +				!enable_wp, 0);
> > +
> > +	err = 0;
> > +out_unlock:
> > +	up_read(&dst_mm->mmap_sem);
> > +	return err;
> > +}
> > -- 
> > 2.17.1
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=27d02568f529e908399514dfbee8ee43bdfd5299
> 
> -- 
> Sincerely yours,
> Mike.
> 

-- 
Peter Xu
