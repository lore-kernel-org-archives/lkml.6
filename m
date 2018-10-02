Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F90C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEB02064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEB02064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeJBSsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:48:52 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:36592 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbeJBSsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:48:52 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id B21A31CEC4EE23750FCF;
        Tue,  2 Oct 2018 20:05:50 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w92C4xuE064226;
        Tue, 2 Oct 2018 20:04:59 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018100220051599-2372915 ;
          Tue, 2 Oct 2018 20:05:15 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH v2]  sched/rt : return accurate release rq lock info
Date:   Wed, 3 Oct 2018 04:17:22 +0800
Message-Id: <1538511442-20182-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-10-02 20:05:16,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-10-02 20:04:55,
        Serialize complete at 2018-10-02 20:04:55
X-MAIL: mse01.zte.com.cn w92C4xuE064226
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_lock_lowest_rq may or not releease rq lock, but it is fuzzy.
If not releasing rq lock, it is unnecessary to re-call
pick_next_pushable_task.
When CONFIG_PREEMPT=n, not releasing rq lock frequently happens
in a simple test case:
Four different rt priority tasks run on limited two cpus.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 kernel/sched/rt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 2e2955a..7c5382a 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1718,6 +1718,7 @@ static int find_lowest_rq(struct task_struct *task)
 static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 {
 	struct rq *lowest_rq = NULL;
+	bool release_lock = false;
 	int tries;
 	int cpu;
 
@@ -1741,6 +1742,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 
 		/* if the prio of this runqueue changed, try again */
 		if (double_lock_balance(rq, lowest_rq)) {
+			release_lock = true;
 			/*
 			 * We had to unlock the run queue. In
 			 * the mean time, task could have
@@ -1768,6 +1770,8 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 		lowest_rq = NULL;
 	}
 
+	if (!lowest_rq && release_lock)
+		lowest_rq = RETRY_TASK;
 	return lowest_rq;
 }
 
@@ -1830,7 +1834,7 @@ static int push_rt_task(struct rq *rq)
 
 	/* find_lock_lowest_rq locks the rq if found */
 	lowest_rq = find_lock_lowest_rq(next_task, rq);
-	if (!lowest_rq) {
+	if (lowest_rq == RETRY_TASK) {
 		struct task_struct *task;
 		/*
 		 * find_lock_lowest_rq releases rq->lock
@@ -1863,6 +1867,8 @@ static int push_rt_task(struct rq *rq)
 		goto retry;
 	}
 
+	if (!lowest_rq)
+		goto out;
 	deactivate_task(rq, next_task, 0);
 	set_task_cpu(next_task, lowest_rq->cpu);
 	activate_task(lowest_rq, next_task, 0);
-- 
1.8.3.1

