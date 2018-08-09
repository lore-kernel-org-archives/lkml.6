Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF73C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A1921B31
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A1921B31
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbeHIIun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 04:50:43 -0400
Received: from exmail.andestech.com ([59.124.169.137]:52877 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbeHIIum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 04:50:42 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w796QKMV087905;
        Thu, 9 Aug 2018 14:26:20 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 9 Aug 2018
 14:27:14 +0800
From:   Alan Kao <alankao@andestech.com>
To:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        "Palmer Dabbelt" <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, Darius Rad <darius@bluespec.com>
CC:     <greentime@andestech.com>, <vincentc@andestech.com>,
        <zong@andestech.com>, <nickhu@andestech.com>,
        Alan Kao <alankao@andestech.com>
Subject: [PATCH v5 5/5] Auto-detect whether a FPU exists
Date:   Thu, 9 Aug 2018 14:26:43 +0800
Message-ID: <1533796003-680-6-git-send-email-alankao@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533796003-680-1-git-send-email-alankao@andestech.com>
References: <1533796003-680-1-git-send-email-alankao@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w796QKMV087905
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We expect that a kernel with CONFIG_FPU=y can still support no-FPU
machines. To do so, the kernel should first examine the existence of a
FPU, then do nothing if a FPU does exist; otherwise, it should
disable/bypass all FPU-related functions.

In this patch, a new global variable, has_fpu, is created and determined
when parsing the hardware capability from device tree during booting.
This variable is used in those FPU-related functions.

Signed-off-by: Alan Kao <alankao@andestech.com>
Cc: Greentime Hu <greentime@andestech.com>
Cc: Vincent Chen <vincentc@andestech.com>
Cc: Zong Li <zong@andestech.com>
Cc: Nick Hu <nickhu@andestech.com>
---
 arch/riscv/include/asm/hwcap.h     | 1 +
 arch/riscv/include/asm/switch_to.h | 9 +++++----
 arch/riscv/kernel/cpufeature.c     | 8 ++++++++
 arch/riscv/kernel/process.c        | 4 +++-
 arch/riscv/kernel/signal.c         | 6 ++++--
 5 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 8a4ed7bbcbea..b0da2cbfb468 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -33,5 +33,6 @@ enum {
 };
 
 extern unsigned long elf_hwcap;
+extern bool has_fpu;
 #endif
 #endif
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 093050b03543..7943f991bd86 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -17,6 +17,7 @@
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/csr.h>
+#include <asm/hwcap.h>
 
 #ifdef CONFIG_FPU
 extern void __fstate_save(struct task_struct *save_to);
@@ -56,13 +57,12 @@ static inline void __switch_to_aux(struct task_struct *prev,
 	fstate_restore(next, task_pt_regs(next));
 }
 
-#define DEFAULT_SSTATUS (SR_SPIE | SR_FS_INITIAL)
-
+extern bool has_fpu;
 #else
+#define has_fpu false
 #define fstate_save(task, regs) do { } while (0)
 #define fstate_restore(task, regs) do { } while (0)
 #define __switch_to_aux(__prev, __next) do { } while (0)
-#define DEFAULT_SSTATUS (SR_SPIE | SR_FS_OFF)
 #endif
 
 extern struct task_struct *__switch_to(struct task_struct *,
@@ -72,7 +72,8 @@ extern struct task_struct *__switch_to(struct task_struct *,
 do {							\
 	struct task_struct *__prev = (prev);		\
 	struct task_struct *__next = (next);		\
-	__switch_to_aux(__prev, __next);		\
+	if (has_fpu)					\
+		__switch_to_aux(__prev, __next);	\
 	((last) = __switch_to(__prev, __next));		\
 } while (0)
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 17011a870044..46942e635266 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -22,6 +22,9 @@
 #include <asm/hwcap.h>
 
 unsigned long elf_hwcap __read_mostly;
+#ifdef CONFIG_FPU
+bool has_fpu __read_mostly;
+#endif
 
 void riscv_fill_hwcap(void)
 {
@@ -58,4 +61,9 @@ void riscv_fill_hwcap(void)
 		elf_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
 
 	pr_info("elf_hwcap is 0x%lx", elf_hwcap);
+
+#ifdef CONFIG_FPU
+	if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))
+		has_fpu = true;
+#endif
 }
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 3820d89e2db9..97155aee9e71 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -83,7 +83,9 @@ void show_regs(struct pt_regs *regs)
 void start_thread(struct pt_regs *regs, unsigned long pc,
 	unsigned long sp)
 {
-	regs->sstatus = DEFAULT_SSTATUS;
+	regs->sstatus = SR_SPIE;
+	if (has_fpu)
+		regs->sstatus |= SR_FS_INITIAL;
 	regs->sepc = pc;
 	regs->sp = sp;
 	set_fs(USER_DS);
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 2450b824d799..f9b5e7e352ef 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -98,7 +98,8 @@ static long restore_sigcontext(struct pt_regs *regs,
 	/* sc_regs is structured the same as the start of pt_regs */
 	err = __copy_from_user(regs, &sc->sc_regs, sizeof(sc->sc_regs));
 	/* Restore the floating-point state. */
-	err |= restore_fp_state(regs, &sc->sc_fpregs);
+	if (has_fpu)
+		err |= restore_fp_state(regs, &sc->sc_fpregs);
 	return err;
 }
 
@@ -150,7 +151,8 @@ static long setup_sigcontext(struct rt_sigframe __user *frame,
 	/* sc_regs is structured the same as the start of pt_regs */
 	err = __copy_to_user(&sc->sc_regs, regs, sizeof(sc->sc_regs));
 	/* Save the floating-point state. */
-	err |= save_fp_state(regs, &sc->sc_fpregs);
+	if (has_fpu)
+		err |= save_fp_state(regs, &sc->sc_fpregs);
 	return err;
 }
 
-- 
2.18.0

