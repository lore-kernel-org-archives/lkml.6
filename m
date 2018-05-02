Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751412AbeEBIUa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 04:20:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52796 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbeEBIU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 04:20:27 -0400
Date: Wed, 2 May 2018 10:20:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Kohli, Gaurav" <gkohli@codeaurora.org>
Cc: tglx@linutronix.de, mpe@ellerman.id.au, mingo@kernel.org,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v1] kthread/smpboot: Serialize kthread parking against
 wakeup
Message-ID: <20180502082011.GB12180@hirez.programming.kicks-ass.net>
References: <20180426085719.GW4129@hirez.programming.kicks-ass.net>
 <4d3f68f8-e599-6b27-a2e8-9e96b401d57a@codeaurora.org>
 <20180430111744.GE4082@hirez.programming.kicks-ass.net>
 <3af3365b-4e3f-e388-8e90-45a3bd4120fd@codeaurora.org>
 <20180501101845.GE12217@hirez.programming.kicks-ass.net>
 <f134c8d8-e56f-bf29-0177-e6702ae79f2b@codeaurora.org>
 <20180501113132.GF12217@hirez.programming.kicks-ass.net>
 <745d762d-9ab3-0749-9b87-9bb03d913071@codeaurora.org>
 <20180501131904.GG12217@hirez.programming.kicks-ass.net>
 <9b289790-9b3a-73bd-7166-bf39f32cefd8@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b289790-9b3a-73bd-7166-bf39f32cefd8@codeaurora.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 10:45:52AM +0530, Kohli, Gaurav wrote:
> On 5/1/2018 6:49 PM, Peter Zijlstra wrote:

> >   - complete(&kthread->parked), which we can do inside schedule(); this
> >     solves the problem because then kthread_park() will not return early
> >     and the task really is blocked.
> 
> I think complete will not help, as problem is like below :
> 
> Control Thread                                CPUHP thread
> 					
> 					      cpuhp_thread_fun
> 					      Wake control thread
> 					      complete(&st->done);
> 
> takedown_cpu
> kthread_park
> set_bit(KTHREAD_SHOULD_PARK
> 
> 					     Here cpuhp is looping,
> 					//success case
> 					     Generally when issue is not
> 					     coming
> 					     it schedule out by below :
>                                            ht->thread_should_run(td->cpu
> 					      scheduler
> 					//failure case
> 					before schedule
> 					loop check
> 					(kthread_should_park()
> 				         enter here as PARKED set
> 
> wake_up_process(k)

If k has TASK_PARKED, then wake_up_process() which uses TASK_NORMAL will
no-op, because:

	TASK_PARKED & TASK_NORMAL == 0

> 					__kthread_parkme
> 					 complete(&self->parked);
> SETS RUNNING
> 		                         schedule			

But suppose, you do get that store, and we get to schedule with
TASK_RUNNING, then schedule will no-op and we'll go around the loop and
not complete.

See also: lkml.kernel.org/r/20180430111744.GE4082@hirez.programming.kicks-ass.net

Either TASK_RUNNING gets set before we do schedule() and we go around
again, re-set TASK_PARKED, resched the condition and re-call schedule(),
or we schedule() first and ttwu() will not issue the TASK_RUNNING store.

In either case, we'll eventually hit schedule() with TASK_PARKED. Then,
and only then will the complete() happen.

> wait_for_completion(&kthread->parked);

The point is, we'll only ever complete ^ that completion when we've
scheduled out the task in TASK_PARKED state. If the task didn't get
parked, no completion.


And that is the reason I like this approach above the others. It
guarantees the task really is parked when we ask for it. We don't have
to deal with the task still running and getting migrated to another CPU
nonsense.
