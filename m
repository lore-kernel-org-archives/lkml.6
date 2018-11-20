Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058E8C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6AB620989
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iK4LFosW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6AB620989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbeKUArZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:47:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60212 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbeKUArZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:47:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JYki+xWxe0rWP6C89Pvnwup76KGz/u9WDhQ1+AsoZxU=; b=iK4LFosWQr9FpOTDFDkqE4Lj+
        JJpyvs+bUxzeQ+9nyMs63h//kJ7HzexiDQ1Q0d2WvyF0WVM1naX+Ru8qX5oP3PiacZY71mGYcLuK7
        vgOrmDrOUteSZiABOH7ViZj0PQlXeR/BWy1gXhUwhxuYZZ0CJWzmaGUMbX9UJpquxs+oaLqV8+PMt
        ekoCg2xCmqomWaP+Ufq/+b2aR4aGXioLY9HwRccmbDJ8yBphcz0J9/ikmI1VhjZGiJfC1FGxizi48
        XTPQcGT3ndOc5Cin+khj7aNvyE8c7+g7SL/KxEfWVH7qtGZCLZt67UuP3iLNxu01S2moxAUcPx8M4
        Ixah16eNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gP6qh-0005Wx-S7; Tue, 20 Nov 2018 14:17:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F6452029F87F; Tue, 20 Nov 2018 15:17:54 +0100 (CET)
Date:   Tue, 20 Nov 2018 15:17:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 19/25] sched/vite: Handle nice updates under vtime
Message-ID: <20181120141754.GW2131@hirez.programming.kicks-ass.net>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
 <1542163569-20047-20-git-send-email-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542163569-20047-20-git-send-email-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 03:46:03AM +0100, Frederic Weisbecker wrote:
> On the vtime level, nice updates are currently handled on context
> switches. When a task's nice value gets updated while it is sleeping,
> the context switch takes into account the new nice value in order to
> later record the vtime delta to the appropriate kcpustat index.

Urgh, so this patch should be folded into the previous one. On their own
neither really makes sense.

> We have yet to handle live updates: when set_user_nice() is called
> while the target is running. We'll handle that on two sides:
> 
> * If the caller of set_user_nice() is the current task, we update the
>   vtime state in place.
> 
> * If the target runs on a different CPU, we interrupt it with an IPI to
>   update the vtime state in place.

*groan*... So what are the rules for vtime updates? Who can do that
when?

So when we change nice, we'll have the respective rq locked and task
effectively unqueued. It cannot schedule at such a point. Can
'concurrent' vtime updates still happen?

> The vtime update in question consists in flushing the pending vtime
> delta to the task/kcpustat and resume the accounting on top of the new
> nice value.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f12225f..e8f0437 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3868,6 +3868,7 @@ void set_user_nice(struct task_struct *p, long nice)
>  	int old_prio, delta;
>  	struct rq_flags rf;
>  	struct rq *rq;
> +	long old_nice;
>  
>  	if (task_nice(p) == nice || nice < MIN_NICE || nice > MAX_NICE)
>  		return;
> @@ -3878,6 +3879,8 @@ void set_user_nice(struct task_struct *p, long nice)
>  	rq = task_rq_lock(p, &rf);
>  	update_rq_clock(rq);
>  
> +	old_nice = task_nice(p);
> +
>  	/*
>  	 * The RT priorities are set via sched_setscheduler(), but we still
>  	 * allow the 'normal' nice value to be set - but as expected
> @@ -3913,6 +3916,7 @@ void set_user_nice(struct task_struct *p, long nice)
>  	if (running)
>  		set_curr_task(rq, p);
>  out_unlock:
> +	vtime_set_nice(rq, p, old_nice);
>  	task_rq_unlock(rq, p, &rf);
>  }

That's not sufficient; I think you want to hook set_load_weight() or
something. Things like sys_sched_setattr() can also change the nice
value.

>  EXPORT_SYMBOL(set_user_nice);
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index 07c2e7f..2b35132 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c

> @@ -937,6 +937,33 @@ void vtime_exit_task(struct task_struct *t)
>  	local_irq_restore(flags);
>  }
>  
> +void vtime_set_nice_local(struct task_struct *t)
> +{
> +	struct vtime *vtime = &t->vtime;
> +
> +	write_seqcount_begin(&vtime->seqcount);
> +	if (vtime->state == VTIME_USER)
> +		vtime_account_user(t, vtime, true);
> +	else if (vtime->state == VTIME_GUEST)
> +		vtime_account_guest(t, vtime, true);
> +	vtime->nice = (task_nice(t) > 0) ? 1 : 0;
> +	write_seqcount_end(&vtime->seqcount);
> +}
> +
> +static void vtime_set_nice_func(struct irq_work *work)
> +{
> +	vtime_set_nice_local(current);
> +}
> +
> +static DEFINE_PER_CPU(struct irq_work, vtime_set_nice_work) = {
> +	.func = vtime_set_nice_func,
> +};
> +
> +void vtime_set_nice_remote(int cpu)
> +{
> +	irq_work_queue_on(&per_cpu(vtime_set_nice_work, cpu), cpu);

What happens if you already had one pending? Do we loose updates?

> +}
> +
>  u64 task_gtime(struct task_struct *t)
>  {
>  	struct vtime *vtime = &t->vtime;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 618577f..c7846ca 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1790,6 +1790,45 @@ static inline int sched_tick_offload_init(void) { return 0; }
>  static inline void sched_update_tick_dependency(struct rq *rq) { }
>  #endif
>  
> +static inline void vtime_set_nice(struct rq *rq,
> +				  struct task_struct *p, long old_nice)
> +{
> +#ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
> +	long nice;
> +	int cpu;
> +
> +	if (!vtime_accounting_enabled())
> +		return;
> +
> +	cpu = cpu_of(rq);
> +
> +	if (!vtime_accounting_enabled_cpu(cpu))
> +		return;
> +
> +	/*
> +	 * Task not running, nice update will be seen by vtime on its
> +	 * next context switch.
> +	 */
> +	if (!task_current(rq, p))
> +		return;
> +
> +	nice = task_nice(p);
> +
> +	/* Task stays nice, still accounted as nice in kcpustat */
> +	if (old_nice > 0 && nice > 0)
> +		return;
> +
> +	/* Task stays rude, still accounted as non-nice in kcpustat */
> +	if (old_nice <= 0 && nice <= 0)
> +		return;
> +
> +	if (p == current)
> +		vtime_set_nice_local(p);
> +	else
> +		vtime_set_nice_remote(cpu);
> +#endif
> +}

That's _far_ too large for an inline I'm thinking. Also, changing nice
really isn't a fast path or anything.
