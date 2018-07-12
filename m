Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F300C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4603420BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BS2NPEll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4603420BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbeGLN6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 09:58:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44088 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeGLN6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 09:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qkdkjD1dB+iq+f1dholXWLqLCoRsNFvyBojes/cCNpg=; b=BS2NPEllA9BcVnYce3X8IMcYG
        WDoIbzPNhCuxQ7XiqfR0Fvt9ONdd/uJ6awbau/OLTj7lFFh9XnG1hQ1s8zxrSr3/PLrbQz6i1iKba
        JjRdm615amnOYypEioNQoFKZsvMUfqFDEZn+PHEH5nDrSCYI0LWHf3MtZ48TuEYn6aXwkOSKnbh6h
        rgCOEUXxLwZHTOED3I6j+3vLWeQHVHK4KW9eVQs0ckFL/Jl1YMDa9DtmGjNqddNqmIhuV8bLOmP6o
        UrnjKlm6DhHs9NzQFj8nQctbK/4wU/1bHoFUUzLKDlnbg69C/f3dO199YaqbBeBb7gwmS4N3AIldg
        DPmy7j9+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdbxI-0003Qy-P1; Thu, 12 Jul 2018 13:48:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 301CC20291063; Thu, 12 Jul 2018 15:48:21 +0200 (CEST)
Date:   Thu, 12 Jul 2018 15:48:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180712134821.GT2494@hirez.programming.kicks-ass.net>
References: <Pine.LNX.4.44L0.1807091519180.2462-100000@iolanthe.rowland.org>
 <20180710093821.GA5414@andrea>
 <20180711094310.GA13963@arm.com>
 <20180711123421.GA9673@andrea>
 <20180712074040.GA4920@worktop.programming.kicks-ass.net>
 <20180712115249.GA6201@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712115249.GA6201@andrea>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 01:52:49PM +0200, Andrea Parri wrote:
> On Thu, Jul 12, 2018 at 09:40:40AM +0200, Peter Zijlstra wrote:
> > On Wed, Jul 11, 2018 at 02:34:21PM +0200, Andrea Parri wrote:

> > >   2) Resolve the above mentioned controversy (the inconsistency between
> > >      - locking operations and atomic RMWs on one side, and their actual
> > >      implementation in generic code on the other), thus enabling the use
> > >      of LKMM _and_ its tools for the analysis/reviewing of the latter.
> > 
> > This is a good point; so lets see if there is something we can do to
> > strengthen the model so it all works again.
> > 
> > And I think if we raise atomic*_acquire() to require TSO (but ideally
> > raise it to RCsc) we're there.
> > 

> You mean: "when paired with a po-earlier release to the same memory
> location", right?  I am afraid that neither arm64 nor riscv current
> implementations would ensure "(r1 == 1 && r2 == 0) forbidden" if we
> removed the po-earlier spin_unlock()...

Yes indeed. More on this below.

> But again, these are stuble patterns, and my guess is that several/
> most kernel developers really won't care about such guarantees (and
> if some will do, they'll have the tools to figure out what they can
> actually rely on ...)

Yes it is subtle, yes most people won't care, however the problem is
that it is subtly the wrong way around. People expect causality, this is
a human failing perhaps, but that's how it is.

And I strongly feel we should have our locks be such that they don't
subtly break things.

Take for instance the pattern where RCU relies on RCsc locks, this is an
entirely simple and straight forward use of locks, yet completely fails
on this subtle point.

And people will not even try and use complicated tools for apparently
simple things. They'll say, oh of course this simple thing will work
right.

I'm still hoping we can convince the PowerPC people that they're wrong,
and get rid of this wart and just call all locks RCsc.

> OTOH (as I pointed out earlier) the strengthening we're configuring
> will prevent some arch. (riscv being just the example of today!) to
> go "full RCpc", and this will inevitably "complicate" both the LKMM
> and the reviewing process of related changes (atomics, locking, ...;
> c.f., this debate), apparently, just because you  ;-) want to "care"
> about these guarantees.

It's not just me btw, Linus also cares about these matters. Widely used
primitives such as spinlocks, should not have subtle and
counter-intuitive behaviour such as RCpc.



Anyway, back to the problem of being able to use the memory model to
describe locks. This is I think a useful property.

My earlier reasoning was that:

  - smp_store_release() + smp_load_acquire() := RCpc

  - we use smp_store_release() as unlock()

Therefore, if we want unlock+lock to imply at least TSO (ideally
smp_mb()) we need lock to make up for whatever unlock lacks.

Hence my proposal to strenghten rmw-acquire, because that is the basic
primitive used to implement lock.

But as you (and Will) point out, we don't so much care about rmw-acquire
semantics as much as that we care about unlock+lock behaviour. Another
way to look at this is to define:

  smp-store-release + rmw-acquire := TSO (ideally smp_mb)

But then we also have to look at:

  rmw-release + smp-load-acquire
  rmw-release + rmw-acquire

for completeness sake, and I would suggest they result in (at least) the
same (TSO) ordering as the one we really care about.

One alternative is to no longer use smp_store_release() for unlock(),
and say define atomic_set_release() to be in the rmw-release class
instead of being a simple smp_store_release().

Another, and I like this proposal least, is to introduce a new barrier
to make this all work.
