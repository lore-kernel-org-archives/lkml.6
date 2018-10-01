Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0144BC0044B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1DC9213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1DC9213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbeJAUyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:54:53 -0400
Received: from verein.lst.de ([213.95.11.211]:37900 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729295AbeJAUyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:54:52 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 1DBED68BDF; Mon,  1 Oct 2018 16:16:48 +0200 (CEST)
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: [PATCH v3 2/4] arm64: implement ftrace with regs
In-Reply-To: <20181001140910.086E768BC7@newverein.lst.de>
References: <20181001140910.086E768BC7@newverein.lst.de>
Message-Id: <20181001141648.1DBED68BDF@newverein.lst.de>
Date:   Mon,  1 Oct 2018 16:16:48 +0200 (CEST)
From:   duwe@lst.de (Torsten Duwe)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check for compiler support of -fpatchable-function-entry and use it
to intercept functions immediately on entry, saving the LR in x9.
patchable-function-entry in GCC disables IPA-RA, which means ABI
register calling conventions are obeyed *and* scratch registers are
available.
Disable ftracing in efi/libstub, because this triggers cross-section
linker errors now (-pg is disabled already for those files).
Add an ftrace_caller which can handle LR in x9, as well as an
ftrace_regs_caller that additionally writes out a set of pt_regs
for inspection.
Introduce and handle an ftrace_regs_trampoline for module PLTs.

Signed-off-by: Torsten Duwe <duwe@suse.de>

--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -110,6 +110,7 @@ config ARM64
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
+	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_TRACER
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -78,6 +78,15 @@ ifeq ($(CONFIG_ARM64_MODULE_PLTS),y)
 KBUILD_LDFLAGS_MODULE	+= -T $(srctree)/arch/arm64/kernel/module.lds
 endif
 
+ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_REGS),y)
+  CC_FLAGS_FTRACE := -fpatchable-function-entry=2
+  KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
+  ifeq ($(call cc-option,-fpatchable-function-entry=2),)
+    $(error Cannot use CONFIG_DYNAMIC_FTRACE_WITH_REGS: \
+             -fpatchable-function-entry not supported by compiler)
+  endif
+endif
+
 # Default value
 head-y		:= arch/arm64/kernel/head.o
 
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -16,6 +16,17 @@
 #define MCOUNT_ADDR		((unsigned long)_mcount)
 #define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
 
+/* DYNAMIC_FTRACE_WITH_REGS is implemented by adding 2 NOPs at the beginning
+   of each function, with the second NOP actually calling ftrace. In contrary
+   to a classic _mcount call, the call instruction to be modified is thus
+   the second one, and not the only one. */
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#define ARCH_SUPPORTS_FTRACE_OPS 1
+#define REC_IP_BRANCH_OFFSET AARCH64_INSN_SIZE
+#else
+#define REC_IP_BRANCH_OFFSET 0
+#endif
+
 #ifndef __ASSEMBLY__
 #include <linux/compat.h>
 
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -7,9 +7,9 @@ CPPFLAGS_vmlinux.lds	:= -DTEXT_OFFSET=$(
 AFLAGS_head.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 CFLAGS_armv8_deprecated.o := -I$(src)
 
-CFLAGS_REMOVE_ftrace.o = -pg
-CFLAGS_REMOVE_insn.o = -pg
-CFLAGS_REMOVE_return_address.o = -pg
+CFLAGS_REMOVE_ftrace.o = -pg $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_insn.o = -pg $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_return_address.o = -pg $(CC_FLAGS_FTRACE)
 
 # Object file lists.
 arm64-obj-y		:= debug-monitors.o entry.o irq.o fpsimd.o		\
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -11,7 +11,8 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__K
 				   -fPIC -fno-strict-aliasing -mno-red-zone \
 				   -mno-mmx -mno-sse -fshort-wchar
 
-cflags-$(CONFIG_ARM64)		:= $(subst -pg,,$(KBUILD_CFLAGS)) -fpie
+cflags-$(CONFIG_ARM64)		:= $(filter-out -pg $(CC_FLAGS_FTRACE)\
+				  ,$(KBUILD_CFLAGS)) -fpie
 cflags-$(CONFIG_ARM)		:= $(subst -pg,,$(KBUILD_CFLAGS)) \
 				   -fno-builtin -fpic -mno-single-pic-base
 
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -13,6 +13,8 @@
 #include <asm/assembler.h>
 #include <asm/ftrace.h>
 #include <asm/insn.h>
+#include <asm/asm-offsets.h>
+#include <asm/assembler.h>
 
 /*
  * Gcc with -pg will put the following code in the beginning of each function:
@@ -123,6 +125,7 @@ skip_ftrace_call:			// }
 ENDPROC(_mcount)
 
 #else /* CONFIG_DYNAMIC_FTRACE */
+#ifndef CC_USING_PATCHABLE_FUNCTION_ENTRY
 /*
  * _mcount() is used to build the kernel with -pg option, but all the branch
  * instructions to _mcount() are replaced to NOP initially at kernel start up,
@@ -162,6 +165,92 @@ ftrace_graph_call:			// ftrace_graph_cal
 
 	mcount_exit
 ENDPROC(ftrace_caller)
+#else /* CC_USING_PATCHABLE_FUNCTION_ENTRY */
+
+/* Since no -pg or similar compiler flag is used, there should really be
+   no reference to _mcount; so do not define one. Only a function address
+   is needed in order to refer to it. */
+ENTRY(_mcount)
+	ret	/* just in case, prevent any fall through. */
+ENDPROC(_mcount)
+
+ENTRY(ftrace_regs_caller)
+	sub	sp, sp, #S_FRAME_SIZE
+	stp	x29, x9, [sp, #-16]	/* FP/LR link */
+
+	stp	x10, x11, [sp, #S_X10]
+	stp	x12, x13, [sp, #S_X12]
+	stp	x14, x15, [sp, #112]
+	stp	x16, x17, [sp, #128]
+	stp	x18, x19, [sp, #144]
+	stp	x20, x21, [sp, #160]
+	stp	x22, x23, [sp, #176]
+	stp	x24, x25, [sp, #192]
+	stp	x26, x27, [sp, #208]
+
+	b	ftrace_common
+ENDPROC(ftrace_regs_caller)
+
+ENTRY(ftrace_caller)
+	sub	sp, sp, #S_FRAME_SIZE
+	stp	x29, x9, [sp, #-16]	/* FP/LR link */
+
+ftrace_common:
+	stp	x28, x29, [sp, #224]	/* FP in pt_regs + "our" x28 */
+
+	/* save function arguments */
+	stp	x0, x1, [sp]
+	stp	x2, x3, [sp, #16]
+	stp	x4, x5, [sp, #32]
+	stp	x6, x7, [sp, #48]
+	stp	x8, x9, [sp, #64]
+
+	/* The link Register at callee entry */
+	str	x9, [sp, #S_LR]		/* to pt_regs.r[30] */
+	/* The program counter just after the ftrace call site */
+	str	lr, [sp, #S_PC]
+	/* The stack pointer as it was on ftrace_caller entry... */
+	add	x29, sp, #S_FRAME_SIZE
+	str	x29, [sp, #S_SP]
+
+	ldr_l	x2, function_trace_op, x0
+	mov	x1, x9		/* saved LR == parent IP */
+	sub	x0, lr, #8	/* function entry == IP */
+	mov	x3, sp		/* pt_regs are @sp */
+	sub	sp, sp, #16	/* skip over FP/LR link */
+
+	.global ftrace_call
+ftrace_call:
+
+	bl	ftrace_stub
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	.global ftrace_graph_call
+ftrace_graph_call:			// ftrace_graph_caller();
+	nop				// If enabled, this will be replaced
+					// "b ftrace_graph_caller"
+#endif
+
+ftrace_common_return:
+	add	sp, sp, #16	/* advance to pt_regs for restore */
+
+	ldp	x0, x1, [sp]
+	ldp	x2, x3, [sp, #16]
+	ldp	x4, x5, [sp, #32]
+	ldp	x6, x7, [sp, #48]
+	ldp	x8, x9, [sp, #64]
+
+	ldp	x28, x29, [sp, #224]
+
+	ldr	x9, [sp, #S_PC]
+	ldr	lr, [sp, #S_LR]
+	add	sp, sp, #S_FRAME_SIZE
+
+	ret	x9
+
+ENDPROC(ftrace_caller)
+
+#endif /* CC_USING_PATCHABLE_FUNCTION_ENTRY */
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 ENTRY(ftrace_stub)
@@ -197,12 +286,20 @@ ENDPROC(ftrace_stub)
  * and run return_to_handler() later on its exit.
  */
 ENTRY(ftrace_graph_caller)
+#ifndef CC_USING_PATCHABLE_FUNCTION_ENTRY
 	mcount_get_lr_addr	  x0	//     pointer to function's saved lr
 	mcount_get_pc		  x1	//     function's pc
 	mcount_get_parent_fp	  x2	//     parent's fp
 	bl	prepare_ftrace_return	// prepare_ftrace_return(&lr, pc, fp)
 
 	mcount_exit
+#else
+	add	x0, sp, #S_LR+16	/* address of (LR pointing into caller) */
+	ldr	x1, [sp, #S_PC+16]
+	ldr	x2, [sp, #S_X28 + 8+16]	/* caller's frame pointer */
+	bl	prepare_ftrace_return
+	b	ftrace_common_return
+#endif
 ENDPROC(ftrace_graph_caller)
 
 /*
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -65,18 +65,66 @@ int ftrace_update_ftrace_func(ftrace_fun
 	return ftrace_modify_code(pc, 0, new, false);
 }
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+/* Have the assembler generate a known "mov x9,x30" at compile time. */
+static void notrace noinline __attribute__((used)) mov_x9_x30(void)
+{
+	asm(" .global insn_mov_x9_x30\n"
+		     "insn_mov_x9_x30: mov x9,x30\n" : : : "x9");
+}
+#endif
+
+#ifdef CONFIG_ARM64_MODULE_PLTS
+int use_ftrace_trampoline(struct module *mod, unsigned long *addr)
+{
+	struct plt_entry trampoline;
+	trampoline = get_plt_entry(*addr);
+	if (*addr == FTRACE_ADDR) {
+		if (!plt_entries_equal(mod->arch.ftrace_trampoline,
+				       &trampoline)) {
+
+			/* point the trampoline to our ftrace entry point */
+			module_disable_ro(mod);
+			*mod->arch.ftrace_trampoline = trampoline;
+			module_enable_ro(mod, true);
+
+			/* update trampoline before patching in the branch */
+			smp_wmb();
+		}
+		*addr = (unsigned long)(void *)mod->arch.ftrace_trampoline;
+	}
+	else if (*addr == FTRACE_REGS_ADDR) {
+		if (!plt_entries_equal(mod->arch.ftrace_regs_trampoline,
+				       &trampoline)) {
+
+			/* point the trampoline to our ftrace entry point */
+			module_disable_ro(mod);
+			*mod->arch.ftrace_regs_trampoline = trampoline;
+			module_enable_ro(mod, true);
+
+			/* update trampoline before patching in the branch */
+			smp_wmb();
+		}
+		*addr = (unsigned long)(void *)mod->arch.ftrace_regs_trampoline;
+	}
+	else
+		return -EINVAL;
+	return 0;
+}
+#endif
+
 /*
  * Turn on the call to ftrace_caller() in instrumented function
  */
 int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
-	unsigned long pc = rec->ip;
+	unsigned long pc = rec->ip + REC_IP_BRANCH_OFFSET;
+	int ret;
 	u32 old, new;
 	long offset = (long)pc - (long)addr;
 
 	if (offset < -SZ_128M || offset >= SZ_128M) {
 #ifdef CONFIG_ARM64_MODULE_PLTS
-		struct plt_entry trampoline;
 		struct module *mod;
 
 		/*
@@ -96,54 +144,67 @@ int ftrace_make_call(struct dyn_ftrace *
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
-		trampoline = get_plt_entry(addr);
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
-
-			/* update trampoline before patching in the branch */
-			smp_wmb();
+		/* Check against our well-known list of ftrace entry points */
+		if (addr == FTRACE_ADDR || addr == FTRACE_REGS_ADDR) {
+			ret = use_ftrace_trampoline(mod, &addr);
+			if (ret < 0)
+				return ret;
 		}
-		addr = (unsigned long)(void *)mod->arch.ftrace_trampoline;
+		else
+			return -EINVAL;
+
 #else /* CONFIG_ARM64_MODULE_PLTS */
 		return -EINVAL;
 #endif /* CONFIG_ARM64_MODULE_PLTS */
 	}
 
 	old = aarch64_insn_gen_nop();
+	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS)) {
+		new = *(u32*)&mov_x9_x30;
+		ret = ftrace_modify_code(pc - REC_IP_BRANCH_OFFSET,
+					 old, new, true);
+		if (ret)
+			return ret;
+		smp_wmb(); /* ensure LR saver is in place before ftrace call */
+	}
 	new = aarch64_insn_gen_branch_imm(pc, addr, AARCH64_INSN_BRANCH_LINK);
 
 	return ftrace_modify_code(pc, old, new, true);
 }
 
+int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
+			unsigned long addr)
+{
+	unsigned long pc = rec->ip + REC_IP_BRANCH_OFFSET;
+	u32 old, new;
+
+	old = aarch64_insn_gen_branch_imm(pc, old_addr, true);
+	new = aarch64_insn_gen_branch_imm(pc, addr, true);
+
+	return ftrace_modify_code(pc, old, new, true);
+}
+
+
 /*
  * Turn off the call to ftrace_caller() in instrumented function
  */
 int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 		    unsigned long addr)
 {
-	unsigned long pc = rec->ip;
+	unsigned long pc = rec->ip + REC_IP_BRANCH_OFFSET;
 	bool validate = true;
+	int ret;
 	u32 old = 0, new;
 	long offset = (long)pc - (long)addr;
 
+#ifdef CC_USING_PATCHABLE_FUNCTION_ENTRY
+	/* -fpatchable-function-entry= does not generate a profiling call
+	 *  initially; the NOPs are already there.
+	 */
+	if (addr == MCOUNT_ADDR)
+		return 0;
+#endif
+
 	if (offset < -SZ_128M || offset >= SZ_128M) {
 #ifdef CONFIG_ARM64_MODULE_PLTS
 		u32 replaced;
@@ -188,7 +249,16 @@ int ftrace_make_nop(struct module *mod,
 
 	new = aarch64_insn_gen_nop();
 
-	return ftrace_modify_code(pc, old, new, validate);
+	ret = ftrace_modify_code(pc, old, new, validate);
+	if (ret)
+		return ret;
+	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS)) {
+		smp_wmb(); /* ftrace call must not remain without LR saver. */
+		old = *(u32*)&mov_x9_x30;
+		ret = ftrace_modify_code(pc - REC_IP_BRANCH_OFFSET,
+					 old, new, true);
+	}
+	return ret;
 }
 
 void arch_ftrace_update_code(int command)
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -115,6 +115,7 @@
 #define MCOUNT_REC()	. = ALIGN(8);				\
 			__start_mcount_loc = .;			\
 			KEEP(*(__mcount_loc))			\
+			KEEP(*(__patchable_function_entries))	\
 			__stop_mcount_loc = .;
 #else
 #define MCOUNT_REC()
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -61,8 +61,12 @@ extern void __chk_io_ptr(const volatile
 #if defined(CC_USING_HOTPATCH) && !defined(__CHECKER__)
 #define notrace __attribute__((hotpatch(0,0)))
 #else
+#ifdef CC_USING_PATCHABLE_FUNCTION_ENTRY
+#define notrace __attribute__((patchable_function_entry(0)))
+#else
 #define notrace __attribute__((no_instrument_function))
 #endif
+#endif
 
 /* Intel compiler defines __GNUC__. So we will overwrite implementations
  * coming from above header files here
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -33,6 +33,7 @@ struct mod_arch_specific {
 
 	/* for CONFIG_DYNAMIC_FTRACE */
 	struct plt_entry 	*ftrace_trampoline;
+	struct plt_entry 	*ftrace_regs_trampoline;
 };
 #endif
 
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -454,6 +454,10 @@ int module_finalize(const Elf_Ehdr *hdr,
 		if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
 		    !strcmp(".text.ftrace_trampoline", secstrs + s->sh_name))
 			me->arch.ftrace_trampoline = (void *)s->sh_addr;
+		if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS) &&
+		    !strcmp(".text.ftrace_regs_trampoline",
+				secstrs + s->sh_name))
+			me->arch.ftrace_regs_trampoline = (void *)s->sh_addr;
 #endif
 	}
 
