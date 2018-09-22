Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E57AC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 10:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA0B21523
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 10:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xauF6oXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA0B21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeIVQTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 12:19:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49954 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeIVQTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 12:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3tBh84qLZeYHo7NMsaOL7fLJkS7c0TwrIKBmLOgxSjo=; b=xauF6oXU1OlspiXHta4ABvllu
        MND0YqkMLd9v4Ku6c3sEbeqPRrm62XbRiLKBhqYElp0qsKHaD2MY455bpeWJCylM5hD1QiUtIrvS0
        olKSDYUt2blkEPxxmYga1QbAURwaLxkXIp+viqAjVtky9kihpn3Loljkmj5kMFDk+TuLYAaaIlDsK
        FUapnnYcZ+bX3jovWFoaTUqT7R5UoXjpjxy04w5Eqentz3x4oiKo+bMuWVVBnd7OUlyYKuy6PWQqQ
        5O9PPI00xAc4orlmWTmbRPXhLI3k0BgJnDPRVOFpBIDIVL/7H5VHxiOndEJIRdUqg+7Ze0qLy8arF
        qMO1BCTJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g3f7a-0004bY-8N; Sat, 22 Sep 2018 10:26:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9E2292025483B; Sat, 22 Sep 2018 12:26:40 +0200 (CEST)
Date:   Sat, 22 Sep 2018 12:26:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     PierceGriffiths <pierceagriffiths@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scheduler: conditional statement cleanup
Message-ID: <20180922102640.GG24124@hirez.programming.kicks-ass.net>
References: <20180921202205.11769-1-pierceagriffiths@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921202205.11769-1-pierceagriffiths@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 03:22:03PM -0500, PierceGriffiths wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 625bc9897f62..443a1f235cfd 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -617,12 +617,8 @@ bool sched_can_stop_tick(struct rq *rq)
>  	 * If there are more than one RR tasks, we need the tick to effect the
>  	 * actual RR behaviour.
>  	 */
> -	if (rq->rt.rr_nr_running) {
> -		if (rq->rt.rr_nr_running == 1)
> -			return true;
> -		else
> -			return false;
> -	}
> +	if (rq->rt.rr_nr_running)
> +		return rq->rt.rr_nr_running == 1;
>  
>  	/*
>  	 * If there's no RR tasks, but FIFO tasks, we can skip the tick, no

That one is OK I suppose.

> diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
> index 5e54cbcae673..a8fd4bd68954 100644
> --- a/kernel/sched/cpufreq.c
> +++ b/kernel/sched/cpufreq.c
> @@ -34,10 +34,7 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
>  			void (*func)(struct update_util_data *data, u64 time,
>  				     unsigned int flags))
>  {
> -	if (WARN_ON(!data || !func))
> -		return;
> -
> -	if (WARN_ON(per_cpu(cpufreq_update_util_data, cpu)))
> +	if (WARN_ON(!data || !func || per_cpu(cpufreq_update_util_data, cpu)))
>  		return;
>  
>  	data->func = func;

But I'm not a fan of this one. It mixes a different class of function
and the WARN condition gets too complicated. Its easier to have separate
warns.

> diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
> index daaadf939ccb..152c133e8247 100644
> --- a/kernel/sched/cpupri.c
> +++ b/kernel/sched/cpupri.c
> @@ -29,20 +29,16 @@
>  #include "sched.h"
>  
>  /* Convert between a 140 based task->prio, and our 102 based cpupri */
> -static int convert_prio(int prio)
> +static int convert_prio(const int prio)
>  {
> -	int cpupri;
> -
>  	if (prio == CPUPRI_INVALID)
> -		cpupri = CPUPRI_INVALID;
> +		return CPUPRI_INVALID;
>  	else if (prio == MAX_PRIO)
> -		cpupri = CPUPRI_IDLE;
> +		return CPUPRI_IDLE;
>  	else if (prio >= MAX_RT_PRIO)
> -		cpupri = CPUPRI_NORMAL;
> +		return CPUPRI_NORMAL;
>  	else
> -		cpupri = MAX_RT_PRIO - prio + 1;
> -
> -	return cpupri;
> +		return MAX_RT_PRIO - prio + 1;

The code looks even better if you leave out the last else.

>  }
>  
>  /**
> @@ -95,10 +91,8 @@ int cpupri_find(struct cpupri *cp, struct task_struct *p,
>  		smp_rmb();
>  
>  		/* Need to do the rmb for every iteration */
> -		if (skip)
> -			continue;
> -
> -		if (cpumask_any_and(&p->cpus_allowed, vec->mask) >= nr_cpu_ids)
> +		if (skip || cpumask_any_and(&p->cpus_allowed, vec->mask)
> +				>= nr_cpu_ids)
>  			continue;
>  
>  		if (lowest_mask) {

That just makes the code ugly for no reason.

> @@ -222,7 +216,7 @@ int cpupri_init(struct cpupri *cp)
>  	return 0;
>  
>  cleanup:
> -	for (i--; i >= 0; i--)
> +	while (--i >= 0)
>  		free_cpumask_var(cp->pri_to_cpu[i].mask);
>  	return -ENOMEM;
>  }
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 2e2955a8cf8f..acf1b94669ad 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -142,10 +142,12 @@ void free_rt_sched_group(struct task_group *tg)
>  		destroy_rt_bandwidth(&tg->rt_bandwidth);
>  
>  	for_each_possible_cpu(i) {
> -		if (tg->rt_rq)
> -			kfree(tg->rt_rq[i]);
> -		if (tg->rt_se)
> -			kfree(tg->rt_se[i]);
> +		/* Don't need to check if tg->rt_rq[i]
> +		 * or tg->rt_se[i] are NULL, since kfree(NULL)
> +		 * simply performs no operation
> +		 */

That's an invalid comment style.

> +		kfree(tg->rt_rq[i]);
> +		kfree(tg->rt_se[i]);
>  	}
>  
>  	kfree(tg->rt_rq);
> @@ -1015,10 +1017,7 @@ enqueue_top_rt_rq(struct rt_rq *rt_rq)
>  
>  	BUG_ON(&rq->rt != rt_rq);
>  
> -	if (rt_rq->rt_queued)
> -		return;
> -
> -	if (rt_rq_throttled(rt_rq))
> +	if (rt_rq->rt_queued || rt_rq_throttled(rt_rq))
>  		return;
>  
>  	if (rt_rq->rt_nr_running) {

The compiler can do this transformation and the old code was simpler.

> @@ -1211,10 +1210,7 @@ void dec_rt_tasks(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
>   */
>  static inline bool move_entity(unsigned int flags)
>  {
> -	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) == DEQUEUE_SAVE)
> -		return false;
> -
> -	return true;
> +	return !((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) == DEQUEUE_SAVE)
>  }

Again, I find the new code harder to read.

>  
> @@ -2518,12 +2513,10 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
>  	/*
>  	 * Disallowing the root group RT runtime is BAD, it would disallow the
>  	 * kernel creating (and or operating) RT threads.
> +	 *
> +	 * No period doesn't make any sense.
>  	 */
> -	if (tg == &root_task_group && rt_runtime == 0)
> -		return -EINVAL;
> -
> -	/* No period doesn't make any sense. */
> -	if (rt_period == 0)
> +	if ((tg == &root_task_group && !rt_runtime) || !rt_period)
>  		return -EINVAL;
>  
>  	mutex_lock(&rt_constraints_mutex);

Again, far harder to read.

In short, while all the transformations are 'correct' the end result is
horrible. Please don't do this.
