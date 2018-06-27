Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43095C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 04:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045B826572
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 04:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045B826572
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbeF0EWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 00:22:41 -0400
Received: from exmail.andestech.com ([59.124.169.137]:17964 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751304AbeF0EWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 00:22:39 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w5R4P1GW043382;
        Wed, 27 Jun 2018 12:25:01 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Wed, 27 Jun 2018
 12:22:27 +0800
From:   Alan Kao <alankao@andestech.com>
To:     Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        "Andrew Waterman" <andrew@sifive.com>,
        Darius Rad <darius@bluespec.com>
CC:     Greentime <greentime@andestech.com>, Zong Li <zong@andestech.com>,
        "Alan Kao" <alankao@andestech.com>
Subject: [PATCH v2] riscv: Add support to no-FPU systems
Date:   Wed, 27 Jun 2018 12:22:26 +0800
Message-ID: <1530073346-5341-1-git-send-email-alankao@andestech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w5R4P1GW043382
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an option, CONFIG_FPU, to enable/disable floating
procedures.  Also, some style issues are fixed.

Signed-off-by: Alan Kao <alankao@andestech.com>
Cc: Greentime Hu <greentime@andestech.com>
Cc: Zong Li <zong@andestech.com>
---
 arch/riscv/Kconfig                 |  9 ++++
 arch/riscv/Makefile                | 19 +++----
 arch/riscv/include/asm/switch_to.h |  6 +++
 arch/riscv/kernel/entry.S          |  3 +-
 arch/riscv/kernel/process.c        |  7 ++-
 arch/riscv/kernel/signal.c         | 82 +++++++++++++++++++++---------
 6 files changed, 90 insertions(+), 36 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6debcc4afc72..6069597ba73f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -232,6 +232,15 @@ config RISCV_BASE_PMU
 
 endmenu
 
+config FPU
+	bool "FPU support"
+	default y
+	help
+	  Say N here if you want to disable all floating-point related procedure
+	  in the kernel.
+
+	  If you don't know what to do here, say Y.
+
 endmenu
 
 menu "Kernel type"
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 6d4a5f6c3f4f..ad3033739430 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -26,7 +26,6 @@ ifeq ($(CONFIG_ARCH_RV64I),y)
 
 	KBUILD_CFLAGS += -mabi=lp64
 	KBUILD_AFLAGS += -mabi=lp64
-	KBUILD_MARCH = rv64im
 	LDFLAGS += -melf64lriscv
 else
 	BITS := 32
@@ -34,22 +33,20 @@ else
 
 	KBUILD_CFLAGS += -mabi=ilp32
 	KBUILD_AFLAGS += -mabi=ilp32
-	KBUILD_MARCH = rv32im
 	LDFLAGS += -melf32lriscv
 endif
 
 KBUILD_CFLAGS += -Wall
 
-ifeq ($(CONFIG_RISCV_ISA_A),y)
-	KBUILD_ARCH_A = a
-endif
-ifeq ($(CONFIG_RISCV_ISA_C),y)
-	KBUILD_ARCH_C = c
-endif
-
-KBUILD_AFLAGS += -march=$(KBUILD_MARCH)$(KBUILD_ARCH_A)fd$(KBUILD_ARCH_C)
+# ISA string setting
+riscv-march-$(CONFIG_ARCH_RV32I)      := rv32im
+riscv-march-$(CONFIG_ARCH_RV64I)      := rv64im
+riscv-march-$(CONFIG_RISCV_ISA_A)     := $(riscv-march-y)a
+riscv-march-$(CONFIG_FPU)             := $(riscv-march-y)fd
+riscv-march-$(CONFIG_RISCV_ISA_C)     := $(riscv-march-y)c
+KBUILD_CFLAGS += -march=$(riscv-march-y)
+KBUILD_AFLAGS += -march=$(riscv-march-y)
 
-KBUILD_CFLAGS += -march=$(KBUILD_MARCH)$(KBUILD_ARCH_A)$(KBUILD_ARCH_C)
 KBUILD_CFLAGS += -mno-save-restore
 KBUILD_CFLAGS += -DCONFIG_PAGE_OFFSET=$(CONFIG_PAGE_OFFSET)
 
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index dd6b05bff75b..de333c012227 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -18,6 +18,7 @@
 #include <asm/ptrace.h>
 #include <asm/csr.h>
 
+#ifdef CONFIG_FPU
 extern void __fstate_save(struct task_struct *save_to);
 extern void __fstate_restore(struct task_struct *restore_from);
 
@@ -54,6 +55,11 @@ static inline void __switch_to_aux(struct task_struct *prev,
 		fstate_save(prev, regs);
 	fstate_restore(next, task_pt_regs(next));
 }
+#else
+#define fstate_save(task, regs) do { } while (0)
+#define fstate_restore(task, regs) do { } while (0)
+#define __switch_to_aux(__prev, __next)
+#endif
 
 extern struct task_struct *__switch_to(struct task_struct *,
 				       struct task_struct *);
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 9aaf6c986771..89867c9aa4f5 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -357,6 +357,7 @@ ENTRY(__switch_to)
 	ret
 ENDPROC(__switch_to)
 
+#ifdef CONFIG_FPU
 ENTRY(__fstate_save)
 	li  a2,  TASK_THREAD_F0
 	add a0, a0, a2
@@ -442,7 +443,7 @@ ENTRY(__fstate_restore)
 	csrc sstatus, t1
 	ret
 ENDPROC(__fstate_restore)
-
+#endif
 
 	.section ".rodata"
 	/* Exception vector table */
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index cb209139ba53..99d20283bb62 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -83,7 +83,12 @@ void show_regs(struct pt_regs *regs)
 void start_thread(struct pt_regs *regs, unsigned long pc,
 	unsigned long sp)
 {
-	regs->sstatus = SR_SPIE /* User mode, irqs on */ | SR_FS_INITIAL;
+	/* User mode, irqs on */
+#ifdef CONFIG_FPU
+	regs->sstatus = SR_SPIE | SR_FS_INITIAL;
+#else
+	regs->sstatus = SR_SPIE | SR_FS_OFF;
+#endif
 	regs->sepc = pc;
 	regs->sp = sp;
 	set_fs(USER_DS);
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 718d0c984ef0..a7a5ed5598a8 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -37,8 +37,9 @@ struct rt_sigframe {
 	struct ucontext uc;
 };
 
-static long restore_d_state(struct pt_regs *regs,
-	struct __riscv_d_ext_state __user *state)
+#ifdef CONFIG_FPU
+static inline long __restore_d_state(struct pt_regs *regs,
+				     struct __riscv_d_ext_state __user *state)
 {
 	long err;
 	err = __copy_from_user(&current->thread.fstate, state, sizeof(*state));
@@ -47,35 +48,75 @@ static long restore_d_state(struct pt_regs *regs,
 	return err;
 }
 
-static long save_d_state(struct pt_regs *regs,
-	struct __riscv_d_ext_state __user *state)
+static inline long __save_d_state(struct pt_regs *regs,
+				  struct __riscv_d_ext_state __user *state)
 {
 	fstate_save(current, regs);
 	return __copy_to_user(state, &current->thread.fstate, sizeof(*state));
 }
 
-static long restore_sigcontext(struct pt_regs *regs,
-	struct sigcontext __user *sc)
+static long restore_d_state(struct pt_regs *regs,
+			    union __riscv_fp_state *sc_fpregs)
 {
 	long err;
 	size_t i;
-	/* sc_regs is structured the same as the start of pt_regs */
-	err = __copy_from_user(regs, &sc->sc_regs, sizeof(sc->sc_regs));
-	if (unlikely(err))
-		return err;
+
 	/* Restore the floating-point state. */
-	err = restore_d_state(regs, &sc->sc_fpregs.d);
+	err = __restore_d_state(regs, &sc_fpregs->d);
 	if (unlikely(err))
 		return err;
 	/* We support no other extension state at this time. */
-	for (i = 0; i < ARRAY_SIZE(sc->sc_fpregs.q.reserved); i++) {
+	for (i = 0; i < ARRAY_SIZE(sc_fpregs->q.reserved); i++) {
 		u32 value;
-		err = __get_user(value, &sc->sc_fpregs.q.reserved[i]);
+		err = __get_user(value, &sc_fpregs->q.reserved[i]);
 		if (unlikely(err))
 			break;
 		if (value != 0)
 			return -EINVAL;
 	}
+
+	return 0;
+}
+
+static long save_d_state(struct pt_regs *regs,
+			 union __riscv_fp_state *sc_fpregs)
+{
+	long err;
+	size_t i;
+
+	/* Save the floating-point state. */
+	err = __save_d_state(regs, &sc_fpregs->d);
+	/* We support no other extension state at this time. */
+	for (i = 0; i < ARRAY_SIZE(sc_fpregs->q.reserved); i++)
+		err |= __put_user(0, &sc_fpregs->q.reserved[i]);
+
+	return err;
+}
+#else
+static long restore_d_state(struct pt_regs *regs,
+			    union __riscv_fp_state *sc_fpregs)
+{
+	return 0;
+}
+
+static long save_d_state(struct pt_regs *regs,
+			 union __riscv_fp_state *sc_fpregs)
+{
+	return 0;
+}
+#endif
+
+static long restore_sigcontext(struct pt_regs *regs,
+			       struct sigcontext __user *sc)
+{
+	long err;
+	/* sc_regs is structured the same as the start of pt_regs */
+	err = __copy_from_user(regs, &sc->sc_regs, sizeof(sc->sc_regs));
+	if (unlikely(err))
+		return err;
+	/* Restore the floating-point state. */
+	err = restore_d_state(regs, &sc->sc_fpregs);
+
 	return err;
 }
 
@@ -120,23 +161,18 @@ SYSCALL_DEFINE0(rt_sigreturn)
 }
 
 static long setup_sigcontext(struct rt_sigframe __user *frame,
-	struct pt_regs *regs)
+			     struct pt_regs *regs)
 {
 	struct sigcontext __user *sc = &frame->uc.uc_mcontext;
 	long err;
-	size_t i;
 	/* sc_regs is structured the same as the start of pt_regs */
 	err = __copy_to_user(&sc->sc_regs, regs, sizeof(sc->sc_regs));
-	/* Save the floating-point state. */
-	err |= save_d_state(regs, &sc->sc_fpregs.d);
-	/* We support no other extension state at this time. */
-	for (i = 0; i < ARRAY_SIZE(sc->sc_fpregs.q.reserved); i++)
-		err |= __put_user(0, &sc->sc_fpregs.q.reserved[i]);
+	err |= save_d_state(regs, &sc->sc_fpregs);
 	return err;
 }
 
 static inline void __user *get_sigframe(struct ksignal *ksig,
-	struct pt_regs *regs, size_t framesize)
+					struct pt_regs *regs, size_t framesize)
 {
 	unsigned long sp;
 	/* Default to using normal stack */
@@ -160,7 +196,7 @@ static inline void __user *get_sigframe(struct ksignal *ksig,
 
 
 static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
-	struct pt_regs *regs)
+			  struct pt_regs *regs)
 {
 	struct rt_sigframe __user *frame;
 	long err = 0;
@@ -279,7 +315,7 @@ static void do_signal(struct pt_regs *regs)
  * - triggered by the _TIF_WORK_MASK flags
  */
 asmlinkage void do_notify_resume(struct pt_regs *regs,
-	unsigned long thread_info_flags)
+				 unsigned long thread_info_flags)
 {
 	/* Handle pending signal delivery */
 	if (thread_info_flags & _TIF_SIGPENDING)
-- 
2.18.0

