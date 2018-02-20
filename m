Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752833AbeBTQW1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:22:27 -0500
Received: from foss.arm.com ([217.140.101.70]:45020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752702AbeBTQW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:22:26 -0500
Date: Tue, 20 Feb 2018 16:22:22 +0000
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] sched/fair: Avoid unnecessary balancing of
 asymmetric capacity groups
Message-ID: <20180220162222.GC4589@e105550-lin.cambridge.arm.com>
References: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
 <1518711654-23503-5-git-send-email-morten.rasmussen@arm.com>
 <20180219145012.GH25181@hirez.programming.kicks-ass.net>
 <20180219145335.GN25235@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219145335.GN25235@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 03:53:35PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 19, 2018 at 03:50:12PM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 15, 2018 at 04:20:51PM +0000, Morten Rasmussen wrote:
> > > On systems with asymmetric cpu capacities, a skewed load distribution
> > > might yield better throughput than balancing load per group capacity.
> > > For example, preferring high capacity cpus for compute intensive tasks
> > > leaving low capacity cpus idle rather than balancing the number of idle
> > > cpus across different cpu types. Instead, let load-balance back off if
> > > the busiest group isn't really overloaded.
> > 
> > I'm sorry. I just can't seem to make sense of that today. What?
> 
> Aah, you're saying that is we have 4+4 bit.little and 4 runnable tasks,
> we would like them running on our big cluster and leave the small
> cluster entirely idle, instead of runnint 2+2.

Yes. Ideally, when are busy, we want to fill up the big cpus first, one
task on each, and if we have more tasks we start using little cpus
before putting additional tasks on any of the bigs. The load per group
capacity metric is sort of working against that up until roughly the
point where we have enough tasks for all the cpus.

> So what about this DynamicQ nonsense? Or is that so unstructured we
> can't really do anything sensible with it?

With DynamiQ we don't have any grouping of the cpu types provided by the
architecture. So we are going end up balancing between individual cpus.
I hope these tweaks should work for DynamiQ too. Always-running tasks on
little cpus should to be flagged as misfits and be picked up by big
cpus. It is still to be verified though.
