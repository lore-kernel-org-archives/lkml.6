Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969562AbeEXNmp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 09:42:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45060 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966066AbeEXNmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 09:42:42 -0400
Date: Thu, 24 May 2018 14:42:36 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Joel Fernandes <joel@joelfernandes.org>
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
Message-ID: <20180524134236.GA30654@e110439-lin>
References: <20180510150553.28122-1-patrick.bellasi@arm.com>
 <20180510150553.28122-4-patrick.bellasi@arm.com>
 <20180513060443.GB64158@joelaf.mtv.corp.google.com>
 <20180513062538.GA116730@joelaf.mtv.corp.google.com>
 <20180514163206.GF30654@e110439-lin>
 <20180517151701.GC162290@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517151701.GC162290@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,
sorry for the late reply, this thread is a bit confusing because we
keep discussing while there was already a v2 posted on list.

However, here are few comments below...

[...]

> > > > > @@ -5456,10 +5443,12 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > > > >  		update_cfs_group(se);
> > > > >  	}
> > > > >  
> > > > > +	/* The task is no more visible from the root cfs_rq */
> > > > >  	if (!se)
> > > > >  		sub_nr_running(rq, 1);
> > > > >  
> > > > >  	util_est_dequeue(&rq->cfs, p, task_sleep);
> > > > > +	cpufreq_update_util(rq, 0);
> > > > 
> > > > One question about this change. In enqueue, throttle and unthrottle - you are
> > > > conditionally calling cpufreq_update_util incase the task was
> > > > visible/not-visible in the hierarchy.
> > > > 
> > > > But in dequeue you're unconditionally calling it. Seems a bit inconsistent.
> > > > Is this because of util_est or something? Could you add a comment here
> > > > explaining why this is so?
> > > 
> > > The big question I have is incase se != NULL, then its still visible at the
> > > root RQ level.
> > 
> > My understanding it that you get !se at dequeue time when we are
> > dequeuing a task from a throttled RQ. Isn't it?
> 
> I don't think so? !se means the RQ is not throttled.

Yes, I agree, I "just" forgot a "not" in the sentence above... my bad!

However, we are on the same page here.
 
> > Thus, this means you are dequeuing a throttled task, I guess for
> > example because of a migration.
> > However, the point is that a task dequeue from a throttled RQ _is
> > already_ not visible from the root RQ, because of the sub_nr_running()
> > done by throttle_cfs_rq().
> 
> Yes that's what I was wondering, so my point was if its already not visible,
> then why call schedutil. I felt call schedutil only if its visible like you
> were doing for the other paths.

Agree, as discussed in Vincent in v2, we should likely move these
schedutil updates at attach/detach time. This is when exectly we know
that the utilization has changed for a CPU.

... and that's what I'll propose in the upcoming v3 for this patch.

[...]

> I agree with your assessments below and about not calling cpufreq
> when CPU is about to idle.

Cool ;)

-- 
#include <best/regards.h>

Patrick Bellasi
