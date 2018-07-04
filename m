Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71559C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C2120847
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C2120847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934382AbeGDMK2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:10:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36312 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934274AbeGDMKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:10:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF8C218A;
        Wed,  4 Jul 2018 05:10:24 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 907DF3F5AD;
        Wed,  4 Jul 2018 05:10:24 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 7F6E11AE189D; Wed,  4 Jul 2018 13:11:04 +0100 (BST)
Date:   Wed, 4 Jul 2018 13:11:04 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        dlustig@nvidia.com
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Message-ID: <20180704121103.GB26941@arm.com>
References: <20180625081920.GA5619@andrea>
 <Pine.LNX.4.44L0.1807031228250.1513-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1807031228250.1513-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Tue, Jul 03, 2018 at 01:28:17PM -0400, Alan Stern wrote:
> On Mon, 25 Jun 2018, Andrea Parri wrote:
> 
> > On Fri, Jun 22, 2018 at 07:30:08PM +0100, Will Deacon wrote:
> > > > > I think the second example would preclude us using LDAPR for load-acquire,
> > 
> > > I don't think it's a moot point. We want new architectures to implement
> > > acquire/release efficiently, and it's not unlikely that they will have
> > > acquire loads that are similar in semantics to LDAPR. This patch prevents
> > > them from doing so,
> > 
> > By this same argument, you should not be a "big fan" of rfi-rel-acq in ppo ;)
> > consider, e.g., the two litmus tests below: what am I missing?
> 
> This is an excellent point, which seems to have gotten lost in the 
> shuffle.  I'd like to see your comments.

Yeah, sorry. Loads going on at the moment. You could ask herd instead of me
though ;)

> In essence, if you're using release-acquire instructions that only
> provide RCpc consistency, does store-release followed by load-acquire
> of the same address provide read-read ordering?  In theory it doesn't
> have to, because if the value from the store-release is forwarded to
> the load-acquire then:
> 
> 	LOAD A
> 	STORE-RELEASE X, v
> 	LOAD-ACQUIRE X
> 	LOAD B
> 
> could be executed by the CPU in the order:
> 
> 	LOAD-ACQUIRE X
> 	LOAD B
> 	LOAD A
> 	STORE-RELEASE X, v
> 
> thereby accessing A and B out of program order without violating the
> requirements on the release or the acquire.
> 
> Of course PPC doesn't allow this, but should we rule it out entirely?

This would be allowed if LOAD-ACQUIRE was implemented using LDAPR on Arm.
I don't think we should be ruling out architectures using RCpc
acquire/release primitives, because doing so just feels like an artifact of
most architectures building these out of fences today.

It's funny really, because from an Arm-perspective I don't plan to stray
outside of RCsc, but I feel like other weak architectures aren't being
well represented here. If we just care about x86, Arm and Power (and assume
that Power doesn't plan to implement RCpc acquire/release instructions)
then we're good to tighten things up. But I fear that RISC-V should probably
be more engaged (adding Daniel) and who knows about MIPS or these other
random architectures popping up on linux-arch.

> > C MP+fencewmbonceonce+pooncerelease-rfireleaseacquire-poacquireonce
> > 
> > {}
> > 
> > P0(int *x, int *y)
> > {
> > 	WRITE_ONCE(*x, 1);
> > 	smp_wmb();
> > 	WRITE_ONCE(*y, 1);
> > }
> > 
> > P1(int *x, int *y, int *z)
> > {
> > 	r0 = READ_ONCE(*y);
> > 	smp_store_release(z, 1);
> > 	r1 = smp_load_acquire(z);
> > 	r2 = READ_ONCE(*x);
> > }
> > 
> > exists (1:r0=1 /\ 1:r1=1 /\ 1:r2=0)
> > 
> > 
> > AArch64 MP+dmb.st+popl-rfilq-poqp
> > "DMB.STdWW Rfe PodRWPL RfiLQ PodRRQP Fre"
> > Generator=diyone7 (version 7.49+02(dev))
> > Prefetch=0:x=F,0:y=W,1:y=F,1:x=T
> > Com=Rf Fr
> > Orig=DMB.STdWW Rfe PodRWPL RfiLQ PodRRQP Fre
> > {
> > 0:X1=x; 0:X3=y;
> > 1:X1=y; 1:X3=z; 1:X6=x;
> > }
> >  P0          | P1            ;
> >  MOV W0,#1   | LDR W0,[X1]   ;
> >  STR W0,[X1] | MOV W2,#1     ;
> >  DMB ST      | STLR W2,[X3]  ;
> >  MOV W2,#1   | LDAPR W4,[X3] ;
> >  STR W2,[X3] | LDR W5,[X6]   ;
> > exists
> > (1:X0=1 /\ 1:X4=1 /\ 1:X5=0)

(you can also run this yourself, since 'Q' is supported in the .cat file
I contributed to herdtools7)

Test MP+dmb.sy+popl-rfilq-poqp Allowed
States 4
1:X0=0; 1:X4=1; 1:X5=0;
1:X0=0; 1:X4=1; 1:X5=1;
1:X0=1; 1:X4=1; 1:X5=0;
1:X0=1; 1:X4=1; 1:X5=1;
Ok
Witnesses
Positive: 1 Negative: 3
Condition exists (1:X0=1 /\ 1:X4=1 /\ 1:X5=0)
Observation MP+dmb.sy+popl-rfilq-poqp Sometimes 1 3
Time MP+dmb.sy+popl-rfilq-poqp 0.01
Hash=61858b7b59a6310d869f99cd05718f96

> There's also read-write ordering, in the form of the LB pattern:
> 
> P0(int *x, int *y, int *z)
> {
> 	r0 = READ_ONCE(*x);
> 	smp_store_release(z, 1);
> 	r1 = smp_load_acquire(z);
> 	WRITE_ONCE(*y, 1);
> }
> 
> P1(int *x, int *y)
> {
> 	r2 = READ_ONCE(*y);
> 	smp_mp();
> 	WRITE_ONCE(*x, 1);
> }
> 
> exists (0:r0=1 /\ 1:r2=1)

The access types are irrelevant to the acquire/release primitives, so yes
that's also allowed.

> Would this be allowed if smp_load_acquire() was implemented with LDAPR?
> If the answer is yes then we will have to remove the rfi-rel-acq and
> rel-rf-acq-po relations from the memory model entirely.

I don't understand what you mean by "rfi-rel-acq-po", and I assume you mean
rel-rfi-acq-po for the other? Sounds like I'm confused here.

Will
