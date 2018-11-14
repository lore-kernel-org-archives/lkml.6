Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EBEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7312245E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vm3GPyQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7312245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732277AbeKNMrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:47:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:51478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731854AbeKNMrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:47:36 -0500
Received: from lerouge.suse.de (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0303E223D0;
        Wed, 14 Nov 2018 02:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542163585;
        bh=v5msp+DUb69LlfFunLACXvdO361KldPqGddyHBFDw+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vm3GPyQggAGjelUbi4oFt6zp7C+f8khheSiI0J3tpaOwAwwH71bIuMDJc8poN4pTu
         JYthr9Zv8/D2J0x9++TtXRXSmunlAQoetGtV0+oY+I4ubwca7V+EfhEHS1ObtlMSPB
         ES/Bzzoaumf5MiwQRsxP8a9o+F/0Wj3hQFX66+SQ=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: [PATCH 04/25] vtime: Spare a seqcount lock/unlock cycle on context switch
Date:   Wed, 14 Nov 2018 03:45:48 +0100
Message-Id: <1542163569-20047-5-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542163569-20047-1-git-send-email-frederic@kernel.org>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On context switch we are locking the vtime seqcount of the scheduling-out
task twice:

 * On vtime_task_switch_common(), when we flush the pending vtime through
   vtime_account_system() / vtime_account_idle()

 * On arch_vtime_task_switch() to reset the vtime state.

This is pointless as these actions can be performed without the need
to unlock/lock in the middle. The reason these steps are separated is to
consolidate a very small amount of common code between
CONFIG_VIRT_CPU_ACCOUNTING_GEN and CONFIG_VIRT_CPU_ACCOUNTING_NATIVE.

Performance in this fast path is definetly a priority over artificial
code factorization so split the task switch code between GEN and
NATIVE and mutualize the parts than can run under a single seqcount
locked block.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/vtime.h  | 32 ++++++++++++++++----------------
 kernel/sched/cputime.c | 38 +++++++++++++++++++++-----------------
 2 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 2fd247f..d9160ab 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -14,8 +14,12 @@ struct task_struct;
  * vtime_accounting_cpu_enabled() definitions/declarations
  */
 #if defined(CONFIG_VIRT_CPU_ACCOUNTING_NATIVE)
+
 static inline bool vtime_accounting_cpu_enabled(void) { return true; }
+extern void vtime_task_switch(struct task_struct *prev);
+
 #elif defined(CONFIG_VIRT_CPU_ACCOUNTING_GEN)
+
 /*
  * Checks if vtime is enabled on some CPU. Cputime readers want to be careful
  * in that case and compute the tickless cputime.
@@ -36,33 +40,29 @@ static inline bool vtime_accounting_cpu_enabled(void)
 
 	return false;
 }
+
+extern void vtime_task_switch_generic(struct task_struct *prev);
+
+static inline void vtime_task_switch(struct task_struct *prev)
+{
+	if (vtime_accounting_cpu_enabled())
+		vtime_task_switch_generic(prev);
+}
+
 #else /* !CONFIG_VIRT_CPU_ACCOUNTING */
+
 static inline bool vtime_accounting_cpu_enabled(void) { return false; }
-#endif
+static inline void vtime_task_switch(struct task_struct *prev) { }
 
+#endif
 
 /*
  * Common vtime APIs
  */
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
-
-#ifdef __ARCH_HAS_VTIME_TASK_SWITCH
-extern void vtime_task_switch(struct task_struct *prev);
-#else
-extern void vtime_common_task_switch(struct task_struct *prev);
-static inline void vtime_task_switch(struct task_struct *prev)
-{
-	if (vtime_accounting_cpu_enabled())
-		vtime_common_task_switch(prev);
-}
-#endif /* __ARCH_HAS_VTIME_TASK_SWITCH */
-
 extern void vtime_account_kernel(struct task_struct *tsk);
 extern void vtime_account_idle(struct task_struct *tsk);
-
 #else /* !CONFIG_VIRT_CPU_ACCOUNTING */
-
-static inline void vtime_task_switch(struct task_struct *prev) { }
 static inline void vtime_account_kernel(struct task_struct *tsk) { }
 #endif /* !CONFIG_VIRT_CPU_ACCOUNTING */
 
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 63f10ac..facc665 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -404,9 +404,10 @@ static inline void irqtime_account_process_tick(struct task_struct *p, int user_
 /*
  * Use precise platform statistics if available:
  */
-#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
+
 # ifndef __ARCH_HAS_VTIME_TASK_SWITCH
-void vtime_common_task_switch(struct task_struct *prev)
+void vtime_task_switch(struct task_struct *prev)
 {
 	if (is_idle_task(prev))
 		vtime_account_idle(prev);
@@ -417,10 +418,7 @@ void vtime_common_task_switch(struct task_struct *prev)
 	arch_vtime_task_switch(prev);
 }
 # endif
-#endif /* CONFIG_VIRT_CPU_ACCOUNTING */
 
-
-#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 /*
  * Archs that account the whole time spent in the idle task
  * (outside irq) as idle time can rely on this and just implement
@@ -730,19 +728,25 @@ static void vtime_account_guest(struct task_struct *tsk,
 	}
 }
 
-void vtime_account_kernel(struct task_struct *tsk)
+static void __vtime_account_kernel(struct task_struct *tsk,
+				   struct vtime *vtime)
 {
-	struct vtime *vtime = &tsk->vtime;
-
-	if (!vtime_delta(vtime))
-		return;
-
-	write_seqcount_begin(&vtime->seqcount);
 	/* We might have scheduled out from guest path */
 	if (tsk->flags & PF_VCPU)
 		vtime_account_guest(tsk, vtime);
 	else
 		vtime_account_system(tsk, vtime);
+}
+
+void vtime_account_kernel(struct task_struct *tsk)
+{
+	struct vtime *vtime = &tsk->vtime;
+
+	if (!vtime_delta(vtime))
+		return;
+
+	write_seqcount_begin(&vtime->seqcount);
+	__vtime_account_kernel(tsk, vtime);
 	write_seqcount_end(&vtime->seqcount);
 }
 
@@ -800,18 +804,18 @@ EXPORT_SYMBOL_GPL(vtime_guest_exit);
 
 void vtime_account_idle(struct task_struct *tsk)
 {
-	struct vtime *vtime = &tsk->vtime;
-
-	write_seqcount_begin(&vtime->seqcount);
 	account_idle_time(get_vtime_delta(&tsk->vtime));
-	write_seqcount_end(&vtime->seqcount);
 }
 
-void arch_vtime_task_switch(struct task_struct *prev)
+void vtime_task_switch_generic(struct task_struct *prev)
 {
 	struct vtime *vtime = &prev->vtime;
 
 	write_seqcount_begin(&vtime->seqcount);
+	if (is_idle_task(prev))
+		vtime_account_idle(prev);
+	else
+		__vtime_account_kernel(prev, vtime);
 	vtime->state = VTIME_INACTIVE;
 	write_seqcount_end(&vtime->seqcount);
 
-- 
2.7.4

