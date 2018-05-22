Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751419AbeEVKwD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:52:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34730 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751106AbeEVKwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:52:02 -0400
Date: Tue, 22 May 2018 11:51:57 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Joel Fernandes (Google.)" <joelaf@google.com>,
        linux-kernel@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>, Todd Kjos <tkjos@google.com>,
        claudio@evidence.eu.com, kernel-team@android.com,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] schedutil: Allow cpufreq requests to be made even
 when kthread kicked
Message-ID: <20180522105157.GX30654@e110439-lin>
References: <20180518185501.173552-1-joel@joelfernandes.org>
 <20180522103415.cuutobi5kbhj4gcw@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522103415.cuutobi5kbhj4gcw@vireshk-i7>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-May 16:04, Viresh Kumar wrote:
> Okay, me and Rafael were discussing this patch, locking and races around this.
> 
> On 18-05-18, 11:55, Joel Fernandes (Google.) wrote:
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

It could happen, but using:

   raw_spin_lock_irqsave(&sg_policy->update_lock, flags);
   freq = READ_ONCE(sg_policy->next_freq)
   WRITE_ONCE(sg_policy->work_in_progress, false);
   raw_spin_unlock_irqrestore(&sg_policy->update_lock, flags);

                       if (!READ_ONCE(sg_policy->work_in_progress)) {
                           WRITE_ONCE(sg_policy->work_in_progress, true);
                           irq_work_queue(&sg_policy->irq_work);
                       }

should fix it by enforcing the ordering as well as documenting the
concurrent access.

However, in the "sched update" side, where do we have the sequence:

   sg_policy->next_freq = 0;
   sg_policy->next_freq = real-next-freq;

AFAICS we always use locals for next_freq and do one single assignment
in sugov_update_commit(), isn't it?

-- 
#include <best/regards.h>

Patrick Bellasi
