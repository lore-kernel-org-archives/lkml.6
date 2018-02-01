Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752908AbeBAR0y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 12:26:54 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:34892 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752878AbeBAR0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 12:26:51 -0500
X-Google-Smtp-Source: AH8x226P0JbRepOVzZPjwLZlxzpO24JR+WrQc5PqzyeZJv4su4bU+FD8PAt93Te4CJWlTr466gYuWxi2gBMXdqedu5U=
MIME-Version: 1.0
In-Reply-To: <20180201165749.GE2269@hirez.programming.kicks-ass.net>
References: <CAKfTPtC0+5zjvgNXMyVcvnnyJh0giQgJHtx+5p-GEpjUW1x8eg@mail.gmail.com>
 <20171222082915.4lcb7xyyooqyjpia@hirez.programming.kicks-ass.net>
 <20171222091221.ow5vn3ydx3hj4nht@hirez.programming.kicks-ass.net>
 <CAKfTPtAzutuyA7D2qOErKPwdFaRK082YAtVn4ci8hAOUvL3zMQ@mail.gmail.com>
 <20171222185629.lysjebfifgdwvvhu@hirez.programming.kicks-ass.net>
 <20171222204247.kyc6ugyyu3ei7zhs@hirez.programming.kicks-ass.net>
 <CAKfTPtD13p-n9otxq23rQZZKUfA1r03bxYBSDtSdm5HbWX7H6Q@mail.gmail.com>
 <20180115082609.GA6320@linaro.org> <20180118103807.GD28799@e105550-lin.cambridge.arm.com>
 <20180124082536.GA32318@linaro.org> <20180201165749.GE2269@hirez.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 1 Feb 2018 18:26:30 +0100
Message-ID: <CAKfTPtC-kbAU8FsacrbJ5Qrs8qK4LXS5tC5Y4Sky=9vri8VmJg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] sched: Add NOHZ_STATS_KICK
To: Peter Zijlstra <peterz@infradead.org>
Cc: Morten Rasmussen <morten.rasmussen@foss.arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 February 2018 at 17:57, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Jan 24, 2018 at 09:25:36AM +0100, Vincent Guittot wrote:
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 898785d..ed90303 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -7356,6 +7356,17 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
>>       return true;
>>  }
>>
>> +static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
>> +{
>> +     if (cfs_rq->avg.load_avg)
>> +             return true;
>> +
>> +     if (cfs_rq->avg.util_avg)
>> +             return true;
>> +
>> +     return false;
>> +}
>> +
>>  #ifdef CONFIG_FAIR_GROUP_SCHED
>>
>>  static void update_blocked_averages(int cpu)
>> @@ -7393,7 +7404,9 @@ static void update_blocked_averages(int cpu)
>>                */
>>               if (cfs_rq_is_decayed(cfs_rq))
>>                       list_del_leaf_cfs_rq(cfs_rq);
>> -             else
>> +
>> +             /* Don't need periodic decay once load/util_avg are null */
>> +             if (cfs_rq_has_blocked(cfs_rq))
>>                       done = false;
>>       }
>>
>> @@ -7463,7 +7476,7 @@ static inline void update_blocked_averages(int cpu)
>>       update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
>>  #ifdef CONFIG_NO_HZ_COMMON
>>       rq->last_blocked_load_update_tick = jiffies;
>> -     if (cfs_rq_is_decayed(cfs_rq))
>> +     if (cfs_rq_has_blocked(cfs_rq))
>>               rq->has_blocked_load = 0;
>>  #endif
>>       rq_unlock_irqrestore(rq, &rf);
>
> OK makes sense; would've been even better as a separate patch :-)

Yes  i will make a separate patch for that
