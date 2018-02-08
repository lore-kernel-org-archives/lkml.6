Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752155AbeBHMq5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 07:46:57 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34636 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752018AbeBHMqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 07:46:55 -0500
Subject: Re: [PATCH v2 1/3] sched: Stop nohz stats when decayed
To: Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Cc: morten.rasmussen@foss.arm.com, brendan.jackman@arm.com,
        dietmar.eggemann@arm.com
References: <1517944987-343-1-git-send-email-vincent.guittot@linaro.org>
 <1517944987-343-2-git-send-email-vincent.guittot@linaro.org>
From: Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <780a5b3a-4829-4195-c8fd-95da27248a82@arm.com>
Date: Thu, 8 Feb 2018 12:46:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1517944987-343-2-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2018 07:23 PM, Vincent Guittot wrote:
> [...]
> @@ -7826,8 +7842,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
>  		struct rq *rq = cpu_rq(i);
>  
> -		if (env->flags & LBF_NOHZ_STATS)
> -			update_nohz_stats(rq);
> +		if ((env->flags & LBF_NOHZ_STATS) && update_nohz_stats(rq))
> +			env->flags |= LBF_NOHZ_AGAIN;
>  
>  		/* Bias balancing toward cpus of our domain */
>  		if (local_group)
> @@ -7979,18 +7995,15 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  	struct sg_lb_stats *local = &sds->local_stat;
>  	struct sg_lb_stats tmp_sgs;
>  	int load_idx, prefer_sibling = 0;
> +	int has_blocked = READ_ONCE(nohz.has_blocked);
>  	bool overload = false;
>  
>  	if (child && child->flags & SD_PREFER_SIBLING)
>  		prefer_sibling = 1;
>  
>  #ifdef CONFIG_NO_HZ_COMMON
> -	if (env->idle == CPU_NEWLY_IDLE) {
> +	if (env->idle == CPU_NEWLY_IDLE && has_blocked)
>  		env->flags |= LBF_NOHZ_STATS;
> -
> -		if (cpumask_subset(nohz.idle_cpus_mask, sched_domain_span(env->sd)))
> -			nohz.next_stats = jiffies + msecs_to_jiffies(LOAD_AVG_PERIOD);
> -	}
>  #endif
>  
>  	load_idx = get_sd_load_idx(env->sd, env->idle);
> @@ -8046,6 +8059,15 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  		sg = sg->next;
>  	} while (sg != env->sd->groups);
>  
> +#ifdef CONFIG_NO_HZ_COMMON
> +	if ((env->flags & LBF_NOHZ_AGAIN) &&
> +	    cpumask_subset(nohz.idle_cpus_mask, sched_domain_span(env->sd))) {
> +
> +		WRITE_ONCE(nohz.next_blocked,
> +				jiffies + msecs_to_jiffies(LOAD_AVG_PERIOD));

Here we push the stats update forward if we visited all the nohz CPUs but they
still have blocked load. IMO we should also clear the nohz.has_blocked flag
if we visited all the nohz CPUs and none had blocked load left.

If we don't do that, we could very well have cleared all of the nohz blocked
load in idle_balance and successfully pulled a task, but the flag isn't
cleared so we'll end up doing a _nohz_idle_balance() later on for nothing.


As I said in a previous comment, we also have this problem with periodic
load balance: if a CPU goes nohz (nohz.has_blocked is raised) but wakes up,
e.g. before the next nohz.next_blocked, we should stop kicking ILBs

Now I'd need to test this, but I think it can actually get worse: if that 
CPU keeps generating blocked load after this short idle period, no matter 
how many _nohz_idle_balance() we go through we will never reach a point 
where nohz.has_blocked gets cleared, and we'll keep kicking those ILBs to
update blocked load that already gets updated in the periodic balance.

I think that's where a nohz blocked load cpumask can also help: on top of
skipping nohz CPUs that don't need an update, we can stop the whole remote
update machinery when the last nohz cpu with blocked load wakes up, or say
when it goes through its first periodic balance.

> +	}
> +#endif
> +
