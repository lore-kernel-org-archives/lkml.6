Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="csT9D1eV"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9C46B60860
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932585AbeFFI0q (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 04:26:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37340 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932392AbeFFI0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 04:26:44 -0400
X-Google-Smtp-Source: ADUXVKKeppVOkG0n8Me0cDLopo1hoiXmuk5y9la92lHzysJyRBhoQ3VcYqWU0C9dSe4F4/KLbt86iA==
Date: Wed, 6 Jun 2018 10:26:40 +0200
From: Vincent Guittot <vincent.guittot@linaro.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>, Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH 2/2] sched/fair: util_est: add running_sum tracking
Message-ID: <20180606082640.GA14694@linaro.org>
References: <20180604160600.22052-1-patrick.bellasi@arm.com>
 <20180604160600.22052-3-patrick.bellasi@arm.com>
 <CAKfTPtD8RDxT=-oO2VYJRbtwoEyEKEAau-Ad-bAd8L2T2zKWEg@mail.gmail.com>
 <20180605151129.GC32302@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180605151129.GC32302@e110439-lin>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tuesday 05 Jun 2018 à 16:11:29 (+0100), Patrick Bellasi a écrit :
> Hi Vincent,
> 
> On 05-Jun 08:57, Vincent Guittot wrote:
> > On 4 June 2018 at 18:06, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> 
> [...]
> 
> > > Let's improve the estimated utilization by adding a new "sort-of" PELT
> > > signal, explicitly only for SE which has the following behavior:
> > >  a) at each enqueue time of a task, its value is the (already decayed)
> > >     util_avg of the task being enqueued
> > >  b) it's updated at each update_load_avg
> > >  c) it can just increase, whenever the task is actually RUNNING on a
> > >     CPU, while it's kept stable while the task is RUNNANBLE but not
> > >     actively consuming CPU bandwidth
> > >
> > > Such a defined signal is exactly equivalent to the util_avg for a task
> > > running alone on a CPU while, in case the task is preempted, it allows
> > > to know at dequeue time how much would have been the task utilization if
> > > it was running alone on that CPU.
> > 
> > I don't agree with this statement above
> > Let say that you have 2 periodic tasks which wants to run 4ms in every
> > period of 10ms and wakes up at the same time.
> > One task will execute 1st and the other will wait but at the end they
> > have the same period and running time and as a result the same
> > util_avg which is exactly what they need.
> 
> In your example above you say that both tasks will end up with a 40%
> util_avg, and that's exactly also the value reported by the new
> "running_avg" metric.

It's not really possible because the util_avg of the 2 tasks already give the exact same
right value. So running_avg, which removes some decay for the 2nd task, can't
give same results.

I add more details below

>
> 
> Both tasks, if they where running alone, they would have generated a
> 40% utilization, and above I'm saying:
> 
>         it allows to know at dequeue time
>    how much would have been the task utilization
>       if it it was running alone on that CPU
> 
> Don't see where is not correct, maybe I should explain it better?
> 
> > > This new signal is named "running_avg", since it tracks the actual
> > > RUNNING time of a task by ignoring any form of preemption.
> > 
> > In fact, you still take into account this preemption as you remove
> > some time whereas it's only a shift of the excution
> 
> When the task is enqueued we cache the (already decayed) util_avg, and
> from this time on the running_avg can only increase. It increases only
> for the portion of CPU time the task is running and it's never decayed
> while the task is preempted.
> 
> In your example above, if we look at the second task running, the one
> "delayed", you will have:
> 
>  @t1 wakeup time:    running_avg@t1 = util_avg@t1
>                         since we initialize it with the
>                         "sleep decayed" util_avg
> 
>   NOTE: this initialization is the important part, more on that on your
>   next comment below related to the period being changed.
> 
>  @t2 switch_in time: running_avg@t2 = running_avg@t1
>                         since it's not decayed while RUNNUBLE but !RUNNING
> 
>                      while, meanwhile:
> 
>                      util_avg@t2 < util_avg@t1
>                         since it's decayed while RUNNABLE but !RUNNING
> 
>  @t3 dequeue time:   running_avg@t3 > running_avg@t2
> 
> 
> When you say "it's only a shift of the execution" I agree, and indeed
> the running_avg is not affected at all.
> 
> So, we can say that I'm "accounting for preemption time" but really,
> the way I do it, is just by _not decaying_ PELT when the task is:
> 
>                  RUNNABLE but !RUNNING
> 
> and that's why I say that running_avg gives you the same behavior of
> util_avg _if_ the task was running alone, because in that case you never
> have the condition above, and thus util_avg is never decayed.
>

For the above 2 tasks of the example example we have the pattern

Task 1
state       RRRRSSSSSSERRRRSSSSSSERRRRSSSSSS
util_avg    AAAADDDDDD AAAADDDDDD AAAADDDDDD

Task 2
state       WWWWRRRRSSEWWWWRRRRSSEWWWWRRRRSS
util_avg    DDDDAAAADD DDDDAAAADD DDDDAAAADD
running_avg     AAAADDC    AAAADDC    AAAADD

R : Running 1ms, S: Sleep 1ms , W: Wait 1ms, E: Enqueue event 
A: Accumulate 1ms, D: Decay 1ms, C: Copy util_avg value

the util_avg of T1 and T2 have the same pattern which is:
  AAAADDDDDDAAAADDDDDDAAAADDDDDD
and as a result, the same value which represents their utilization

For the running_avg of T2, there is only 2 decays aftert the last running
phase and before the next enqueue
so the pattern will be AAAADDAAAA
instead of the         AAAADDDDDDAAAA

the runninh_avg will report a higher value than reality

>
> 
> [...]
> 
> > > @@ -3161,6 +3161,8 @@ accumulate_sum(u64 delta, int cpu, struct sched_avg *sa,
> > >                 sa->runnable_load_sum =
> > >                         decay_load(sa->runnable_load_sum, periods);
> > >                 sa->util_sum = decay_load((u64)(sa->util_sum), periods);
> > > +               if (running)
> > > +                       sa->running_sum = decay_load(sa->running_sum, periods);
> > 
> > so you make some time disappearing from the equation as the signal
> > will not be decayed and make the period looking shorter than reality.
> 
> Since at enqueue time we always initialize running_avg to whatever is
> util_avg, I don't think we are messing up with the period at all.
> 
> The util_avg signal properly accounts for the period.
> Thus, the combined effect of:
> 
>   - initializing running_avg at enqueue time with the value of
>     util_avg, already decayed to properly account for the task period
>   - not decaying running_avg when the task is RUNNABLE but !RUNNING
> 
> should just result into "virtually" considering the two tasks of your
> example "as if" they was running concurrently on two different CPUs.
> 
> Isn't it?

No because part of the "sleep" phase is done during the waiting time and
you don't take into account this sleep time

see my explanation above

> 
> > With the example I mentioned above, the 2nd task will be seen as if
> > its period becomes 6ms instead of 10ms which is not true and the
> > utilization of the task is overestimated without any good reason
> 
> I don't see that overestimation... and I cannot even measure it.
> 
> If I run an experiment with your example above, while using the
> performance governor to rule out any possible scale invariance
> difference, here is what I measure:
> 
>    Task1 (40ms delayed by the following Task2):

the 40ms above is a typo mistake ? you mean 4ms, isn't it ?

>                                mean          std     max
>       running_avg        455.387449    22.940168   492.i0

the 492 is the overestimation generated by running_avg and not a rounding
effect. With 4ms and 10ms the number of missing decay steps is small but if
you use 40ms/100ms instead you will see a greater difference in the max number

>       util_avg           433.233288    17.395477   458.0
> 
>    Task2 (waking up at same time of Task1 and running before):
>                                mean          std     max
>       running_avg        430.281834    22.405175   455.0
>       util_avg           421.745331    22.098873   456.0
> 
> and if I compare Task1 above with another experiment where Task1 is
> running alone:
> 
>    Task1 (running alone):
>                                mean          std     min
>       running_avg        460.257895    22.103704   460.0
>       util_avg           435.119737    17.647556   461.0
> 
> 
> Thus, there are some variations ok, but I think they are more due to
> the rounding errors we have.
> Task1 is still seen as a 455 expected utilization, which is not the
> 4/6 ~= 660 you say above if it should be accounted as a task running
> 4ms every 6ms.
> 
> > Furthermore, this new signal doesn't have clear meaning because it's
> > not utilization but it's also not the waiting time of the task.
> 
> The meaning is: the utilization of the task _if_ it should be running
> alone on that CPU. Tehe numbers above shows that since
>     455 (Task1 delayed) ~= 460 (Task1 running alone)

you should look at the max and not the mean that what util_est is interested
in IIUC

Vincent

> 
> If it's running alone it would be exactly util_avg (minus rounding
> errors), but if it's preempted it will be a better representation of
> the task's needed CPU bandwidth.
> 
> Unless we really need to track the "waiting time of a task" I would
> say that the signal above should make util_est much more accurate on
> knowing, at wakeup time, how much CPU a task will likely need...
> independently from preemption sources.
> 
> Here are some other experiments / workloads I'm testing:
> 
>    https://gist.github.com/derkling/fe01e5ddf639e18b5d85a3b1d2e84b7d
> 
> > >
> > >                 /*
> > >                  * Step 2
> > > @@ -3176,8 +3178,10 @@ accumulate_sum(u64 delta, int cpu, struct sched_avg *sa,
> > >                 sa->load_sum += load * contrib;
> > >         if (runnable)
> > >                 sa->runnable_load_sum += runnable * contrib;
> > > -       if (running)
> > > +       if (running) {
> > >                 sa->util_sum += contrib * scale_cpu;
> > > +               sa->running_sum += contrib * scale_cpu;
> > > +       }
> > >
> > >         return periods;
> > >  }
> > > @@ -3963,6 +3967,12 @@ static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
> > >         WRITE_ONCE(cfs_rq->avg.util_est.enqueued, enqueued);
> > >  }
> > >
> > > +static inline void util_est_enqueue_running(struct task_struct *p)
> > > +{
> > > +       /* Initilize the (non-preempted) utilization */
> > > +       p->se.avg.running_sum = p->se.avg.util_sum;
> 
> This line above is what should ensure we do not mess up with the task
> period.
> 
> > > +}
> > > +
> > >  /*
> > >   * Check if a (signed) value is within a specified (unsigned) margin,
> > >   * based on the observation that:
> > > @@ -4018,7 +4028,7 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
> > >          * Skip update of task's estimated utilization when its EWMA is
> > >          * already ~1% close to its last activation value.
> > >          */
> > > -       ue.enqueued = (task_util(p) | UTIL_AVG_UNCHANGED);
> > > +       ue.enqueued = p->se.avg.running_sum / LOAD_AVG_MAX;
> > >         last_ewma_diff = ue.enqueued - ue.ewma;
> > >         if (within_margin(last_ewma_diff, (SCHED_CAPACITY_SCALE / 100)))
> > >                 return;
> > > @@ -5437,6 +5447,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > >         if (!se)
> > >                 add_nr_running(rq, 1);
> > >
> > > +       util_est_enqueue_running(p);
> > > +
> > >         hrtick_update(rq);
> > >  }
> > >
> > > --
> > > 2.15.1
> > >
> 
> -- 
> #include <best/regards.h>
> 
> Patrick Bellasi
