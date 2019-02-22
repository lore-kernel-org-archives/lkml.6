Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2711C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8745420657
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfBVPMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:12:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:23914 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbfBVPMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:12:07 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 82267308FF29;
        Fri, 22 Feb 2019 15:12:06 +0000 (UTC)
Received: from redhat.com (ovpn-126-14.rdu2.redhat.com [10.10.126.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C70B5D9CA;
        Fri, 22 Feb 2019 15:11:59 +0000 (UTC)
Date:   Fri, 22 Feb 2019 10:11:58 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
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
Message-ID: <20190222151101.GA7783@redhat.com>
References: <20190212025632.28946-5-peterx@redhat.com>
 <20190221085656.18529-1-peterx@redhat.com>
 <20190221155311.GD2813@redhat.com>
 <20190222042544.GD8904@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190222042544.GD8904@xz-x1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 22 Feb 2019 15:12:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 12:25:44PM +0800, Peter Xu wrote:
> On Thu, Feb 21, 2019 at 10:53:11AM -0500, Jerome Glisse wrote:
> > On Thu, Feb 21, 2019 at 04:56:56PM +0800, Peter Xu wrote:
> > > The idea comes from a discussion between Linus and Andrea [1].

[...]

> > > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > > index 248ff0a28ecd..d842c3e02a50 100644
> > > --- a/arch/x86/mm/fault.c
> > > +++ b/arch/x86/mm/fault.c
> > > @@ -1483,9 +1483,7 @@ void do_user_addr_fault(struct pt_regs *regs,
> > >  	if (unlikely(fault & VM_FAULT_RETRY)) {
> > >  		bool is_user = flags & FAULT_FLAG_USER;
> > >  
> > > -		/* Retry at most once */
> > >  		if (flags & FAULT_FLAG_ALLOW_RETRY) {
> > > -			flags &= ~FAULT_FLAG_ALLOW_RETRY;
> > >  			flags |= FAULT_FLAG_TRIED;
> > >  			if (is_user && signal_pending(tsk))
> > >  				return;
> > 
> > So here you have a change in behavior, it can retry indefinitly for as
> > long as they are no signal. Don't you want so test for FAULT_FLAG_TRIED ?
> 
> These first five patches do want to allow the page fault to retry as
> much as needed.  "indefinitely" seems to be a scary word, but IMHO
> this is fine for page faults since otherwise we'll simply crash the
> program or even crash the system depending on the fault context, so it
> seems to be nowhere worse.
> 
> For userspace programs, if anything really really go wrong (so far I
> still cannot think a valid scenario in a bug-free system, but just
> assuming...) and it loops indefinitely, IMHO it'll just hang the buggy
> process itself rather than coredump, and the admin can simply kill the
> process to retake the resources since we'll still detect signals.
> 
> Or did I misunderstood the question?

No i think you are right, it is fine to keep retrying while they are
no signal maybe just add a comment that says so in so many words :)
So people do not see that as a potential issue.

> > [...]
> > 
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 80bb6408fe73..4e11c9639f1b 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -341,11 +341,21 @@ extern pgprot_t protection_map[16];
> > >  #define FAULT_FLAG_ALLOW_RETRY	0x04	/* Retry fault if blocking */
> > >  #define FAULT_FLAG_RETRY_NOWAIT	0x08	/* Don't drop mmap_sem and wait when retrying */
> > >  #define FAULT_FLAG_KILLABLE	0x10	/* The fault task is in SIGKILL killable region */
> > > -#define FAULT_FLAG_TRIED	0x20	/* Second try */
> > > +#define FAULT_FLAG_TRIED	0x20	/* We've tried once */
> > >  #define FAULT_FLAG_USER		0x40	/* The fault originated in userspace */
> > >  #define FAULT_FLAG_REMOTE	0x80	/* faulting for non current tsk/mm */
> > >  #define FAULT_FLAG_INSTRUCTION  0x100	/* The fault was during an instruction fetch */
> > >  
> > > +/*
> > > + * Returns true if the page fault allows retry and this is the first
> > > + * attempt of the fault handling; false otherwise.
> > > + */
> > 
> > You should add why it returns false if it is not the first try ie to
> > avoid starvation.
> 
> How about:
> 
>         Returns true if the page fault allows retry and this is the
>         first attempt of the fault handling; false otherwise.  This is
>         mostly used for places where we want to try to avoid taking
>         the mmap_sem for too long a time when waiting for another
>         condition to change, in which case we can try to be polite to
>         release the mmap_sem in the first round to avoid potential
>         starvation of other processes that would also want the
>         mmap_sem.
> 
> ?

Looks perfect to me.

Cheers,
Jérôme
