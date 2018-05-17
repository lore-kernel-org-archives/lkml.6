Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeEQPRF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 11:17:05 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36906 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbeEQPRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 11:17:03 -0400
X-Google-Smtp-Source: AB8JxZqZpc+cCBev7MBWLDWMPO6dm34rVPOI7FUzFj/2LW2SWDwRHrK6BJtt6KE1BOcMzjAasdkCGA==
Date: Thu, 17 May 2018 08:17:01 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Todd Kjos <tkjos@google.com>, kernel-team@android.com,
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH 3/3] sched/fair: schedutil: explicit update only when
 required
Message-ID: <20180517151701.GC162290@joelaf.mtv.corp.google.com>
References: <20180510150553.28122-1-patrick.bellasi@arm.com>
 <20180510150553.28122-4-patrick.bellasi@arm.com>
 <20180513060443.GB64158@joelaf.mtv.corp.google.com>
 <20180513062538.GA116730@joelaf.mtv.corp.google.com>
 <20180514163206.GF30654@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514163206.GF30654@e110439-lin>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick,

On Mon, May 14, 2018 at 05:32:06PM +0100, Patrick Bellasi wrote:
> On 12-May 23:25, Joel Fernandes wrote:
> > On Sat, May 12, 2018 at 11:04:43PM -0700, Joel Fernandes wrote:
> > > On Thu, May 10, 2018 at 04:05:53PM +0100, Patrick Bellasi wrote:
> > > > Schedutil updates for FAIR tasks are triggered implicitly each time a
> > > > cfs_rq's utilization is updated via cfs_rq_util_change(), currently
> > > > called by update_cfs_rq_load_avg(), when the utilization of a cfs_rq has
> > > > changed, and {attach,detach}_entity_load_avg().
> > > > 
> > > > This design is based on the idea that "we should callback schedutil
> > > > frequently enough" to properly update the CPU frequency at every
> > > > utilization change. However, such an integration strategy has also
> > > > some downsides:
> > > 
> > > I agree making the call explicit would make schedutil integration easier so
> > > that's really awesome. However I also fear that if some path in the fair
> > > class in the future changes the utilization but forgets to update schedutil
> > > explicitly (because they forgot to call the explicit public API) then the
> > > schedutil update wouldn't go through. In this case the previous design of
> > > doing the schedutil update in the wrapper kind of was a nice to have
> 
> I cannot see right now other possible future paths where we can
> actually change the utilization signal without considering that,
> eventually, we should call an existing API to update schedutil if it
> makes sense.
> 
> What I can see more likely instead, also because it already happened a
> couple of time, is that because of code changes in fair.c we end up
> calling (implicitly) schedutil with a wrong utilization value.
> 
> To note this kind of broken dependency it has already been more
> difficult than possibly noticing an update of the utilization without
> a corresponding explicit call of the public API.

Ok, we are in agreement this is a good thing to do :)

> > > > @@ -5397,9 +5366,27 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > > >  		update_cfs_group(se);
> > > >  	}
> > > >  
> > > > -	if (!se)
> > > > +	/* The task is visible from the root cfs_rq */
> > > > +	if (!se) {
> > > > +		unsigned int flags = 0;
> > > > +
> > > >  		add_nr_running(rq, 1);
> > > >  
> > > > +		if (p->in_iowait)
> > > > +			flags |= SCHED_CPUFREQ_IOWAIT;
> > > > +
> > > > +		/*
> > > > +		 * !last_update_time means we've passed through
> > > > +		 * migrate_task_rq_fair() indicating we migrated.
> > > > +		 *
> > > > +		 * IOW we're enqueueing a task on a new CPU.
> > > > +		 */
> > > > +		if (!p->se.avg.last_update_time)
> > > > +			flags |= SCHED_CPUFREQ_MIGRATION;
> > > > +
> > > > +		cpufreq_update_util(rq, flags);
> > > > +	}
> > > > +
> > > >  	hrtick_update(rq);
> > > >  }
> > > >  
> > > > @@ -5456,10 +5443,12 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > > >  		update_cfs_group(se);
> > > >  	}
> > > >  
> > > > +	/* The task is no more visible from the root cfs_rq */
> > > >  	if (!se)
> > > >  		sub_nr_running(rq, 1);
> > > >  
> > > >  	util_est_dequeue(&rq->cfs, p, task_sleep);
> > > > +	cpufreq_update_util(rq, 0);
> > > 
> > > One question about this change. In enqueue, throttle and unthrottle - you are
> > > conditionally calling cpufreq_update_util incase the task was
> > > visible/not-visible in the hierarchy.
> > > 
> > > But in dequeue you're unconditionally calling it. Seems a bit inconsistent.
> > > Is this because of util_est or something? Could you add a comment here
> > > explaining why this is so?
> > 
> > The big question I have is incase se != NULL, then its still visible at the
> > root RQ level.
> 
> My understanding it that you get !se at dequeue time when we are
> dequeuing a task from a throttled RQ. Isn't it?

I don't think so? !se means the RQ is not throttled.

> Thus, this means you are dequeuing a throttled task, I guess for
> example because of a migration.
> However, the point is that a task dequeue from a throttled RQ _is
> already_ not visible from the root RQ, because of the sub_nr_running()
> done by throttle_cfs_rq().

Yes that's what I was wondering, so my point was if its already not visible,
then why call schedutil. I felt call schedutil only if its visible like you
were doing for the other paths.

> 
> > In that case should we still call the util_est_dequeue and the
> > cpufreq_update_util?
> 
> I had a better look at the different code paths and I've possibly come
> up with some interesting observations. Lemme try to resume theme here.
> 
> First of all, we need to distinguish from estimated utilization
> updates and schedutil updates, since they respond to two very
> different goals.

I agree with your assessments below and about not calling cpufreq when CPU is
about to idle.

thanks!

- Joel
