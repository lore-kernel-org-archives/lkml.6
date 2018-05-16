Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752448AbeEPHWR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:22:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44918 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752253AbeEPHWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:22:15 -0400
Date: Wed, 16 May 2018 09:22:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@suse.de, lenb@kernel.org,
        rjw@rjwysocki.net, mgorman@techsingularity.net, x86@kernel.org,
        linux-pm@vger.kernel.org, viresh.kumar@linaro.org, juri.lelli@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT] [PATCH 03/10] cpufreq: intel_pstate: Utility functions
 to boost HWP performance limits
Message-ID: <20180516072202.GV12217@hirez.programming.kicks-ass.net>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
 <20180516044911.28797-4-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516044911.28797-4-srinivas.pandruvada@linux.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 09:49:04PM -0700, Srinivas Pandruvada wrote:
> Setup necessary infrastructure to be able to boost HWP performance on a
> remote CPU. First initialize data structure to be able to use
> smp_call_function_single_async(). The boost up function simply set HWP
> min to HWP max value and EPP to 0. The boost down function simply restores
> to last cached HWP Request value.
> 
> To avoid reading HWP Request MSR during dynamic update, the HWP Request
> MSR value is cached in the local memory. This caching is done whenever
> HWP request MSR is modified during driver init on in setpolicy() callback
> path.

The patch does two independent things; best to split that.


> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index f686bbe..dc7dfa9 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -221,6 +221,9 @@ struct global_params {
>   *			preference/bias
>   * @epp_saved:		Saved EPP/EPB during system suspend or CPU offline
>   *			operation
> + * @hwp_req_cached:	Cached value of the last HWP request MSR

That's simply not true given the code below.

> @@ -763,6 +768,7 @@ static void intel_pstate_hwp_set(unsigned int cpu)
>  		intel_pstate_set_epb(cpu, epp);
>  	}
>  skip_epp:
> +	cpu_data->hwp_req_cached = value;
>  	wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
>  }
>  
> @@ -1381,6 +1387,39 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
>  	intel_pstate_set_min_pstate(cpu);
>  }
>  
> +
> +static inline void intel_pstate_hwp_boost_up(struct cpudata *cpu)
> +{
> +	u64 hwp_req;
> +	u8 max;
> +
> +	max = (u8) (cpu->hwp_req_cached >> 8);
> +
> +	hwp_req = cpu->hwp_req_cached & ~GENMASK_ULL(31, 24);
> +	hwp_req = (hwp_req & ~GENMASK_ULL(7, 0)) | max;
> +
> +	wrmsrl(MSR_HWP_REQUEST, hwp_req);
> +}
> +
> +static inline void intel_pstate_hwp_boost_down(struct cpudata *cpu)
> +{
> +	wrmsrl(MSR_HWP_REQUEST, cpu->hwp_req_cached);
> +}

This is not a traditional msr shadow; that would be updated on every
wrmsr. There is not a comment in sight explaining why this one is
different.
