Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA74C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E504B2089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E504B2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbeJBQuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:50:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34805 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeJBQuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:50:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w92A7NNl1915766
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 03:07:23 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w92A7Nxb1915763;
        Tue, 2 Oct 2018 03:07:23 -0700
Date:   Tue, 2 Oct 2018 03:07:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dietmar Eggemann <tipbot@zytor.com>
Message-ID: <tip-4a465e3ebbc8004ce4f7f08f6022ee8315a94edf@git.kernel.org>
Cc:     joelaf@google.com, patrick.bellasi@arm.com,
        dietmar.eggemann@arm.com, mingo@kernel.org, hpa@zytor.com,
        quentin.perret@arm.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, morten.rasmussen@arm.com,
        torvalds@linux-foundation.org
Reply-To: hpa@zytor.com, joelaf@google.com, mingo@kernel.org,
          dietmar.eggemann@arm.com, patrick.bellasi@arm.com,
          tglx@linutronix.de, peterz@infradead.org,
          torvalds@linux-foundation.org, morten.rasmussen@arm.com,
          vincent.guittot@linaro.org, quentin.perret@arm.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180803140538.1178-1-dietmar.eggemann@arm.com>
References: <20180803140538.1178-1-dietmar.eggemann@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Remove setting task's
 se->runnable_weight during PELT update
Git-Commit-ID: 4a465e3ebbc8004ce4f7f08f6022ee8315a94edf
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4a465e3ebbc8004ce4f7f08f6022ee8315a94edf
Gitweb:     https://git.kernel.org/tip/4a465e3ebbc8004ce4f7f08f6022ee8315a94edf
Author:     Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate: Fri, 3 Aug 2018 15:05:38 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 2 Oct 2018 09:45:03 +0200

sched/fair: Remove setting task's se->runnable_weight during PELT update

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: http://lkml.kernel.org/r/20180803140538.1178-1-dietmar.eggemann@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 2 ++
 kernel/sched/pelt.c | 6 ------
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f2caf1bae4a3..56b3c1781276 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -700,6 +700,7 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 	if (idle_policy(p->policy)) {
 		load->weight = scale_load(WEIGHT_IDLEPRIO);
 		load->inv_weight = WMULT_IDLEPRIO;
+		p->se.runnable_weight = load->weight;
 		return;
 	}
 
@@ -712,6 +713,7 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 	} else {
 		load->weight = scale_load(sched_prio_to_weight[prio]);
 		load->inv_weight = sched_prio_to_wmult[prio];
+		p->se.runnable_weight = load->weight;
 	}
 }
 
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 48a126486435..90fb5bc12ad4 100644
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
 
