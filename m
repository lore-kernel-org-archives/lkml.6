Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752468AbeDJRQT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 13:16:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40980 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751881AbeDJRQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 13:16:17 -0400
Date: Tue, 10 Apr 2018 18:16:12 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH 4/7] sched/core: uclamp: add utilization clamping to the
 CPU controller
Message-ID: <20180410171612.GJ14248@e110439-lin>
References: <20180409165615.2326-1-patrick.bellasi@arm.com>
 <20180409165615.2326-5-patrick.bellasi@arm.com>
 <20180409222417.GK3126663@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409222417.GK3126663@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On 09-Apr 15:24, Tejun Heo wrote:
> On Mon, Apr 09, 2018 at 05:56:12PM +0100, Patrick Bellasi wrote:
> > This patch extends the CPU controller by adding a couple of new attributes,
> > util_min and util_max, which can be used to enforce frequency boosting and
> > capping. Specifically:
> > 
> > - util_min: defines the minimum CPU utilization which should be considered,
> > 	    e.g. when  schedutil selects the frequency for a CPU while a
> > 	    task in this group is RUNNABLE.
> > 	    i.e. the task will run at least at a minimum frequency which
> > 	         corresponds to the min_util utilization
> > 
> > - util_max: defines the maximum CPU utilization which should be considered,
> > 	    e.g. when schedutil selects the frequency for a CPU while a
> > 	    task in this group is RUNNABLE.
> > 	    i.e. the task will run up to a maximum frequency which
> > 	         corresponds to the max_util utilization
> 
> I'm not too enthusiastic about util_min/max given that it can easily
> be read as actual utilization based bandwidth control when what's
> actually implemented, IIUC, is affecting CPU frequency selection.

Right now we are basically affecting the frequency selection.
However, the next step is to use this same interface to possibly bias
task placement.

The idea is that:

- the util_min value can be used to possibly avoid CPUs which have
  a (maybe temporarily) limited capacity, for example, due to thermal
  pressure.

- a util_max value can use used to possibly identify tasks which can
  be co-scheduled together in a (maybe) limited capacity CPU since
  they are more likely "less important" tasks.

Thus, since this is a new user-space API, we would like to find a
concept which is generic enough to express the current requirement but
also easily accommodate future extensions.

> Maybe something like cpu.freq.min/max are better names?

IMO this is something too much platform specific.

I agree that utilization is maybe too much an implementation detail,
but perhaps this can be solved by using a more generic range.

What about using values in the [0..100] range which define:

   a percentage of the maximum available capacity
         for the CPUs in the target system

Do you think this can work?

> > These attributes:
> > a) are tunable at all hierarchy levels, i.e. at root group level too, thus
> >    allowing to define the minimum and maximum frequency constraints for all
> >    otherwise non-classified tasks (e.g. autogroups) and to be a sort-of
> >    replacement for cpufreq's powersave, ondemand and performance
> >    governors.
> 
> This is a problem which exists for all other interfaces.  For
> historical and other reasons, at least till now, we've opted to put
> everything at system level outside of cgroup interface.  We might
> change this in the future and duplicate system-level information and
> interfaces in the root cgroup but we wanna do that in a more systemtic
> fashion than adding an one-off knob in the cgroup root.

I see, I think we can easily come up with a procfs/sysfs interface
usable to define system-wide values.

Any suggestion for something already existing which I can use as a
reference?

> Besides, if a feature makes sense at the system level which is the
> cgroup root, it makes sense without cgroup mounted or enabled, so it
> needs a place outside cgroup one way or the other.

Indeed, and it makes perfectly sense now that we have also a non
cgroup-based primary APU.

> > b) allow to create subgroups of tasks which are not violating the
> >    utilization constraints defined by the parent group.
> 
> Tying creation / config operations to the config propagation doesn't
> work well with delegation and is inconsistent with what other
> controllers are doing.  For cases where the propagated config being
> visible in a sub cgroup is necessary, please add .effective files.

I'm not sure to understand this point: you mean that we should not
enforce "consistency rules" among parent-child groups?

I have to look better into this "effective" concept.
Meanwhile, can you make a simple example?

> > Tasks on a subgroup can only be more boosted and/or capped, which is
> 
> Less boosted.  .low at a parent level must set the upper bound of .low
> that all its descendants can have.

Is that a mandatory requirement? Or based on a proper justification
you can also accept what I'm proposing?

I've always been more of the idea that what I'm proposing could make
more sense for a general case but perhaps I just need to go back and
better check the use-cases we have on hand to see if it's really
required or not.

Thanks for the prompt feedbacks!

-- 
#include <best/regards.h>

Patrick Bellasi
