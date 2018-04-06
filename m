Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbeDFKyF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 06:54:05 -0400
Received: from foss.arm.com ([217.140.101.70]:35008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751454AbeDFKyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 06:54:04 -0400
Date: Fri, 6 Apr 2018 11:54:17 +0100
From: Will Deacon <will.deacon@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        catalin.marinas@arm.com, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 03/10] locking/qspinlock: Kill cmpxchg loop when claiming
 lock from head of queue
Message-ID: <20180406105417.GA27619@arm.com>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-4-git-send-email-will.deacon@arm.com>
 <20180405171912.GE4082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405171912.GE4082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 07:19:12PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 05, 2018 at 05:59:00PM +0100, Will Deacon wrote:
> > +
> > +	/* In the PV case we might already have _Q_LOCKED_VAL set */
> > +	if ((val & _Q_TAIL_MASK) == tail) {
> >  		/*
> >  		 * The smp_cond_load_acquire() call above has provided the
> > +		 * necessary acquire semantics required for locking.
> >  		 */
> >  		old = atomic_cmpxchg_relaxed(&lock->val, val, _Q_LOCKED_VAL);
> >  		if (old == val)
> > +			goto release; /* No contention */
> >  	}
> 
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -464,8 +464,7 @@ void queued_spin_lock_slowpath(struct qs
>  		 * The smp_cond_load_acquire() call above has provided the
>  		 * necessary acquire semantics required for locking.
>  		 */
> -		old = atomic_cmpxchg_relaxed(&lock->val, val, _Q_LOCKED_VAL);
> -		if (old == val)
> +		if (atomic_try_cmpxchg_release(&lock->val, &val, _Q_LOCKED_VAL))
>  			goto release; /* No contention */
>  	}
> 
> Does that also work for you? It would generate slightly better code for
> x86 (not that it would matter much on this path).

Assuming you meant to use atomic_try_cmpxchg_relaxed, then that works for
me too.

Will
