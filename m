Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752251AbeENJTM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:19:12 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:53577 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbeENJTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:19:10 -0400
X-Google-Smtp-Source: AB8JxZprQx1BYmZ4Mtbz1FCqpxRf9XCsVktphx6pTXZfWdRmfFO/A+Ikxi/hwLVUMSsx5SaIo6ognYH+SAoWNt2nMc8=
MIME-Version: 1.0
In-Reply-To: <20180511091242.GE30654@e110439-lin>
References: <20180510150553.28122-1-patrick.bellasi@arm.com>
 <20180510150553.28122-2-patrick.bellasi@arm.com> <20180511054407.qxwyyqsgyzqsf6e4@vireshk-i7>
 <20180511091242.GE30654@e110439-lin>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 14 May 2018 11:18:49 +0200
Message-ID: <CAKfTPtCqoQOiJZktGu-QgCe2A7Cb0N7=eaqqSPN6vy=sKAkQHQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] sched/cpufreq: always consider blocked FAIR utilization
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 May 2018 at 11:12, Patrick Bellasi <patrick.bellasi@arm.com> wrote:

>>
>> Do we need a Fixes tag and Cc stable ?
>
> Mmm... no sure, I would say that's not a fix.
>
> As I say in the changelog above, 8f111bc357aa was doing the correct
> thing but, since the recent Vincent's commit 31e77c93e432, this is an
> update worth to have, since now we can trust the decay of blocked
> utilization.
>
> Regarding stable, well... if Vincent patches are not going to be
> considered for stable, then we should not consider this too, do we?

commit 31e77c93e432 is not for stable so this patch should not go too

>
>> >
>> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>> > index d2c6083304b4..a74d05160e66 100644
>> > --- a/kernel/sched/cpufreq_schedutil.c
>> > +++ b/kernel/sched/cpufreq_schedutil.c
>> > @@ -183,22 +183,21 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
>> >  static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
>> >  {
>> >     struct rq *rq = cpu_rq(sg_cpu->cpu);
>> > -   unsigned long util;
>> >
>> > -   if (rq->rt.rt_nr_running) {
>> > -           util = sg_cpu->max;
>> > -   } else {
>> > -           util = sg_cpu->util_dl;
>> > -           if (rq->cfs.h_nr_running)
>> > -                   util += sg_cpu->util_cfs;
>> > -   }
>> > +   if (rq->rt.rt_nr_running)
>> > +           return sg_cpu->max;
>> >
>> >     /*
>> > +    * Utilization required by DEADLINE must always be granted while, for
>> > +    * FAIR, we use blocked utilization of IDLE CPUs as a mechanism to
>> > +    * gracefully reduce the frequency when no tasks show up for longer
>> > +    * periods of time.
>> > +    *
>> >      * Ideally we would like to set util_dl as min/guaranteed freq and
>> >      * util_cfs + util_dl as requested freq. However, cpufreq is not yet
>> >      * ready for such an interface. So, we only do the latter for now.
>> >      */
>> > -   return min(util, sg_cpu->max);
>> > +   return min(sg_cpu->max, (sg_cpu->util_dl + sg_cpu->util_cfs));
>> >  }
>> >
>> >  static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time, unsigned int flags)
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>
>> --
>> viresh
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
