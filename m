Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752506AbeEPIMa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 04:12:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36024 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbeEPIM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 04:12:28 -0400
Date: Wed, 16 May 2018 10:11:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@suse.de, lenb@kernel.org,
        rjw@rjwysocki.net, mgorman@techsingularity.net, x86@kernel.org,
        linux-pm@vger.kernel.org, viresh.kumar@linaro.org, juri.lelli@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT] [PATCH 06/10] cpufreq / sched: Add interface to get
 utilization values
Message-ID: <20180516081155.GA12217@hirez.programming.kicks-ass.net>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
 <20180516044911.28797-7-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516044911.28797-7-srinivas.pandruvada@linux.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 09:49:07PM -0700, Srinivas Pandruvada wrote:
> --- a/kernel/sched/cpufreq.c
> +++ b/kernel/sched/cpufreq.c
> @@ -60,3 +60,26 @@ void cpufreq_remove_update_util_hook(int cpu)
>  	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), NULL);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_remove_update_util_hook);
> +
> +/**
> + * cpufreq_get_sched_util - Get utilization values.
> + * @cpu: The targeted CPU.
> + *
> + * Get the CFS, DL and max utilization.
> + * This function allows cpufreq driver outside the kernel/sched to access
> + * utilization value for a CPUs run queue.
> + */
> +void cpufreq_get_sched_util(int cpu, unsigned long *util_cfs,
> +			    unsigned long *util_dl, unsigned long *max)
> +{
> +#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
> +	struct rq *rq = cpu_rq(cpu);
> +
> +	*max = arch_scale_cpu_capacity(NULL, cpu);
> +	*util_cfs = cpu_util_cfs(rq);
> +	*util_dl  = cpu_util_dl(rq);
> +#else
> +	*util_cfs = *util_dl = 1;
> +#endif
> +}
> +EXPORT_SYMBOL_GPL(cpufreq_get_sched_util);

So I _really_ hate this... I'd much rather you make schedutil work with
the hwp passive stuff.

Also, afaict intel_pstate is bool, not tristate, so no need for an
EXPORT at all.
