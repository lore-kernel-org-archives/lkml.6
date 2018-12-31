Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F56C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 07:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E44221019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 07:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbeLaHUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 02:20:55 -0500
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:41029 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726435AbeLaHUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 02:20:55 -0500
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Sun, 30 Dec 2018 23:20:33 -0800
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id A03EB40BD0;
        Sun, 30 Dec 2018 23:20:35 -0800 (PST)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Edward Cree <ecree@solarflare.com>
CC:     "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Nadav Amit <namit@vmware.com>
Subject: [RFC v2 3/6] x86: patch indirect branch promotion
Date:   Sun, 30 Dec 2018 23:21:09 -0800
Message-ID: <20181231072112.21051-4-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181231072112.21051-1-namit@vmware.com>
References: <20181231072112.21051-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To perform indirect branch promotion, we need to find all the locations
and patch them, while ignore various code sections (e.g., init,
alternatives). Using a GCC plugin allows us to do so. It is also
possible to add on top of this plugin and opt-in/out mechanism.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/Kconfig                             |   4 +
 arch/x86/include/asm/nospec-branch.h         |  71 ++++
 arch/x86/kernel/Makefile                     |   1 +
 arch/x86/kernel/asm-offsets.c                |   9 +
 arch/x86/kernel/nospec-branch.c              |  11 +
 arch/x86/kernel/vmlinux.lds.S                |   7 +
 arch/x86/lib/retpoline.S                     |  83 +++++
 scripts/Makefile.gcc-plugins                 |   3 +
 scripts/gcc-plugins/x86_call_markup_plugin.c | 329 +++++++++++++++++++
 9 files changed, 518 insertions(+)
 create mode 100644 arch/x86/kernel/nospec-branch.c
 create mode 100644 scripts/gcc-plugins/x86_call_markup_plugin.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e65105c1f875..b0956fb7b40b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2904,6 +2904,10 @@ config X86_DMA_REMAP
 config HAVE_GENERIC_GUP
 	def_bool y
 
+config OPTPOLINE
+       def_bool y
+       depends on X86_64 && RETPOLINE && GCC_PLUGINS
+
 source "drivers/firmware/Kconfig"
 
 source "arch/x86/kvm/Kconfig"
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index be4713ef0940..cb0a7613dd0a 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -9,6 +9,7 @@
 #include <asm/alternative-asm.h>
 #include <asm/cpufeatures.h>
 #include <asm/msr-index.h>
+#include <asm/percpu.h>
 
 /*
  * Fill the CPU return stack buffer.
@@ -30,6 +31,9 @@
 #define RSB_CLEAR_LOOPS		32	/* To forcibly overwrite all entries */
 #define RSB_FILL_LOOPS		16	/* To avoid underflow */
 
+#define OPTPOLINE_SAMPLES_NUM		(1 << 8)
+#define OPTPOLINE_SAMPLES_MASK		(OPTPOLINE_SAMPLES_NUM - 1)
+
 /*
  * Google experimented with loop-unrolling and this turned out to be
  * the optimal version — two calls, each with their own speculation
@@ -299,6 +303,73 @@ static inline void indirect_branch_prediction_barrier(void)
 	alternative_msr_write(MSR_IA32_PRED_CMD, val, X86_FEATURE_USE_IBPB);
 }
 
+/* Data structure that is used during the learning stage */
+struct optpoline_sample {
+	u32 src;
+	u32 tgt;
+	u32 cnt;
+} __packed;
+
+DECLARE_PER_CPU_ALIGNED(struct optpoline_sample[OPTPOLINE_SAMPLES_NUM],
+		       optpoline_samples);
+
+DECLARE_PER_CPU(u8, has_optpoline_samples);
+
+/*
+ * Information for optpolines as it is saved in the source.
+ */
+struct optpoline_entry {
+	void *rip;
+	u8 reg;
+} __packed;
+
+/*
+ * Reflects the structure of the assembly code. We exclude the compare
+ * opcode which depends on the register.
+ */
+struct optpoline_code {
+	union {
+		struct {
+			u8 rex;
+			u8 opcode;
+			u8 modrm;
+			u32 imm;
+		} __packed cmp;
+		struct {
+			u8 opcode;
+			s8 rel;
+		} __packed skip;
+		struct {
+			u8 opcode;
+			s32 rel;
+		} __packed patching_call;
+	} __packed;
+	struct {
+		u8 rex;
+		u8 opcode;
+		s8 rel;
+	} __packed jnz;
+	struct {
+		u8 rex;
+		u8 opcode;
+		s32 rel;
+	} __packed call;
+	struct {
+		/* Instruction is not patched, so no prefix needed */
+		u8 opcode;
+		u8 rel;
+	} __packed jmp_done;
+	struct {
+		u8 rex;
+		u8 opcode;
+		s32 rel;
+	} __packed fallback;
+} __packed;
+
+extern const void *indirect_thunks[16];
+extern const void *save_optpoline_funcs[16];
+extern const void *skip_optpoline_funcs[16];
+
 /* The Intel SPEC CTRL MSR base value cache */
 extern u64 x86_spec_ctrl_base;
 
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 8824d01c0c35..7c342cfd3771 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -149,4 +149,5 @@ ifeq ($(CONFIG_X86_64),y)
 
 	obj-$(CONFIG_MMCONF_FAM10H)	+= mmconf-fam10h_64.o
 	obj-y				+= vsmp_64.o
+	obj-$(CONFIG_OPTPOLINE)		+= nospec-branch.o
 endif
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 168543d077d7..e5b6236fdcb2 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -18,6 +18,7 @@
 #include <asm/bootparam.h>
 #include <asm/suspend.h>
 #include <asm/tlbflush.h>
+#include <asm/nospec-branch.h>
 
 #ifdef CONFIG_XEN
 #include <xen/interface/xen.h>
@@ -105,4 +106,12 @@ static void __used common(void)
 	OFFSET(TSS_sp0, tss_struct, x86_tss.sp0);
 	OFFSET(TSS_sp1, tss_struct, x86_tss.sp1);
 	OFFSET(TSS_sp2, tss_struct, x86_tss.sp2);
+
+	/* Relpolines */
+	OFFSET(OPTPOLINE_SAMPLE_src, optpoline_sample, src);
+	OFFSET(OPTPOLINE_SAMPLE_tgt, optpoline_sample, tgt);
+	OFFSET(OPTPOLINE_SAMPLE_cnt, optpoline_sample, cnt);
+	DEFINE(OPTPOLINE_CODE_SIZE, sizeof(struct optpoline_code));
+	DEFINE(OPTPOLINE_CODE_patching_call_end,
+	       offsetofend(struct optpoline_code, patching_call));
 }
diff --git a/arch/x86/kernel/nospec-branch.c b/arch/x86/kernel/nospec-branch.c
new file mode 100644
index 000000000000..5ae12681b23b
--- /dev/null
+++ b/arch/x86/kernel/nospec-branch.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 Nadav Amit <namit@vmware.com>
+ */
+
+#include <linux/percpu.h>
+#include <asm/nospec-branch.h>
+
+DEFINE_PER_CPU_ALIGNED(struct optpoline_sample[OPTPOLINE_SAMPLES_NUM],
+		       optpoline_samples);
+DEFINE_PER_CPU(u8, has_optpoline_samples);
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 0d618ee634ac..6faf89098e40 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -355,6 +355,13 @@ SECTIONS
 	.data_nosave : AT(ADDR(.data_nosave) - LOAD_OFFSET) {
 		NOSAVE_DATA
 	}
+
+	. = ALIGN(8);
+	.optpolines : AT(ADDR(.optpolines) - LOAD_OFFSET) {
+		__optpolines = .;
+		*(.optpolines)
+		__optpolines_end = .;
+	}
 #endif
 
 	/* BSS */
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index c909961e678a..e53a08a9a385 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -7,6 +7,7 @@
 #include <asm/alternative-asm.h>
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
+#include <asm/asm-offsets.h>
 
 .macro THUNK reg
 	.section .text.__x86.indirect_thunk
@@ -45,4 +46,86 @@ GENERATE_THUNK(r12)
 GENERATE_THUNK(r13)
 GENERATE_THUNK(r14)
 GENERATE_THUNK(r15)
+
+#ifdef CONFIG_OPTPOLINE
+
+.macro save_optpoline reg:req
+ENTRY(save_optpoline_\reg\())
+	pushq 	%rdi
+	pushq	%rsi
+	pushq	%rcx
+
+	/* First load the destination, for the case rsi is the destination */
+.if "\reg" != "rdi"
+	mov	%\reg, %rdi
+.endif
+	mov	24(%rsp), %rsi
+
+	/* Compute the xor as an index in the table */
+	mov	%rsi, %rcx
+	xor	%rdi, %rcx
+	and	$OPTPOLINE_SAMPLES_MASK, %ecx
+
+	/* Entry size is 12-bit */
+	shl	$2, %ecx				# ecx *= 4
+	lea	optpoline_samples(%rcx,%rcx,2), %rcx	# rcx *= 3
+
+	movl	%esi, PER_CPU_VAR(OPTPOLINE_SAMPLE_src)(%rcx)
+	movl	%edi, PER_CPU_VAR(OPTPOLINE_SAMPLE_tgt)(%rcx)
+	incl	PER_CPU_VAR(OPTPOLINE_SAMPLE_cnt)(%rcx)
+	movb	$1, PER_CPU_VAR(has_optpoline_samples)
+
+	popq	%rcx
+	popq	%rsi
+	popq	%rdi
+	ANNOTATE_NOSPEC_ALTERNATIVE
+	ALTERNATIVE __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg\()),\
+		"jmp __x86_indirect_thunk_\reg",			\
+		X86_FEATURE_RETPOLINE
+
+ENDPROC(save_optpoline_\reg\())
+_ASM_NOKPROBE(save_optpoline_\reg\())
+EXPORT_SYMBOL(save_optpoline_\reg\())
+.endm
+
+.macro skip_optpoline reg:req
+ENTRY(skip_optpoline_\reg\())
+	addq	$(OPTPOLINE_CODE_SIZE - OPTPOLINE_CODE_patching_call_end), (%_ASM_SP)
+	jmp	__x86_indirect_thunk_\reg
+ENDPROC(skip_optpoline_\reg\())
+_ASM_NOKPROBE(skip_optpoline_\reg\())
+EXPORT_SYMBOL(skip_optpoline_\reg\())
+.endm
+
+#define ARCH_REG_NAMES rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14,r15
+
+.irp reg,ARCH_REG_NAMES
+.if \reg != "rsp"
+save_optpoline reg=\reg
+skip_optpoline reg=\reg
+.endif
+.endr
+
+/*
+ * List of indirect thunks
+ */
+.macro create_func_per_reg_list name:req func_prefix:req
+.global \name
+\name:
+.irp reg,ARCH_REG_NAMES
+.if \reg != "rsp"
+.quad \func_prefix\()_\reg
+.else
+.quad 0
+.endif
+.endr
+.endm
+
+.pushsection .rodata
+create_func_per_reg_list name=indirect_thunks func_prefix=__x86_indirect_thunk
+create_func_per_reg_list name=save_optpoline_funcs func_prefix=save_optpoline
+create_func_per_reg_list name=skip_optpoline_funcs func_prefix=skip_optpoline
+.popsection
+
+#endif
 #endif
diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index 46c5c6809806..796b6d59f27e 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -31,6 +31,9 @@ gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK)		\
 		+= -DSTACKLEAK_PLUGIN
 gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK)		\
 		+= -fplugin-arg-stackleak_plugin-track-min-size=$(CONFIG_STACKLEAK_TRACK_MIN_SIZE)
+
+gcc-plugin-$(CONFIG_OPTPOLINE) 			+= x86_call_markup_plugin.so
+
 ifdef CONFIG_GCC_PLUGIN_STACKLEAK
     DISABLE_STACKLEAK_PLUGIN += -fplugin-arg-stackleak_plugin-disable
 endif
diff --git a/scripts/gcc-plugins/x86_call_markup_plugin.c b/scripts/gcc-plugins/x86_call_markup_plugin.c
new file mode 100644
index 000000000000..fb01cf36c26f
--- /dev/null
+++ b/scripts/gcc-plugins/x86_call_markup_plugin.c
@@ -0,0 +1,329 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 Nadav Amit <namit@vmware.com>
+ */
+
+#include "gcc-common.h"
+
+__visible int plugin_is_GPL_compatible;
+
+static struct plugin_info kernexec_plugin_info = {
+	.version	= "201607271510vanilla",
+	.help		= "method=call\tmaniuplation method\n"
+};
+
+static bool include_emitted;
+
+#define N_CLOBBERED_FUNC_REGS			(4)
+
+struct reg_pair {
+	machine_mode	mode;
+	unsigned int	regno;
+};
+
+static const struct reg_pair clobbered_func_regs[N_CLOBBERED_FUNC_REGS] = {
+	{DImode, R11_REG},
+	{DImode, R10_REG},
+	{CCmode, FLAGS_REG},
+	{CCFPmode, FPSR_REG}
+};
+
+struct output_pair {
+	const char *constraint;
+	unsigned int regno;
+};
+
+#define N_OUTPUT_FUNC_REGS			(7)
+
+/* VREG indicates the call register, which is N_OUTPUT_FUNC_REGS + 1 */
+#define VREG					"8"
+
+static const struct output_pair output_regs[N_OUTPUT_FUNC_REGS] = {
+	/* Order must not be changed, since inputs regard outputs */
+	{"=r", SP_REG},
+	{"=D", DI_REG},
+	{"=S", SI_REG},
+	{"=c", CX_REG},
+	{"=d", DX_REG},
+	{"+r", R8_REG},
+	{"+r", R9_REG}
+};
+
+#define KERNEL_RESTARTABLE_PREFIX		"0x40"
+
+/*
+ * %V8, since 8 = N_OUTPUT_FUNC_REGS + 1
+ *
+ * There are a few suboptimization in this code, that can be addressed in the
+ * future. They simplify the code, though.
+ *
+ * 1. We always encode a longer version of CMP, even 'cmp eax, imm' is possible.
+ * 2. We always encode the "restartable" prefix, even on non-preemptive or
+ *    voluntary-preemption kernels.
+ */
+const char *call_block =
+	"# INDIRECT BRANCH -------------------				\n"
+	"	i = 0							\n"
+	"	.irp reg_it, rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14,r15\n"
+	"	.ifc \"%V" VREG "\", \"\\reg_it\"			\n"
+	"		reg_num=i					\n"
+	"	.endif							\n"
+	"	i = i + 1						\n"
+	"	.endr							\n"
+	"1:								\n"
+	".section .optpolines,\"a\"					\n"
+	"	.quad		1b					\n"
+	"	.byte		reg_num					\n"
+	".previous							\n"
+	"								\n"
+	"	.byte 0x48 | ((reg_num & 8) >> 3)			\n"
+	"	.byte 0x81, 0xf8 | (reg_num & 7)			\n"
+	"	.long 0							\n"
+	"								\n"
+	"	# jmp 4f, patched to jnz in runtime			\n"
+	"	.byte " KERNEL_RESTARTABLE_PREFIX ", 0xeb, 4f - 2f	\n"
+	"								\n"
+	"	# call retpoline, tell objtool about it			\n"
+	"2:								\n"
+	"	.pushsection .discard.ignore				\n"
+	"	.long 2b - .						\n"
+	"	.popsection						\n"
+	"	.byte " KERNEL_RESTARTABLE_PREFIX ", 0xe8		\n"
+	"	.long __x86_indirect_thunk_%V " VREG " - 3f		\n"
+	"3:								\n"
+	"	# jmp 5f,  tell objtool about it			\n"
+	"	.pushsection .discard.ignore				\n"
+	"	.long 3b - .						\n"
+	"	.popsection						\n"
+	"	.byte 0xeb, 5f - 4f					\n"
+	"4:								\n"
+	"	# retpoline						\n"
+	"	.byte " KERNEL_RESTARTABLE_PREFIX ", 0xe8		\n"
+	"	.long __x86_indirect_thunk_%V" VREG " - 5f 		\n"
+	"5:								\n"
+	" # ----------------------------------				\n";
+
+static unsigned int x86_call_markup_execute(void)
+{
+	rtx_insn *insn;
+	rtx annotate;
+	const char *buf;
+	const char * name;
+
+	insn = get_first_nonnote_insn();
+	if (!insn)
+		return 0;
+
+	/* Do not patch init (and other) section calls */
+	if (current_function_decl) {
+	       const char *sec_name = DECL_SECTION_NAME(current_function_decl);
+
+	       if (sec_name)
+		       return 0;
+	}
+
+	buf = call_block;
+
+	for (insn = get_insns(); insn; insn = NEXT_INSN(insn)) {
+		unsigned int i, j, n_inputs;
+		bool has_output;
+		rtvec arg_vec, constraint_vec, label_vec;
+		rtx operands, call, call_op, annotate;
+		rtx asm_op, new_body, p, clob;
+		rtx output_reg;
+		rtx body;
+
+		if (!CALL_P(insn))
+			continue;
+
+		body = PATTERN(insn);
+		switch (GET_CODE(body)) {
+		case CALL:
+			/* A call with no return value */
+			has_output = false;
+			call = body;
+			break;
+		case SET:
+			/* A call with a return value */
+			has_output = true;
+			call = SET_SRC(body);
+			break;
+		default:
+			return -1;
+		}
+
+		if (GET_CODE(call) != CALL)
+			continue;
+
+		call_op = XEXP(XEXP(call, 0), 0);
+
+		switch (GET_CODE(call_op)) {
+		case SYMBOL_REF:
+			/* direct call */
+			continue;
+		case REG:
+			break;
+		default:
+			return -1;	/* ERROR */
+		}
+
+		/* Count the inputs */
+		for (n_inputs = 0, p = CALL_INSN_FUNCTION_USAGE (insn); p; p = XEXP (p, 1)) {
+			if (GET_CODE (XEXP (p, 0)) != USE)
+				return -1;
+			n_inputs++;
+		}
+
+		label_vec = rtvec_alloc(0);
+		arg_vec = rtvec_alloc(2 + n_inputs);
+		constraint_vec = rtvec_alloc(2 + n_inputs);
+
+		i = 0;
+
+		/* AX input */
+		RTVEC_ELT(arg_vec, i) = call_op;
+		RTVEC_ELT(constraint_vec, i) =
+			gen_rtx_ASM_INPUT_loc(GET_MODE(call_op), "r",
+					      RTL_LOCATION(call_op));
+		i++;
+
+		/* SP input */
+		RTVEC_ELT(arg_vec, i) = gen_rtx_REG(DImode, SP_REG);
+		RTVEC_ELT(constraint_vec, i) =
+			gen_rtx_ASM_INPUT_loc(DImode, "1",
+					      RTL_LOCATION(call_op));
+		i++;
+
+		for (p = CALL_INSN_FUNCTION_USAGE(insn); p; p = XEXP (p, 1)) {
+			const char *constraint;
+			rtx input;
+
+			if (GET_CODE (XEXP (p, 0)) != USE)
+				continue;
+
+			input = XEXP(XEXP(p, 0), 0);
+
+			if (MEM_P(input)) {
+				constraint = "m";
+			} else if (REG_P(input)) {
+				switch (REGNO(input)) {
+				case DI_REG:
+					constraint = "D";
+					break;
+				case SI_REG:
+					constraint = "S";
+					break;
+				case DX_REG:
+					constraint = "d";
+					break;
+				case CX_REG:
+					constraint = "c";
+					break;
+				case R8_REG:
+					constraint = "r";
+					break;
+				case R9_REG:
+					constraint = "r";
+					break;
+				default:
+					return -1;
+				}
+			} else {
+				return -1;
+			}
+			RTVEC_ELT(arg_vec, i) = input;
+			rtx input_rtx = gen_rtx_ASM_INPUT_loc(GET_MODE(input),
+							      ggc_strdup(constraint),
+							      RTL_LOCATION(input));
+
+			RTVEC_ELT(constraint_vec, i) = input_rtx;
+			i++;
+		}
+
+		new_body = gen_rtx_PARALLEL(VOIDmode,
+				rtvec_alloc(1 + 1 + N_OUTPUT_FUNC_REGS +
+					    N_CLOBBERED_FUNC_REGS));
+
+		/*
+		 * The function output. If none still mark as if AX is
+		 * written to ensure it is clobbered.
+		 */
+		i = 0;
+		output_reg = has_output ? SET_DEST(body) :
+					  gen_rtx_REG(DImode, AX_REG);
+		asm_op = gen_rtx_ASM_OPERANDS(VOIDmode, ggc_strdup(buf), "=a", i,
+					      arg_vec, constraint_vec,
+					      label_vec, RTL_LOCATION(insn));
+		XVECEXP(new_body, 0, i++) = gen_rtx_SET(output_reg, asm_op);
+
+		/*
+		 * SP is used as output. Since there is always an output, we do
+		 * not use MEM_VOLATILE_P
+		 */
+		for (j = 0; j < N_OUTPUT_FUNC_REGS; j++) {
+			const struct output_pair *output = &output_regs[j];
+			rtx reg_rtx;
+
+			asm_op = gen_rtx_ASM_OPERANDS(VOIDmode, ggc_strdup(buf),
+						      output->constraint, i,
+						      arg_vec, constraint_vec,
+						      label_vec, RTL_LOCATION(insn));
+
+			reg_rtx = gen_rtx_REG(DImode, output->regno);
+			XVECEXP(new_body, 0, i++) = gen_rtx_SET(reg_rtx, asm_op);
+		}
+
+		/* Add the clobbers */
+		for (j = 0; j < N_CLOBBERED_FUNC_REGS; j++) {
+			const struct reg_pair *regs = &clobbered_func_regs[j];
+
+			clob = gen_rtx_REG(regs->mode, regs->regno);
+			clob = gen_rtx_CLOBBER(VOIDmode, clob);
+			XVECEXP(new_body, 0, i++) = clob;
+		}
+
+		/* Memory clobber */
+		clob = gen_rtx_SCRATCH(VOIDmode);
+		clob = gen_rtx_MEM(BLKmode, clob);
+		clob = gen_rtx_CLOBBER(VOIDmode, clob);
+		XVECEXP(new_body, 0, i++) = clob;
+
+		if (n_inputs >= 5)
+			emit_insn_before(gen_rtx_USE(VOIDmode,
+					  gen_rtx_REG(DImode, R8_REG)), insn);
+		if (n_inputs >= 6)
+			emit_insn_before(gen_rtx_USE(VOIDmode,
+					  gen_rtx_REG(DImode, R9_REG)), insn);
+
+		emit_insn_before(new_body, insn);
+
+		delete_insn(insn);
+	}
+	return 0;
+}
+
+#define PASS_NAME x86_call_markup
+#define NO_GATE
+
+#include "gcc-generate-rtl-pass.h"
+
+__visible int plugin_init(struct plugin_name_args *plugin_info,
+			  struct plugin_gcc_version *version)
+{
+	const char * const plugin_name = plugin_info->base_name;
+	const int argc = plugin_info->argc;
+	const struct plugin_argument *argv = plugin_info->argv;
+
+	if (!plugin_default_version_check(version, &gcc_version)) {
+		error(G_("incompatible gcc/plugin versions"));
+		return 1;
+	}
+
+	register_callback(plugin_name, PLUGIN_INFO, NULL, &kernexec_plugin_info);
+
+	PASS_INFO(x86_call_markup, "expand", 1, PASS_POS_INSERT_AFTER);
+	register_callback(plugin_name, PLUGIN_PASS_MANAGER_SETUP, NULL,
+			  &x86_call_markup_pass_info);
+
+	return 0;
+}
-- 
2.17.1

