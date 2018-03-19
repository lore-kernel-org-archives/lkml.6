Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932646AbeCSJMb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 05:12:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46212 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932426AbeCSJM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 05:12:29 -0400
Date: Mon, 19 Mar 2018 10:11:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFT][PATCH v5 4/7] cpuidle: Return nohz hint from
 cpuidle_select()
Message-ID: <20180319091159.GF4043@hirez.programming.kicks-ass.net>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan>
 <2021405.tG9RYD54xL@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2021405.tG9RYD54xL@aspire.rjw.lan>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 11:11:35PM +0100, Rafael J. Wysocki wrote:

I would suggest s/nohz_ret/stop_tick/ throughout, because I keep
forgetting which way around the boolean works and the new name doesn't
confuse.


> Index: linux-pm/drivers/cpuidle/governors/menu.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> +++ linux-pm/drivers/cpuidle/governors/menu.c
> @@ -275,12 +275,16 @@ again:
>  	goto again;
>  }
>  
> +#define TICK_USEC_HZ   ((USEC_PER_SEC + HZ/2) / HZ)

Do we want to put that next to TICK_NSEC?

Also, there are only 2 users of the existing TICK_USEC, do we want to:

  s/TICK_USEC/USER_&/

and then rename the new thing to TICK_USEC ?

>  /**
>   * menu_select - selects the next idle state to enter
>   * @drv: cpuidle driver containing state data
>   * @dev: the CPU
> + * @nohz_ret: indication on whether or not to stop the tick
>   */
> +static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> +		       bool *nohz_ret)
>  {
>  	struct menu_device *data = this_cpu_ptr(&menu_devices);
>  	struct device *device = get_cpu_device(dev->cpu);
> @@ -303,8 +307,10 @@ static int menu_select(struct cpuidle_dr
>  		latency_req = resume_latency;
>  
>  	/* Special case when user has set very strict latency requirement */
> +	if (unlikely(latency_req == 0)) {
> +		*nohz_ret = false;
>  		return 0;
> +	}
>  
>  	/* determine the expected residency time, round up */
>  	data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length());
> @@ -354,6 +360,7 @@ static int menu_select(struct cpuidle_dr
>  	if (latency_req > interactivity_req)
>  		latency_req = interactivity_req;
>  
> +	expected_interval = data->predicted_us;
>  	/*
>  	 * Find the idle state with the lowest power while satisfying
>  	 * our constraints.
> @@ -369,15 +376,30 @@ static int menu_select(struct cpuidle_dr
>  			idx = i; /* first enabled state */
>  		if (s->target_residency > data->predicted_us)
>  			break;
> +		if (s->exit_latency > latency_req) {
> +			/*
> +			 * If we break out of the loop for latency reasons, use
> +			 * the target residency of the selected state as the
> +			 * expected idle duration so that the tick is retained
> +			 * as long as that target residency is low enough.
> +			 */
> +			expected_interval = drv->states[idx].target_residency;
>  			break;
> +		}
>  		idx = i;
>  	}
>  
>  	if (idx == -1)
>  		idx = 0; /* No states enabled. Must use 0. */
>  
> +	/*
> +	 * Don't stop the tick if the selected state is a polling one or if the
> +	 * expected idle duration is shorter than the tick period length.
> +	 */
> +	if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
> +	    expected_interval < TICK_USEC_HZ)
> +		*nohz_ret = false;
> +
>  	data->last_state_idx = idx;
>  
>  	return data->last_state_idx;

Yes, much clearer, Thanks!
