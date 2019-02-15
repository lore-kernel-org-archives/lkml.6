Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4D7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226BB21924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389629AbfBOPfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:35:01 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:53418 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726634AbfBOPfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:35:01 -0500
Received: (qmail 2203 invoked by uid 2102); 15 Feb 2019 10:35:00 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Feb 2019 10:35:00 -0500
Date:   Fri, 15 Feb 2019 10:35:00 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Will Deacon <will.deacon@arm.com>
cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Mixing volatile and non-volatile accesses
In-Reply-To: <20190215144230.GA6540@fuggles.cambridge.arm.com>
Message-ID: <Pine.LNX.4.44L0.1902151020160.1574-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Added LKML to CC: -- I forgot to include it originally]

On Fri, 15 Feb 2019, Will Deacon wrote:

Thanks a lot for the quick feedback.

> Hi Alan,
> 
> I'll give you my opinions below, but my broader concern here is that the
> compiler folks will be reluctant to guarantee very much in this area :(

Agreed.

> On Thu, Feb 14, 2019 at 04:59:21PM -0500, Alan Stern wrote:
> > Work on adding support for plain (non-volatile, unannotated) accesses
> > to the Linux Kernel Memory Model has raised a number of questions
> > concerning how the volatile accesses used by READ_ONCE and WRITE_ONCE
> > can interact with plain accesses.  These questions amount to asking
> > what sort of code transformations the compiler is allowed to perform.
> > 
> > For example, if the source code contains:
> > 
> > 	r1 = x;
> > 	r2 = READ_ONCE(x);
> > 
> > is the compiler allowed to emit object code equivalent to:
> > 
> > 	r2 = LOAD(x);
> > 	r1 = LOAD(x);
> > 
> > thereby interchanging the order of the reads?
> 
> FWIW, we've seen the opposite of that tranformation before where:
> 
> 	r1 = READ_ONCE(x);
> 	r2 = x;
> 
> ended up with r2 using a stale value that was loaded from before r1 (see
> a7b100953aa3 and 20a004e7b017). So I would say that this is allowed.

Yes; I think I will have to minimize the LKMM's assumptions in these 
areas.

> > Or even:
> > 
> > 	r1 = r2 = LOAD(x);
> > 
> > eliminating the first read completely?  The second translation seems
> > more reasonable than the first, but is it allowed?
> 
> I also think this is allowed.
> 
> > Can overwriting a value with WRITE_ONCE be used to prevent races?  
> > Given:
> > 
> > 	P0()			P1()
> > 	r = x;			if (READ_ONCE(x) == 2)
> > 	WRITE_ONCE(x, 2);		WRITE_ONCE(x, 3);
> > 
> > is there a race between P0's plain read of x and P1's write?
> 
> I would say that there isn't a race here.

I should expand on this, because now I'm not so sure.

Having a plain read in the source gives the compiler license to add 
its own reads of the same location, so long as they wouldn't create 
a data race where one didn't already exist.  The Standard (and 
presumably the compiler writers) regard memory barriers as the only 
things that can be used to prevent races.

Thus, in the example above, the compiler may well be allowed to add 
reads of x following P0's WRITE_ONCE.  Of course there's no reason 
for the compiler to do this -- it would be foolish -- but it is 
allowed, and such accesses would indeed race with P1.  So the 
conclusion is that we do need to regard this code as racy.

> > Similar questions arise when we consider the interaction between 
> > address dependencies and volatile accesses.  In order to support RCU 
> > properly, the compiler must avoid breaking address dependencies from a 
> > volatile read to a plain access.  This means the compiler should not be 
> > allowed to transform:
> > 
> > 	x = 1;
> > 	r = READ_ONCE(ptr);
> > 	*r = 1;
> > 
> > into
> > 
> > 	x = 1;
> > 	r = READ_ONCE(ptr);
> > 	if (r != &x)
> > 		*r = 1;
> > 
> > or to transform:
> > 
> > 	x = 1;
> > 	r1 = READ_ONCE(ptr);
> > 	r2 = *r1;
> > 
> > into:
> > 
> > 	r2 = x = 1;
> > 	r1 = READ_ONCE(ptr);
> > 	if (r1 != &x)
> > 		r2 = *r1;
> > 
> > because these would break the address dependency when ptr contains &x.
> 
> I've never seen a compiler manage to do this, but I suspect that it would
> not be considered a bug by the compiler developers if it did occur. This is
> one of the reasons why I've been reluctant to enable LTO for arm64 kernel
> builds, because I fear that it will give the compiler enough information to
> perform these sorts of transformations.
> 
> > But suppose we have:
> > 
> > 	r = rcu_dereference(ptr);
> > 	*r = 1;
> > 	WRITE_ONCE(x, 2);
> > 
> > Is the compiler allowed to transform this to:
> > 
> > 	r = rcu_dereference(ptr);
> > 	WRITE_ONCE(x, 2);
> > 	if (r != &x)
> > 		*r = 1;
> > 
> > Does this transformation also break the dependency?  I would say that
> > it does.  How do we know the compiler won't perform it anyway?
> 
> Oh man, that's a horrible example but I can't see what would prevent it from
> happening if the compiler figured it out.

Yes -- ouch.

> I think the bottom line here is that the de-facto guarantees on which we
> rely today are unlikely to hold us well into the future unless we engage
> with both the language and compiler communities to secure the guarantees
> that we require for efficient, relaxed concurrency. Paul has been fighting
> the good fight in SG1, but we're still some way from having a proposal that
> is imminently deployable in the kernel imo.

Perhaps the best approach we can take at this point is something Paul
suggested.  Namely, exclude from the memory model any code containing
both a plain access and a READ_ONCE/WRITE_ONCE of the same location
that aren't separated by at least a compiler barrier.  This means we
wouldn't have to make any firm pronouncements about any of the examples
above, and it seems like the safest thing to do.

(I guess to be thorough we should also exclude plain accesses 
appearing before an acquire load, and plain accesses appearing after a 
release store.)

After all, code that mixes plain accesses with READ_ONCE/WRITE_ONCE is 
highly suspect and in very bad style, no matter what.

Alan

