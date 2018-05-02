Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbeEBFQH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 01:16:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55362 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751020AbeEBFQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 01:16:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 261F960585
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: [PATCH v1] kthread/smpboot: Serialize kthread parking against
 wakeup
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, mpe@ellerman.id.au, mingo@kernel.org,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, Oleg Nesterov <oleg@redhat.com>
References: <20180425200917.GZ4082@hirez.programming.kicks-ass.net>
 <20180426084131.GV4129@hirez.programming.kicks-ass.net>
 <20180426085719.GW4129@hirez.programming.kicks-ass.net>
 <4d3f68f8-e599-6b27-a2e8-9e96b401d57a@codeaurora.org>
 <20180430111744.GE4082@hirez.programming.kicks-ass.net>
 <3af3365b-4e3f-e388-8e90-45a3bd4120fd@codeaurora.org>
 <20180501101845.GE12217@hirez.programming.kicks-ass.net>
 <f134c8d8-e56f-bf29-0177-e6702ae79f2b@codeaurora.org>
 <20180501113132.GF12217@hirez.programming.kicks-ass.net>
 <745d762d-9ab3-0749-9b87-9bb03d913071@codeaurora.org>
 <20180501131904.GG12217@hirez.programming.kicks-ass.net>
From: "Kohli, Gaurav" <gkohli@codeaurora.org>
Message-ID: <9b289790-9b3a-73bd-7166-bf39f32cefd8@codeaurora.org>
Date: Wed, 2 May 2018 10:45:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501131904.GG12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/1/2018 6:49 PM, Peter Zijlstra wrote:
>> On 5/1/2018 5:01 PM, Peter Zijlstra wrote:
> 
>>> Let me ponder what the best solution is, it's a bit of a mess.
> 
> So there's:
> 
>   - TASK_PARKED, which we can make a special state; this solves the
>     problem because then wait_task_inactive() is guaranteed to see
>     TASK_PARKED and DTRT.

Yes this should work, as it takes pi-lock and blocking kthread_parkme.
> 
>   - complete(&kthread->parked), which we can do inside schedule(); this
>     solves the problem because then kthread_park() will not return early
>     and the task really is blocked.

I think complete will not help, as problem is like below :

Control Thread                                CPUHP thread
					
					      cpuhp_thread_fun
					      Wake control thread
					      complete(&st->done);

takedown_cpu
kthread_park
set_bit(KTHREAD_SHOULD_PARK

					     Here cpuhp is looping,
					//success case
					     Generally when issue is not
					     coming
					     it schedule out by below :
                                            ht->thread_should_run(td->cpu
					      scheduler
					//failure case
					before schedule
					loop check
					(kthread_should_park()
				         enter here as PARKED set

wake_up_process(k)
					__kthread_parkme
					 complete(&self->parked);
SETS RUNNING
		                         schedule			
wait_for_completion(&kthread->parked);


So even we protect complete, it may see TASK_RUNNING as final state.
That's why we took pi-lock , So wake_up_process either see TASK_RUNNING
so return or it will exit early before parkme call.

Please correct me , if i misunderstood it. With pi-lock approach we are 
not seeing issue. SO you first solution should fix this(put parked in 
special state).

Regards
Gaurav
					

> 
> and I'm fairly sure I thought of a 3rd way to cure things, but now that
> I'm writing things down I cannot seem to remember :/ -- could be we muck
> with wait_task_inactive().
> 
> In any case, I hate all of them, but I think the completion one is the
> least horrible because it gives the strongest guarantees and cleans up
> most. But promoting TASK_PARKED to special certainly is the earier
> patch.
> 
> The below boots, but that's about all I did with it. Opinions?
> 
> ---
> 
> --- a/include/linux/kthread.h
> +++ b/include/linux/kthread.h
> @@ -62,6 +62,7 @@ void *kthread_probe_data(struct task_str
>   int kthread_park(struct task_struct *k);
>   void kthread_unpark(struct task_struct *k);
>   void kthread_parkme(void);
> +void kthread_park_complete(struct task_struct *k);
>   
>   int kthreadd(void *unused);
>   extern struct task_struct *kthreadd_task;
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -55,7 +55,6 @@ enum KTHREAD_BITS {
>   	KTHREAD_IS_PER_CPU = 0,
>   	KTHREAD_SHOULD_STOP,
>   	KTHREAD_SHOULD_PARK,
> -	KTHREAD_IS_PARKED,
>   };
>   
>   static inline void set_kthread_struct(void *kthread)
> @@ -177,14 +176,12 @@ void *kthread_probe_data(struct task_str
>   
>   static void __kthread_parkme(struct kthread *self)
>   {
> -	__set_current_state(TASK_PARKED);
> -	while (test_bit(KTHREAD_SHOULD_PARK, &self->flags)) {
> -		if (!test_and_set_bit(KTHREAD_IS_PARKED, &self->flags))
> -			complete(&self->parked);
> +	for (;;) {
> +		set_current_state(TASK_PARKED);
> +		if (!test_bit(KTHREAD_SHOULD_PARK, &self->flags))
> +			break;
>   		schedule();
> -		__set_current_state(TASK_PARKED);
>   	}
> -	clear_bit(KTHREAD_IS_PARKED, &self->flags);
>   	__set_current_state(TASK_RUNNING);
>   }
>   
> @@ -194,6 +191,11 @@ void kthread_parkme(void)
>   }
>   EXPORT_SYMBOL_GPL(kthread_parkme);
>   
> +void kthread_park_complete(struct task_struct *k)
> +{
> +	complete(&to_kthread(k)->parked);
> +}
> +
>   static int kthread(void *_create)
>   {
>   	/* Copy data: it's on kthread's stack */
> @@ -450,22 +452,15 @@ void kthread_unpark(struct task_struct *
>   {
>   	struct kthread *kthread = to_kthread(k);
>   
> -	clear_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
>   	/*
> -	 * We clear the IS_PARKED bit here as we don't wait
> -	 * until the task has left the park code. So if we'd
> -	 * park before that happens we'd see the IS_PARKED bit
> -	 * which might be about to be cleared.
> +	 * Newly created kthread was parked when the CPU was offline.
> +	 * The binding was lost and we need to set it again.
>   	 */
> -	if (test_and_clear_bit(KTHREAD_IS_PARKED, &kthread->flags)) {
> -		/*
> -		 * Newly created kthread was parked when the CPU was offline.
> -		 * The binding was lost and we need to set it again.
> -		 */
> -		if (test_bit(KTHREAD_IS_PER_CPU, &kthread->flags))
> -			__kthread_bind(k, kthread->cpu, TASK_PARKED);
> -		wake_up_state(k, TASK_PARKED);
> -	}
> +	if (test_bit(KTHREAD_IS_PER_CPU, &kthread->flags))
> +		__kthread_bind(k, kthread->cpu, TASK_PARKED);
> +
> +	clear_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
> +	wake_up_state(k, TASK_PARKED);
>   }
>   EXPORT_SYMBOL_GPL(kthread_unpark);
>   
> @@ -488,12 +483,13 @@ int kthread_park(struct task_struct *k)
>   	if (WARN_ON(k->flags & PF_EXITING))
>   		return -ENOSYS;
>   
> -	if (!test_bit(KTHREAD_IS_PARKED, &kthread->flags)) {
> -		set_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
> -		if (k != current) {
> -			wake_up_process(k);
> -			wait_for_completion(&kthread->parked);
> -		}
> +	if (WARN_ON_ONCE(test_bit(KTHREAD_SHOULD_PARK, &kthread->flags)))
> +		return -EBUSY;
> +
> +	set_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
> +	if (k != current) {
> +		wake_up_process(k);
> +		wait_for_completion(&kthread->parked);
>   	}
>   
>   	return 0;
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7,6 +7,8 @@
>    */
>   #include "sched.h"
>   
> +#include <linux/kthread.h>
> +
>   #include <asm/switch_to.h>
>   #include <asm/tlb.h>
>   
> @@ -2718,20 +2720,28 @@ static struct rq *finish_task_switch(str
>   		membarrier_mm_sync_core_before_usermode(mm);
>   		mmdrop(mm);
>   	}
> -	if (unlikely(prev_state == TASK_DEAD)) {
> -		if (prev->sched_class->task_dead)
> -			prev->sched_class->task_dead(prev);
> +	if (unlikely(prev_state & (TASK_DEAD|TASK_PARKED))) {
> +		switch (prev_state) {
> +		case TASK_DEAD:
> +			if (prev->sched_class->task_dead)
> +				prev->sched_class->task_dead(prev);
> +
> +			/*
> +			 * Remove function-return probe instances associated with this
> +			 * task and put them back on the free list.
> +			 */
> +			kprobe_flush_task(prev);
>   
> -		/*
> -		 * Remove function-return probe instances associated with this
> -		 * task and put them back on the free list.
> -		 */
> -		kprobe_flush_task(prev);
> +			/* Task is done with its stack. */
> +			put_task_stack(prev);
>   
> -		/* Task is done with its stack. */
> -		put_task_stack(prev);
> +			put_task_struct(prev);
> +			break;
>   
> -		put_task_struct(prev);
> +		case TASK_PARKED:
> +			kthread_park_complete(prev);
> +			break;
> +		}
>   	}
>   
>   	tick_nohz_task_switch();
> 

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, 
Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
