Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeBHQwY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 11:52:24 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:43373 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeBHQwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 11:52:22 -0500
X-Google-Smtp-Source: AH8x225NZjVzpLIEQB6de92u5IhSOXpvg0IULK5WP2PT6FJb7HQAo+fQds95BFQd5YmX/2siuzGVrloUs4sDO439uoI=
MIME-Version: 1.0
In-Reply-To: <20180208154459.GA25181@hirez.programming.kicks-ass.net>
References: <1517944987-343-1-git-send-email-vincent.guittot@linaro.org>
 <1517944987-343-2-git-send-email-vincent.guittot@linaro.org>
 <20180208140005.GH25201@hirez.programming.kicks-ass.net> <CAKfTPtB0dDmovt=iM=efXUG1EY7GnOAuTTCf0VqTvx08fatWeQ@mail.gmail.com>
 <20180208154459.GA25181@hirez.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 8 Feb 2018 17:52:00 +0100
Message-ID: <CAKfTPtA0kmgD0XtMMweESojfuGFW1t9fT53=2QqtrJVbPV4QBw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] sched: Stop nohz stats when decayed
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Morten Rasmussen <morten.rasmussen@foss.arm.com>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 February 2018 at 16:44, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Feb 08, 2018 at 04:05:58PM +0100, Vincent Guittot wrote:
>> On 8 February 2018 at 15:00, Peter Zijlstra <peterz@infradead.org> wrote:
>> > On Tue, Feb 06, 2018 at 08:23:05PM +0100, Vincent Guittot wrote:
>> >
>> >> @@ -9207,13 +9231,15 @@ void nohz_balance_enter_idle(int cpu)
>> >>       if (!housekeeping_cpu(cpu, HK_FLAG_SCHED))
>> >>               return;
>> >>
>> >> +     rq->has_blocked_load = 1;
>
> Should we not set that with rq->lock held? We already clear it while
> holding rq->lock.

I think it's safe because it is used to re-enable the periodic decay
unconditionally.
It is cleared with  rq->lock held to prevents any update of the cfs_rq
*_avg  while deciding if we can clear has_blocked_load

>
>> >> +
>> >>       if (rq->nohz_tick_stopped)
>> >> -             return;
>> >
>> > this case is difficult... needs thinking
>>
>> The use case happens when a CPU wakes up and goes back to idle before
>> the tick fires and clears nohz_tick_stopped.
>
> Yes, and so we could have accrued blocked load. Now in this case the CPU
> must already be set in the cpumask, but we could've already cleared
> has_blocked.
>
> My question is mostly about needing that "goto out" to set the flag,
> because I think we can loose it on a store collision vs clearing it. But
> in that case I suppose the iteration must already be in progress, which
> in turn will observe rq->has_blocked_load and re-set nohz.has_blocked.
>
> So yes, this is good, but could use a comment.
>
>> > Without this ordering I think it would be possible to loose has_blocked
>> > and not observe the CPU either.
>>
>> I think that you are right.
>> I also wondered if some barriers were necessary but wrongly concluded
>> that set operation on nohz.idle_cpus_mask and WRITE_ONCE with volatile
>> would be enough to ensure the right ordering
>
> Yeah, so I forgot to write the comment in my patch, but it had the
> barriers implied by cmpxchg.
