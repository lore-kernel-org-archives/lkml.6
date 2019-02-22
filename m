Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66044C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 04:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330CE20818
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 04:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfBVEZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 23:25:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbfBVEZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 23:25:58 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7829D3082E07;
        Fri, 22 Feb 2019 04:25:57 +0000 (UTC)
Received: from xz-x1 (ovpn-12-57.pek2.redhat.com [10.72.12.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B75760C80;
        Fri, 22 Feb 2019 04:25:48 +0000 (UTC)
Date:   Fri, 22 Feb 2019 12:25:44 +0800
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
Subject: Re: [PATCH v2.1 04/26] mm: allow VM_FAULT_RETRY for multiple times
Message-ID: <20190222042544.GD8904@xz-x1>
References: <20190212025632.28946-5-peterx@redhat.com>
 <20190221085656.18529-1-peterx@redhat.com>
 <20190221155311.GD2813@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190221155311.GD2813@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 22 Feb 2019 04:25:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 10:53:11AM -0500, Jerome Glisse wrote:
> On Thu, Feb 21, 2019 at 04:56:56PM +0800, Peter Xu wrote:
> > The idea comes from a discussion between Linus and Andrea [1].
> > 
> > Before this patch we only allow a page fault to retry once.  We
> > achieved this by clearing the FAULT_FLAG_ALLOW_RETRY flag when doing
> > handle_mm_fault() the second time.  This was majorly used to avoid
> > unexpected starvation of the system by looping over forever to handle
> > the page fault on a single page.  However that should hardly happen,
> > and after all for each code path to return a VM_FAULT_RETRY we'll
> > first wait for a condition (during which time we should possibly yield
> > the cpu) to happen before VM_FAULT_RETRY is really returned.
> > 
> > This patch removes the restriction by keeping the
> > FAULT_FLAG_ALLOW_RETRY flag when we receive VM_FAULT_RETRY.  It means
> > that the page fault handler now can retry the page fault for multiple
> > times if necessary without the need to generate another page fault
> > event.  Meanwhile we still keep the FAULT_FLAG_TRIED flag so page
> > fault handler can still identify whether a page fault is the first
> > attempt or not.
> > 
> > Then we'll have these combinations of fault flags (only considering
> > ALLOW_RETRY flag and TRIED flag):
> > 
> >   - ALLOW_RETRY and !TRIED:  this means the page fault allows to
> >                              retry, and this is the first try
> > 
> >   - ALLOW_RETRY and TRIED:   this means the page fault allows to
> >                              retry, and this is not the first try
> > 
> >   - !ALLOW_RETRY and !TRIED: this means the page fault does not allow
> >                              to retry at all
> > 
> >   - !ALLOW_RETRY and TRIED:  this is forbidden and should never be used
> > 
> > In existing code we have multiple places that has taken special care
> > of the first condition above by checking against (fault_flags &
> > FAULT_FLAG_ALLOW_RETRY).  This patch introduces a simple helper to
> > detect the first retry of a page fault by checking against
> > both (fault_flags & FAULT_FLAG_ALLOW_RETRY) and !(fault_flag &
> > FAULT_FLAG_TRIED) because now even the 2nd try will have the
> > ALLOW_RETRY set, then use that helper in all existing special paths.
> > One example is in __lock_page_or_retry(), now we'll drop the mmap_sem
> > only in the first attempt of page fault and we'll keep it in follow up
> > retries, so old locking behavior will be retained.
> > 
> > This will be a nice enhancement for current code [2] at the same time
> > a supporting material for the future userfaultfd-writeprotect work,
> > since in that work there will always be an explicit userfault
> > writeprotect retry for protected pages, and if that cannot resolve the
> > page fault (e.g., when userfaultfd-writeprotect is used in conjunction
> > with swapped pages) then we'll possibly need a 3rd retry of the page
> > fault.  It might also benefit other potential users who will have
> > similar requirement like userfault write-protection.
> > 
> > GUP code is not touched yet and will be covered in follow up patch.
> > 
> > Please read the thread below for more information.
> > 
> > [1] https://lkml.org/lkml/2017/11/2/833
> > [2] https://lkml.org/lkml/2018/12/30/64
> 
> I have few comments on this one. See below.
> 
> 
> > 
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> > 
> >  arch/alpha/mm/fault.c           |  2 +-
> >  arch/arc/mm/fault.c             |  1 -
> >  arch/arm/mm/fault.c             |  3 ---
> >  arch/arm64/mm/fault.c           |  5 -----
> >  arch/hexagon/mm/vm_fault.c      |  1 -
> >  arch/ia64/mm/fault.c            |  1 -
> >  arch/m68k/mm/fault.c            |  3 ---
> >  arch/microblaze/mm/fault.c      |  1 -
> >  arch/mips/mm/fault.c            |  1 -
> >  arch/nds32/mm/fault.c           |  1 -
> >  arch/nios2/mm/fault.c           |  3 ---
> >  arch/openrisc/mm/fault.c        |  1 -
> >  arch/parisc/mm/fault.c          |  2 --
> >  arch/powerpc/mm/fault.c         |  6 ------
> >  arch/riscv/mm/fault.c           |  5 -----
> >  arch/s390/mm/fault.c            |  5 +----
> >  arch/sh/mm/fault.c              |  1 -
> >  arch/sparc/mm/fault_32.c        |  1 -
> >  arch/sparc/mm/fault_64.c        |  1 -
> >  arch/um/kernel/trap.c           |  1 -
> >  arch/unicore32/mm/fault.c       |  6 +-----
> >  arch/x86/mm/fault.c             |  2 --
> >  arch/xtensa/mm/fault.c          |  1 -
> >  drivers/gpu/drm/ttm/ttm_bo_vm.c | 12 +++++++++---
> >  include/linux/mm.h              | 12 +++++++++++-
> >  mm/filemap.c                    |  2 +-
> >  mm/shmem.c                      |  2 +-
> >  27 files changed, 25 insertions(+), 57 deletions(-)
> > 
> 
> [...]
> 
> > diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
> > index 29422eec329d..7d3e96a9a7ab 100644
> > --- a/arch/parisc/mm/fault.c
> > +++ b/arch/parisc/mm/fault.c
> > @@ -327,8 +327,6 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
> >  		else
> >  			current->min_flt++;
> >  		if (fault & VM_FAULT_RETRY) {
> > -			flags &= ~FAULT_FLAG_ALLOW_RETRY;
> 
> Don't you need to also add:
>      flags |= FAULT_FLAG_TRIED;
> 
> Like other arch.

Yes I can add that, thanks for noticing this.  Actually I only changed
one of the same cases in current patch (alpha, parisc, unicore32 are
special cases here where TRIED is never used).  I think it's fine to
even not have TRIED flag here because if we pass in fault flag with
!ALLOW_RETRY and !TRIED it'll simply be the synchronize case so we'll
probably be safe too just like a normal 2nd fault retry and we'll wait
until page fault resolved.  Though after a second thought I think
maybe this is also a good chance that we clean this whole thing up to
make sure all the archs are using the same pattern to pass fault
flags.  So I'll touch up the other two places together to make sure
TRIED will be there if it's the 2nd retry or more.

> 
> 
> [...]
> 
> > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > index 248ff0a28ecd..d842c3e02a50 100644
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -1483,9 +1483,7 @@ void do_user_addr_fault(struct pt_regs *regs,
> >  	if (unlikely(fault & VM_FAULT_RETRY)) {
> >  		bool is_user = flags & FAULT_FLAG_USER;
> >  
> > -		/* Retry at most once */
> >  		if (flags & FAULT_FLAG_ALLOW_RETRY) {
> > -			flags &= ~FAULT_FLAG_ALLOW_RETRY;
> >  			flags |= FAULT_FLAG_TRIED;
> >  			if (is_user && signal_pending(tsk))
> >  				return;
> 
> So here you have a change in behavior, it can retry indefinitly for as
> long as they are no signal. Don't you want so test for FAULT_FLAG_TRIED ?

These first five patches do want to allow the page fault to retry as
much as needed.  "indefinitely" seems to be a scary word, but IMHO
this is fine for page faults since otherwise we'll simply crash the
program or even crash the system depending on the fault context, so it
seems to be nowhere worse.

For userspace programs, if anything really really go wrong (so far I
still cannot think a valid scenario in a bug-free system, but just
assuming...) and it loops indefinitely, IMHO it'll just hang the buggy
process itself rather than coredump, and the admin can simply kill the
process to retake the resources since we'll still detect signals.

Or did I misunderstood the question?

> 
> [...]
> 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 80bb6408fe73..4e11c9639f1b 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -341,11 +341,21 @@ extern pgprot_t protection_map[16];
> >  #define FAULT_FLAG_ALLOW_RETRY	0x04	/* Retry fault if blocking */
> >  #define FAULT_FLAG_RETRY_NOWAIT	0x08	/* Don't drop mmap_sem and wait when retrying */
> >  #define FAULT_FLAG_KILLABLE	0x10	/* The fault task is in SIGKILL killable region */
> > -#define FAULT_FLAG_TRIED	0x20	/* Second try */
> > +#define FAULT_FLAG_TRIED	0x20	/* We've tried once */
> >  #define FAULT_FLAG_USER		0x40	/* The fault originated in userspace */
> >  #define FAULT_FLAG_REMOTE	0x80	/* faulting for non current tsk/mm */
> >  #define FAULT_FLAG_INSTRUCTION  0x100	/* The fault was during an instruction fetch */
> >  
> > +/*
> > + * Returns true if the page fault allows retry and this is the first
> > + * attempt of the fault handling; false otherwise.
> > + */
> 
> You should add why it returns false if it is not the first try ie to
> avoid starvation.

How about:

        Returns true if the page fault allows retry and this is the
        first attempt of the fault handling; false otherwise.  This is
        mostly used for places where we want to try to avoid taking
        the mmap_sem for too long a time when waiting for another
        condition to change, in which case we can try to be polite to
        release the mmap_sem in the first round to avoid potential
        starvation of other processes that would also want the
        mmap_sem.

?

Thanks,

-- 
Peter Xu
