Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbeCTDSI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 23:18:08 -0400
Received: from akagi.fsij.org ([217.70.189.144]:38116 "EHLO akagi.fsij.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751548AbeCTDQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 23:16:53 -0400
From: NIIBE Yutaka <gniibe@fsij.org>
To: linux-kernel@vger.kernel.org
Cc: gniibe@fsij.org
Subject: [PATCH 3/4] signal/x86: Move nosig handling at the end of exit_to_usermode_loop.
Date: Tue, 20 Mar 2018 11:38:56 +0900
Message-Id: <20180320023857.1885-4-gniibe@fsij.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180320023857.1885-1-gniibe@fsij.org>
References: <20180320023857.1885-1-gniibe@fsij.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handling of restarting a system call for nosig should be done after
all possible calls of do_signal, to see if it's actually delivering
signal(s) or not.

Before this change, restarting a system call for nosig may be followed
by a call of handle_signal which would try to change the system call
returning -EINTR instead, but it is too late to do so.

Signed-off-by: NIIBE Yutaka <gniibe@fsij.org>
---
 arch/x86/entry/common.c       | 6 +++++-
 arch/x86/include/asm/signal.h | 2 +-
 arch/x86/kernel/signal.c      | 6 +++---
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 74f6eee15179..38e0939c0aeb 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -137,6 +137,8 @@ static long syscall_trace_enter(struct pt_regs *regs)
 
 static void exit_to_usermode_loop(struct pt_regs *regs, u32 cached_flags)
 {
+	int nosig = 0;
+
 	/*
 	 * In order to return to user mode, we need to have IRQs off with
 	 * none of EXIT_TO_USERMODE_LOOP_FLAGS set.  Several of these flags
@@ -159,7 +161,7 @@ static void exit_to_usermode_loop(struct pt_regs *regs, u32 cached_flags)
 
 		/* deal with pending signal delivery */
 		if (cached_flags & _TIF_SIGPENDING)
-			do_signal(regs);
+			nosig |= do_signal(regs);
 
 		if (cached_flags & _TIF_NOTIFY_RESUME) {
 			clear_thread_flag(TIF_NOTIFY_RESUME);
@@ -177,6 +179,8 @@ static void exit_to_usermode_loop(struct pt_regs *regs, u32 cached_flags)
 		if (!(cached_flags & EXIT_TO_USERMODE_LOOP_FLAGS))
 			break;
 	}
+	if (nosig)
+		nosig_restart_syscall(regs);
 }
 
 /* Called with IRQs disabled. */
diff --git a/arch/x86/include/asm/signal.h b/arch/x86/include/asm/signal.h
index 6517df6d9938..31e68266c2f6 100644
--- a/arch/x86/include/asm/signal.h
+++ b/arch/x86/include/asm/signal.h
@@ -35,7 +35,7 @@ typedef sigset_t compat_sigset_t;
 #endif /* __ASSEMBLY__ */
 #include <uapi/asm/signal.h>
 #ifndef __ASSEMBLY__
-extern void do_signal(struct pt_regs *regs);
+extern int do_signal(struct pt_regs *regs);
 extern void nosig_restart_syscall(struct pt_regs *regs);
 
 #define __ARCH_HAS_SA_RESTORER
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index e709b54a01b8..57576988a01f 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -803,17 +803,17 @@ static inline unsigned long get_nr_restart_syscall(const struct pt_regs *regs)
  * want to handle. Thus you cannot kill init even with a SIGKILL even by
  * mistake.
  */
-void do_signal(struct pt_regs *regs)
+int do_signal(struct pt_regs *regs)
 {
 	struct ksignal ksig;
 
 	if (get_signal(&ksig)) {
 		/* Whee! Actually deliver the signal.  */
 		handle_signal(&ksig, regs);
-		return;
+		return 0;
 	}
 
-	nosig_restart_syscall(regs);
+	return 1;
 }
 
 void nosig_restart_syscall(struct pt_regs *regs)
-- 
2.11.0
