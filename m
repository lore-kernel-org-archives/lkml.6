Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751329AbeEVKuM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:50:12 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40250 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeEVKuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:50:09 -0400
X-Google-Smtp-Source: AB8JxZqi427Tuc8Tn6tQr3pvLyIhgJ3qh9Q5WbAxo6PsKkzcC9dlTNEbDz2lU2Vcx/qn3XFKLgvZVQ==
Date: Tue, 22 May 2018 16:20:06 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Joel Fernandes (Google.)" <joelaf@google.com>
Cc: linux-kernel@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>, Todd Kjos <tkjos@google.com>,
        claudio@evidence.eu.com, kernel-team@android.com,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] schedutil: Allow cpufreq requests to be made even
 when kthread kicked
Message-ID: <20180522105006.hvntwnhzzvhznij2@vireshk-i7>
References: <20180518185501.173552-1-joel@joelfernandes.org>
 <20180522103415.cuutobi5kbhj4gcw@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522103415.cuutobi5kbhj4gcw@vireshk-i7>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-05-18, 16:04, Viresh Kumar wrote:
> Okay, me and Rafael were discussing this patch, locking and races around this.
> 
> On 18-05-18, 11:55, Joel Fernandes (Google.) wrote:
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index e13df951aca7..5c482ec38610 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -92,9 +92,6 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> >  	    !cpufreq_can_do_remote_dvfs(sg_policy->policy))
> >  		return false;
> >  
> > -	if (sg_policy->work_in_progress)
> > -		return false;
> > -
> >  	if (unlikely(sg_policy->need_freq_update)) {
> >  		sg_policy->need_freq_update = false;
> >  		/*
> > @@ -128,7 +125,7 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
> >  
> >  		policy->cur = next_freq;
> >  		trace_cpu_frequency(next_freq, smp_processor_id());
> > -	} else {
> > +	} else if (!sg_policy->work_in_progress) {
> >  		sg_policy->work_in_progress = true;
> >  		irq_work_queue(&sg_policy->irq_work);
> >  	}
> > @@ -291,6 +288,13 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
> >  
> >  	ignore_dl_rate_limit(sg_cpu, sg_policy);
> >  
> > +	/*
> > +	 * For slow-switch systems, single policy requests can't run at the
> > +	 * moment if update is in progress, unless we acquire update_lock.
> > +	 */
> > +	if (sg_policy->work_in_progress)
> > +		return;
> > +
> >  	if (!sugov_should_update_freq(sg_policy, time))
> >  		return;
> >  
> > @@ -382,13 +386,27 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
> >  static void sugov_work(struct kthread_work *work)
> >  {
> >  	struct sugov_policy *sg_policy = container_of(work, struct sugov_policy, work);
> > +	unsigned int freq;
> > +	unsigned long flags;
> > +
> > +	/*
> > +	 * Hold sg_policy->update_lock shortly to handle the case where:
> > +	 * incase sg_policy->next_freq is read here, and then updated by
> > +	 * sugov_update_shared just before work_in_progress is set to false
> > +	 * here, we may miss queueing the new update.
> > +	 *
> > +	 * Note: If a work was queued after the update_lock is released,
> > +	 * sugov_work will just be called again by kthread_work code; and the
> > +	 * request will be proceed before the sugov thread sleeps.
> > +	 */
> > +	raw_spin_lock_irqsave(&sg_policy->update_lock, flags);
> > +	freq = sg_policy->next_freq;
> > +	sg_policy->work_in_progress = false;
> > +	raw_spin_unlock_irqrestore(&sg_policy->update_lock, flags);
> >  
> >  	mutex_lock(&sg_policy->work_lock);
> > -	__cpufreq_driver_target(sg_policy->policy, sg_policy->next_freq,
> > -				CPUFREQ_RELATION_L);
> > +	__cpufreq_driver_target(sg_policy->policy, freq, CPUFREQ_RELATION_L);
> >  	mutex_unlock(&sg_policy->work_lock);
> > -
> > -	sg_policy->work_in_progress = false;
> >  }
> 
> And I do see a race here for single policy systems doing slow switching.
> 
> Kthread                                                 Sched update
> 
> sugov_work()                                            sugov_update_single()
> 
>         lock();
>         // The CPU is free to rearrange below           
>         // two in any order, so it may clear
>         // the flag first and then read next
>         // freq. Lets assume it does.
>         work_in_progress = false
> 
>                                                         if (work_in_progress)
>                                                                 return;
> 
>                                                         sg_policy->next_freq = 0;
>         freq = sg_policy->next_freq;
>                                                         sg_policy->next_freq = real-next-freq;
>         unlock();
> 
> 
> 
> Is the above theory right or am I day dreaming ? :)

And here comes the ugly fix:

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 35826f4ec43c..1665da31862e 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -283,6 +283,9 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 
        ignore_dl_rate_limit(sg_cpu, sg_policy);
 
+       if (!policy->fast_switch_enabled)
+               raw_spin_lock(&sg_policy->update_lock);
+
        /*
         * For slow-switch systems, single policy requests can't run at the
         * moment if update is in progress, unless we acquire update_lock.
@@ -312,6 +315,9 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
        }
 
        sugov_update_commit(sg_policy, time, next_f);
+
+       if (!policy->fast_switch_enabled)
+               raw_spin_unlock(&sg_policy->update_lock);
 }
 
 static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)


-- 
viresh
