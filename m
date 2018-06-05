Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751532AbeFEG53 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:57:29 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51298 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbeFEG51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:57:27 -0400
X-Google-Smtp-Source: ADUXVKJ5ZAczGjzN+OsMVCD9kn1Ib7npdjIEmY1r/Wo0PyWdOOe/LsWktaBs60zSJKYCOhKoZvUJFi2OK0Rgpaz3Skw=
MIME-Version: 1.0
In-Reply-To: <20180604160600.22052-3-patrick.bellasi@arm.com>
References: <20180604160600.22052-1-patrick.bellasi@arm.com> <20180604160600.22052-3-patrick.bellasi@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 5 Jun 2018 08:57:05 +0200
Message-ID: <CAKfTPtD8RDxT=-oO2VYJRbtwoEyEKEAau-Ad-bAd8L2T2zKWEg@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/fair: util_est: add running_sum tracking
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 June 2018 at 18:06, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> The estimated utilization of a task is affected by the task being
> preempted, either by another FAIR task of by a task of an higher
> priority class (i.e. RT or DL). Indeed, when a preemption happens, the
> PELT utilization of the preempted task is going to be decayed a bit.
> That's actually correct for utilization, which goal is to measure the
> actual CPU bandwidth consumed by a task.
>
> However, the above behavior does not allow to know exactly what is the
> utilization a task "would have used" if it was running without
> being preempted. Thus, this reduces the effectiveness of util_est for a
> task because it does not always allow to predict how much CPU a task is
> likely to require.
>
> Let's improve the estimated utilization by adding a new "sort-of" PELT
> signal, explicitly only for SE which has the following behavior:
>  a) at each enqueue time of a task, its value is the (already decayed)
>     util_avg of the task being enqueued
>  b) it's updated at each update_load_avg
>  c) it can just increase, whenever the task is actually RUNNING on a
>     CPU, while it's kept stable while the task is RUNNANBLE but not
>     actively consuming CPU bandwidth
>
> Such a defined signal is exactly equivalent to the util_avg for a task
> running alone on a CPU while, in case the task is preempted, it allows
> to know at dequeue time how much would have been the task utilization if
> it was running alone on that CPU.

I don't agree with this statement above
Let say that you have 2 periodic tasks which wants to run 4ms in every
period of 10ms and wakes up at the same time.
One task will execute 1st and the other will wait but at the end they
have the same period and running time and as a result the same
util_avg which is exactly what they need.

>
> This new signal is named "running_avg", since it tracks the actual
> RUNNING time of a task by ignoring any form of preemption.

In fact, you still take into account this preemption as you remove
some time whereas it's only a shift of the excution

>
> From an implementation standpoint, since the sched_avg should fit into a
> single cache line, we save space by tracking only a new runnable sum:
>    p->se.avg.running_sum
> while the conversion into a running_avg is done on demand whenever we
> need it, which is at task dequeue time when a new util_est sample has to
> be collected.
>
> The conversion from "running_sum" to "running_avg" is done by performing
> a single division by LOAD_AVG_MAX, which introduces a small error since
> in the division we do not consider the (sa->period_contrib - 1024)
> compensation factor used in ___update_load_avg(). However:
>  a) this error is expected to be limited (~2-3%)
>  b) it can be safely ignored since the estimated utilization is the only
>     consumer which is already subject to small estimation errors
>
> The additional corresponding benefit is that, at run-time, we pay the
> cost for a additional sum and multiply, while the more expensive
> division is required only at dequeue time.
>
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Steve Muckle <smuckle@google.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Morten Rasmussen <morten.rasmussen@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> ---
>  include/linux/sched.h |  1 +
>  kernel/sched/fair.c   | 16 ++++++++++++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 9d8732dab264..2bd5f1c68da9 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -399,6 +399,7 @@ struct sched_avg {
>         u64                             load_sum;
>         u64                             runnable_load_sum;
>         u32                             util_sum;
> +       u32                             running_sum;
>         u32                             period_contrib;
>         unsigned long                   load_avg;
>         unsigned long                   runnable_load_avg;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f74441be3f44..5d54d6a4c31f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3161,6 +3161,8 @@ accumulate_sum(u64 delta, int cpu, struct sched_avg *sa,
>                 sa->runnable_load_sum =
>                         decay_load(sa->runnable_load_sum, periods);
>                 sa->util_sum = decay_load((u64)(sa->util_sum), periods);
> +               if (running)
> +                       sa->running_sum = decay_load(sa->running_sum, periods);

so you make some time disappearing from the equation as the signal
will not be decayed and make the period looking shorter than reality.
With the example I mentioned above, the 2nd task will be seen as if
its period becomes 6ms instead of 10ms which is not true and the
utilization of the task is overestimated without any good reason
Furthermore, this new signal doesn't have clear meaning because it's
not utilization but it's also not the waiting time of the task.

>
>                 /*
>                  * Step 2
> @@ -3176,8 +3178,10 @@ accumulate_sum(u64 delta, int cpu, struct sched_avg *sa,
>                 sa->load_sum += load * contrib;
>         if (runnable)
>                 sa->runnable_load_sum += runnable * contrib;
> -       if (running)
> +       if (running) {
>                 sa->util_sum += contrib * scale_cpu;
> +               sa->running_sum += contrib * scale_cpu;
> +       }
>
>         return periods;
>  }
> @@ -3963,6 +3967,12 @@ static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
>         WRITE_ONCE(cfs_rq->avg.util_est.enqueued, enqueued);
>  }
>
> +static inline void util_est_enqueue_running(struct task_struct *p)
> +{
> +       /* Initilize the (non-preempted) utilization */
> +       p->se.avg.running_sum = p->se.avg.util_sum;
> +}
> +
>  /*
>   * Check if a (signed) value is within a specified (unsigned) margin,
>   * based on the observation that:
> @@ -4018,7 +4028,7 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
>          * Skip update of task's estimated utilization when its EWMA is
>          * already ~1% close to its last activation value.
>          */
> -       ue.enqueued = (task_util(p) | UTIL_AVG_UNCHANGED);
> +       ue.enqueued = p->se.avg.running_sum / LOAD_AVG_MAX;
>         last_ewma_diff = ue.enqueued - ue.ewma;
>         if (within_margin(last_ewma_diff, (SCHED_CAPACITY_SCALE / 100)))
>                 return;
> @@ -5437,6 +5447,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>         if (!se)
>                 add_nr_running(rq, 1);
>
> +       util_est_enqueue_running(p);
> +
>         hrtick_update(rq);
>  }
>
> --
> 2.15.1
>
