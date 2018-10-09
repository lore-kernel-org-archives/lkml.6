Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D74CC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 02:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633E42086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 02:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633E42086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbeJIJea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 05:34:30 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:33604 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726486AbeJIJeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 05:34:24 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w992M3xj032673;
        Tue, 9 Oct 2018 10:22:03 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Tue, 9 Oct 2018
 10:19:22 +0800
From:   Alan Kao <alankao@andestech.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
CC:     Greentime Hu <greentime@andestech.com>,
        Vincent Chen <vincentc@andestech.com>,
        Zong Li <zong@andestech.com>, Nick Hu <nickhu@andestech.com>,
        Alan Kao <alankao@andestech.com>
Subject: [PATCH v8 4/5] Allow to disable FPU support
Date:   Tue, 9 Oct 2018 10:18:33 +0800
Message-ID: <1539051514-3658-5-git-send-email-alankao@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539051514-3658-1-git-send-email-alankao@andestech.com>
References: <1539051514-3658-1-git-send-email-alankao@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w992M3xj032673
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FPU codes have been separated from common part in previous patches.
This patch add the CONFIG_FPU option and some stubs, so that a no-FPU
configuration is allowed.

Signed-off-by: Alan Kao <alankao@andestech.com>
Cc: Greentime Hu <greentime@andestech.com>
Cc: Vincent Chen <vincentc@andestech.com>
Cc: Zong Li <zong@andestech.com>
Cc: Nick Hu <nickhu@andestech.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/Kconfig                 |  9 +++++++++
 arch/riscv/Makefile                |  2 +-
 arch/riscv/include/asm/switch_to.h | 10 ++++++++++
 arch/riscv/kernel/Makefile         |  2 +-
 arch/riscv/kernel/process.c        |  4 +++-
 arch/riscv/kernel/signal.c         |  5 +++++
 6 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a344980..a63f9db 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -208,6 +208,15 @@ config RISCV_BASE_PMU
 
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
index 01393e1..901770f 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -44,7 +44,7 @@ KBUILD_CFLAGS += -Wall
 riscv-march-$(CONFIG_ARCH_RV32I)	:= rv32im
 riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64im
 riscv-march-$(CONFIG_RISCV_ISA_A)	:= $(riscv-march-y)a
-riscv-march-y				:= $(riscv-march-y)fd
+riscv-march-$(CONFIG_FPU)		:= $(riscv-march-y)fd
 riscv-march-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-y)c
 KBUILD_CFLAGS += -march=$(subst fd,,$(riscv-march-y))
 KBUILD_AFLAGS += -march=$(riscv-march-y)
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index dd6b05b..093050b 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -18,6 +18,7 @@
 #include <asm/ptrace.h>
 #include <asm/csr.h>
 
+#ifdef CONFIG_FPU
 extern void __fstate_save(struct task_struct *save_to);
 extern void __fstate_restore(struct task_struct *restore_from);
 
@@ -55,6 +56,15 @@ static inline void __switch_to_aux(struct task_struct *prev,
 	fstate_restore(next, task_pt_regs(next));
 }
 
+#define DEFAULT_SSTATUS (SR_SPIE | SR_FS_INITIAL)
+
+#else
+#define fstate_save(task, regs) do { } while (0)
+#define fstate_restore(task, regs) do { } while (0)
+#define __switch_to_aux(__prev, __next) do { } while (0)
+#define DEFAULT_SSTATUS (SR_SPIE | SR_FS_OFF)
+#endif
+
 extern struct task_struct *__switch_to(struct task_struct *,
 				       struct task_struct *);
 
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index bd433efd..f13f7f2 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -13,7 +13,6 @@ extra-y += vmlinux.lds
 obj-y	+= cpu.o
 obj-y	+= cpufeature.o
 obj-y	+= entry.o
-obj-y	+= fpu.o
 obj-y	+= irq.o
 obj-y	+= process.o
 obj-y	+= ptrace.o
@@ -32,6 +31,7 @@ obj-y	+= vdso/
 
 CFLAGS_setup.o := -mcmodel=medany
 
+obj-$(CONFIG_FPU)		+= fpu.o
 obj-$(CONFIG_SMP)		+= smpboot.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_MODULES)		+= module.o
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index d7c6ca7..07d5156 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -76,7 +76,7 @@ void show_regs(struct pt_regs *regs)
 void start_thread(struct pt_regs *regs, unsigned long pc,
 	unsigned long sp)
 {
-	regs->sstatus = SR_SPIE /* User mode, irqs on */ | SR_FS_INITIAL;
+	regs->sstatus = DEFAULT_SSTATUS;
 	regs->sepc = pc;
 	regs->sp = sp;
 	set_fs(USER_DS);
@@ -84,12 +84,14 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
 
 void flush_thread(void)
 {
+#ifdef CONFIG_FPU
 	/*
 	 * Reset FPU context
 	 *	frm: round to nearest, ties to even (IEEE default)
 	 *	fflags: accrued exceptions cleared
 	 */
 	memset(&current->thread.fstate, 0, sizeof(current->thread.fstate));
+#endif
 }
 
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 6a18b98..2450b82 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -37,6 +37,7 @@ struct rt_sigframe {
 	struct ucontext uc;
 };
 
+#ifdef CONFIG_FPU
 static long restore_fp_state(struct pt_regs *regs,
 			     union __riscv_fp_state *sc_fpregs)
 {
@@ -85,6 +86,10 @@ static long save_fp_state(struct pt_regs *regs,
 
 	return err;
 }
+#else
+#define save_fp_state(task, regs) (0)
+#define restore_fp_state(task, regs) (0)
+#endif
 
 static long restore_sigcontext(struct pt_regs *regs,
 	struct sigcontext __user *sc)
-- 
2.7.4

