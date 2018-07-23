Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6753FECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2740520874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2740520874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388277AbeGWSYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:24:33 -0400
Received: from foss.arm.com ([217.140.101.70]:37288 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388002AbeGWSYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:24:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A48C218A;
        Mon, 23 Jul 2018 10:22:20 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 051DA3F6A8;
        Mon, 23 Jul 2018 10:22:17 -0700 (PDT)
Date:   Mon, 23 Jul 2018 18:22:15 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v2 08/12] sched/core: uclamp: extend cpu's cgroup
 controller
Message-ID: <20180723172215.GG2683@e110439-lin>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-9-patrick.bellasi@arm.com>
 <20180723153040.GG1934745@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723153040.GG1934745@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-Jul 08:30, Tejun Heo wrote:
> Hello,

Hi Tejun!
 
> On Mon, Jul 16, 2018 at 09:29:02AM +0100, Patrick Bellasi wrote:
> > The cgroup's CPU controller allows to assign a specified (maximum)
> > bandwidth to the tasks of a group. However this bandwidth is defined and
> > enforced only on a temporal base, without considering the actual
> > frequency a CPU is running on. Thus, the amount of computation completed
> > by a task within an allocated bandwidth can be very different depending
> > on the actual frequency the CPU is running that task.
> > The amount of computation can be affected also by the specific CPU a
> > task is running on, especially when running on asymmetric capacity
> > systems like Arm's big.LITTLE.
> 
> One basic problem I have with this patchset is that what's being
> described is way more generic than what actually got implemented.
> What's described is computation bandwidth control but what's
> implemented is just frequency clamping.

What I meant to describe is that we already have a computation
bandwidth control mechanism which is working quite fine for the
scheduling classes it applies to, i.e. CFS and RT.

For these classes we are usually happy with just a _best effort_
allocation of the bandwidth: nothing enforced in strict terms. Indeed,
there is not (at least not in kernel space) a tracking of the actual
available and allocated bandwidth. If we need strict enforcement, we
already have DL with its CBS servers.

However, the "best effort" bandwidth control we have for CFS and RT
can be further improved if, instead of just looking at time spent on
CPUs, we provide some more hints to the scheduler to know at which
min/max "MIPS" we want to consume the (best effort) time we have been
allocated on a CPU.

Such a simple extension is still quite useful to satisfy many use-case
we have, mainly on mobile systems, like the ones I've described in the
   "Newcomer's Short Abstract (Updated)"
section of the cover letter:
   https://lore.kernel.org/lkml/20180716082906.6061-1-patrick.bellasi@arm.com/T/#u

> So, there are fundamental discrepancies between
> description+interface vs. what it actually does.

Perhaps then I should just change the description to make it less
generic...

> I really don't think that's something we can fix up later.

... since, really, I don't think we can get to the point to extend
later this interface to provide the strict bandwidth enforcement you
are thinking about.

This would not be a fixup, but something really close to
re-implementing what we already have with the DL class.

> > These attributes:
> > 
> > a) are available only for non-root nodes, both on default and legacy
> >    hierarchies
> > b) do not enforce any constraints and/or dependency between the parent
> >    and its child nodes, thus relying on the delegation model and
> >    permission settings defined by the system management software
> 
> cgroup does host attributes which only concern the cgroup itself and
> thus don't need any hierarchical behaviors on their own, but what's
> being implemented does control resource allocation,

I'm not completely sure to get your point here.

Maybe it all depends on what we mean by "control resource allocation".

AFAIU, currently both the CFS and RT bandwidth controllers allow you
to define how much CPU time a group of tasks can use. It does that by
looking just within the group: there is no enforced/required relation
between the bandwidth assigned to a group and the bandwidth assigned
to its parent, siblings and/or children.

The resource control allocation is eventually enforced "indirectly" by
means of the fact that, based on tasks priorities and cgroup shares,
the scheduler will prefer to pick and run "more frequently" and
"longer" certain tasks instead of others.

Thus I would say that the resource allocation control is already
performed by the combined action of:
A) priorities / shares to favor certain tasks over others
B) period & bandwidth to further bias the scheduler in _not_ selecting
  tasks which already executed for the configured amount of time.

> and what you're describing inherently breaks the delegation model.

What I describe here is just an additional hint to the scheduler which
enrich the above described model. Provided A and B are already
satisfied, when a task gets a chance to run it will be executed at a
min/max configured frequency. That's really all... there is not
additional impact on "resources allocation".

I don't see why you say that this breaks the delegation model?

Maybe an example can help to better explain what you mean?

Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
