Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC355C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 02:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2EF20868
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 02:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfAWCR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 21:17:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbfAWCR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 21:17:56 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 40471C05FF7E;
        Wed, 23 Jan 2019 02:17:55 +0000 (UTC)
Received: from xz-x1 (ovpn-12-57.pek2.redhat.com [10.72.12.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B2690600CD;
        Wed, 23 Jan 2019 02:17:47 +0000 (UTC)
Date:   Wed, 23 Jan 2019 10:17:45 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Jerome Glisse <jglisse@redhat.com>
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
Message-ID: <20190123021745.GB2970@xz-x1>
References: <20190121075722.7945-1-peterx@redhat.com>
 <20190121075722.7945-7-peterx@redhat.com>
 <20190121140535.GD3344@redhat.com>
 <20190122093935.GF14907@xz-x1>
 <20190122170223.GC3188@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190122170223.GC3188@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 23 Jan 2019 02:17:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 12:02:24PM -0500, Jerome Glisse wrote:
> On Tue, Jan 22, 2019 at 05:39:35PM +0800, Peter Xu wrote:
> > On Mon, Jan 21, 2019 at 09:05:35AM -0500, Jerome Glisse wrote:
> > 
> > [...]
> > 
> > > > +	change_protection(dst_vma, start, start + len, newprot,
> > > > +				!enable_wp, 0);
> > > 
> > > So setting dirty_accountable bring us to that code in mprotect.c:
> > > 
> > >     if (dirty_accountable && pte_dirty(ptent) &&
> > >             (pte_soft_dirty(ptent) ||
> > >              !(vma->vm_flags & VM_SOFTDIRTY))) {
> > >         ptent = pte_mkwrite(ptent);
> > >     }
> > > 
> > > My understanding is that you want to set write flag when enable_wp
> > > is false and you want to set the write flag unconditionaly, right ?
> > 
> > Right.
> > 
> > > 
> > > If so then you should really move the change_protection() flags
> > > patch before this patch and add a flag for setting pte write flags.
> > > 
> > > Otherwise the above is broken at it will only set the write flag
> > > for pte that were dirty and i am guessing so far you always were
> > > lucky because pte were all dirty (change_protection will preserve
> > > dirtyness) when you write protected them.
> > > 
> > > So i believe the above is broken or at very least unclear if what
> > > you really want is to only set write flag to pte that have the
> > > dirty flag set.
> > 
> > You are right, if we build the tree until this patch it won't work for
> > all the cases.  It'll only work if the page was at least writable
> > before and also it's dirty (as you explained).  Sorry to be unclear
> > about this, maybe I should at least mention that in the commit message
> > but I totally forgot it.
> > 
> > All these problems are solved in later on patches, please feel free to
> > have a look at:
> > 
> >   mm: merge parameters for change_protection()
> >   userfaultfd: wp: apply _PAGE_UFFD_WP bit
> >   userfaultfd: wp: handle COW properly for uffd-wp
> > 
> > Note that even in the follow up patches IMHO we can't directly change
> > the write permission since the page can be shared by other processes
> > (e.g., the zero page or COW pages).  But the general idea is the same
> > as you explained.
> > 
> > I tried to avoid squashing these stuff altogether as explained
> > previously.  Also, this patch can be seen as a standalone patch to
> > introduce the new interface which seems to make sense too, and it is
> > indeed still working in many cases so I see the latter patches as
> > enhancement of this one.  Please let me know if you still want me to
> > have all these stuff squashed, or if you'd like me to squash some of
> > them.
> 
> Yeah i have look at those after looking at this one. You should just
> re-order the patch this one first and then one that add new flag,
> then ones that add the new userfaultfd feature. Otherwise you are
> adding a userfaultfd feature that is broken midway ie it is added
> broken and then you fix it. Some one bisecting thing might get hurt
> by that. It is better to add and change everything you need and then
> add the new feature so that the new feature will work as intended.
> 
> So no squashing just change the order ie add the userfaultfd code
> last.

Yes this makes sense, I'll do that in v2.  Thanks for the suggestion!

-- 
Peter Xu
