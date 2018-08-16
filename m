Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494F5C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB8A208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB8A208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbeHPUUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 16:20:08 -0400
Received: from foss.arm.com ([217.140.101.70]:39292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbeHPUUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 16:20:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C9EE7A9;
        Thu, 16 Aug 2018 10:20:22 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 816833F5B3;
        Thu, 16 Aug 2018 10:20:19 -0700 (PDT)
Date:   Thu, 16 Aug 2018 18:20:17 +0100
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
Subject: Re: [PATCH v3 07/14] sched/core: uclamp: enforce last task UCLAMP_MAX
Message-ID: <20180816172016.GG2960@e110439-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-8-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806163946.28380-8-patrick.bellasi@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-Aug 17:39, Patrick Bellasi wrote:
> When a util_max clamped task sleeps, its clamp constraints are removed
> from the CPU. However, the blocked utilization on that CPU can still be
> higher than the max clamp value enforced while that task was running.
> This max clamp removal when a CPU is going to be idle could thus allow
> unwanted CPU frequency increases, right while the task is not running.
> 
> This can happen, for example, where there is another (smaller) task
> running on a different CPU of the same frequency domain.
> In this case, when we aggregate the utilization of all the CPUs in a
> shared frequency domain, schedutil can still see the full non clamped
> blocked utilization of all the CPUs and thus eventually increase the
> frequency.
> 
> Let's fix this by using:
> 
>    uclamp_cpu_put_id(UCLAMP_MAX)
>       uclamp_cpu_update(last_clamp_value)
> 
> to detect when a CPU has no more RUNNABLE clamped tasks and to flag this
> condition. Thus, while a CPU is idle, we can still enforce the last used
> clamp value for it.
> 
> To the contrary, we do not track any UCLAMP_MIN since, while a CPU is
> idle, we don't want to enforce any minimum frequency
> Indeed, we rely just on blocked load decay to smoothly reduce the
> frequency.

[...]

> @@ -906,7 +906,8 @@ uclamp_group_find(int clamp_id, unsigned int clamp_value)
>   * For the specified clamp index, this method computes the new CPU utilization
>   * clamp to use until the next change on the set of RUNNABLE tasks on that CPU.
>   */
> -static inline void uclamp_cpu_update(struct rq *rq, int clamp_id)
> +static inline void uclamp_cpu_update(struct rq *rq, int clamp_id,
> +				     unsigned int last_clamp_value)
>  {
>  	struct uclamp_group *uc_grp = &rq->uclamp.group[clamp_id][0];
>  	int max_value = UCLAMP_NOT_VALID;
> @@ -924,6 +925,19 @@ static inline void uclamp_cpu_update(struct rq *rq, int clamp_id)
>  		if (max_value >= SCHED_CAPACITY_SCALE)
>  			break;
>  	}
> +
> +	/*
> +	 * Just for the UCLAMP_MAX value, in case there are no RUNNABLE
> +	 * task, we keep the CPU clamped to the last task's clamp value.
> +	 * This avoids frequency spikes to MAX when one CPU, with an high
> +	 * blocked utilization, sleeps and another CPU, in the same frequency
> +	 * domain, do not see anymore the clamp on the first CPU.
> +	 */
> +	if (clamp_id == UCLAMP_MAX && max_value == UCLAMP_NOT_VALID) {
> +		rq->uclamp.flags |= UCLAMP_FLAG_IDLE;
> +		max_value = last_clamp_value;
> +	}
> +
>  	rq->uclamp.value[clamp_id] = max_value;
>  }
>  
> @@ -953,13 +967,26 @@ static inline void uclamp_cpu_get_id(struct task_struct *p,
>  	uc_grp = &rq->uclamp.group[clamp_id][0];
>  	uc_grp[group_id].tasks += 1;
>  
> +	/* Force clamp update on idle exit */
> +	uc_cpu = &rq->uclamp;
> +	clamp_value = p->uclamp[clamp_id].value;
> +	if (unlikely(uc_cpu->flags & UCLAMP_FLAG_IDLE)) {
> +		/*
> +		 * This function is called for both UCLAMP_MIN (before) and
> +		 * UCLAMP_MAX (after). Let's reset the flag only the second
> +		 * once we know that UCLAMP_MIN has been already updated.
> +		 */
> +		if (clamp_id == UCLAMP_MAX)
> +			uc_cpu->flags &= ~UCLAMP_FLAG_IDLE;
> +		uc_cpu->value[clamp_id] = clamp_value;
> +		return;
> +	}

Just notice that the code block above is not reached when we enqueue a task
without a valid clamp group, i.e. an un-clamped task, which is the
default for all tasks.

The fix should be as simple as moving this block at the beginning of
uclamp_cpu_update() so that we always un-conditionally release the
clamp holding as soon as we enqueue the first task after a CPU wakeup,
i.e. when the UCLAMP_FLAG_IDLE flag is set.

Will fix this on v4.

-- 
#include <best/regards.h>

Patrick Bellasi
