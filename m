Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752636AbeFARYF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 13:24:05 -0400
Received: from foss.arm.com ([217.140.101.70]:56186 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751502AbeFARYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 13:24:04 -0400
Date: Fri, 1 Jun 2018 18:23:59 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        viresh.kumar@linaro.org, valentin.schneider@arm.com
Subject: Re: [PATCH v5 03/10] cpufreq/schedutil: add rt utilization tracking
Message-ID: <20180601172359.GN30654@e110439-lin>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-4-git-send-email-vincent.guittot@linaro.org>
 <20180530164601.GC2174@e108498-lin.cambridge.arm.com>
 <20180531084607.GB17937@localhost.localdomain>
 <20180601162357.GT12180@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601162357.GT12180@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-Jun 18:23, Peter Zijlstra wrote:
> On Thu, May 31, 2018 at 10:46:07AM +0200, Juri Lelli wrote:
> > On 30/05/18 17:46, Quentin Perret wrote:
> 
> > > So I understand why we want to got to max freq when a RT task is running,
> > > but I think there are use cases where we might want to be more conservative
> > > and use the util_avg of the RT rq instead. The first use case is
> > > battery-powered devices where going to max isn't really affordable from
> > > an energy standpoint. Android, for example, has been using a RT
> > > utilization signal to select OPPs for quite a while now, because going
> > > to max blindly is _very_ expensive.
> > > 
> > > And the second use-case is thermal pressure. On some modern CPUs, going to
> > > max freq can lead to stringent thermal capping very quickly, at the
> > > point where your CPUs might not have enough capacity to serve your tasks
> > > properly. And that can ultimately hurt the very RT tasks you originally
> > > tried to run fast. In these systems, in the long term, you'd be better off
> > > not asking for more than what you really need ...
> > 
> > Proposed the same at last LPC. Peter NAKed it (since RT is all about
> > meeting deadlines, and when using FIFO/RR we don't really know how fast
> > the CPU should go to meet them, so go to max is the only safe decision).
> > 
> > > So what about having a sched_feature to select between going to max and
> > > using the RT util_avg ? Obviously the default should keep the current
> > > behaviour.
> > 
> > Peter, would SCHED_FEAT make a difference? :)
> 
> Hurmph...
> 
> > Or Patrick's utilization capping applied to RT..
> 
> There might be something there, IIRC that tracks the max potential
> utilization for the running tasks. So at that point we can set a
> frequency to minimize idle time.

Or we can do the opposite: we go to max by default (as it is now) and
if you think that some RT tasks don't need the full speed, you can
apply a util_max to them.

That way, when a RT task is running alone on a CPU, we can run it
only at a custom max freq which is known to be ok according to your
latency requirements.

If instead it's running with other CFS tasks, we add already the CFS
utilization, which will result into a speedup of the RT task to give
back the CPU to CFS.

> It's not perfect, because while the clamping thing effectively sets a
> per-task bandwidth, the max filter is wrong. Also there's no CBS to
> enforce anything.

Right, well... from user-space potentially if you carefully set the RT
cpu's controller (both bandwidth and clamping) and keep track of the
allocated bandwidth, you can still ensure that all your RT tasks will
be able to run, according to their prio.

> With RT servers we could aggregate the group bandwidth and limit from
> that...

What we certainly miss I think it's the EDF scheduler: it's not
possible to run certain RT tasks before others irrespectively of they
relative priority.

-- 
#include <best/regards.h>

Patrick Bellasi
