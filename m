Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631CDC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3B12086A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3B12086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732912AbeKNBKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:10:07 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57978 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbeKNBKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 20:10:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF4F5A78;
        Tue, 13 Nov 2018 07:11:33 -0800 (PST)
Received: from darkstar (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4548B3F5BD;
        Tue, 13 Nov 2018 07:11:33 -0800 (PST)
Date:   Tue, 13 Nov 2018 07:11:27 -0800
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v5 04/15] sched/core: uclamp: add CPU's clamp groups
 refcounting
Message-ID: <20181113151127.GA7681@darkstar>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-6-patrick.bellasi@arm.com>
 <20181111164754.GA3038@worktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111164754.GA3038@worktop>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-Nov 17:47, Peter Zijlstra wrote:
> On Mon, Oct 29, 2018 at 06:32:59PM +0000, Patrick Bellasi wrote:
> > +static inline void uclamp_cpu_update(struct rq *rq, unsigned int clamp_id)
> > +{
> > +	unsigned int group_id;
> > +	int max_value = 0;
> > +
> > +	for (group_id = 0; group_id < UCLAMP_GROUPS; ++group_id) {
> > +		if (!rq->uclamp.group[clamp_id][group_id].tasks)
> > +			continue;
> > +		/* Both min and max clamps are MAX aggregated */
> > +		if (max_value < rq->uclamp.group[clamp_id][group_id].value)
> > +			max_value = rq->uclamp.group[clamp_id][group_id].value;
> 
> 		max_value = max(max_value, rq->uclamp.group[clamp_id][group_id].value);

Right, I get used to this pattern to avoid write instructions.
I guess that here, being just a function local variable, we don't
really care much...

> > +		if (max_value >= SCHED_CAPACITY_SCALE)
> > +			break;
> > +	}
> > +	rq->uclamp.value[clamp_id] = max_value;
> > +}
> > +
> > +/**
> > + * uclamp_cpu_get_id(): increase reference count for a clamp group on a CPU
> > + * @p: the task being enqueued on a CPU
> > + * @rq: the CPU's rq where the clamp group has to be reference counted
> > + * @clamp_id: the clamp index to update
> > + *
> > + * Once a task is enqueued on a CPU's rq, the clamp group currently defined by
> > + * the task's uclamp::group_id is reference counted on that CPU.
> > + */
> > +static inline void uclamp_cpu_get_id(struct task_struct *p, struct rq *rq,
> > +				     unsigned int clamp_id)
> > +{
> > +	unsigned int group_id;
> > +
> > +	if (unlikely(!p->uclamp[clamp_id].mapped))
> > +		return;
> > +
> > +	group_id = p->uclamp[clamp_id].group_id;
> > +	p->uclamp[clamp_id].active = true;
> > +
> > +	rq->uclamp.group[clamp_id][group_id].tasks += 1;
> 
> 	++
> > +
> > +	if (rq->uclamp.value[clamp_id] < p->uclamp[clamp_id].value)
> > +		rq->uclamp.value[clamp_id] = p->uclamp[clamp_id].value;
> 
> 	rq->uclamp.value[clamp_id] = max(rq->uclamp.value[clamp_id],
> 					 p->uclamp[clamp_id].value);

In this case instead, since we are updating a variable visible from
other CPUs, should not be preferred to avoid assignment when not
required ?

Is the compiler is smart enough to optimize the code above?
... will check better.

> > +}
> > +
> > +/**
> > + * uclamp_cpu_put_id(): decrease reference count for a clamp group on a CPU
> > + * @p: the task being dequeued from a CPU
> > + * @rq: the CPU's rq from where the clamp group has to be released
> > + * @clamp_id: the clamp index to update
> > + *
> > + * When a task is dequeued from a CPU's rq, the CPU's clamp group reference
> > + * counted by the task is released.
> > + * If this was the last task reference coutning the current max clamp group,
> > + * then the CPU clamping is updated to find the new max for the specified
> > + * clamp index.
> > + */
> > +static inline void uclamp_cpu_put_id(struct task_struct *p, struct rq *rq,
> > +				     unsigned int clamp_id)
> > +{
> > +	unsigned int clamp_value;
> > +	unsigned int group_id;
> > +
> > +	if (unlikely(!p->uclamp[clamp_id].mapped))
> > +		return;
> > +
> > +	group_id = p->uclamp[clamp_id].group_id;
> > +	p->uclamp[clamp_id].active = false;
> > +
> 	SCHED_WARN_ON(!rq->uclamp.group[clamp_id][group_id].tasks);
> 
> > +	if (likely(rq->uclamp.group[clamp_id][group_id].tasks))
> > +		rq->uclamp.group[clamp_id][group_id].tasks -= 1;
> 
> 	--
> 
> > +#ifdef CONFIG_SCHED_DEBUG
> > +	else {
> > +		WARN(1, "invalid CPU[%d] clamp group [%u:%u] refcount\n",
> > +		     cpu_of(rq), clamp_id, group_id);
> > +	}
> > +#endif
> 
> > +
> > +	if (likely(rq->uclamp.group[clamp_id][group_id].tasks))
> > +		return;
> > +
> > +	clamp_value = rq->uclamp.group[clamp_id][group_id].value;
> > +#ifdef CONFIG_SCHED_DEBUG
> > +	if (unlikely(clamp_value > rq->uclamp.value[clamp_id])) {
> > +		WARN(1, "invalid CPU[%d] clamp group [%u:%u] value\n",
> > +		     cpu_of(rq), clamp_id, group_id);
> > +	}
> > +#endif
> 
> 	SCHED_WARN_ON(clamp_value > rq->uclamp.value[clamp_id]);
> 
> > +	if (clamp_value >= rq->uclamp.value[clamp_id])
> > +		uclamp_cpu_update(rq, clamp_id);
> > +}
> 
> > @@ -866,6 +1020,28 @@ static void uclamp_group_get(struct uclamp_se *uc_se, unsigned int clamp_id,
> >  	if (res != uc_map_old.data)
> >  		goto retry;
> >  
> > +	/* Ensure each CPU tracks the correct value for this clamp group */
> > +	if (likely(uc_map_new.se_count > 1))
> > +		goto done;
> > +	for_each_possible_cpu(cpu) {
> 
> yuck yuck yuck.. why!?

When a clamp group is released, i.e. no more SEs refcount it, that
group could be mapped in the future to a different clamp value.

Thus, when this happens, a different clamp value can be assigned to
that clamp group and we need to update the value tracked in the CPU
side data structures. That's the value actually used to figure out the
min/max clamps at enqueue/dequeue times.

However, since here we are in the slow-path, this should not be an
issue, isn't it ?

> 
> > +		struct uclamp_cpu *uc_cpu = &cpu_rq(cpu)->uclamp;
> > +
> > +		/* Refcounting is expected to be always 0 for free groups */
> > +		if (unlikely(uc_cpu->group[clamp_id][group_id].tasks)) {
> > +			uc_cpu->group[clamp_id][group_id].tasks = 0;
> > +#ifdef CONFIG_SCHED_DEBUG
> > +			WARN(1, "invalid CPU[%d] clamp group [%u:%u] refcount\n",
> > +			     cpu, clamp_id, group_id);
> > +#endif
> 
> 		SCHED_WARN_ON();
> 
> > +		}
> > +
> > +		if (uc_cpu->group[clamp_id][group_id].value == clamp_value)
> > +			continue;
> > +		uc_cpu->group[clamp_id][group_id].value = clamp_value;
> > +	}
> > +
> > +done:
> > +
> >  	/* Update SE's clamp values and attach it to new clamp group */
> >  	uc_se->value = clamp_value;
> >  	uc_se->group_id = group_id;

-- 
#include <best/regards.h>

Patrick Bellasi
