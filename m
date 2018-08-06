Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AACC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA9021A28
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA9021A28
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387516AbeHFSup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:50:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41834 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbeHFSuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:50:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2767E15AB;
        Mon,  6 Aug 2018 09:40:51 -0700 (PDT)
Received: from e110439-lin.Cambridge.Arm.com (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5A1FF3F5D0;
        Mon,  6 Aug 2018 09:40:48 -0700 (PDT)
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
Subject: [PATCH v3 07/14] sched/core: uclamp: enforce last task UCLAMP_MAX
Date:   Mon,  6 Aug 2018 17:39:39 +0100
Message-Id: <20180806163946.28380-8-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806163946.28380-1-patrick.bellasi@arm.com>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a util_max clamped task sleeps, its clamp constraints are removed
from the CPU. However, the blocked utilization on that CPU can still be
higher than the max clamp value enforced while that task was running.
This max clamp removal when a CPU is going to be idle could thus allow
unwanted CPU frequency increases, right while the task is not running.

This can happen, for example, where there is another (smaller) task
running on a different CPU of the same frequency domain.
In this case, when we aggregate the utilization of all the CPUs in a
shared frequency domain, schedutil can still see the full non clamped
blocked utilization of all the CPUs and thus eventually increase the
frequency.

Let's fix this by using:

   uclamp_cpu_put_id(UCLAMP_MAX)
      uclamp_cpu_update(last_clamp_value)

to detect when a CPU has no more RUNNABLE clamped tasks and to flag this
condition. Thus, while a CPU is idle, we can still enforce the last used
clamp value for it.

To the contrary, we do not track any UCLAMP_MIN since, while a CPU is
idle, we don't want to enforce any minimum frequency
Indeed, we rely just on blocked load decay to smoothly reduce the
frequency.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
Changes in v3:
 Message-ID: <CAJuCfpFnj2g3+ZpR4fP4yqfxs0zd=c-Zehr2XM7m_C+WdL9jNA@mail.gmail.com>
 - rename UCLAMP_NONE into UCLAMP_NOT_VALID

Changes in v2:
 - rabased on v4.18-rc4
 - new patch to improve a specific issue
---
 kernel/sched/core.c  | 35 +++++++++++++++++++++++++++++++----
 kernel/sched/sched.h |  2 ++
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bc2beedec7bf..ff76b000bbe8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -906,7 +906,8 @@ uclamp_group_find(int clamp_id, unsigned int clamp_value)
  * For the specified clamp index, this method computes the new CPU utilization
  * clamp to use until the next change on the set of RUNNABLE tasks on that CPU.
  */
-static inline void uclamp_cpu_update(struct rq *rq, int clamp_id)
+static inline void uclamp_cpu_update(struct rq *rq, int clamp_id,
+				     unsigned int last_clamp_value)
 {
 	struct uclamp_group *uc_grp = &rq->uclamp.group[clamp_id][0];
 	int max_value = UCLAMP_NOT_VALID;
@@ -924,6 +925,19 @@ static inline void uclamp_cpu_update(struct rq *rq, int clamp_id)
 		if (max_value >= SCHED_CAPACITY_SCALE)
 			break;
 	}
+
+	/*
+	 * Just for the UCLAMP_MAX value, in case there are no RUNNABLE
+	 * task, we keep the CPU clamped to the last task's clamp value.
+	 * This avoids frequency spikes to MAX when one CPU, with an high
+	 * blocked utilization, sleeps and another CPU, in the same frequency
+	 * domain, do not see anymore the clamp on the first CPU.
+	 */
+	if (clamp_id == UCLAMP_MAX && max_value == UCLAMP_NOT_VALID) {
+		rq->uclamp.flags |= UCLAMP_FLAG_IDLE;
+		max_value = last_clamp_value;
+	}
+
 	rq->uclamp.value[clamp_id] = max_value;
 }
 
@@ -953,13 +967,26 @@ static inline void uclamp_cpu_get_id(struct task_struct *p,
 	uc_grp = &rq->uclamp.group[clamp_id][0];
 	uc_grp[group_id].tasks += 1;
 
+	/* Force clamp update on idle exit */
+	uc_cpu = &rq->uclamp;
+	clamp_value = p->uclamp[clamp_id].value;
+	if (unlikely(uc_cpu->flags & UCLAMP_FLAG_IDLE)) {
+		/*
+		 * This function is called for both UCLAMP_MIN (before) and
+		 * UCLAMP_MAX (after). Let's reset the flag only the second
+		 * once we know that UCLAMP_MIN has been already updated.
+		 */
+		if (clamp_id == UCLAMP_MAX)
+			uc_cpu->flags &= ~UCLAMP_FLAG_IDLE;
+		uc_cpu->value[clamp_id] = clamp_value;
+		return;
+	}
+
 	/*
 	 * If this is the new max utilization clamp value, then we can update
 	 * straight away the CPU clamp value. Otherwise, the current CPU clamp
 	 * value is still valid and we are done.
 	 */
-	uc_cpu = &rq->uclamp;
-	clamp_value = p->uclamp[clamp_id].value;
 	if (uc_cpu->value[clamp_id] < clamp_value)
 		uc_cpu->value[clamp_id] = clamp_value;
 }
@@ -1011,7 +1038,7 @@ static inline void uclamp_cpu_put_id(struct task_struct *p,
 	uc_cpu = &rq->uclamp;
 	clamp_value = uc_grp[group_id].value;
 	if (clamp_value >= uc_cpu->value[clamp_id])
-		uclamp_cpu_update(rq, clamp_id);
+		uclamp_cpu_update(rq, clamp_id, clamp_value);
 }
 
 /**
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index bb305e3d5737..d5855babb9c9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -803,6 +803,8 @@ struct uclamp_group {
  * values, i.e. no min/max clamping at all.
  */
 struct uclamp_cpu {
+#define UCLAMP_FLAG_IDLE 0x01
+	int flags;
 	int value[UCLAMP_CNT];
 	struct uclamp_group group[UCLAMP_CNT][CONFIG_UCLAMP_GROUPS_COUNT + 1];
 };
-- 
2.18.0

