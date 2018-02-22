Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753316AbeBVKFA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 05:05:00 -0500
Received: from foss.arm.com ([217.140.101.70]:38156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753088AbeBVKE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 05:04:59 -0500
Subject: Re: [PATCH v5 1/3] sched: Stop nohz stats when decayed
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <morten.rasmussen@foss.arm.com>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <1518622006-16089-1-git-send-email-vincent.guittot@linaro.org>
 <1518622006-16089-2-git-send-email-vincent.guittot@linaro.org>
 <44a7d9dc-f6f3-e003-44d6-b0c4aa7dc046@arm.com>
 <CAKfTPtAbr2vUvw2DvVCuqCXNnSA-7LuO2EaJ59pP=oJTgQ3R_g@mail.gmail.com>
 <a351f2de-3a00-1cf8-b16f-59493c5b67f5@arm.com>
 <CAKfTPtAM1z86FBqXOoEu-p2cZonUATWFq1vbZ=6pPHn9h5zM-g@mail.gmail.com>
From: Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <82f2d889-ee8a-98f6-c714-5ef7b399a84e@arm.com>
Date: Thu, 22 Feb 2018 10:04:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtAM1z86FBqXOoEu-p2cZonUATWFq1vbZ=6pPHn9h5zM-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/2018 08:37 AM, Vincent Guittot wrote:
> On 21 February 2018 at 14:13, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>> On 02/16/2018 01:44 PM, Vincent Guittot wrote:
>>> On 16 February 2018 at 13:13, Valentin Schneider
>>> <valentin.schneider@arm.com> wrote:
>>>> On 02/14/2018 03:26 PM, Vincent Guittot wrote:
>>>>> Stopped the periodic update of blocked load when all idle CPUs have fully
>>>>> decayed. We introduce a new nohz.has_blocked that reflect if some idle
>>>>> CPUs has blocked load that have to be periodiccally updated. nohz.has_blocked
>>>>> is set everytime that a Idle CPU can have blocked load and it is then clear
>>>>> when no more blocked load has been detected during an update. We don't need
>>>>> atomic operation but only to make cure of the right ordering when updating
>>>>> nohz.idle_cpus_mask and nohz.has_blocked.
>>>>>
>>>>> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>>>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>>>>> ---
>>>>>  kernel/sched/fair.c  | 122 ++++++++++++++++++++++++++++++++++++++++++---------
>>>>>  kernel/sched/sched.h |   1 +
>>>>>  2 files changed, 102 insertions(+), 21 deletions(-)
>>>>>
>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>>> index 7af1fa9..5a6835e 100644
>>>>> --- a/kernel/sched/fair.c
>>>>> +++ b/kernel/sched/fair.c
>>>>>
>>>>> [...]
>>
>> I have one more question on that bit:
>>
>>
>>                 has_blocked_load |= update_nohz_stats(rq, true);
>>
>>                 /*
>>                  * If time for next balance is due,
>>                  * do the balance.
>>                  */
>>                 if (time_after_eq(jiffies, rq->next_balance)) {
>>                         struct rq_flags rf;
>>
>>                         rq_lock_irqsave(rq, &rf);
>>                         update_rq_clock(rq);
>>                         cpu_load_update_idle(rq);
>>                         rq_unlock_irqrestore(rq, &rf);
>>
>>                         if (flags & NOHZ_BALANCE_KICK)
>>                                 rebalance_domains(rq, CPU_IDLE);
>>                 }
>>
>>                 if (time_after(next_balance, rq->next_balance)) {
>>                         next_balance = rq->next_balance;
>>                         update_next_balance = 1;
>>                 }
>>
>>
>> Now that I think about it, shouldn't we always have a 'continue' after
>> the blocked load update if (flags & NOHZ_KICK_MASK) == NOHZ_STATS_KICK ?
>> AFAICT we don't want to push the next_balance forward, only the next_blocked.
> 
> But we don't push next_balance forward. It just get the shortest
> next_balance and update nohz.next_balance exactly like what is done in
> full idle load balance
> 

Sorry, that was a poor choice of words - I probably should've just gone with
"update". What I meant by that is that if we have
    (flags & NOHZ_KICK_MASK) == NOHZ_STATS_KICK
then we're not going to do the load balance.

Then, in this case, I thought that we should not be going through any
condition that uses nohz.next_balance (since we're not doing any balancing).
Arguably *updating* nohz.next_balance still makes sense in this scenario.

In short, my comment was mostly about "cleanly" separating stats update vs
load balance.

>> That would also take care of not doing the load balance.
>>>>
>>>>                 /*
>>>>                  * This cpu doesn't have any remaining blocked load, skip it.
>>>>                  * It's sane to do this because this flag is raised in
>>>>                  * nohz_balance_enter_idle()
>>>>                  */
>>>>                 if ((flags & NOHZ_KICK_MASK) == NOHZ_STATS_KICK &&
>>>>                     !rq->has_blocked_load)
>>>>                         continue;
> 
> Then, it's worth keeping the call to cpu_load_update_idle(rq); which
> update the cpu_load[] array which is still used at some level
> 

Is that something we would want to have in update_nohz_stats() to also
cover the idle_balance -> load_balance update scenario ?
>From a quick glance I would've said it shouldn't be needed since the CPU doing
the updates wouldn't have been nohz previously, but we're currently calling
it when going through nohz_newidle_balance() so I might have gotten that wrong.

>>>>
>>>>> +             update_blocked_averages(rq->cpu);
>>>>> +             has_blocked_load |= rq->has_blocked_load;
>>>>> +
