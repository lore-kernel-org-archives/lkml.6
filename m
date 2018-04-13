Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754104AbeDMLEd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:04:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41292 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753784AbeDMLEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:04:31 -0400
Date: Fri, 13 Apr 2018 12:04:26 +0100
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
Message-ID: <20180413110426.GQ14248@e110439-lin>
References: <20180409165615.2326-1-patrick.bellasi@arm.com>
 <20180409165615.2326-2-patrick.bellasi@arm.com>
 <20180413082648.GP4043@hirez.programming.kicks-ass.net>
 <20180413102202.GN4129@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413102202.GN4129@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-Apr 12:22, Peter Zijlstra wrote:
> On Fri, Apr 13, 2018 at 10:26:48AM +0200, Peter Zijlstra wrote:
> > On Mon, Apr 09, 2018 at 05:56:09PM +0100, Patrick Bellasi wrote:
> > > +static inline void uclamp_cpu_get(struct task_struct *p, int cpu, int clamp_id)
> > > +{
> > > +	struct uclamp_cpu *uc_cpu = &cpu_rq(cpu)->uclamp[clamp_id];
> > 
> > > +static inline void uclamp_cpu_put(struct task_struct *p, int cpu, int clamp_id)
> > > +{
> > > +	struct uclamp_cpu *uc_cpu = &cpu_rq(cpu)->uclamp[clamp_id];
> > 
> > That all seems daft, since you already have rq at the call site.
> > 
> > > +static inline void uclamp_task_update(struct rq *rq, struct task_struct *p)
> > > +{
> > > +	int cpu = cpu_of(rq);
> > > +	int clamp_id;
> > > +
> > > +	/* The idle task does not affect CPU's clamps */
> > > +	if (unlikely(p->sched_class == &idle_sched_class))
> > > +		return;
> > > +	/* DEADLINE tasks do not affect CPU's clamps */
> > > +	if (unlikely(p->sched_class == &dl_sched_class))
> > > +		return;
> > 
> > This is wrong; it misses the stop_sched_class.
> > 
> > And since you're looking at sched_class anyway, maybe put a marker in
> > there:
> > 
> > 	if (!p->sched_class->has_clamping)
> > 		return;
> 
> Alternatively, we could simply add uclamp_task_{en,de}queue() into
> {en,de}queue_task_{fair,rt}().

I like better your first proposal, I think it makes sense to factor
out in core code used by both RT and FAIR the same way.

Do you have a strong preference?

> > > +	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
> > > +		if (uclamp_task_affects(p, clamp_id))
> > > +			uclamp_cpu_put(p, cpu, clamp_id);
> > > +		else
> > > +			uclamp_cpu_get(p, cpu, clamp_id);
> > > +	}
> > > +}

-- 
#include <best/regards.h>

Patrick Bellasi
