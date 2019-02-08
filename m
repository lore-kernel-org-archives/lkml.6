Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99408C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440D02177B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfBHPKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:10:23 -0500
Received: from verein.lst.de ([213.95.11.211]:42872 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727617AbfBHPKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:10:22 -0500
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 9E7A968DDD; Fri,  8 Feb 2019 16:10:19 +0100 (CET)
To:     Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: [PATCH v8 4/5] arm64: implement ftrace with regs
In-Reply-To: <20190208150826.44EBC68DD2@newverein.lst.de>
References: <20190208150826.44EBC68DD2@newverein.lst.de>
Message-Id: <20190208151019.9E7A968DDD@newverein.lst.de>
Date:   Fri,  8 Feb 2019 16:10:19 +0100 (CET)
From:   duwe@lst.de (Torsten Duwe)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement ftrace with regs, based on the new gcc flag
-fpatchable-function-entry (=2)

Now that gcc8 added 2 NOPs at the beginning of each function, replace
the first NOP thus generated with a quick LR saver (move it to scratch
reg x9), so the 2nd replacement insn, the call to ftrace, does not
clobber the value. Ftrace will then generate the standard stack
frames.

Note that patchable-function-entry in GCC disables IPA-RA, which means
ABI register calling conventions are obeyed and scratch registers such
as x9 are available.

Introduce and handle an ftrace_regs_trampoline for module PLTs, right
after ftrace_trampoline in an ftrace_trampolines[2] array, and double
the size of the corresponding special section.

Signed-off-by: Torsten Duwe <duwe@suse.de>

---
 arch/arm64/include/asm/ftrace.h  |   16 ++++
 arch/arm64/include/asm/module.h  |    3 
 arch/arm64/kernel/entry-ftrace.S |  125 +++++++++++++++++++++++++++++++++++++--
 arch/arm64/kernel/ftrace.c       |  117 ++++++++++++++++++++++++++++--------
 arch/arm64/kernel/module-plts.c  |    3 
 arch/arm64/kernel/module.c       |    2 
 6 files changed, 231 insertions(+), 35 deletions(-)
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -14,9 +14,16 @@
 #include <asm/insn.h>
 
 #define HAVE_FUNCTION_GRAPH_FP_TEST
-#define MCOUNT_ADDR		((unsigned long)_mcount)
 #define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#define ARCH_SUPPORTS_FTRACE_OPS 1
+/* All we need is some magic value. Simply use "_mCount:" */
+#define MCOUNT_ADDR		(0x5f6d436f756e743a)
+#else
+#define MCOUNT_ADDR		((unsigned long)_mcount)
+#endif
+
 #ifndef __ASSEMBLY__
 #include <linux/compat.h>
 
@@ -34,6 +41,13 @@ extern void return_to_handler(void);
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
 	/*
+	 * For -fpatchable-function-entry=2, there's first the
+	 * LR saver, and only then the actual call insn.
+	 * Advance addr accordingly.
+	 */
+	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS))
+		return (addr + AARCH64_INSN_SIZE);
+	/*
 	 * addr is the address of the mcount call instruction.
 	 * recordmcount does the necessary offset calculation.
 	 */
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -10,6 +10,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/asm-offsets.h>
 #include <asm/assembler.h>
 #include <asm/ftrace.h>
 #include <asm/insn.h>
@@ -124,6 +125,7 @@ EXPORT_SYMBOL(_mcount)
 NOKPROBE(_mcount)
 
 #else /* CONFIG_DYNAMIC_FTRACE */
+#ifndef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 /*
  * _mcount() is used to build the kernel with -pg option, but all the branch
  * instructions to _mcount() are replaced to NOP initially at kernel start up,
@@ -163,11 +165,6 @@ GLOBAL(ftrace_graph_call)		// ftrace_gra
 
 	mcount_exit
 ENDPROC(ftrace_caller)
-#endif /* CONFIG_DYNAMIC_FTRACE */
-
-ENTRY(ftrace_stub)
-	ret
-ENDPROC(ftrace_stub)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 /*
@@ -187,7 +184,125 @@ ENTRY(ftrace_graph_caller)
 
 	mcount_exit
 ENDPROC(ftrace_graph_caller)
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+
+#else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+
+	.macro  ftrace_regs_entry, allregs=0
+	/* make room for pt_regs, plus a callee frame */
+	sub	sp, sp, #(S_FRAME_SIZE + 16)
+
+	/* save function arguments */
+	stp	x0, x1, [sp, #S_X0]
+	stp	x2, x3, [sp, #S_X2]
+	stp	x4, x5, [sp, #S_X4]
+	stp	x6, x7, [sp, #S_X6]
+	stp	x8, x9, [sp, #S_X8]
 
+	.if \allregs == 1
+	stp	x10, x11, [sp, #S_X10]
+	stp	x12, x13, [sp, #S_X12]
+	stp	x14, x15, [sp, #S_X14]
+	stp	x16, x17, [sp, #S_X16]
+	stp	x18, x19, [sp, #S_X18]
+	stp	x20, x21, [sp, #S_X20]
+	stp	x22, x23, [sp, #S_X22]
+	stp	x24, x25, [sp, #S_X24]
+	stp	x26, x27, [sp, #S_X26]
+	.endif
+
+	/* Save fp and x28, which is used in this function. */
+	stp	x28, x29, [sp, #S_X28]
+
+	/* The stack pointer as it was on ftrace_caller entry... */
+	add	x28, sp, #(S_FRAME_SIZE + 16)
+	/* ...and the link Register at callee entry */
+	stp	x9, x28, [sp, #S_LR]	/* to pt_regs.r[30] and .sp */
+
+	/* The program counter just after the ftrace call site */
+	str	lr, [sp, #S_PC]
+
+	/* Now fill in callee's preliminary stackframe. */
+	stp	x29, x9, [sp, #S_FRAME_SIZE]
+	/* Let FP point to it. */
+	add	x29, sp, #S_FRAME_SIZE
+
+	/* Our stackframe, stored inside pt_regs. */
+	stp	x29, x30, [sp, #S_STACKFRAME]
+	add	x29, sp, #S_STACKFRAME
+	.endm
+
+ENTRY(ftrace_regs_caller)
+	ftrace_regs_entry	1
+	b	ftrace_common
+ENDPROC(ftrace_regs_caller)
+
+ENTRY(ftrace_caller)
+	ftrace_regs_entry	0
+	b	ftrace_common
+ENDPROC(ftrace_caller)
+
+ENTRY(ftrace_common)
+
+	mov	x3, sp				/* pt_regs are @sp */
+	ldr_l	x2, function_trace_op, x0
+	mov	x1, x9				/* parent IP */
+	sub	x0, lr, #AARCH64_INSN_SIZE
+
+GLOBAL(ftrace_call)
+	bl	ftrace_stub
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+GLOBAL(ftrace_graph_call)		// ftrace_graph_caller();
+	nop				// If enabled, this will be replaced
+					// "b ftrace_graph_caller"
+#endif
+
+/*
+ * GCC's patchable-function-entry implicitly disables IPA-RA,
+ * so all non-argument registers are either scratch / dead
+ * or callee-saved (within the ftrace framework). Function
+ * arguments of the call we are intercepting right now however
+ * need to be preserved in any case.
+ */
+ftrace_common_return:
+	/* restore function args */
+	ldp	x0, x1, [sp]
+	ldp	x2, x3, [sp, #S_X2]
+	ldp	x4, x5, [sp, #S_X4]
+	ldp	x6, x7, [sp, #S_X6]
+	ldr	x8, [sp, #S_X8]
+
+	/* restore fp and x28 */
+	ldp	x28, x29, [sp, #S_X28]
+
+	ldr	lr, [sp, #S_LR]
+	ldr	x9, [sp, #S_PC]
+	/* clean up both frames, ours and callee preliminary */
+	add	sp, sp, #S_FRAME_SIZE + 16
+
+	ret	x9
+ENDPROC(ftrace_common)
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+ENTRY(ftrace_graph_caller)
+	ldr	x0, [sp, #S_PC]		   /* pc */
+	sub	x0, x0, #AARCH64_INSN_SIZE
+	add	x1, sp, #S_LR		   /* &lr */
+	ldr	x2, [sp, #S_FRAME_SIZE]	   /* fp */
+	bl	prepare_ftrace_return
+	b	ftrace_common_return
+ENDPROC(ftrace_graph_caller)
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+#endif /* CONFIG_DYNAMIC_FTRACE */
+
+ENTRY(ftrace_stub)
+	ret
+ENDPROC(ftrace_stub)
+
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
 /*
  * void return_to_handler(void)
  *
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -65,6 +65,40 @@ int ftrace_update_ftrace_func(ftrace_fun
 	return ftrace_modify_code(pc, 0, new, false);
 }
 
+#ifdef CONFIG_ARM64_MODULE_PLTS
+static int install_ftrace_trampoline(struct module *mod, unsigned long *addr)
+{
+	struct plt_entry trampoline, *mod_trampoline;
+
+	/*
+	 * Iterate over
+	 * mod->arch.ftrace_trampolines[MOD_ARCH_NR_FTRACE_TRAMPOLINES]
+	 * The assignment to various ftrace functions happens here.
+	 */
+	if (*addr == FTRACE_ADDR)
+		mod_trampoline = &mod->arch.ftrace_trampolines[0];
+	else if (*addr == FTRACE_REGS_ADDR)
+		mod_trampoline = &mod->arch.ftrace_trampolines[1];
+	else
+		return -EINVAL;
+
+	trampoline = get_plt_entry(*addr, mod_trampoline);
+
+	if (!plt_entries_equal(mod_trampoline, &trampoline)) {
+		/* point the trampoline at our ftrace entry point */
+		module_disable_ro(mod);
+		*mod_trampoline = trampoline;
+		module_enable_ro(mod, true);
+
+		/* update trampoline before patching in the branch */
+		smp_wmb();
+	}
+	*addr = (unsigned long)(void *)mod_trampoline;
+
+	return 0;
+}
+#endif
+
 /*
  * Turn on the call to ftrace_caller() in instrumented function
  */
@@ -76,8 +110,8 @@ int ftrace_make_call(struct dyn_ftrace *
 
 	if (offset < -SZ_128M || offset >= SZ_128M) {
 #ifdef CONFIG_ARM64_MODULE_PLTS
-		struct plt_entry trampoline;
 		struct module *mod;
+		int ret;
 
 		/*
 		 * On kernels that support module PLTs, the offset between the
@@ -96,32 +130,14 @@ int ftrace_make_call(struct dyn_ftrace *
 		if (WARN_ON(!mod))
 			return -EINVAL;
 
-		/*
-		 * There is only one ftrace trampoline per module. For now,
-		 * this is not a problem since on arm64, all dynamic ftrace
-		 * invocations are routed via ftrace_caller(). This will need
-		 * to be revisited if support for multiple ftrace entry points
-		 * is added in the future, but for now, the pr_err() below
-		 * deals with a theoretical issue only.
-		 */
-		trampoline = get_plt_entry(addr, mod->arch.ftrace_trampoline);
-		if (!plt_entries_equal(mod->arch.ftrace_trampoline,
-				       &trampoline)) {
-			if (!plt_entries_equal(mod->arch.ftrace_trampoline,
-					       &(struct plt_entry){})) {
-				pr_err("ftrace: far branches to multiple entry points unsupported inside a single module\n");
-				return -EINVAL;
-			}
-
-			/* point the trampoline to our ftrace entry point */
-			module_disable_ro(mod);
-			*mod->arch.ftrace_trampoline = trampoline;
-			module_enable_ro(mod, true);
+		/* Check against our well-known list of ftrace entry points */
+		if (addr == FTRACE_ADDR || addr == FTRACE_REGS_ADDR) {
+			ret = install_ftrace_trampoline(mod, &addr);
+			if (ret < 0)
+				return ret;
+		} else
+			return -EINVAL;
 
-			/* update trampoline before patching in the branch */
-			smp_wmb();
-		}
-		addr = (unsigned long)(void *)mod->arch.ftrace_trampoline;
 #else /* CONFIG_ARM64_MODULE_PLTS */
 		return -EINVAL;
 #endif /* CONFIG_ARM64_MODULE_PLTS */
@@ -133,6 +149,45 @@ int ftrace_make_call(struct dyn_ftrace *
 	return ftrace_modify_code(pc, old, new, true);
 }
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
+			unsigned long addr)
+{
+	unsigned long pc = rec->ip;
+	u32 old, new;
+
+	old = aarch64_insn_gen_branch_imm(pc, old_addr,
+					  AARCH64_INSN_BRANCH_LINK);
+	new = aarch64_insn_gen_branch_imm(pc, addr, AARCH64_INSN_BRANCH_LINK);
+
+	return ftrace_modify_code(pc, old, new, true);
+}
+
+/*
+ * Ftrace with regs generates the tracer calls as close as possible to
+ * the function entry; no stack frame has been set up at that point.
+ * In order to make another call e.g to ftrace_caller, the LR must be
+ * saved from being overwritten.
+ * Between two functions, and with IPA-RA turned off, the scratch registers
+ * are available, so move the LR to x9 before calling into ftrace.
+ *
+ * This function is called once during kernel startup for each call site.
+ * The address passed is that of the actual branch, so patch in the LR saver
+ * just before that.
+ */
+static int ftrace_setup_lr_saver(unsigned long addr)
+{
+	u32 old, new;
+
+	old = aarch64_insn_gen_nop();
+	/* "mov x9, lr" is officially aliased from "orr x9, xzr, lr". */
+	new = aarch64_insn_gen_logical_shifted_reg(AARCH64_INSN_REG_9,
+		AARCH64_INSN_REG_ZR, AARCH64_INSN_REG_LR, 0,
+		AARCH64_INSN_VARIANT_64BIT, AARCH64_INSN_LOGIC_ORR);
+	return ftrace_modify_code(addr - AARCH64_INSN_SIZE, old, new, true);
+}
+#endif
+
 /*
  * Turn off the call to ftrace_caller() in instrumented function
  */
@@ -144,6 +199,16 @@ int ftrace_make_nop(struct module *mod,
 	u32 old = 0, new;
 	long offset = (long)pc - (long)addr;
 
+	/*
+	 * -fpatchable-function-entry= does not generate a profiling call
+	 *  initially; the NOPs are already there. So instead,
+	 *  put the LR saver there ahead of time, in order to avoid
+	 *  any race condition over patching 2 instructions.
+	 */
+	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS) &&
+		addr == MCOUNT_ADDR)
+		return ftrace_setup_lr_saver(pc);
+
 	if (offset < -SZ_128M || offset >= SZ_128M) {
 #ifdef CONFIG_ARM64_MODULE_PLTS
 		u32 replaced;
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -32,7 +32,8 @@ struct mod_arch_specific {
 	struct mod_plt_sec	init;
 
 	/* for CONFIG_DYNAMIC_FTRACE */
-	struct plt_entry 	*ftrace_trampoline;
+	struct plt_entry	*ftrace_trampolines;
+#define MOD_ARCH_NR_FTRACE_TRAMPOLINES	2
 };
 #endif
 
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -452,7 +452,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 #ifdef CONFIG_ARM64_MODULE_PLTS
 		if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
 		    !strcmp(".text.ftrace_trampoline", secstrs + s->sh_name))
-			me->arch.ftrace_trampoline = (void *)s->sh_addr;
+			me->arch.ftrace_trampolines = (void *)s->sh_addr;
 #endif
 	}
 
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -333,7 +333,8 @@ int module_frob_arch_sections(Elf_Ehdr *
 		tramp->sh_type = SHT_NOBITS;
 		tramp->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
 		tramp->sh_addralign = __alignof__(struct plt_entry);
-		tramp->sh_size = sizeof(struct plt_entry);
+		tramp->sh_size = MOD_ARCH_NR_FTRACE_TRAMPOLINES
+				 * sizeof(struct plt_entry);
 	}
 
 	return 0;
