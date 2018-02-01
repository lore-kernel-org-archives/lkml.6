Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752768AbeBAQ54 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:57:56 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55962 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbeBAQ5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:57:55 -0500
Date: Thu, 1 Feb 2018 17:57:49 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Morten Rasmussen <morten.rasmussen@foss.arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [RFC PATCH 2/5] sched: Add NOHZ_STATS_KICK
Message-ID: <20180201165749.GE2269@hirez.programming.kicks-ass.net>
References: <CAKfTPtC0+5zjvgNXMyVcvnnyJh0giQgJHtx+5p-GEpjUW1x8eg@mail.gmail.com>
 <20171222082915.4lcb7xyyooqyjpia@hirez.programming.kicks-ass.net>
 <20171222091221.ow5vn3ydx3hj4nht@hirez.programming.kicks-ass.net>
 <CAKfTPtAzutuyA7D2qOErKPwdFaRK082YAtVn4ci8hAOUvL3zMQ@mail.gmail.com>
 <20171222185629.lysjebfifgdwvvhu@hirez.programming.kicks-ass.net>
 <20171222204247.kyc6ugyyu3ei7zhs@hirez.programming.kicks-ass.net>
 <CAKfTPtD13p-n9otxq23rQZZKUfA1r03bxYBSDtSdm5HbWX7H6Q@mail.gmail.com>
 <20180115082609.GA6320@linaro.org>
 <20180118103807.GD28799@e105550-lin.cambridge.arm.com>
 <20180124082536.GA32318@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180124082536.GA32318@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 24, 2018 at 09:25:36AM +0100, Vincent Guittot wrote:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 898785d..ed90303 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7356,6 +7356,17 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
>  	return true;
>  }
>  
> +static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
> +{
> +	if (cfs_rq->avg.load_avg)
> +		return true;
> +
> +	if (cfs_rq->avg.util_avg)
> +		return true;
> +
> +	return false;
> +}
> +
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  
>  static void update_blocked_averages(int cpu)
> @@ -7393,7 +7404,9 @@ static void update_blocked_averages(int cpu)
>  		 */
>  		if (cfs_rq_is_decayed(cfs_rq))
>  			list_del_leaf_cfs_rq(cfs_rq);
> -		else
> +
> +		/* Don't need periodic decay once load/util_avg are null */
> +		if (cfs_rq_has_blocked(cfs_rq))
>  			done = false;
>  	}
>  
> @@ -7463,7 +7476,7 @@ static inline void update_blocked_averages(int cpu)
>  	update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
>  #ifdef CONFIG_NO_HZ_COMMON
>  	rq->last_blocked_load_update_tick = jiffies;
> -	if (cfs_rq_is_decayed(cfs_rq))
> +	if (cfs_rq_has_blocked(cfs_rq))
>  		rq->has_blocked_load = 0;
>  #endif
>  	rq_unlock_irqrestore(rq, &rf);

OK makes sense; would've been even better as a separate patch :-)
