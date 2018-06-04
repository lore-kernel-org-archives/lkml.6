Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751254AbeFDRNs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 13:13:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46060 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751103AbeFDRNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 13:13:47 -0400
Date: Mon, 4 Jun 2018 18:13:40 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        viresh.kumar@linaro.org, valentin.schneider@arm.com
Subject: Re: [PATCH v5 00/10] track CPU utilization
Message-ID: <20180604171339.GA25372@e108498-lin.cambridge.arm.com>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <20180604165047.GU12180@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604165047.GU12180@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 Jun 2018 at 18:50:47 (+0200), Peter Zijlstra wrote:
> On Fri, May 25, 2018 at 03:12:21PM +0200, Vincent Guittot wrote:
> > When both cfs and rt tasks compete to run on a CPU, we can see some frequency
> > drops with schedutil governor. In such case, the cfs_rq's utilization doesn't
> > reflect anymore the utilization of cfs tasks but only the remaining part that
> > is not used by rt tasks. We should monitor the stolen utilization and take
> > it into account when selecting OPP. This patchset doesn't change the OPP
> > selection policy for RT tasks but only for CFS tasks
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
> 
> Your solution is to track RT/DL/stop/IRQ with the identical PELT average
> as we track cfs util. Such that we can then add the various averages to
> reconstruct the actual utilisation signal.
> 
> This should work for the case of the utilization signal on UP. When we
> consider that PELT migrates the signal around on SMP, but we don't do
> that to the per-rq signals we have for RT/DL/stop/IRQ.
> 
> There is also the 'complaint' that this ends up with 2 util signals for
> DL, complicating things.
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

Isn't it equivalent ? I mean, you can remove RT/DL/stop/IRQ from the CPU
capacity and compare the CFS util_avg against that, or you can add
RT/DL/stop/IRQ to the CFS util_avg and compare it to arch_scale_cpu_capacity().
Both should be interchangeable no ? By adding RT/DL/IRQ PELT signals
to the CFS util_avg, Vincent is proposing to go with the latter I think.

But aren't the signals we currently use to account for RT/DL/stop/IRQ in
cpu_capacity good enough for that ? Can't we just add the diff between
capacity_orig_of and capacity_of to the CFS util and do OPP selection with
that (for !nr_rt_running) ? Maybe add a min with dl running_bw to be on
the safe side ... ?

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
> 	scale_cpu_capacity / (rt_frac^2)
> 
> for load, then we inflate the load and could maybe get rid of all this
> capacity_of() sprinkling, but that needs more thinking.
> 
> 
> But I really feel we need to consider both util and load, as this issue
> affects both.
