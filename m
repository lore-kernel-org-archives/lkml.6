Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753005AbeBFTJW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 14:09:22 -0500
Received: from merlin.infradead.org ([205.233.59.134]:60546 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752688AbeBFTJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 14:09:15 -0500
Date: Tue, 6 Feb 2018 20:09:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>,
        Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH v4 1/3] sched/fair: add util_est on top of PELT
Message-ID: <20180206190900.GN2249@hirez.programming.kicks-ass.net>
References: <20180206144131.31233-1-patrick.bellasi@arm.com>
 <20180206144131.31233-2-patrick.bellasi@arm.com>
 <20180206155056.GF2269@hirez.programming.kicks-ass.net>
 <20180206183315.GG5739@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206183315.GG5739@e110439-lin>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 06:33:15PM +0000, Patrick Bellasi wrote:

> Good point, I was actually expecting this question and I should have
> added it to the cover letter, sorry.
> 
> The reasoning was: the task's estimated utilization is defined as the
> max between PELT and the "estimation". Where "estimation" is
> the max between EWMA and the last ENQUEUED utilization.
> 
> Thus I was envisioning these two calls:
> 
>    _task_util_est := max(EWMA, ENQUEUED)
>     task_util_est := max(util_avg, _task_util_est)
> 
> but since now we have clients only for the first API, I've not added
> the second one. Still I would prefer to keep the "_" to make it clear
> that's and util_est's internal signal, not the actual task's estimated
> utilization.
> 
> Does it make sense?
> 
> Do you prefer I just remove the "_" and we will refactor it once we
> should add a customer for the proper task's util_est?

Hurm... I was thinking:

  task_util_est := max(util_avg, EWMA)

But the above mixes ENQUEUED into it.. *confused*.

Also, I think I'm confused by the 'enqueued' name... it makes sense for
the cfs use-case, where we track the sum of all 'enqueued' tasks, but it
doesn't make sense for the task use-case where it tracks task_util() at
dequeue time.

> > > +/*
> > > + * Check if the specified (signed) value is within a specified margin,
> > > + * based on the observation that:
> > > + *     abs(x) < y := (unsigned)(x + y - 1) < (2 * y - 1)
> > > + */
> > > +static inline bool within_margin(long value, unsigned int margin)
> > 
> > This mixing of long and int is dodgy, do we want to consistently use int
> > here?
> 
> Right, perhaps better "unsigned int" for both params, isn't?

Can't, must be signed, since @value is supposed to be able to be
negative remember? ;-)


> > > +	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, util_est);

> > > +	WRITE_ONCE(p->se.avg.util_est.enqueued, util_last);
> > 
> > Two stores to that word... can we fix that nicely?
> 
> Good point, the single word comes from the goal to fit into the same
> cache line of sched_avg.

Its the above two stores I confuzzled to be the same. So n/m all that.

> > > +SCHED_FEAT(UTIL_EST, false)
> > 
> > Since you couldn't measure it, do we wants it true?
> 
> I'm just a single tester so far, I would be more confident once
> someone volunteer to turn this on to give a better coverage.

Lets just enable it by default, that way its far more likely someone
will complain about it :-), disabling it again is a trivial matter when
needed.


Also, your patch 2/3 have insufficient READ_ONCE()s.
