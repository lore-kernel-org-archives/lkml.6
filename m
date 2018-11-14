Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79824C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A9E22419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pa7NDMEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A9E22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732240AbeKNMrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:47:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:51414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731854AbeKNMre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:47:34 -0500
Received: from lerouge.suse.de (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AFA3223DD;
        Wed, 14 Nov 2018 02:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542163583;
        bh=ZO19vOg3UBVADV2bH8TL1RpCboaQzmsKW8CcCt41eq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pa7NDMEL3EDhs+izXHUQKglXK3+twrEqyQkEKlSDBohck8vi4Y06vElmGZnG4424q
         HXB/SwOem1x634B4Xlyecp+L2BBasbOwm01Kic92Aqgku7sacCPP/jboxc7sLnDXdU
         7rRcaA1tQdF0FFfhMwu+1vDHejE9/H5onl4vDud8=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: [PATCH 03/25] vtime: Rename vtime_account_system() to vtime_account_kernel()
Date:   Wed, 14 Nov 2018 03:45:47 +0100
Message-Id: <1542163569-20047-4-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542163569-20047-1-git-send-email-frederic@kernel.org>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vtime_account_system() decides if we need to account the time to the
system (__vtime_account_system()) or to the guest (vtime_account_guest()).

So this function is a misnommer as we are on a higher level than
"system". All we know when we call that function is that we are
accounting kernel cputime. Whether it belongs to guest or system time
is a lower level detail.

Rename this function to vtime_account_kernel(). This will clarify things
and avoid too many underscored vtime_account_system() versions.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 arch/ia64/kernel/time.c          |  4 ++--
 arch/powerpc/kernel/time.c       |  6 +++---
 arch/s390/kernel/vtime.c         |  4 ++--
 include/linux/context_tracking.h |  4 ++--
 include/linux/vtime.h            |  6 +++---
 kernel/sched/cputime.c           | 18 +++++++++---------
 6 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/ia64/kernel/time.c b/arch/ia64/kernel/time.c
index 9025699..a3b09ea 100644
--- a/arch/ia64/kernel/time.c
+++ b/arch/ia64/kernel/time.c
@@ -132,7 +132,7 @@ static __u64 vtime_delta(struct task_struct *tsk)
 	return delta_stime;
 }
 
-void vtime_account_system(struct task_struct *tsk)
+void vtime_account_kernel(struct task_struct *tsk)
 {
 	struct thread_info *ti = task_thread_info(tsk);
 	__u64 stime = vtime_delta(tsk);
@@ -146,7 +146,7 @@ void vtime_account_system(struct task_struct *tsk)
 	else
 		ti->stime += stime;
 }
-EXPORT_SYMBOL_GPL(vtime_account_system);
+EXPORT_SYMBOL_GPL(vtime_account_kernel);
 
 void vtime_account_idle(struct task_struct *tsk)
 {
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 3646aff..cc591a4 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -342,7 +342,7 @@ static unsigned long vtime_delta(struct task_struct *tsk,
 	return stime;
 }
 
-void vtime_account_system(struct task_struct *tsk)
+void vtime_account_kernel(struct task_struct *tsk)
 {
 	unsigned long stime, stime_scaled, steal_time;
 	struct cpu_accounting_data *acct = get_accounting(tsk);
@@ -370,7 +370,7 @@ void vtime_account_system(struct task_struct *tsk)
 #endif
 	}
 }
-EXPORT_SYMBOL_GPL(vtime_account_system);
+EXPORT_SYMBOL_GPL(vtime_account_kernel);
 
 void vtime_account_idle(struct task_struct *tsk)
 {
@@ -399,7 +399,7 @@ static void vtime_flush_scaled(struct task_struct *tsk,
 /*
  * Account the whole cputime accumulated in the paca
  * Must be called with interrupts disabled.
- * Assumes that vtime_account_system/idle() has been called
+ * Assumes that vtime_account_kernel/idle() has been called
  * recently (i.e. since the last entry from usermode) so that
  * get_paca()->user_time_scaled is up to date.
  */
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index f24395a..af48db3 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -242,9 +242,9 @@ void vtime_account_irq_enter(struct task_struct *tsk)
 }
 EXPORT_SYMBOL_GPL(vtime_account_irq_enter);
 
-void vtime_account_system(struct task_struct *tsk)
+void vtime_account_kernel(struct task_struct *tsk)
 __attribute__((alias("vtime_account_irq_enter")));
-EXPORT_SYMBOL_GPL(vtime_account_system);
+EXPORT_SYMBOL_GPL(vtime_account_kernel);
 
 /*
  * Sorted add to a list. List is linear searched until first bigger
diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index d05609a..558a209 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -141,7 +141,7 @@ static inline void guest_enter_irqoff(void)
 	 * to assume that it's the stime pending cputime
 	 * to flush.
 	 */
-	vtime_account_system(current);
+	vtime_account_kernel(current);
 	current->flags |= PF_VCPU;
 	rcu_virt_note_context_switch(smp_processor_id());
 }
@@ -149,7 +149,7 @@ static inline void guest_enter_irqoff(void)
 static inline void guest_exit_irqoff(void)
 {
 	/* Flush the guest cputime we spent on the guest */
-	vtime_account_system(current);
+	vtime_account_kernel(current);
 	current->flags &= ~PF_VCPU;
 }
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_GEN */
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index a26ed10..2fd247f 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -57,13 +57,13 @@ static inline void vtime_task_switch(struct task_struct *prev)
 }
 #endif /* __ARCH_HAS_VTIME_TASK_SWITCH */
 
-extern void vtime_account_system(struct task_struct *tsk);
+extern void vtime_account_kernel(struct task_struct *tsk);
 extern void vtime_account_idle(struct task_struct *tsk);
 
 #else /* !CONFIG_VIRT_CPU_ACCOUNTING */
 
 static inline void vtime_task_switch(struct task_struct *prev) { }
-static inline void vtime_account_system(struct task_struct *tsk) { }
+static inline void vtime_account_kernel(struct task_struct *tsk) { }
 #endif /* !CONFIG_VIRT_CPU_ACCOUNTING */
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
@@ -86,7 +86,7 @@ extern void vtime_account_irq_enter(struct task_struct *tsk);
 static inline void vtime_account_irq_exit(struct task_struct *tsk)
 {
 	/* On hard|softirq exit we always account to hard|softirq cputime */
-	vtime_account_system(tsk);
+	vtime_account_kernel(tsk);
 }
 extern void vtime_flush(struct task_struct *tsk);
 #else /* !CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 6e74ec2..63f10ac 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -411,7 +411,7 @@ void vtime_common_task_switch(struct task_struct *prev)
 	if (is_idle_task(prev))
 		vtime_account_idle(prev);
 	else
-		vtime_account_system(prev);
+		vtime_account_kernel(prev);
 
 	vtime_flush(prev);
 	arch_vtime_task_switch(prev);
@@ -424,7 +424,7 @@ void vtime_common_task_switch(struct task_struct *prev)
 /*
  * Archs that account the whole time spent in the idle task
  * (outside irq) as idle time can rely on this and just implement
- * vtime_account_system() and vtime_account_idle(). Archs that
+ * vtime_account_kernel() and vtime_account_idle(). Archs that
  * have other meaning of the idle time (s390 only includes the
  * time spent by the CPU when it's in low power mode) must override
  * vtime_account().
@@ -435,7 +435,7 @@ void vtime_account_irq_enter(struct task_struct *tsk)
 	if (!in_interrupt() && is_idle_task(tsk))
 		vtime_account_idle(tsk);
 	else
-		vtime_account_system(tsk);
+		vtime_account_kernel(tsk);
 }
 EXPORT_SYMBOL_GPL(vtime_account_irq_enter);
 #endif /* __ARCH_HAS_VTIME_ACCOUNT */
@@ -710,8 +710,8 @@ static u64 get_vtime_delta(struct vtime *vtime)
 	return delta - other;
 }
 
-static void __vtime_account_system(struct task_struct *tsk,
-				   struct vtime *vtime)
+static void vtime_account_system(struct task_struct *tsk,
+				 struct vtime *vtime)
 {
 	vtime->stime += get_vtime_delta(vtime);
 	if (vtime->stime >= TICK_NSEC) {
@@ -730,7 +730,7 @@ static void vtime_account_guest(struct task_struct *tsk,
 	}
 }
 
-void vtime_account_system(struct task_struct *tsk)
+void vtime_account_kernel(struct task_struct *tsk)
 {
 	struct vtime *vtime = &tsk->vtime;
 
@@ -742,7 +742,7 @@ void vtime_account_system(struct task_struct *tsk)
 	if (tsk->flags & PF_VCPU)
 		vtime_account_guest(tsk, vtime);
 	else
-		__vtime_account_system(tsk, vtime);
+		vtime_account_system(tsk, vtime);
 	write_seqcount_end(&vtime->seqcount);
 }
 
@@ -751,7 +751,7 @@ void vtime_user_enter(struct task_struct *tsk)
 	struct vtime *vtime = &tsk->vtime;
 
 	write_seqcount_begin(&vtime->seqcount);
-	__vtime_account_system(tsk, vtime);
+	vtime_account_system(tsk, vtime);
 	vtime->state = VTIME_USER;
 	write_seqcount_end(&vtime->seqcount);
 }
@@ -781,7 +781,7 @@ void vtime_guest_enter(struct task_struct *tsk)
 	 * that can thus safely catch up with a tickless delta.
 	 */
 	write_seqcount_begin(&vtime->seqcount);
-	__vtime_account_system(tsk, vtime);
+	vtime_account_system(tsk, vtime);
 	tsk->flags |= PF_VCPU;
 	write_seqcount_end(&vtime->seqcount);
 }
-- 
2.7.4

