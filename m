Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbeEPKpp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:45:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45888 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752450AbeEPKpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:45:42 -0400
Date: Wed, 16 May 2018 11:45:37 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH 3/3] sched/fair: schedutil: explicit update only when
 required
Message-ID: <20180516104537.GL30654@e110439-lin>
References: <20180510150553.28122-1-patrick.bellasi@arm.com>
 <20180510150553.28122-4-patrick.bellasi@arm.com>
 <20180513060443.GB64158@joelaf.mtv.corp.google.com>
 <20180513062538.GA116730@joelaf.mtv.corp.google.com>
 <20180514163206.GF30654@e110439-lin>
 <CAKfTPtCrUOJ=RGqrXMTc0_JFHzRjtpydoKmVNGT8KVz19QQ1vA@mail.gmail.com>
 <20180515145343.GJ30654@e110439-lin>
 <CAKfTPtAieHNLeeobgRqoB=h4N_BakgbkaiP5g9PDuZAD-tt+ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAieHNLeeobgRqoB=h4N_BakgbkaiP5g9PDuZAD-tt+ag@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-May 09:12, Vincent Guittot wrote:
> On 15 May 2018 at 16:53, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> > On 15-May 12:19, Vincent Guittot wrote:
> >> On 14 May 2018 at 18:32, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> >> > On 12-May 23:25, Joel Fernandes wrote:
> >> >> On Sat, May 12, 2018 at 11:04:43PM -0700, Joel Fernandes wrote:
> >> >> > On Thu, May 10, 2018 at 04:05:53PM +0100, Patrick Bellasi wrote:
> >
> > [...]
> >
> >> >> > One question about this change. In enqueue, throttle and unthrottle - you are
> >> >> > conditionally calling cpufreq_update_util incase the task was
> >> >> > visible/not-visible in the hierarchy.
> >> >> >
> >> >> > But in dequeue you're unconditionally calling it. Seems a bit inconsistent.
> >> >> > Is this because of util_est or something? Could you add a comment here
> >> >> > explaining why this is so?
> >> >>
> >> >> The big question I have is incase se != NULL, then its still visible at the
> >> >> root RQ level.
> >> >
> >> > My understanding it that you get !se at dequeue time when we are
> >> > dequeuing a task from a throttled RQ. Isn't it?
> >>
> >> Yes se becomes NULL only when you reach root domain
> >
> > Right, my point was mainly what I'm saing below: a task removed from a
> > "throttled" cfs_rq is _already_ not visible from the root cfs_rq since
> > it has been de-accounted at throttle_cfs_rq() time.
> >
> > [...]
> >
> >> > At dequeue time instead, since we certainly removed some estimated
> >> > utilization, then I unconditionally updated schedutil.
> >> >
> >> > HOWEVER, I was not considering these two things:
> >> >
> >> > 1. for a task going to sleep, we still have its blocked utilization
> >> >    accounted in the cfs_rq utilization.
> >>
> >> It might be still interesting to reduce the frequency because the
> >> blocked utilization can be lower than its estimated utilization.
> >
> > Good point, this is the case of a task which, in its last activation,
> > executed for less time then its previous estimated utilization.
> >
> > However, it could also very well be the opposite, a task which
> > executed more then its past activation. In this case a schedutil
> > update could trigger a frequency increase.
> > Thus, the scheduler knows that we are going to sleep: does is really
> > makes sense to send a notification in this case?
> 
> Why do you say that we are going to sleep ? a task that does to sleep
> doesn't mean that cpu is going to sleep as well

Yes, sure... that was just an example of a single task running on that
CPU. If this is not the last task, we will still have a tick in the
next (e.g.) 4ms... which will give us a better reading for all the
classes in any case.

> > To me that's not a policy to choose when it makes sense to change the
> > frequency, but just the proper definition of when it makes sense to
> > send a notification.
> >
> > IMHO we should better consider not only (and blindly) the utilization
> > changes but also what the scheduler knows about the status of a task.
> > Thus: if the utilization change while a task is running, it's worth to
> > send a notification. While, when a task is done on a CPU and that CPU
> > is likely going to be idle, then maybe we should skip the
> > notification.
> 
> I don't think so. Depending of the c-state, the power consumption can
> be impacted and in addition we will have to do the frequency change at
> wake up

Idle energy impacts more on shallow idle states, but that means that
(likely) we are also going to sleep for a short amount of time... and
the we will have a wakeup->enqueue where frequency will be updated
(eventually).

It seems that a frequency drop at IDLE enter is something which could
be really beneficial only if the blocked utilization is way smaller
then the estimated one. Thus, the idea to send a schedutil
notification with an explicit SCHED_CPUFREQ_IDLE flag could help in
supporting a proper decision policy from the schedutil side.

[...]

> > That was not my thinking. What I wanted to say is just that we should
> > send notification when it makes really sense, because we have the most
> > valuable information to pass.
> >
> > Thus, notifying schedutil when we update the RQ utilization is a bit
> > of a greedy approach with respect to the information the scheduler has.
> >
> > In the migration example above:
> > - first we update the RQ utilization
> > - then we actually remove from the RQ the utilization of the migrated
> >   task
> > If we notify schedutil at the first step we are more likely to pass an
> > already outdated information, since from the scheduler standpoint we
> > know that we are going to reduce the CPU utilization quite soon.
> > Thus, would it not be better to defer the notification at detach time?
> 
> better or not I would say that this depends of the platform, the cost
> of changing the frequency, how many OPP there are and the gap between
> these OPP ...

Yes, that decision can be supported by the additional hint provided by
the new flag.

> > After all that's the original goal of this patch
> >
> >> I agree that some scheduling events give higher chances of a
> >> sustainable utilization level and we should favor these events when
> >> the frequency change is costly but I'm not sure that we should remove
> >> all other opportunity to udjust the frequency to the current
> >> utilization level when the cost is low or negligible.
> >
> > Maybe we can try to run hackbench to quantify the overhead we add with
> > useless schedutil updates. However, my main concerns is that if we
> > want a proper decoupling between the scheduler and schedutil, then we
> > also have to ensure that we callback for updates only when it really
> > makes sense.
> >
> > Otherwise, the risk is that the schedutil policy will take decisions
> > based on wrong assumptions like: ok, let's increase the OPP (since I
> > can now and it's cheap) without knowing that the CPU is instead going
> > to be almost empty or even IDLE.
> >
> >> Can't we classify the utilization events into some kind of major and
> >> minor changes ?
> >
> > Doesn't a classification itself looks more like a policy?
> >
> > Maybe we can consider it, but still I think we should be able to find
> > when the scheduler has the most accurate and updated information about
> > the tasks actually RUNNABLE on a CPU and at that point send a
> > notification to schedutil.
> >
> > IMO there are few small events when the utilization could have big
> > changes: and these are wakeups (because of util_est) and migrations.
> 
> This 2 events looks very few
> 
> > For all the rest, the tick should be a good enough update rate,
> > considering also that, even at 250Hz, in 4ms PELT never build up more
> > then ~8%.
> 
> And at 100HZ which is default for arm32, it's almost 20%

Sure, 250Hz is the default for arm64, but still... 8-20% change is the
worst case where you have to ramp-up from 0: a task which toggle
between being small and big, which sounds also more likely to be a
theoretical case. Is there any other case?

Otherwise, for pretty much periodic tasks, util_est will give you the
right utilization for each activation. While new tasks always start
with a fraction of the spare utilization, isn't it?

Thus the tick seems to be "mainly" a fallback mechanism to follow the
utilization increase for tasks changing their behaviors.

Moreover, if your task is running for 10ms, on an Android system,
where usually you have 16ms periods, then it's a pretty big one (~60%)
and thus your utilization increase even slower: in 10ms you can build
up only 8% utilization.

All that to say that, excluding few corner cases, likely a tick based
update should be frequent enough... and I'm not factoring in here all
the approximation we have in PELT regarding the proper evaluation of
how big a task is... having more frequent updates to me it seems
over-engineering the solution thus introducing overheads without
clear benefits.

-- 
#include <best/regards.h>

Patrick Bellasi
