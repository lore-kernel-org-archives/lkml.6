Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933527AbeD1Mpt (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 08:45:49 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50194 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933450AbeD1Mps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 08:45:48 -0400
Date: Sat, 28 Apr 2018 14:45:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        longman@redhat.com
Subject: Re: [PATCH v3 05/14] locking/qspinlock: Remove unbounded cmpxchg
 loop from locking slowpath
Message-ID: <20180428124537.GD4082@hirez.programming.kicks-ass.net>
References: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
 <1524738868-31318-6-git-send-email-will.deacon@arm.com>
 <20180426155335.GL4064@hirez.programming.kicks-ass.net>
 <20180426165518.GC898@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426165518.GC898@arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 05:55:19PM +0100, Will Deacon wrote:
> Hi Peter,
> 
> On Thu, Apr 26, 2018 at 05:53:35PM +0200, Peter Zijlstra wrote:
> > On Thu, Apr 26, 2018 at 11:34:19AM +0100, Will Deacon wrote:
> > > @@ -290,58 +312,50 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> > >  	}
> > >  
> > >  	/*
> > > +	 * If we observe any contention; queue.
> > > +	 */
> > > +	if (val & ~_Q_LOCKED_MASK)
> > > +		goto queue;
> > > +
> > > +	/*
> > >  	 * trylock || pending
> > >  	 *
> > >  	 * 0,0,0 -> 0,0,1 ; trylock
> > >  	 * 0,0,1 -> 0,1,1 ; pending
> > >  	 */
> > > +	val = atomic_fetch_or_acquire(_Q_PENDING_VAL, &lock->val);
> > > +	if (!(val & ~_Q_LOCKED_MASK)) {
> > >  		/*
> > > +		 * we're pending, wait for the owner to go away.
> > > +		 *
> > > +		 * *,1,1 -> *,1,0
> > 
> > Tail must be 0 here, right?
> 
> Not necessarily. If we're concurrently setting pending with another slowpath
> locker, they could queue in the tail behind us, so we can't mess with those
> upper bits.

Could be my brain just entirely stopped working; but I read that as:

	!(val & ~0xFF) := !(val & 0xFFFFFF00)

which then pretty much mandates the top bits are empty, no?
