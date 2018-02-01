Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752940AbeBAQxC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:53:02 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55916 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752719AbeBAQw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:52:57 -0500
Date: Thu, 1 Feb 2018 17:52:49 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [RFC PATCH 2/5] sched: Add NOHZ_STATS_KICK
Message-ID: <20180201165249.GC2269@hirez.programming.kicks-ass.net>
References: <CAKfTPtCVgnO1zcD_X4Ad-T0auWmN-TJ0dezv0P5wEtubkbgHyQ@mail.gmail.com>
 <20171222075934.f6yenvcb2zkf2ysd@hirez.programming.kicks-ass.net>
 <CAKfTPtC0+5zjvgNXMyVcvnnyJh0giQgJHtx+5p-GEpjUW1x8eg@mail.gmail.com>
 <20171222082915.4lcb7xyyooqyjpia@hirez.programming.kicks-ass.net>
 <20171222091221.ow5vn3ydx3hj4nht@hirez.programming.kicks-ass.net>
 <CAKfTPtAzutuyA7D2qOErKPwdFaRK082YAtVn4ci8hAOUvL3zMQ@mail.gmail.com>
 <20171222185629.lysjebfifgdwvvhu@hirez.programming.kicks-ass.net>
 <20171222204247.kyc6ugyyu3ei7zhs@hirez.programming.kicks-ass.net>
 <CAKfTPtD13p-n9otxq23rQZZKUfA1r03bxYBSDtSdm5HbWX7H6Q@mail.gmail.com>
 <20180115082609.GA6320@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180115082609.GA6320@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2018 at 09:26:09AM +0100, Vincent Guittot wrote:

Would've probably been easier to read if you'd not included the revert
of that timer patch...

> @@ -9258,21 +9255,11 @@ void nohz_balance_enter_idle(int cpu)
>  	set_cpu_sd_state_idle(cpu);
>  
>  	/*
> -	 * implies a barrier such that if the stats_state update is observed
> -	 * the above updates are also visible. Pairs with stuff in
> -	 * update_sd_lb_stats() and nohz_idle_balance().
> +	 * Each time a cpu enter idle, we assume that it has blocked load and
> +	 * enable the periodic update of the load of idle cpus
>  	 */
> -	val = atomic_read(&nohz.stats_state);
> -	do {
> -		new = val + 2;
> -		new |= 1;
> -	} while (!atomic_try_cmpxchg(&nohz.stats_state, &val, new));
> +	atomic_set(&nohz.stats_state, 1);
>  

> @@ -9422,7 +9408,6 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>  		return false;
>  	}
>  
> -	stats_seq = atomic_read(&nohz.stats_state);
>  	/*
>  	 * barrier, pairs with nohz_balance_enter_idle(), ensures ...
>  	 */
> @@ -9432,6 +9417,16 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>  
>  	SCHED_WARN_ON((flags & NOHZ_KICK_MASK) == NOHZ_BALANCE_KICK);
>  
> +	/*
> +	 * We assume there will be no idle load after this update and clear
> +	 * the stats state. If a cpu enters idle in the mean time, it will
> +	 * set the stats state and trig another update of idle load.
> +	 * Because a cpu that becomes idle, is added to idle_cpus_mask before
> +	 * setting the stats state, we are sure to not clear the state and not
> +	 * check the load of an idle cpu.
> +	 */
> +	atomic_set(&nohz.stats_state, 0);
> +
>  	for_each_cpu(balance_cpu, nohz.idle_cpus_mask) {
>  		if (balance_cpu == this_cpu || !idle_cpu(balance_cpu))
>  			continue;
> @@ -9441,8 +9436,10 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>  		 * work being done for other cpus. Next load
>  		 * balancing owner will pick it up.
>  		 */
> -		if (need_resched())
> +		if (need_resched()) {
> +			has_blocked_load = true;
>  			break;
> +		}
>  
>  		rq = cpu_rq(balance_cpu);
>  
> @@ -9477,12 +9474,12 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>  	if (flags & NOHZ_BALANCE_KICK)
>  		rebalance_domains(this_rq, CPU_IDLE);
>  
> -	if (has_blocked_load ||
> -	    !atomic_try_cmpxchg(&nohz.stats_state, &stats_seq, 0)) {
> -		WRITE_ONCE(nohz.next_stats,
> -				now + msecs_to_jiffies(LOAD_AVG_PERIOD));
> -		mod_timer(&nohz.timer, nohz.next_stats);
> -	}
> +	WRITE_ONCE(nohz.next_stats,
> +		now + msecs_to_jiffies(LOAD_AVG_PERIOD));
> +
> +	/* There is still blocked load, enable periodic update */
> +	if (has_blocked_load)
> +		atomic_set(&nohz.stats_state, 1);
>  
>  	/*
>  	 * next_balance will be updated only when there is a need.

After this there is no point for stats_state to be atomic anymore. Also
a better name.

Maybe if I drop the last two patches (and you re-introduce the bits
from: Subject: sched: Optimize nohz stats, that you do need) this all
becomes more readable?
