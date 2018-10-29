Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47928C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C712080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C712080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbeJ3DXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:23:43 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44620 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729275AbeJ3DXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:23:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A79DD1684;
        Mon, 29 Oct 2018 11:33:51 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B69D83F6A8;
        Mon, 29 Oct 2018 11:33:48 -0700 (PDT)
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
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
Subject: [PATCH v5 06/15] sched/core: uclamp: enforce last task UCLAMP_MAX
Date:   Mon, 29 Oct 2018 18:33:01 +0000
Message-Id: <20181029183311.29175-8-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181029183311.29175-1-patrick.bellasi@arm.com>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a util_max clamped task sleeps, its clamp constraints are removed
from the CPU. However, the blocked utilization on that CPU can still be
higher than the max clamp value enforced while that task was running.

The release of a util_max clamp when a CPU is going to be idle could
thus allow unwanted CPU frequency increases while tasks are not
running. This can happen, for example, when a frequency update is
triggered from another CPU of the same frequency domain.
In this case, when we aggregate the utilization of all the CPUs in a
shared frequency domain, schedutil can still see the full not clamped
blocked utilization of all the CPUs and thus, eventually, increase the
frequency.

Let's fix this by using:

   uclamp_cpu_put_id(UCLAMP_MAX)
      uclamp_cpu_update(last_clamp_value)

to detect when a CPU has no more RUNNABLE clamped tasks and to flag this
condition. Thus, while a CPU is idle, we can still enforce the last used
clamp value for it.

To the contrary, we do not track any UCLAMP_MIN since, while a CPU is
idle, we don't want to enforce any minimum frequency. Indeed, in this
case, we rely just on the decay of the blocked utilization to smoothly
reduce the CPU frequency.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
Changes in v5:
 Others:
 - reduce usage of alias local variables whenever the global ones can
   still be used without affecting code readability
 - reduced usage of inline comments
 - rebased on v4.19

Changes in v4:
 Message-ID: <20180816172016.GG2960@e110439-lin>
 - ensure to always reset clamp holding on wakeup from IDLE
 Others:
 - rebased on v4.19-rc1
Changes in v3:
 Message-ID: <CAJuCfpFnj2g3+ZpR4fP4yqfxs0zd=c-Zehr2XM7m_C+WdL9jNA@mail.gmail.com>
 - rename UCLAMP_NONE into UCLAMP_NOT_VALID
Changes in v2:
 - rabased on v4.18-rc4
 - new patch to improve a specific issue
---
 kernel/sched/core.c  | 41 ++++++++++++++++++++++++++++++++++++++---
 kernel/sched/sched.h | 11 +++++++++++
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 21f6251a1d44..b23f80c07be9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -796,10 +796,11 @@ static union uclamp_map uclamp_maps[UCLAMP_CNT][UCLAMP_GROUPS];
  * For the specified clamp index, this method computes the new CPU utilization
  * clamp to use until the next change on the set of active clamp groups.
  */
-static inline void uclamp_cpu_update(struct rq *rq, unsigned int clamp_id)
+static inline void uclamp_cpu_update(struct rq *rq, unsigned int clamp_id,
+				     unsigned int last_clamp_value)
 {
 	unsigned int group_id;
-	int max_value = 0;
+	int max_value = -1;
 
 	for (group_id = 0; group_id < UCLAMP_GROUPS; ++group_id) {
 		if (!rq->uclamp.group[clamp_id][group_id].tasks)
@@ -810,6 +811,28 @@ static inline void uclamp_cpu_update(struct rq *rq, unsigned int clamp_id)
 		if (max_value >= SCHED_CAPACITY_SCALE)
 			break;
 	}
+
+	/*
+	 * Just for the UCLAMP_MAX value, in case there are no RUNNABLE
+	 * task, we want to keep the CPU clamped to the last task's clamp
+	 * value. This is to avoid frequency spikes to MAX when one CPU, with
+	 * an high blocked utilization, sleeps and another CPU, in the same
+	 * frequency domain, do not see anymore the clamp on the first CPU.
+	 *
+	 * The UCLAMP_FLAG_IDLE is set whenever we detect, from the above
+	 * loop, that there are no more RUNNABLE taks on that CPU.
+	 * In this case we enforce the CPU util_max to that of the last
+	 * dequeued task.
+	 */
+	if (max_value < 0) {
+		if (clamp_id == UCLAMP_MAX) {
+			rq->uclamp.flags |= UCLAMP_FLAG_IDLE;
+			max_value = last_clamp_value;
+		} else {
+			max_value = uclamp_none(UCLAMP_MIN);
+		}
+	}
+
 	rq->uclamp.value[clamp_id] = max_value;
 }
 
@@ -835,6 +858,18 @@ static inline void uclamp_cpu_get_id(struct task_struct *p, struct rq *rq,
 
 	rq->uclamp.group[clamp_id][group_id].tasks += 1;
 
+	if (unlikely(rq->uclamp.flags & UCLAMP_FLAG_IDLE)) {
+		/*
+		 * Reset clamp holds on idle exit.
+		 * This function is called for both UCLAMP_MIN (before) and
+		 * UCLAMP_MAX (after). Let's reset the flag only the second
+		 * once we know that UCLAMP_MIN has been already updated.
+		 */
+		if (clamp_id == UCLAMP_MAX)
+			rq->uclamp.flags &= ~UCLAMP_FLAG_IDLE;
+		rq->uclamp.value[clamp_id] = p->uclamp[clamp_id].value;
+	}
+
 	if (rq->uclamp.value[clamp_id] < p->uclamp[clamp_id].value)
 		rq->uclamp.value[clamp_id] = p->uclamp[clamp_id].value;
 }
@@ -883,7 +918,7 @@ static inline void uclamp_cpu_put_id(struct task_struct *p, struct rq *rq,
 	}
 #endif
 	if (clamp_value >= rq->uclamp.value[clamp_id])
-		uclamp_cpu_update(rq, clamp_id);
+		uclamp_cpu_update(rq, clamp_id, clamp_value);
 }
 
 /**
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 94c4f2f410ad..859192ec492c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -807,6 +807,17 @@ struct uclamp_group {
 struct uclamp_cpu {
 	struct uclamp_group group[UCLAMP_CNT][UCLAMP_GROUPS];
 	int value[UCLAMP_CNT];
+/*
+ * Idle clamp holding
+ * Whenever a CPU is idle, we enforce the util_max clamp value of the last
+ * task running on that CPU. This bit is used to flag a clamp holding
+ * currently active for a CPU. This flag is:
+ * - set when we update the clamp value of a CPU at the time of dequeuing the
+ *   last before entering idle
+ * - reset when we enqueue the first task after a CPU wakeup from IDLE
+ */
+#define UCLAMP_FLAG_IDLE 0x01
+	int flags;
 };
 #endif /* CONFIG_UCLAMP_TASK */
 
-- 
2.18.0

