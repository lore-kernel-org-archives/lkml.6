Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46182C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035DD20852
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035DD20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933835AbeGIQsJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:48:09 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35022 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933277AbeGIQsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:48:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33FC67A9;
        Mon,  9 Jul 2018 09:48:06 -0700 (PDT)
Received: from e107985-lin.cambridge.arm.com (e107985-lin.cambridge.arm.com [10.1.210.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AF7473F589;
        Mon,  9 Jul 2018 09:48:04 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Remove setting task's se->runnable_weight during PELT update
Date:   Mon,  9 Jul 2018 17:47:53 +0100
Message-Id: <20180709164753.24699-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A CFS (SCHED_OTHER, SCHED_BATCH or SCHED_IDLE policy) task's
se->runnable_weight must always be in sync with its se->load.weight.

se->runnable_weight is set to se->load.weight when the task is
forked (init_entity_runnable_average()) or reniced (reweight_entity()).

There are two cases in set_load_weight() which since they currently only
set se->load.weight could lead to a situation in which se->load.weight
is different to se->runnable_weight for a CFS task:

(1) A task switches to SCHED_IDLE.

(2) A SCHED_FIFO, SCHED_RR or SCHED_DEADLINE task which has been reniced
    (during which only its static priority gets set) switches to
    SCHED_OTHER or SCHED_BATCH.

Set se->runnable_weight to se->load.weight in these two cases to prevent
this. This eliminates the need to explicitly set it to se->load.weight
during PELT updates in the CFS scheduler fastpath.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/core.c | 2 ++
 kernel/sched/fair.c | 6 ------
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fe365c9a08e9..4eaf6166a293 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -724,6 +724,7 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 	if (idle_policy(p->policy)) {
 		load->weight = scale_load(WEIGHT_IDLEPRIO);
 		load->inv_weight = WMULT_IDLEPRIO;
+		p->se.runnable_weight = load->weight;
 		return;
 	}
 
@@ -736,6 +737,7 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 	} else {
 		load->weight = scale_load(sched_prio_to_weight[prio]);
 		load->inv_weight = sched_prio_to_wmult[prio];
+		p->se.runnable_weight = load->weight;
 	}
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 321cd5dcf2e8..8c09c4974edf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3327,9 +3327,6 @@ static inline void cfs_se_util_change(struct sched_avg *avg)
 static int
 __update_load_avg_blocked_se(u64 now, int cpu, struct sched_entity *se)
 {
-	if (entity_is_task(se))
-		se->runnable_weight = se->load.weight;
-
 	if (___update_load_sum(now, cpu, &se->avg, 0, 0, 0)) {
 		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
 		return 1;
@@ -3341,9 +3338,6 @@ __update_load_avg_blocked_se(u64 now, int cpu, struct sched_entity *se)
 static int
 __update_load_avg_se(u64 now, int cpu, struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	if (entity_is_task(se))
-		se->runnable_weight = se->load.weight;
-
 	if (___update_load_sum(now, cpu, &se->avg, !!se->on_rq, !!se->on_rq,
 				cfs_rq->curr == se)) {
 
-- 
2.11.0

