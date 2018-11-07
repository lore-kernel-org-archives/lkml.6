Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24DEC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971B92085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971B92085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbeKGXzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:55:09 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51638 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbeKGXzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:55:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F28AFA78;
        Wed,  7 Nov 2018 06:24:33 -0800 (PST)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30B233F718;
        Wed,  7 Nov 2018 06:24:31 -0800 (PST)
Date:   Wed, 7 Nov 2018 14:24:28 +0000
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
Message-ID: <20181107142428.GG14309@e110439-lin>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-4-patrick.bellasi@arm.com>
 <20181107134414.GR9781@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107134414.GR9781@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-Nov 14:44, Peter Zijlstra wrote:
> On Mon, Oct 29, 2018 at 06:32:57PM +0000, Patrick Bellasi wrote:
> > +/**
> > + * uclamp_group_get: increase the reference count for a clamp group
> > + * @uc_se: the utilization clamp data for the task
> > + * @clamp_id: the clamp index affected by the task
> > + * @clamp_value: the new clamp value for the task
> > + *
> > + * Each time a task changes its utilization clamp value, for a specified clamp
> > + * index, we need to find an available clamp group which can be used to track
> > + * this new clamp value. The corresponding clamp group index will be used to
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
> 
> Can you please put in a comment, either here or on top, on why this can
> not in fact happen? And we're always guaranteed a free group.

You right, that's confusing especially because up to this point we are
not granted. We are always granted a free group once we add:

   sched/core: uclamp: add clamp group bucketing support

I've kept it separated to better document how we introduce that
support.

Is it ok for for you if I better call out in the change log that the
guarantee comes from a following patch... and add the comment in
that later patch ?

> 
> > +		group_id = free_group_id;
> > +		uc_map_old.data = atomic_long_read(&uc_maps[group_id].adata);
> > +	}
> > +
> > +	uc_map_new.se_count = uc_map_old.se_count + 1;
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
