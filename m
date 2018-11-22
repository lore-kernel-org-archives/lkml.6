Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FBBC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA9D206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA9D206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391919AbeKVNwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:52:32 -0500
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:12918 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729224AbeKVNwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 08:52:32 -0500
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id wAM3EE8b012551;
        Thu, 22 Nov 2018 11:14:14 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 22 Nov 2018
 11:14:58 +0800
From:   Vincent Chen <vincentc@andestech.com>
To:     <green.hu@gmail.com>, <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, <vincentc@andestech.com>
Subject: [PATCH v4 3/5] nds32: support denormalized result through FP emulator
Date:   Thu, 22 Nov 2018 11:14:36 +0800
Message-ID: <1542856478-795-4-git-send-email-vincentc@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542856478-795-1-git-send-email-vincentc@andestech.com>
References: <1542856478-795-1-git-send-email-vincentc@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com wAM3EE8b012551
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the nds32 FPU dose not support the arithmetic of denormalized
number. When the nds32 FPU finds the result of the instruction is a
denormlized number, the nds32 FPU considers it to be an underflow condition
and rounds the result to an appropriate number. It may causes some loss
of precision. This commit proposes a solution to re-execute the
instruction by the FPU emulator to enhance the precision. To transfer
calculations from user space to kernel space, this feature will enable
the underflow exception trap by default. Enabling this feature may cause
some side effects:
  1. Performance loss due to extra FPU exception
  2. Need another scheme to control real underflow trap
       A new parameter, UDF_trap, which is belong to FPU context is used
     to control underflow trap.

User can configure this feature via CONFIG_SUPPORT_DENORMAL_ARITHMETIC

Signed-off-by: Vincent Chen <vincentc@andestech.com>
---
 arch/nds32/Kconfig.cpu                   |   13 ++++++++++++
 arch/nds32/include/asm/elf.h             |   11 ++++++++++
 arch/nds32/include/asm/fpu.h             |   11 ++++++++++
 arch/nds32/include/asm/syscalls.h        |    1 +
 arch/nds32/include/uapi/asm/auxvec.h     |    7 ++++++
 arch/nds32/include/uapi/asm/sigcontext.h |    9 ++++++++
 arch/nds32/include/uapi/asm/udftrap.h    |   13 ++++++++++++
 arch/nds32/include/uapi/asm/unistd.h     |    2 +
 arch/nds32/kernel/fpu.c                  |   25 +++++++++++++++++++---
 arch/nds32/kernel/sys_nds32.c            |   32 ++++++++++++++++++++++++++++++
 arch/nds32/math-emu/fpuemu.c             |    5 ++++
 11 files changed, 125 insertions(+), 4 deletions(-)
 create mode 100644 arch/nds32/include/uapi/asm/udftrap.h

diff --git a/arch/nds32/Kconfig.cpu b/arch/nds32/Kconfig.cpu
index 593d0c2..3aad9e4 100644
--- a/arch/nds32/Kconfig.cpu
+++ b/arch/nds32/Kconfig.cpu
@@ -28,6 +28,19 @@ config LAZY_FPU
 
 	  For nomal case, say Y.
 
+config SUPPORT_DENORMAL_ARITHMETIC
+	bool "Denormal arithmetic support"
+	depends on FPU
+	default n
+	help
+	  Say Y here to enable arithmetic of denormalized number. Enabling
+	  this feature can enhance the precision for tininess number.
+	  However, performance loss in float pointe calculations is
+	  possibly significant due to additional FPU exception.
+
+	  If the calculated tolerance for tininess number is not critical,
+	  say N to prevent performance loss.
+
 config HWZOL
 	bool "hardware zero overhead loop support"
 	depends on CPU_D10 || CPU_D15
diff --git a/arch/nds32/include/asm/elf.h b/arch/nds32/include/asm/elf.h
index f5f9cf7..95f3ea2 100644
--- a/arch/nds32/include/asm/elf.h
+++ b/arch/nds32/include/asm/elf.h
@@ -9,6 +9,7 @@
  */
 
 #include <asm/ptrace.h>
+#include <asm/fpu.h>
 
 typedef unsigned long elf_greg_t;
 typedef unsigned long elf_freg_t[3];
@@ -159,8 +160,18 @@ struct user_fp {
 
 #endif
 
+
+#if IS_ENABLED(CONFIG_FPU)
+#define FPU_AUX_ENT	NEW_AUX_ENT(AT_FPUCW, FPCSR_INIT)
+#else
+#define FPU_AUX_ENT	NEW_AUX_ENT(AT_IGNORE, 0)
+#endif
+
 #define ARCH_DLINFO						\
 do {								\
+	/* Optional FPU initialization */			\
+	FPU_AUX_ENT;						\
+								\
 	NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
 		    (elf_addr_t)current->mm->context.vdso);	\
 } while (0)
diff --git a/arch/nds32/include/asm/fpu.h b/arch/nds32/include/asm/fpu.h
index 9b1107b..019f1bc 100644
--- a/arch/nds32/include/asm/fpu.h
+++ b/arch/nds32/include/asm/fpu.h
@@ -28,7 +28,18 @@
 #define sNAN64    0xFFFFFFFFFFFFFFFFULL
 #define sNAN32    0xFFFFFFFFUL
 
+#if IS_ENABLED(CONFIG_SUPPORT_DENORMAL_ARITHMETIC)
+/*
+ * Denormalized number is unsupported by nds32 FPU. Hence the operation
+ * is treated as underflow cases when the final result is a denormalized
+ * number. To enhance precision, underflow exception trap should be
+ * enabled by default and kerenl will re-execute it by fpu emulator
+ * when getting underflow exception.
+ */
+#define FPCSR_INIT  FPCSR_mskUDFE
+#else
 #define FPCSR_INIT  0x0UL
+#endif
 
 extern const struct fpu_struct init_fpuregs;
 
diff --git a/arch/nds32/include/asm/syscalls.h b/arch/nds32/include/asm/syscalls.h
index 78778ec..da32101 100644
--- a/arch/nds32/include/asm/syscalls.h
+++ b/arch/nds32/include/asm/syscalls.h
@@ -7,6 +7,7 @@
 asmlinkage long sys_cacheflush(unsigned long addr, unsigned long len, unsigned int op);
 asmlinkage long sys_fadvise64_64_wrapper(int fd, int advice, loff_t offset, loff_t len);
 asmlinkage long sys_rt_sigreturn_wrapper(void);
+asmlinkage long sys_udftrap(int option);
 
 #include <asm-generic/syscalls.h>
 
diff --git a/arch/nds32/include/uapi/asm/auxvec.h b/arch/nds32/include/uapi/asm/auxvec.h
index 56043ce..2d3213f 100644
--- a/arch/nds32/include/uapi/asm/auxvec.h
+++ b/arch/nds32/include/uapi/asm/auxvec.h
@@ -4,6 +4,13 @@
 #ifndef __ASM_AUXVEC_H
 #define __ASM_AUXVEC_H
 
+/*
+ * This entry gives some information about the FPU initialization
+ * performed by the kernel.
+ */
+#define AT_FPUCW	18	/* Used FPU control word.  */
+
+
 /* VDSO location */
 #define AT_SYSINFO_EHDR	33
 
diff --git a/arch/nds32/include/uapi/asm/sigcontext.h b/arch/nds32/include/uapi/asm/sigcontext.h
index 1257a78..58afc41 100644
--- a/arch/nds32/include/uapi/asm/sigcontext.h
+++ b/arch/nds32/include/uapi/asm/sigcontext.h
@@ -12,6 +12,15 @@
 struct fpu_struct {
 	unsigned long long fd_regs[32];
 	unsigned long fpcsr;
+	/*
+	 * UDF_trap is used to recognize whether underflow trap is enabled
+	 * or not. When UDF_trap == 1, this process will be traped and then
+	 * get a SIGFPE signal when encountering an underflow exception.
+	 * UDF_trap is only modified through setfputrap syscall. Therefore,
+	 * UDF_trap needn't be saved or loaded to context in each context
+	 * switch.
+	 */
+	unsigned long UDF_trap;
 };
 
 struct zol_struct {
diff --git a/arch/nds32/include/uapi/asm/udftrap.h b/arch/nds32/include/uapi/asm/udftrap.h
new file mode 100644
index 0000000..433f79d
--- /dev/null
+++ b/arch/nds32/include/uapi/asm/udftrap.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2005-2018 Andes Technology Corporation */
+#ifndef	_ASM_SETFPUTRAP
+#define	_ASM_SETFPUTRAP
+
+/*
+ * Options for setfputrap system call
+ */
+#define	DISABLE_UDFTRAP	0	/* disable underflow exception trap */
+#define	ENABLE_UDFTRAP	1	/* enable undeflos exception trap */
+#define	GET_UDFTRAP	2	/* only get undeflos exception trap status */
+
+#endif /* _ASM_CACHECTL */
diff --git a/arch/nds32/include/uapi/asm/unistd.h b/arch/nds32/include/uapi/asm/unistd.h
index 6e95901..199e675 100644
--- a/arch/nds32/include/uapi/asm/unistd.h
+++ b/arch/nds32/include/uapi/asm/unistd.h
@@ -8,4 +8,6 @@
 
 /* Additional NDS32 specific syscalls. */
 #define __NR_cacheflush		(__NR_arch_specific_syscall)
+#define __NR_udftrap		(__NR_arch_specific_syscall + 1)
 __SYSCALL(__NR_cacheflush, sys_cacheflush)
+__SYSCALL(__NR_udftrap, sys_udftrap)
diff --git a/arch/nds32/kernel/fpu.c b/arch/nds32/kernel/fpu.c
index 2942df6..fddd40c 100644
--- a/arch/nds32/kernel/fpu.c
+++ b/arch/nds32/kernel/fpu.c
@@ -12,7 +12,10 @@
 
 const struct fpu_struct init_fpuregs = {
 	.fd_regs = {[0 ... 31] = sNAN64},
-	.fpcsr = FPCSR_INIT
+	.fpcsr = FPCSR_INIT,
+#if IS_ENABLED(CONFIG_SUPPORT_DENORMAL_ARITHMETIC)
+	.UDF_trap = 0
+#endif
 };
 
 void save_fpu(struct task_struct *tsk)
@@ -174,6 +177,9 @@ inline void do_fpu_context_switch(struct pt_regs *regs)
 	} else {
 		/* First time FPU user.  */
 		load_fpu(&init_fpuregs);
+#if IS_ENABLED(CONFIG_SUPPORT_DENORMAL_ARITHMETIC)
+		current->thread.fpu.UDF_trap = init_fpuregs.UDF_trap;
+#endif
 		set_used_math();
 	}
 
@@ -183,10 +189,12 @@ inline void fill_sigfpe_signo(unsigned int fpcsr, int *signo)
 {
 	if (fpcsr & FPCSR_mskOVFT)
 		*signo = FPE_FLTOVF;
-	else if (fpcsr & FPCSR_mskIVOT)
-		*signo = FPE_FLTINV;
+#ifndef CONFIG_SUPPORT_DENORMAL_ARITHMETIC
 	else if (fpcsr & FPCSR_mskUDFT)
 		*signo = FPE_FLTUND;
+#endif
+	else if (fpcsr & FPCSR_mskIVOT)
+		*signo = FPE_FLTINV;
 	else if (fpcsr & FPCSR_mskDBZT)
 		*signo = FPE_FLTDIV;
 	else if (fpcsr & FPCSR_mskIEXT)
@@ -197,11 +205,20 @@ inline void handle_fpu_exception(struct pt_regs *regs)
 {
 	unsigned int fpcsr;
 	int si_code = 0, si_signo = SIGFPE;
+#if IS_ENABLED(CONFIG_SUPPORT_DENORMAL_ARITHMETIC)
+	unsigned long redo_except = FPCSR_mskDNIT|FPCSR_mskUDFT;
+#else
+	unsigned long redo_except = FPCSR_mskDNIT;
+#endif
 
 	lose_fpu();
 	fpcsr = current->thread.fpu.fpcsr;
 
-	if (fpcsr & FPCSR_mskDNIT) {
+	if (fpcsr & redo_except) {
+#if IS_ENABLED(CONFIG_SUPPORT_DENORMAL_ARITHMETIC)
+		if (fpcsr & FPCSR_mskUDFT)
+			current->thread.fpu.fpcsr &= ~FPCSR_mskIEX;
+#endif
 		si_signo = do_fpuemu(regs, &current->thread.fpu);
 		fpcsr = current->thread.fpu.fpcsr;
 		if (!si_signo)
diff --git a/arch/nds32/kernel/sys_nds32.c b/arch/nds32/kernel/sys_nds32.c
index 9de93ab..0835277 100644
--- a/arch/nds32/kernel/sys_nds32.c
+++ b/arch/nds32/kernel/sys_nds32.c
@@ -6,6 +6,8 @@
 
 #include <asm/cachectl.h>
 #include <asm/proc-fns.h>
+#include <asm/udftrap.h>
+#include <asm/fpu.h>
 
 SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
 	       unsigned long, prot, unsigned long, flags,
@@ -48,3 +50,33 @@
 
 	return 0;
 }
+
+SYSCALL_DEFINE1(udftrap, int, option)
+{
+#if IS_ENABLED(CONFIG_SUPPORT_DENORMAL_ARITHMETIC)
+	int old_udftrap;
+
+	if (!used_math()) {
+		load_fpu(&init_fpuregs);
+		current->thread.fpu.UDF_trap = init_fpuregs.UDF_trap;
+		set_used_math();
+	}
+
+	old_udftrap = current->thread.fpu.UDF_trap;
+	switch (option) {
+	case DISABLE_UDFTRAP:
+		current->thread.fpu.UDF_trap = 0;
+		break;
+	case ENABLE_UDFTRAP:
+		current->thread.fpu.UDF_trap = FPCSR_mskUDFE;
+		break;
+	case GET_UDFTRAP:
+		break;
+	default:
+		return -EINVAL;
+	}
+	return old_udftrap;
+#else
+	return -ENOTSUPP;
+#endif
+}
diff --git a/arch/nds32/math-emu/fpuemu.c b/arch/nds32/math-emu/fpuemu.c
index 2a01333..75cf164 100644
--- a/arch/nds32/math-emu/fpuemu.c
+++ b/arch/nds32/math-emu/fpuemu.c
@@ -304,7 +304,12 @@ static int fpu_emu(struct fpu_struct *fpu_reg, unsigned long insn)
 	/*
 	 * If an exception is required, generate a tidy SIGFPE exception.
 	 */
+#if IS_ENABLED(CONFIG_SUPPORT_DENORMAL_ARITHMETIC)
+	if (((fpu_reg->fpcsr << 5) & fpu_reg->fpcsr & FPCSR_mskALLE_NO_UDFE) ||
+	    ((fpu_reg->fpcsr & FPCSR_mskUDF) && (fpu_reg->UDF_trap)))
+#else
 	if ((fpu_reg->fpcsr << 5) & fpu_reg->fpcsr & FPCSR_mskALLE)
+#endif
 		return SIGFPE;
 	return 0;
 }
-- 
1.7.1

