Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbeEPHhZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:37:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52384 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750992AbeEPHhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:37:22 -0400
Date: Wed, 16 May 2018 09:37:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@suse.de, lenb@kernel.org,
        rjw@rjwysocki.net, mgorman@techsingularity.net, x86@kernel.org,
        linux-pm@vger.kernel.org, viresh.kumar@linaro.org, juri.lelli@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT] [PATCH 05/10] cpufreq: intel_pstate: HWP boost
 performance on IO Wake
Message-ID: <20180516073701.GW12217@hirez.programming.kicks-ass.net>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
 <20180516044911.28797-6-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516044911.28797-6-srinivas.pandruvada@linux.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 09:49:06PM -0700, Srinivas Pandruvada wrote:
> When a task is woken up from IO wait, boost HWP prformance to max. This
> helps IO workloads on servers with per core P-states. But changing limits
> has extra over head of issuing new HWP Request MSR, which takes 1000+
> cycles. So this change limits setting HWP Request MSR. Also request can
> be for a remote CPU.
> Rate control in setting HWP Requests:
> - If the current performance is around P1, simply ignore IO flag.
> - Once set wait till hold time, till remove boost. While the boost
>   is on, another IO flags is notified, it will prolong boost.
> - If the IO flags are notified multiple ticks apart, this may not be
> IO bound task. Othewise idle system gets periodic boosts for one
> IO wake.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 75 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index e200887..d418265 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -20,6 +20,7 @@
>  #include <linux/tick.h>
>  #include <linux/slab.h>
>  #include <linux/sched/cpufreq.h>
> +#include <linux/sched/topology.h>
>  #include <linux/list.h>
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
> @@ -224,6 +225,8 @@ struct global_params {
>   * @hwp_req_cached:	Cached value of the last HWP request MSR
>   * @csd:		A structure used to issue SMP async call, which
>   *			defines callback and arguments
> + * @hwp_boost_active:	HWP performance is boosted on this CPU
> + * @last_io_update:	Last time when IO wake flag was set
>   *
>   * This structure stores per CPU instance data for all CPUs.
>   */
> @@ -258,6 +261,8 @@ struct cpudata {
>  	s16 epp_saved;
>  	u64 hwp_req_cached;
>  	call_single_data_t csd;
> +	bool hwp_boost_active;
> +	u64 last_io_update;

This structure has abysmal layout; you should look at that.
Also, mandatory complaint about using _Bool in composites.

>  };
>  
>  static struct cpudata **all_cpu_data;
> @@ -1421,10 +1426,80 @@ static void csd_init(struct cpudata *cpu)
>  	cpu->csd.info = cpu;
>  }
>  
> +/*
> + * Long hold time will keep high perf limits for long time,
> + * which negatively impacts perf/watt for some workloads,
> + * like specpower. 3ms is based on experiements on some
> + * workoads.
> + */
> +static int hwp_boost_hold_time_ms = 3;
> +
> +/* Default: This will roughly around P1 on SKX */
> +#define BOOST_PSTATE_THRESHOLD	(SCHED_CAPACITY_SCALE / 2)

Yuck.. why the need to hardcode this? Can't you simply read the P1 value
for the part at hand?

> +static int hwp_boost_pstate_threshold = BOOST_PSTATE_THRESHOLD;
> +
> +static inline bool intel_pstate_check_boost_threhold(struct cpudata *cpu)
> +{
> +	/*
> +	 * If the last performance is above threshold, then return false,
> +	 * so that caller can ignore boosting.
> +	 */
> +	if (arch_scale_freq_capacity(cpu->cpu) > hwp_boost_pstate_threshold)
> +		return false;
> +
> +	return true;
> +}
> +
>  static inline void intel_pstate_update_util_hwp(struct update_util_data *data,
>  						u64 time, unsigned int flags)
>  {
> +	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
> +
> +	if (flags & SCHED_CPUFREQ_IOWAIT) {
> +		/*
> +		 * Set iowait_boost flag and update time. Since IO WAIT flag
> +		 * is set all the time, we can't just conclude that there is
> +		 * some IO bound activity is scheduled on this CPU with just
> +		 * one occurrence. If we receive at least two in two
> +		 * consecutive ticks, then we start treating as IO. So
> +		 * there will be one tick latency.
> +		 */
> +		if (time_before64(time, cpu->last_io_update + 2 * TICK_NSEC) &&
> +		    intel_pstate_check_boost_threhold(cpu))
> +			cpu->iowait_boost = true;
> +
> +		cpu->last_io_update = time;
> +		cpu->last_update = time;
> +	}
>  
> +	/*
> +	 * If the boost is active, we will remove it after timeout on local
> +	 * CPU only.
> +	 */
> +	if (cpu->hwp_boost_active) {
> +		if (smp_processor_id() == cpu->cpu) {
> +			bool expired;
> +
> +			expired = time_after64(time, cpu->last_update +
> +					       (hwp_boost_hold_time_ms * NSEC_PER_MSEC));
> +			if (expired) {
> +				intel_pstate_hwp_boost_down(cpu);
> +				cpu->hwp_boost_active = false;
> +				cpu->iowait_boost = false;
> +			}
> +		}
> +		return;
> +	}
> +
> +	cpu->last_update = time;
> +
> +	if (cpu->iowait_boost) {
> +		cpu->hwp_boost_active = true;
> +		if (smp_processor_id() == cpu->cpu)
> +			intel_pstate_hwp_boost_up(cpu);
> +		else
> +			smp_call_function_single_async(cpu->cpu, &cpu->csd);
> +	}
>  }

Hurmph, this looks like you're starting to duplicate the schedutil
iowait logic. Why didn't you copy the gradual boosting thing?
