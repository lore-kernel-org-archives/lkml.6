Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A8BC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5EE121728
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5EE121728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbeHNThG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:37:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45936 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732280AbeHNThF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:37:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FDFD18A;
        Tue, 14 Aug 2018 09:49:10 -0700 (PDT)
Received: from e110439-lin (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A24BF3F5BD;
        Tue, 14 Aug 2018 09:49:07 -0700 (PDT)
Date:   Tue, 14 Aug 2018 17:49:05 +0100
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
Subject: Re: [PATCH v3 03/14] sched/core: uclamp: add CPU's clamp groups
 accounting
Message-ID: <20180814164905.GG2605@e110439-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-4-patrick.bellasi@arm.com>
 <a24def9b-57bb-d072-5064-0421076d2e43@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a24def9b-57bb-d072-5064-0421076d2e43@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar!

On 14-Aug 17:44, Dietmar Eggemann wrote:
> On 08/06/2018 06:39 PM, Patrick Bellasi wrote:

[...]

> >+/**
> >+ * uclamp_cpu_put_id(): decrease reference count for a clamp group on a CPU
> >+ * @p: the task being dequeued from a CPU
> >+ * @cpu: the CPU from where the clamp group has to be released
> >+ * @clamp_id: the utilization clamp (e.g. min or max utilization) to release
> >+ *
> >+ * When a task is dequeued from a CPU's RQ, the CPU's clamp group reference
> >+ * counted by the task is decreased.
> >+ * If this was the last task defining the current max clamp group, then the
> >+ * CPU clamping is updated to find the new max for the specified clamp
> >+ * index.
> >+ */
> >+static inline void uclamp_cpu_put_id(struct task_struct *p,
> >+				     struct rq *rq, int clamp_id)
> >+{
> >+	struct uclamp_group *uc_grp;
> >+	struct uclamp_cpu *uc_cpu;
> >+	unsigned int clamp_value;
> >+	int group_id;
> >+
> >+	/* No task specific clamp values: nothing to do */
> >+	group_id = p->uclamp[clamp_id].group_id;
> >+	if (group_id == UCLAMP_NOT_VALID)
> >+		return;
> >+
> >+	/* Decrement the task's reference counted group index */
> >+	uc_grp = &rq->uclamp.group[clamp_id][0];
> >+#ifdef SCHED_DEBUG
> >+	if (unlikely(uc_grp[group_id].tasks == 0)) {
> >+		WARN(1, "invalid CPU[%d] clamp group [%d:%d] refcount\n",
> >+		     cpu_of(rq), clamp_id, group_id);
> >+		uc_grp[group_id].tasks = 1;
> >+	}
> >+#endif
> 
> This one indicates that there are some holes in your ref-counting.

Not really, this has been added not because I've detected a refcount
issue... but because it was suggested as a possible safety check in a
previous code review comment:

   https://lore.kernel.org/lkml/20180720151156.GA31421@e110439-lin/

> It's probably easier to debug that there is still a task but the
> uc_grp[group_id].tasks value == 0 (A). I assume the other problem exists as
> well, i.e. last task and uc_grp[group_id].tasks > 1 (B)?
> 
> You have uclamp_cpu_[get/put](_id)() in [enqueue/dequeue]_task.
> 
> Patch 04/14 introduces its use in uclamp_task_update_active().
> 
> Do you know why (A) (and (B)) are happening?

I've never saw that warning in my tests so far so, again, the warning
is there just to support testing/debugging when refcounting code
is/will be touched in the future. That's also the reason why is
SCHED_DEBUG protected.

> >+	uc_grp[group_id].tasks -= 1;
> >+
> >+	/* If this is not the last task, no updates are required */
> >+	if (uc_grp[group_id].tasks > 0)
> >+		return;
> >+
> >+	/*
> >+	 * Update the CPU only if this was the last task of the group
> >+	 * defining the current clamp value.
> >+	 */
> >+	uc_cpu = &rq->uclamp;
> >+	clamp_value = uc_grp[group_id].value;
> >+	if (clamp_value >= uc_cpu->value[clamp_id])
> 
> 'clamp_value > uc_cpu->value[clamp_id]' should indicate another
> inconsistency in the uclamp machinery, right?

Here you right, I would say that it should always be:

    clamp_value <= uc_cpu->value[clamp_id]

since this matches the update done at the end of uclamp_cpu_get_id():

   if (uc_cpu->value[clamp_id] < clamp_value)
        uc_cpu->value[clamp_id] = clamp_value;

Perhaps we can add another safety check here, similar to the one
above, to have something like:

    clamp_value = uc_grp[group_id].value;
#ifdef SCHED_DEBUG
    if (unlikely(clamp_value > uc_cpu->value[clamp_id])) {
        WARN(1, "invalid CPU[%d] clamp group [%d:%d] value\n",
                cpu_of(rq), clamp_id, group_id);
#endif
    if (clamp_value == uc_cpu->value[clamp_id])
        uclamp_cpu_update(rq, clamp_id);

-- 
#include <best/regards.h>

Patrick Bellasi
