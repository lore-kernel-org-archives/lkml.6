Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD8AC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB842083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB842083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbeJOTQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:16:05 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:50178 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbeJOTQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:16:05 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 2D82D706C860288A0DE8;
        Mon, 15 Oct 2018 19:31:12 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w9FBV7SS011179;
        Mon, 15 Oct 2018 19:31:07 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018101519311529-4615329 ;
          Mon, 15 Oct 2018 19:31:15 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     rostedt@goodmis.org, andrea.parri@amarulasolutions.com,
        linux-kernel@vger.kernel.org, juri.lelli@gmail.com,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH v2]  sched/dl: Reduce push_dl_task() retries
Date:   Tue, 16 Oct 2018 03:42:46 +0800
Message-Id: <1539632566-4440-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-10-15 19:31:15,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-10-15 19:31:07,
        Serialize complete at 2018-10-15 19:31:07
X-MAIL: mse01.zte.com.cn w9FBV7SS011179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve push_dl_task() by propagating the double_lock_balance()
usage from find_lock_later_rq(), thereby reducing the number
of cases where we have to assume rq->lock was dropped.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 kernel/sched/deadline.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 997ea7b..8e875ec 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1979,7 +1979,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 				     !dl_task(task) ||
 				     !task_on_rq_queued(task))) {
 				double_unlock_balance(rq, later_rq);
-				later_rq = NULL;
+				later_rq = RETRY_TASK;
 				break;
 			}
 		}
@@ -2063,7 +2063,9 @@ static int push_dl_task(struct rq *rq)
 
 	/* Will lock the rq it'll find */
 	later_rq = find_lock_later_rq(next_task, rq);
-	if (!later_rq) {
+	if (!later_rq)
+		goto out;
+	if (later_rq == RETRY_TASK) {
 		struct task_struct *task;
 
 		/*
-- 
1.8.3.1

