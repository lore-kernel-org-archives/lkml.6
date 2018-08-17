Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC6DC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 11:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FAC2187B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 11:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40FAC2187B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbeHQOH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 10:07:28 -0400
Received: from foss.arm.com ([217.140.101.70]:46050 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbeHQOH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 10:07:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0F187A9;
        Fri, 17 Aug 2018 04:04:26 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21F1A3F5BD;
        Fri, 17 Aug 2018 04:04:23 -0700 (PDT)
Date:   Fri, 17 Aug 2018 12:04:21 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
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
Subject: Re: [PATCH v3 03/14] sched/core: uclamp: add CPU's clamp groups
 accounting
Message-ID: <20180817110421.GJ2960@e110439-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-4-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806163946.28380-4-patrick.bellasi@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-Aug 17:39, Patrick Bellasi wrote:

[...]

> +/**
> + * uclamp_cpu_get_id(): increase reference count for a clamp group on a CPU
> + * @p: the task being enqueued on a CPU
> + * @rq: the CPU's rq where the clamp group has to be reference counted
> + * @clamp_id: the utilization clamp (e.g. min or max utilization) to reference
> + *
> + * Once a task is enqueued on a CPU's RQ, the clamp group currently defined by
> + * the task's uclamp.group_id is reference counted on that CPU.
> + */
> +static inline void uclamp_cpu_get_id(struct task_struct *p,
> +				     struct rq *rq, int clamp_id)
> +{
> +	struct uclamp_group *uc_grp;
> +	struct uclamp_cpu *uc_cpu;
> +	int clamp_value;
> +	int group_id;
> +
> +	/* No task specific clamp values: nothing to do */
> +	group_id = p->uclamp[clamp_id].group_id;
> +	if (group_id == UCLAMP_NOT_VALID)
> +		return;

This is broken for util_max aggression.

By not refcounting tasks without a task specific clamp value, we end
up enforcing a max_util to these tasks when they are co-scheduled with
another max clamped task.

I need to fix this by removing this "optimization" (working just for
util_min) and refcount all the tasks.

> +
> +	/* Reference count the task into its current group_id */
> +	uc_grp = &rq->uclamp.group[clamp_id][0];
> +	uc_grp[group_id].tasks += 1;
> +
> +	/*
> +	 * If this is the new max utilization clamp value, then we can update
> +	 * straight away the CPU clamp value. Otherwise, the current CPU clamp
> +	 * value is still valid and we are done.
> +	 */
> +	uc_cpu = &rq->uclamp;
> +	clamp_value = p->uclamp[clamp_id].value;
> +	if (uc_cpu->value[clamp_id] < clamp_value)
> +		uc_cpu->value[clamp_id] = clamp_value;
> +}
> +

-- 
#include <best/regards.h>

Patrick Bellasi
