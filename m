Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F62CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123132250E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVK/HKz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 123132250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732406AbeKNMrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:47:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:51680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732374AbeKNMrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:47:45 -0500
Received: from lerouge.suse.de (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CC35224E0;
        Wed, 14 Nov 2018 02:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542163594;
        bh=HmIxqJF5DXBxqVJms2vqCV1TmwuolzPSr5CZNa1ruhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QVK/HKz2Ox5k9thVVnF5cGsdSLeX+ZrZez4vHU/pS3Ps5+wtcNJugoOYowK6L1A9f
         ejVy1zyRFumT81oNaNp/PhxPc8jjxAYifjVkvaJ9jAnFs0m0I3E5m6+76lBEIPzVTa
         AU4WqbKxY6XzbCK06LJ6jYwa/AHdypW7gvgLILCg=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: [PATCH 08/25] vtime: Exit vtime before exit_notify()
Date:   Wed, 14 Nov 2018 03:45:52 +0100
Message-Id: <1542163569-20047-9-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542163569-20047-1-git-send-email-frederic@kernel.org>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to correctly implement kcpustat under nohz_full, we need to
track the task running on a given CPU and read its vtime state safely,
reliably and locklessly.

This leaves us with tracking and fetching that task under RCU. This will
be done in a further patch. Until then we need to prepare vtime for
handling that properly and close the accounting before we meet the earliest
opportunity for the RCU delayed put_task_struct() to be queued. That
point happens to be in exit_notify() in case of auto-reaping.

Therefore we need to finish the accounting right before exit_notify().
After that we shouldn't track the exiting task any further.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched.h  |  2 ++
 include/linux/vtime.h  |  2 ++
 kernel/exit.c          |  1 +
 kernel/sched/cputime.c | 56 ++++++++++++++++++++++++++++++++++++++++++--------
 4 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d458d65..27e0544 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -265,6 +265,8 @@ struct task_cputime {
 enum vtime_state {
 	/* Task is sleeping or running in a CPU with VTIME inactive: */
 	VTIME_INACTIVE = 0,
+	/* Task has passed exit_notify() */
+	VTIME_DEAD,
 	/* Task is idle */
 	VTIME_IDLE,
 	/* Task runs in kernelspace in a CPU with VTIME active: */
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index d9160ab..8350a0b 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -73,12 +73,14 @@ extern void vtime_user_exit(struct task_struct *tsk);
 extern void vtime_guest_enter(struct task_struct *tsk);
 extern void vtime_guest_exit(struct task_struct *tsk);
 extern void vtime_init_idle(struct task_struct *tsk, int cpu);
+extern void vtime_exit_task(struct task_struct *tsk);
 #else /* !CONFIG_VIRT_CPU_ACCOUNTING_GEN  */
 static inline void vtime_user_enter(struct task_struct *tsk) { }
 static inline void vtime_user_exit(struct task_struct *tsk) { }
 static inline void vtime_guest_enter(struct task_struct *tsk) { }
 static inline void vtime_guest_exit(struct task_struct *tsk) { }
 static inline void vtime_init_idle(struct task_struct *tsk, int cpu) { }
+static inline void vtime_exit_task(struct task_struct *tsk) { }
 #endif
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
diff --git a/kernel/exit.c b/kernel/exit.c
index 0e21e6d..cae3fe9 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -883,6 +883,7 @@ void __noreturn do_exit(long code)
 	 */
 	flush_ptrace_hw_breakpoint(tsk);
 
+	vtime_exit_task(tsk);
 	exit_tasks_rcu_start();
 	exit_notify(tsk, group_dead);
 	proc_exit_connector(tsk);
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index f64afd7..a0c3a82 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -702,7 +702,7 @@ static u64 get_vtime_delta(struct vtime *vtime)
 	 * errors from causing elapsed vtime to go negative.
 	 */
 	other = account_other_time(delta);
-	WARN_ON_ONCE(vtime->state == VTIME_INACTIVE);
+	WARN_ON_ONCE(vtime->state < VTIME_IDLE);
 	vtime->starttime += delta;
 
 	return delta - other;
@@ -813,17 +813,31 @@ void vtime_task_switch_generic(struct task_struct *prev)
 {
 	struct vtime *vtime = &prev->vtime;
 
-	write_seqcount_begin(&vtime->seqcount);
-	if (vtime->state == VTIME_IDLE)
-		vtime_account_idle(prev);
-	else
-		__vtime_account_kernel(prev, vtime);
-	vtime->state = VTIME_INACTIVE;
-	vtime->cpu = -1;
-	write_seqcount_end(&vtime->seqcount);
+	/*
+	 * Flush the prev task vtime, unless it has passed
+	 * vtime_exit_task(), in which case there is nothing
+	 * left to account.
+	 */
+	if (vtime->state != VTIME_DEAD) {
+		write_seqcount_begin(&vtime->seqcount);
+		if (vtime->state == VTIME_IDLE)
+			vtime_account_idle(prev);
+		else
+			__vtime_account_kernel(prev, vtime);
+		vtime->state = VTIME_INACTIVE;
+		vtime->cpu = -1;
+		write_seqcount_end(&vtime->seqcount);
+	}
 
 	vtime = &current->vtime;
 
+	/*
+	 * Ignore the next task if it has been preempted after
+	 * vtime_exit_task().
+	 */
+	if (vtime->state == VTIME_DEAD)
+		return;
+
 	write_seqcount_begin(&vtime->seqcount);
 	if (is_idle_task(current))
 		vtime->state = VTIME_IDLE;
@@ -850,6 +864,30 @@ void vtime_init_idle(struct task_struct *t, int cpu)
 	local_irq_restore(flags);
 }
 
+/*
+ * This is the final settlement point after which we don't account
+ * anymore vtime for this task.
+ */
+void vtime_exit_task(struct task_struct *t)
+{
+	struct vtime *vtime = &t->vtime;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	write_seqcount_begin(&vtime->seqcount);
+	/*
+	 * A task that has never run on a nohz_full CPU hasn't
+	 * been tracked by vtime. Thus it's in VTIME_INACTIVE
+	 * state. Nothing to account for it.
+	 */
+	if (vtime->state != VTIME_INACTIVE)
+		vtime_account_system(t, vtime);
+	vtime->state = VTIME_DEAD;
+	vtime->cpu = -1;
+	write_seqcount_end(&vtime->seqcount);
+	local_irq_restore(flags);
+}
+
 u64 task_gtime(struct task_struct *t)
 {
 	struct vtime *vtime = &t->vtime;
-- 
2.7.4

