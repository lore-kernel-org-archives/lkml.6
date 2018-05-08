Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754431AbeEHGyl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 02:54:41 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43608 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754257AbeEHGyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 02:54:39 -0400
X-Google-Smtp-Source: AB8JxZqqfSagPiETQb7/W8qynvidm40QVHTMNzELOzdE3dfLAz7EG7bbGSA3Rh/B+6DSD+IU894Ccw==
Date: Tue, 8 May 2018 12:24:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Claudio Scordino <claudio@evidence.eu.com>
Cc: linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Joel Fernandes <joelaf@google.com>, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH] sched/cpufreq/schedutil: handling urgent frequency
 requests
Message-ID: <20180508065435.bcht6dyb3rpp6gk5@vireshk-i7>
References: <1525704215-8683-1-git-send-email-claudio@evidence.eu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525704215-8683-1-git-send-email-claudio@evidence.eu.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-05-18, 16:43, Claudio Scordino wrote:
> At OSPM, it was mentioned the issue about urgent CPU frequency requests
> arriving when a frequency switch is already in progress.
> 
> Besides the various issues (physical time for switching frequency,
> on-going kthread activity, etc.) one (minor) issue is the kernel
> "forgetting" such request, thus waiting the next switch time for
> recomputing the needed frequency and behaving accordingly.
> 
> This patch makes the kthread serve any urgent request occurred during
> the previous frequency switch. It introduces a specific flag, only set
> when the SCHED_DEADLINE scheduling class increases the CPU utilization,
> aiming at decreasing the likelihood of a deadline miss.
> 
> Indeed, some preliminary tests in critical conditions (i.e.
> SCHED_DEADLINE tasks with short periods) have shown reductions of more
> than 10% of the average number of deadline misses. On the other hand,
> the increase in terms of energy consumption when running SCHED_DEADLINE
> tasks (not yet measured) is likely to be not negligible (especially in
> case of critical scenarios like "ramp up" utilizations).
> 
> The patch is meant as follow-up discussion after OSPM.
> 
> Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
> CC: Viresh Kumar <viresh.kumar@linaro.org>
> CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Patrick Bellasi <patrick.bellasi@arm.com>
> CC: Juri Lelli <juri.lelli@redhat.com>
> Cc: Luca Abeni <luca.abeni@santannapisa.it>
> CC: Joel Fernandes <joelaf@google.com>
> CC: linux-pm@vger.kernel.org
> ---
>  kernel/sched/cpufreq_schedutil.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index d2c6083..4de06b0 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -41,6 +41,7 @@ struct sugov_policy {
>  	bool			work_in_progress;
>  
>  	bool			need_freq_update;
> +	bool			urgent_freq_update;
>  };
>  
>  struct sugov_cpu {
> @@ -92,6 +93,14 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>  	    !cpufreq_can_do_remote_dvfs(sg_policy->policy))
>  		return false;
>  
> +	/*
> +	 * Continue computing the new frequency. In case of work_in_progress,
> +	 * the kthread will resched a change once the current transition is
> +	 * finished.
> +	 */
> +	if (sg_policy->urgent_freq_update)
> +		return true;
> +
>  	if (sg_policy->work_in_progress)
>  		return false;
>  
> @@ -121,6 +130,9 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
>  	sg_policy->next_freq = next_freq;
>  	sg_policy->last_freq_update_time = time;
>  
> +	if (sg_policy->work_in_progress)
> +		return;
> +
>  	if (policy->fast_switch_enabled) {
>  		next_freq = cpufreq_driver_fast_switch(policy, next_freq);
>  		if (!next_freq)
> @@ -274,7 +286,7 @@ static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
>  static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu, struct sugov_policy *sg_policy)
>  {
>  	if (cpu_util_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->util_dl)
> -		sg_policy->need_freq_update = true;
> +		sg_policy->urgent_freq_update = true;
>  }
>  
>  static void sugov_update_single(struct update_util_data *hook, u64 time,
> @@ -383,8 +395,11 @@ static void sugov_work(struct kthread_work *work)
>  	struct sugov_policy *sg_policy = container_of(work, struct sugov_policy, work);
>  
>  	mutex_lock(&sg_policy->work_lock);
> -	__cpufreq_driver_target(sg_policy->policy, sg_policy->next_freq,
> +	do {
> +		sg_policy->urgent_freq_update = false;
> +		__cpufreq_driver_target(sg_policy->policy, sg_policy->next_freq,
>  				CPUFREQ_RELATION_L);

If we are going to solve this problem, then maybe instead of the added
complexity and a new flag we can look for need_freq_update flag at this location
and re-calculate the next frequency if required.

> +	} while (sg_policy->urgent_freq_update);
>  	mutex_unlock(&sg_policy->work_lock);
>  
>  	sg_policy->work_in_progress = false;
> @@ -673,6 +688,7 @@ static int sugov_start(struct cpufreq_policy *policy)
>  	sg_policy->next_freq			= UINT_MAX;
>  	sg_policy->work_in_progress		= false;
>  	sg_policy->need_freq_update		= false;
> +	sg_policy->urgent_freq_update		= false;
>  	sg_policy->cached_raw_freq		= 0;
>  
>  	for_each_cpu(cpu, policy->cpus) {
> -- 
> 2.7.4

-- 
viresh
