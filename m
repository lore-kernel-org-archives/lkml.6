Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A116C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3717320823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfARQnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:43:04 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:44434 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727346AbfARQnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:43:04 -0500
Received: (qmail 4164 invoked by uid 2102); 18 Jan 2019 11:43:02 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Jan 2019 11:43:02 -0500
Date:   Fri, 18 Jan 2019 11:43:02 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Plain accesses and data races in the Linux Kernel Memory Model
In-Reply-To: <20190118155638.GA24442@andrea>
Message-ID: <Pine.LNX.4.44L0.1901181137180.1425-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019, Andrea Parri wrote:

> > A relatively simple solution to this problem would be to say that 
> > smp_wmb doesn't order plain writes.
> 
> It seems so; I don't have other solutions to suggest ATM.  (But, TBH,
> I'm still in the process of reviewing/testing these changes... )
> 
> And yes, this is a pain! : I don't have the exact statistics, but I'm
> willing to believe that removing this order will take us back ~99% of
> the current (~500!) uses of smp_wmb() ;-/
> 
> Oh, well, maybe we'll find a better solution one day: after all, that
> one doesn't seem worse than what the current LKMM has to say! ;-)
> 
> 
> > 
> > I think the rest of the memory model would then be okay.  However, I am
> > open to arguments that this approach is too complex and we should
> > insist on the same kind of strict ordering for race avoidance that the
> > C11 standard uses (i.e., conflicting accesses separated by full memory
> > barriers or release & acquire barriers or locking).
> 
> Indeed;  maybe, we've just found another reason to obsolete smp_wmb()! ;-)

Here's another example of how smp_wmb can cause trouble.  In this test,
I have replaced "*x = 1" in P1 with "r2 = *x; if (r2 != 1) *x = 1",
which is a perfectly valid transformation for the compiler to make.  
But as a result of this transformation, the MP pattern between P1 and
P2 is now allowed!

This shows that when plain accesses are involved, smp_wmb() in the
writing thread is not sufficient to forbid MP.

Alan


C bad-wmb

{}

P0(int *x, int *y)
{
	WRITE_ONCE(*x, 1);
	smp_store_release(y, 1);
}

P1(int *x, int *y, int *z)
{
	int r1;
	int r2;

	r1 = smp_load_acquire(y);
	if (r1) {
		/* Instead of *x = 1 ... */
		r2 = *x;
		if (r2 != 1)
			*x = 1;
		smp_wmb();
		WRITE_ONCE(*z, 1);
	}
}

P2(int *x, int *z)
{
	int r3;
	int r4 = 0;

	r3 = READ_ONCE(*z);
	if (r3) {
		smp_rmb();
		r4 = READ_ONCE(*x);
	}
}

exists (2:r3=1 /\ 2:r4=0)

