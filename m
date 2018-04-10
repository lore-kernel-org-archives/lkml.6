Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753196AbeDJUFU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 16:05:20 -0400
Received: from mail-yb0-f171.google.com ([209.85.213.171]:34755 "EHLO
        mail-yb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751629AbeDJUFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 16:05:17 -0400
X-Google-Smtp-Source: AIpwx48rKmPwC5udi1N+iXh/1/m38CqTKu4w8O8kZmpY5lPmO76o8kgpqQCIwq8M0OEVSGBvRl1sRQ==
Date: Tue, 10 Apr 2018 13:05:14 -0700
From: Tejun Heo <tj@kernel.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
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
Message-ID: <20180410200514.GA793541@devbig577.frc2.facebook.com>
References: <20180409165615.2326-1-patrick.bellasi@arm.com>
 <20180409165615.2326-5-patrick.bellasi@arm.com>
 <20180409222417.GK3126663@devbig577.frc2.facebook.com>
 <20180410171612.GJ14248@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410171612.GJ14248@e110439-lin>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Apr 10, 2018 at 06:16:12PM +0100, Patrick Bellasi wrote:
> > I'm not too enthusiastic about util_min/max given that it can easily
> > be read as actual utilization based bandwidth control when what's
> > actually implemented, IIUC, is affecting CPU frequency selection.
> 
> Right now we are basically affecting the frequency selection.
> However, the next step is to use this same interface to possibly bias
> task placement.
> 
> The idea is that:
> 
> - the util_min value can be used to possibly avoid CPUs which have
>   a (maybe temporarily) limited capacity, for example, due to thermal
>   pressure.
> 
> - a util_max value can use used to possibly identify tasks which can
>   be co-scheduled together in a (maybe) limited capacity CPU since
>   they are more likely "less important" tasks.
> 
> Thus, since this is a new user-space API, we would like to find a
> concept which is generic enough to express the current requirement but
> also easily accommodate future extensions.

I'm not sure we can overload the meanings like that on the same
interface.  Right now, it doesn't say anything about bandwidth (or
utilization) allocation.  It just limits the frequency range the
particular cpu that the task ended up on can be in and what you're
describing above is the third different thing.  It doesn't seem clear
that they're something which can be overloaded onto the same
interface.

> > Maybe something like cpu.freq.min/max are better names?
> 
> IMO this is something too much platform specific.
> 
> I agree that utilization is maybe too much an implementation detail,
> but perhaps this can be solved by using a more generic range.
> 
> What about using values in the [0..100] range which define:
> 
>    a percentage of the maximum available capacity
>          for the CPUs in the target system
> 
> Do you think this can work?

Yeah, sure, it's more that right now the intention isn't clear.  A
cgroup control knob which limits cpu frequency range while the cgroup
is on a cpu is a very different thing from a cgroup knob which
restricts what tasks can be scheduled on the same cpu.  They're
actually incompatible.  Doing the latter actively breaks the former.

> > This is a problem which exists for all other interfaces.  For
> > historical and other reasons, at least till now, we've opted to put
> > everything at system level outside of cgroup interface.  We might
> > change this in the future and duplicate system-level information and
> > interfaces in the root cgroup but we wanna do that in a more systemtic
> > fashion than adding an one-off knob in the cgroup root.
> 
> I see, I think we can easily come up with a procfs/sysfs interface
> usable to define system-wide values.
> 
> Any suggestion for something already existing which I can use as a
> reference?

Most system level interfaces are there with a long history and things
aren't that consistent.  One route could be finding an interface
implementing a nearby feature and staying consistent with that.

> > Tying creation / config operations to the config propagation doesn't
> > work well with delegation and is inconsistent with what other
> > controllers are doing.  For cases where the propagated config being
> > visible in a sub cgroup is necessary, please add .effective files.
> 
> I'm not sure to understand this point: you mean that we should not
> enforce "consistency rules" among parent-child groups?

You should.  It just shouldn't make configurations fail cuz that ends
up breaking delegations.

> I have to look better into this "effective" concept.
> Meanwhile, can you make a simple example?

There's a recent cpuset patchset posted by Waiman Long.  Googling for
lkml cpuset and Waiman Long should find it easily.

> > > Tasks on a subgroup can only be more boosted and/or capped, which is
> > 
> > Less boosted.  .low at a parent level must set the upper bound of .low
> > that all its descendants can have.
> 
> Is that a mandatory requirement? Or based on a proper justification
> you can also accept what I'm proposing?
>
> I've always been more of the idea that what I'm proposing could make
> more sense for a general case but perhaps I just need to go back and
> better check the use-cases we have on hand to see if it's really
> required or not.

Yeah, I think we want to stick to that semantics.  That's what memory
controller does and it'd be really confusing to flip the directions on
different controllers.

Thanks.

-- 
tejun
