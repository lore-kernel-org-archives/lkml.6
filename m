Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6104C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A8A24665
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A8A24665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933822AbeFVRHM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:07:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42955 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933668AbeFVRHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:07:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5MH6q6r147004
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Jun 2018 10:06:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5MH6pGA146993;
        Fri, 22 Jun 2018 10:06:51 -0700
Date:   Fri, 22 Jun 2018 10:06:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Will Deacon <tipbot@zytor.com>
Message-ID: <tip-784e0300fe9fe4aa81bd7df9d59e138f56bb605b@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, will.deacon@arm.com,
        tglx@linutronix.de, mingo@kernel.org,
        mathieu.desnoyers@efficios.com
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          will.deacon@arm.com, mathieu.desnoyers@efficios.com,
          mingo@kernel.org, hpa@zytor.com
In-Reply-To: <1529664307-983-1-git-send-email-will.deacon@arm.com>
References: <1529664307-983-1-git-send-email-will.deacon@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] rseq: Avoid infinite recursion when delivering
 SIGSEGV
Git-Commit-ID: 784e0300fe9fe4aa81bd7df9d59e138f56bb605b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  784e0300fe9fe4aa81bd7df9d59e138f56bb605b
Gitweb:     https://git.kernel.org/tip/784e0300fe9fe4aa81bd7df9d59e138f56bb605b
Author:     Will Deacon <will.deacon@arm.com>
AuthorDate: Fri, 22 Jun 2018 11:45:07 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Jun 2018 19:04:22 +0200

rseq: Avoid infinite recursion when delivering SIGSEGV

When delivering a signal to a task that is using rseq, we call into
__rseq_handle_notify_resume() so that the registers pushed in the
sigframe are updated to reflect the state of the restartable sequence
(for example, ensuring that the signal returns to the abort handler if
necessary).

However, if the rseq management fails due to an unrecoverable fault when
accessing userspace or certain combinations of RSEQ_CS_* flags, then we
will attempt to deliver a SIGSEGV. This has the potential for infinite
recursion if the rseq code continuously fails on signal delivery.

Avoid this problem by using force_sigsegv() instead of force_sig(), which
is explicitly designed to reset the SEGV handler to SIG_DFL in the case
of a recursive fault. In doing so, remove rseq_signal_deliver() from the
internal rseq API and have an optional struct ksignal * parameter to
rseq_handle_notify_resume() instead.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org
Cc: paulmck@linux.vnet.ibm.com
Cc: boqun.feng@gmail.com
Link: https://lkml.kernel.org/r/1529664307-983-1-git-send-email-will.deacon@arm.com

---
 arch/arm/kernel/signal.c     |  4 ++--
 arch/powerpc/kernel/signal.c |  4 ++--
 arch/x86/entry/common.c      |  2 +-
 arch/x86/kernel/signal.c     |  2 +-
 include/linux/sched.h        | 18 +++++++++++-------
 kernel/rseq.c                |  7 ++++---
 6 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index f09e9d66d605..dec130e7078c 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -544,7 +544,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	 * Increment event counter and perform fixup for the pre-signal
 	 * frame.
 	 */
-	rseq_signal_deliver(regs);
+	rseq_signal_deliver(ksig, regs);
 
 	/*
 	 * Set up the stack frame
@@ -666,7 +666,7 @@ do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
 			} else {
 				clear_thread_flag(TIF_NOTIFY_RESUME);
 				tracehook_notify_resume(regs);
-				rseq_handle_notify_resume(regs);
+				rseq_handle_notify_resume(NULL, regs);
 			}
 		}
 		local_irq_disable();
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index 17fe4339ba59..b3e8db376ecd 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -134,7 +134,7 @@ static void do_signal(struct task_struct *tsk)
 	/* Re-enable the breakpoints for the signal stack */
 	thread_change_pc(tsk, tsk->thread.regs);
 
-	rseq_signal_deliver(tsk->thread.regs);
+	rseq_signal_deliver(&ksig, tsk->thread.regs);
 
 	if (is32) {
         	if (ksig.ka.sa.sa_flags & SA_SIGINFO)
@@ -170,7 +170,7 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)
 	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
 		clear_thread_flag(TIF_NOTIFY_RESUME);
 		tracehook_notify_resume(regs);
-		rseq_handle_notify_resume(regs);
+		rseq_handle_notify_resume(NULL, regs);
 	}
 
 	user_enter();
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 92190879b228..3b2490b81918 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -164,7 +164,7 @@ static void exit_to_usermode_loop(struct pt_regs *regs, u32 cached_flags)
 		if (cached_flags & _TIF_NOTIFY_RESUME) {
 			clear_thread_flag(TIF_NOTIFY_RESUME);
 			tracehook_notify_resume(regs);
-			rseq_handle_notify_resume(regs);
+			rseq_handle_notify_resume(NULL, regs);
 		}
 
 		if (cached_flags & _TIF_USER_RETURN_NOTIFY)
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 445ca11ff863..92a3b312a53c 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -692,7 +692,7 @@ setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	 * Increment event counter and perform fixup for the pre-signal
 	 * frame.
 	 */
-	rseq_signal_deliver(regs);
+	rseq_signal_deliver(ksig, regs);
 
 	/* Set up the stack frame */
 	if (is_ia32_frame(ksig)) {
diff --git a/include/linux/sched.h b/include/linux/sched.h
index c1882643d455..9256118bd40c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1799,20 +1799,22 @@ static inline void rseq_set_notify_resume(struct task_struct *t)
 		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
 }
 
-void __rseq_handle_notify_resume(struct pt_regs *regs);
+void __rseq_handle_notify_resume(struct ksignal *sig, struct pt_regs *regs);
 
-static inline void rseq_handle_notify_resume(struct pt_regs *regs)
+static inline void rseq_handle_notify_resume(struct ksignal *ksig,
+					     struct pt_regs *regs)
 {
 	if (current->rseq)
-		__rseq_handle_notify_resume(regs);
+		__rseq_handle_notify_resume(ksig, regs);
 }
 
-static inline void rseq_signal_deliver(struct pt_regs *regs)
+static inline void rseq_signal_deliver(struct ksignal *ksig,
+				       struct pt_regs *regs)
 {
 	preempt_disable();
 	__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
 	preempt_enable();
-	rseq_handle_notify_resume(regs);
+	rseq_handle_notify_resume(ksig, regs);
 }
 
 /* rseq_preempt() requires preemption to be disabled. */
@@ -1861,10 +1863,12 @@ static inline void rseq_execve(struct task_struct *t)
 static inline void rseq_set_notify_resume(struct task_struct *t)
 {
 }
-static inline void rseq_handle_notify_resume(struct pt_regs *regs)
+static inline void rseq_handle_notify_resume(struct ksignal *ksig,
+					     struct pt_regs *regs)
 {
 }
-static inline void rseq_signal_deliver(struct pt_regs *regs)
+static inline void rseq_signal_deliver(struct ksignal *ksig,
+				       struct pt_regs *regs)
 {
 }
 static inline void rseq_preempt(struct task_struct *t)
diff --git a/kernel/rseq.c b/kernel/rseq.c
index ae306f90c514..22b6acf1ad63 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -251,10 +251,10 @@ static int rseq_ip_fixup(struct pt_regs *regs)
  * respect to other threads scheduled on the same CPU, and with respect
  * to signal handlers.
  */
-void __rseq_handle_notify_resume(struct pt_regs *regs)
+void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 {
 	struct task_struct *t = current;
-	int ret;
+	int ret, sig;
 
 	if (unlikely(t->flags & PF_EXITING))
 		return;
@@ -268,7 +268,8 @@ void __rseq_handle_notify_resume(struct pt_regs *regs)
 	return;
 
 error:
-	force_sig(SIGSEGV, t);
+	sig = ksig ? ksig->sig : 0;
+	force_sigsegv(sig, t);
 }
 
 #ifdef CONFIG_DEBUG_RSEQ
