Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbeBFJW6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:22:58 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:39548 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752207AbeBFJWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:22:51 -0500
X-Google-Smtp-Source: AH8x226NhJZT1cZuUwSUGca/jD9PhGjZvdgdBfvimLMF8Vthvoch0SsXBi+mrDoEQf+uJhXyHGVk6LbCV+WVQOnUxEI=
MIME-Version: 1.0
In-Reply-To: <5694b3f8-9726-d5a8-dba3-e4c1619a05be@arm.com>
References: <20171222075934.f6yenvcb2zkf2ysd@hirez.programming.kicks-ass.net>
 <CAKfTPtC0+5zjvgNXMyVcvnnyJh0giQgJHtx+5p-GEpjUW1x8eg@mail.gmail.com>
 <20171222082915.4lcb7xyyooqyjpia@hirez.programming.kicks-ass.net>
 <20171222091221.ow5vn3ydx3hj4nht@hirez.programming.kicks-ass.net>
 <CAKfTPtAzutuyA7D2qOErKPwdFaRK082YAtVn4ci8hAOUvL3zMQ@mail.gmail.com>
 <20171222185629.lysjebfifgdwvvhu@hirez.programming.kicks-ass.net>
 <20171222204247.kyc6ugyyu3ei7zhs@hirez.programming.kicks-ass.net>
 <CAKfTPtD13p-n9otxq23rQZZKUfA1r03bxYBSDtSdm5HbWX7H6Q@mail.gmail.com>
 <20180115082609.GA6320@linaro.org> <20180118103807.GD28799@e105550-lin.cambridge.arm.com>
 <20180124082536.GA32318@linaro.org> <b1efd041-2faa-76e0-7d9b-3d2917e03012@arm.com>
 <CAKfTPtCmFC2mmR9SBTjjuuzPS8tFNmmrSRMmKrOrkh3uPkYYoA@mail.gmail.com>
 <4fb17712-3f98-c407-42b3-4601a4f294d9@arm.com> <5694b3f8-9726-d5a8-dba3-e4c1619a05be@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 6 Feb 2018 10:22:30 +0100
Message-ID: <CAKfTPtAh=tw1MpS_+V+bhmDD+8iq2_+3Tsh3csCSDQ5BKnySsw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] sched: Add NOHZ_STATS_KICK
To: Valentin Schneider <valentin.schneider@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@foss.arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w169N2Sa018720

On 5 February 2018 at 23:18, Valentin Schneider
<valentin.schneider@arm.com> wrote:
> On 01/30/2018 11:41 AM, Valentin Schneider wrote:
>> [...]
>>> I have studied a way to keep track of how many cpus still have blocked
>>> load to try to minimize the number of useless ilb kick but this add
>>> more atomic operations which can impact the system throughput with
>>> heavy load and lot of very small wake up. that's why i have propose
>>> this solution which is more simple. But it's probably just a matter of
>>> where we want to "waste" time. Either we accept to spent a bit more
>>> time to check the state of idle CPUs or we accept to kick ilb from
>>> time to time for no good reason.
>>>
>>
>> Agreed. I have the feeling that spending more time doing atomic ops could be worth it - I'll try to test this out and see if it's actually relevant.
>>
>
> I gave this a spin, still using Vincent's patches with the included patch on top. Nothing too clever, just seeing how replacing nohz.stats_state with a cpumask would go.
>
> I've replaced nohz.stats_state by nohz.stale_cpus_mask. I kept changes minimal - there are some places where I think nohz.idle_cpus_mask could be substituted by nohz.stale_cpus_mask. Speaking about that, I was about to write a comment regarding the fact that nohz.stale_cpus_mask should be a subset of nohz.idle_cpus_mask, but I realized it's actually not true:
>
> In the current implementation (cpumask or stats_state flag), an idle CPU is defined as having blocked load as soon as it goes through nohz_balance_enter_idle(), and that flag is cleared when we go through _nohz_idle_balance() (and newly idle load balance in my cpumask implementation).
> However we can imagine a scenario where a CPU goes idle, is flagged as having blocked load, then it wakes up and goes through its periodic balance code and updates that load. Yet, the flag (or cpumask) won't have been updated.
> So I think there could be a discussion on whether the flag should be cleared on nohz_balance_exit_idle() if we assume periodic balance now takes care of this. It could cause issues if we have a weird scenario where a CPU keeps going online/idle but never stays online long enough for a tick though.
> Alternatively we could clear that flag when going through the first periodic balance after idling, but then that's a bit weird because we're using a nohz structure in a non-nohz context.
>
>
> Anyway, I tried to get some profiling done with the cpumask but there's something wrong with my setup, I would only get nonsense numbers (for both baseline & my patch), so I added start/end trace_printks to _nohz_idle_balance(). It's ugly, inaccurate and unorthodox but it still gives a rough idea of how the cpumask impacts stuff.
> I ran 20 iterations of my "nohz update" test case (a task accumulates load, goes to sleep, and another always-running task keeps kicking an ILB to decay that blocked load) and the time saved by skipping CPUs is in the ballpark of 20%. Notebook is at [1].

Even if saving time in the ILB is interesting, we have to check the
impact of bitmask operation on the wake up latency of the CPUs when
the system is heavily used and generate a lot of sleep/wakeup on CPUs


>
> I'll try to get a proper function profiling working for when Vincent posts his "v2".
>
> [1]: https://gist.github.com/valschneider/6f203143bee1e149f24c44e9582a9eff
>
> ---
