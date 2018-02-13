Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934237AbeBML2k (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 06:28:40 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52519 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933926AbeBML2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 06:28:38 -0500
Date: Tue, 13 Feb 2018 03:28:13 -0800
From: tip-bot for Wen Yang <tipbot@zytor.com>
Message-ID: <tip-6fe0ce1eb04f99a1eb1eb6e7f775666966cf6c80@git.kernel.org>
Cc: mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
        tglx@linutronix.de, jiang.biao2@zte.com.cn,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        wen.yang99@zte.com.cn
Reply-To: peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org, wen.yang99@zte.com.cn, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, jiang.biao2@zte.com.cn
In-Reply-To: <1517882148-44599-1-git-send-email-wen.yang99@zte.com.cn>
References: <1517882148-44599-1-git-send-email-wen.yang99@zte.com.cn>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/deadline: Make update_curr_dl() more
 accurate
Git-Commit-ID: 6fe0ce1eb04f99a1eb1eb6e7f775666966cf6c80
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6fe0ce1eb04f99a1eb1eb6e7f775666966cf6c80
Gitweb:     https://git.kernel.org/tip/6fe0ce1eb04f99a1eb1eb6e7f775666966cf6c80
Author:     Wen Yang <wen.yang99@zte.com.cn>
AuthorDate: Tue, 6 Feb 2018 09:55:48 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 11:44:40 +0100

sched/deadline: Make update_curr_dl() more accurate

rq->clock_task may be updated between the two calls of
rq_clock_task() in update_curr_dl(). Calling rq_clock_task() only
once makes it more accurate and efficient, taking update_curr() as
reference.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: zhong.weidong@zte.com.cn
Link: http://lkml.kernel.org/r/1517882148-44599-1-git-send-email-wen.yang99@zte.com.cn
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/deadline.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 9bb0e0c..9df0978 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1153,6 +1153,7 @@ static void update_curr_dl(struct rq *rq)
 	struct sched_dl_entity *dl_se = &curr->dl;
 	u64 delta_exec, scaled_delta_exec;
 	int cpu = cpu_of(rq);
+	u64 now;
 
 	if (!dl_task(curr) || !on_dl_rq(dl_se))
 		return;
@@ -1165,7 +1166,8 @@ static void update_curr_dl(struct rq *rq)
 	 * natural solution, but the full ramifications of this
 	 * approach need further study.
 	 */
-	delta_exec = rq_clock_task(rq) - curr->se.exec_start;
+	now = rq_clock_task(rq);
+	delta_exec = now - curr->se.exec_start;
 	if (unlikely((s64)delta_exec <= 0)) {
 		if (unlikely(dl_se->dl_yielded))
 			goto throttle;
@@ -1178,7 +1180,7 @@ static void update_curr_dl(struct rq *rq)
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
 
-	curr->se.exec_start = rq_clock_task(rq);
+	curr->se.exec_start = now;
 	cgroup_account_cputime(curr, delta_exec);
 
 	sched_rt_avg_update(rq, delta_exec);
