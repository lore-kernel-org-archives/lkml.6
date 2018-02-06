Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbeBFB4J (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 20:56:09 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:54096 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752069AbeBFB4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 20:56:01 -0500
From: Wen Yang <wen.yang99@zte.com.cn>
To: mingo@redhat.com, peterz@infradead.org
Cc: linux-kernel@vger.kernel.org, jiang.biao2@zte.com.cn,
        zhong.weidong@zte.com.cn, wen.yang99@zte.com.cn
Subject: [PATCH v2] sched/rt: Make update_curr_rt() more accurate
Date: Tue, 6 Feb 2018 09:53:28 +0800
Message-Id: <1517882008-44552-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-02-06 09:55:56,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-02-06 09:55:49,
        Serialize complete at 2018-02-06 09:55:49
X-MAIL: mse01.zte.com.cn w161trV6038871
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rq->clock_task may be updated between the two calls of
rq_clock_task() in update_curr_rt(). Calling rq_clock_task() only
once makes it more accurate and efficient, taking update_curr() as
reference.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 kernel/sched/rt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 665ace2..fc527b1 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -951,11 +951,13 @@ static void update_curr_rt(struct rq *rq)
 	struct task_struct *curr = rq->curr;
 	struct sched_rt_entity *rt_se = &curr->rt;
 	u64 delta_exec;
+	u64 now;
 
 	if (curr->sched_class != &rt_sched_class)
 		return;
 
-	delta_exec = rq_clock_task(rq) - curr->se.exec_start;
+	now = rq_clock_task(rq);
+	delta_exec = now - curr->se.exec_start;
 	if (unlikely((s64)delta_exec <= 0))
 		return;
 
@@ -968,7 +970,7 @@ static void update_curr_rt(struct rq *rq)
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
 
-	curr->se.exec_start = rq_clock_task(rq);
+	curr->se.exec_start = now;
 	cgroup_account_cputime(curr, delta_exec);
 
 	sched_rt_avg_update(rq, delta_exec);
-- 
1.8.3.1
