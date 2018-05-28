Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932373AbeE1PDL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:03:11 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:44509 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937150AbeE1O5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 10:57:55 -0400
X-Google-Smtp-Source: ADUXVKKyNFmC+bE/N3w5L8U6iFiyBNPyhUjkPPnMmuMhCaNa6SwRd+yOCv/A9gMMmNDkWbLlvOyJdO09XM7IQp19mHs=
MIME-Version: 1.0
In-Reply-To: <20180528101234.GA1293@localhost.localdomain>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-6-git-send-email-vincent.guittot@linaro.org> <20180528101234.GA1293@localhost.localdomain>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 28 May 2018 16:57:34 +0200
Message-ID: <CAKfTPtDCkzPMt6XrXRcURXm=53LABiwbFd3JMQkJDWpTprycRQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/10] cpufreq/schedutil: get max utilization
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Joel Fernandes <joelaf@google.com>,
        Alessio Balsini <alessio.balsini@santannapisa.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juri,

On 28 May 2018 at 12:12, Juri Lelli <juri.lelli@redhat.com> wrote:
> Hi Vincent,
>
> On 25/05/18 15:12, Vincent Guittot wrote:
>> Now that we have both the dl class bandwidth requirement and the dl class
>> utilization, we can use the max of the 2 values when agregating the
>> utilization of the CPU.
>>
>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>> ---
>>  kernel/sched/sched.h | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 4526ba6..0eb07a8 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -2194,7 +2194,11 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
>>  #ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
>>  static inline unsigned long cpu_util_dl(struct rq *rq)
>>  {
>> -     return (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
>> +     unsigned long util = (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
>
> I'd be tempted to say the we actually want to cap to this one above
> instead of using the max (as you are proposing below) or the
> (theoretical) power reduction benefits of using DEADLINE for certain
> tasks might vanish.

The problem that I'm facing is that the sched_entity bandwidth is
removed after the 0-lag time and the rq->dl.running_bw goes back to
zero but if the DL task has preempted a CFS task, the utilization of
the CFS task will be lower than reality and schedutil will set a lower
OPP whereas the CPU is always running. The example with a RT task
described in the cover letter can be run with a DL task and will give
similar results.
avg_dl.util_avg tracks the utilization of the rq seen by the scheduler
whereas rq->dl.running_bw gives the minimum to match DL requirement.

>
>> +
>> +     util = max_t(unsigned long, util, READ_ONCE(rq->avg_dl.util_avg));
>> +
>> +     return util;
>
> Anyway, just a quick thought. I guess we should experiment with this a
> bit. Now, I don't unfortunately have a Arm platform at hand for testing.
> Claudio, Luca (now Cc-ed), would you be able to fire some tests with
> this change?
>
> Oh, adding Joel and Alessio as well that experimented with DEADLINE
> lately.
>
> Thanks,
>
> - Juri
