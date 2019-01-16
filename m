Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB24BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837E2206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405027AbfAPPtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:49:03 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:57506 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728728AbfAPPtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:49:03 -0500
Received: (qmail 3015 invoked by uid 2102); 16 Jan 2019 10:49:01 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Jan 2019 10:49:01 -0500
Date:   Wed, 16 Jan 2019 10:49:01 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Plain accesses and data races in the Linux Kernel Memory Model
In-Reply-To: <20190116131150.GH1215@linux.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1901161012140.1610-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019, Paul E. McKenney wrote:

> On Wed, Jan 16, 2019 at 12:57:52PM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 15, 2019 at 10:19:10AM -0500, Alan Stern wrote:
> > > On Tue, 15 Jan 2019, Andrea Parri wrote:
> > > 
> > > > Unless I'm mis-reading/-applying this definition, this will flag the
> > > > following test (a variation on your "race.litmus") with "data-race":
> > > > 
> > > > C no-race
> > > > 
> > > > {}
> > > > 
> > > > P0(int *x, spinlock_t *s)
> > > > {
> > > > 	spin_lock(s);
> > > >         WRITE_ONCE(*x, 1);	/* A */
> > > > 	spin_unlock(s);	/* B */
> > > > }
> > > > 
> > > > P1(int *x, spinlock_t *s)
> > > > {
> > > >         int r1;
> > > > 
> > > > 	spin_lock(s); /* C */
> > > >         r1 = *x;	/* D */
> > > > 	spin_unlock(s);
> > > > }
> > > > 
> > > > exists (1:r1=1)
> > > > 
> > > > Broadly speaking, this is due to the fact that the modified "happens-
> > > > before" axiom does not forbid the execution with the (MP-) cycle
> > > > 
> > > > 	A ->po-rel B ->rfe C ->acq-po D ->fre A
> > > > 
> > > > and then to the link "D ->race-from-r A" here defined.
> > > 
> > > Yes, that cycle certainly should be forbidden.  On the other hand, we
> > > don't want to insist that C happens before D, given that D may not
> > > happen at all.
> > > 
> > > This is a real problem.  Can we solve it by adding a modified
> > > "happens-before" which says essentially that _if_ D is preserved _then_
> > > C happens before D?  But then what about cycles involving more than one
> > > possibly preserved access?  Or maybe a relation which says that D
> > > cannot execute before C (so if D executes at all, it has to come after
> > > C)?
> > 
> > The latter; there is a compiler barrier implied at the end of
> > spin_lock() such that anything later (in PO) must indeed be later.
> > 
> > > Now you see why this stuff is so difficult...  At the moment, I don't
> > > know how to fix this.
> 
> In the spirit of cutting the Gordian Knot...
> 
> Given that we are flagging data races, how much do we really lose by
> simply ignoring the possibility of removed accesses?

Well, I thought about these issues overnight.  It turns out Andrea's
test cases expose two problems: an easy one and a hard one.

The easy one is that my definition of hb was too stringent; it required
the accesses involved in the prop relation to be marked, but it should
have allowed any preserved access.  At the same time, it was too
lenient in that the overwrite relation allowed any write as the
right-hand argument, but it should have required the write to be
preserved.  Likewise for the rfe? term in A-cumul.  Those issues have 
now been fixed.

The hard problem involves race detection when non-preserved accesses
are present.  (The plain reads in Andrea's examples were non-preserved;  
if the examples are changed to make them preserved then the corrected
model will realize they do not race.)  The point is that non-preserved
accesses can participate in a data race, but if they do it means that
the compiler must have preserved them!  To put it another way, if the
compiler deletes an access then that access can't race with anything.

Hence, when testing whether a particular execution has a data race
between accesses X and Y, we really should re-determine whether the
execution is allowed under the assumption that X and Y are both
preserved.  If it isn't then X and Y don't race in that execution.

Here's a particularly obscure example to illustrate the point.


C non-race1

{}

P0(int *x, int *y)
{
	int r1;
	int r2;

	r1 = READ_ONCE(*x);
	smp_rmb();
	if (r1 == 1)
		r2 = *y;
	WRITE_ONCE(*y, 1);
}

P1(int *x, int *y)
{
	int r3;

	r3 = READ_ONCE(*y);
	WRITE_ONCE(*x, r3);
}

P2(int *y)
{
	WRITE_ONCE(*y, 2);
}

exists (0:r1=1 /\ 1:r3=1)


This litmus test is allowed, and there's no synchronization at all
between the marked write to y in P2() and the plain read of y in P0().  
Nevertheless, those two accesses do not race, because the "r2 = *y" 
read does not actually occur in any of the allowed executions.

I'm thinking about ways to attack this problem.  One approach is to
ignore non-preserved accesses entirely (they do correspond to dead
code, after all).  But that's not so good, because an access may be
preserved in one execution and non-preserved in another.

Still working on it...

Alan

