Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147E6ECDFB4
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB44C208E0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB44C208E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeGOXut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 19:50:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40631 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbeGOXus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 19:50:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6FNPqCN920990
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 16:25:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6FNPqdX920987;
        Sun, 15 Jul 2018 16:25:52 -0700
Date:   Sun, 15 Jul 2018 16:25:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Quentin Perret <tipbot@zytor.com>
Message-ID: <tip-8fe5c5a937d0f4e84221631833a2718afde52285@git.kernel.org>
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, hpa@zytor.com, mingo@kernel.org,
        quentin.perret@arm.com
Reply-To: quentin.perret@arm.com, mingo@kernel.org, tglx@linutronix.de,
          torvalds@linux-foundation.org, peterz@infradead.org,
          hpa@zytor.com, vincent.guittot@linaro.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180612112215.25448-1-quentin.perret@arm.com>
References: <20180612112215.25448-1-quentin.perret@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Fix util_avg of new tasks for
 asymmetric systems
Git-Commit-ID: 8fe5c5a937d0f4e84221631833a2718afde52285
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

Commit-ID:  8fe5c5a937d0f4e84221631833a2718afde52285
Gitweb:     https://git.kernel.org/tip/8fe5c5a937d0f4e84221631833a2718afde52285
Author:     Quentin Perret <quentin.perret@arm.com>
AuthorDate: Tue, 12 Jun 2018 12:22:15 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 15 Jul 2018 23:51:20 +0200

sched/fair: Fix util_avg of new tasks for asymmetric systems

When a new task wakes-up for the first time, its initial utilization
is set to half of the spare capacity of its CPU. The current
implementation of post_init_entity_util_avg() uses SCHED_CAPACITY_SCALE
directly as a capacity reference. As a result, on a big.LITTLE system, a
new task waking up on an idle little CPU will be given ~512 of util_avg,
even if the CPU's capacity is significantly less than that.

Fix this by computing the spare capacity with arch_scale_cpu_capacity().

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dietmar.eggemann@arm.com
Cc: morten.rasmussen@arm.com
Cc: patrick.bellasi@arm.com
Link: http://lkml.kernel.org/r/20180612112215.25448-1-quentin.perret@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 321cd5dcf2e8..08b89ae34233 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -735,11 +735,12 @@ static void attach_entity_cfs_rq(struct sched_entity *se);
  * To solve this problem, we also cap the util_avg of successive tasks to
  * only 1/2 of the left utilization budget:
  *
- *   util_avg_cap = (1024 - cfs_rq->avg.util_avg) / 2^n
+ *   util_avg_cap = (cpu_scale - cfs_rq->avg.util_avg) / 2^n
  *
- * where n denotes the nth task.
+ * where n denotes the nth task and cpu_scale the CPU capacity.
  *
- * For example, a simplest series from the beginning would be like:
+ * For example, for a CPU with 1024 of capacity, a simplest series from
+ * the beginning would be like:
  *
  *  task  util_avg: 512, 256, 128,  64,  32,   16,    8, ...
  * cfs_rq util_avg: 512, 768, 896, 960, 992, 1008, 1016, ...
@@ -751,7 +752,8 @@ void post_init_entity_util_avg(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 	struct sched_avg *sa = &se->avg;
-	long cap = (long)(SCHED_CAPACITY_SCALE - cfs_rq->avg.util_avg) / 2;
+	long cpu_scale = arch_scale_cpu_capacity(NULL, cpu_of(rq_of(cfs_rq)));
+	long cap = (long)(cpu_scale - cfs_rq->avg.util_avg) / 2;
 
 	if (cap > 0) {
 		if (cfs_rq->avg.util_avg != 0) {
