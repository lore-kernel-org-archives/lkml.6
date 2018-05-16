Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752595AbeEPHnZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:43:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37200 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751040AbeEPHnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:43:23 -0400
Date: Wed, 16 May 2018 09:43:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@suse.de, lenb@kernel.org,
        rjw@rjwysocki.net, mgorman@techsingularity.net, x86@kernel.org,
        linux-pm@vger.kernel.org, viresh.kumar@linaro.org, juri.lelli@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT] [PATCH 08/10] cpufreq: intel_pstate: Dyanmically
 update busy pct
Message-ID: <20180516074304.GX12217@hirez.programming.kicks-ass.net>
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
> +	/* P1 percent out of total range of P-states */
> +	if (cpu->pstate.max_freq != cpu->pstate.turbo_freq) {
> +		hwp_boost_pstate_threshold =
> +			cpu->pstate.max_freq * SCHED_CAPACITY_SCALE / cpu->pstate.turbo_freq;
> +		pr_debug("hwp_boost_pstate_threshold = %d\n",
> +			 hwp_boost_pstate_threshold);
> +	}
> +
> +}
> +
>  static inline void intel_pstate_update_util_hwp(struct update_util_data *data,
>  						u64 time, unsigned int flags)
>  {
> @@ -2061,8 +2097,10 @@ static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
>  
>  	policy->fast_switch_possible = true;
>  
> -	if (hwp_active)
> +	if (hwp_active) {
>  		csd_init(cpu);
> +		intel_pstate_update_busy_threshold(cpu);
> +	}
>  
>  	return 0;
>  }

This should go in patch #5 and then you can remove that SKX hack. Which
you left in, even though you now did it right.
