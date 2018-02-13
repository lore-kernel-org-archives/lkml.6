Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754233AbeBMFnT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 00:43:19 -0500
Received: from exmail.andestech.com ([59.124.169.137]:44204 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752400AbeBMFmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 00:42:18 -0500
From: Alan Kao <alankao@andestech.com>
To: Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        "Steven Rostedt" <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        <patches@groups.riscv.org>, <linux-kernel@vger.kernel.org>,
        <greentime@andestech.com>
CC: Alan Kao <alankao@andestech.com>
Subject: [PATCH v4 2/6] riscv/ftrace: Add dynamic function tracer support
Date: Tue, 13 Feb 2018 13:13:17 +0800
Message-ID: <1518498801-677-3-git-send-email-alankao@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518498801-677-1-git-send-email-alankao@andestech.com>
References: <1518498801-677-1-git-send-email-alankao@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w1D5G6vM046223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now have dynamic ftrace with the following added items:

* ftrace_make_call, ftrace_make_nop (in kernel/ftrace.c)
  The two functions turn each recorded call site of filtered functions
  into a call to ftrace_caller or nops

* ftracce_update_ftrace_func (in kernel/ftrace.c)
  turns the nops at ftrace_call into a call to a generic entry for
  function tracers.

* ftrace_caller (in kernel/mcount-dyn.S)
  The entry where each _mcount call sites calls to once they are
  filtered to be traced.

Also, this patch fixes the semantic problems in mcount.S, which will be
treated as only a reference implementation once we have the dynamic
ftrace.

Cc: Greentime Hu <greentime@andestech.com>
Signed-off-by: Alan Kao <alankao@andestech.com>
---
 arch/riscv/Kconfig              |   1 +
 arch/riscv/include/asm/ftrace.h |  54 +++++++++++++++++++++
 arch/riscv/kernel/Makefile      |   5 +-
 arch/riscv/kernel/ftrace.c      | 103 +++++++++++++++++++++++++++++++++++++++-
 arch/riscv/kernel/mcount-dyn.S  |  50 +++++++++++++++++++
 arch/riscv/kernel/mcount.S      |  22 +++++----
 6 files changed, 223 insertions(+), 12 deletions(-)
 create mode 100644 arch/riscv/kernel/mcount-dyn.S

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 570af19a54ea..df05acbb53d3 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -121,6 +121,7 @@ config ARCH_RV64I
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FTRACE_MCOUNT_RECORD
+	select HAVE_DYNAMIC_FTRACE
 
 endchoice
 
diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 66d4175eb13e..078743aacfd3 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -8,3 +8,57 @@
 #if defined(CONFIG_FUNCTION_GRAPH_TRACER) && defined(CONFIG_FRAME_POINTER)
 #define HAVE_FUNCTION_GRAPH_FP_TEST
 #endif
+
+#ifndef __ASSEMBLY__
+void _mcount(void);
+static inline unsigned long ftrace_call_adjust(unsigned long addr)
+{
+	return addr;
+}
+
+struct dyn_arch_ftrace {
+};
+#endif
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+/*
+ * A general call in RISC-V is a pair of insts:
+ * 1) auipc: setting high-20 pc-related bits to ra register
+ * 2) jalr: setting low-12 offset to ra, jump to ra, and set ra to
+ *          return address (original pc + 4)
+ *
+ * Dynamic ftrace generates probes to call sites, so we must deal with
+ * both auipc and jalr at the same time.
+ */
+
+#define MCOUNT_ADDR		((unsigned long)_mcount)
+#define JALR_SIGN_MASK		(0x00000800)
+#define JALR_OFFSET_MASK	(0x00000fff)
+#define AUIPC_OFFSET_MASK	(0xfffff000)
+#define AUIPC_PAD		(0x00001000)
+#define JALR_SHIFT		20
+#define JALR_BASIC		(0x000080e7)
+#define AUIPC_BASIC		(0x00000097)
+#define NOP4			(0x00000013)
+
+#define make_call(caller, callee, call)					\
+do {									\
+	call[0] = to_auipc_insn((unsigned int)((unsigned long)callee -	\
+				(unsigned long)caller));		\
+	call[1] = to_jalr_insn((unsigned int)((unsigned long)callee -	\
+			       (unsigned long)caller));			\
+} while (0)
+
+#define to_jalr_insn(offset)						\
+	(((offset & JALR_OFFSET_MASK) << JALR_SHIFT) | JALR_BASIC)
+
+#define to_auipc_insn(offset)						\
+	((offset & JALR_SIGN_MASK) ?					\
+	(((offset & AUIPC_OFFSET_MASK) + AUIPC_PAD) | AUIPC_BASIC) :	\
+	((offset & AUIPC_OFFSET_MASK) | AUIPC_BASIC))
+
+/*
+ * Let auipc+jalr be the basic *mcount unit*, so we make it 8 bytes here.
+ */
+#define MCOUNT_INSN_SIZE 8
+#endif
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 196f62ffc428..d7bdf888f1ca 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -34,7 +34,8 @@ CFLAGS_setup.o := -mcmodel=medany
 obj-$(CONFIG_SMP)		+= smpboot.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_MODULES)		+= module.o
-obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o
-obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o
+
+obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
+obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
 
 clean:
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index d0de68d144cb..be4b24332d97 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -6,9 +6,109 @@
  */
 
 #include <linux/ftrace.h>
+#include <linux/uaccess.h>
+#include <asm/cacheflush.h>
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+static int ftrace_check_current_call(unsigned long hook_pos,
+				     unsigned int *expected)
+{
+	unsigned int replaced[2];
+	unsigned int nops[2] = {NOP4, NOP4};
+
+	/* we expect nops at the hook position */
+	if (!expected)
+		expected = nops;
+
+	/*
+	 * Read the text we want to modify;
+	 * return must be -EFAULT on read error
+	 */
+	if (probe_kernel_read(replaced, (void *)hook_pos, MCOUNT_INSN_SIZE))
+		return -EFAULT;
+
+	/*
+	 * Make sure it is what we expect it to be;
+	 * return must be -EINVAL on failed comparison
+	 */
+	if (memcmp(expected, replaced, sizeof(replaced))) {
+		pr_err("%p: expected (%08x %08x) but get (%08x %08x)",
+		       (void *)hook_pos, expected[0], expected[1], replaced[0],
+		       replaced[1]);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target,
+				bool enable)
+{
+	unsigned int call[2];
+	unsigned int nops[2] = {NOP4, NOP4};
+	int ret = 0;
+
+	make_call(hook_pos, target, call);
+
+	/* replace the auipc-jalr pair at once */
+	ret = probe_kernel_write((void *)hook_pos, enable ? call : nops,
+				 MCOUNT_INSN_SIZE);
+	/* return must be -EPERM on write error */
+	if (ret)
+		return -EPERM;
+
+	smp_mb();
+	flush_icache_range((void *)hook_pos, (void *)hook_pos + MCOUNT_INSN_SIZE);
+
+	return 0;
+}
+
+int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+{
+	int ret = ftrace_check_current_call(rec->ip, NULL);
+
+	if (ret)
+		return ret;
+
+	return __ftrace_modify_call(rec->ip, addr, true);
+}
+
+int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
+		    unsigned long addr)
+{
+	unsigned int call[2];
+	int ret;
+
+	make_call(rec->ip, addr, call);
+	ret = ftrace_check_current_call(rec->ip, call);
+
+	if (ret)
+		return ret;
+
+	return __ftrace_modify_call(rec->ip, addr, false);
+}
+
+int ftrace_update_ftrace_func(ftrace_func_t func)
+{
+	int ret = __ftrace_modify_call((unsigned long)&ftrace_call,
+				       (unsigned long)func, true);
+	if (!ret) {
+		ret = __ftrace_modify_call((unsigned long)&ftrace_regs_call,
+					   (unsigned long)func, true);
+	}
+
+	return ret;
+}
+
+int __init ftrace_dyn_arch_init(void)
+{
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
 /*
- * Most of this file is copied from arm64.
+ * Most of this function is copied from arm64.
  */
 void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 			   unsigned long frame_pointer)
@@ -39,3 +139,4 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 		return;
 	*parent = return_hooker;
 }
+#endif
diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
new file mode 100644
index 000000000000..a3ebeadbe698
--- /dev/null
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2017 Andes Technology Corporation */
+
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <asm/asm.h>
+#include <asm/csr.h>
+#include <asm/unistd.h>
+#include <asm/thread_info.h>
+#include <asm/asm-offsets.h>
+#include <asm-generic/export.h>
+#include <asm/ftrace.h>
+
+	.text
+
+	.macro SAVE_ABI_STATE
+	addi	sp, sp, -16
+	sd	s0, 0(sp)
+	sd	ra, 8(sp)
+	addi	s0, sp, 16
+	.endm
+
+	.macro RESTORE_ABI_STATE
+	ld	ra, 8(sp)
+	ld	s0, 0(sp)
+	addi	sp, sp, 16
+	.endm
+
+ENTRY(ftrace_caller)
+	/*
+	 * a0: the address in the caller when calling ftrace_caller
+	 * a1: the caller's return address
+	 */
+	ld	a1, -8(s0)
+	addi	a0, ra, -MCOUNT_INSN_SIZE
+	SAVE_ABI_STATE
+ftrace_call:
+	.global ftrace_call
+	/*
+	 * For the dynamic ftrace to work, here we should reserve at least
+	 * 8 bytes for a functional auipc-jalr pair.  The following call
+	 * serves this purpose.
+	 *
+	 * Calling ftrace_update_ftrace_func would overwrite the nops below.
+	 * Check ftrace_modify_all_code for details.
+	 */
+	call	ftrace_stub
+	RESTORE_ABI_STATE
+	ret
+ENDPROC(ftrace_caller)
diff --git a/arch/riscv/kernel/mcount.S b/arch/riscv/kernel/mcount.S
index c46a778627be..ce9bdc57a2a1 100644
--- a/arch/riscv/kernel/mcount.S
+++ b/arch/riscv/kernel/mcount.S
@@ -32,13 +32,13 @@
 	addi	s0, sp, 32
 	.endm
 
-	.macro STORE_ABI_STATE
+	.macro RESTORE_ABI_STATE
 	ld	ra, 8(sp)
 	ld	s0, 0(sp)
 	addi	sp, sp, 16
 	.endm
 
-	.macro STORE_RET_ABI_STATE
+	.macro RESTORE_RET_ABI_STATE
 	ld	ra, 24(sp)
 	ld	s0, 16(sp)
 	ld	a0, 8(sp)
@@ -46,6 +46,10 @@
 	.endm
 
 ENTRY(ftrace_stub)
+#ifdef CONFIG_DYNAMIC_FTRACE
+       .global _mcount
+       .set    _mcount, ftrace_stub
+#endif
 	ret
 ENDPROC(ftrace_stub)
 
@@ -66,15 +70,15 @@ ENTRY(return_to_handler)
 #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
 	mv	a0, t6
 #endif
-	la	t0, ftrace_return_to_handler
-	jalr	t0
+	call	ftrace_return_to_handler
 	mv	a1, a0
-	STORE_RET_ABI_STATE
+	RESTORE_RET_ABI_STATE
 	jalr	a1
 ENDPROC(return_to_handler)
 EXPORT_SYMBOL(return_to_handler)
 #endif
 
+#ifndef CONFIG_DYNAMIC_FTRACE
 ENTRY(_mcount)
 	la	t4, ftrace_stub
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
@@ -104,9 +108,8 @@ do_ftrace_graph_caller:
 	ld	a2, -16(s0)
 #endif
 	SAVE_ABI_STATE
-	la	t0, prepare_ftrace_return
-	jalr	t0
-	STORE_ABI_STATE
+	call	prepare_ftrace_return
+	RESTORE_ABI_STATE
 	ret
 #endif
 
@@ -120,7 +123,8 @@ do_trace:
 
 	SAVE_ABI_STATE
 	jalr	t5
-	STORE_ABI_STATE
+	RESTORE_ABI_STATE
 	ret
 ENDPROC(_mcount)
 EXPORT_SYMBOL(_mcount)
+#endif
-- 
2.15.1
