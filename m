Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752940AbeBASKw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 13:10:52 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56588 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752646AbeBASKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 13:10:50 -0500
Date: Thu, 1 Feb 2018 19:10:42 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Morten Rasmussen <morten.rasmussen@foss.arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [RFC PATCH 2/5] sched: Add NOHZ_STATS_KICK
Message-ID: <20180201181041.GF2269@hirez.programming.kicks-ass.net>
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
> @@ -8861,7 +8875,14 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
>  			update_next_balance(sd, &next_balance);
>  		rcu_read_unlock();
>  
> -		if (time_after(jiffies, next) && atomic_read(&nohz.stats_state))
> +		/*
> +		 * Update blocked idle load if it has not been done for a
> +		 * while. Try to do it locally before entering idle but kick a
> +		 * ilb if it takes too much time and might delay next local
> +		 * wake up
> +		 */
> +		if (time_after(jiffies, next) && atomic_read(&nohz.stats_state) &&
> +				!_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE))
>  			kick_ilb(NOHZ_STATS_KICK);
>  
>  		goto out;

This I really dislike. We're here because avg_idle is _really_ low, we
really should not then call _nohz_idle_balance().
