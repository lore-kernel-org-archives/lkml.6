Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752985AbeBFL6o (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 06:58:44 -0500
Received: from terminus.zytor.com ([65.50.211.136]:53713 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752879AbeBFL6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 06:58:35 -0500
Date: Tue, 6 Feb 2018 03:55:07 -0800
From: tip-bot for Wen Yang <tipbot@zytor.com>
Message-ID: <tip-e7ad203166fff89b1d8253faf68fbe6966bf7181@git.kernel.org>
Cc: peterz@infradead.org, efault@gmx.de, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org, jiang.biao2@zte.com.cn,
        hpa@zytor.com, torvalds@linux-foundation.org, wen.yang99@zte.com.cn
Reply-To: tglx@linutronix.de, efault@gmx.de, peterz@infradead.org,
        jiang.biao2@zte.com.cn, linux-kernel@vger.kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, wen.yang99@zte.com.cn, mingo@kernel.org
In-Reply-To: <1517800721-42092-1-git-send-email-wen.yang99@zte.com.cn>
References: <1517800721-42092-1-git-send-email-wen.yang99@zte.com.cn>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/rt: Make update_curr_rt() more accurate
Git-Commit-ID: e7ad203166fff89b1d8253faf68fbe6966bf7181
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

Commit-ID:  e7ad203166fff89b1d8253faf68fbe6966bf7181
Gitweb:     https://git.kernel.org/tip/e7ad203166fff89b1d8253faf68fbe6966bf7181
Author:     Wen Yang <wen.yang99@zte.com.cn>
AuthorDate: Mon, 5 Feb 2018 11:18:41 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 6 Feb 2018 10:20:34 +0100

sched/rt: Make update_curr_rt() more accurate

rq->clock_task may be updated between the two calls of
rq_clock_task() in update_curr_rt(). Calling rq_clock_task() only
once makes it more accurate and efficient, taking update_curr() as
reference.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: zhong.weidong@zte.com.cn
Link: http://lkml.kernel.org/r/1517800721-42092-1-git-send-email-wen.yang99@zte.com.cn
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/rt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 89a086e..663b235 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -950,12 +950,13 @@ static void update_curr_rt(struct rq *rq)
 {
 	struct task_struct *curr = rq->curr;
 	struct sched_rt_entity *rt_se = &curr->rt;
+	u64 now = rq_clock_task(rq);
 	u64 delta_exec;
 
 	if (curr->sched_class != &rt_sched_class)
 		return;
 
-	delta_exec = rq_clock_task(rq) - curr->se.exec_start;
+	delta_exec = now - curr->se.exec_start;
 	if (unlikely((s64)delta_exec <= 0))
 		return;
 
@@ -968,7 +969,7 @@ static void update_curr_rt(struct rq *rq)
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
 
-	curr->se.exec_start = rq_clock_task(rq);
+	curr->se.exec_start = now;
 	cgroup_account_cputime(curr, delta_exec);
 
 	sched_rt_avg_update(rq, delta_exec);
