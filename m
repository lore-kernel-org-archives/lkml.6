Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 432D0607B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeFFNvU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:51:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55936 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751533AbeFFNvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:51:18 -0400
Date: Wed, 6 Jun 2018 15:51:16 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Kohli, Gaurav" <gkohli@codeaurora.org>, tglx@linutronix.de,
        mpe@ellerman.id.au, mingo@kernel.org, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v1] kthread/smpboot: Serialize kthread parking against
 wakeup
Message-ID: <20180606135115.GA4609@redhat.com>
References: <20180502082011.GB12180@hirez.programming.kicks-ass.net>
 <830d7225-af90-a55a-991a-bb2023d538f1@codeaurora.org>
 <cdd5d434-9c11-7c19-2895-0f7f3811eb11@codeaurora.org>
 <55221a5b-dd52-3359-f582-86830dd9f205@codeaurora.org>
 <ba12bc49-33c0-b4ee-05cf-f84124bd66cc@codeaurora.org>
 <20180605150841.GA24053@redhat.com>
 <20180605152212.GY12180@hirez.programming.kicks-ass.net>
 <20180605154053.GB12235@hirez.programming.kicks-ass.net>
 <20180605163515.GB24053@redhat.com>
 <20180605201316.GZ12198@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605201316.GZ12198@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05, Peter Zijlstra wrote:
>
> Also, I think we still need TASK_PARKED as a special state for that.

I think it would be nice to kill the TASK_PARKED state altogether. But I don't
know how. I'll try to look at this code later, but I am not sure I will find a
way to cleanup it...


> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -177,12 +177,24 @@ void *kthread_probe_data(struct task_struct *task)
>  static void __kthread_parkme(struct kthread *self)
>  {
>  	for (;;) {
> -		set_current_state(TASK_PARKED);
> +		/*
> +		 * TASK_PARKED is a special state; we must serialize against
> +		 * possible pending wakeups to avoid store-store collisions on
> +		 * task->state.
> +		 *
> +		 * Such a collision might possibly result in the task state
> +		 * changin from TASK_PARKED and us failing the
> +		 * wait_task_inactive() in kthread_park().
> +		 */
> +		set_special_state(TASK_PARKED);

Agreed,

>  		if (!test_bit(KTHREAD_SHOULD_PARK, &self->flags))
>  			break;
> +
> +		complete_all(&self->parked);
>  		schedule();
>  	}
>  	__set_current_state(TASK_RUNNING);
> +	reinit_completion(&self->parked);

But how can we know that all the callers of kthread_park() have already returned
from wait_for_completion() ?

Oh. The very fact that __kthread_parkme() does complete_all() proves that we need
some serious cleanups. In particular, I think that kthread_park() on a parked kthread
must not be possible.

Just look at this code. It looks as if __kthread_parkme() can race with _unpark()
and thus we need this wait-event-like loop.

But if it can race with _unpark() then kthread_park() can block forever.


For the start, can't we change kthread_park()

	-	set_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
	+ 	if (test_and_set_bit(...))
	+		return -EAGAIN;

and s/complete_all/complete/ in __kthread_parkme() ?

IIUC, this will only affect smpboot_update_cpumask_percpu_thread() which can hit
an already parked thread, but it doesn't need to wait.

And it seems that smpboot_update_cpumask_percpu_thread() in turn needs some cleanups.
Hmm. and its single user: kernel/watchdog.c.

And speaking of watchdog.c, can't we simply kill the "watchdog/%u" threads? This is
off-topic, but can't watchdog_timer_fn() use stop_one_cpu_nowait(watchdog) ?

And I really think we should unexport kthread_park/unpark(), only smpboot_thread_fn()
should use them. kthread() should not play with __kthread_parkme(). And even
KTHREAD_SHOULD_PARK must die, I mean it should live in struct smp_hotplug_thread,
not in struct kthread.

OK, this is off-topic too.

In short, I think this patch is fine but I didn't read it carefully, will try tomorrow.

And, let me repeat, can't we avoid complete_all() ?

Oleg.
