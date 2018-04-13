Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754232AbeDMLIz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:08:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41342 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751827AbeDMLIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:08:53 -0400
Date: Fri, 13 Apr 2018 12:08:48 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH 1/7] sched/core: uclamp: add CPU clamp groups accounting
Message-ID: <20180413110848.GR14248@e110439-lin>
References: <20180409165615.2326-1-patrick.bellasi@arm.com>
 <20180409165615.2326-2-patrick.bellasi@arm.com>
 <20180413094615.GT4043@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413094615.GT4043@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-Apr 11:46, Peter Zijlstra wrote:
> On Mon, Apr 09, 2018 at 05:56:09PM +0100, Patrick Bellasi wrote:
> > +static inline void uclamp_cpu_get(struct task_struct *p, int cpu, int clamp_id)
> > +{
> > +	struct uclamp_cpu *uc_cpu = &cpu_rq(cpu)->uclamp[clamp_id];
> > +	int clamp_value;
> > +	int group_id;
> > +
> > +	/* Get task's specific clamp value */
> > +	clamp_value = p->uclamp[clamp_id].value;
> > +	group_id = p->uclamp[clamp_id].group_id;
> > +
> > +	/* No task specific clamp values: nothing to do */
> > +	if (group_id == UCLAMP_NONE)
> > +		return;
> > +
> > +	/* Increment the current group_id */
> 
> That I think qualifies being called a bad comment.

my bad :/

> > +	uc_cpu->group[group_id].tasks += 1;
> > +
> > +	/* Mark task as enqueued for this clamp index */
> > +	p->uclamp_group_id[clamp_id] = group_id;
> 
> Why exactly do we need this? we got group_id from @p in the first place.

The idea is to back-annotate on the task the group in which it has
been refcounted. That allows a much simpler and less racy refcount
decrements at dequeue/migration time.

That's also why we have a single call-back, uclamp_task_update(),
for both enqueue/dequeue. Depending on the check performed by
uclamp_task_affects() we know if we have to get or put the refcounter.

> I suspect this is because when we update p->uclamp[], we don't update
> this active value (when needed), is that worth it?

What you mean by "we don't update this active value"?

> > +	/*
> > +	 * If this is the new max utilization clamp value, then we can update
> > +	 * straight away the CPU clamp value. Otherwise, the current CPU clamp
> > +	 * value is still valid and we are done.
> > +	 */
> > +	if (uc_cpu->value < clamp_value)
> > +		uc_cpu->value = clamp_value;
> > +}

-- 
#include <best/regards.h>

Patrick Bellasi
