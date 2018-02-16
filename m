Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966213AbeBPMNN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 07:13:13 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39044 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965852AbeBPMNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 07:13:12 -0500
Subject: Re: [PATCH v5 1/3] sched: Stop nohz stats when decayed
To: Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Cc: morten.rasmussen@foss.arm.com, brendan.jackman@arm.com,
        dietmar.eggemann@arm.com
References: <1518622006-16089-1-git-send-email-vincent.guittot@linaro.org>
 <1518622006-16089-2-git-send-email-vincent.guittot@linaro.org>
From: Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <44a7d9dc-f6f3-e003-44d6-b0c4aa7dc046@arm.com>
Date: Fri, 16 Feb 2018 12:13:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518622006-16089-2-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/14/2018 03:26 PM, Vincent Guittot wrote:
> Stopped the periodic update of blocked load when all idle CPUs have fully
> decayed. We introduce a new nohz.has_blocked that reflect if some idle
> CPUs has blocked load that have to be periodiccally updated. nohz.has_blocked
> is set everytime that a Idle CPU can have blocked load and it is then clear
> when no more blocked load has been detected during an update. We don't need
> atomic operation but only to make cure of the right ordering when updating
> nohz.idle_cpus_mask and nohz.has_blocked.
> 
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c  | 122 ++++++++++++++++++++++++++++++++++++++++++---------
>  kernel/sched/sched.h |   1 +
>  2 files changed, 102 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7af1fa9..5a6835e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
>
> [...]
>> @@ -9374,6 +9427,22 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>  
>  	SCHED_WARN_ON((flags & NOHZ_KICK_MASK) == NOHZ_BALANCE_KICK);
>  
> +	/*
> +	 * We assume there will be no idle load after this update and clear
> +	 * the has_blocked flag. If a cpu enters idle in the mean time, it will
> +	 * set the has_blocked flag and trig another update of idle load.
> +	 * Because a cpu that becomes idle, is added to idle_cpus_mask before
> +	 * setting the flag, we are sure to not clear the state and not
> +	 * check the load of an idle cpu.
> +	 */
> +	WRITE_ONCE(nohz.has_blocked, 0);
> +
> +	/*
> +	 * Ensures that if we miss the CPU, we must see the has_blocked
> +	 * store from nohz_balance_enter_idle().
> +	 */
> +	smp_mb();
> +
>  	for_each_cpu(balance_cpu, nohz.idle_cpus_mask) {
>  		if (balance_cpu == this_cpu || !idle_cpu(balance_cpu))
>  			continue;
> @@ -9383,11 +9452,16 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>  		 * work being done for other cpus. Next load
>  		 * balancing owner will pick it up.
>  		 */
> -		if (need_resched())
> -			break;
> +		if (need_resched()) {
> +			has_blocked_load = true;
> +			goto abort;
> +		}
>  
>  		rq = cpu_rq(balance_cpu);
>  

I'd say it's safe to do the following here. The flag is raised in
nohz_balance_enter_idle() before the smp_mb(), so we won't skip a CPU
that just got added to nohz.idle_cpus_mask.

		/*
		 * This cpu doesn't have any remaining blocked load, skip it.
		 * It's sane to do this because this flag is raised in
		 * nohz_balance_enter_idle()
		 */
		if ((flags & NOHZ_KICK_MASK) == NOHZ_STATS_KICK &&
		    !rq->has_blocked_load)
			continue;

> +		update_blocked_averages(rq->cpu);
> +		has_blocked_load |= rq->has_blocked_load;
> +
>  		/*
>  		 * If time for next balance is due,
>  		 * do the balance.
> @@ -9400,7 +9474,6 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>  			cpu_load_update_idle(rq);
>  			rq_unlock_irq(rq, &rf);
>  
> -			update_blocked_averages(rq->cpu);
>  			if (flags & NOHZ_BALANCE_KICK)
>  				rebalance_domains(rq, CPU_IDLE);
>  		}
> @@ -9415,7 +9488,13 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>  	if (flags & NOHZ_BALANCE_KICK)
>  		rebalance_domains(this_rq, CPU_IDLE);
>  
> -	nohz.next_stats = next_stats;
> +	WRITE_ONCE(nohz.next_blocked,
> +		now + msecs_to_jiffies(LOAD_AVG_PERIOD));
> +
> +abort:
> +	/* There is still blocked load, enable periodic update */
> +	if (has_blocked_load)
> +		WRITE_ONCE(nohz.has_blocked, 1);
>  
>  	/*
>  	 * next_balance will be updated only when there is a need.
