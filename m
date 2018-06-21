Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52664C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FA420693
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FA420693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754563AbeFUBZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:25:24 -0400
Received: from exmail.andestech.com ([59.124.169.137]:31702 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754137AbeFUBZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:25:23 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w5L1OM7a036082;
        Thu, 21 Jun 2018 09:24:22 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 21 Jun 2018
 09:24:44 +0800
From:   Alan Kao <alankao@andestech.com>
To:     Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Alan Kao <alankao@andestech.com>,
        Greentime Hu <greentime@andestech.com>,
        Zong Li <zong@andestech.com>
Subject: [PATCH] riscv: Add support to no-FPU systems
Date:   Thu, 21 Jun 2018 09:24:36 +0800
Message-ID: <1529544276-28103-1-git-send-email-alankao@andestech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w5L1OM7a036082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an option, CONFIG_FPU, so that we can enable/disable
floating procedures in kernel.

Signed-off-by: Alan Kao <alankao@andestech.com>
Cc: Greentime Hu <greentime@andestech.com>
Cc: Zong Li <zong@andestech.com>
---
 arch/riscv/Kconfig                 | 4 ++++
 arch/riscv/Makefile                | 4 ++++
 arch/riscv/include/asm/switch_to.h | 4 ++++
 arch/riscv/kernel/entry.S          | 3 ++-
 arch/riscv/kernel/process.c        | 6 ++++++
 arch/riscv/kernel/signal.c         | 6 ++++++
 6 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6debcc4afc72..429d0bf777c9 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -232,6 +232,10 @@ config RISCV_BASE_PMU
 
 endmenu
 
+config FPU
+	bool "FPU support"
+	default y
+
 endmenu
 
 menu "Kernel type"
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 76e958a5414a..2719e768c4dc 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -47,7 +47,11 @@ ifeq ($(CONFIG_RISCV_ISA_C),y)
 	KBUILD_ARCH_C = c
 endif
 
+ifeq ($(CONFIG_FPU),y)
 KBUILD_AFLAGS += -march=$(KBUILD_MARCH)$(KBUILD_ARCH_A)fd$(KBUILD_ARCH_C)
+else
+KBUILD_AFLAGS += -march=$(KBUILD_MARCH)$(KBUILD_ARCH_A)$(KBUILD_ARCH_C)
+endif
 
 KBUILD_CFLAGS += -march=$(KBUILD_MARCH)$(KBUILD_ARCH_A)$(KBUILD_ARCH_C)
 KBUILD_CFLAGS += -mno-save-restore
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index dd6b05bff75b..da0327a74466 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -18,6 +18,7 @@
 #include <asm/ptrace.h>
 #include <asm/csr.h>
 
+#ifdef CONFIG_FPU
 extern void __fstate_save(struct task_struct *save_to);
 extern void __fstate_restore(struct task_struct *restore_from);
 
@@ -54,6 +55,9 @@ static inline void __switch_to_aux(struct task_struct *prev,
 		fstate_save(prev, regs);
 	fstate_restore(next, task_pt_regs(next));
 }
+#else
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
index cb209139ba53..a817046e478a 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -83,7 +83,11 @@ void show_regs(struct pt_regs *regs)
 void start_thread(struct pt_regs *regs, unsigned long pc,
 	unsigned long sp)
 {
+#ifdef CONFIG_FPU
 	regs->sstatus = SR_SPIE /* User mode, irqs on */ | SR_FS_INITIAL;
+#else
+	regs->sstatus = SR_SPIE | SR_FS_OFF;
+#endif
 	regs->sepc = pc;
 	regs->sp = sp;
 	set_fs(USER_DS);
@@ -101,7 +105,9 @@ void flush_thread(void)
 
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 {
+#ifdef CONFIG_FPU
 	fstate_save(src, task_pt_regs(src));
+#endif
 	*dst = *src;
 	return 0;
 }
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 718d0c984ef0..0f659c9ef465 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -37,6 +37,7 @@ struct rt_sigframe {
 	struct ucontext uc;
 };
 
+#ifdef CONFIG_FPU
 static long restore_d_state(struct pt_regs *regs,
 	struct __riscv_d_ext_state __user *state)
 {
@@ -53,6 +54,7 @@ static long save_d_state(struct pt_regs *regs,
 	fstate_save(current, regs);
 	return __copy_to_user(state, &current->thread.fstate, sizeof(*state));
 }
+#endif
 
 static long restore_sigcontext(struct pt_regs *regs,
 	struct sigcontext __user *sc)
@@ -63,6 +65,7 @@ static long restore_sigcontext(struct pt_regs *regs,
 	err = __copy_from_user(regs, &sc->sc_regs, sizeof(sc->sc_regs));
 	if (unlikely(err))
 		return err;
+#ifdef CONFIG_FPU
 	/* Restore the floating-point state. */
 	err = restore_d_state(regs, &sc->sc_fpregs.d);
 	if (unlikely(err))
@@ -76,6 +79,7 @@ static long restore_sigcontext(struct pt_regs *regs,
 		if (value != 0)
 			return -EINVAL;
 	}
+#endif
 	return err;
 }
 
@@ -127,11 +131,13 @@ static long setup_sigcontext(struct rt_sigframe __user *frame,
 	size_t i;
 	/* sc_regs is structured the same as the start of pt_regs */
 	err = __copy_to_user(&sc->sc_regs, regs, sizeof(sc->sc_regs));
+#ifdef CONFIG_FPU
 	/* Save the floating-point state. */
 	err |= save_d_state(regs, &sc->sc_fpregs.d);
 	/* We support no other extension state at this time. */
 	for (i = 0; i < ARRAY_SIZE(sc->sc_fpregs.q.reserved); i++)
 		err |= __put_user(0, &sc->sc_fpregs.q.reserved[i]);
+#endif
 	return err;
 }
 
-- 
2.17.0

