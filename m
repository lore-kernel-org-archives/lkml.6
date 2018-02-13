Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754179AbeBMFmr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 00:42:47 -0500
Received: from exmail.andestech.com ([59.124.169.137]:7717 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754054AbeBMFmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 00:42:24 -0500
From: Alan Kao <alankao@andestech.com>
To: Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        "Steven Rostedt" <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        <patches@groups.riscv.org>, <linux-kernel@vger.kernel.org>,
        <greentime@andestech.com>
CC: Alan Kao <alankao@andestech.com>
Subject: [PATCH v4 5/6] riscv/ftrace: Add DYNAMIC_FTRACE_WITH_REGS support
Date: Tue, 13 Feb 2018 13:13:20 +0800
Message-ID: <1518498801-677-6-git-send-email-alankao@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518498801-677-1-git-send-email-alankao@andestech.com>
References: <1518498801-677-1-git-send-email-alankao@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w1D5GLDK046266
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Greentime Hu <greentime@andestech.com>
Signed-off-by: Alan Kao <alankao@andestech.com>
---
 arch/riscv/Kconfig              |   1 +
 arch/riscv/include/asm/ftrace.h |   1 +
 arch/riscv/kernel/ftrace.c      |  17 ++++++
 arch/riscv/kernel/mcount-dyn.S  | 122 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 141 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index df05acbb53d3..e4f9bac8ed76 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -122,6 +122,7 @@ config ARCH_RV64I
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_DYNAMIC_FTRACE
+	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 
 endchoice
 
diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index fedadc40e358..c6dcc5291f97 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -8,6 +8,7 @@
 #if defined(CONFIG_FUNCTION_GRAPH_TRACER) && defined(CONFIG_FRAME_POINTER)
 #define HAVE_FUNCTION_GRAPH_FP_TEST
 #endif
+#define HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
 
 #define ARCH_SUPPORTS_FTRACE_OPS 1
 #ifndef __ASSEMBLY__
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 5bbe1afd9463..48b5353691c3 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -106,6 +106,23 @@ int __init ftrace_dyn_arch_init(void)
 }
 #endif
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
+		       unsigned long addr)
+{
+	unsigned int call[2];
+	int ret;
+
+	make_call(rec->ip, old_addr, call);
+	ret = ftrace_check_current_call(rec->ip, call);
+
+	if (ret)
+		return ret;
+
+	return __ftrace_modify_call(rec->ip, addr, true);
+}
+#endif
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 /*
  * Most of this function is copied from arm64.
diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index 6bbc3f88fcb3..35a6ed76cb8b 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -115,3 +115,125 @@ ftrace_call:
 	RESTORE_ABI_STATE
 	ret
 ENDPROC(ftrace_caller)
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+	.macro SAVE_ALL
+	addi	sp, sp, -(PT_SIZE_ON_STACK+16)
+	sd	s0, (PT_SIZE_ON_STACK)(sp)
+	sd	ra, (PT_SIZE_ON_STACK+8)(sp)
+	addi	s0, sp, (PT_SIZE_ON_STACK+16)
+
+	sd x1,  PT_RA(sp)
+	sd x2,  PT_SP(sp)
+	sd x3,  PT_GP(sp)
+	sd x4,  PT_TP(sp)
+	sd x5,  PT_T0(sp)
+	sd x6,  PT_T1(sp)
+	sd x7,  PT_T2(sp)
+	sd x8,  PT_S0(sp)
+	sd x9,  PT_S1(sp)
+	sd x10, PT_A0(sp)
+	sd x11, PT_A1(sp)
+	sd x12, PT_A2(sp)
+	sd x13, PT_A3(sp)
+	sd x14, PT_A4(sp)
+	sd x15, PT_A5(sp)
+	sd x16, PT_A6(sp)
+	sd x17, PT_A7(sp)
+	sd x18, PT_S2(sp)
+	sd x19, PT_S3(sp)
+	sd x20, PT_S4(sp)
+	sd x21, PT_S5(sp)
+	sd x22, PT_S6(sp)
+	sd x23, PT_S7(sp)
+	sd x24, PT_S8(sp)
+	sd x25, PT_S9(sp)
+	sd x26, PT_S10(sp)
+	sd x27, PT_S11(sp)
+	sd x28, PT_T3(sp)
+	sd x29, PT_T4(sp)
+	sd x30, PT_T5(sp)
+	sd x31, PT_T6(sp)
+	.endm
+
+	.macro RESTORE_ALL
+	ld x1,  PT_RA(sp)
+	ld x2,  PT_SP(sp)
+	ld x3,  PT_GP(sp)
+	ld x4,  PT_TP(sp)
+	ld x5,  PT_T0(sp)
+	ld x6,  PT_T1(sp)
+	ld x7,  PT_T2(sp)
+	ld x8,  PT_S0(sp)
+	ld x9,  PT_S1(sp)
+	ld x10, PT_A0(sp)
+	ld x11, PT_A1(sp)
+	ld x12, PT_A2(sp)
+	ld x13, PT_A3(sp)
+	ld x14, PT_A4(sp)
+	ld x15, PT_A5(sp)
+	ld x16, PT_A6(sp)
+	ld x17, PT_A7(sp)
+	ld x18, PT_S2(sp)
+	ld x19, PT_S3(sp)
+	ld x20, PT_S4(sp)
+	ld x21, PT_S5(sp)
+	ld x22, PT_S6(sp)
+	ld x23, PT_S7(sp)
+	ld x24, PT_S8(sp)
+	ld x25, PT_S9(sp)
+	ld x26, PT_S10(sp)
+	ld x27, PT_S11(sp)
+	ld x28, PT_T3(sp)
+	ld x29, PT_T4(sp)
+	ld x30, PT_T5(sp)
+	ld x31, PT_T6(sp)
+
+	ld	s0, (PT_SIZE_ON_STACK)(sp)
+	ld	ra, (PT_SIZE_ON_STACK+8)(sp)
+	addi	sp, sp, (PT_SIZE_ON_STACK+16)
+	.endm
+
+	.macro RESTORE_GRAPH_REG_ARGS
+	ld	a0, PT_T0(sp)
+	ld	a1, PT_T1(sp)
+#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
+	ld	a2, PT_T2(sp)
+#endif
+	.endm
+
+/*
+ * Most of the contents are the same as ftrace_caller.
+ */
+ENTRY(ftrace_regs_caller)
+	/*
+	 * a3: the address of all registers in the stack
+	 */
+	ld	a1, -8(s0)
+	addi	a0, ra, -MCOUNT_INSN_SIZE
+	la	t5, function_trace_op
+	ld	a2, 0(t5)
+	addi	a3, sp, -(PT_SIZE_ON_STACK+16)
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	addi	t0, s0, -8
+	mv	t1, a0
+#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
+	ld	t2, -16(s0)
+#endif
+#endif
+	SAVE_ALL
+
+ftrace_regs_call:
+	.global ftrace_regs_call
+	call	ftrace_stub
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	RESTORE_GRAPH_REG_ARGS
+	call	ftrace_graph_caller
+#endif
+
+	RESTORE_ALL
+	ret
+ENDPROC(ftrace_regs_caller)
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
-- 
2.15.1
