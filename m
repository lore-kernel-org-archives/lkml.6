Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932433AbeEWKO2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 06:14:28 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38646 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932326AbeEWKOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 06:14:21 -0400
X-Google-Smtp-Source: AB8JxZroufxQM6rC6SEQuzKdb3AQ26N7vmWiE5L+skOFOmnKy2MQehJAWx7Z4Hc4XEuLnHv8w6rdkg==
Date: Wed, 23 May 2018 15:44:18 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>, claudio@evidence.eu.com,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH] cpufreq: schedutil: Avoid missing updates for one-CPU
 policies
Message-ID: <20180523101418.s4zg5mr3ycxm4vi5@vireshk-i7>
References: <1672734.JYOlA1IWnU@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1672734.JYOlA1IWnU@aspire.rjw.lan>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-05-18, 11:47, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 152db033d775 (schedutil: Allow cpufreq requests to be made
> even when kthread kicked) made changes to prevent utilization updates
> from being discarded during processing a previous request, but it
> left a small window in which that still can happen in the one-CPU
> policy case.  Namely, updates coming in after setting work_in_progress
> in sugov_update_commit() and clearing it in sugov_work() will still
> be dropped due to the work_in_progress check in sugov_update_single().
> 
> To close that window, rearrange the code so as to acquire the update
> lock around the deferred update branch in sugov_update_single()
> and drop the work_in_progress check from it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  kernel/sched/cpufreq_schedutil.c |   70 ++++++++++++++++++++++++++-------------
>  1 file changed, 47 insertions(+), 23 deletions(-)
> 
> Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> @@ -100,25 +100,41 @@ static bool sugov_should_update_freq(str
>  	return delta_ns >= sg_policy->freq_update_delay_ns;
>  }
>  
> -static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
> -				unsigned int next_freq)
> +static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
> +				   unsigned int next_freq)
>  {
> -	struct cpufreq_policy *policy = sg_policy->policy;
> -
>  	if (sg_policy->next_freq == next_freq)
> -		return;
> +		return false;
>  
>  	sg_policy->next_freq = next_freq;
>  	sg_policy->last_freq_update_time = time;
>  
> -	if (policy->fast_switch_enabled) {
> -		next_freq = cpufreq_driver_fast_switch(policy, next_freq);
> -		if (!next_freq)
> -			return;
> +	return true;
> +}
> +
> +static void sugov_fast_switch(struct sugov_policy *sg_policy, u64 time,
> +			      unsigned int next_freq)
> +{
> +	struct cpufreq_policy *policy = sg_policy->policy;
> +
> +	if (!sugov_update_next_freq(sg_policy, time, next_freq))
> +		return;
> +
> +	next_freq = cpufreq_driver_fast_switch(policy, next_freq);
> +	if (!next_freq)
> +		return;
>  
> -		policy->cur = next_freq;
> -		trace_cpu_frequency(next_freq, smp_processor_id());
> -	} else if (!sg_policy->work_in_progress) {
> +	policy->cur = next_freq;
> +	trace_cpu_frequency(next_freq, smp_processor_id());
> +}
> +
> +static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,
> +				  unsigned int next_freq)
> +{
> +	if (!sugov_update_next_freq(sg_policy, time, next_freq))
> +		return;
> +
> +	if (!sg_policy->work_in_progress) {
>  		sg_policy->work_in_progress = true;
>  		irq_work_queue(&sg_policy->irq_work);
>  	}
> @@ -363,13 +379,6 @@ static void sugov_update_single(struct u
>  
>  	ignore_dl_rate_limit(sg_cpu, sg_policy);
>  
> -	/*
> -	 * For slow-switch systems, single policy requests can't run at the
> -	 * moment if update is in progress, unless we acquire update_lock.
> -	 */
> -	if (sg_policy->work_in_progress)
> -		return;
> -
>  	if (!sugov_should_update_freq(sg_policy, time))
>  		return;
>  
> @@ -391,7 +400,18 @@ static void sugov_update_single(struct u
>  		sg_policy->cached_raw_freq = 0;
>  	}
>  
> -	sugov_update_commit(sg_policy, time, next_f);
> +	/*
> +	 * This code runs under rq->lock for the target CPU, so it won't run
> +	 * concurrently on two different CPUs for the same target and it is not
> +	 * necessary to acquire the lock in the fast switch case.
> +	 */
> +	if (sg_policy->policy->fast_switch_enabled) {
> +		sugov_fast_switch(sg_policy, time, next_f);
> +	} else {
> +		raw_spin_lock(&sg_policy->update_lock);
> +		sugov_deferred_update(sg_policy, time, next_f);
> +		raw_spin_unlock(&sg_policy->update_lock);
> +	}
>  }
>  
>  static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
> @@ -435,7 +455,11 @@ sugov_update_shared(struct update_util_d
>  
>  	if (sugov_should_update_freq(sg_policy, time)) {
>  		next_f = sugov_next_freq_shared(sg_cpu, time);
> -		sugov_update_commit(sg_policy, time, next_f);
> +
> +		if (sg_policy->policy->fast_switch_enabled)
> +			sugov_fast_switch(sg_policy, time, next_f);
> +		else
> +			sugov_deferred_update(sg_policy, time, next_f);
>  	}
>  
>  	raw_spin_unlock(&sg_policy->update_lock);
> @@ -450,11 +474,11 @@ static void sugov_work(struct kthread_wo
>  	/*
>  	 * Hold sg_policy->update_lock shortly to handle the case where:
>  	 * incase sg_policy->next_freq is read here, and then updated by
> -	 * sugov_update_shared just before work_in_progress is set to false
> +	 * sugov_deferred_update() just before work_in_progress is set to false
>  	 * here, we may miss queueing the new update.
>  	 *
>  	 * Note: If a work was queued after the update_lock is released,
> -	 * sugov_work will just be called again by kthread_work code; and the
> +	 * sugov_work() will just be called again by kthread_work code; and the
>  	 * request will be proceed before the sugov thread sleeps.
>  	 */
>  	raw_spin_lock_irqsave(&sg_policy->update_lock, flags);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
