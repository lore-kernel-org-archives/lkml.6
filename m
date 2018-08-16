Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88733C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4732020C07
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4732020C07
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeHPTsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:48:39 -0400
Received: from foss.arm.com ([217.140.101.70]:38716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbeHPTr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:47:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B94337A9;
        Thu, 16 Aug 2018 09:47:50 -0700 (PDT)
Received: from e110439-lin (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 085983F5B3;
        Thu, 16 Aug 2018 09:47:47 -0700 (PDT)
Date:   Thu, 16 Aug 2018 17:47:45 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 07/14] sched/core: uclamp: enforce last task UCLAMP_MAX
Message-ID: <20180816164745.GF2960@e110439-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-8-patrick.bellasi@arm.com>
 <2366fe11-db1f-4f39-df03-960535611319@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2366fe11-db1f-4f39-df03-960535611319@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-Aug 17:43, Dietmar Eggemann wrote:
> On 08/06/2018 06:39 PM, Patrick Bellasi wrote:
> >When a util_max clamped task sleeps, its clamp constraints are removed
> >from the CPU. However, the blocked utilization on that CPU can still be
> >higher than the max clamp value enforced while that task was running.
> >This max clamp removal when a CPU is going to be idle could thus allow
> >unwanted CPU frequency increases, right while the task is not running.
> 
> So 'rq->uclamp.flags == UCLAMP_FLAG_IDLE' means CPU is IDLE because
> non-clamped tasks are tracked as well ((group_id = 0)).

Right, but... with (group_id = 0) you mean that "non-clamped tasks are
tracked" in the first clamp group?

> Maybe this is worth mentioning here?

Maybe I can explicitely say that we detect that there are not RUNNABLE
tasks because all the clamp groups are in UCLAMP_NOT_VALID status.

> >This can happen, for example, where there is another (smaller) task
> >running on a different CPU of the same frequency domain.
> >In this case, when we aggregate the utilization of all the CPUs in a
> >shared frequency domain, schedutil can still see the full non clamped
> >blocked utilization of all the CPUs and thus eventually increase the
> >frequency.
> >
> >Let's fix this by using:
> >
> >    uclamp_cpu_put_id(UCLAMP_MAX)
> >       uclamp_cpu_update(last_clamp_value)
> >
> >to detect when a CPU has no more RUNNABLE clamped tasks and to flag this
> >condition. Thus, while a CPU is idle, we can still enforce the last used
> >clamp value for it.
> >
> >To the contrary, we do not track any UCLAMP_MIN since, while a CPU is
> >idle, we don't want to enforce any minimum frequency
> >Indeed, we rely just on blocked load decay to smoothly reduce the
> >frequency.
> 
> [...]
> 
> >diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >index bc2beedec7bf..ff76b000bbe8 100644
> >--- a/kernel/sched/core.c
> >+++ b/kernel/sched/core.c
> >@@ -906,7 +906,8 @@ uclamp_group_find(int clamp_id, unsigned int clamp_value)
> >   * For the specified clamp index, this method computes the new CPU utilization
> >   * clamp to use until the next change on the set of RUNNABLE tasks on that CPU.
> >   */
> >-static inline void uclamp_cpu_update(struct rq *rq, int clamp_id)
> >+static inline void uclamp_cpu_update(struct rq *rq, int clamp_id,
> >+				     unsigned int last_clamp_value)
> >  {
> >  	struct uclamp_group *uc_grp = &rq->uclamp.group[clamp_id][0];
> >  	int max_value = UCLAMP_NOT_VALID;
> >@@ -924,6 +925,19 @@ static inline void uclamp_cpu_update(struct rq *rq, int clamp_id)
> 
> The condition:
> 
>     if (!uclamp_group_active(uc_grp, group_id))
>         continue;
> 
> in 'for (group_id = 0; group_id <= CONFIG_UCLAMP_GROUPS_COUNT; ++group_id)
> {}' makes sure that 'max_value == UCLAMP_NOT_VALID' is true for the if
> condition (*):
> 
> 
> >  		if (max_value >= SCHED_CAPACITY_SCALE)
> >  			break;
> >  	}
> >+
> >+	/*
> >+	 * Just for the UCLAMP_MAX value, in case there are no RUNNABLE
> >+	 * task, we keep the CPU clamped to the last task's clamp value.
> >+	 * This avoids frequency spikes to MAX when one CPU, with an high
> >+	 * blocked utilization, sleeps and another CPU, in the same frequency
> >+	 * domain, do not see anymore the clamp on the first CPU.
> >+	 */
> >+	if (clamp_id == UCLAMP_MAX && max_value == UCLAMP_NOT_VALID) {
> >+		rq->uclamp.flags |= UCLAMP_FLAG_IDLE;
> >+		max_value = last_clamp_value;
> >+	}
> >+
> 
> (*): So the uc_grp[group_id].value stays last_clamp_value?

A bit confusing... but I think you've got the point.

> What do you do when the blocked utilization decays below this enforced
> last_clamp_value on that CPU?

This is done _just_ for max_util:
- it clamps a blocked utilization bigger then last_clamp_value
  thus avoiding the selection of an OPP bigger then the one enforced
  while the task was runnable
- it has not effect on a blocked utilization smaller then last_clamp_value
  thus allowing to reduce gracefully the OPP as long as the blocked
  utilization is decayed

> I assume there are plenty of this kind of corner cases because we have
> blocked signals (including all tasks) and clamping (including runnable
> tasks).

This is a pretty compelling one I've noticed in my tests and thus
worth a fix... I don't have on hand other similar corner cases, do
you?


-- 
#include <best/regards.h>

Patrick Bellasi
