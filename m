Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753923AbeBGLs1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 06:48:27 -0500
Received: from foss.arm.com ([217.140.101.70]:49794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753478AbeBGLsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 06:48:25 -0500
Date: Wed, 7 Feb 2018 11:48:20 +0000
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20180207114820.GI5739@e110439-lin>
References: <20180206144131.31233-1-patrick.bellasi@arm.com>
 <20180206144131.31233-2-patrick.bellasi@arm.com>
 <20180206155056.GF2269@hirez.programming.kicks-ass.net>
 <20180206183315.GG5739@e110439-lin>
 <20180206190900.GN2249@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206190900.GN2249@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-Feb 20:09, Peter Zijlstra wrote:
> On Tue, Feb 06, 2018 at 06:33:15PM +0000, Patrick Bellasi wrote:
> 
> > Good point, I was actually expecting this question and I should have
> > added it to the cover letter, sorry.
> > 
> > The reasoning was: the task's estimated utilization is defined as the
> > max between PELT and the "estimation". Where "estimation" is
> > the max between EWMA and the last ENQUEUED utilization.
> > 
> > Thus I was envisioning these two calls:
> > 
> >    _task_util_est := max(EWMA, ENQUEUED)
> >     task_util_est := max(util_avg, _task_util_est)
> > 
> > but since now we have clients only for the first API, I've not added
> > the second one. Still I would prefer to keep the "_" to make it clear
> > that's and util_est's internal signal, not the actual task's estimated
> > utilization.
> > 
> > Does it make sense?
> > 
> > Do you prefer I just remove the "_" and we will refactor it once we
> > should add a customer for the proper task's util_est?
> 
> Hurm... I was thinking:
> 
>   task_util_est := max(util_avg, EWMA)
> 
> But the above mixes ENQUEUED into it.. *confused*.
> 
> Also, I think I'm confused by the 'enqueued' name... it makes sense for
> the cfs use-case, where we track the sum of all 'enqueued' tasks, but it
> doesn't make sense for the task use-case where it tracks task_util() at
> dequeue time.

Can be confusing at first, I've changed name in this version while
trying to consolidate concepts in a reasonable way.

Let see if I can cast some light...

First of all:

  a)  task_util_est := max(util_avg, EWMA, enqueued)
  b)       enqueued := util_avg@dequeue time


a) why we mix "enqueued" into?

   I think we need all the three components to properly describe these
   scenarios:

   - a task becoming smaller:
     the "EWMA" amortize the task's utilization reduction, usually
     converging to the new lower utilization in ~6 activations, which
     should be reasonable at least for some mobile use-cases.

   - a task becoming bigger:
     the "enqueued" value better represents the task utilization while
     the "EWMA" catches up, but... that's true only from the second
     longer running activation.
     For the first bigger activation, when the task starts to run
     longer then before, at a certain point the util_avg will be
     bigger both "enqueued" and "EWMA", thus task_util_est() should
     just track the PELT's "util_avg".

   Here is a picture showing all these behaviors using a "ramp" task
   generated with rt-app:

      https://photos.app.goo.gl/kRYgvpS6PTgvu2AM2

b) why enqueued for tasks?

  Since v3 it was:

     task : util_avg { util_est { last, ewma } }
     cpu  :   cfs_rq { util_est_enqueued }

  and Joel noticed that, since now util_est{} is part of util_avg{},
  which is included also by cfs_rq{}, then we can use the same
  util_avg{} for cfs_rq{} too.

  Problem was that using cfs_rq::util_est::last was not meaningful to
  me, hence I've try to find a concept which was working well for both
  cpus and tasks.

  Enqueued IMO seems to work for both, provided you read the task's
  enqueued util_est as:
     "the util_est of a task which is currently enqueued in its cfs_rq"
  which (only) happens to be the util_avg@dequeue time.

  IMO, also for tasks, that's not worst than util_est.last...
  Maybe it's just matter to add a bit of documentation in the util_est
  struct definition?

Does that makes a bit more sense now?

> > > > +/*
> > > > + * Check if the specified (signed) value is within a specified margin,
> > > > + * based on the observation that:
> > > > + *     abs(x) < y := (unsigned)(x + y - 1) < (2 * y - 1)
> > > > + */
> > > > +static inline bool within_margin(long value, unsigned int margin)
> > > 
> > > This mixing of long and int is dodgy, do we want to consistently use int
> > > here?
> > 
> > Right, perhaps better "unsigned int" for both params, isn't?
> 
> Can't, must be signed, since @value is supposed to be able to be
> negative remember? ;-)

Right... :)

> > > > +	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, util_est);
> 
> > > > +	WRITE_ONCE(p->se.avg.util_est.enqueued, util_last);
> > > 
> > > Two stores to that word... can we fix that nicely?
> > 
> > Good point, the single word comes from the goal to fit into the same
> > cache line of sched_avg.
> 
> Its the above two stores I confuzzled to be the same. So n/m all that.

Ok, fine... however, isn't a single WRITE_ONCE on "struct util_est"
still better? Did not checked at generated code...

> > > > +SCHED_FEAT(UTIL_EST, false)
> > > 
> > > Since you couldn't measure it, do we wants it true?
> > 
> > I'm just a single tester so far, I would be more confident once
> > someone volunteer to turn this on to give a better coverage.
> 
> Lets just enable it by default, that way its far more likely someone
> will complain about it :-), disabling it again is a trivial matter when
> needed.

Ok, at the end it's your call... but you right, this could help on
testing it better.

Moreover, on low-utilization (desktop like) workloads we do see
measurable benefits for interactive tasks.

> Also, your patch 2/3 have insufficient READ_ONCE()s.

Damn, I'll look at it...

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
