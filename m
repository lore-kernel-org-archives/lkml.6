Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D096C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 03:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A9F21522
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 03:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A9F21522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbeHHFm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 01:42:58 -0400
Received: from exmail.andestech.com ([59.124.169.137]:21899 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbeHHFm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 01:42:58 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w783OTNV083368;
        Wed, 8 Aug 2018 11:24:29 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Wed, 8 Aug 2018
 11:25:19 +0800
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
Subject: [PATCH v4 5/5] Auto-detect whether a FPU exists
Date:   Wed, 8 Aug 2018 11:24:45 +0800
Message-ID: <1533698685-18022-6-git-send-email-alankao@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533698685-18022-1-git-send-email-alankao@andestech.com>
References: <1533698685-18022-1-git-send-email-alankao@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w783OTNV083368
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We expect that a kernel with CONFIG_FPU=y can still support no-FPU machines.
To do so, the kernel should first examine the existence of a FPU, then
do nothing if a FPU does exist; otherwise, it should disable/bypass all
FPU-related functions.

In this patch, a new global variable, no_fpu, is created and determined
when parsing the hardware capability from device tree during booting.
This variable is used in those FPU-related functions.

Signed-off-by: Alan Kao <alankao@andestech.com>
Cc: Greentime Hu <greentime@andestech.com>
Cc: Vincent Chen <vincentc@andestech.com>
Cc: Zong Li <zong@andestech.com>
Cc: Nick Hu <nickhu@andestech.com>
---
 arch/riscv/include/asm/hwcap.h     |  3 +++
 arch/riscv/include/asm/switch_to.h | 13 ++++++++++++-
 arch/riscv/kernel/cpufeature.c     | 11 +++++++++++
 arch/riscv/kernel/signal.c         |  6 ++++++
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 8a4ed7bbcbea..1b870086a869 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -33,5 +33,8 @@ enum {
 };
 
 extern unsigned long elf_hwcap;
+#ifdef CONFIG_FPU
+extern bool no_fpu;
+#endif
 #endif
 #endif
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 093050b03543..7278e3eb7a70 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -17,6 +17,7 @@
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/csr.h>
+#include <asm/hwcap.h>
 
 #ifdef CONFIG_FPU
 extern void __fstate_save(struct task_struct *save_to);
@@ -30,6 +31,9 @@ static inline void __fstate_clean(struct pt_regs *regs)
 static inline void fstate_save(struct task_struct *task,
 			       struct pt_regs *regs)
 {
+	if (unlikely(no_fpu))
+		return;
+
 	if ((regs->sstatus & SR_FS) == SR_FS_DIRTY) {
 		__fstate_save(task);
 		__fstate_clean(regs);
@@ -39,6 +43,9 @@ static inline void fstate_save(struct task_struct *task,
 static inline void fstate_restore(struct task_struct *task,
 				  struct pt_regs *regs)
 {
+	if (unlikely(no_fpu))
+		return;
+
 	if ((regs->sstatus & SR_FS) != SR_FS_OFF) {
 		__fstate_restore(task);
 		__fstate_clean(regs);
@@ -50,13 +57,17 @@ static inline void __switch_to_aux(struct task_struct *prev,
 {
 	struct pt_regs *regs;
 
+	if (unlikely(no_fpu))
+		return;
+
 	regs = task_pt_regs(prev);
 	if (unlikely(regs->sstatus & SR_SD))
 		fstate_save(prev, regs);
 	fstate_restore(next, task_pt_regs(next));
 }
 
-#define DEFAULT_SSTATUS (SR_SPIE | SR_FS_INITIAL)
+#define DEFAULT_SSTATUS \
+	((unlikely(no_fpu)) ? (SR_SPIE | SR_FS_OFF) : (SR_SPIE | SR_FS_INITIAL))
 
 #else
 #define fstate_save(task, regs) do { } while (0)
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 17011a870044..bc269c1e0b1a 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -22,6 +22,9 @@
 #include <asm/hwcap.h>
 
 unsigned long elf_hwcap __read_mostly;
+#ifdef CONFIG_FPU
+bool no_fpu __read_mostly;
+#endif
 
 void riscv_fill_hwcap(void)
 {
@@ -58,4 +61,12 @@ void riscv_fill_hwcap(void)
 		elf_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
 
 	pr_info("elf_hwcap is 0x%lx", elf_hwcap);
+
+#ifdef CONFIG_FPU
+	no_fpu = 0;
+	if (!(elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))) {
+		pr_info("Bypass FPU code.");
+		no_fpu = 1;
+	}
+#endif
 }
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 2450b824d799..9714e4fccb69 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -45,6 +45,9 @@ static long restore_fp_state(struct pt_regs *regs,
 	struct __riscv_d_ext_state __user *state = &sc_fpregs->d;
 	size_t i;
 
+	if (unlikely(no_fpu))
+		return 0;
+
 	err = __copy_from_user(&current->thread.fstate, state, sizeof(*state));
 	if (unlikely(err))
 		return err;
@@ -72,6 +75,9 @@ static long save_fp_state(struct pt_regs *regs,
 	struct __riscv_d_ext_state __user *state = &sc_fpregs->d;
 	size_t i;
 
+	if (unlikely(no_fpu))
+		return 0;
+
 	fstate_save(current, regs);
 	err = __copy_to_user(state, &current->thread.fstate, sizeof(*state));
 	if (unlikely(err))
-- 
2.18.0

