Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751366AbeFDSJV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:09:21 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55683 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbeFDSJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:09:20 -0400
X-Google-Smtp-Source: ADUXVKK48ztjyvLhiiPguECc9f4Weh4fFOfwPy4PX948bm/Vw4nwEzLsHdD/437FqMSCZCk0atfUdZTCaCa+16rTbH4=
MIME-Version: 1.0
In-Reply-To: <20180604165047.GU12180@hirez.programming.kicks-ass.net>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org> <20180604165047.GU12180@hirez.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 4 Jun 2018 20:08:58 +0200
Message-ID: <CAKfTPtDtx72OgxvA3vxnRiCW_UG24HSJ3oE_8j5Rx3-vP0gCeA@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] track CPU utilization
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 June 2018 at 18:50, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, May 25, 2018 at 03:12:21PM +0200, Vincent Guittot wrote:
>> When both cfs and rt tasks compete to run on a CPU, we can see some frequency
>> drops with schedutil governor. In such case, the cfs_rq's utilization doesn't
>> reflect anymore the utilization of cfs tasks but only the remaining part that
>> is not used by rt tasks. We should monitor the stolen utilization and take
>> it into account when selecting OPP. This patchset doesn't change the OPP
>> selection policy for RT tasks but only for CFS tasks
>
> So the problem is that when RT/DL/stop/IRQ happens and preempts CFS
> tasks, time continues and the CFS load tracking will see !running and
> decay things.
>
> Then, when we get back to CFS, we'll have lower load/util than we
> expected.
>
> In particular, your focus is on OPP selection, and where we would have
> say: u=1 (always running task), after being preempted by our RT task for
> a while, it will now have u=.5. With the effect that when the RT task
> goes sleep we'll drop our OPP to .5 max -- which is 'wrong', right?

yes that's the typical example

>
> Your solution is to track RT/DL/stop/IRQ with the identical PELT average
> as we track cfs util. Such that we can then add the various averages to
> reconstruct the actual utilisation signal.

yes and get the whole cpu utilization

>
> This should work for the case of the utilization signal on UP. When we
> consider that PELT migrates the signal around on SMP, but we don't do
> that to the per-rq signals we have for RT/DL/stop/IRQ.
>
> There is also the 'complaint' that this ends up with 2 util signals for
> DL, complicating things.

yes. that's the main point of discussion how to balance dl bandwidth
and dl utilization

>
>
> So this patch-set tracks the !cfs occupation using the same function,
> which is all good. But what, if instead of using that to compensate the
> OPP selection, we employ that to renormalize the util signal?
>
> If we normalize util against the dynamic (rt_avg affected) cpu_capacity,
> then I think your initial problem goes away. Because while the RT task
> will push the util to .5, it will at the same time push the CPU capacity
> to .5, and renormalized that gives 1.
>
>   NOTE: the renorm would then become something like:
>         scale_cpu = arch_scale_cpu_capacity() / rt_frac();
>
>
> On IRC I mentioned stopping the CFS clock when preempted, and while that
> would result in fixed numbers, Vincent was right in pointing out the
> numbers will be difficult to interpret, since the meaning will be purely
> CPU local and I'm not sure you can actually fix it again with
> normalization.
>
> Imagine, running a .3 RT task, that would push the (always running) CFS
> down to .7, but because we discard all !cfs time, it actually has 1. If
> we try and normalize that we'll end up with ~1.43, which is of course
> completely broken.
>
>
> _However_, all that happens for util, also happens for load. So the above
> scenario will also make the CPU appear less loaded than it actually is.

The load will continue to increase because we track runnable state and
not running for the load

>
> Now, we actually try and compensate for that by decreasing the capacity
> of the CPU. But because the existing rt_avg and PELT signals are so
> out-of-tune, this is likely to be less than ideal. With that fixed
> however, the best this appears to do is, as per the above, preserve the
> actual load. But what we really wanted is to actually inflate the load,
> such that someone will take load from us -- we're doing less actual work
> after all.
>
> Possibly, we can do something like:
>
>         scale_cpu_capacity / (rt_frac^2)
>
> for load, then we inflate the load and could maybe get rid of all this
> capacity_of() sprinkling, but that needs more thinking.
>
>
> But I really feel we need to consider both util and load, as this issue
> affects both.

my initial idea was to get max between dl bandwidth and dl util_avg
but util_avg can be higher than bandwidth and using it will make
sched_util selecting higher OPP for now good reason if nothing is
running around and need compute capacity

As you mentioned, scale_rt_capacity give the remaining capacity for
cfs and it will behave like cfs util_avg now that it uses PELT. So as
long as cfs util_avg <  scale_rt_capacity(we probably need a margin)
we keep using dl bandwidth + cfs util_avg + rt util_avg for selecting
OPP because we have remaining spare capacity but if  cfs util_avg ==
scale_rt_capacity, we make sure to use max OPP.

I will run some test to make sure that all my test are running
correctly which such policy
