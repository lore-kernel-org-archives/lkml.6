Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932337AbeEWJll (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:41:41 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48137 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932178AbeEWJlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:41:39 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Joel Fernandes <joelaf@google.com>
Cc: linux-kernel@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>, Todd Kjos <tkjos@google.com>,
        claudio@evidence.eu.com, kernel-team@android.com,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3] schedutil: Allow cpufreq requests to be made even when kthread kicked
Date: Wed, 23 May 2018 11:40:57 +0200
Message-ID: <2283013.nhvQ7q45Bo@aspire.rjw.lan>
In-Reply-To: <20180522225553.69483-1-joel@joelfernandes.org>
References: <20180522225553.69483-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, May 23, 2018 12:55:53 AM CEST Joel Fernandes wrote:
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> Currently there is a chance of a schedutil cpufreq update request to be
> dropped if there is a pending update request. This pending request can
> be delayed if there is a scheduling delay of the irq_work and the wake
> up of the schedutil governor kthread.
> 
> A very bad scenario is when a schedutil request was already just made,
> such as to reduce the CPU frequency, then a newer request to increase
> CPU frequency (even sched deadline urgent frequency increase requests)
> can be dropped, even though the rate limits suggest that its Ok to
> process a request. This is because of the way the work_in_progress flag
> is used.
> 
> This patch improves the situation by allowing new requests to happen
> even though the old one is still being processed. Note that in this
> approach, if an irq_work was already issued, we just update next_freq
> and don't bother to queue another request so there's no extra work being
> done to make this happen.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Juri Lelli <juri.lelli@redhat.com>
> CC: Viresh Kumar <viresh.kumar@linaro.org>
> CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Patrick Bellasi <patrick.bellasi@arm.com>
> CC: Juri Lelli <juri.lelli@redhat.com>
> Cc: Luca Abeni <luca.abeni@santannapisa.it>
> CC: Todd Kjos <tkjos@google.com>
> CC: claudio@evidence.eu.com
> CC: kernel-team@android.com
> CC: linux-pm@vger.kernel.org
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> Only commit log update, no code change in v2->v3
> 
>  kernel/sched/cpufreq_schedutil.c | 34 ++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index e13df951aca7..5c482ec38610 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -92,9 +92,6 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>  	    !cpufreq_can_do_remote_dvfs(sg_policy->policy))
>  		return false;
>  
> -	if (sg_policy->work_in_progress)
> -		return false;
> -
>  	if (unlikely(sg_policy->need_freq_update)) {
>  		sg_policy->need_freq_update = false;
>  		/*
> @@ -128,7 +125,7 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
>  
>  		policy->cur = next_freq;
>  		trace_cpu_frequency(next_freq, smp_processor_id());
> -	} else {
> +	} else if (!sg_policy->work_in_progress) {
>  		sg_policy->work_in_progress = true;
>  		irq_work_queue(&sg_policy->irq_work);
>  	}
> @@ -291,6 +288,13 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>  
>  	ignore_dl_rate_limit(sg_cpu, sg_policy);
>  
> +	/*
> +	 * For slow-switch systems, single policy requests can't run at the
> +	 * moment if update is in progress, unless we acquire update_lock.
> +	 */
> +	if (sg_policy->work_in_progress)
> +		return;
> +
>  	if (!sugov_should_update_freq(sg_policy, time))
>  		return;
>  
> @@ -382,13 +386,27 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
>  static void sugov_work(struct kthread_work *work)
>  {
>  	struct sugov_policy *sg_policy = container_of(work, struct sugov_policy, work);
> +	unsigned int freq;
> +	unsigned long flags;
> +
> +	/*
> +	 * Hold sg_policy->update_lock shortly to handle the case where:
> +	 * incase sg_policy->next_freq is read here, and then updated by
> +	 * sugov_update_shared just before work_in_progress is set to false
> +	 * here, we may miss queueing the new update.
> +	 *
> +	 * Note: If a work was queued after the update_lock is released,
> +	 * sugov_work will just be called again by kthread_work code; and the
> +	 * request will be proceed before the sugov thread sleeps.
> +	 */
> +	raw_spin_lock_irqsave(&sg_policy->update_lock, flags);
> +	freq = sg_policy->next_freq;
> +	sg_policy->work_in_progress = false;
> +	raw_spin_unlock_irqrestore(&sg_policy->update_lock, flags);
>  
>  	mutex_lock(&sg_policy->work_lock);
> -	__cpufreq_driver_target(sg_policy->policy, sg_policy->next_freq,
> -				CPUFREQ_RELATION_L);
> +	__cpufreq_driver_target(sg_policy->policy, freq, CPUFREQ_RELATION_L);
>  	mutex_unlock(&sg_policy->work_lock);
> -
> -	sg_policy->work_in_progress = false;
>  }
>  
>  static void sugov_irq_work(struct irq_work *irq_work)
> 

Applied, thanks!
