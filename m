Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751494AbeDEQXK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 12:23:10 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:53864 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeDEQXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 12:23:09 -0400
X-Google-Smtp-Source: AIpwx49cco5jFyPajVFZEkdBGe+eNcAXTq4DLqvnh5aHfaCbxzg1HGDvvAZ89Rxrhoxnrc3Dmab8lG/qfD8CbsskJa0=
MIME-Version: 1.0
In-Reply-To: <20180405154630.GS4589@e105550-lin.cambridge.arm.com>
References: <1522223215-23524-1-git-send-email-vincent.guittot@linaro.org>
 <20180329125324.GR4589@e105550-lin.cambridge.arm.com> <CAKfTPtD4skW_3SAk--vBEC5-m1Ua48bjOQYS0pDqW3nPSpsENg@mail.gmail.com>
 <74865492-d9a6-649d-d37c-a5a6a8c28f23@arm.com> <CAKfTPtDy2uUj4amA9MARUz9qS=+urwV2edyQn+fW70hkN+CgoQ@mail.gmail.com>
 <e8e6e7d0-7744-1dab-7b24-b7ff37df60c8@arm.com> <CAKfTPtCQayuu5-84931ZxzXV1-roV_CfRd_5wXG1oxOEUZmZgw@mail.gmail.com>
 <20180405154630.GS4589@e105550-lin.cambridge.arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 5 Apr 2018 18:22:48 +0200
Message-ID: <CAKfTPtBv7BzAqZWTxU9HaCoNjQa2B8usk6dfO1qgofjGYG7S=w@mail.gmail.com>
Subject: Re: [PATCH] sched: support dynamiQ cluster
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Chris Redpath <chris.redpath@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morten,

On 5 April 2018 at 17:46, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> On Wed, Apr 04, 2018 at 03:43:17PM +0200, Vincent Guittot wrote:
>> On 4 April 2018 at 12:44, Valentin Schneider <valentin.schneider@arm.com> wrote:
>> > Hi,
>> >
>> > On 03/04/18 13:17, Vincent Guittot wrote:
>> >> Hi Valentin,
>> >>
>> > [...]
>> >>>
>> >>> I believe ASYM_PACKING behaves better here because the workload is only
>> >>> sysbench threads. As stated above, since task utilization is disregarded, I
>> >>
>> >> It behaves better because it doesn't wait for the task's utilization
>> >> to reach a level before assuming the task needs high compute capacity.
>> >> The utilization gives an idea of the running time of the task not the
>> >> performance level that is needed
>> >>
>> >
>> > That's my point actually. ASYM_PACKING disregards utilization and moves those
>> > threads to the big cores ASAP, which is good here because it's just sysbench
>> > threads.
>> >
>> > What I meant was that if the task composition changes, IOW we mix "small"
>> > tasks (e.g. periodic stuff) and "big" tasks (performance-sensitive stuff like
>> > sysbench threads), we shouldn't assume all of those require to run on a big
>> > CPU. The thing is, ASYM_PACKING can't make the difference between those, so
>>
>> That's the 1st point where I tend to disagree: why big cores are only
>> for long running task and periodic stuff can't need to run on big
>> cores to get max compute capacity ?
>> You make the assumption that only long running tasks need high compute
>> capacity. This patch wants to always provide max compute capacity to
>> the system and not only long running task
>
> There is no way we can tell if a periodic or short-running tasks
> requires the compute capacity of a big core or not based on utilization
> alone. The utilization can only tell us if a task could potentially use
> more compute capacity, i.e. the utilization approaches the compute
> capacity of its current cpu.
>
> How we handle low utilization tasks comes down to how we define
> "performance" and if we care about the cost of "performance" (e.g.
> energy consumption).
>
> Placing a low utilization task on a little cpu should always be fine
> from _throughput_ point of view. As long as the cpu has spare cycles it

I disagree, throughput is not only a matter of spare cycle it's also a
matter of how fast you compute the work like with IO activity as an
example

> means that work isn't piling up faster than it can be processed.
> However, from a _latency_ (completion time) point of view it might be a
> problem, and for latency sensitive tasks I can agree that going for max
> capacity might be better choice.
>
> The misfit patches places tasks based on utilization to ensure that
> tasks get the _throughput_ they need if possible. This is in line with
> the placement policy we have in select_task_rq_fair() already.
>
> We shouldn't forget that what we are discussing here is the default
> behaviour when we don't have sufficient knowledge about the tasks in the
> scheduler. So we are looking a reasonable middle-of-the-road policy that
> doesn't kill your performance or the battery. If user-space has its own

But misfit task kills performance and might also kills your battery as
it doesn't prevent small task to run on big cores
The default behavior of the scheduler is to provide max _throughput_
not middle performance and then side activity can mitigate the power
impact like frequency scaling or like EAS which tries to optimize the
usage of energy when system is not overloaded. With misfit task, you
make the assumption that short task on little core is the best
placement to do even for a performance PoV. It seems that you make
some power/performance assumption without using an energy model which
can make such decision. This is all the interest of EAS.

> opinion about performance requirements it is free to use task affinity
> to control which cpu the task end up on and ensure that the task gets
> max capacity always. On top of that we have had interfaces in Android
> for years to specify performance requirements for task (groups) to allow
> small tasks to be placed on big cpus and big task to be placed on little
> cpus depending on their requirements. It is even tied into cpufreq as
> well. A lot of effort has gone into Android to get this balance right.
> Patrick is working hard on upstreaming some of those features.
>
> In the bigger picture always going for max capacity is not desirable for
> well-configured big.LITTLE system. You would never exploit the advantage
> of the little cpus as you always use big first and only use little when
> the bigs are overloaded at which point having little cpus at all makes

If i'm not wrong misfit task patchset doesn't prevent little task to
run on big core

> little sense. Vendors build big.LITTLE systems because they want a
> better performance/energy trade-off, if they wanted max capacity always,
> they would just built big-only systems.

And that's all the purpose of the EAS patchset. EAS patchset is there
to put some energy awareness in the scheduler decision. There is 2
running mode for EAS: one when there is spare cycles so tasks can be
placed to optimize energy consumption. And one when the system or part
of the system is overloaded and it goes back to default performance
mode because there is no interest for energy efficiency and we just
want to provide max performance. So the asym packing fits with this
latter mode as it provide the max compute capacity to the default mode
and doesn't break EAS as it uses the load balance which is disable by
EAS in not overloaded mode

Vincent
>
> If we would be that concerned about latency, DVFS would be a problem too
> and we would use nothing but the performance governor. So seen in the
> bigger picture I have to disagree that blindly going for max capacity is
> the right default policy for big.LITTLE. As soon as we involve a energy
> model in the task placement decisions, it definitely isn't.
>
> Morten
