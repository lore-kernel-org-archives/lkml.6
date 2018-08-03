Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5885BC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B0521709
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B0521709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbeHCQCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:02:19 -0400
Received: from foss.arm.com ([217.140.101.70]:43314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731699AbeHCQCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:02:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C29F980D;
        Fri,  3 Aug 2018 07:05:49 -0700 (PDT)
Received: from e107985-lin.Emea.Arm.com (e107985-lin.emea.arm.com [10.4.12.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 497FC3F2EA;
        Fri,  3 Aug 2018 07:05:48 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched/fair: Remove setting task's se->runnable_weight during PELT update
Date:   Fri,  3 Aug 2018 15:05:38 +0100
Message-Id: <20180803140538.1178-1-dietmar.eggemann@arm.com>
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

Changes v1->v2:
- Rebased on latest tip/sched/core

This patch has been tested w/ appropriate BUG_ON()'s in
__update_load_avg_blocked_se() and __update_load_avg_se() on an Ubuntu
18.04 desktop.

 kernel/sched/core.c | 2 ++
 kernel/sched/pelt.c | 6 ------
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index deafa9fe602b..2a08418db3d1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -701,6 +701,7 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 	if (idle_policy(p->policy)) {
 		load->weight = scale_load(WEIGHT_IDLEPRIO);
 		load->inv_weight = WMULT_IDLEPRIO;
+		p->se.runnable_weight = load->weight;
 		return;
 	}
 
@@ -713,6 +714,7 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 	} else {
 		load->weight = scale_load(sched_prio_to_weight[prio]);
 		load->inv_weight = sched_prio_to_wmult[prio];
+		p->se.runnable_weight = load->weight;
 	}
 }
 
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 35475c0c5419..d0016b16d23a 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -269,9 +269,6 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load, unsigned long runna
 
 int __update_load_avg_blocked_se(u64 now, int cpu, struct sched_entity *se)
 {
-	if (entity_is_task(se))
-		se->runnable_weight = se->load.weight;
-
 	if (___update_load_sum(now, cpu, &se->avg, 0, 0, 0)) {
 		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
 		return 1;
@@ -282,9 +279,6 @@ int __update_load_avg_blocked_se(u64 now, int cpu, struct sched_entity *se)
 
 int __update_load_avg_se(u64 now, int cpu, struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	if (entity_is_task(se))
-		se->runnable_weight = se->load.weight;
-
 	if (___update_load_sum(now, cpu, &se->avg, !!se->on_rq, !!se->on_rq,
 				cfs_rq->curr == se)) {
 
-- 
2.11.0

