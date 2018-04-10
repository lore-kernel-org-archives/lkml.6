Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753101AbeDJNT4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:19:56 -0400
Received: from foss.arm.com ([217.140.101.70]:38084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752690AbeDJNTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:19:54 -0400
Date: Tue, 10 Apr 2018 14:19:50 +0100
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Chris Redpath <chris.redpath@arm.com>
Subject: Re: [PATCH] sched: support dynamiQ cluster
Message-ID: <20180410131950.GU4589@e105550-lin.cambridge.arm.com>
References: <20180329125324.GR4589@e105550-lin.cambridge.arm.com>
 <CAKfTPtD4skW_3SAk--vBEC5-m1Ua48bjOQYS0pDqW3nPSpsENg@mail.gmail.com>
 <74865492-d9a6-649d-d37c-a5a6a8c28f23@arm.com>
 <CAKfTPtDy2uUj4amA9MARUz9qS=+urwV2edyQn+fW70hkN+CgoQ@mail.gmail.com>
 <e8e6e7d0-7744-1dab-7b24-b7ff37df60c8@arm.com>
 <CAKfTPtCQayuu5-84931ZxzXV1-roV_CfRd_5wXG1oxOEUZmZgw@mail.gmail.com>
 <20180405154630.GS4589@e105550-lin.cambridge.arm.com>
 <CAKfTPtBv7BzAqZWTxU9HaCoNjQa2B8usk6dfO1qgofjGYG7S=w@mail.gmail.com>
 <20180406125825.GT4589@e105550-lin.cambridge.arm.com>
 <CAKfTPtCfCZzuBgdYzWW_KcT34VTgj6utUF+Q5zSpre+Ky2r4eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCfCZzuBgdYzWW_KcT34VTgj6utUF+Q5zSpre+Ky2r4eA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 09:34:00AM +0200, Vincent Guittot wrote:
> Hi Morten,
> 
> On 6 April 2018 at 14:58, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> > On Thu, Apr 05, 2018 at 06:22:48PM +0200, Vincent Guittot wrote:
> >> Hi Morten,
> >>
> >> On 5 April 2018 at 17:46, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> >> > On Wed, Apr 04, 2018 at 03:43:17PM +0200, Vincent Guittot wrote:
> >> >> On 4 April 2018 at 12:44, Valentin Schneider <valentin.schneider@arm.com> wrote:
> 
> [snip]
> 
> >> >> > What I meant was that if the task composition changes, IOW we mix "small"
> >> >> > tasks (e.g. periodic stuff) and "big" tasks (performance-sensitive stuff like
> >> >> > sysbench threads), we shouldn't assume all of those require to run on a big
> >> >> > CPU. The thing is, ASYM_PACKING can't make the difference between those, so
> >> >>
> >> >> That's the 1st point where I tend to disagree: why big cores are only
> >> >> for long running task and periodic stuff can't need to run on big
> >> >> cores to get max compute capacity ?
> >> >> You make the assumption that only long running tasks need high compute
> >> >> capacity. This patch wants to always provide max compute capacity to
> >> >> the system and not only long running task
> >> >
> >> > There is no way we can tell if a periodic or short-running tasks
> >> > requires the compute capacity of a big core or not based on utilization
> >> > alone. The utilization can only tell us if a task could potentially use
> >> > more compute capacity, i.e. the utilization approaches the compute
> >> > capacity of its current cpu.
> >> >
> >> > How we handle low utilization tasks comes down to how we define
> >> > "performance" and if we care about the cost of "performance" (e.g.
> >> > energy consumption).
> >> >
> >> > Placing a low utilization task on a little cpu should always be fine
> >> > from _throughput_ point of view. As long as the cpu has spare cycles it
> >>
> >> I disagree, throughput is not only a matter of spare cycle it's also a
> >> matter of how fast you compute the work like with IO activity as an
> >> example
> >
> > From a cpu centric point of view it is, but I agree that from a
> > application/user point of view completion time might impact throughput
> > too. For example of if your throughput depends on how fast you can
> > offload work to some peripheral device (GPU for example).
> >
> > However, as I said in the beginning we don't know what the task does.
> 
> I agree but that's not what you do with misfit as you assume long
> running task has higher priority but not shorter running tasks

Not really, as I said in the previous replies it comes down what you see
as the goal of the CFS scheduler. With the misfit patches I'm just
trying to make sure that no task is overutilizing a cpu unnecessarily as
this is in line with what load-balancing does for SMP systems. Compute
capacity is distributed as evenly as possible based on utilization just
like it is for load-balancing when task priorities are the same. From
that point of view the misfit patches don't give long running tasks
preferential treatment. However, I do agree that from a completion time
point of view, low utilization tasks could suffer unnecessarily in some
scenarios.

I don't see optimizing for completion time of low utilization tasks as a
primary goal of CFS. Wake-up balancing does try to minimize wake-up
latency, but that is about it. Fork and exec balancing and the
load-balancing code is all based on load and utilization.

Even if we wanted to optimize for completion time it is more tricky for
asymmetric cpu capacity systems than it is for SMP. Just keeping the big
cpus busy all the time isn't going to do it for many scenarios.

Firstly, migrating running tasks is quite expensive so force-migrating a
short-running task could end up taking longer time than letting it
complete on a little cpu.

Secondly, by keeping big cpus busy at all cost you risk that longer
running tasks will either end up queueing on the big cpus if you choose
to enqueue them there anyway, or they could end up running on a little
cpu if you go for the first available cpu in which case you end up
harming the completion time of that task instead.  I'm not sure how you
balance which task's completion time is more important differently than
we do today based on load or utilization. The misfit patches use the
latter. We could let it use load instead although I think we have agreed
in the past the comparing load to capacity isn't great idea.

Finally, keeping big cpus busy will increase the number of active
migrations a lot.

As said above, I see your point about completion time might suffer in
some cases for low utilization tasks, but I don't see how you can fix
that automagically. ASYM_PACKING has a lot of problematic side-effects.
If use-space knows that completion time is important for a task, there
are already ways to improve that somewhat in mainline (task priority and
pinning), and more powerful solutions in the Android kernel which
Patrick is currently pushing upstream.

> 
> >
> >> > means that work isn't piling up faster than it can be processed.
> >> > However, from a _latency_ (completion time) point of view it might be a
> >> > problem, and for latency sensitive tasks I can agree that going for max
> >> > capacity might be better choice.
> >> >
> >> > The misfit patches places tasks based on utilization to ensure that
> >> > tasks get the _throughput_ they need if possible. This is in line with
> >> > the placement policy we have in select_task_rq_fair() already.
> >> >
> >> > We shouldn't forget that what we are discussing here is the default
> >> > behaviour when we don't have sufficient knowledge about the tasks in the
> >> > scheduler. So we are looking a reasonable middle-of-the-road policy that
> >> > doesn't kill your performance or the battery. If user-space has its own
> >>
> >> But misfit task kills performance and might also kills your battery as
> >> it doesn't prevent small task to run on big cores
> >
> > As I said it is not perfect for all use-cases, it is middle-of-the-road
> > approach. But I strongly disagree that it is always a bad choice for
> 
> mmh ... I never said that it's always a bad choice; I said that it can
> also easily make bad choice and kills performance and / or battery.

You did say "But misfit task kills performance and might...", but never
mind, thanks for clarifying your statement.

> In
> fact, we can't really predict the behavior of the system as short
> running tasks can be randomly put on big or little cores and random
> behavior are impossible to predict and mitigate.

You can't predict the behaviour of the system either if you use
ASYM_PACKING. The short running tasks may or may not be lucky to wake up
when there is a big cpu idle. Performance is a best-effort thing on most
modern systems. ASYM_PACKING might increase the probability that a short
running task ends up on a big cpu, but at the same time it might harm
predictability of completion time of long running tasks.

> > both energy and performance as you suggest. ASYM_PACKING doesn't
> > guarantee max "throughput" (by your definition) either as you may fill
> > up your big cores with smaller tasks leaving the big tasks behind on
> > little cpus.
> 
> You didn't understand the point here. Asym ensures the max throughput
> to the system because it will provide the max compute capacity per
> seconds to the whole system and not only to some specific tasks. You
> assume that long running tasks must run on big cores and not short
> running tasks. But why filling a big core with long running task and
> filling a little core with short running tasks is the best choice ?

I'm fairly sure I understand your point. From a theoretical point of
view, if migrations were free and we had no caches, always keeping the
big cpus busy before using the little cpus would get us most throughput.
I don't disagree with that. The issue here is that migrations aren't
free, we do have caches, the CFS scheduler isn't designed to work that
way, and for many real world use-cases on big.LITTLE systems people
don't want to maximize global throughput, they want to maximize
throughput of the important tasks at the expense of everyone else
running slower even if they don't care about energy.

I'm not saying that scheduling short running tasks on little cpus is
always the best choice, but it seems to be a good compromise and it is
in line with the existing load-balancing policy. So I see it as the
least invasive solution to improve things for asymmetric cpu capacity
systems.

> Why the opposite should not be better as long as the big core is fully
> used ? The goal is to keep big CPU used whatever the type of tasks.
> then, there are other mechanism like cgroup to help sorting groups of
> tasks.

Because of all the side-effects I mentioned further up. If your goal is
to keep the big cpus always busy, why not change the wake-up code to
always prefer them instead of trying to catch them later? That seems a
much more reasonable approach since you would migrate short running
tasks at wake-up which is much cheaper and would only require simple
tweaks to the existing capacity-aware wake-up code. Short running tasks
will always be handled there, so we only need to worry about long
running tasks that would be handled by the misfit patches. My worry with
doing that is that big tasks might suffer from additional migrations and
that the policy is too aggressive for users that care about energy, so
it would have to be disabled as soon as an energy model is in use.

> You try to partially do 2 things at the same time

I'm trying to make all the effort in scheduling and OSPM come together
while looking at what users need.

> 
> >
> >> The default behavior of the scheduler is to provide max _throughput_
> >> not middle performance and then side activity can mitigate the power
> >> impact like frequency scaling or like EAS which tries to optimize the
> >> usage of energy when system is not overloaded.
> >
> > That view doesn't fit very well with all activities around integrating
> > cpufreq and the scheduler. Frequency scaling is an important factor in
> > optimizing the throughput.
> >
> 
> Here you didn't catch my point too. Pleas don't give me intention that
> I don't have.
> By side activity, I'm not saying that it should not consolidate the
> cpufreq and other framework decisions. Scheduler is the best place to
> consolidate CPU related decision. I'm just saying that it's an
> additional action taken to optimize energy.
> The scheduler doesn't use current frequency in task placement and load
> balancing as it assumes that max throughput is available if needed and
> adjust frequency to current needsA

That is the whole problem with mainline scheduling and OSPM that we have
been working on addressing for several years now. Energy-aware
scheduling does exactly that, it considers current frequency as part of
task placement and we actively ask for a suitable frequency based on a
mix of PELT utilization and use-space hints. All this goodness has
already been in the Android kernel for years.

Hence my point above was to say that viewing frequency selection as a
"side activity" doesn't fit with what is being proposed for energy-aware
scheduling.

> 
> >
> >> With misfit task, you
> >> make the assumption that short task on little core is the best
> >> placement to do even for a performance PoV.
> >
> > I never said it was the best placement, I said it was a reasonable
> > default policy for big.LITTLE systems.
> 
> But "The primary job for the task scheduler is to deliver the highest
> possible throughput with minimal latency."

I'm not sure where that quote is coming from, but I think I have already
covered to great extent above why optimizing for aggressively for
keeping the big cpus busy on asymmetric cpu capacity systems isn't
necessarily the best choice. At least, if we this is what we truly want
ASYM_PACKING is not a good implementation of this policy.

> 
> >
> >> It seems that you make
> >> some power/performance assumption without using an energy model which
> >> can make such decision. This is all the interest of EAS.
> >
> > I'm trying to see the bigger picture where you seem not to. The
> 
> Thanks for helping me to get the bigger picture ;-)
> 
> > ASYM_PACKING solution is incompatible with EAS. CFS has a cpu centric
> > view and the default policy I'm suggesting doesn't violate that view.
> 
> Sorry I don't catch the sentences above

My point is that ASYM_PACKING conflicts with EAS while the misfit
patches work well with EAS and the resulting behaviour is in line with
load-balancing as I already covered above.

> 
> > Your own code in group_is_overloaded() follows this view as it is
> > utilization based and happily accepts partially utilized groups as being
> 
> But this is done for SMP system where all cores have same capacity and
> to detect when tasks can get more throughput on another CPU.

But you don't detect scenarios where you could improve completion time.
This is where this discussion started :-)

> ASYM_PACKING is there to add capacity awareness in the load balance
> when CPUs have different capacity

Well, one fundamental difference between asymmetric cpu capacity systems
(big.LITTLE) and the existing users of ASYM_PACKING is that the existing
users of ASYM_PACKING don't have any downsides of using that feature. As
in, the n+1th task to be packed doesn't get punished in terms of
performance just because it woke up later than the other tasks. It is
just placing tasks to improve the chances of an opportunistic
performance boost. This is not the case for asymmetric cpu capacity
systems. Using ASYM_PACKING here would mean that late wakers gets
punished while early risers gets treated with better throughput until
they choose to stop or it gets preempted because there are more tasks
than cpus.

Is it fair to favor the first tasks to wake? I think providing true fairness,
particularly on asymmetric cpu capacity systems, can only be achieved by
using a rotating scheduler, where each task take turns on running on the
fastest cpu ;-)

> 
> > fine without need to be offloaded despite you could have multiple tasks
> > waiting to execute.
> > CFS doesn't not provide any latency guarantees, but
> > we of course do the best we can within reason to minimize it.
> >
> > Seen in the bigger picture I would consider going for max capacity for
> > big.LITTLE systems more aggressive than using the performance cpufreq
> > govenor. Nobody does the latter for battery powered devices, hence I
> > don't see why anyone would to go big-always for big.LITTLE systems.
> 
> And that's why EAS exists: to make battery friendly decision

True, I'm just wondering if we should spend effort supporting a use-case
which might only be of theoretical interest instead of focusing on the
problems that a lot of users care about.

> >> > opinion about performance requirements it is free to use task affinity
> >> > to control which cpu the task end up on and ensure that the task gets
> >> > max capacity always. On top of that we have had interfaces in Android
> >> > for years to specify performance requirements for task (groups) to allow
> >> > small tasks to be placed on big cpus and big task to be placed on little
> >> > cpus depending on their requirements. It is even tied into cpufreq as
> >> > well. A lot of effort has gone into Android to get this balance right.
> >> > Patrick is working hard on upstreaming some of those features.
> >> >
> >> > In the bigger picture always going for max capacity is not desirable for
> >> > well-configured big.LITTLE system. You would never exploit the advantage
> >> > of the little cpus as you always use big first and only use little when
> >> > the bigs are overloaded at which point having little cpus at all makes
> >>
> >> If i'm not wrong misfit task patchset doesn't prevent little task to
> >> run on big core
> >
> > It does not, in fact it doesn't touch small tasks at all, that is not
> > the point of the patch set. The point is to make sure that big tasks
> > don't get stuck on little cpus. IOW, a selective little to big
> > migration based on task utilization.
> >
> >>
> >> > little sense. Vendors build big.LITTLE systems because they want a
> >> > better performance/energy trade-off, if they wanted max capacity always,
> >> > they would just built big-only systems.
> >>
> >> And that's all the purpose of the EAS patchset. EAS patchset is there
> >> to put some energy awareness in the scheduler decision. There is 2
> >> running mode for EAS: one when there is spare cycles so tasks can be
> >> placed to optimize energy consumption. And one when the system or part
> >> of the system is overloaded and it goes back to default performance
> >> mode because there is no interest for energy efficiency and we just
> >> want to provide max performance. So the asym packing fits with this
> >> latter mode as it provide the max compute capacity to the default mode
> >> and doesn't break EAS as it uses the load balance which is disable by
> >> EAS in not overloaded mode
> >
> > We still care about energy even when we are overutilized. We really
> > don't want a vastly different placement policy depending on whether we
> > are overutilized or not if we can avoid it as the situation changes
> > frequently in many real world scenarios. With ASYM_PACKING everything
> > could suddenly shift to big cpus if a little cpu is suddenly
> > overutilized. With the misfit patches, we would detect exactly which
> 
> Not everything. The same happens with ASYM_PACKING. It doesn't blindly
> put everything on "big" cores and do use parallelism too.

I fail to understand your point here. ASYM_PACKING doesn't put multiple
tasks on the same cpu, but it does fill all the big cpus even if all we
really need is to migrate a single big task.

Morten
