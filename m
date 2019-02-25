Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC190C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F21A2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfBYGTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 01:19:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfBYGTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 01:19:22 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E51630013E6;
        Mon, 25 Feb 2019 06:19:22 +0000 (UTC)
Received: from xz-x1 (ovpn-12-105.pek2.redhat.com [10.72.12.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 321E310027D9;
        Mon, 25 Feb 2019 06:19:11 +0000 (UTC)
Date:   Mon, 25 Feb 2019 14:19:09 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Jerome Glisse <jglisse@redhat.com>
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
Message-ID: <20190225061835.GA28121@xz-x1>
References: <20190212025632.28946-5-peterx@redhat.com>
 <20190221085656.18529-1-peterx@redhat.com>
 <20190221155311.GD2813@redhat.com>
 <20190222042544.GD8904@xz-x1>
 <20190222151101.GA7783@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190222151101.GA7783@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 25 Feb 2019 06:19:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 10:11:58AM -0500, Jerome Glisse wrote:
> On Fri, Feb 22, 2019 at 12:25:44PM +0800, Peter Xu wrote:
> > On Thu, Feb 21, 2019 at 10:53:11AM -0500, Jerome Glisse wrote:
> > > On Thu, Feb 21, 2019 at 04:56:56PM +0800, Peter Xu wrote:
> > > > The idea comes from a discussion between Linus and Andrea [1].
> 
> [...]
> 
> > > > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > > > index 248ff0a28ecd..d842c3e02a50 100644
> > > > --- a/arch/x86/mm/fault.c
> > > > +++ b/arch/x86/mm/fault.c
> > > > @@ -1483,9 +1483,7 @@ void do_user_addr_fault(struct pt_regs *regs,
> > > >  	if (unlikely(fault & VM_FAULT_RETRY)) {
> > > >  		bool is_user = flags & FAULT_FLAG_USER;
> > > >  
> > > > -		/* Retry at most once */
> > > >  		if (flags & FAULT_FLAG_ALLOW_RETRY) {
> > > > -			flags &= ~FAULT_FLAG_ALLOW_RETRY;
> > > >  			flags |= FAULT_FLAG_TRIED;
> > > >  			if (is_user && signal_pending(tsk))
> > > >  				return;
> > > 
> > > So here you have a change in behavior, it can retry indefinitly for as
> > > long as they are no signal. Don't you want so test for FAULT_FLAG_TRIED ?
> > 
> > These first five patches do want to allow the page fault to retry as
> > much as needed.  "indefinitely" seems to be a scary word, but IMHO
> > this is fine for page faults since otherwise we'll simply crash the
> > program or even crash the system depending on the fault context, so it
> > seems to be nowhere worse.
> > 
> > For userspace programs, if anything really really go wrong (so far I
> > still cannot think a valid scenario in a bug-free system, but just
> > assuming...) and it loops indefinitely, IMHO it'll just hang the buggy
> > process itself rather than coredump, and the admin can simply kill the
> > process to retake the resources since we'll still detect signals.
> > 
> > Or did I misunderstood the question?
> 
> No i think you are right, it is fine to keep retrying while they are
> no signal maybe just add a comment that says so in so many words :)
> So people do not see that as a potential issue.

Sure thing.  I don't know whether commenting this on all the
architectures is good...  I'll try to add some comments above
FAULT_FLAG_* deinitions to explain this.

Thanks!

-- 
Peter Xu
