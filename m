Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754651AbeBATLi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 14:11:38 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:51108 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752973AbeBATLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 14:11:30 -0500
X-Google-Smtp-Source: AH8x22581ysvLFX0k2+mDCd6Mq7ty+TG6JCnO1mC5YqzwcDyo5RyPndTJ7zQXTP/2BxA9/lTbdxfKuwTVpw1+2t3k0c=
MIME-Version: 1.0
In-Reply-To: <20180201181041.GF2269@hirez.programming.kicks-ass.net>
References: <CAKfTPtC0+5zjvgNXMyVcvnnyJh0giQgJHtx+5p-GEpjUW1x8eg@mail.gmail.com>
 <20171222082915.4lcb7xyyooqyjpia@hirez.programming.kicks-ass.net>
 <20171222091221.ow5vn3ydx3hj4nht@hirez.programming.kicks-ass.net>
 <CAKfTPtAzutuyA7D2qOErKPwdFaRK082YAtVn4ci8hAOUvL3zMQ@mail.gmail.com>
 <20171222185629.lysjebfifgdwvvhu@hirez.programming.kicks-ass.net>
 <20171222204247.kyc6ugyyu3ei7zhs@hirez.programming.kicks-ass.net>
 <CAKfTPtD13p-n9otxq23rQZZKUfA1r03bxYBSDtSdm5HbWX7H6Q@mail.gmail.com>
 <20180115082609.GA6320@linaro.org> <20180118103807.GD28799@e105550-lin.cambridge.arm.com>
 <20180124082536.GA32318@linaro.org> <20180201181041.GF2269@hirez.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 1 Feb 2018 20:11:08 +0100
Message-ID: <CAKfTPtDT1JAM7q44T_nxoQvB2cGYb6H59wPXJmZQXvi+M9YyhA@mail.gmail.com>
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

On 1 February 2018 at 19:10, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Jan 24, 2018 at 09:25:36AM +0100, Vincent Guittot wrote:
>> @@ -8861,7 +8875,14 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
>>                       update_next_balance(sd, &next_balance);
>>               rcu_read_unlock();
>>
>> -             if (time_after(jiffies, next) && atomic_read(&nohz.stats_state))
>> +             /*
>> +              * Update blocked idle load if it has not been done for a
>> +              * while. Try to do it locally before entering idle but kick a
>> +              * ilb if it takes too much time and might delay next local
>> +              * wake up
>> +              */
>> +             if (time_after(jiffies, next) && atomic_read(&nohz.stats_state) &&
>> +                             !_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE))
>>                       kick_ilb(NOHZ_STATS_KICK);
>>
>>               goto out;
>
> This I really dislike. We're here because avg_idle is _really_ low, we
> really should not then call _nohz_idle_balance().

Yes. In fact I was targeting the case were (this_rq->avg_idle >=
sysctl_sched_migration_cost) and the system is not overloaded
