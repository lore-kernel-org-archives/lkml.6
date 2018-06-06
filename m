Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jxJTJZx3"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 66AB76037B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbeFFQGh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 12:06:37 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35692 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbeFFQGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 12:06:36 -0400
X-Google-Smtp-Source: ADUXVKJ9OJxfB5rM2+CIZVifz6o/YliGYW5YCqX9ZERhmtnGvatI3t+vSVDKti1SuDybjwInO3uD33/UHwkYRehA/K8=
MIME-Version: 1.0
In-Reply-To: <fba5a810-3c3b-dc8b-15fb-8078a591ec2b@arm.com>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-8-git-send-email-vincent.guittot@linaro.org>
 <72473e6f-8ade-8e26-3282-276fcae4c4c7@arm.com> <CAKfTPtC8c9sP7TjefZPN2SFuNVGS7Q12WBj3BBYEbJFzxVN-2A@mail.gmail.com>
 <fba5a810-3c3b-dc8b-15fb-8078a591ec2b@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 6 Jun 2018 18:06:14 +0200
Message-ID: <CAKfTPtAMf1FUyY-HtziVzZ8JecnKTrQ1LaF60hg6bd=Nv9pCQQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/10] sched/irq: add irq utilization tracking
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,

Sorry for the late answer

On 31 May 2018 at 18:54, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> On 05/30/2018 08:45 PM, Vincent Guittot wrote:
>> Hi Dietmar,
>>
>> On 30 May 2018 at 17:55, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>> On 05/25/2018 03:12 PM, Vincent Guittot wrote:
>
> [...]
>
>>>> +        */
>>>> +       ret = ___update_load_sum(rq->clock - running, rq->cpu,
>>>> &rq->avg_irq,
>>>> +                               0,
>>>> +                               0,
>>>> +                               0);
>>>> +       ret += ___update_load_sum(rq->clock, rq->cpu, &rq->avg_irq,
>>>> +                               1,
>>>> +                               1,
>>>> +                               1);
>
> Can you not change the function parameter list to the usual
> (u64 now, struct rq *rq, int running)?
>
> Something like this (only compile and boot tested):

To be honest, I prefer to keep the specific sequence above in a
dedicated function instead of adding it in core code.
Furthermore,  we end up calling call twice ___update_load_avg instead
of only once. This will set an intermediate and incorrect value in
util_avg and this value can be read in the meantime

Vincent

>
> -- >8 --
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9894bc7af37e..26ffd585cab8 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -177,8 +177,22 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
>         rq->clock_task += delta;
>
>  #if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> -       if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
> -               update_irq_load_avg(rq, irq_delta + steal);
> +       if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY)) {
> +               /*
> +                * We know the time that has been used by interrupt since last
> +                * update but we don't when. Let be pessimistic and assume that
> +                * interrupt has happened just before the update. This is not
> +                * so far from reality because interrupt will most probably
> +                * wake up task and trig an update of rq clock during which the
> +                * metric si updated.
> +                * We start to decay with normal context time and then we add
> +                * the interrupt context time.
> +                * We can safely remove running from rq->clock because
> +                * rq->clock += delta with delta >= running
> +                */
> +               update_irq_load_avg(rq_clock(rq) - (irq_delta + steal), rq, 0);
> +               update_irq_load_avg(rq_clock(rq), rq, 1);
> +       }
>  #endif
>  }
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1bb3379c4b71..a245f853c271 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7363,7 +7363,7 @@ static void update_blocked_averages(int cpu)
>         }
>         update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
>         update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
> -       update_irq_load_avg(rq, 0);
> +       update_irq_load_avg(rq_clock(rq), rq, 0);
>         /* Don't need periodic decay once load/util_avg are null */
>         if (others_rqs_have_blocked(rq))
>                 done = false;
> @@ -7434,7 +7434,7 @@ static inline void update_blocked_averages(int cpu)
>         update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
>         update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
>         update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
> -       update_irq_load_avg(rq, 0);
> +       update_irq_load_avg(rq_clock(rq), rq, 0);
>  #ifdef CONFIG_NO_HZ_COMMON
>         rq->last_blocked_load_update_tick = jiffies;
>         if (!cfs_rq_has_blocked(cfs_rq) && !others_rqs_have_blocked(rq))
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index d2e4f2186b13..ae01bb18e28c 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -365,31 +365,15 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
>   *
>   */
>
> -int update_irq_load_avg(struct rq *rq, u64 running)
> +int update_irq_load_avg(u64 now, struct rq *rq, int running)
>  {
> -       int ret = 0;
> -       /*
> -        * We know the time that has been used by interrupt since last update
> -        * but we don't when. Let be pessimistic and assume that interrupt has
> -        * happened just before the update. This is not so far from reality
> -        * because interrupt will most probably wake up task and trig an update
> -        * of rq clock during which the metric si updated.
> -        * We start to decay with normal context time and then we add the
> -        * interrupt context time.
> -        * We can safely remove running from rq->clock because
> -        * rq->clock += delta with delta >= running
> -        */
> -       ret = ___update_load_sum(rq->clock - running, rq->cpu, &rq->avg_irq,
> -                               0,
> -                               0,
> -                               0);
> -       ret += ___update_load_sum(rq->clock, rq->cpu, &rq->avg_irq,
> -                               1,
> -                               1,
> -                               1);
> -
> -       if (ret)
> +       if (___update_load_sum(now, rq->cpu, &rq->avg_irq,
> +                               running,
> +                               running,
> +                               running)) {
>                 ___update_load_avg(&rq->avg_irq, 1, 1);
> +               return 1;
> +       }
>
> -       return ret;
> +       return 0;
>  }
> diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
> index 0ce9a5a5877a..ebc57301a9a8 100644
> --- a/kernel/sched/pelt.h
> +++ b/kernel/sched/pelt.h
> @@ -5,7 +5,7 @@ int __update_load_avg_se(u64 now, int cpu, struct cfs_rq *cfs_rq, struct sched_e
>  int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq);
>  int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
>  int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
> -int update_irq_load_avg(struct rq *rq, u64 running);
> +int update_irq_load_avg(u64 now, struct rq *rq, int running);
>
>  /*
>   * When a task is dequeued, its estimated utilization should not be update if
>
>
