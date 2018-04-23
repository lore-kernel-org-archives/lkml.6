Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932275AbeDWUzZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 16:55:25 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43970 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752086AbeDWUzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 16:55:22 -0400
X-Google-Smtp-Source: AIpwx48k4mnvHLCYA7LdNhH3vg7bwwLvpNffQILECNUm13lMDjMPwG/R45+Q4dpJAEo4MdIV5Vm+9Q==
Date: Mon, 23 Apr 2018 22:55:14 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] locking/rwsem: Synchronize task state & waiter->task of
 readers
Message-ID: <20180423205514.GA5876@andrea>
References: <1523380938-19462-1-git-send-email-longman@redhat.com>
 <6c112ecb-d662-b1fc-152a-32060ec46dae@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c112ecb-d662-b1fc-152a-32060ec46dae@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waiman,

On Mon, Apr 23, 2018 at 12:46:12PM -0400, Waiman Long wrote:
> On 04/10/2018 01:22 PM, Waiman Long wrote:
> > It was observed occasionally in PowerPC systems that there was reader
> > who had not been woken up but that its waiter->task had been cleared.

Can you provide more details about these observations?  (links to LKML
posts, traces, applications used/micro-benchmarks, ...)


> >
> > One probable cause of this missed wakeup may be the fact that the
> > waiter->task and the task state have not been properly synchronized as
> > the lock release-acquire pair of different locks in the wakeup code path
> > does not provide a full memory barrier guarantee.

I guess that by the "pair of different locks" you mean (sem->wait_lock,
p->pi_lock), right?  BTW, __rwsem_down_write_failed_common() is calling
wake_up_q() _before_ releasing the wait_lock: did you intend to exclude
this callsite? (why?)


> So smp_store_mb()
> > is now used to set waiter->task to NULL to provide a proper memory
> > barrier for synchronization.

Mmh; the patch is not introducing an smp_store_mb()... My guess is that
you are thinking at the sequence:

	smp_store_release(&waiter->task, NULL);
	[...]
	smp_mb(); /* added with your patch */

or what am I missing?


> >
> > Signed-off-by: Waiman Long <longman@redhat.com>
> > ---
> >  kernel/locking/rwsem-xadd.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
> > index e795908..b3c588c 100644
> > --- a/kernel/locking/rwsem-xadd.c
> > +++ b/kernel/locking/rwsem-xadd.c
> > @@ -209,6 +209,23 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
> >  		smp_store_release(&waiter->task, NULL);
> >  	}
> >  
> > +	/*
> > +	 * To avoid missed wakeup of reader, we need to make sure
> > +	 * that task state and waiter->task are properly synchronized.
> > +	 *
> > +	 *     wakeup		      sleep
> > +	 *     ------		      -----
> > +	 * __rwsem_mark_wake:	rwsem_down_read_failed*:
> > +	 *   [S] waiter->task	  [S] set_current_state(state)
> > +	 *	 MB		      MB
> > +	 * try_to_wake_up:
> > +	 *   [L] state		  [L] waiter->task
> > +	 *
> > +	 * For the wakeup path, the original lock release-acquire pair
> > +	 * does not provide enough guarantee of proper synchronization.
> > +	 */
> > +	smp_mb();
> > +
> >  	adjustment = woken * RWSEM_ACTIVE_READ_BIAS - adjustment;
> >  	if (list_empty(&sem->wait_list)) {
> >  		/* hit end of list above */
> 
> Ping!
> 
> Any thought on this patch?
> 
> I am wondering if there is a cheaper way to apply the memory barrier
> just on architectures that need it.

try_to_wake_up() does:

	raw_spin_lock_irqsave(&p->pi_lock, flags);
	smp_mb__after_spinlock();
	if (!(p->state & state))

My understanding is that this smp_mb__after_spinlock() provides us with
the guarantee you described above.  The smp_mb__after_spinlock() should
represent a 'cheaper way' to provide such a guarantee.

If this understanding is correct, the remaining question would be about
whether you want to rely on (and document) the smp_mb__after_spinlock()
in the callsite in question (the comment in wake_up_q()

   /*
    * wake_up_process() implies a wmb() to pair with the queueing
    * in wake_q_add() so as not to miss wakeups.
    */

does not appear to be suffient...).

  Andrea


> 
> Cheers,
> Longman
> 
