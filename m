Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751792AbeFDGmO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 02:42:14 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:41453 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751409AbeFDGmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 02:42:13 -0400
X-Google-Smtp-Source: ADUXVKK6IIpZ+9eqcO31ni9IAGkmYsreaPxPFhj3R+pVrIaRGSj3Z7eAPXxUbMuxzpT90SxK9xUoBYXBJD+m3c9yWcQ=
MIME-Version: 1.0
In-Reply-To: <20180601174526.GA105687@joelaf.mtv.corp.google.com>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-6-git-send-email-vincent.guittot@linaro.org>
 <20180528101234.GA1293@localhost.localdomain> <CAKfTPtDCkzPMt6XrXRcURXm=53LABiwbFd3JMQkJDWpTprycRQ@mail.gmail.com>
 <20180528152243.GD1293@localhost.localdomain> <CAKfTPtAY26HZ00R02RuW2kvZLvZxHGvh-kbfrqv-hPumdknvWg@mail.gmail.com>
 <20180531102735.GM30654@e110439-lin> <CAKfTPtCeoimTehLktVk4WiTEM5h9KW_4yvuxGof8p6ZOgsRE2Q@mail.gmail.com>
 <20180601135307.GA28550@linaro.org> <20180601174526.GA105687@joelaf.mtv.corp.google.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 4 Jun 2018 08:41:51 +0200
Message-ID: <CAKfTPtBu5D=P3ib6fqfVLz9yQXN19ipRQAz5L6s1+ewnVTrHmg@mail.gmail.com>
Subject: Re: [PATCH v5 05/10] cpufreq/schedutil: get max utilization
To: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Alessio Balsini <alessio.balsini@santannapisa.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 June 2018 at 19:45, Joel Fernandes <joelaf@google.com> wrote:
> On Fri, Jun 01, 2018 at 03:53:07PM +0200, Vincent Guittot wrote:
>> > >> >> The example with a RT task described in the cover letter can be
>> > >> >> run with a DL task and will give similar results.
>> > >
>> > > In the cover letter you says:
>> > >
>> > >    A rt-app use case which creates an always running cfs thread and a
>> > >    rt threads that wakes up periodically with both threads pinned on
>> > >    same CPU, show lot of frequency switches of the CPU whereas the CPU
>> > >    never goes idles during the test.
>> > >
>> > > I would say that's a quite specific corner case where your always
>> > > running CFS task has never accumulated a util_est sample.
>> > >
>> > > Do we really have these cases in real systems?
>> >
>> > My example is voluntary an extreme one because it's easier to
>> > highlight the problem
>> >
>> > >
>> > > Otherwise, it seems to me that we are trying to solve quite specific
>> > > corner cases by adding a not negligible level of "complexity".
>> >
>> > By complexity, do you mean :
>> >
>> > Taking into account the number cfs running task to choose between
>> > rq->dl.running_bw and avg_dl.util_avg
>> >
>> > I'm preparing a patchset that will provide the cfs waiting time in
>> > addition to dl/rt util_avg for almost no additional cost. I will try
>> > to sent the proposal later today
>>
>>
>> The code below adds the tracking of the waiting level of cfs tasks because of
>> rt/dl preemption. This waiting time can then be used when selecting an OPP
>> instead of the dl util_avg which could become higher than dl bandwidth with
>> "long" runtime
>>
>> We need only one new call for the 1st cfs task that is enqueued to get these additional metrics
>> the call to arch_scale_cpu_capacity() can be removed once the later will be
>> taken into account when computing the load (which scales only with freq
>> currently)
>>
>> For rt task, we must keep to take into account util_avg to have an idea of the
>> rt level on the cpu which is given by the badnwodth for dl
>>
>> ---
>>  kernel/sched/fair.c  | 27 +++++++++++++++++++++++++++
>>  kernel/sched/pelt.c  |  8 ++++++--
>>  kernel/sched/sched.h |  4 +++-
>>  3 files changed, 36 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index eac1f9a..1682ea7 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5148,6 +5148,30 @@ static inline void hrtick_update(struct rq *rq)
>>  }
>>  #endif
>>
>> +static inline void update_cfs_wait_util_avg(struct rq *rq)
>> +{
>> +     /*
>> +      * If cfs is already enqueued, we don't have anything to do because
>> +      * we already updated the non waiting time
>> +      */
>> +     if (rq->cfs.h_nr_running)
>> +             return;
>> +
>> +     /*
>> +      * If rt is running, we update the non wait time before increasing
>> +      * cfs.h_nr_running)
>> +      */
>> +     if (rq->curr->sched_class == &rt_sched_class)
>> +             update_rt_rq_load_avg(rq_clock_task(rq), rq, 1);
>> +
>> +     /*
>> +      * If dl is running, we update the non time before increasing
>> +      * cfs.h_nr_running)
>> +      */
>> +     if (rq->curr->sched_class == &dl_sched_class)
>> +             update_dl_rq_load_avg(rq_clock_task(rq), rq, 1);
>> +}
>> +
>
> Please correct me if I'm wrong but the CFS preemption-decay happens in
> set_next_entity -> update_load_avg when the CFS task is scheduled again after
> the preemption. Then can we not fix this issue by doing our UTIL_EST magic
> from set_next_entity? But yeah probably we need to be careful with overhead..

util_est is there to keep track of the last max. I'm not sure that
trying to add some magics to take into account preemption is the right
way to do. Mixing several information in the same metric just add more
fuzzy in the meaning of the metric.

>
> IMO I feel its overkill to account dl_avg when we already have DL's running
> bandwidth we can use. I understand it may be too instanenous, but perhaps we

We keep using dl bandwidth which is quite correct for dl needs but
doesn't reflect how it has disturbed other classes

> can fix CFS's problems within CFS itself and not have to do this kind of
> extra external accounting ?
>
> I also feel its better if we don't have to call update_{rt,dl}_rq_load_avg
> from within CFS class as being done above.
>
> thanks,
>
>  - Joel
>
