Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8EFC476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088C82086E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 088C82086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732490AbeGLROx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:14:53 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:54786 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727037AbeGLROx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:14:53 -0400
Received: (qmail 29054 invoked by uid 2102); 12 Jul 2018 13:04:27 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jul 2018 13:04:27 -0400
Date:   Thu, 12 Jul 2018 13:04:27 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
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
In-Reply-To: <20180712134821.GT2494@hirez.programming.kicks-ass.net>
Message-ID: <Pine.LNX.4.44L0.1807121236470.1306-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2018, Peter Zijlstra wrote:

> > But again, these are stuble patterns, and my guess is that several/
> > most kernel developers really won't care about such guarantees (and
> > if some will do, they'll have the tools to figure out what they can
> > actually rely on ...)
> 
> Yes it is subtle, yes most people won't care, however the problem is
> that it is subtly the wrong way around. People expect causality, this is
> a human failing perhaps, but that's how it is.
> 
> And I strongly feel we should have our locks be such that they don't
> subtly break things.
> 
> Take for instance the pattern where RCU relies on RCsc locks, this is an
> entirely simple and straight forward use of locks, yet completely fails
> on this subtle point.

Do you happen to remember exactly where in the kernel source this 
occurs?

> And people will not even try and use complicated tools for apparently
> simple things. They'll say, oh of course this simple thing will work
> right.
> 
> I'm still hoping we can convince the PowerPC people that they're wrong,
> and get rid of this wart and just call all locks RCsc.

It seems reasonable to ask people to learn that locks have stronger
ordering guarantees than RMW atomics do.  Maybe not the greatest
situation in the world, but one I think we could live with.

> > OTOH (as I pointed out earlier) the strengthening we're configuring
> > will prevent some arch. (riscv being just the example of today!) to
> > go "full RCpc", and this will inevitably "complicate" both the LKMM
> > and the reviewing process of related changes (atomics, locking, ...;
> > c.f., this debate), apparently, just because you  ;-) want to "care"
> > about these guarantees.
> 
> It's not just me btw, Linus also cares about these matters. Widely used
> primitives such as spinlocks, should not have subtle and
> counter-intuitive behaviour such as RCpc.

Which raises the question of whether RCtso (adopting Daniel's suggested
term) is also too subtle or counter-intuitive for spinlocks.  I wonder 
what Linus would say...

> Anyway, back to the problem of being able to use the memory model to
> describe locks. This is I think a useful property.
> 
> My earlier reasoning was that:
> 
>   - smp_store_release() + smp_load_acquire() := RCpc
> 
>   - we use smp_store_release() as unlock()
> 
> Therefore, if we want unlock+lock to imply at least TSO (ideally
> smp_mb()) we need lock to make up for whatever unlock lacks.
> 
> Hence my proposal to strenghten rmw-acquire, because that is the basic
> primitive used to implement lock.

That was essentially what the v2 patch did.  (And my reasoning was
basically the same as what you have just outlined.  There was one
additional element: smp_store_release() is already strong enough for
TSO; the acquire is what needs to be stronger in the memory model.)

> But as you (and Will) point out, we don't so much care about rmw-acquire
> semantics as much as that we care about unlock+lock behaviour. Another
> way to look at this is to define:
> 
>   smp-store-release + rmw-acquire := TSO (ideally smp_mb)
> 
> But then we also have to look at:
> 
>   rmw-release + smp-load-acquire
>   rmw-release + rmw-acquire

Let's assume that rmw-release is equivalent, in terms of ordering
strength, to smp_store_release().  Then we can focus our attention on
just the acquire part.

On PowerPC, for instance, if spin_lock() used a full HWSYNC fence
then unlock+lock would become RCsc -- even with no changes to
spin_unlock().

> for completeness sake, and I would suggest they result in (at least) the
> same (TSO) ordering as the one we really care about.
> 
> One alternative is to no longer use smp_store_release() for unlock(),
> and say define atomic_set_release() to be in the rmw-release class
> instead of being a simple smp_store_release().
> 
> Another, and I like this proposal least, is to introduce a new barrier
> to make this all work.

This apparently boils down to two questions:

	Should spin_lock/spin_unlock be RCsc?

	Should rmw-acquire be strong enough so that smp_store_release + 
	rmw-acquire is RCtso?

If both answers are No, we end up with the v3 patch.  If the first
answer is No and the second is Yes, we end up with the v2 patch.  The
problem is that different people seem to want differing answers.

(The implicit third question, "Should spin_lock/spin_unlock be RCtso?",
seems to be pretty well settled at this point -- by Peter's and Will's
vociferousness if nothing else -- despite Andrea's reservations.  
However I admit it would be nice to have one or two examples showing
that the kernel really needs this.)

Alan

