Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13500C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFC822431
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEFC822431
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbeHJScn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 14:32:43 -0400
Received: from verein.lst.de ([213.95.11.211]:48589 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728635AbeHJScm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 14:32:42 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id D360D68C76; Fri, 10 Aug 2018 18:02:23 +0200 (CEST)
From:   Torsten Duwe <duwe@lst.de>
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: [PATCH 1/3] arm64: implement ftrace with regs
In-Reply-To: <20180810160043.9E45568C76@newverein.lst.de>
References: <20180810160043.9E45568C76@newverein.lst.de>
Message-Id: <20180810160223.D360D68C76@newverein.lst.de>
Date:   Fri, 10 Aug 2018 18:02:23 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check for compiler support of -fpatchable-function-entry and use it
to intercept functions immediately on entry, saving the LR in x9.
Disable ftracing in efi/libstub, because this triggers cross-section
linker errors now (-pg used to be disabled already).
Add an ftrace_caller which can handle LR in x9.
This code has successfully passed the FTRACE_STARTUP_TEST.

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
 
+ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+  CC_FLAGS_FTRACE := -fpatchable-function-entry=2
+  KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
+  ifeq ($(call cc-option,-fpatchable-function-entry=2),)
+    $(warning Cannot use CONFIG_DYNAMIC_FTRACE_WITH_REGS: \
+             -fpatchable-function-entry not supported by compiler)
+  endif
+endif
+
 # Default value
 head-y		:= arch/arm64/kernel/head.o
 
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -16,6 +16,14 @@
 #define MCOUNT_ADDR		((unsigned long)_mcount)
 #define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#define ARCH_SUPPORTS_FTRACE_OPS 1
+#define REC_IP_BRANCH_OFFSET 4
+#define FTRACE_REGS_ADDR FTRACE_ADDR
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
@@ -11,7 +11,8 @@
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
+#ifndef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 /*
  * _mcount() is used to build the kernel with -pg option, but all the branch
  * instructions to _mcount() are replaced to NOP initially at kernel start up,
@@ -162,6 +165,84 @@ ftrace_graph_call:			// ftrace_graph_cal
 
 	mcount_exit
 ENDPROC(ftrace_caller)
+#else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+ENTRY(_mcount)
+	mov     x10, lr
+	mov     lr, x9
+	ret     x10
+ENDPROC(_mcount)
+
+ENTRY(ftrace_caller)
+	stp	x29, x9, [sp, #-16]!
+	sub	sp, sp, #S_FRAME_SIZE
+
+	stp	x0, x1, [sp]
+	stp	x2, x3, [sp, #16]
+	stp	x4, x5, [sp, #32]
+	stp	x6, x7, [sp, #48]
+	stp	x8, x9, [sp, #64]
+	stp	x10, x11, [sp, #80]
+	stp	x12, x13, [sp, #96]
+	stp	x14, x15, [sp, #112]
+	stp	x16, x17, [sp, #128]
+	stp	x18, x19, [sp, #144]
+	stp	x20, x21, [sp, #160]
+	stp	x22, x23, [sp, #176]
+	stp	x24, x25, [sp, #192]
+	stp	x26, x27, [sp, #208]
+	stp	x28, x29, [sp, #224]
+	/* The link Register at callee entry */
+	str	x9, [sp, #S_LR]
+	/* The program counter just after the ftrace call site */
+	str	lr, [sp, #S_PC]
+	/* The stack pointer as it was on ftrace_caller entry... */
+	add	x29, sp, #S_FRAME_SIZE+16	/* ...is also our new FP */
+	str	x29, [sp, #S_SP]
+
+	adrp    x0, function_trace_op
+	ldr     x2, [x0, #:lo12:function_trace_op]
+	mov	x1, x9		/* saved LR == parent IP */
+	sub	x0, lr, #8	/* function entry == IP */
+	mov	x3, sp		/* complete pt_regs are @sp */
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
+ftrace_regs_return:
+	ldp	x0, x1, [sp]
+	ldp	x2, x3, [sp, #16]
+	ldp	x4, x5, [sp, #32]
+	ldp	x6, x7, [sp, #48]
+	ldp	x8, x9, [sp, #64]
+	ldp	x10, x11, [sp, #80]
+	ldp	x12, x13, [sp, #96]
+	ldp	x14, x15, [sp, #112]
+	ldp	x16, x17, [sp, #128]
+	ldp	x18, x19, [sp, #144]
+	ldp	x20, x21, [sp, #160]
+	ldp	x22, x23, [sp, #176]
+	ldp	x24, x25, [sp, #192]
+	ldp	x26, x27, [sp, #208]
+	ldp	x28, x29, [sp, #224]
+
+	ldr	x9, [sp, #S_PC]
+	ldr	lr, [sp, #S_LR]
+	add	sp, sp, #S_FRAME_SIZE+16
+
+	ret	x9
+
+ENDPROC(ftrace_caller)
+
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 ENTRY(ftrace_stub)
@@ -197,12 +278,20 @@ ENDPROC(ftrace_stub)
  * and run return_to_handler() later on its exit.
  */
 ENTRY(ftrace_graph_caller)
+#ifndef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 	mcount_get_lr_addr	  x0	//     pointer to function's saved lr
 	mcount_get_pc		  x1	//     function's pc
 	mcount_get_parent_fp	  x2	//     parent's fp
 	bl	prepare_ftrace_return	// prepare_ftrace_return(&lr, pc, fp)
 
 	mcount_exit
+#else
+	add	x0, sp, #S_LR	/* address of (LR pointing into caller) */
+	ldr	x1, [sp, #S_PC]
+	ldr	x2, [sp, #232]	/* caller's frame pointer */
+	bl	prepare_ftrace_return
+	b	ftrace_regs_return
+#endif
 ENDPROC(ftrace_graph_caller)
 
 /*
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -70,7 +70,8 @@ int ftrace_update_ftrace_func(ftrace_fun
  */
 int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
-	unsigned long pc = rec->ip;
+	unsigned long pc = rec->ip+REC_IP_BRANCH_OFFSET;
+	int ret;
 	u32 old, new;
 	long offset = (long)pc - (long)addr;
 
@@ -127,23 +128,51 @@ int ftrace_make_call(struct dyn_ftrace *
 #endif /* CONFIG_ARM64_MODULE_PLTS */
 	}
 
-	old = aarch64_insn_gen_nop();
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+	old = aarch64_insn_gen_nop();
+	new = 0xaa1e03e9;       /* mov x9,x30 */
+	ret = ftrace_modify_code(pc-REC_IP_BRANCH_OFFSET, old, new, true);
+	if (ret)
+		return ret;
+	smp_wmb();	/* ensure LR saver is in place before ftrace call */
+#endif
 	new = aarch64_insn_gen_branch_imm(pc, addr, AARCH64_INSN_BRANCH_LINK);
 
 	return ftrace_modify_code(pc, old, new, true);
 }
 
+int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
+			unsigned long addr)
+{
+	unsigned long pc = rec->ip+REC_IP_BRANCH_OFFSET;
+	u32 old, new;
+
+	old = aarch64_insn_gen_branch_imm(pc, old_addr, true);
+	new = aarch64_insn_gen_branch_imm(pc, addr, true);
+
+	return ftrace_modify_code(pc, old, new, true);
+}
+
 /*
  * Turn off the call to ftrace_caller() in instrumented function
  */
 int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 		    unsigned long addr)
 {
-	unsigned long pc = rec->ip;
+	unsigned long pc = rec->ip+REC_IP_BRANCH_OFFSET;
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
@@ -188,7 +218,16 @@ int ftrace_make_nop(struct module *mod,
 
 	new = aarch64_insn_gen_nop();
 
-	return ftrace_modify_code(pc, old, new, validate);
+	ret = ftrace_modify_code(pc, old, new, validate);
+	if (ret)
+		return ret;
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+	smp_wmb();	/* ftrace call must not remain without LR saver. */
+	old = 0xaa1e03e9;       /* mov x9,x30 */
+	new = aarch64_insn_gen_nop();
+	ret = ftrace_modify_code(pc-REC_IP_BRANCH_OFFSET, old, new, true);
+#endif
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
