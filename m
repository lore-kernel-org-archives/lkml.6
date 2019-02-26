Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA85C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95906217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfBZHy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 02:54:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfBZHy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 02:54:57 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ABD7D3082B21;
        Tue, 26 Feb 2019 07:54:56 +0000 (UTC)
Received: from xz-x1 (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D2A21001DE2;
        Tue, 26 Feb 2019 07:54:46 +0000 (UTC)
Date:   Tue, 26 Feb 2019 15:54:44 +0800
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
Message-ID: <20190226075444.GO13653@xz-x1>
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-21-peterx@redhat.com>
 <20190225205233.GC10454@rapoport-lnx>
 <20190226060627.GG13653@xz-x1>
 <20190226064347.GB5873@rapoport-lnx>
 <20190226072027.GK13653@xz-x1>
 <20190226074612.GG5873@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190226074612.GG5873@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 26 Feb 2019 07:54:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 09:46:12AM +0200, Mike Rapoport wrote:

[...]

> > > > > > +int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
> > > > > > +			unsigned long len, bool enable_wp, bool *mmap_changing)
> > > > > > +{
> > > > > > +	struct vm_area_struct *dst_vma;
> > > > > > +	pgprot_t newprot;
> > > > > > +	int err;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * Sanitize the command parameters:
> > > > > > +	 */
> > > > > > +	BUG_ON(start & ~PAGE_MASK);
> > > > > > +	BUG_ON(len & ~PAGE_MASK);
> > > > > > +
> > > > > > +	/* Does the address range wrap, or is the span zero-sized? */
> > > > > > +	BUG_ON(start + len <= start);
> > > > > 
> > > > > I'd replace these BUG_ON()s with
> > > > > 
> > > > > 	if (WARN_ON())
> > > > > 		 return -EINVAL;
> > > > 
> > > > I believe BUG_ON() is used because these parameters should have been
> > > > checked in userfaultfd_writeprotect() already by the common
> > > > validate_range() even before calling mwriteprotect_range().  So I'm
> > > > fine with the WARN_ON() approach but I'd slightly prefer to simply
> > > > keep the patch as is to keep Jerome's r-b if you won't disagree. :)
> > > 
> > > Right, userfaultfd_writeprotect() should check these parameters and if it
> > > didn't it was a bug indeed. But still, it's not severe enough to crash the
> > > kernel.
> > > 
> > > I hope Jerome wouldn't mind to keep his r-b with s/BUG_ON/WARN_ON ;-)
> > > 
> > > With this change you can also add 
> > > 
> > > Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Thanks!  Though before I change anything... please note that the
> > BUG_ON()s are really what we've done in existing MISSING code.  One
> > example is userfaultfd_copy() which did validate_range() first, then
> > in __mcopy_atomic() we've used BUG_ON()s.  They make sense to me
> > becauase userspace should never be able to trigger it.  And if we
> > really want to change the BUG_ON()s in this patch, IMHO we probably
> > want to change the other BUG_ON()s as well, then that can be a
> > standalone patch or patchset to address another issue...
> 
> Yeah, we have quite a lot of them, so doing the replacement in a separate
> patch makes perfect sense.
>  
> > (and if we really want to use WARN_ON, I would prefer WARN_ON_ONCE, or
> >  directly return the errors to avoid DOS).
> 
> Agree.
> 
> > I'll see how you'd prefer to see how I should move on with this patch.
> 
> Let's keep this patch as is and make the replacement on top of the WP
> series. Feel free to add r-b.

Great!  I'll do.  Thanks,

-- 
Peter Xu
