Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967841AbeBPMxk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 07:53:40 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39384 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967661AbeBPMxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 07:53:38 -0500
Subject: Re: [PATCH v5 1/3] sched: Stop nohz stats when decayed
To: Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Cc: morten.rasmussen@foss.arm.com, brendan.jackman@arm.com,
        dietmar.eggemann@arm.com
References: <1518622006-16089-1-git-send-email-vincent.guittot@linaro.org>
 <1518622006-16089-2-git-send-email-vincent.guittot@linaro.org>
From: Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <c4909c7e-e11b-8886-db15-ba82a331b89e@arm.com>
Date: Fri, 16 Feb 2018 12:53:36 +0000
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
>
> -static void update_nohz_stats(struct rq *rq)
> +static bool update_nohz_stats(struct rq *rq)
>  {
>  #ifdef CONFIG_NO_HZ_COMMON
>  	unsigned int cpu = rq->cpu;
>  
> +	if (!rq->has_blocked_load)
> +		return false;
> +
>  	if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
> -		return;
> +		return false;
>  
>  	if (!time_after(jiffies, rq->last_blocked_load_update_tick))
> -		return;
> +		return true;
>  
>  	update_blocked_averages(cpu);
> +
> +	return rq->has_blocked_load;
> +#else
> +	return false;
>  #endif
>  }
>  

(Wrongly thought that this bit was in a different patch, comment should have
been squashed in previous reply...)

I've been thinking about this, and it's a messy one if we want to
skip CPUs in idle_balance() / clear the nohz.has_blocked_flag.

AFAICT, the rq->has_blocked_load flag can be wrongly cleared: if we're
calling update_nohz_stats() for CPU A, but CPU A got out/in of
idle really quickly in that same timeframe, I'm not sure you can guarantee
the clearing of rq->has_blocked_load done in update_blocked_averages() will
always end up in memory before the setting of the flag in
nohz_balance_enter_idle().

I was going to say we don't have this problem in _nohz_idle_balance() but
actually I think we do. We have the checking of nohz.idle_cpus_mask after the
smp_mb(), which makes sure the clear of nohz.has_blocked will never
overwrite the set in nohz_balance_enter_idle(), but it doesn't
guarantee the same for the rq flag. So we can have nohz CPUs with blocked
load but with rq->has_blocked_load set to false. Which isn't a problem now
but it is if we want to use the flag to skip CPUs.

Am I correct or am I going crazy ? There's a comment about this in
nohz_balance_enter_idle() but I'm confused now:

	/*
	 * Can be set safely without rq->lock held
	 * If a clear happens, it will have evaluated last additions because
	 * rq->lock is held during the check and the clear
	 */
	rq->has_blocked_load = 1;
