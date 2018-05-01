Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753993AbeEAKTC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 06:19:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41732 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbeEAKTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 06:19:00 -0400
Date: Tue, 1 May 2018 12:18:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Kohli, Gaurav" <gkohli@codeaurora.org>
Cc: tglx@linutronix.de, mpe@ellerman.id.au, mingo@kernel.org,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v1] kthread/smpboot: Serialize kthread parking against
 wakeup
Message-ID: <20180501101845.GE12217@hirez.programming.kicks-ass.net>
References: <1524645199-5596-1-git-send-email-gkohli@codeaurora.org>
 <20180425200917.GZ4082@hirez.programming.kicks-ass.net>
 <20180426084131.GV4129@hirez.programming.kicks-ass.net>
 <20180426085719.GW4129@hirez.programming.kicks-ass.net>
 <4d3f68f8-e599-6b27-a2e8-9e96b401d57a@codeaurora.org>
 <20180430111744.GE4082@hirez.programming.kicks-ass.net>
 <3af3365b-4e3f-e388-8e90-45a3bd4120fd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3af3365b-4e3f-e388-8e90-45a3bd4120fd@codeaurora.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 01:20:26PM +0530, Kohli, Gaurav wrote:
> But In our older case, where we have seen failure below is the wake up path
> and ftraces, Wakeup occured  and completed before schedule call only.
> 
> So final state of CPUHP is running not parked. I have also pasted debug
> ftraces that we got during issue reproduction.
> 
> Here wakeup for cpuhp is below:
> 
> takedown_cpu-> kthread_park-> wake_up_process
> 
> 
>  39,034,311,742,395  apps (10240)        Trace Printk cpuhp/0  (16)  [000]
> 39015.625000: <debug> __kthread_parkme state=512 task=ffffffcc7458e680
> flags: 0x5 -> state 5 -> state is parked inside parkme function
> 
> 39,034,311,846,510  apps (10240)        Trace Printk cpuhp/0  (16)  [000]
> 39015.625000: <debug> before schedule __kthread_parkme state=0
> task=ffffffcc7458e680 flags: 0xd  ->  just before schedule call, state is
> running
> 
> tatic void __kthread_parkme(struct kthread *self)
> 
> {
> 
>         __set_current_state(TASK_PARKED);
> 
>         while (test_bit(KTHREAD_SHOULD_PARK, &self->flags)) {
> 
>                 if (!test_and_set_bit(KTHREAD_IS_PARKED, &self->flags))
> 
>                         complete(&self->parked);
> 
>                 schedule();
> 
>                 __set_current_state(TASK_PARKED);
> 
>         }
> 
>         clear_bit(KTHREAD_IS_PARKED, &self->flags);
> 
>         __set_current_state(TASK_RUNNING);
> 
> }
> 
> So my point is here also, if it is reschedule then it can set TASK_PARKED,
> but it seems after takedown_cpu call this thread never get a chance to run,
> So final state is TASK_RUNNING.
> 
> In our current fix also can't we observe same scenario where final state is
> TASK_RUNNING.

I'm not sure I understand your concern. Loosing the TASK_PARKED store
with the above code is obviously bad. But with the loop as proposed I
don't see a problem.

takedown_cpu() can proceed beyond smpboot_park_threads() and kill the
CPU before any of the threads are parked -- per having the complete()
before hitting schedule().

And, afaict, that is harmless. When we go offline, sched_cpu_dying() ->
migrate_tasks() will migrate any still runnable threads off the cpu.
But because at this point the thread must be in the PARKED wait-loop, it
will hit schedule() and go to sleep eventually.

Also note that kthread_unpark() does __kthread_bind() to rebind the
threads.

Aaaah... I think I've spotted a problem there. We clear SHOULD_PARK
before we rebind, so if the thread lost the first PARKED store,
does the completion, gets migrated, cycles through the loop and now
observes !SHOULD_PARK and bails the wait-loop, then __kthread_bind()
will forever wait.

Is that what you had in mind?
