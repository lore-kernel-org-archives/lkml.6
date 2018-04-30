Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752534AbeD3LRz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 07:17:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33280 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbeD3LRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 07:17:53 -0400
Date: Mon, 30 Apr 2018 13:17:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Kohli, Gaurav" <gkohli@codeaurora.org>
Cc: tglx@linutronix.de, mpe@ellerman.id.au, mingo@kernel.org,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v1] kthread/smpboot: Serialize kthread parking against
 wakeup
Message-ID: <20180430111744.GE4082@hirez.programming.kicks-ass.net>
References: <1524645199-5596-1-git-send-email-gkohli@codeaurora.org>
 <20180425200917.GZ4082@hirez.programming.kicks-ass.net>
 <20180426084131.GV4129@hirez.programming.kicks-ass.net>
 <20180426085719.GW4129@hirez.programming.kicks-ass.net>
 <4d3f68f8-e599-6b27-a2e8-9e96b401d57a@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d3f68f8-e599-6b27-a2e8-9e96b401d57a@codeaurora.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 09:23:25PM +0530, Kohli, Gaurav wrote:
> On 4/26/2018 2:27 PM, Peter Zijlstra wrote:
> 
> > On Thu, Apr 26, 2018 at 10:41:31AM +0200, Peter Zijlstra wrote:
> > > diff --git a/kernel/kthread.c b/kernel/kthread.c
> > > index cd50e99202b0..4b6503c6a029 100644
> > > --- a/kernel/kthread.c
> > > +++ b/kernel/kthread.c
> > > @@ -177,12 +177,13 @@ void *kthread_probe_data(struct task_struct *task)
> > >   static void __kthread_parkme(struct kthread *self)
> > >   {
> > > -	__set_current_state(TASK_PARKED);
> > > -	while (test_bit(KTHREAD_SHOULD_PARK, &self->flags)) {
> > > +	for (;;) {
> > > +		__set_task_state(TASK_PARKED);
> > 		set_current_state(TASK_PARKED);
> > 
> > of course..
> 
> Hi Peter,
> 
> Maybe i am missing something , but still that race can come as we don't put task_parked on special state.
> 
> Controller                                                                       Hotplug
> 
>                                                                                  Loop
> 
>                                                                                  Task_Interruptible
> 
> Set SHOULD_PARK
> 
> wakeup -> Proceeds
> 
>                                                                                   Set Running
> 
>                                                                                   kthread_parkme
> 
>                                                                                   SET TASK_PARKED
> 
>                                                                                   schedule
> 
> Set TASK_RUNNING
> 
> Can you please correct ME, if I misunderstood this.

If that could happen, all wait-loops would be broken. However,
AFAICT that cannot happen, because ttwu_remote() and schedule()
serialize on rq->lock. See:


A						B

for (;;) {
	set_current_state(UNINTERRUPTIBLE);

						cond1 = true;
						wake_up_process(A)
						  lock(A->pi_lock)
						  smp_mb__after_spinlock()
						  if (A->state & TASK_NORMAL)
						    A->on_rq && ttwu_remote()
	if (cond1) // true
		break;
	schedule();
}
__set_current_state(RUNNING);

for (;;) {
	set_current_state(UNINTERRUPTIBLE);
	if (cond2)
		break;

	schedule();
	  lock(rq->lock)
	  smp_mb__after_spinlock();
	  deactivate_task(A);
	  <sched-out>
	  unlock(rq->lock);
						      rq = __task_rq_lock(A)
						      if (A->on_rq) // false
						        A->state = TASK_RUNNING;
						      __task_rq_unlock(rq)


Either A's schedule() must observe RUNNING (not shown) or B must
observe !A->on_rq (shown) and not issue the store.
