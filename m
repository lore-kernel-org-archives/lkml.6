Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752570AbeEPHrr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:47:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752483AbeEPHro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:47:44 -0400
Date: Wed, 16 May 2018 09:47:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@suse.de, lenb@kernel.org,
        rjw@rjwysocki.net, mgorman@techsingularity.net, x86@kernel.org,
        linux-pm@vger.kernel.org, viresh.kumar@linaro.org, juri.lelli@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT] [PATCH 08/10] cpufreq: intel_pstate: Dyanmically
 update busy pct
Message-ID: <20180516074734.GY12217@hirez.programming.kicks-ass.net>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
 <20180516044911.28797-9-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516044911.28797-9-srinivas.pandruvada@linux.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 09:49:09PM -0700, Srinivas Pandruvada wrote:

> +static inline void intel_pstate_update_busy_threshold(struct cpudata *cpu)
> +{
> +	if (!hwp_boost_threshold_busy_pct) {
> +		int min_freq, max_freq;
> +
> +		min_freq  = cpu->pstate.min_pstate * cpu->pstate.scaling;
> +		update_turbo_state();
> +		max_freq =  global.turbo_disabled || global.no_turbo ?
> +				cpu->pstate.max_freq : cpu->pstate.turbo_freq;
> +
> +		/*
> +		 * We are guranteed to get atleast min P-state.

		   If we assume
> +		 * P-state is proportional to load (such that 10% load
> +		 * increase will result in 10% P-state increase),

		   we will
> +		 * get at least min P-state till we have atleast
> +		 * (min * 100/max) percent cpu load.

turbo makes that story less clear ofcourse.

		   So any load less than
> +		 * than this this we shouldn't do any boost. Then boosting
> +		 * is not free, we will add atleast 20% offset.

This I don't get.. so you want to remain at min P longer?

> +		 */
> +		hwp_boost_threshold_busy_pct = min_freq * 100 / max_freq;
> +		hwp_boost_threshold_busy_pct += 20;
> +		pr_debug("hwp_boost_threshold_busy_pct = %d\n",
> +			 hwp_boost_threshold_busy_pct);
> +	}
> +}

And then this part should go in the previous patch.
