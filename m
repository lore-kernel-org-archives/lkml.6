Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754004AbeDMI1M (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 04:27:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35776 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753122AbeDMI1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 04:27:07 -0400
Date: Fri, 13 Apr 2018 10:26:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
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
Message-ID: <20180413082648.GP4043@hirez.programming.kicks-ass.net>
References: <20180409165615.2326-1-patrick.bellasi@arm.com>
 <20180409165615.2326-2-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409165615.2326-2-patrick.bellasi@arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 05:56:09PM +0100, Patrick Bellasi wrote:
> +static inline void uclamp_cpu_get(struct task_struct *p, int cpu, int clamp_id)
> +{
> +	struct uclamp_cpu *uc_cpu = &cpu_rq(cpu)->uclamp[clamp_id];

> +static inline void uclamp_cpu_put(struct task_struct *p, int cpu, int clamp_id)
> +{
> +	struct uclamp_cpu *uc_cpu = &cpu_rq(cpu)->uclamp[clamp_id];

That all seems daft, since you already have rq at the call site.

> +static inline void uclamp_task_update(struct rq *rq, struct task_struct *p)
> +{
> +	int cpu = cpu_of(rq);
> +	int clamp_id;
> +
> +	/* The idle task does not affect CPU's clamps */
> +	if (unlikely(p->sched_class == &idle_sched_class))
> +		return;
> +	/* DEADLINE tasks do not affect CPU's clamps */
> +	if (unlikely(p->sched_class == &dl_sched_class))
> +		return;

This is wrong; it misses the stop_sched_class.

And since you're looking at sched_class anyway, maybe put a marker in
there:

	if (!p->sched_class->has_clamping)
		return;

> +	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
> +		if (uclamp_task_affects(p, clamp_id))
> +			uclamp_cpu_put(p, cpu, clamp_id);
> +		else
> +			uclamp_cpu_get(p, cpu, clamp_id);
> +	}
> +}
