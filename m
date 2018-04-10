Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752781AbeDJJf7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 05:35:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42360 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752303AbeDJJf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 05:35:58 -0400
Date: Tue, 10 Apr 2018 11:35:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mingo@kernel.org,
        boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        catalin.marinas@arm.com
Subject: Re: [PATCH 02/10] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
Message-ID: <20180410093551.GC4082@hirez.programming.kicks-ass.net>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-3-git-send-email-will.deacon@arm.com>
 <dc5f5e43-a60a-05f2-16fb-46960c40459e@redhat.com>
 <20180409105835.GC23134@arm.com>
 <20180409145409.GA9661@arm.com>
 <20180409155420.GB4082@hirez.programming.kicks-ass.net>
 <20180409171959.GB9661@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409171959.GB9661@arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 06:19:59PM +0100, Will Deacon wrote:
> On Mon, Apr 09, 2018 at 05:54:20PM +0200, Peter Zijlstra wrote:
> > On Mon, Apr 09, 2018 at 03:54:09PM +0100, Will Deacon wrote:
> > > @@ -289,18 +315,26 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> > >  		return;
> > >  
> > >  	/*
> > > -	 * If we observe any contention; queue.
> > > +	 * If we observe queueing, then queue ourselves.
> > >  	 */
> > > -	if (val & ~_Q_LOCKED_MASK)
> > > +	if (val & _Q_TAIL_MASK)
> > >  		goto queue;
> > >  
> > >  	/*
> > > +	 * We didn't see any queueing, so have one more try at snatching
> > > +	 * the lock in case it became available whilst we were taking the
> > > +	 * slow path.
> > > +	 */
> > > +	if (queued_spin_trylock(lock))
> > > +		return;
> > > +
> > > +	/*
> > >  	 * trylock || pending
> > >  	 *
> > >  	 * 0,0,0 -> 0,0,1 ; trylock
> > >  	 * 0,0,1 -> 0,1,1 ; pending
> > >  	 */
> > > +	val = set_pending_fetch_acquire(lock);
> > >  	if (!(val & ~_Q_LOCKED_MASK)) {
> > 
> > So, if I remember that partial paper correctly, the atomc_read_acquire()
> > can see 'arbitrary' old values for everything except the pending byte,
> > which it just wrote and will fwd into our load, right?
> > 
> > But I think coherence requires the read to not be older than the one
> > observed by the trylock before (since it uses c-cas its acquire can be
> > elided).
> > 
> > I think this means we can miss a concurrent unlock vs the fetch_or. And
> > I think that's fine, if we still see the lock set we'll needlessly 'wait'
> > for it go become unlocked.
> 
> Ah, but there is a related case that doesn't work. If the lock becomes
> free just before we set pending, then another CPU can succeed on the
> fastpath. We'll then set pending, but the lockword we get back may still
> have the locked byte of 0, so two people end up holding the lock.
> 
> I think it's worth giving this a go with the added trylock, but I can't
> see a way to avoid the atomic_fetch_or at the moment.

Oh yikes, indeed. Yeah, I don't see how we'd be able to fix that one.
