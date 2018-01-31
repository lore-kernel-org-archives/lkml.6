Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932097AbeAaPcc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 10:32:32 -0500
Received: from foss.arm.com ([217.140.101.70]:39292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753556AbeAaPc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 10:32:29 -0500
Date: Wed, 31 Jan 2018 15:32:23 +0000
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>,
        Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH v3 2/3] sched/fair: use util_est in LB and WU paths
Message-ID: <20180131153223.GD5739@e110439-lin>
References: <20180123180847.4477-1-patrick.bellasi@arm.com>
 <20180123180847.4477-3-patrick.bellasi@arm.com>
 <20180124113342.GD30677@codeaurora.org>
 <20180124193138.GB5739@e110439-lin>
 <20180125143358.GE30677@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180125143358.GE30677@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-Jan 20:03, Pavan Kondeti wrote:
> On Wed, Jan 24, 2018 at 07:31:38PM +0000, Patrick Bellasi wrote:
> > 
> > > > +       /*
> > > > +        * These are the main cases covered:
> > > > +        * - if *p is the only task sleeping on this CPU, then:
> > > > +        *      cpu_util (== task_util) > util_est (== 0)
> > > > +        *   and thus we return:
> > > > +        *      cpu_util_wake = (cpu_util - task_util) = 0
> > > > +        *
> > > > +        * - if other tasks are SLEEPING on the same CPU, which is just waking
> > > > +        *   up, then:
> > > > +        *      cpu_util >= task_util
> > > > +        *      cpu_util > util_est (== 0)
> > > > +        *   and thus we discount *p's blocked utilization to return:
> > > > +        *      cpu_util_wake = (cpu_util - task_util) >= 0
> > > > +        *
> > > > +        * - if other tasks are RUNNABLE on that CPU and
> > > > +        *      util_est > cpu_util
> > > > +        *   then we use util_est since it returns a more restrictive
> > > > +        *   estimation of the spare capacity on that CPU, by just considering
> > > > +        *   the expected utilization of tasks already runnable on that CPU.
> > > > +        */
> > > > +       util_est = cpu_rq(cpu)->cfs.util_est_runnable;
> > > > +       util = max(util, util_est);
> > > > +
> > > > +       return util;
> > 
> > I should instead clamp util before returning it! ;-)
> > 
> > > May be a separate patch to remove  the clamping part?
> > 
> > No, I think we should keep cpu_util_wake clamped to not affect the existing
> > call sites. I just need to remove it where not needed (done) and add it where
> > needed (will do on the next iteration).
> 
> cpu_util_wake() is called only from capacity_spare_wake(). There are no other
> callsites.

True...

> The capacity_spare_wake() is clamping the return value of
> cpu_util_wake() to CPU capacity.

... actually it's clamping negative numbers with:

   max_t(long, capacity_of(cpu) - cpu_util_wake(cpu, p), 0);

thus, by having cpu_util_wake returning potentially a value which is
bigger then capacity_of or capacity_orig_of we should not have issues
from a capacity_spare_wake() usage standpoint.

> The clamping is not needed, I think.

However, we can still argue that the cpu_util_wake() should never
return something bigger then the maximum possible capacity of a CPU.
At least that's the feature so fare.

Thus, even just for the sake of consistency, with previous returns
paths (e.g. when we bail out returning cpu_util), I would say that
it's worth to maintain this semantics.

With a clamping, all these functions:
 - cpu_util
 - cpu_util_est
 - cpu_util_wake
will always return a signal which is never bigger then the maximum
possible CPU capacity.

-- 
#include <best/regards.h>

Patrick Bellasi
