Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08609C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F2522565
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F2522565
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934272AbeGCR2T (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:28:19 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:37852 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S933677AbeGCR2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:28:18 -0400
Received: (qmail 5601 invoked by uid 2102); 3 Jul 2018 13:28:17 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Jul 2018 13:28:17 -0400
Date:   Tue, 3 Jul 2018 13:28:17 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Will Deacon <will.deacon@arm.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by release-acquire
 and by locks
In-Reply-To: <20180625081920.GA5619@andrea>
Message-ID: <Pine.LNX.4.44L0.1807031228250.1513-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will:

On Mon, 25 Jun 2018, Andrea Parri wrote:

> On Fri, Jun 22, 2018 at 07:30:08PM +0100, Will Deacon wrote:
> > > > I think the second example would preclude us using LDAPR for load-acquire,
> 
> > I don't think it's a moot point. We want new architectures to implement
> > acquire/release efficiently, and it's not unlikely that they will have
> > acquire loads that are similar in semantics to LDAPR. This patch prevents
> > them from doing so,
> 
> By this same argument, you should not be a "big fan" of rfi-rel-acq in ppo ;)
> consider, e.g., the two litmus tests below: what am I missing?

This is an excellent point, which seems to have gotten lost in the 
shuffle.  I'd like to see your comments.

In essence, if you're using release-acquire instructions that only
provide RCpc consistency, does store-release followed by load-acquire
of the same address provide read-read ordering?  In theory it doesn't
have to, because if the value from the store-release is forwarded to
the load-acquire then:

	LOAD A
	STORE-RELEASE X, v
	LOAD-ACQUIRE X
	LOAD B

could be executed by the CPU in the order:

	LOAD-ACQUIRE X
	LOAD B
	LOAD A
	STORE-RELEASE X, v

thereby accessing A and B out of program order without violating the
requirements on the release or the acquire.

Of course PPC doesn't allow this, but should we rule it out entirely?

> C MP+fencewmbonceonce+pooncerelease-rfireleaseacquire-poacquireonce
> 
> {}
> 
> P0(int *x, int *y)
> {
> 	WRITE_ONCE(*x, 1);
> 	smp_wmb();
> 	WRITE_ONCE(*y, 1);
> }
> 
> P1(int *x, int *y, int *z)
> {
> 	r0 = READ_ONCE(*y);
> 	smp_store_release(z, 1);
> 	r1 = smp_load_acquire(z);
> 	r2 = READ_ONCE(*x);
> }
> 
> exists (1:r0=1 /\ 1:r1=1 /\ 1:r2=0)
> 
> 
> AArch64 MP+dmb.st+popl-rfilq-poqp
> "DMB.STdWW Rfe PodRWPL RfiLQ PodRRQP Fre"
> Generator=diyone7 (version 7.49+02(dev))
> Prefetch=0:x=F,0:y=W,1:y=F,1:x=T
> Com=Rf Fr
> Orig=DMB.STdWW Rfe PodRWPL RfiLQ PodRRQP Fre
> {
> 0:X1=x; 0:X3=y;
> 1:X1=y; 1:X3=z; 1:X6=x;
> }
>  P0          | P1            ;
>  MOV W0,#1   | LDR W0,[X1]   ;
>  STR W0,[X1] | MOV W2,#1     ;
>  DMB ST      | STLR W2,[X3]  ;
>  MOV W2,#1   | LDAPR W4,[X3] ;
>  STR W2,[X3] | LDR W5,[X6]   ;
> exists
> (1:X0=1 /\ 1:X4=1 /\ 1:X5=0)

There's also read-write ordering, in the form of the LB pattern:

P0(int *x, int *y, int *z)
{
	r0 = READ_ONCE(*x);
	smp_store_release(z, 1);
	r1 = smp_load_acquire(z);
	WRITE_ONCE(*y, 1);
}

P1(int *x, int *y)
{
	r2 = READ_ONCE(*y);
	smp_mp();
	WRITE_ONCE(*x, 1);
}

exists (0:r0=1 /\ 1:r2=1)

Would this be allowed if smp_load_acquire() was implemented with LDAPR?
If the answer is yes then we will have to remove the rfi-rel-acq and
rel-rf-acq-po relations from the memory model entirely.

Alan

PS: Paul, is the patch which introduced rel-rf-acq-po currently present
in any of your branches?  I couldn't find it.

