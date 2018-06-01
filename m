Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbeFAQYS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:24:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752064AbeFAQYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:24:15 -0400
Date: Fri, 1 Jun 2018 18:23:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Quentin Perret <quentin.perret@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        viresh.kumar@linaro.org, valentin.schneider@arm.com
Subject: Re: [PATCH v5 03/10] cpufreq/schedutil: add rt utilization tracking
Message-ID: <20180601162357.GT12180@hirez.programming.kicks-ass.net>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-4-git-send-email-vincent.guittot@linaro.org>
 <20180530164601.GC2174@e108498-lin.cambridge.arm.com>
 <20180531084607.GB17937@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531084607.GB17937@localhost.localdomain>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 10:46:07AM +0200, Juri Lelli wrote:
> On 30/05/18 17:46, Quentin Perret wrote:

> > So I understand why we want to got to max freq when a RT task is running,
> > but I think there are use cases where we might want to be more conservative
> > and use the util_avg of the RT rq instead. The first use case is
> > battery-powered devices where going to max isn't really affordable from
> > an energy standpoint. Android, for example, has been using a RT
> > utilization signal to select OPPs for quite a while now, because going
> > to max blindly is _very_ expensive.
> > 
> > And the second use-case is thermal pressure. On some modern CPUs, going to
> > max freq can lead to stringent thermal capping very quickly, at the
> > point where your CPUs might not have enough capacity to serve your tasks
> > properly. And that can ultimately hurt the very RT tasks you originally
> > tried to run fast. In these systems, in the long term, you'd be better off
> > not asking for more than what you really need ...
> 
> Proposed the same at last LPC. Peter NAKed it (since RT is all about
> meeting deadlines, and when using FIFO/RR we don't really know how fast
> the CPU should go to meet them, so go to max is the only safe decision).
> 
> > So what about having a sched_feature to select between going to max and
> > using the RT util_avg ? Obviously the default should keep the current
> > behaviour.
> 
> Peter, would SCHED_FEAT make a difference? :)

Hurmph...

> Or Patrick's utilization capping applied to RT..

There might be something there, IIRC that tracks the max potential
utilization for the running tasks. So at that point we can set a
frequency to minimize idle time.

It's not perfect, because while the clamping thing effectively sets a
per-task bandwidth, the max filter is wrong. Also there's no CBS to
enforce anything.

With RT servers we could aggregate the group bandwidth and limit from
that...
