Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752713AbeDJLET (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 07:04:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36626 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752368AbeDJLER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 07:04:17 -0400
Date: Tue, 10 Apr 2018 12:04:12 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20180410110412.GG14248@e110439-lin>
References: <20180406172835.20078-1-patrick.bellasi@arm.com>
 <CAKfTPtCkZ1x-LS7sfJ7K2cgsKK=hYnDo1Fi3toPcGT0331Vpog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCkZ1x-LS7sfJ7K2cgsKK=hYnDo1Fi3toPcGT0331Vpog@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 09-Apr 10:51, Vincent Guittot wrote:
> Hi Patrick
> 
> On 6 April 2018 at 19:28, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> > Schedutil is not properly updated when the first FAIR task wakes up on a
> > CPU and when a RQ is (un)throttled. This is mainly due to the current
> > integration strategy, which relies on updates being triggered implicitly
> > each time a cfs_rq's utilization is updated.
> >
> > Those updates are currently provided (mainly) via
> >    cfs_rq_util_change()
> > which is used in:
> >  - update_cfs_rq_load_avg()
> >    when the utilization of a cfs_rq is updated
> >  - {attach,detach}_entity_load_avg()
> > This is done based on the idea that "we should callback schedutil
> > frequently enough" to properly update the CPU frequency at every
> > utilization change.
> >
> > Since this recent schedutil update:
> >
> >   commit 8f111bc357aa ("cpufreq/schedutil: Rewrite CPUFREQ_RT support")
> >
> > we use additional RQ information to properly account for FAIR tasks
> > utilization. Specifically, cfs_rq::h_nr_running has to be non-zero
> > in sugov_aggregate_util() to sum up the cfs_rq's utilization.
> 
> Isn't the use of cfs_rq::h_nr_running,  the root cause of the problem ?

Not really...

> I can now see a lot a frequency changes on my hikey with this new
> condition in sugov_aggregate_util().
> With a rt-app UC that creates a periodic cfs task, I have a lot of
> frequency changes instead of staying at the same frequency

I don't remember a similar behavior... but I'll check better.

> Peter,
> what was your goal with adding the condition "if
> (rq->cfs.h_nr_running)" for the aggragation of CFS utilization

The original intent was to get rid of sched class flags, used to track
which class has tasks runnable from within schedutil. The reason was
to solve some misalignment between scheduler class status and
schedutil status.

The solution, initially suggested by Viresh, and finally proposed by
Peter was to exploit RQ knowledges directly from within schedutil.

The problem is that now schedutil updated depends on two information:
utilization changes and number of RT and CFS runnable tasks.

Thus, using cfs_rq::h_nr_running is not the problem... it's actually
part of a much more clean solution of the code we used to have.

The problem, IMO is that we now depend on other information which
needs to be in sync before calling schedutil... and the patch I
proposed is meant to make it less likely that all the information
required are not aligned (also in the future).

-- 
#include <best/regards.h>

Patrick Bellasi
