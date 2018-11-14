Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9290C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644A4223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjDb3yf7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 644A4223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732735AbeKNMsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:48:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:52122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732676AbeKNMsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:48:10 -0500
Received: from lerouge.suse.de (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8524223D0;
        Wed, 14 Nov 2018 02:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542163619;
        bh=ENrcZhmsMVQDi9ySvQSsNNr3R66GjHdcjIwA5sMdjlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DjDb3yf7lcj/74F/YxKPSm5csgu93IDotVrBVm7L2RRyYOX03HvCYii9b5L+tzYIm
         wApIhlNNTEXcxbPJBYdZWvH52z13/c5w3kNQeADTt98PpKkAVS4VkW7lKI/UpLQZ07
         UleVBzmQr+9392OhkfoHZOilvrc3MxV2y9iA8HlM=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: [PATCH 19/25] sched/vite: Handle nice updates under vtime
Date:   Wed, 14 Nov 2018 03:46:03 +0100
Message-Id: <1542163569-20047-20-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542163569-20047-1-git-send-email-frederic@kernel.org>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the vtime level, nice updates are currently handled on context
switches. When a task's nice value gets updated while it is sleeping,
the context switch takes into account the new nice value in order to
later record the vtime delta to the appropriate kcpustat index.

We have yet to handle live updates: when set_user_nice() is called
while the target is running. We'll handle that on two sides:

* If the caller of set_user_nice() is the current task, we update the
  vtime state in place.

* If the target runs on a different CPU, we interrupt it with an IPI to
  update the vtime state in place.

The vtime update in question consists in flushing the pending vtime
delta to the task/kcpustat and resume the accounting on top of the new
nice value.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/vtime.h  |  2 ++
 kernel/sched/core.c    |  4 ++++
 kernel/sched/cputime.c | 41 ++++++++++++++++++++++++++++++++++-------
 kernel/sched/sched.h   | 39 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 7 deletions(-)

diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index a53f6ea..b4566d5 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -85,6 +85,8 @@ extern void vtime_guest_enter(struct task_struct *tsk);
 extern void vtime_guest_exit(struct task_struct *tsk);
 extern void vtime_init_idle(struct task_struct *tsk, int cpu);
 extern void vtime_exit_task(struct task_struct *tsk);
+extern void vtime_set_nice_local(struct task_struct *tsk);
+extern void vtime_set_nice_remote(int cpu);
 #else /* !CONFIG_VIRT_CPU_ACCOUNTING_GEN  */
 static inline void vtime_user_enter(struct task_struct *tsk) { }
 static inline void vtime_user_exit(struct task_struct *tsk) { }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f12225f..e8f0437 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3868,6 +3868,7 @@ void set_user_nice(struct task_struct *p, long nice)
 	int old_prio, delta;
 	struct rq_flags rf;
 	struct rq *rq;
+	long old_nice;
 
 	if (task_nice(p) == nice || nice < MIN_NICE || nice > MAX_NICE)
 		return;
@@ -3878,6 +3879,8 @@ void set_user_nice(struct task_struct *p, long nice)
 	rq = task_rq_lock(p, &rf);
 	update_rq_clock(rq);
 
+	old_nice = task_nice(p);
+
 	/*
 	 * The RT priorities are set via sched_setscheduler(), but we still
 	 * allow the 'normal' nice value to be set - but as expected
@@ -3913,6 +3916,7 @@ void set_user_nice(struct task_struct *p, long nice)
 	if (running)
 		set_curr_task(rq, p);
 out_unlock:
+	vtime_set_nice(rq, p, old_nice);
 	task_rq_unlock(rq, p, &rf);
 }
 EXPORT_SYMBOL(set_user_nice);
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 07c2e7f..2b35132 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -733,13 +733,13 @@ static void vtime_account_system(struct task_struct *tsk,
 }
 
 static void vtime_account_guest(struct task_struct *tsk,
-				struct vtime *vtime)
+				struct vtime *vtime, bool force)
 {
 	enum cpu_usage_stat index;
 
 	vtime->gtime += get_vtime_delta(vtime);
 
-	if (vtime->gtime < TICK_NSEC)
+	if (vtime->gtime < TICK_NSEC && !force)
 		return;
 
 	if (vtime->nice)
@@ -752,13 +752,13 @@ static void vtime_account_guest(struct task_struct *tsk,
 }
 
 static void vtime_account_user(struct task_struct *tsk,
-			       struct vtime *vtime)
+			       struct vtime *vtime, bool force)
 {
 	enum cpu_usage_stat index;
 
 	vtime->utime += get_vtime_delta(vtime);
 
-	if (vtime->utime < TICK_NSEC)
+	if (vtime->utime < TICK_NSEC && !force)
 		return;
 
 	if (vtime->nice)
@@ -776,7 +776,7 @@ static void __vtime_account_kernel(struct task_struct *tsk,
 {
 	/* We might have scheduled out from guest path */
 	if (vtime->state == VTIME_GUEST)
-		vtime_account_guest(tsk, vtime);
+		vtime_account_guest(tsk, vtime, false);
 	else
 		vtime_account_system(tsk, vtime);
 }
@@ -808,7 +808,7 @@ void vtime_user_exit(struct task_struct *tsk)
 	struct vtime *vtime = &tsk->vtime;
 
 	write_seqcount_begin(&vtime->seqcount);
-	vtime_account_user(tsk, vtime);
+	vtime_account_user(tsk, vtime, false);
 	vtime->state = VTIME_SYS;
 	write_seqcount_end(&vtime->seqcount);
 }
@@ -836,7 +836,7 @@ void vtime_guest_exit(struct task_struct *tsk)
 	struct vtime *vtime = &tsk->vtime;
 
 	write_seqcount_begin(&vtime->seqcount);
-	vtime_account_guest(tsk, vtime);
+	vtime_account_guest(tsk, vtime, false);
 	tsk->flags &= ~PF_VCPU;
 	vtime->state = VTIME_SYS;
 	write_seqcount_end(&vtime->seqcount);
@@ -937,6 +937,33 @@ void vtime_exit_task(struct task_struct *t)
 	local_irq_restore(flags);
 }
 
+void vtime_set_nice_local(struct task_struct *t)
+{
+	struct vtime *vtime = &t->vtime;
+
+	write_seqcount_begin(&vtime->seqcount);
+	if (vtime->state == VTIME_USER)
+		vtime_account_user(t, vtime, true);
+	else if (vtime->state == VTIME_GUEST)
+		vtime_account_guest(t, vtime, true);
+	vtime->nice = (task_nice(t) > 0) ? 1 : 0;
+	write_seqcount_end(&vtime->seqcount);
+}
+
+static void vtime_set_nice_func(struct irq_work *work)
+{
+	vtime_set_nice_local(current);
+}
+
+static DEFINE_PER_CPU(struct irq_work, vtime_set_nice_work) = {
+	.func = vtime_set_nice_func,
+};
+
+void vtime_set_nice_remote(int cpu)
+{
+	irq_work_queue_on(&per_cpu(vtime_set_nice_work, cpu), cpu);
+}
+
 u64 task_gtime(struct task_struct *t)
 {
 	struct vtime *vtime = &t->vtime;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 618577f..c7846ca 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1790,6 +1790,45 @@ static inline int sched_tick_offload_init(void) { return 0; }
 static inline void sched_update_tick_dependency(struct rq *rq) { }
 #endif
 
+static inline void vtime_set_nice(struct rq *rq,
+				  struct task_struct *p, long old_nice)
+{
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
+	long nice;
+	int cpu;
+
+	if (!vtime_accounting_enabled())
+		return;
+
+	cpu = cpu_of(rq);
+
+	if (!vtime_accounting_enabled_cpu(cpu))
+		return;
+
+	/*
+	 * Task not running, nice update will be seen by vtime on its
+	 * next context switch.
+	 */
+	if (!task_current(rq, p))
+		return;
+
+	nice = task_nice(p);
+
+	/* Task stays nice, still accounted as nice in kcpustat */
+	if (old_nice > 0 && nice > 0)
+		return;
+
+	/* Task stays rude, still accounted as non-nice in kcpustat */
+	if (old_nice <= 0 && nice <= 0)
+		return;
+
+	if (p == current)
+		vtime_set_nice_local(p);
+	else
+		vtime_set_nice_remote(cpu);
+#endif
+}
+
 static inline void add_nr_running(struct rq *rq, unsigned count)
 {
 	unsigned prev_nr = rq->nr_running;
-- 
2.7.4

