Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8966C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887AC2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfAYKMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:12:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbfAYKMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 05:12:48 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C6F1C144054;
        Fri, 25 Jan 2019 10:12:46 +0000 (UTC)
Received: from xz-x1 (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DD6961520;
        Fri, 25 Jan 2019 10:12:37 +0000 (UTC)
Date:   Fri, 25 Jan 2019 18:12:34 +0800
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
Message-ID: <20190125101234.GA3128@xz-x1>
References: <20190121075722.7945-1-peterx@redhat.com>
 <20190121075722.7945-8-peterx@redhat.com>
 <20190121104232.GA26461@rapoport-lnx>
 <20190124045551.GD18231@xz-x1>
 <20190124072706.GA3179@rapoport-lnx>
 <20190124092848.GL18231@xz-x1>
 <20190125075453.GF31519@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190125075453.GF31519@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 25 Jan 2019 10:12:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 09:54:53AM +0200, Mike Rapoport wrote:
> On Thu, Jan 24, 2019 at 05:28:48PM +0800, Peter Xu wrote:
> > On Thu, Jan 24, 2019 at 09:27:07AM +0200, Mike Rapoport wrote:
> > > On Thu, Jan 24, 2019 at 12:56:15PM +0800, Peter Xu wrote:
> > > > On Mon, Jan 21, 2019 at 12:42:33PM +0200, Mike Rapoport wrote:
> > > > 
> > > > [...]
> > > > 
> > > > > > @@ -1343,7 +1344,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> > > > > > 
> > > > > >  		/* check not compatible vmas */
> > > > > >  		ret = -EINVAL;
> > > > > > -		if (!vma_can_userfault(cur))
> > > > > > +		if (!vma_can_userfault(cur, vm_flags))
> > > > > >  			goto out_unlock;
> > > > > > 
> > > > > >  		/*
> > > > > > @@ -1371,6 +1372,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> > > > > >  			if (end & (vma_hpagesize - 1))
> > > > > >  				goto out_unlock;
> > > > > >  		}
> > > > > > +		if ((vm_flags & VM_UFFD_WP) && !(cur->vm_flags & VM_WRITE))
> > > > > > +			goto out_unlock;
> > > > > 
> > > > > This is problematic for the non-cooperative use-case. Way may still want to
> > > > > monitor a read-only area because it may eventually become writable, e.g. if
> > > > > the monitored process runs mprotect().
> > > > 
> > > > Firstly I think I should be able to change it to VM_MAYWRITE which
> > > > seems to suite more.
> > > > 
> > > > Meanwhile, frankly speaking I didn't think a lot about how to nest the
> > > > usages of uffd-wp and mprotect(), so far I was only considering it as
> > > > a replacement of mprotect().  But indeed it can happen that the
> > > > monitored process calls mprotect().  Is there an existing scenario of
> > > > such usage?
> > > > 
> > > > The problem is I'm uncertain about whether this scenario can work
> > > > after all.  Say, the monitor process A write protected process B's
> > > > page P, so logically A will definitely receive a message before B
> > > > writes to page P.  However here if we allow process B to do
> > > > mprotect(PROT_WRITE) upon page P and grant write permission to it on
> > > > its own, then A will not be able to capture the write operation at
> > > > all?  Then I don't know how it can work here... or whether we should
> > > > fail the mprotect() at least upon uffd-wp ranges?
> > > 
> > > The use-case we've discussed a while ago was to use uffd-wp instead of
> > > soft-dirty for tracking memory changes in CRIU for pre-copy migration.
> > > Currently, we enable soft-dirty for the migrated process and monitor
> > > /proc/pid/pagemap between memory dump iterations to see what memory pages
> > > have been changed.
> > > With uffd-wp we thought to register all the process memory with uffd-wp and
> > > then track changes with uffd-wp notifications. Back then it was considered
> > > only at the very general level without paying much attention to details.
> > > 
> > > So my initial thought was that we do register the entire memory with
> > > uffd-wp. If an area changes from RO to RW at some point, uffd-wp will
> > > generate notifications to the monitor, it would be able to notice the
> > > change and the write will continue normally.
> > > 
> > > If we are to limit uffd-wp register only to VMAs with VM_WRITE and even
> > > VM_MAYWRITE, we'd need a way to handle the possible changes of VMA
> > > protection and an ability to add monitoring for areas that changed from RO
> > > to RW.
> > > 
> > > Can't say I have a clear picture in mind at the moment, will continue to
> > > think about it.
> > 
> > Thanks for these details.  Though I have a question about how it's
> > used.
> > 
> > Since we're talking about replacing soft dirty with uffd-wp here, I
> > noticed that there's a major interface difference between soft-dirty
> > and uffd-wp: the soft-dirty was all about /proc operations so a
> > monitor process can easily monitor mostly any process on the system as
> > long as knowing its PID.  However I'm unsure about uffd-wp since
> > userfaultfd was always bound to a mm_struct.  For example, the syscall
> > userfaultfd() will always attach the current process mm_struct to the
> > newly created userfaultfd but it cannot be attached to another random
> > mm_struct of other processes.  Or is there any way that the CRIU
> > monitor process can gain an userfaultfd of any process of the system
> > somehow?
>  
> Yes, there is. For CRIU to read the process state during snapshot (or one
> the source in case of the migration) we inject a parasite code into the
> victim process. The parasite code communicates with the "main" CRIU monitor
> via UNIX socket to pass information that cannot be obtained from outside.
> For uffd-wp usage we thought about creating the uffd context in the
> parasite code, registering the memory and passing the userfault file
> descriptor to the CRIU core via that UNIX socket.

Glad to know the black magic behind it...

> 
> > > 
> > > > > Particularity, for using uffd-wp as a replacement for soft-dirty would
> > > > > require it.
> > > > > 
> > > > > > 
> > > > > >  		/*
> > > > > >  		 * Check that this vma isn't already owned by a
> > > > > > @@ -1400,7 +1403,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> > > > > >  	do {
> > > > > >  		cond_resched();
> > > > > > 
> > > > > > -		BUG_ON(!vma_can_userfault(vma));
> > > > > > +		BUG_ON(!vma_can_userfault(vma, vm_flags));
> > > > > >  		BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
> > > > > >  		       vma->vm_userfaultfd_ctx.ctx != ctx);
> > > > > >  		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
> > > > > > @@ -1760,6 +1763,46 @@ static int userfaultfd_zeropage(struct userfaultfd_ctx *ctx,
> > > > > >  	return ret;
> > > > > >  }
> > > > > > 
> > > > > > +static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
> > > > > > +				    unsigned long arg)
> > > > > > +{
> > > > > > +	int ret;
> > > > > > +	struct uffdio_writeprotect uffdio_wp;
> > > > > > +	struct uffdio_writeprotect __user *user_uffdio_wp;
> > > > > > +	struct userfaultfd_wake_range range;
> > > > > > +
> > > > > 
> > > > > In the non-cooperative mode the userfaultfd_writeprotect() may race with VM
> > > > > layout changes, pretty much as uffdio_copy() [1]. My solution for uffdio_copy()
> > > > > was to return -EAGAIN if such race is encountered. I think the same would
> > > > > apply here.
> > > > 
> > > > I tried to understand the problem at [1] but failed... could you help
> > > > to clarify it a bit more?
> > > > 
> > > > I'm quoting some of the discussions from [1] here directly between you
> > > > and Pavel:
> > > > 
> > > >   > Since the monitor cannot assume that the process will access all its memory
> > > >   > it has to copy some pages "in the background". A simple monitor may look
> > > >   > like:
> > > >   > 
> > > >   > 	for (;;) {
> > > >   > 		wait_for_uffd_events(timeout);
> > > >   > 		handle_uffd_events();
> > > >   > 		uffd_copy(some not faulted pages);
> > > >   > 	}
> > > >   > 
> > > >   > Then, if the "background" uffd_copy() races with fork, the pages we've
> > > >   > copied may be already present in parent's mappings before the call to
> > > >   > copy_page_range() and may be not.
> > > >   > 
> > > >   > If the pages were not present, uffd_copy'ing them again to the child's
> > > >   > memory would be ok.
> > > >   >
> > > >   > But if uffd_copy() was first to catch mmap_sem, and we would uffd_copy them
> > > >   > again, child process will get memory corruption.
> > > > 
> > > > Here I don't understand why the child process will get memory
> > > > corruption if uffd_copy() caught the mmap_sem first.
> > > > 
> > > > If it did it, then IMHO when uffd_copy() copies the page again it'll
> > > > simply get a -EEXIST showing that the page has already been copied.
> > > > Could you explain on why there will be a data corruption?
> > > 
> > > Let's say we do post-copy migration of a process A with CRIU and its page at
> > > address 0x1000 is already copied. Now it modifies the contents of this
> > > page. At this point the contents of the page at 0x1000 is different on the
> > > source and the destination.
> > > Next, process A forks process B. The CRIU's uffd monitor gets
> > > UFFD_EVENT_FORK, and starts filling process B memory with UFFDIO_COPY.
> > > It may happen, that UFFDIO_COPY to 0x1000 of the process B will occur
> > 
> > I think this is the place I started to get confused...
> > 
> > The mmap copy phase and the FORK event path is in dup_mmap() as
> > mentioned in the patch too:
> > 
> >      dup_mmap()
> >         down_write(old_mm)
> >         down_write(new_mm)
> >         foreach(vma)
> >             copy_page_range()            (a)
> >         up_write(new_mm)
> >         up_write(old_mm)
> >         dup_userfaultfd_complete()       (b)
> > 
> > Here if we already received UFFD_EVENT_FORK and started to copy pages
> > to process B in the background, then we should have at least passed
> > (b) above since otherwise we won't even know the existance of process
> > B.  However if so, we should have already passed the point to copy
> > data at (a) too, then how could copy_page_range() race?  It seems that
> > I might have missed something important out there but it's not easy
> > for me to figure out myself...
> 
> Apparently, I confused myself as well...
> I clearly remember that there was a problem with fork() but the sequence
> the causes it keeps evading me :(
> 
> Anyway, some mean of synchronization between uffd_copy and the
> non-cooperative events is required. Take, for example, MADV_DONTNEED. When
> it races with uffdio_copy() a process may end reading non zero values right
> after MADV_DONTNEED call.
> 
> uffd monitor           | process
> -----------------------+-------------------------------------------
> uffdio_copy(0x1000)    | madvise(MADV_DONTNEED, 0x1000)
>                        |    down_read(mmap_sem)
>                        |    zap_pte_range(0x1000)
>                        |    up_read(mmap_sem)
>    down_read(mmap_sem) |
>    copy()              |
>    up_read(mmap_sem)   |
>                        |  read(0x1000) != 0
> 
> Similar issues happen with mpremap() and munmap().

I think I get the point this time especially with the context of CRIU
process postcopy migration in mind.

If my understanding is correct, here if UFFDIO_COPY returned -EAGAIN
due to this, continuous UFFDIO_COPY upon the same page will fail too
(which could be slightly confusing at the first glance since normally
that's what -EAGAIN means: it should let the caller to simply
retry...), and IMHO the only correct way to solve this to break out of
the copy_page_background() loop and receive uffd messages instead.
And then we'll notice that there's a UNMAP event of the page, then we
know that we don't need to UFFDIO_COPY this page, so instead of a real
"retry" we just don't do it at all.

Tricky... but it does make sense if considering this under the
postcopy scenario for either CRIU or even QEMU when migrating VMs.

Then I'll just simply follow df2cc96e77011cf79892 in
UFFDIO_WRITEPROTECT() too then.  Thanks for all these explanations!

-- 
Peter Xu
