Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A95ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D210A2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D210A2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeJRIyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 04:54:32 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:1559 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727019AbeJRIyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 04:54:32 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 17 Oct 2018 17:55:52 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 45FAB408EF;
        Wed, 17 Oct 2018 17:56:09 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>
CC:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin " <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Nadav Amit <namit@vmware.com>
Subject: [RFC PATCH 2/5] x86: patch indirect branch promotion
Date:   Wed, 17 Oct 2018 17:54:17 -0700
Message-ID: <20181018005420.82993-3-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181018005420.82993-1-namit@vmware.com>
References: <20181018005420.82993-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To perform indirect branch promotion, we need to find all the locations.
Retpolines make it relatively easy to find these branches, by looking at
the assembly and finding calls to the indirect thunks.

An assembly macro named CALL is used to catch all assembly calls, find
these the use indirect thunks and patch them to hold the code that is
needed for indirect branch promotion.

The build-system is slightly broken with this patch, as changes to
nospec-branch.h should trigger a full kernel rebuild, which currently
it does not.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/nospec-branch.h | 119 +++++++++++++++++++++++++++
 arch/x86/kernel/Makefile             |   1 +
 arch/x86/kernel/asm-offsets.c        |   6 ++
 arch/x86/kernel/macros.S             |   1 +
 arch/x86/kernel/nospec-branch.c      |   5 ++
 arch/x86/kernel/vmlinux.lds.S        |   7 ++
 arch/x86/lib/retpoline.S             |  75 +++++++++++++++++
 7 files changed, 214 insertions(+)
 create mode 100644 arch/x86/kernel/nospec-branch.c

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 0267611eb247..bd2d3a41e88c 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -7,6 +7,27 @@
 #include <asm/alternative-asm.h>
 #include <asm/cpufeatures.h>
 #include <asm/msr-index.h>
+#include <asm/percpu.h>
+
+/*
+ * Defining registers with the architectural order
+ */
+#define ARCH_RAX	0
+#define	ARCH_RCX	1
+#define ARCH_RDX	2
+#define ARCH_RBX	3
+#define ARCH_RSP	4
+#define ARCH_RBP	5
+#define ARCH_RSI	6
+#define ARCH_RDI	7
+#define ARCH_R8		8
+#define ARCH_R9		9
+#define ARCH_R10	10
+#define ARCH_R11	11
+#define ARCH_R12	12
+#define ARCH_R13	13
+#define ARCH_R14	14
+#define ARCH_R15	15
 
 /*
  * Fill the CPU return stack buffer.
@@ -28,6 +49,9 @@
 #define RSB_CLEAR_LOOPS		32	/* To forcibly overwrite all entries */
 #define RSB_FILL_LOOPS		16	/* To avoid underflow */
 
+#define RELPOLINE_SAMPLES_NUM		(1 << 8)
+#define RELPOLINE_SAMPLES_MASK		(RELPOLINE_SAMPLES_NUM - 1)
+
 /*
  * Google experimented with loop-unrolling and this turned out to be
  * the optimal version — two calls, each with their own speculation
@@ -160,6 +184,81 @@
 #endif
 .endm
 
+/*
+ * This macro performs the actual relpoline work. The machine-code is hand
+ * coded to avoid assembler optimizations. This code is heavily patched in
+ * runtime to make it do what it should.
+ */
+.macro relpoline_call reg:req
+	# cmp instruction
+	get_reg_num reg=\reg
+.if reg_num == ARCH_RAX
+	.byte 0x48
+	.byte 0x3d
+.else
+.if reg_num >= ARCH_R8
+	.byte 0x49
+.else
+	.byte 0x48
+.endif
+	.byte 0x81
+	.byte 0xf8 | (reg_num & 7)		# modrm
+.endif
+1:
+	.long 0
+
+	.section .relpolines,"a"
+	_ASM_PTR	1b
+	.byte		reg_num
+	.previous
+
+	# cachepoling-using code
+
+	# jnz 4f, patched to jmp while the target is changed
+	preempt_disable_prefix
+	.byte	0x75, 4f - 2f
+2:
+	# call retpoline
+	preempt_disable_prefix
+	.byte 0xe8
+	.long __x86_indirect_thunk_\reg - 3f
+3:
+	# jmp 5f
+	.byte 0xeb, 5f - 4f
+4:
+	# retpoline space
+	ANNOTATE_NOSPEC_ALTERNATIVE
+	preempt_disable_prefix
+	.byte 0xe8
+	.long save_relpoline_\reg - 5f
+5:
+.endm
+
+#define ARCH_REG_NAMES rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14,r15
+
+.macro get_reg_num reg:req
+	i = 0
+.irp reg_it,ARCH_REG_NAMES
+	.ifc "\reg", "\reg_it"
+		reg_num=i
+	.endif
+	i = i+1
+.endr
+.endm
+
+.macro call v:vararg
+	retpoline = 0
+.irp reg_it,ARCH_REG_NAMES
+.ifc "\v", "__x86_indirect_thunk_\reg_it"
+	relpoline_call reg=\reg_it
+	retpoline = 1
+.endif
+.endr
+.if retpoline == 0
+	{disp8} call \v
+.endif
+.endm
+
 #else /* __ASSEMBLY__ */
 
 #define ANNOTATE_NOSPEC_ALTERNATIVE				\
@@ -288,6 +387,26 @@ static inline void indirect_branch_prediction_barrier(void)
 	alternative_msr_write(MSR_IA32_PRED_CMD, val, X86_FEATURE_USE_IBPB);
 }
 
+/* Data structure that is used during the learning stage */
+struct relpoline_sample {
+	u32 src;
+	u32 dst;
+	u32 cnt;
+	u32 padding;
+} __packed;
+
+DECLARE_PER_CPU_ALIGNED(struct relpoline_sample[RELPOLINE_SAMPLES_NUM],
+		       relpoline_samples);
+
+/*
+ * Information for relpolines as it is saved in the source.
+ */
+struct relpoline_entry {
+	void *rip;
+	u8 reg;
+} __packed;
+
+
 /* The Intel SPEC CTRL MSR base value cache */
 extern u64 x86_spec_ctrl_base;
 
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 8824d01c0c35..8a50d304093a 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -138,6 +138,7 @@ obj-$(CONFIG_X86_INTEL_UMIP)		+= umip.o
 obj-$(CONFIG_UNWINDER_ORC)		+= unwind_orc.o
 obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
 obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
+obj-$(CONFIG_RETPOLINE)			+= nospec-branch.o
 
 ###
 # 64 bit specific files
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 72adf6c335dc..2db2628c79cd 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -18,6 +18,7 @@
 #include <asm/bootparam.h>
 #include <asm/suspend.h>
 #include <asm/tlbflush.h>
+#include <asm/nospec-branch.h>
 
 #ifdef CONFIG_XEN
 #include <xen/interface/xen.h>
@@ -104,4 +105,9 @@ void common(void) {
 	OFFSET(TSS_sp0, tss_struct, x86_tss.sp0);
 	OFFSET(TSS_sp1, tss_struct, x86_tss.sp1);
 	OFFSET(TSS_sp2, tss_struct, x86_tss.sp2);
+
+	/* Relpolines */
+	OFFSET(RELPOLINE_SAMPLE_src, relpoline_sample, src);
+	OFFSET(RELPOLINE_SAMPLE_dst, relpoline_sample, dst);
+	OFFSET(RELPOLINE_SAMPLE_cnt, relpoline_sample, cnt);
 }
diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
index 161c95059044..3d79f3d62d20 100644
--- a/arch/x86/kernel/macros.S
+++ b/arch/x86/kernel/macros.S
@@ -14,3 +14,4 @@
 #include <asm/asm.h>
 #include <asm/cpufeature.h>
 #include <asm/jump_label.h>
+#include <asm/nospec-branch.h>
diff --git a/arch/x86/kernel/nospec-branch.c b/arch/x86/kernel/nospec-branch.c
new file mode 100644
index 000000000000..b3027761442b
--- /dev/null
+++ b/arch/x86/kernel/nospec-branch.c
@@ -0,0 +1,5 @@
+#include <linux/percpu.h>
+#include <asm/nospec-branch.h>
+
+DEFINE_PER_CPU_ALIGNED(struct relpoline_sample[RELPOLINE_SAMPLES_NUM],
+		       relpoline_samples);
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 0d618ee634ac..c62735d06d58 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -355,6 +355,13 @@ SECTIONS
 	.data_nosave : AT(ADDR(.data_nosave) - LOAD_OFFSET) {
 		NOSAVE_DATA
 	}
+
+	. = ALIGN(8);
+	.relpolines : AT(ADDR(.relpolines) - LOAD_OFFSET) {
+		__relpolines = .;
+		*(.relpolines)
+		__relpolines_end = .;
+	}
 #endif
 
 	/* BSS */
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index c909961e678a..f30521c180db 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -7,6 +7,8 @@
 #include <asm/alternative-asm.h>
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
+#include <asm/asm-offsets.h>
+#include <asm/frame.h>
 
 .macro THUNK reg
 	.section .text.__x86.indirect_thunk
@@ -45,4 +47,77 @@ GENERATE_THUNK(r12)
 GENERATE_THUNK(r13)
 GENERATE_THUNK(r14)
 GENERATE_THUNK(r15)
+
+.macro save_relpoline reg:req
+ENTRY(save_relpoline_\reg\())
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
+	and	$RELPOLINE_SAMPLES_MASK, %ecx
+
+	/* Entry size is 16-bit */
+	shl	$4, %ecx
+
+	movl	%esi, PER_CPU_VAR(relpoline_samples + RELPOLINE_SAMPLE_src)(%ecx)
+	movl	%edi, PER_CPU_VAR(relpoline_samples + RELPOLINE_SAMPLE_dst)(%ecx)
+	incl	PER_CPU_VAR(relpoline_samples + RELPOLINE_SAMPLE_cnt)(%ecx)
+
+#ifdef CACHEPOLINE_DEBUG
+	incl 	PER_CPU_VAR(relpoline_misses)
+#endif
+	popq	%rcx
+	popq	%rsi
+	popq	%rdi
+	ANNOTATE_NOSPEC_ALTERNATIVE
+	ALTERNATIVE __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg\()),\
+		"jmp __x86_indirect_thunk_\reg",			\
+		X86_FEATURE_RETPOLINE
+
+ENDPROC(save_relpoline_\reg\())
+_ASM_NOKPROBE(save_relpoline_\reg\())
+EXPORT_SYMBOL(save_relpoline_\reg\())
+.endm
+
+.irp reg,ARCH_REG_NAMES
+.if \reg != "rsp"
+save_relpoline reg=\reg
+.endif
+.endr
+
+/*
+ * List of indirect thunks
+ */
+.pushsection .rodata
+.global indirect_thunks
+indirect_thunks:
+.irp reg,ARCH_REG_NAMES
+.if \reg != "rsp"
+.quad __x86_indirect_thunk_\reg
+.else
+.quad 0
+.endif
+.endr
+
+.global save_relpoline_funcs
+save_relpoline_funcs:
+.irp reg,ARCH_REG_NAMES
+.if \reg != "rsp"
+.quad save_relpoline_\reg
+.else
+.quad 0
+.endif
+.endr
+.popsection
+
+
 #endif
-- 
2.17.1

