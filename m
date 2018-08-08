Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EA8C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 03:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF4821522
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 03:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF4821522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeHHFmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 01:42:54 -0400
Received: from exmail.andestech.com ([59.124.169.137]:55635 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbeHHFmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 01:42:53 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w783OOsR083355;
        Wed, 8 Aug 2018 11:24:24 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Wed, 8 Aug 2018
 11:25:14 +0800
From:   Alan Kao <alankao@andestech.com>
To:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        "Palmer Dabbelt" <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, Darius Rad <darius@bluespec.com>
CC:     Alan Kao <alankao@andestech.com>,
        Greentime Hu <greentime@andestech.com>,
        Vincent Chen <vincentc@andestech.com>,
        Zong Li <zong@andestech.com>, Nick Hu <nickhu@andestech.com>
Subject: [PATCH v4 4/5] Allow to disable FPU support
Date:   Wed, 8 Aug 2018 11:24:44 +0800
Message-ID: <1533698685-18022-5-git-send-email-alankao@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533698685-18022-1-git-send-email-alankao@andestech.com>
References: <1533698685-18022-1-git-send-email-alankao@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w783OOsR083355
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
---
 arch/riscv/Kconfig                 |  9 +++++++++
 arch/riscv/include/asm/switch_to.h | 10 ++++++++++
 arch/riscv/kernel/Makefile         |  2 +-
 arch/riscv/kernel/process.c        |  4 +++-
 arch/riscv/kernel/signal.c         |  5 +++++
 5 files changed, 28 insertions(+), 2 deletions(-)

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
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index dd6b05bff75b..093050b03543 100644
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
index bd433efd915e..f13f7f276639 100644
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
index cb209139ba53..3820d89e2db9 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -83,7 +83,7 @@ void show_regs(struct pt_regs *regs)
 void start_thread(struct pt_regs *regs, unsigned long pc,
 	unsigned long sp)
 {
-	regs->sstatus = SR_SPIE /* User mode, irqs on */ | SR_FS_INITIAL;
+	regs->sstatus = DEFAULT_SSTATUS;
 	regs->sepc = pc;
 	regs->sp = sp;
 	set_fs(USER_DS);
@@ -91,12 +91,14 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
 
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
index 6a18b9819ead..2450b824d799 100644
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
2.18.0

