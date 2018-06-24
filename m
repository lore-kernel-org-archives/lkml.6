Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C641AC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 11:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7572224EC8
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 11:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7572224EC8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbeFXL4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 07:56:50 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44872 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbeFXL4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 07:56:49 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fX3dP-0004ZG-LT; Sun, 24 Jun 2018 13:56:47 +0200
Date:   Sun, 24 Jun 2018 13:56:47 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] scheduler updates for 4.18
Message-ID: <alpine.DEB.2.21.1806241352100.8650@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

A pile of rseq related fixups:

 - Prevent infinite recursion when delivering SIGSEGV

 - Remove the abort of rseq critical section on fork() as syscalls inside
   rseq critical sections are explicitely forbidden. So no point in doing
   the abort on the child.

 - Align the rseq structure on 32 bytes in the ARM selftest code.

 - Fix file permissions of the test script

Thanks,

	tglx

------------------>
Mathieu Desnoyers (3):
      rseq/selftests: Make run_param_test.sh executable
      rseq/selftests/arm: Align 'struct rseq_cs' on 32 bytes
      rseq/cleanup: Do not abort rseq c.s. in child on fork()

Will Deacon (1):
      rseq: Avoid infinite recursion when delivering SIGSEGV


 arch/arm/kernel/signal.c                       |  4 ++--
 arch/powerpc/kernel/signal.c                   |  4 ++--
 arch/x86/entry/common.c                        |  2 +-
 arch/x86/kernel/signal.c                       |  2 +-
 include/linux/sched.h                          | 23 ++++++++++++-----------
 kernel/rseq.c                                  |  7 ++++---
 tools/testing/selftests/rseq/rseq-arm.h        |  1 +
 tools/testing/selftests/rseq/run_param_test.sh |  0
 8 files changed, 23 insertions(+), 20 deletions(-)
 mode change 100644 => 100755 tools/testing/selftests/rseq/run_param_test.sh

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
index 87bf02d93a27..9256118bd40c 100644
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
@@ -1831,9 +1833,7 @@ static inline void rseq_migrate(struct task_struct *t)
 
 /*
  * If parent process has a registered restartable sequences area, the
- * child inherits. Only applies when forking a process, not a thread. In
- * case a parent fork() in the middle of a restartable sequence, set the
- * resume notifier to force the child to retry.
+ * child inherits. Only applies when forking a process, not a thread.
  */
 static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
 {
@@ -1847,7 +1847,6 @@ static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
 		t->rseq_len = current->rseq_len;
 		t->rseq_sig = current->rseq_sig;
 		t->rseq_event_mask = current->rseq_event_mask;
-		rseq_preempt(t);
 	}
 }
 
@@ -1864,10 +1863,12 @@ static inline void rseq_execve(struct task_struct *t)
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
diff --git a/tools/testing/selftests/rseq/rseq-arm.h b/tools/testing/selftests/rseq/rseq-arm.h
index 3b055f9aeaab..3cea19877227 100644
--- a/tools/testing/selftests/rseq/rseq-arm.h
+++ b/tools/testing/selftests/rseq/rseq-arm.h
@@ -57,6 +57,7 @@ do {									\
 #define __RSEQ_ASM_DEFINE_ABORT(table_label, label, teardown,		\
 				abort_label, version, flags,		\
 				start_ip, post_commit_offset, abort_ip)	\
+		".balign 32\n\t"					\
 		__rseq_str(table_label) ":\n\t"				\
 		".word " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
 		".word " __rseq_str(start_ip) ", 0x0, " __rseq_str(post_commit_offset) ", 0x0, " __rseq_str(abort_ip) ", 0x0\n\t" \
diff --git a/tools/testing/selftests/rseq/run_param_test.sh b/tools/testing/selftests/rseq/run_param_test.sh
old mode 100644
new mode 100755
