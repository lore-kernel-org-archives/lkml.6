Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2250EC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0BBC2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfAXE4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 23:56:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:29588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbfAXE4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 23:56:24 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 01C75C087321;
        Thu, 24 Jan 2019 04:56:24 +0000 (UTC)
Received: from xz-x1 (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E66E65D6A6;
        Thu, 24 Jan 2019 04:56:17 +0000 (UTC)
Date:   Thu, 24 Jan 2019 12:56:15 +0800
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
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH RFC 07/24] userfaultfd: wp: add the writeprotect API to
 userfaultfd ioctl
Message-ID: <20190124045551.GD18231@xz-x1>
References: <20190121075722.7945-1-peterx@redhat.com>
 <20190121075722.7945-8-peterx@redhat.com>
 <20190121104232.GA26461@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190121104232.GA26461@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 24 Jan 2019 04:56:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 12:42:33PM +0200, Mike Rapoport wrote:

[...]

> > @@ -1343,7 +1344,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> > 
> >  		/* check not compatible vmas */
> >  		ret = -EINVAL;
> > -		if (!vma_can_userfault(cur))
> > +		if (!vma_can_userfault(cur, vm_flags))
> >  			goto out_unlock;
> > 
> >  		/*
> > @@ -1371,6 +1372,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> >  			if (end & (vma_hpagesize - 1))
> >  				goto out_unlock;
> >  		}
> > +		if ((vm_flags & VM_UFFD_WP) && !(cur->vm_flags & VM_WRITE))
> > +			goto out_unlock;
> 
> This is problematic for the non-cooperative use-case. Way may still want to
> monitor a read-only area because it may eventually become writable, e.g. if
> the monitored process runs mprotect().

Firstly I think I should be able to change it to VM_MAYWRITE which
seems to suite more.

Meanwhile, frankly speaking I didn't think a lot about how to nest the
usages of uffd-wp and mprotect(), so far I was only considering it as
a replacement of mprotect().  But indeed it can happen that the
monitored process calls mprotect().  Is there an existing scenario of
such usage?

The problem is I'm uncertain about whether this scenario can work
after all.  Say, the monitor process A write protected process B's
page P, so logically A will definitely receive a message before B
writes to page P.  However here if we allow process B to do
mprotect(PROT_WRITE) upon page P and grant write permission to it on
its own, then A will not be able to capture the write operation at
all?  Then I don't know how it can work here... or whether we should
fail the mprotect() at least upon uffd-wp ranges?

> Particularity, for using uffd-wp as a replacement for soft-dirty would
> require it.
> 
> > 
> >  		/*
> >  		 * Check that this vma isn't already owned by a
> > @@ -1400,7 +1403,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> >  	do {
> >  		cond_resched();
> > 
> > -		BUG_ON(!vma_can_userfault(vma));
> > +		BUG_ON(!vma_can_userfault(vma, vm_flags));
> >  		BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
> >  		       vma->vm_userfaultfd_ctx.ctx != ctx);
> >  		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
> > @@ -1535,7 +1538,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> >  		 * provides for more strict behavior to notice
> >  		 * unregistration errors.
> >  		 */
> > -		if (!vma_can_userfault(cur))
> > +		if (!vma_can_userfault(cur, cur->vm_flags))
> >  			goto out_unlock;
> > 
> >  		found = true;
> > @@ -1549,7 +1552,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> >  	do {
> >  		cond_resched();
> > 
> > -		BUG_ON(!vma_can_userfault(vma));
> > +		BUG_ON(!vma_can_userfault(vma, vma->vm_flags));
> >  		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
> > 
> >  		/*
> > @@ -1760,6 +1763,46 @@ static int userfaultfd_zeropage(struct userfaultfd_ctx *ctx,
> >  	return ret;
> >  }
> > 
> > +static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
> > +				    unsigned long arg)
> > +{
> > +	int ret;
> > +	struct uffdio_writeprotect uffdio_wp;
> > +	struct uffdio_writeprotect __user *user_uffdio_wp;
> > +	struct userfaultfd_wake_range range;
> > +
> 
> In the non-cooperative mode the userfaultfd_writeprotect() may race with VM
> layout changes, pretty much as uffdio_copy() [1]. My solution for uffdio_copy()
> was to return -EAGAIN if such race is encountered. I think the same would
> apply here.

I tried to understand the problem at [1] but failed... could you help
to clarify it a bit more?

I'm quoting some of the discussions from [1] here directly between you
and Pavel:

  > Since the monitor cannot assume that the process will access all its memory
  > it has to copy some pages "in the background". A simple monitor may look
  > like:
  > 
  > 	for (;;) {
  > 		wait_for_uffd_events(timeout);
  > 		handle_uffd_events();
  > 		uffd_copy(some not faulted pages);
  > 	}
  > 
  > Then, if the "background" uffd_copy() races with fork, the pages we've
  > copied may be already present in parent's mappings before the call to
  > copy_page_range() and may be not.
  > 
  > If the pages were not present, uffd_copy'ing them again to the child's
  > memory would be ok.
  >
  > But if uffd_copy() was first to catch mmap_sem, and we would uffd_copy them
  > again, child process will get memory corruption.

Here I don't understand why the child process will get memory
corruption if uffd_copy() caught the mmap_sem first.

If it did it, then IMHO when uffd_copy() copies the page again it'll
simply get a -EEXIST showing that the page has already been copied.
Could you explain on why there will be a data corruption?

Thanks in advance,

>  
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=df2cc96e77011cf7989208b206da9817e0321028
>

-- 
Peter Xu
