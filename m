Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbeEQQEh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:04:37 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35811 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751481AbeEQQEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:04:36 -0400
X-Google-Smtp-Source: AB8JxZrlUnUXBv8FdgNXUSCAHZZuJ705Ear1/GIY7Q6GPFV8hlojb2dYNHlA2OU9ZO7KEKjO7e1oYg==
Date: Thu, 17 May 2018 09:04:33 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Luca Abeni <luca.abeni@santannapisa.it>, linux-pm@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH RFC] schedutil: Allow cpufreq requests to be made even
 when kthread kicked
Message-ID: <20180517160433.GD162290@joelaf.mtv.corp.google.com>
References: <20180516224518.109891-1-joel@joelfernandes.org>
 <20180517070026.GA22493@localhost.localdomain>
 <20180517102024.s3dxo4uepujh5f65@vireshk-i7>
 <20180517105358.GB22493@localhost.localdomain>
 <20180517130704.GA139147@joelaf.mtv.corp.google.com>
 <20180517142823.GD22493@localhost.localdomain>
 <20180517144359.GA162290@joelaf.mtv.corp.google.com>
 <20180517152312.GG22493@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517152312.GG22493@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 05:23:12PM +0200, Juri Lelli wrote:
> On 17/05/18 07:43, Joel Fernandes wrote:
> > On Thu, May 17, 2018 at 04:28:23PM +0200, Juri Lelli wrote:
> > [...]
> > > > > > We would need more locking stuff in the work handler in that case and
> > > > > > I think there maybe a chance of missing the request in that solution
> > > > > > if the request happens right at the end of when sugov_work returns.
> > > > > 
> > > > > Mmm, true. Ideally we might want to use some sort of queue where to
> > > > > atomically insert requests and then consume until queue is empty from
> > > > > sugov kthread.
> > > > 
> > > > IMO we don't really need a queue or anything, we should need the kthread to
> > > > process the *latest* request it sees since that's the only one that matters.
> > > 
> > > Yep, makes sense.
> > > 
> > > > > But, I guess that's going to be too much complexity for an (hopefully)
> > > > > corner case.
> > > > 
> > > > I thought of this corner case too, I'd argue its still an improvement over
> > > > not doing anything, but we could tighten this up a bit more if you wanted by
> > > 
> > > Indeed! :)
> > > 
> > > > doing something like this on top of my patch. Thoughts?
> > > > 
> > > > ---8<-----------------------
> > > > 
> > > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > > index a87fc281893d..e45ec24b810b 100644
> > > > --- a/kernel/sched/cpufreq_schedutil.c
> > > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > > @@ -394,6 +394,7 @@ static void sugov_work(struct kthread_work *work)
> > > >  	unsigned int freq;
> > > >  	unsigned long flags;
> > > >  
> > > > +redo_work:
> > > >  	/*
> > > >  	 * Hold sg_policy->update_lock shortly to handle the case where:
> > > >  	 * incase sg_policy->next_freq is read here, and then updated by
> > > > @@ -409,6 +410,9 @@ static void sugov_work(struct kthread_work *work)
> > > >  	__cpufreq_driver_target(sg_policy->policy, freq,
> > > >  				CPUFREQ_RELATION_L);
> > > >  	mutex_unlock(&sg_policy->work_lock);
> > > > +
> > > > +	if (sg_policy->work_in_progress)
> > > > +		goto redo_work;
> > > 
> > > Didn't we already queue up another irq_work at this point?
> > 
> > Oh yeah, so the case I was thinking was if the kthread was active, while the
> > new irq_work raced and finished.
> > 
> > Since that would just mean a new kthread_work for the worker, the loop I
> > mentioned above isn't needed. Infact there's already a higher level loop
> > taking care of it in kthread_worker_fn as below. So the governor thread
> > will not sleep and we'll keep servicing all pending requests till
> > they're done. So I think we're good with my original patch.
> > 
> > repeat:
> > [...]
> > if (!list_empty(&worker->work_list)) {
> > 		work = list_first_entry(&worker->work_list,
> > 					struct kthread_work, node);
> > 		list_del_init(&work->node);
> > 	}
> > 	worker->current_work = work;
> > 	spin_unlock_irq(&worker->lock);
> > 
> > 	if (work) {
> > 		__set_current_state(TASK_RUNNING);
> > 		work->func(work);
> > 	} else if (!freezing(current))
> > 		schedule();
> > 
> > 	try_to_freeze();
> > 	cond_resched();
> > 	goto repeat;
> 
> Ah, right. Your original patch LGTM then. :)

Cool, thanks. :)

> Maybe add a comment about this higher level loop?

Sure, will do.

thanks,

- Joel
