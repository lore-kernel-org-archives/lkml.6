Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755540AbeDZLPm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:15:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52168 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754428AbeDZLPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:15:38 -0400
Date: Thu, 26 Apr 2018 12:15:33 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH] sched/fair: schedutil: update only with all info
 available
Message-ID: <20180426111533.GX14248@e110439-lin>
References: <20180406172835.20078-1-patrick.bellasi@arm.com>
 <CAKfTPtCkZ1x-LS7sfJ7K2cgsKK=hYnDo1Fi3toPcGT0331Vpog@mail.gmail.com>
 <20180410110412.GG14248@e110439-lin>
 <20180411151450.GK4043@hirez.programming.kicks-ass.net>
 <CAKfTPtC+-FR3ZD_t1vkGR2gVoUyxXpE=i4g9zqqLXu4jKKqgUA@mail.gmail.com>
 <20180411153710.GN4082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411153710.GN4082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-Apr 17:37, Peter Zijlstra wrote:
> On Wed, Apr 11, 2018 at 05:29:01PM +0200, Vincent Guittot wrote:
> > On 11 April 2018 at 17:14, Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Tue, Apr 10, 2018 at 12:04:12PM +0100, Patrick Bellasi wrote:
> > >> On 09-Apr 10:51, Vincent Guittot wrote:
> > >
> > >> > Peter,
> > >> > what was your goal with adding the condition "if
> > >> > (rq->cfs.h_nr_running)" for the aggragation of CFS utilization
> > >>
> > >> The original intent was to get rid of sched class flags, used to track
> > >> which class has tasks runnable from within schedutil. The reason was
> > >> to solve some misalignment between scheduler class status and
> > >> schedutil status.
> > >>
> > >> The solution, initially suggested by Viresh, and finally proposed by
> > >> Peter was to exploit RQ knowledges directly from within schedutil.
> > >>
> > >> The problem is that now schedutil updated depends on two information:
> > >> utilization changes and number of RT and CFS runnable tasks.
> > >>
> > >> Thus, using cfs_rq::h_nr_running is not the problem... it's actually
> > >> part of a much more clean solution of the code we used to have.
> > >>
> > >> The problem, IMO is that we now depend on other information which
> > >> needs to be in sync before calling schedutil... and the patch I
> > >> proposed is meant to make it less likely that all the information
> > >> required are not aligned (also in the future).
> > >
> > > Specifically, the h_nr_running test was get rid of
> > >
> > >                 if (delta_ns > TICK_NSEC) {
> > >                         j_sg_cpu->iowait_boost = 0;
> > >                         j_sg_cpu->iowait_boost_pending = false;
> > > -                       j_sg_cpu->util_cfs = 0;
> > >
> > >                         ^^^^^^^^^^^^^^^^^^^^^^^ that..
> > >
> > > -                       if (j_sg_cpu->util_dl == 0)
> > > -                               continue;
> > >                 }
> > >
> > >
> > > because that felt rather arbitrary.
> > 
> > yes I agree.
> > 
> > With the patch that updates blocked idle load, we should not have the
> > problem of blocked utilization anymore and get rid of the code above
> > and h_nr_running test
> 
> Yes, these patches predate those, but indeed, now that we age the
> blocked load consistently it should no longer be required.

After this discussion, I think there is a general consensus about
always add sg_cpu->util_cfs in cpufreq_schedutil.c::sugov_aggregate_util.

Is that right?

For the rest, what this patch proposes is a code reorganization which
is not required anymore to fix this specific issue but, it's still
required to fix the other issue reported by Vincent: i.e. util_est is
not updated before schedutil.

Thus, I would propose to still keep this refactoring but in the
context of a different patch to specifically fixes the util_est case.

If there are not major complains, I'll post a new series in the next
few days.

-- 
#include <best/regards.h>

Patrick Bellasi
