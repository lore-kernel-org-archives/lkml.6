Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeBFB5x (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 20:57:53 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:55362 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752154AbeBFB5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 20:57:45 -0500
From: Wen Yang <wen.yang99@zte.com.cn>
To: mingo@redhat.com, peterz@infradead.org
Cc: linux-kernel@vger.kernel.org, jiang.biao2@zte.com.cn,
        zhong.weidong@zte.com.cn, wen.yang99@zte.com.cn
Subject: [PATCH] sched/deadline: Make update_curr_dl() more accurate
Date: Tue, 6 Feb 2018 09:55:48 +0800
Message-Id: <1517882148-44599-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-02-06 09:57:40,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-02-06 09:57:34,
        Serialize complete at 2018-02-06 09:57:34
X-MAIL: mse01.zte.com.cn w161vbjo040602
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rq->clock_task may be updated between the two calls of
rq_clock_task() in update_curr_dl(). Calling rq_clock_task() only
once makes it more accurate and efficient, taking update_curr() as
reference.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/deadline.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 2473736..a32209c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1115,6 +1115,7 @@ static void update_curr_dl(struct rq *rq)
 	struct task_struct *curr = rq->curr;
 	struct sched_dl_entity *dl_se = &curr->dl;
 	u64 delta_exec;
+	u64 now;
 
 	if (!dl_task(curr) || !on_dl_rq(dl_se))
 		return;
@@ -1127,7 +1128,8 @@ static void update_curr_dl(struct rq *rq)
 	 * natural solution, but the full ramifications of this
 	 * approach need further study.
 	 */
-	delta_exec = rq_clock_task(rq) - curr->se.exec_start;
+	now = rq_clock_task(rq);
+	delta_exec = now - curr->se.exec_start;
 	if (unlikely((s64)delta_exec <= 0)) {
 		if (unlikely(dl_se->dl_yielded))
 			goto throttle;
@@ -1143,7 +1145,7 @@ static void update_curr_dl(struct rq *rq)
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
 
-	curr->se.exec_start = rq_clock_task(rq);
+	curr->se.exec_start = now;
 	cgroup_account_cputime(curr, delta_exec);
 
 	sched_rt_avg_update(rq, delta_exec);
-- 
1.8.3.1
