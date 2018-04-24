Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755962AbeDXF0s (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 01:26:48 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38698 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752110AbeDXF0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 01:26:44 -0400
X-Google-Smtp-Source: AIpwx4/7ww7QkRlHkPDAViXGx9IXkmM/WCmMyvBuUl5VSJ5tEevsnZr7At/+wd94BcQ9MghG2hlVCQ==
Date: Tue, 24 Apr 2018 15:26:30 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] kernel/sched/core: busy wait before going idle
Message-ID: <20180424152630.46e9de59@roar.ozlabs.ibm.com>
In-Reply-To: <20180423101740.GA28936@codeaurora.org>
References: <20180415133149.24112-1-npiggin@gmail.com>
        <20180423101740.GA28936@codeaurora.org>
Organization: IBM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2018 15:47:40 +0530
Pavan Kondeti <pkondeti@codeaurora.org> wrote:

> Hi Nick,
> 
> On Sun, Apr 15, 2018 at 11:31:49PM +1000, Nicholas Piggin wrote:
> > This is a quick hack for comments, but I've always wondered --
> > if we have a short term polling idle states in cpuidle for performance
> > -- why not skip the context switch and entry into all the idle states,
> > and just wait for a bit to see if something wakes up again.
> > 
> > It's not uncommon to see various going-to-idle work in kernel profiles.
> > This might be a way to reduce that (and just the cost of switching
> > registers and kernel stack to idle thread). This can be an important
> > path for single thread request-response throughput.
> > 
> > tbench bandwidth seems to be improved (the numbers aren't too stable
> > but they pretty consistently show some gain). 10-20% would be a pretty
> > nice gain for such workloads
> > 
> > clients     1     2     4     8    16   128
> > vanilla   232   467   823  1819  3218  9065
> > patched   310   503   962  2465  3743  9820
> >   
> 
> <snip>
> 
> > +idle_spin_end:
> >  	/* Promote REQ to ACT */
> >  	rq->clock_update_flags <<= 1;
> >  	update_rq_clock(rq);
> > @@ -3437,6 +3439,32 @@ static void __sched notrace __schedule(bool preempt)
> >  		if (unlikely(signal_pending_state(prev->state, prev))) {
> >  			prev->state = TASK_RUNNING;
> >  		} else {
> > +			/*
> > +			 * Busy wait before switching to idle thread. This
> > +			 * is marked unlikely because we're idle so jumping
> > +			 * out of line doesn't matter too much.
> > +			 */
> > +			if (unlikely(do_idle_spin && rq->nr_running == 1)) {
> > +				u64 start;
> > +
> > +				do_idle_spin = false;
> > +
> > +				rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
> > +				rq_unlock_irq(rq, &rf);
> > +
> > +				spin_begin();
> > +				start = local_clock();
> > +				while (!need_resched() && prev->state &&
> > +					!signal_pending_state(prev->state, prev)) {
> > +					spin_cpu_relax();
> > +					if (local_clock() - start > 1000000)
> > +						break;
> > +				}  
> 
> Couple of comments/questions.
> 
> When a RT task is doing this busy loop, 
> 
> (1) need_resched() may not be set even if a fair/normal task is enqueued on
> this CPU.

This is true, it should probably spin on nr_running == 1, good catch.

> 
> (2) Any lower prio RT task waking up on this CPU may migrate to another CPU
> thinking this CPU is busy with higher prio RT task.

Also true. If we completely replaced the polling idle states with a
spin here, this would not be acceptable and it would have to be quite
a lot more work to interact with load calculations etc.

On the other hand if it is a much smaller spin on the order of
context switch latency that could be considered part of the cost
of context switching for the purposes of load balancing, *maybe*
not much else is need.

Thanks,
Nick
