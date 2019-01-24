Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024FEC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D172E217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfAXFWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 00:22:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbfAXFWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 00:22:44 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AEF1DC079C4C;
        Thu, 24 Jan 2019 05:22:43 +0000 (UTC)
Received: from xz-x1 (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 738935E7AF;
        Thu, 24 Jan 2019 05:22:38 +0000 (UTC)
Date:   Thu, 24 Jan 2019 13:22:36 +0800
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
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH RFC 13/24] mm: merge parameters for change_protection()
Message-ID: <20190124052236.GF18231@xz-x1>
References: <20190121075722.7945-1-peterx@redhat.com>
 <20190121075722.7945-14-peterx@redhat.com>
 <20190121135444.GC3344@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190121135444.GC3344@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 24 Jan 2019 05:22:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 08:54:46AM -0500, Jerome Glisse wrote:
> On Mon, Jan 21, 2019 at 03:57:11PM +0800, Peter Xu wrote:
> > change_protection() was used by either the NUMA or mprotect() code,
> > there's one parameter for each of the callers (dirty_accountable and
> > prot_numa).  Further, these parameters are passed along the calls:
> > 
> >   - change_protection_range()
> >   - change_p4d_range()
> >   - change_pud_range()
> >   - change_pmd_range()
> >   - ...
> > 
> > Now we introduce a flag for change_protect() and all these helpers to
> > replace these parameters.  Then we can avoid passing multiple parameters
> > multiple times along the way.
> > 
> > More importantly, it'll greatly simplify the work if we want to
> > introduce any new parameters to change_protection().  In the follow up
> > patches, a new parameter for userfaultfd write protection will be
> > introduced.
> > 
> > No functional change at all.
> 
> There is one change i could spot and also something that looks wrong.
> 
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> 
> [...]
> 
> > @@ -428,8 +431,7 @@ mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
> >  	dirty_accountable = vma_wants_writenotify(vma, vma->vm_page_prot);
> >  	vma_set_page_prot(vma);
> >  
> > -	change_protection(vma, start, end, vma->vm_page_prot,
> > -			  dirty_accountable, 0);
> > +	change_protection(vma, start, end, vma->vm_page_prot, MM_CP_DIRTY_ACCT);
> 
> Here you unconditionaly see the DIRTY_ACCT flag instead it should be
> something like:
> 
>     s/dirty_accountable/cp_flags
>     if (vma_wants_writenotify(vma, vma->vm_page_prot))
>         cp_flags = MM_CP_DIRTY_ACCT;
>     else
>         cp_flags = 0;
> 
>     change_protection(vma, start, end, vma->vm_page_prot, cp_flags);
> 
> Or any equivalent construct.

Oops, thanks for spotting this... it was definitely wrong.  I'll fix.

> 
> >  	/*
> >  	 * Private VM_LOCKED VMA becoming writable: trigger COW to avoid major
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 005291b9b62f..23d4bbd117ee 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -674,7 +674,7 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
> >  		newprot = vm_get_page_prot(dst_vma->vm_flags);
> >  
> >  	change_protection(dst_vma, start, start + len, newprot,
> > -				!enable_wp, 0);
> > +			  enable_wp ? 0 : MM_CP_DIRTY_ACCT);
> 
> We had a discussion in the past on that, i have not look at other
> patches but this seems wrong to me. MM_CP_DIRTY_ACCT is an
> optimization to keep a pte with write permission if it is dirty
> while my understanding is that you want to set write flag for pte
> unconditionaly.
> 
> So maybe this patch that adds flag should be earlier in the serie
> so that you can add a flag to do that before introducing the UFD
> mwriteprotect_range() function.

I agree.  I'm going to move the UFFDIO_WRITEPROTECT patch to the last
so I'll rearrange this part too so these lines will be removed in my
next version.

Thanks!

-- 
Peter Xu
