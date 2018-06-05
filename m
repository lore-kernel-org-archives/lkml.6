Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbeFEPWW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:22:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45336 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751599AbeFEPWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:22:20 -0400
Date: Tue, 5 Jun 2018 17:22:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Kohli, Gaurav" <gkohli@codeaurora.org>, tglx@linutronix.de,
        mpe@ellerman.id.au, mingo@kernel.org, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v1] kthread/smpboot: Serialize kthread parking against
 wakeup
Message-ID: <20180605152212.GY12180@hirez.programming.kicks-ass.net>
References: <20180501113132.GF12217@hirez.programming.kicks-ass.net>
 <745d762d-9ab3-0749-9b87-9bb03d913071@codeaurora.org>
 <20180501131904.GG12217@hirez.programming.kicks-ass.net>
 <9b289790-9b3a-73bd-7166-bf39f32cefd8@codeaurora.org>
 <20180502082011.GB12180@hirez.programming.kicks-ass.net>
 <830d7225-af90-a55a-991a-bb2023d538f1@codeaurora.org>
 <cdd5d434-9c11-7c19-2895-0f7f3811eb11@codeaurora.org>
 <55221a5b-dd52-3359-f582-86830dd9f205@codeaurora.org>
 <ba12bc49-33c0-b4ee-05cf-f84124bd66cc@codeaurora.org>
 <20180605150841.GA24053@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605150841.GA24053@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 05:08:41PM +0200, Oleg Nesterov wrote:

> On 06/05, Kohli, Gaurav wrote:
> >
> > As last mentioned on mail, we are still seeing issue with the latest
> > approach and below is the susceptible race as mentioned earlier..
> > controller Thread                               CPUHP Thread
> > takedown_cpu
> > kthread_park
> > kthread_parkme
> > Set KTHREAD_SHOULD_PARK
> >                                                 smpboot_thread_fn
> >                                                 set Task interruptible
> >
> >
> > wake_up_process
> >  if (!(p->state & state))
> >                 goto out;
> >
> >                                                 Kthread_parkme
> >                                                 SET TASK_PARKED
> >                                                 schedule
> >                                                 raw_spin_lock(&rq->lock)
> > ttwu_remote
> > waiting for __task_rq_lock
> >                                                 context_switch
> >
> >                                                 finish_lock_switch
> >
> >
> >
> >                                                 Case TASK_PARKED
> >                                                 kthread_park_complete
> >
> >
> > SET Running
> 
> I think you are right.
> 
> And, now that I look at 85f1abe0019fcb3ea10df7029056cf42702283a8
> ("kthread, sched/wait: Fix kthread_parkme() completion issue") I see this note
> int the changelog:
> 
> 	The alternative is to promote TASK_PARKED to a special state, this
> 	guarantees wait_task_inactive() cannot observe a 'stale' TASK_RUNNING
> 	and we'll end up doing the right thing, but this preserves the whole
> 	icky business of potentially migating the still runnable thing.
> 
> OK, but __kthread_parkme() can be preempted before it calls schedule(), so the
> caller still can be migrated? Plus kthread_park_complete() can be called twice.

Argh... I forgot TASK_DEAD does the whole thing with preempt_disable().
Let me stare at that a bit.
