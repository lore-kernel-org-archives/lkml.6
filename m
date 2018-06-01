Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeFAOh4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:37:56 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:37554 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbeFAOhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:37:54 -0400
X-Google-Smtp-Source: ADUXVKJjWBOVr/LfMZ3HdAcH2nBVCKQYBz/oTxsWCWyUmm1NR7fvRVCzTRbG0jgLrPComcmaX4dTMkqUsGe2UB2cpPE=
MIME-Version: 1.0
In-Reply-To: <20180517201207.GA478@linaro.org>
References: <1526541403-16380-1-git-send-email-vincent.guittot@linaro.org>
 <20180517090530.GO12217@hirez.programming.kicks-ass.net> <20180517093206.GP12235@hirez.programming.kicks-ass.net>
 <20180517201207.GA478@linaro.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 1 Jun 2018 16:37:32 +0200
Message-ID: <CAKfTPtDXdo16gTPUf8RwXDuESTdn09c2W7J0YCCYjCxg8uuh6A@mail.gmail.com>
Subject: Re: [PATCH v2] sched/rt: fix call to cpufreq_update_util
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, Mike Galbraith <efault@gmx.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        "# v4 . 16+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w51Ec2IL007834

Hi Peter,

On 17 May 2018 at 22:12, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> Le Thursday 17 May 2018 à 11:32:06 (+0200), Peter Zijlstra a écrit :
>> On Thu, May 17, 2018 at 11:05:30AM +0200, Peter Zijlstra wrote:
>> > Hurm.. I think this is also wrong. See how dequeue_rt_stack() is also
>> > called from the enqueue path. Also, nothing calls cpufreq_update_util()
>> > on the throttle path now.
>
> Yes I missed the point that rt_entities were dequeued then re-enqueued when
> a task was either enqueued or dequeued.
>
> That's also means that enqueue_top_rt_rq() is always called when a task is
> enqueued or dequeued and also when groups are throttled or unthrottled
> In fact, the only point where it's not called, is when root rt_rq is
> throttled. So I have prepared the patch below which call cpufreq_update util
> in enqueue_top_rt_rq() and also when we throttle the root rt_rq.
> According to the tests I have done , it seems to work for enqueue/dequeue and
> throttle/unthrottle use cases.
>
> I have re-used your rt_rq_is_runnable() which takes into account rt_queued

What is the status for this problem ?

The patch below conflict with
b29bbbbff0d6 ('sched/cpufreq: always consider blocked FAIR utilization')
that has been merged in tip/sched/core

Do you want me to rebase it  ?

Regards,
Vincent

>
> ---
>  kernel/sched/cpufreq_schedutil.c |  2 +-
>  kernel/sched/rt.c                | 16 ++++++++++------
>  kernel/sched/sched.h             |  5 +++++
>  3 files changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index e13df95..1751f96 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -185,7 +185,7 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
>         struct rq *rq = cpu_rq(sg_cpu->cpu);
>         unsigned long util;
>
> -       if (rq->rt.rt_nr_running) {
> +       if (rt_rq_is_runnable(&rq->rt)) {
>                 util = sg_cpu->max;
>         } else {
>                 util = sg_cpu->util_dl;
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 7aef6b4..d6b9517 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -508,8 +508,11 @@ static void sched_rt_rq_dequeue(struct rt_rq *rt_rq)
>
>         rt_se = rt_rq->tg->rt_se[cpu];
>
> -       if (!rt_se)
> +       if (!rt_se) {
>                 dequeue_top_rt_rq(rt_rq);
> +               /* Kick cpufreq (see the comment in kernel/sched/sched.h). */
> +               cpufreq_update_util(rq_of_rt_rq(rt_rq), 0);
> +       }
>         else if (on_rt_rq(rt_se))
>                 dequeue_rt_entity(rt_se, 0);
>  }
> @@ -1001,8 +1004,6 @@ dequeue_top_rt_rq(struct rt_rq *rt_rq)
>         sub_nr_running(rq, rt_rq->rt_nr_running);
>         rt_rq->rt_queued = 0;
>
> -       /* Kick cpufreq (see the comment in kernel/sched/sched.h). */
> -       cpufreq_update_util(rq, 0);
>  }
>
>  static void
> @@ -1014,11 +1015,14 @@ enqueue_top_rt_rq(struct rt_rq *rt_rq)
>
>         if (rt_rq->rt_queued)
>                 return;
> -       if (rt_rq_throttled(rt_rq) || !rt_rq->rt_nr_running)
> +
> +       if (rt_rq_throttled(rt_rq))
>                 return;
>
> -       add_nr_running(rq, rt_rq->rt_nr_running);
> -       rt_rq->rt_queued = 1;
> +       if (rt_rq->rt_nr_running) {
> +               add_nr_running(rq, rt_rq->rt_nr_running);
> +               rt_rq->rt_queued = 1;
> +       }
>
>         /* Kick cpufreq (see the comment in kernel/sched/sched.h). */
>         cpufreq_update_util(rq, 0);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index c9895d3..bbebcfe 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -609,6 +609,11 @@ struct rt_rq {
>  #endif
>  };
>
> +static inline bool rt_rq_is_runnable(struct rt_rq *rt_rq)
> +{
> +       return rt_rq->rt_queued && rt_rq->rt_nr_running;
> +}
> +
>  /* Deadline class' related fields in a runqueue */
>  struct dl_rq {
>         /* runqueue is an rbtree, ordered by deadline */
> --
> 2.7.4
>
>
>
>
>
>> >
>> > And talking about throttle; I think we wanted to check rt_queued in that
>> > case.
>>
>> Bah, clearly you also want to update on unthrottle.. but I think there's
>> more buggered wrt throtteling.
>
>
>
>
