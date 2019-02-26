Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E754C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF848213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfBZGGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:06:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfBZGGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:06:43 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 71E6A3082163;
        Tue, 26 Feb 2019 06:06:42 +0000 (UTC)
Received: from xz-x1 (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 462E460BE7;
        Tue, 26 Feb 2019 06:06:30 +0000 (UTC)
Date:   Tue, 26 Feb 2019 14:06:27 +0800
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
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH v2 20/26] userfaultfd: wp: support write protection for
 userfault vma range
Message-ID: <20190226060627.GG13653@xz-x1>
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-21-peterx@redhat.com>
 <20190225205233.GC10454@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190225205233.GC10454@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 26 Feb 2019 06:06:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 10:52:34PM +0200, Mike Rapoport wrote:
> On Tue, Feb 12, 2019 at 10:56:26AM +0800, Peter Xu wrote:
> > From: Shaohua Li <shli@fb.com>
> > 
> > Add API to enable/disable writeprotect a vma range. Unlike mprotect,
> > this doesn't split/merge vmas.
> > 
> > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > Cc: Rik van Riel <riel@redhat.com>
> > Cc: Kirill A. Shutemov <kirill@shutemov.name>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Shaohua Li <shli@fb.com>
> > Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> > [peterx:
> >  - use the helper to find VMA;
> >  - return -ENOENT if not found to match mcopy case;
> >  - use the new MM_CP_UFFD_WP* flags for change_protection
> >  - check against mmap_changing for failures]
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/linux/userfaultfd_k.h |  3 ++
> >  mm/userfaultfd.c              | 54 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 57 insertions(+)
> > 
> > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> > index 765ce884cec0..8f6e6ed544fb 100644
> > --- a/include/linux/userfaultfd_k.h
> > +++ b/include/linux/userfaultfd_k.h
> > @@ -39,6 +39,9 @@ extern ssize_t mfill_zeropage(struct mm_struct *dst_mm,
> >  			      unsigned long dst_start,
> >  			      unsigned long len,
> >  			      bool *mmap_changing);
> > +extern int mwriteprotect_range(struct mm_struct *dst_mm,
> > +			       unsigned long start, unsigned long len,
> > +			       bool enable_wp, bool *mmap_changing);
> > 
> >  /* mm helpers */
> >  static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index fefa81c301b7..529d180bb4d7 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -639,3 +639,57 @@ ssize_t mfill_zeropage(struct mm_struct *dst_mm, unsigned long start,
> >  {
> >  	return __mcopy_atomic(dst_mm, start, 0, len, true, mmap_changing, 0);
> >  }
> > +
> > +int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
> > +			unsigned long len, bool enable_wp, bool *mmap_changing)
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
> 
> I'd replace these BUG_ON()s with
> 
> 	if (WARN_ON())
> 		 return -EINVAL;

I believe BUG_ON() is used because these parameters should have been
checked in userfaultfd_writeprotect() already by the common
validate_range() even before calling mwriteprotect_range().  So I'm
fine with the WARN_ON() approach but I'd slightly prefer to simply
keep the patch as is to keep Jerome's r-b if you won't disagree. :)

Thanks,

-- 
Peter Xu
