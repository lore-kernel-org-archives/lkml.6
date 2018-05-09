Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753160AbeEIEy3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 00:54:29 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38139 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbeEIEy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 00:54:27 -0400
X-Google-Smtp-Source: AB8JxZqDFUvK7Bh8yQ3FACQ5HPZZBzXdMKeuNWqj3IWJq0F++6LiSyGJcl+saIOQL+j5F+k9NE9YnA==
Date: Tue, 8 May 2018 21:54:25 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Claudio Scordino <claudio@evidence.eu.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Joel Fernandes <joelaf@google.com>, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH] sched/cpufreq/schedutil: handling urgent frequency
 requests
Message-ID: <20180509045425.GA158882@joelaf.mtv.corp.google.com>
References: <1525704215-8683-1-git-send-email-claudio@evidence.eu.com>
 <20180508065435.bcht6dyb3rpp6gk5@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508065435.bcht6dyb3rpp6gk5@vireshk-i7>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 12:24:35PM +0530, Viresh Kumar wrote:
> On 07-05-18, 16:43, Claudio Scordino wrote:
> > At OSPM, it was mentioned the issue about urgent CPU frequency requests
> > arriving when a frequency switch is already in progress.
> > 
> > Besides the various issues (physical time for switching frequency,
> > on-going kthread activity, etc.) one (minor) issue is the kernel
> > "forgetting" such request, thus waiting the next switch time for
> > recomputing the needed frequency and behaving accordingly.
> > 
> > This patch makes the kthread serve any urgent request occurred during
> > the previous frequency switch. It introduces a specific flag, only set
> > when the SCHED_DEADLINE scheduling class increases the CPU utilization,
> > aiming at decreasing the likelihood of a deadline miss.
> > 
> > Indeed, some preliminary tests in critical conditions (i.e.
> > SCHED_DEADLINE tasks with short periods) have shown reductions of more
> > than 10% of the average number of deadline misses. On the other hand,
> > the increase in terms of energy consumption when running SCHED_DEADLINE
> > tasks (not yet measured) is likely to be not negligible (especially in
> > case of critical scenarios like "ramp up" utilizations).
> > 
> > The patch is meant as follow-up discussion after OSPM.
> > 
> > Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
> > CC: Viresh Kumar <viresh.kumar@linaro.org>
> > CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > CC: Peter Zijlstra <peterz@infradead.org>
> > CC: Ingo Molnar <mingo@redhat.com>
> > CC: Patrick Bellasi <patrick.bellasi@arm.com>
> > CC: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Luca Abeni <luca.abeni@santannapisa.it>
> > CC: Joel Fernandes <joelaf@google.com>
> > CC: linux-pm@vger.kernel.org
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index d2c6083..4de06b0 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -41,6 +41,7 @@ struct sugov_policy {
> >  	bool			work_in_progress;
> >  
> >  	bool			need_freq_update;
> > +	bool			urgent_freq_update;
> >  };
> >  
> >  struct sugov_cpu {
> > @@ -92,6 +93,14 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> >  	    !cpufreq_can_do_remote_dvfs(sg_policy->policy))
> >  		return false;
> >  
> > +	/*
> > +	 * Continue computing the new frequency. In case of work_in_progress,
> > +	 * the kthread will resched a change once the current transition is
> > +	 * finished.
> > +	 */
> > +	if (sg_policy->urgent_freq_update)
> > +		return true;
> > +
> >  	if (sg_policy->work_in_progress)
> >  		return false;
> >  
> > @@ -121,6 +130,9 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
> >  	sg_policy->next_freq = next_freq;
> >  	sg_policy->last_freq_update_time = time;
> >  
> > +	if (sg_policy->work_in_progress)
> > +		return;
> > +
> >  	if (policy->fast_switch_enabled) {
> >  		next_freq = cpufreq_driver_fast_switch(policy, next_freq);
> >  		if (!next_freq)
> > @@ -274,7 +286,7 @@ static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
> >  static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu, struct sugov_policy *sg_policy)
> >  {
> >  	if (cpu_util_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->util_dl)
> > -		sg_policy->need_freq_update = true;
> > +		sg_policy->urgent_freq_update = true;
> >  }
> >  
> >  static void sugov_update_single(struct update_util_data *hook, u64 time,
> > @@ -383,8 +395,11 @@ static void sugov_work(struct kthread_work *work)
> >  	struct sugov_policy *sg_policy = container_of(work, struct sugov_policy, work);
> >  
> >  	mutex_lock(&sg_policy->work_lock);
> > -	__cpufreq_driver_target(sg_policy->policy, sg_policy->next_freq,
> > +	do {
> > +		sg_policy->urgent_freq_update = false;
> > +		__cpufreq_driver_target(sg_policy->policy, sg_policy->next_freq,
> >  				CPUFREQ_RELATION_L);
> 
> If we are going to solve this problem, then maybe instead of the added
> complexity and a new flag we can look for need_freq_update flag at this location
> and re-calculate the next frequency if required.

Just for discussion sake, is there any need for work_in_progress? If we can
queue multiple work say kthread_queue_work can handle it, then just queuing
works whenever they are available should be Ok and the kthread loop can
handle them. __cpufreq_driver_target is also protected by the work lock if
there is any concern that can have races... only thing is rate-limiting of
the requests, but we are doing a rate limiting, just not for the "DL
increased utilization" type requests (which I don't think we are doing at the
moment for urgent DL requests anyway).

Following is an untested diff to show the idea. What do you think?

thanks,

- Joel

----8<---
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index d2c6083304b4..862634ff4bf3 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -38,7 +38,6 @@ struct sugov_policy {
 	struct			mutex work_lock;
 	struct			kthread_worker worker;
 	struct task_struct	*thread;
-	bool			work_in_progress;
 
 	bool			need_freq_update;
 };
@@ -92,16 +91,8 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 	    !cpufreq_can_do_remote_dvfs(sg_policy->policy))
 		return false;
 
-	if (sg_policy->work_in_progress)
-		return false;
-
 	if (unlikely(sg_policy->need_freq_update)) {
 		sg_policy->need_freq_update = false;
-		/*
-		 * This happens when limits change, so forget the previous
-		 * next_freq value and force an update.
-		 */
-		sg_policy->next_freq = UINT_MAX;
 		return true;
 	}
 
@@ -129,7 +120,6 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
 		policy->cur = next_freq;
 		trace_cpu_frequency(next_freq, smp_processor_id());
 	} else {
-		sg_policy->work_in_progress = true;
 		irq_work_queue(&sg_policy->irq_work);
 	}
 }
@@ -386,8 +376,6 @@ static void sugov_work(struct kthread_work *work)
 	__cpufreq_driver_target(sg_policy->policy, sg_policy->next_freq,
 				CPUFREQ_RELATION_L);
 	mutex_unlock(&sg_policy->work_lock);
-
-	sg_policy->work_in_progress = false;
 }
 
 static void sugov_irq_work(struct irq_work *irq_work)
@@ -671,7 +659,6 @@ static int sugov_start(struct cpufreq_policy *policy)
 	sg_policy->freq_update_delay_ns	= sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
 	sg_policy->last_freq_update_time	= 0;
 	sg_policy->next_freq			= UINT_MAX;
-	sg_policy->work_in_progress		= false;
 	sg_policy->need_freq_update		= false;
 	sg_policy->cached_raw_freq		= 0;
 
