Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF60C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6E720881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6E720881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754662AbeGITSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 15:18:52 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:54898 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1754516AbeGITSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 15:18:51 -0400
Received: (qmail 9862 invoked by uid 2102); 9 Jul 2018 15:18:50 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Jul 2018 15:18:50 -0400
Date:   Mon, 9 Jul 2018 15:18:50 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Daniel Lustig <dlustig@nvidia.com>
cc:     Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by release-acquire
 and by locks
In-Reply-To: <01c35480-e207-c916-078b-de53df0e2645@nvidia.com>
Message-ID: <Pine.LNX.4.44L0.1807091421380.2462-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2018, Daniel Lustig wrote:

> On 7/9/2018 9:52 AM, Will Deacon wrote:
> > On Fri, Jul 06, 2018 at 02:10:55PM -0700, Paul E. McKenney wrote:
> >> On Fri, Jul 06, 2018 at 04:37:21PM -0400, Alan Stern wrote:
> >>> On Thu, 5 Jul 2018, Andrea Parri wrote:
> >>>
> >>>>> At any rate, it looks like instead of strengthening the relation, I
> >>>>> should write a patch that removes it entirely.  I also will add new,
> >>>>> stronger relations for use with locking, essentially making spin_lock
> >>>>> and spin_unlock be RCsc.
> >>>>
> >>>> Thank you.
> >>>>
> >>>> Ah let me put this forward: please keep an eye on the (generic)
> >>>>
> >>>>   queued_spin_lock()
> >>>>   queued_spin_unlock()
> >>>>
> >>>> (just to point out an example). Their implementation (in part.,
> >>>> the fast-path) suggests that if we will stick to RCsc lock then
> >>>> we should also stick to RCsc acq. load from RMW and rel. store.
> 
> Just to be clear, this is "RCsc with W->R exception" again, right?

Yes.

I don't think any of these suggested names are really appropriate.  
(For instance, if I understood the original paper correctly, the "sc"  
in "RCsc" refers to the ordering properties of the acquire and release
accesses themselves, not the accesses they protect.)  I'm going to
avoid using them.

> >>> A very good point.  The implementation of those routines uses
> >>> atomic_cmpxchg_acquire() to acquire the lock.  Unless this is
> >>> implemented with an operation or fence that provides write-write
> >>> ordering (in conjunction with a suitable release), qspinlocks won't
> >>> have the ordering properties that we want.
> >>>
> >>> I'm going to assume that the release operations used for unlocking
> >>> don't need to have any extra properties; only the lock-acquire
> >>> operations need to be special (i.e., stronger than a normal
> >>> smp_load_acquire). This suggests that atomic RMW functions with acquire
> >>> semantics should also use this stronger form of acquire.
> 
> It's not clear to me that the burden of enforcing "RCsc with W->R
> ordering" should always be placed only on the acquire half.
> RISC-V currently places some of the burden on the release half, as
> we discussed last week.  Specifically, there are a few cases where
> fence.tso is used instead of fence rw,w on the release side.
> 
> If we always use fence.tso here, following the current recommendation,
> we'll still be fine.  If LKMM introduces an RCpc vs. RCsc distinction
> of some kind, though, I think we would want to distinguish the two
> types of release accordingly as well.

I wasn't talking about the burden in the implementation, just the
modification to the memory model.  In practice it shouldn't matter
because real code should never intermix the two kinds of fences.  That
is, nobody will call smp_store_release() or cmpxchg_acquire()  
with an argument of type spinlock_t *, and nobody will call
spin_unlock() with an argument that isn't of type spinlock_t *.

> >>> Does anybody have a different suggestion?
> >>
> >> The approach you suggest makes sense to me.  Will, Peter, Daniel, any
> >> reasons why this approach would be a problem for you guys?
> > 
> > qspinlock is very much opt-in per arch, so we can simply require that
> > an architecture must have RCsc RmW atomics if they want to use qspinlock.
> > Should an architecture arise where that isn't the case, then we could
> > consider an arch hook in the qspinlock code, but I don't think we have
> > to solve that yet.
> > 
> > Will
> 
> This sounds reasonable to me.

Okay, I'll arrange the patch so that the new requirements apply only to
lock and unlock accesses, not to RMW accesses in general.

Alan

