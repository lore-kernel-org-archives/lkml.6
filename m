Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677CDC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62BE20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D62BE20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbeJBMwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 08:52:55 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:34974 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbeJBMwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 08:52:54 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 58882B1473A56CFFDBFC;
        Tue,  2 Oct 2018 14:11:21 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w926BHAO022016;
        Tue, 2 Oct 2018 14:11:17 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018100214113073-2349048 ;
          Tue, 2 Oct 2018 14:11:30 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  sched/rt : return accurate release rq lock info
Date:   Tue, 2 Oct 2018 22:23:41 +0800
Message-Id: <1538490221-18028-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-10-02 14:11:30,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-10-02 14:11:13,
        Serialize complete at 2018-10-02 14:11:13
X-MAIL: mse01.zte.com.cn w926BHAO022016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_lock_lowest_rq may or not releease rq lock, but it is fuzzy.
If not releasing rq lock, it is unnecessary to re-call
pick_next_oushable_task.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 kernel/sched/rt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 2e2955a..4d7d322 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1719,6 +1719,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 {
 	struct rq *lowest_rq = NULL;
 	int tries;
+	bool release_lock = false;
 	int cpu;
 
 	for (tries = 0; tries < RT_MAX_TRIES; tries++) {
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
 
+	if (!lowest_rq && !release_lock)
+		lowest_rq = (void *) -1;
 	return lowest_rq;
 }
 
@@ -1863,6 +1867,9 @@ static int push_rt_task(struct rq *rq)
 		goto retry;
 	}
 
+	if (lowest_rq == (void *) -1)
+		goto out;
+
 	deactivate_task(rq, next_task, 0);
 	set_task_cpu(next_task, lowest_rq->cpu);
 	activate_task(lowest_rq, next_task, 0);
-- 
1.8.3.1

