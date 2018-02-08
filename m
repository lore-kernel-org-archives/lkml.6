Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752335AbeBHRpE convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 12:45:04 -0500
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:43458 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752297AbeBHRpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 12:45:02 -0500
Date: Thu, 8 Feb 2018 18:44:52 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Levin Alexander <alexander.levin@verizon.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>, Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Abeni <pabeni@redhat.com>, Radu Rendec <rrendec@arista.com>,
        Ingo Molnar <mingo@kernel.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Rik van Riel <riel@redhat.com>, Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>
Subject: Re: [RFC PATCH 2/4] softirq: Per vector deferment to workqueue
Message-ID: <20180208174450.qjvjy752jf4ngt2g@breakpoint.cc>
References: <1516376774-24076-1-git-send-email-frederic@kernel.org>
 <1516376774-24076-3-git-send-email-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1516376774-24076-3-git-send-email-frederic@kernel.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-01-19 16:46:12 [+0100], Frederic Weisbecker wrote:
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index c8c6841..becb1d9 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -62,6 +62,19 @@ const char * const softirq_to_name[NR_SOFTIRQS] = {
…
> +static void vector_work_func(struct work_struct *work)
> +{
> +	struct vector *vector = container_of(work, struct vector, work);
> +	struct softirq *softirq = this_cpu_ptr(&softirq_cpu);
> +	int vec_nr = vector->nr;
> +	int vec_bit = BIT(vec_nr);
> +	u32 pending;
> +
> +	local_irq_disable();
> +	pending = local_softirq_pending();
> +	account_irq_enter_time(current);
> +	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
> +	lockdep_softirq_enter();
> +	set_softirq_pending(pending & ~vec_bit);
> +	local_irq_enable();
> +
> +	if (pending & vec_bit) {
> +		struct softirq_action *sa = &softirq_vec[vec_nr];
> +
> +		kstat_incr_softirqs_this_cpu(vec_nr);
> +		softirq->work_running = 1;
> +		trace_softirq_entry(vec_nr);
> +		sa->action(sa);

You invoke the softirq handler while BH is disabled (not wrong, I just
state the obvious). That means, the scheduler can't preempt/interrupt
the workqueue/BH-handler while it is invoked so it has to wait until it
completes its doing.
In do_softirq_workqueue() you schedule multiple workqueue items (one for
each softirq vector) which is unnecessary because they can't preempt one
another and should be invoked the order they were enqueued. So it would
be enough to enqueue one item because it is serialized after all. So one
work_struct per CPU with a cond_resched_rcu_qs() while switching from one
vector to another should accomplish that what you have now here (not
sure if that cond_resched after each vector is needed). But…

> +		trace_softirq_exit(vec_nr);
> +		softirq->work_running = 0;
> +	}
> +
> +	local_irq_disable();
> +
> +	pending = local_softirq_pending();
> +	if (pending & vec_bit)
> +		schedule_work_on(smp_processor_id(), &vector->work);

… on a system that is using system_wq a lot, it might introduced a certain
latency until your softirq-worker gets its turn. The workqueue will
spawn new workers if the current worker schedules out but until that
happens you have to wait. I am not sure if this is intended or whether
this might be a problem. I think you could argue either way depending on
what you currently think is more important.
Further, schedule_work_on(x, ) does not guarentee that the work item is
invoked on CPU x. It tries that but if CPU x goes down due to
CPU-hotplug then the workitem will be moved to random CPU. For that
reason we have work_on_cpu_safe() but you don't want to use that / flush
that workqueue while in here.

May I instead suggest to stick to ksoftirqd? So you run in softirq
context (after return from IRQ) and if takes too long, you offload the
vector to ksoftirqd instead. You may want to play with the metric on
which you decide when you want switch to ksoftirqd / account how long a
vector runs.

> +	else
> +		softirq->pending_work_mask &= ~vec_bit;
> +
> +	lockdep_softirq_exit();
> +	account_irq_exit_time(current);
> +	__local_bh_enable(SOFTIRQ_OFFSET);
> +	local_irq_enable();
> +}

Sebastian
