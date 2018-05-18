Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753110AbeERJgs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:36:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45882 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752677AbeERJgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:36:45 -0400
Date: Fri, 18 May 2018 11:36:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        yuyang.du@intel.com, pjt@google.com, bsegall@google.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v3] sched/fair: update scale invariance of PELT
Message-ID: <20180518093638.GL12198@hirez.programming.kicks-ass.net>
References: <1493389435-2525-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493389435-2525-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Replying to the latest version available; given the current interest I
figure I'd re-read some of the old threads and look at this stuff again.

On Fri, Apr 28, 2017 at 04:23:55PM +0200, Vincent Guittot wrote:

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 0978fb7..f8dde36 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -313,6 +313,7 @@ struct load_weight {
>   */
>  struct sched_avg {
>  	u64				last_update_time;
> +	u64				stolen_idle_time;
>  	u64				load_sum;
>  	u32				util_sum;
>  	u32				period_contrib;

Right, so sadly Patrick stole that space with the util_est bits.

Also, given the comment here:

  https://marc.info/?l=linux-kernel&m=149373232422941&w=2

this should be a u32, right? Which might be slightly easier finding a
hole for.

>  /*
> + * Scale the time to reflect the effective amount of computation done during
> + * this delta time.

I would much appreciate a more extended comment here. One that includes
pictures of the of the moving window edges, as in:

  https://marc.info/?l=linux-kernel&m=149200866116792&w=2
  https://marc.info/?l=linux-kernel&m=149201190517985&w=2

> + */
> +static __always_inline u64
> +scale_time(u64 delta, int cpu, struct sched_avg *sa,
> +		unsigned long weight, int running)
> +{
> +	if (running) {
> +		/*
> +		 * When an entity runs at a lower compute capacity, it will
> +		 * need more time to do the same amount of work than at max
> +		 * capacity. In order to be invariant, we scale the delta to
> +		 * reflect how much work has been really done.
> +		 * Running at lower capacity also means running longer to do
> +		 * the same amount of work and this results in stealing some
> +		 * idle time that will disturbed the load signal compared to
> +		 * max capacity; We also track this amount of stolen time to
> +		 * reflect it when the entity will go back to sleep.
> +		 *
> +		 * stolen time = (current run time) - (effective time at max
> +		 * capacity)
> +		 */
> +		sa->stolen_idle_time += delta;
> +
> +		/*
> +		 * scale the elapsed time to reflect the real amount of
> +		 * computation
> +		 */
> +		delta = cap_scale(delta, arch_scale_freq_capacity(NULL, cpu));
> +		delta = cap_scale(delta, arch_scale_cpu_capacity(NULL, cpu));
> +
> +		/*
> +		 * Track the amount of stolen idle time due to running at
> +		 * lower capacity
> +		 */
> +		sa->stolen_idle_time -= delta;
> +	} else if (!weight) {
> +		/*
> +		 * Entity is sleeping so both utilization and load will decay
> +		 * and we can safely add the stolen time. Reflecting some
> +		 * stolen time make sense only if this idle phase would be
> +		 * present at max capacity. As soon as the utilization of an
> +		 * entity has reached the maximum value, it is considered as
> +		 * an always runnnig entity without idle time to steal.
> +		 */
> +		if (sa->util_avg < (SCHED_CAPACITY_SCALE - 1)) {
> +			/*
> +			 * Add the idle time stolen by running at lower compute
> +			 * capacity
> +			 */
> +			delta += sa->stolen_idle_time;
> +		}
> +		sa->stolen_idle_time = 0;
> +	}

What happened to the proposed changes here:

  https://marc.info/?l=linux-kernel&m=149383148721909&w=2

to deal with the load scaling issues?

> +
> +	return delta;
> +}
