Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeDKJ2E (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:28:04 -0400
Received: from foss.arm.com ([217.140.101.70]:47056 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751854AbeDKJ2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:28:02 -0400
Date: Wed, 11 Apr 2018 10:27:56 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH] sched/fair: schedutil: update only with all info
 available
Message-ID: <20180411092756.GK14248@e110439-lin>
References: <20180406172835.20078-1-patrick.bellasi@arm.com>
 <CAKfTPtB+6LoduwinNxEyTq2TFsOv8jEjnQ3o0M=Sf5viB+PL0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtB+6LoduwinNxEyTq2TFsOv8jEjnQ3o0M=Sf5viB+PL0w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-Apr 09:57, Vincent Guittot wrote:
> On 6 April 2018 at 19:28, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> 
> >  }
> > @@ -5454,8 +5441,11 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >                 update_cfs_group(se);
> >         }
> >
> > -       if (!se)
> > +       /* The task is no more visible from the root cfs_rq */
> > +       if (!se) {
> >                 sub_nr_running(rq, 1);
> > +               cpufreq_update_util(rq, 0);
> 
> call to cpufreq_update_util() should be done after util_est_dequeue()

Yeah... good point, looks like I should have notice it :)

That's another compelling example why updating schedutil as a side
effect of update_load_avg does not allow to easily track when it's the
best time to trigger an update.

UtilEst is now a factor which could impact on OPP selection for CFS
tasks, and thus we should update at the really end of the function.

> > +       }
> >
> >         util_est_dequeue(&rq->cfs, p, task_sleep);
> >         hrtick_update(rq);

-- 
#include <best/regards.h>

Patrick Bellasi
