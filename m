Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752804AbeDJLoh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 07:44:37 -0400
Received: from foss.arm.com ([217.140.101.70]:37006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752333AbeDJLog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 07:44:36 -0400
Date: Tue, 10 Apr 2018 12:44:31 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Joel Fernandes <joelaf@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>, Steve Muckle <smuckle@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH] sched/fair: schedutil: update only with all info
 available
Message-ID: <20180410114431.GH14248@e110439-lin>
References: <20180406172835.20078-1-patrick.bellasi@arm.com>
 <CAJWu+or7OeTELc=yUuTw=vRKvU6VaCyeHp5gA1UJsLSFonYz0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+or7OeTELc=yUuTw=vRKvU6VaCyeHp5gA1UJsLSFonYz0w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On 06-Apr 16:48, Joel Fernandes wrote:
> On Fri, Apr 6, 2018 at 10:28 AM, Patrick Bellasi
> <patrick.bellasi@arm.com> wrote:
> > Schedutil is not properly updated when the first FAIR task wakes up on a
> > CPU and when a RQ is (un)throttled. This is mainly due to the current
> > integration strategy, which relies on updates being triggered implicitly
> > each time a cfs_rq's utilization is updated.
> 
> To me that's not implicit, but is explicitly done when the util is
> updated. It seems that's the logical place..

I'm not arguing the place is not logical, it makes perfect sense.
IMO it just makes more difficult to track dependencies like the one we
have now: when the root cfs_rq utilization is updated the h_nr_running
is not always aligned.

Moreover, when task groups are in use, we do many times a call to a
wrapper function which just bails out, since we are updating a non
root cfs_rq. Other reasons have also been detailed in the changelog.

I've notice that we already have pretty well defined call sites
in fair.c where we update the core's nr_running counter. These are
also the exact and only places where the root cfs_rq utilization
change, apart from the tick.

What I'm proposing here is meant not only to fix the current issue,
but also at possible find a code organization which makes less likely
to miss dependencies in possible future code updates too.
To me it looks more clean and, still have to look better at the code,
but I think this can be a first step to possibly factor all schedutil
updates (for FAIR and RT) into just core.c

[...]

> > This means that we are likely to see a zero cfs_rq utilization when we
> > enqueue a task on an empty CPU, or a non-zero cfs_rq utilization when
> > instead, for example, we are throttling all the FAIR tasks of a CPU.
> >
> > While the second issue is less important, since we are less likely to
> 
> Actually I wanted behavior like the second issue, because that means
> frequency will not be dropped if CPU is about to idle which is similar
> to a patch I sent long time ago (skip freq update if CPU about to
> idle).

I think that's a slightly different case since here a cfs_rq is
intentionally throttled thus we want to stop the tasks and potentially
to drop the frequency.

> > reduce frequency when CPU utilization decreases, the first issue can
> > instead impact performance. Indeed, we potentially introduce a not desired
> 
> This issue would be fixed by just fixing the h_nr_running bug right?

Sure, something like this:

---8<---
index 0951d1c58d2f..e9a31258d345 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5368,6 +5368,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
                if (se->on_rq)
                        break;
                cfs_rq = cfs_rq_of(se);
+               cfs_rq->h_nr_running++;
                enqueue_entity(cfs_rq, se, flags);
 
                /*
@@ -5377,8 +5378,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
                 * post the final h_nr_running increment below.
                 */
                if (cfs_rq_throttled(cfs_rq))
+                       cfs_rq->h_nr_running--;
                        break;
-               cfs_rq->h_nr_running++;
+               }
 
                flags = ENQUEUE_WAKEUP;
        }
---8<---

can probably easily fix one of the problems.

But I did not checked what does it imply to increment h_nr_running
before calling enqueue_entity() and cfs_rq_throttled().

Still we miss the (IMO) opportunity to make a more suitable single and
explicit function call only when needed. Which is also just few code
lines below in the same function as proposed by this patch.

> > latency between a task enqueue on a CPU and its frequency increase.
> >
> > Another possible unwanted side effect is the iowait boosting of a CPU
> > when we enqueue a task into a throttled cfs_rq.
> 
> Probably very very rare.

Still possible by code... and when you notice it you cannot think
about a non wanted behavior.

> > Moreover, the current schedutil integration has these other downsides:
> >
> >  - schedutil updates are triggered by RQ's load updates, which makes
> >    sense in general but it does not allow to know exactly which other RQ
> >    related information has been updated (e.g. h_nr_running).
> 
> It seems broken that all information that schedutil needs isn't
> updated _before_ the cpufreq update request, so that should be fixed
> instead?

That's what I'm trying to do here but, instead of doing before some
operations I'm proposing to postpone what can be done after.
Schedutil updates can be done right before returning to the core
scheduler, at which time we should be pretty sure all CFS related
info have been properly updated.

[...]

> > All the above considered, let's try to make schedutil updates more
> > explicit in fair.c by:
> >
> >  - removing the cfs_rq_util_change() wrapper function to use the
> >    cpufreq_update_util() public API only when root cfs_rq is updated
> >
> >  - remove indirect and side-effect (sometimes not required) schedutil
> >    updates when the cfs_rq utilization is updated
> >
> >  - call cpufreq_update_util() explicitly in the few call sites where it
> >    really makes sense and all the required information has been updated
> >
> > By doing so, this patch mainly removes code and adds explicit calls to
> > schedutil only when we:
> >  - {enqueue,dequeue}_task_fair() a task to/from the root cfs_rq
> >  - (un)throttle_cfs_rq() a set of tasks up to the root cfs_rq
> >  - task_tick_fair() to update the utilization of the root cfs_rq
> 
> About the "update for root" thingy, we're already doing rq->cfs ==
> cfs_rq in cfs_rq_util_change so its already covered?
> 
> Also, I feel if you can shorten the commit message a little and only
> include the best reasons for this patch that'll be nice so its easier
> to review.

Sorry for that, since (as demonstrated by your reply) I was expecting
quite some comments on this change, I just wanted to detail the
reasons and motivations behind the proposed change.

> > All the other code paths, currently _indirectly_ covered by a call to
> > update_load_avg(), are also covered by the above three calls.
> 
> I would rather we do it in as few places as possible (when util is
> updated for root) than spreading it around and making it "explicit". I
> hope I didn't miss something but I feel its explicit enough already...

Well, again, I'm not saying that the current solution is not possibly
working... just that it can make easy to possible break some
dependencies. Moreover, maybe it makes less easy to see that, perhaps,
we can factorize most of the schedutil updates into just core.c

> thanks!

Thanks for your time.

-- 
#include <best/regards.h>

Patrick Bellasi
