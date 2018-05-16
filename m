Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbeEPHNB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:13:01 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36776 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752500AbeEPHM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:12:58 -0400
X-Google-Smtp-Source: AB8JxZojlfGRWR45y/TuLJ6jDBrLZvJBYarXY3OHc2EaUqasMjw0aR/sSp0PMWuVar+YVqmF69WvUoZVF2zp4nOqbAQ=
MIME-Version: 1.0
In-Reply-To: <20180515145343.GJ30654@e110439-lin>
References: <20180510150553.28122-1-patrick.bellasi@arm.com>
 <20180510150553.28122-4-patrick.bellasi@arm.com> <20180513060443.GB64158@joelaf.mtv.corp.google.com>
 <20180513062538.GA116730@joelaf.mtv.corp.google.com> <20180514163206.GF30654@e110439-lin>
 <CAKfTPtCrUOJ=RGqrXMTc0_JFHzRjtpydoKmVNGT8KVz19QQ1vA@mail.gmail.com> <20180515145343.GJ30654@e110439-lin>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 16 May 2018 09:12:36 +0200
Message-ID: <CAKfTPtAieHNLeeobgRqoB=h4N_BakgbkaiP5g9PDuZAD-tt+ag@mail.gmail.com>
Subject: Re: [PATCH 3/3] sched/fair: schedutil: explicit update only when required
To: Patrick Bellasi <patrick.bellasi@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 May 2018 at 16:53, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> On 15-May 12:19, Vincent Guittot wrote:
>> On 14 May 2018 at 18:32, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>> > On 12-May 23:25, Joel Fernandes wrote:
>> >> On Sat, May 12, 2018 at 11:04:43PM -0700, Joel Fernandes wrote:
>> >> > On Thu, May 10, 2018 at 04:05:53PM +0100, Patrick Bellasi wrote:
>
> [...]
>
>> >> > One question about this change. In enqueue, throttle and unthrottle - you are
>> >> > conditionally calling cpufreq_update_util incase the task was
>> >> > visible/not-visible in the hierarchy.
>> >> >
>> >> > But in dequeue you're unconditionally calling it. Seems a bit inconsistent.
>> >> > Is this because of util_est or something? Could you add a comment here
>> >> > explaining why this is so?
>> >>
>> >> The big question I have is incase se != NULL, then its still visible at the
>> >> root RQ level.
>> >
>> > My understanding it that you get !se at dequeue time when we are
>> > dequeuing a task from a throttled RQ. Isn't it?
>>
>> Yes se becomes NULL only when you reach root domain
>
> Right, my point was mainly what I'm saing below: a task removed from a
> "throttled" cfs_rq is _already_ not visible from the root cfs_rq since
> it has been de-accounted at throttle_cfs_rq() time.
>
> [...]
>
>> > At dequeue time instead, since we certainly removed some estimated
>> > utilization, then I unconditionally updated schedutil.
>> >
>> > HOWEVER, I was not considering these two things:
>> >
>> > 1. for a task going to sleep, we still have its blocked utilization
>> >    accounted in the cfs_rq utilization.
>>
>> It might be still interesting to reduce the frequency because the
>> blocked utilization can be lower than its estimated utilization.
>
> Good point, this is the case of a task which, in its last activation,
> executed for less time then its previous estimated utilization.
>
> However, it could also very well be the opposite, a task which
> executed more then its past activation. In this case a schedutil
> update could trigger a frequency increase.
> Thus, the scheduler knows that we are going to sleep: does is really
> makes sense to send a notification in this case?

Why do you say that we are going to sleep ? a task that does to sleep
doesn't mean that cpu is going to sleep as well

>
> To me that's not a policy to choose when it makes sense to change the
> frequency, but just the proper definition of when it makes sense to
> send a notification.
>
> IMHO we should better consider not only (and blindly) the utilization
> changes but also what the scheduler knows about the status of a task.
> Thus: if the utilization change while a task is running, it's worth to
> send a notification. While, when a task is done on a CPU and that CPU
> is likely going to be idle, then maybe we should skip the
> notification.

I don't think so. Depending of the c-state, the power consumption can
be impacted and in addition we will have to do the frequency change at
wake up

>
>> > 2. for a task being migrated, at dequeue time we still have not
>> >    removed the task's utilization from the cfs_rq's utilization.
>> >    This usually happens later, for example we can have:
>> >
>> >       move_queued_task()
>> >          dequeue_task()                      --> CFS task dequeued
>> >          set_task_cpu()                         --> schedutil updated
>> >             migrate_task_rq_fair()
>> >                detach_entity_cfs_rq()
>> >                   detach_entity_load_avg()   --> CFS util removal
>> >          enqueue_task()
>> >
>> > Moreover, the "CFS util removal" actually affects the cfs_rq only if
>> > we hold the RQ lock, otherwise we know that it's just back annotated
>> > as "removed" utilization and the actual cfs_rq utilization is fixed up
>> > at the next chance we have the RQ lock.
>> >
>> > Thus, I would say that in both cases, at dequeue time it does not make
>> > sense to update schedutil since we always see the task's utilization
>> > in the cfs_rq and thus we will not reduce the frequency.
>>
>> Yes only attach/detach make sense from an utilization pov and that's
>> where we should check for a frequency update for utilization
>
> Indeed, I was considering the idea to move the callbacks there, which
> are the only code places where we know for sure that some utilization
> joined or departed from a CPU.
>
> Still have to check better however, because these functions can be
> called also for non root cfs_rqs... thus we will need again the
> filtering condition we have now in the wrapper function.

yes probably

>
>> > NOTE, this is true independently from the refactoring I'm proposing.
>> > At dequeue time, although we call update_load_avg() on the root RQ,
>> > it does not make sense to update schedutil since we still see either
>> > the blocked utilization of a sleeping task or the not yet removed
>> > utilization of a migrating task. In both cases the risk is to ask for
>> > an higher OPP right when a CPU is going to be IDLE.
>>
>> We have to take care of not mixing the opportunity to update the
>> frequency when we are updating the utilization with the policy that we
>> want to apply regarding (what we think that is) the best time to
>> update the frequency. Like saying that we should wait a bit more to
>> make sure that the current utilization is sustainable because a
>> frequency change is expensive on the platform (or not)
>
> I completely agree on keeping utilization update notification separated
> from schedutil decisions...
>
>> It's not because a task is dequeued that we should not update and
>> increase the frequency; Or even that we should not decrease it because
>> we have just taken into account some removed utilization of a previous
>> migration.
>> The same happen when a task migrates, we don't know if the utilization
>> that is about to be migrated, will be higher or lower than the normal
>> update of the utilization (since the last update) and can not generate
>> a frequency change
>>
>> I see your explanation above like a kind of policy where you want to
>> balance the cost of a frequency change with the probability that we
>> will not have to re-update the frequency soon.
>
> That was not my thinking. What I wanted to say is just that we should
> send notification when it makes really sense, because we have the most
> valuable information to pass.
>
> Thus, notifying schedutil when we update the RQ utilization is a bit
> of a greedy approach with respect to the information the scheduler has.
>
> In the migration example above:
> - first we update the RQ utilization
> - then we actually remove from the RQ the utilization of the migrated
>   task
> If we notify schedutil at the first step we are more likely to pass an
> already outdated information, since from the scheduler standpoint we
> know that we are going to reduce the CPU utilization quite soon.
> Thus, would it not be better to defer the notification at detach time?

better or not I would say that this depends of the platform, the cost
of changing the frequency, how many OPP there are and the gap between
these OPP ...

>
> After all that's the original goal of this patch
>
>> I agree that some scheduling events give higher chances of a
>> sustainable utilization level and we should favor these events when
>> the frequency change is costly but I'm not sure that we should remove
>> all other opportunity to udjust the frequency to the current
>> utilization level when the cost is low or negligible.
>
> Maybe we can try to run hackbench to quantify the overhead we add with
> useless schedutil updates. However, my main concerns is that if we
> want a proper decoupling between the scheduler and schedutil, then we
> also have to ensure that we callback for updates only when it really
> makes sense.
>
> Otherwise, the risk is that the schedutil policy will take decisions
> based on wrong assumptions like: ok, let's increase the OPP (since I
> can now and it's cheap) without knowing that the CPU is instead going
> to be almost empty or even IDLE.
>
>> Can't we classify the utilization events into some kind of major and
>> minor changes ?
>
> Doesn't a classification itself looks more like a policy?
>
> Maybe we can consider it, but still I think we should be able to find
> when the scheduler has the most accurate and updated information about
> the tasks actually RUNNABLE on a CPU and at that point send a
> notification to schedutil.
>
> IMO there are few small events when the utilization could have big
> changes: and these are wakeups (because of util_est) and migrations.

This 2 events looks very few

> For all the rest, the tick should be a good enough update rate,
> considering also that, even at 250Hz, in 4ms PELT never build up more
> then ~8%.

And at 100HZ which is default for arm32, it's almost 20%

>
> [...]
>
>> > .:: Conclusions
>> > ===============
>> >
>> > All that considered, I think I've convinced myself that we really need
>> > to notify schedutil only in these cases:
>> >
>> >  1. enqueue time
>> >     because of the changes in estimated utilization and the
>> >     possibility to just straight to a better OPP
>> >
>> >  2. task tick time
>> >     because of the possible ramp-up of the utilization
>> >
>> > Another case is related to remote CPUs blocked utilization update,
>> > after the recent Vincent's patches. Currently indeed:
>> >
>> >   update_blocked_averages()
>> >      update_load_avg()
>> >         --> update schedutil
>> >
>> > and thus, potentially we wake up an IDLE cluster just to reduce its
>> > OPP. If the cluster is in a deep idle state, I'm not entirely sure
>> > this is good from an energy saving standpoint.
>> > However, with the patch I'm proposing we are missing that support,
>> > meaning that an IDLE cluster will get its utilization decayed but we
>> > don't wake it up just to drop its frequency.
>>
>> So more than deciding in the scheduler if we should wake it up or not,
>> we should give a chance to cpufreq to decide if it wants to update the
>> frequency or not as this decision is somehow platform specific: cost
>> of frequency change, clock topology and shared clock, voltage topology
>> ...
>
> Fair enough, then we should keep updating schedutil from that code path.
>
> What about adding a new explicit callback at the end of:
>    update_blocked_averages() ?
>
> Something like:
>
> ---8<---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cb77407ba485..6eb0f31c656d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7740,6 +7740,9 @@ static void update_blocked_averages(int cpu)
>         if (done)
>                 rq->has_blocked_load = 0;
>  #endif
> +
> +       cpufreq_update_util(rq, SCHED_CPUFREQ_IDLE);
> +
>         rq_unlock_irqrestore(rq, &rf);
>  }
> ---8<---
>
> Where we can also pass in a new SCHED_CPUFREQ_IDLE flag just to notify
> schedutil that the CPU is currently IDLE?
>
> Could that work?
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
