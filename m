Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751049AbeBIMyG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:54:06 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:42817 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbeBIMyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:54:05 -0500
Date: Fri, 9 Feb 2018 13:53:58 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Rohit Jain <rohit.k.jain@oracle.com>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
        steven.sistare@oracle.com, dhaval.giani@oracle.com, joelaf@google.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, eas-dev@lists.linaro.org
Subject: Re: [RESEND PATCH] sched/fair: consider RT/IRQ pressure in
 select_idle_sibling
Message-ID: <20180209125358.GO25201@hirez.programming.kicks-ass.net>
References: <1517268429-933-1-git-send-email-rohit.k.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517268429-933-1-git-send-email-rohit.k.jain@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 03:27:09PM -0800, Rohit Jain wrote:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 26a71eb..ce5ccf8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5625,6 +5625,11 @@ static unsigned long capacity_orig_of(int cpu)
>  	return cpu_rq(cpu)->cpu_capacity_orig;
>  }
>  
> +static inline bool full_capacity(int cpu)
> +{
> +	return capacity_of(cpu) >= (capacity_orig_of(cpu)*3)/4;
> +}

I don't like that name; >.75 != 1.

Maybe invert things and do something like:

static inline bool reduced_capacity(int cpu)
{
	return capacity_of(cpu) < (3*capacity_orig_of(cpu))/4;
}

> @@ -6110,11 +6116,13 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
>  	for_each_cpu(cpu, cpu_smt_mask(target)) {
>  		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
>  			continue;
> +		if (idle_cpu(cpu) && (capacity_of(cpu) > max_cap)) {
> +			max_cap = capacity_of(cpu);
> +			rcpu = cpu;
> +		}

		if (idle_cpu(cpu)) {
			if (!reduced_capacity(cpu))
				return cpu;

			if (capacity_cpu(cpu) > max_cap) {
				max_cap = capacity_cpu(cpu);
				rcpu = cpu;
			}
		}

Would be more consistent, I think.

>  	}
>  
> -	return -1;
> +	return rcpu;
>  }



> @@ -6143,6 +6151,8 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  	u64 time, cost;
>  	s64 delta;
>  	int cpu, nr = INT_MAX;
> +	int best_cpu = -1;
> +	unsigned int best_cap = 0;

Randomly different names for the same thing as in select_idle_smt().
Thinking up two different names for the same thing is more work; be more
lazy.

>  	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
>  	if (!this_sd)
> @@ -6173,8 +6183,15 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  			return -1;
>  		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
>  			continue;
> +		if (idle_cpu(cpu)) {
> +			if (full_capacity(cpu)) {
> +				best_cpu = cpu;
> +				break;
> +			} else if (capacity_of(cpu) > best_cap) {
> +				best_cap = capacity_of(cpu);
> +				best_cpu = cpu;
> +			}
> +		}

No need for the else. And you'll note you're once again inconsistent
with your previous self.

But here I worry about big.little a wee bit. I think we're allowed big
and little cores on the same L3 these days, and you can't directly
compare capacity between them.

Morten / Dietmar, any comments?

> @@ -6193,13 +6210,14 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	struct sched_domain *sd;
>  	int i;
>  
> -	if (idle_cpu(target))
> +	if (idle_cpu(target) && full_capacity(target))
>  		return target;
>  
>  	/*
>  	 * If the previous cpu is cache affine and idle, don't be stupid.
>  	 */
> -	if (prev != target && cpus_share_cache(prev, target) && idle_cpu(prev))
> +	if (prev != target && cpus_share_cache(prev, target) && idle_cpu(prev) &&
> +	    full_capacity(prev))
>  		return prev;

split before idle_cpu() for a better balance.
