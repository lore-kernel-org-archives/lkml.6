Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752565AbeDIHeZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 03:34:25 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:43167 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751792AbeDIHeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 03:34:22 -0400
X-Google-Smtp-Source: AIpwx4+FjAbEfumNrM9NlqtWL9wi8L/8HbuI9gUs12zTIZIbzKr9s6rE6jYc9K7goy7bNaAhFKapaCErfYv5WjlzilQ=
MIME-Version: 1.0
In-Reply-To: <20180406125825.GT4589@e105550-lin.cambridge.arm.com>
References: <1522223215-23524-1-git-send-email-vincent.guittot@linaro.org>
 <20180329125324.GR4589@e105550-lin.cambridge.arm.com> <CAKfTPtD4skW_3SAk--vBEC5-m1Ua48bjOQYS0pDqW3nPSpsENg@mail.gmail.com>
 <74865492-d9a6-649d-d37c-a5a6a8c28f23@arm.com> <CAKfTPtDy2uUj4amA9MARUz9qS=+urwV2edyQn+fW70hkN+CgoQ@mail.gmail.com>
 <e8e6e7d0-7744-1dab-7b24-b7ff37df60c8@arm.com> <CAKfTPtCQayuu5-84931ZxzXV1-roV_CfRd_5wXG1oxOEUZmZgw@mail.gmail.com>
 <20180405154630.GS4589@e105550-lin.cambridge.arm.com> <CAKfTPtBv7BzAqZWTxU9HaCoNjQa2B8usk6dfO1qgofjGYG7S=w@mail.gmail.com>
 <20180406125825.GT4589@e105550-lin.cambridge.arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 9 Apr 2018 09:34:00 +0200
Message-ID: <CAKfTPtCfCZzuBgdYzWW_KcT34VTgj6utUF+Q5zSpre+Ky2r4eA@mail.gmail.com>
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

On 6 April 2018 at 14:58, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> On Thu, Apr 05, 2018 at 06:22:48PM +0200, Vincent Guittot wrote:
>> Hi Morten,
>>
>> On 5 April 2018 at 17:46, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
>> > On Wed, Apr 04, 2018 at 03:43:17PM +0200, Vincent Guittot wrote:
>> >> On 4 April 2018 at 12:44, Valentin Schneider <valentin.schneider@arm.com> wrote:

[snip]

>> >> > What I meant was that if the task composition changes, IOW we mix "small"
>> >> > tasks (e.g. periodic stuff) and "big" tasks (performance-sensitive stuff like
>> >> > sysbench threads), we shouldn't assume all of those require to run on a big
>> >> > CPU. The thing is, ASYM_PACKING can't make the difference between those, so
>> >>
>> >> That's the 1st point where I tend to disagree: why big cores are only
>> >> for long running task and periodic stuff can't need to run on big
>> >> cores to get max compute capacity ?
>> >> You make the assumption that only long running tasks need high compute
>> >> capacity. This patch wants to always provide max compute capacity to
>> >> the system and not only long running task
>> >
>> > There is no way we can tell if a periodic or short-running tasks
>> > requires the compute capacity of a big core or not based on utilization
>> > alone. The utilization can only tell us if a task could potentially use
>> > more compute capacity, i.e. the utilization approaches the compute
>> > capacity of its current cpu.
>> >
>> > How we handle low utilization tasks comes down to how we define
>> > "performance" and if we care about the cost of "performance" (e.g.
>> > energy consumption).
>> >
>> > Placing a low utilization task on a little cpu should always be fine
>> > from _throughput_ point of view. As long as the cpu has spare cycles it
>>
>> I disagree, throughput is not only a matter of spare cycle it's also a
>> matter of how fast you compute the work like with IO activity as an
>> example
>
> From a cpu centric point of view it is, but I agree that from a
> application/user point of view completion time might impact throughput
> too. For example of if your throughput depends on how fast you can
> offload work to some peripheral device (GPU for example).
>
> However, as I said in the beginning we don't know what the task does.

I agree but that's not what you do with misfit as you assume long
running task has higher priority but not shorter running tasks

>
>> > means that work isn't piling up faster than it can be processed.
>> > However, from a _latency_ (completion time) point of view it might be a
>> > problem, and for latency sensitive tasks I can agree that going for max
>> > capacity might be better choice.
>> >
>> > The misfit patches places tasks based on utilization to ensure that
>> > tasks get the _throughput_ they need if possible. This is in line with
>> > the placement policy we have in select_task_rq_fair() already.
>> >
>> > We shouldn't forget that what we are discussing here is the default
>> > behaviour when we don't have sufficient knowledge about the tasks in the
>> > scheduler. So we are looking a reasonable middle-of-the-road policy that
>> > doesn't kill your performance or the battery. If user-space has its own
>>
>> But misfit task kills performance and might also kills your battery as
>> it doesn't prevent small task to run on big cores
>
> As I said it is not perfect for all use-cases, it is middle-of-the-road
> approach. But I strongly disagree that it is always a bad choice for

mmh ... I never said that it's always a bad choice; I said that it can
also easily make bad choice and kills performance and / or battery. In
fact, we can't really predict the behavior of the system as short
running tasks can be randomly put on big or little cores and random
behavior are impossible to predict and mitigate.

> both energy and performance as you suggest. ASYM_PACKING doesn't
> guarantee max "throughput" (by your definition) either as you may fill
> up your big cores with smaller tasks leaving the big tasks behind on
> little cpus.

You didn't understand the point here. Asym ensures the max throughput
to the system because it will provide the max compute capacity per
seconds to the whole system and not only to some specific tasks. You
assume that long running tasks must run on big cores and not short
running tasks. But why filling a big core with long running task and
filling a little core with short running tasks is the best choice ?
Why the opposite should not be better as long as the big core is fully
used ? The goal is to keep big CPU used whatever the type of tasks.
then, there are other mechanism like cgroup to help sorting groups of
tasks.

You try to partially do 2 things at the same time

>
>> The default behavior of the scheduler is to provide max _throughput_
>> not middle performance and then side activity can mitigate the power
>> impact like frequency scaling or like EAS which tries to optimize the
>> usage of energy when system is not overloaded.
>
> That view doesn't fit very well with all activities around integrating
> cpufreq and the scheduler. Frequency scaling is an important factor in
> optimizing the throughput.
>

Here you didn't catch my point too. Pleas don't give me intention that
I don't have.
By side activity, I'm not saying that it should not consolidate the
cpufreq and other framework decisions. Scheduler is the best place to
consolidate CPU related decision. I'm just saying that it's an
additional action taken to optimize energy.
The scheduler doesn't use current frequency in task placement and load
balancing as it assumes that max throughput is available if needed and
adjust frequency to current needs

>
>> With misfit task, you
>> make the assumption that short task on little core is the best
>> placement to do even for a performance PoV.
>
> I never said it was the best placement, I said it was a reasonable
> default policy for big.LITTLE systems.

But "The primary job for the task scheduler is to deliver the highest
possible throughput with minimal latency."

>
>> It seems that you make
>> some power/performance assumption without using an energy model which
>> can make such decision. This is all the interest of EAS.
>
> I'm trying to see the bigger picture where you seem not to. The

Thanks for helping me to get the bigger picture ;-)

> ASYM_PACKING solution is incompatible with EAS. CFS has a cpu centric
> view and the default policy I'm suggesting doesn't violate that view.

Sorry I don't catch the sentences above

> Your own code in group_is_overloaded() follows this view as it is
> utilization based and happily accepts partially utilized groups as being

But this is done for SMP system where all cores have same capacity and
to detect when tasks can get more throughput on another CPU.
ASYM_PACKING is there to add capacity awareness in the load balance
when CPUs have different capacity

> fine without need to be offloaded despite you could have multiple tasks
> waiting to execute.
> CFS doesn't not provide any latency guarantees, but
> we of course do the best we can within reason to minimize it.
>
> Seen in the bigger picture I would consider going for max capacity for
> big.LITTLE systems more aggressive than using the performance cpufreq
> govenor. Nobody does the latter for battery powered devices, hence I
> don't see why anyone would to go big-always for big.LITTLE systems.

And that's why EAS exists: to make battery friendly decision

>
>>
>> > opinion about performance requirements it is free to use task affinity
>> > to control which cpu the task end up on and ensure that the task gets
>> > max capacity always. On top of that we have had interfaces in Android
>> > for years to specify performance requirements for task (groups) to allow
>> > small tasks to be placed on big cpus and big task to be placed on little
>> > cpus depending on their requirements. It is even tied into cpufreq as
>> > well. A lot of effort has gone into Android to get this balance right.
>> > Patrick is working hard on upstreaming some of those features.
>> >
>> > In the bigger picture always going for max capacity is not desirable for
>> > well-configured big.LITTLE system. You would never exploit the advantage
>> > of the little cpus as you always use big first and only use little when
>> > the bigs are overloaded at which point having little cpus at all makes
>>
>> If i'm not wrong misfit task patchset doesn't prevent little task to
>> run on big core
>
> It does not, in fact it doesn't touch small tasks at all, that is not
> the point of the patch set. The point is to make sure that big tasks
> don't get stuck on little cpus. IOW, a selective little to big
> migration based on task utilization.
>
>>
>> > little sense. Vendors build big.LITTLE systems because they want a
>> > better performance/energy trade-off, if they wanted max capacity always,
>> > they would just built big-only systems.
>>
>> And that's all the purpose of the EAS patchset. EAS patchset is there
>> to put some energy awareness in the scheduler decision. There is 2
>> running mode for EAS: one when there is spare cycles so tasks can be
>> placed to optimize energy consumption. And one when the system or part
>> of the system is overloaded and it goes back to default performance
>> mode because there is no interest for energy efficiency and we just
>> want to provide max performance. So the asym packing fits with this
>> latter mode as it provide the max compute capacity to the default mode
>> and doesn't break EAS as it uses the load balance which is disable by
>> EAS in not overloaded mode
>
> We still care about energy even when we are overutilized. We really
> don't want a vastly different placement policy depending on whether we
> are overutilized or not if we can avoid it as the situation changes
> frequently in many real world scenarios. With ASYM_PACKING everything
> could suddenly shift to big cpus if a little cpu is suddenly
> overutilized. With the misfit patches, we would detect exactly which

Not everything. The same happens with ASYM_PACKING. It doesn't blindly
put everything on "big" cores and do use parallelism too.

Regards,
Vincent

> little cpu that needs help, migrate the misfit task and everything will
> return to non-overutilized. That is why I said that ASYM_PACKING is
> incompatible with energy-aware scheduling and we would need the misfit
> patches anyway.
>
> Morten
