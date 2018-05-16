Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752568AbeEPHNn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:13:43 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:38008 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeEPHNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:13:42 -0400
X-Google-Smtp-Source: AB8JxZoEuhkDAHWdfaQVXtn4P6daykRb/E/SF5xu2hEn48rvQpUKwIXYgdVQ3oEoiBYWMXCeeP7n/FzCsazjSYC40pw=
MIME-Version: 1.0
In-Reply-To: <20180515165304.GH12217@hirez.programming.kicks-ass.net>
References: <20180510150553.28122-1-patrick.bellasi@arm.com>
 <20180510150553.28122-4-patrick.bellasi@arm.com> <20180513060443.GB64158@joelaf.mtv.corp.google.com>
 <20180513062538.GA116730@joelaf.mtv.corp.google.com> <20180514163206.GF30654@e110439-lin>
 <CAKfTPtCrUOJ=RGqrXMTc0_JFHzRjtpydoKmVNGT8KVz19QQ1vA@mail.gmail.com>
 <20180515145343.GJ30654@e110439-lin> <20180515165304.GH12217@hirez.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 16 May 2018 09:13:20 +0200
Message-ID: <CAKfTPtCUbe+qE47byN_1ptc+A1Tvt_E4Y-5rZQmBsUhLiMGAqw@mail.gmail.com>
Subject: Re: [PATCH 3/3] sched/fair: schedutil: explicit update only when required
To: Peter Zijlstra <peterz@infradead.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
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

On 15 May 2018 at 18:53, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, May 15, 2018 at 03:53:43PM +0100, Patrick Bellasi wrote:
>> On 15-May 12:19, Vincent Guittot wrote:
>> > On 14 May 2018 at 18:32, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>
>> > Yes se becomes NULL only when you reach root domain
>
> root group; domains are something else again ;-)

yes good point :-)

>
>> Thus, the scheduler knows that we are going to sleep: does is really
>> makes sense to send a notification in this case?
>
> It might; esp. on these very slow changing machines.
>
>> What about adding a new explicit callback at the end of:
>>    update_blocked_averages() ?
>>
>> Something like:
>>
>> ---8<---
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index cb77407ba485..6eb0f31c656d 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -7740,6 +7740,9 @@ static void update_blocked_averages(int cpu)
>>         if (done)
>>                 rq->has_blocked_load = 0;
>>  #endif
>> +
>> +       cpufreq_update_util(rq, SCHED_CPUFREQ_IDLE);
>> +
>>         rq_unlock_irqrestore(rq, &rf);
>>  }
>> ---8<---
>>
>> Where we can also pass in a new SCHED_CPUFREQ_IDLE flag just to notify
>> schedutil that the CPU is currently IDLE?
>>
>> Could that work?
>
> Simlarly you could add ENQUEUE/DEQUEUE flags I suppose. But let's do all
> that later in separate patches and evaluate the impact separately, OK?
