Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1667C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653EA2148C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653EA2148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732730AbeIXSZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:25:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56692 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732124AbeIXSZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:25:28 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 87911107E;
        Mon, 24 Sep 2018 12:23:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quentin Perret <quentin.perret@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, patrick.bellasi@arm.com,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 137/173] sched/fair: Fix util_avg of new tasks for asymmetric systems
Date:   Mon, 24 Sep 2018 13:52:51 +0200
Message-Id: <20180924113125.732139449@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quentin Perret <quentin.perret@arm.com>

[ Upstream commit 8fe5c5a937d0f4e84221631833a2718afde52285 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/fair.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -757,11 +757,12 @@ static void attach_entity_cfs_rq(struct
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
@@ -773,7 +774,8 @@ void post_init_entity_util_avg(struct sc
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 	struct sched_avg *sa = &se->avg;
-	long cap = (long)(SCHED_CAPACITY_SCALE - cfs_rq->avg.util_avg) / 2;
+	long cpu_scale = arch_scale_cpu_capacity(NULL, cpu_of(rq_of(cfs_rq)));
+	long cap = (long)(cpu_scale - cfs_rq->avg.util_avg) / 2;
 
 	if (cap > 0) {
 		if (cfs_rq->avg.util_avg != 0) {


