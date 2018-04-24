Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755407AbeDXJPX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 05:15:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48278 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755258AbeDXJPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 05:15:16 -0400
Date: Tue, 24 Apr 2018 11:15:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] locking/rwsem: Synchronize task state & waiter->task of
 readers
Message-ID: <20180424091510.GB4064@hirez.programming.kicks-ass.net>
References: <1523380938-19462-1-git-send-email-longman@redhat.com>
 <6c112ecb-d662-b1fc-152a-32060ec46dae@redhat.com>
 <20180423205514.GA5876@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423205514.GA5876@andrea>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 10:55:14PM +0200, Andrea Parri wrote:
> > > +	/*
> > > +	 * To avoid missed wakeup of reader, we need to make sure
> > > +	 * that task state and waiter->task are properly synchronized.
> > > +	 *
> > > +	 *     wakeup		      sleep
> > > +	 *     ------		      -----
> > > +	 * __rwsem_mark_wake:	rwsem_down_read_failed*:
> > > +	 *   [S] waiter->task	  [S] set_current_state(state)
> > > +	 *	 MB		      MB
> > > +	 * try_to_wake_up:
> > > +	 *   [L] state		  [L] waiter->task
> > > +	 *
> > > +	 * For the wakeup path, the original lock release-acquire pair
> > > +	 * does not provide enough guarantee of proper synchronization.
> > > +	 */
> > > +	smp_mb();
> > > +
> > >  	adjustment = woken * RWSEM_ACTIVE_READ_BIAS - adjustment;
> > >  	if (list_empty(&sem->wait_list)) {
> > >  		/* hit end of list above */
> > 

> try_to_wake_up() does:
> 
> 	raw_spin_lock_irqsave(&p->pi_lock, flags);
> 	smp_mb__after_spinlock();
> 	if (!(p->state & state))
> 
> My understanding is that this smp_mb__after_spinlock() provides us with
> the guarantee you described above.  The smp_mb__after_spinlock() should
> represent a 'cheaper way' to provide such a guarantee.

Right, I don't see what problem is being fixed here either. The scenario
in the comment is already closed by the smp_mb__after_spinlock() you
mention.

And it is fine to rely on that, we do in other places.

> If this understanding is correct, the remaining question would be about
> whether you want to rely on (and document) the smp_mb__after_spinlock()
> in the callsite in question (the comment in wake_up_q()
> 
>    /*
>     * wake_up_process() implies a wmb() to pair with the queueing
>     * in wake_q_add() so as not to miss wakeups.
>     */
> 

So that comment is about the ordering required for wake_q_add() vs
wake_up_q(). But yes, wmb is a little confusing. I suppose I was
thinking of the NULL store vs the wakeup (store), but that doesn't
really make much sense.

And wake_up_process() being a mb means it also implies a wmb; if such is
all that is required for the scenario at hand.
