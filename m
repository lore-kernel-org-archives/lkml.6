Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030933AbeBNOkr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:40:47 -0500
Received: from foss.arm.com ([217.140.101.70]:43070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030772AbeBNOkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:40:46 -0500
Subject: Re: [PATCH 3/3] sched: update blocked load when newly idle
To: Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Cc: morten.rasmussen@foss.arm.com, brendan.jackman@arm.com,
        dietmar.eggemann@arm.com
References: <1518517879-2280-1-git-send-email-vincent.guittot@linaro.org>
 <1518517879-2280-4-git-send-email-vincent.guittot@linaro.org>
From: Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <1750aeb3-b29a-e6e6-93f4-82cae69777ec@arm.com>
Date: Wed, 14 Feb 2018 14:40:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518517879-2280-4-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/13/2018 10:31 AM, Vincent Guittot wrote:
> When NEWLY_IDLE load balance is not triggered, we might need to update the
> blocked load anyway. We can kick an ilb so an idle CPU will take care of
> updating blocked load or we can try to update them locally before entering
> idle. In the latter case, we reuse part of the nohz_idle_balance.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 324 +++++++++++++++++++++++++++++++---------------------
>  1 file changed, 193 insertions(+), 131 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9183fee..cb1ab5c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
>
> [...]
>
>  /*
> + * idle_balance is called by schedule() if this_cpu is about to become
> + * idle. Attempts to pull tasks from other CPUs.
> + */
> +static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
> +{
> +	unsigned long next_balance = jiffies + HZ;
> +	int this_cpu = this_rq->cpu;
> +	struct sched_domain *sd;
> +	int pulled_task = 0;
> +	u64 curr_cost = 0;
> +
> +	/*
> +	 * We must set idle_stamp _before_ calling idle_balance(), such that we
> +	 * measure the duration of idle_balance() as idle time.
> +	 */
> +	this_rq->idle_stamp = rq_clock(this_rq);
> +
> +	/*
> +	 * Do not pull tasks towards !active CPUs...
> +	 */
> +	if (!cpu_active(this_cpu))
> +		return 0;
> +
> +	/*
> +	 * This is OK, because current is on_cpu, which avoids it being picked
> +	 * for load-balance and preemption/IRQs are still disabled avoiding
> +	 * further scheduler activity on it and we're being very careful to
> +	 * re-start the picking loop.
> +	 */
> +	rq_unpin_lock(this_rq, rf);
> +
> +	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
> +	    !this_rq->rd->overload) {
> +#ifdef CONFIG_NO_HZ_COMMON
> +		unsigned long has_blocked = READ_ONCE(nohz.has_blocked);
> +		unsigned long next_blocked = READ_ONCE(nohz.next_blocked);
> +#endif
> +		rcu_read_lock();
> +		sd = rcu_dereference_check_sched_domain(this_rq->sd);
> +		if (sd)
> +			update_next_balance(sd, &next_balance);
> +		rcu_read_unlock();
> +
> +#ifdef CONFIG_NO_HZ_COMMON
> +		/*
> +		 * This CPU doesn't want to be disturbed by scheduler
> +		 * houskeeping

Typo here (houskeeping)

> +		 */
> +		if (!housekeeping_cpu(this_cpu, HK_FLAG_SCHED))
> +			goto out;
> +
> +		/* Will wake up very soon. No time for fdoing anything else*/

Typo here (fdoing)

> +		if (this_rq->avg_idle < sysctl_sched_migration_cost)
> +			goto out;
> +
> +		/* Don't need to update blocked load of idle CPUs*/
> +		if (!has_blocked || time_after_eq(jiffies, next_blocked))
> +			goto out;

My "stats update via NEWLY_IDLE" test case started misbehaving with this
version: we skip most NEWLY_IDLE stats updates. AFAICT this is the culprit.

I believe this time check should be time_before(jiffies, next_blocked)
(or time_before_eq depending on what you want to guarantee with the jiffy
interval stuff).

> +
> +		raw_spin_unlock(&this_rq->lock);
> +		/*
> +		 * This CPU is going to be idle and blocked load of idle CPUs
> +		 * need to be updated. Run the ilb locally as it is a good
> +		 * candidate for ilb instead of waking up another idle CPU.
> +		 * Kick an normal ilb if we failed to do the update.
> +		 */
> +		if (!_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE))
> +			kick_ilb(NOHZ_STATS_KICK);
> +		raw_spin_lock(&this_rq->lock);
> +#endif
> +		goto out;
> +	}
> +
