Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B83C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CC92086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3CC92086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbeKHASz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:18:55 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51942 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbeKHASy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:18:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9D4A80D;
        Wed,  7 Nov 2018 06:48:14 -0800 (PST)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 070DD3F5BD;
        Wed,  7 Nov 2018 06:48:11 -0800 (PST)
Date:   Wed, 7 Nov 2018 14:48:09 +0000
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
Subject: Re: [PATCH v5 03/15] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Message-ID: <20181107144809.GH14309@e110439-lin>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-4-patrick.bellasi@arm.com>
 <20181107133504.GQ9781@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107133504.GQ9781@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-Nov 14:35, Peter Zijlstra wrote:
> On Mon, Oct 29, 2018 at 06:32:57PM +0000, Patrick Bellasi wrote:
> > +/**
> > + * uclamp_group_get: increase the reference count for a clamp group
> > + * @uc_se: the utilization clamp data for the task
> > + * @clamp_id: the clamp index affected by the task
> > + * @clamp_value: the new clamp value for the task
> > + *
> > + * Each time a task changes its utilization clamp value, for a specified clamp
> > + * index, we need to find an available clamp group which can be used to track
>You mean se_count overflow ?

> + * this new clamp value. The corresponding clamp group index will be used to
> > + * reference count the corresponding clamp value while the task is enqueued on
> > + * a CPU.
> > + */
> > +static void uclamp_group_get(struct uclamp_se *uc_se, unsigned int clamp_id,
> > +			     unsigned int clamp_value)
> > +{
> > +	union uclamp_map *uc_maps = &uclamp_maps[clamp_id][0];
> > +	unsigned int prev_group_id = uc_se->group_id;
> > +	union uclamp_map uc_map_old, uc_map_new;
> > +	unsigned int free_group_id;
> > +	unsigned int group_id;
> > +	unsigned long res;
> > +
> > +retry:
> > +
> > +	free_group_id = UCLAMP_GROUPS;
> > +	for (group_id = 0; group_id < UCLAMP_GROUPS; ++group_id) {
> > +		uc_map_old.data = atomic_long_read(&uc_maps[group_id].adata);
> > +		if (free_group_id == UCLAMP_GROUPS && !uc_map_old.se_count)
> > +			free_group_id = group_id;
> > +		if (uc_map_old.value == clamp_value)
> > +			break;
> > +	}
> > +	if (group_id >= UCLAMP_GROUPS) {
> > +#ifdef CONFIG_SCHED_DEBUG
> > +#define UCLAMP_MAPERR "clamp value [%u] mapping to clamp group failed\n"
> > +		if (unlikely(free_group_id == UCLAMP_GROUPS)) {
> > +			pr_err_ratelimited(UCLAMP_MAPERR, clamp_value);
> > +			return;
> > +		}
> > +#endif
> > +		group_id = free_group_id;
> > +		uc_map_old.data = atomic_long_read(&uc_maps[group_id].adata);
> > +	}
> 
> You forgot to check for refcount overflow here ;-)

You mean se_count overflow ?

That se_count is (BITS_PER_LONG - SCHED_CAPACITY_SHIFT - 1)
which makes it able to track up to:

   +2mln  tasks/task_groups on 32bit systems (with SCHED_CAPACITY_SHIFT 10)
   +10^12 tasks/task_groups on 64bit systems (with SCHED_CAPACITY_SHIFT 20)

I don't expect overflow on 64bit systems, do we ?

It's more likely on 32bit systems, especially if in the future we
should increase SCHED_CAPACITY_SHIFT.

> And I'm not really a fan of hiding that error in a define like you keep
> doing.

The #define is not there to mask an overflow, it's there to catch the
case in which the refcount should be corrupted and we end up violating
the invariant: "there is always a clamp group available".

NOTE: that invariant is granted once we add

   sched/core: uclamp: add clamp group bucketing support

The warning reports the issue only on CONFIG_SCHED_DEBUG, but...
it makes sense to keep it always enabled.

While, in case of data corruption, we should just return thus not
setting the scheduling entity as "mapped" towards the end of the
function... which makes me see that it's actually wrong to
conditionally compile the above "return"


> What's wrong with something like:
> 
> 	if (SCHED_WARN(free_group_id == UCLAMP_GROUPS))
> 		return;

Right, the flow should be:

  1. try to find a valid clamp group
  2. if you don't find one, the data structures are corrupted
     warn once for data corruption
     do not map this scheduling entity and return
  3. map the scheduling entity

Is that ok ?


> and
> 
> > +	uc_map_new.se_count = uc_map_old.se_count + 1;
> 
> 	if (SCHED_WARN(!new.se_count))
> 		new.se_count = -1;

Mmm... not sure we can recover from a corrupted refcount or an
overflow.

What should we do on these cases, disable uclamp completely ?


> > +	uc_map_new.value = clamp_value;
> > +	res = atomic_long_cmpxchg(&uc_maps[group_id].adata,
> > +				  uc_map_old.data, uc_map_new.data);
> > +	if (res != uc_map_old.data)
> > +		goto retry;
> > +
> > +	/* Update SE's clamp values and attach it to new clamp group */
> > +	uc_se->value = clamp_value;
> > +	uc_se->group_id = group_id;
> > +
> > +	/* Release the previous clamp group */
> > +	if (uc_se->mapped)
> > +		uclamp_group_put(clamp_id, prev_group_id);
> > +	uc_se->mapped = true;
> > +}

-- 
#include <best/regards.h>

Patrick Bellasi
