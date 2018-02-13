Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934683AbeBML3J (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 06:29:09 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54629 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934532AbeBML3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 06:29:06 -0500
Date: Tue, 13 Feb 2018 03:28:45 -0800
From: tip-bot for Wen Yang <tipbot@zytor.com>
Message-ID: <tip-a7711602c7b79950ea437178f601b52ab08ef659@git.kernel.org>
Cc: jiang.biao2@zte.com.cn, hpa@zytor.com, wen.yang99@zte.com.cn,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, jiang.biao2@zte.com.cn, torvalds@linux-foundation.org,
        tglx@linutronix.de, wen.yang99@zte.com.cn,
        linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
In-Reply-To: <1517882008-44552-1-git-send-email-wen.yang99@zte.com.cn>
References: <1517882008-44552-1-git-send-email-wen.yang99@zte.com.cn>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/rt: Make update_curr_rt() more accurate
Git-Commit-ID: a7711602c7b79950ea437178f601b52ab08ef659
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

Commit-ID:  a7711602c7b79950ea437178f601b52ab08ef659
Gitweb:     https://git.kernel.org/tip/a7711602c7b79950ea437178f601b52ab08ef659
Author:     Wen Yang <wen.yang99@zte.com.cn>
AuthorDate: Tue, 6 Feb 2018 09:53:28 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 11:44:41 +0100

sched/rt: Make update_curr_rt() more accurate

rq->clock_task may be updated between the two calls of
rq_clock_task() in update_curr_rt(). Calling rq_clock_task() only
once makes it more accurate and efficient, taking update_curr() as
reference.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: zhong.weidong@zte.com.cn
Link: http://lkml.kernel.org/r/1517882008-44552-1-git-send-email-wen.yang99@zte.com.cn
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/rt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 663b235..aad49451 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -950,12 +950,13 @@ static void update_curr_rt(struct rq *rq)
 {
 	struct task_struct *curr = rq->curr;
 	struct sched_rt_entity *rt_se = &curr->rt;
-	u64 now = rq_clock_task(rq);
 	u64 delta_exec;
+	u64 now;
 
 	if (curr->sched_class != &rt_sched_class)
 		return;
 
+	now = rq_clock_task(rq);
 	delta_exec = now - curr->se.exec_start;
 	if (unlikely((s64)delta_exec <= 0))
 		return;
