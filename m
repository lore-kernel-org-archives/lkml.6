Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752702AbeDRJgA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 05:36:00 -0400
Received: from mail-pl0-f41.google.com ([209.85.160.41]:44339 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbeDRJf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 05:35:57 -0400
X-Google-Smtp-Source: AIpwx4/V6jgZkTz9QHHP048+YLmo/AtKZRA9bjK16c/hwjGtHRr8SShcyM7gB2Uap/pFsn0T4yONRw==
Date: Wed, 18 Apr 2018 17:31:18 +0800
From: Wang YanQing <udknight@gmail.com>
To: daniel@iogearbox.net
Cc: ast@kernel.org, illusionist.neo@gmail.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bpf, x86_32: add eBPF JIT compiler for ia32 (x86_32)
Message-ID: <20180418093118.GA4184@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>, daniel@iogearbox.net,
        ast@kernel.org, illusionist.neo@gmail.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The JIT compiler emits ia32 bit instructions. Currently, It supports
eBPF only. Classic BPF is supported because of the conversion by BPF core.

Almost all instructions from eBPF ISA supported except the following:
BPF_ALU64 | BPF_DIV | BPF_K
BPF_ALU64 | BPF_DIV | BPF_X
BPF_ALU64 | BPF_MOD | BPF_K
BPF_ALU64 | BPF_MOD | BPF_X
BPF_STX | BPF_XADD | BPF_W
BPF_STX | BPF_XADD | BPF_DW

It doesn't support BPF_JMP|BPF_CALL with BPF_PSEUDO_CALL too.

IA32 has few general purpose registers, EAX|EDX|ECX|EBX|ESI|EDI,
and for these six registers, we can't treat all of them as real
general purpose registers:
MUL instructions need EAX:EDX, shift instructions need ECX, ESI|EDI
for string manipulation instructions.

So I decide to use stack to emulate all eBPF 64 registers, this will
simplify the implementation very much, because we don't need to face
the flexible memory address modes on ia32, for example, we don't need
to write below codes for one BPF_ADD instruction:
if (src_reg is a register && dst_reg is a register)
{
   //one instruction encoding for ADD instruction
} else if (only src is a register)
{
   //another different instruction encoding for ADD instruction
} else if (only dst is a register)
{
   //another different instruction encoding for ADD instruction
} else
{
   //src and dst are all on stack.
   //another different instruction encoding for ADD instruction
}

If you think above if-else-else-else isn't so painful, try to think
it for BPF_ALU64|BPF_*SHIFT* instruction:)

Tested on my PC(Intel(R) Core(TM) i5-5200U CPU) and virtualbox.

Testing results on i5-5200U:

1) test_bpf: Summary: 349 PASSED, 0 FAILED, [319/341 JIT'ed]
2) test_progs: Summary: 81 PASSED, 2 FAILED.
   test_progs report "libbpf: incorrect bpf_call opcode" for
   test_l4lb_noinline and test_xdp_noinline, because there is
   no llvm-6.0 on my machine, and current implementation doesn't
   support BPF_CALL, so I think we can ignore it.
3) test_lpm: OK
4) test_lru_map: OK
5) test_verifier: Summary: 823 PASSED, 5 FAILED
   test_verifier report "invalid bpf_context access off=68 size=1/2/4/8"
   for all the 5 FAILED testcases, and test_verifier report them when
   we turn off the jit, so I think the jit can do nothing to fix them.

Above tests are all done with following flags enabled discretely:
bpf_jit_enable=1 and bpf_jit_harden=2

Below are some numbers for this jit implementation:
Note:
  I run test_progs 100 times in loop for every testcase, the numbers
  are in format: total/times=avg. The numbers that test_bpf report
  almost show the same relation.

a:jit_enable=0 and jit_harden=0            b:jit_enable=1 and jit_harden=0
  test_pkt_access:PASS:ipv4:15622/100=156  test_pkt_access:PASS:ipv4:10057/100=100
  test_pkt_access:PASS:ipv6:9130/100=91    test_pkt_access:PASS:ipv6:5055/100=50
  test_xdp:PASS:ipv4:240198/100=2401       test_xdp:PASS:ipv4:145945/100=1459
  test_xdp:PASS:ipv6:137326/100=1373       test_xdp:PASS:ipv6:67337/100=673
  test_l4lb:PASS:ipv4:61100/100=611        test_l4lb:PASS:ipv4:38137/100=381
  test_l4lb:PASS:ipv6:101000/100=1010      test_l4lb:PASS:ipv6:57779/100=577

c:jit_enable=0 and jit_harden=2            b:jit_enable=1 and jit_harden=2
  test_pkt_access:PASS:ipv4:15214/100=152  test_pkt_access:PASS:ipv4:12650/100=126
  test_pkt_access:PASS:ipv6:9132/100=91    test_pkt_access:PASS:ipv6:7074/100=70
  test_xdp:PASS:ipv4:237252/100=2372       test_xdp:PASS:ipv4:147211/100=1472
  test_xdp:PASS:ipv6:135977/100=1359       test_xdp:PASS:ipv6:85783/100=857
  test_l4lb:PASS:ipv4:61324/100=613        test_l4lb:PASS:ipv4:53222/100=532
  test_l4lb:PASS:ipv6:100833/100=1008      test_l4lb:PASS:ipv6:76322/100=763

Yes, the numbers are pretty without turn on jit_harden, if we want to speedup
jit_harden, then we need to move BPF_REG_AX to *real* register instead of stack
emulation, but If we do it, we need to face all the pain I describe above. We
can do it in next step.

See Documentation/networking/filter.txt for more information.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 arch/x86/Kconfig                     |    2 +-
 arch/x86/include/asm/nospec-branch.h |   26 +-
 arch/x86/net/Makefile                |   10 +-
 arch/x86/net/bpf_jit32.S             |  147 +++
 arch/x86/net/bpf_jit_comp32.c        | 2239 ++++++++++++++++++++++++++++++++++
 5 files changed, 2419 insertions(+), 5 deletions(-)
 create mode 100644 arch/x86/net/bpf_jit32.S
 create mode 100644 arch/x86/net/bpf_jit_comp32.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 00fcf81..1f5fa2f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -137,7 +137,7 @@ config X86
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
-	select HAVE_EBPF_JIT			if X86_64
+	select HAVE_EBPF_JIT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_EXIT_THREAD
 	select HAVE_FENTRY			if X86_64 || DYNAMIC_FTRACE
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index f928ad9..a4c7ca4 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -291,14 +291,17 @@ static inline void indirect_branch_prediction_barrier(void)
  *    lfence
  *    jmp spec_trap
  *  do_rop:
- *    mov %rax,(%rsp)
+ *    mov %rax,(%rsp) for x86_64
+ *    mov %edx,(%esp) for x86_32
  *    retq
  *
  * Without retpolines configured:
  *
- *    jmp *%rax
+ *    jmp *%rax for x86_64
+ *    jmp *%edx for x86_32
  */
 #ifdef CONFIG_RETPOLINE
+#ifdef CONFIG_X86_64
 # define RETPOLINE_RAX_BPF_JIT_SIZE	17
 # define RETPOLINE_RAX_BPF_JIT()				\
 	EMIT1_off32(0xE8, 7);	 /* callq do_rop */		\
@@ -310,9 +313,28 @@ static inline void indirect_branch_prediction_barrier(void)
 	EMIT4(0x48, 0x89, 0x04, 0x24); /* mov %rax,(%rsp) */	\
 	EMIT1(0xC3);             /* retq */
 #else
+# define RETPOLINE_EDX_BPF_JIT()				\
+do {								\
+	EMIT1_off32(0xE8, 7);	 /* call do_rop */		\
+	/* spec_trap: */					\
+	EMIT2(0xF3, 0x90);       /* pause */			\
+	EMIT3(0x0F, 0xAE, 0xE8); /* lfence */			\
+	EMIT2(0xEB, 0xF9);       /* jmp spec_trap */		\
+	/* do_rop: */						\
+	EMIT3(0x89, 0x14, 0x24); /* mov %edx,(%esp) */		\
+	EMIT1(0xC3);             /* ret */			\
+} while (0)
+#endif
+#else /* !CONFIG_RETPOLINE */
+
+#ifdef CONFIG_X86_64
 # define RETPOLINE_RAX_BPF_JIT_SIZE	2
 # define RETPOLINE_RAX_BPF_JIT()				\
 	EMIT2(0xFF, 0xE0);	 /* jmp *%rax */
+#else
+# define RETPOLINE_EDX_BPF_JIT()				\
+	EMIT2(0xFF, 0xE2) /* jmp *%edx */
+#endif
 #endif
 
 #endif /* _ASM_X86_NOSPEC_BRANCH_H_ */
diff --git a/arch/x86/net/Makefile b/arch/x86/net/Makefile
index fefb4b6..adcadc6 100644
--- a/arch/x86/net/Makefile
+++ b/arch/x86/net/Makefile
@@ -1,6 +1,12 @@
 #
 # Arch-specific network modules
 #
-OBJECT_FILES_NON_STANDARD_bpf_jit.o += y
 
-obj-$(CONFIG_BPF_JIT) += bpf_jit.o bpf_jit_comp.o
+
+ifeq ($(CONFIG_X86_32),y)
+        OBJECT_FILES_NON_STANDARD_bpf_jit32.o += y
+        obj-$(CONFIG_BPF_JIT) += bpf_jit32.o bpf_jit_comp32.o
+else
+        OBJECT_FILES_NON_STANDARD_bpf_jit.o += y
+        obj-$(CONFIG_BPF_JIT) += bpf_jit.o bpf_jit_comp.o
+endif
diff --git a/arch/x86/net/bpf_jit32.S b/arch/x86/net/bpf_jit32.S
new file mode 100644
index 0000000..8dac424
--- /dev/null
+++ b/arch/x86/net/bpf_jit32.S
@@ -0,0 +1,147 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* bpf_jit.S : BPF JIT helper functions
+ *
+ * Copyright (C) 2018 Wang YanQing (udknight@gmail.com)
+ * Copyright (C) 2011 Eric Dumazet (eric.dumazet@gmail.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ */
+#include <linux/linkage.h>
+#include <asm/frame.h>
+
+/*
+ * Calling convention :
+ * eax : skb pointer (caller-saved)
+ * edx : offset of byte(s) to fetch in skb (caller-saved)
+ * esi : copy of skb->data (callee-saved)
+ * edi : hlen = skb->len - skb->data_len (callee-saved)
+ *
+ * We don't need to push/pop eax,edx,ecx before calling kernel function,
+ * because jit always prepare eax,edx before calling helper functions,
+ * and jit uses ecx as a temporary register.
+ */
+#define SKBDATA	%esi
+#define SKF_MAX_NEG_OFF    $(-0x200000) /* SKF_LL_OFF from filter.h */
+
+#define FUNC(name) \
+	.globl name; \
+	.type name, @function; \
+	name:
+
+FUNC(sk_load_word)
+	test	%edx,%edx
+	js	bpf_slow_path_word_neg
+
+FUNC(sk_load_word_positive_offset)
+	mov	%edi,%ecx		# hlen
+	sub	%edx,%ecx		# hlen - offset
+	cmp	$3,%ecx
+	jle	bpf_slow_path_word
+	mov     (SKBDATA,%edx),%eax
+	bswap   %eax  			/* ntohl() */
+	ret
+
+FUNC(sk_load_half)
+	test	%edx,%edx
+	js	bpf_slow_path_half_neg
+
+FUNC(sk_load_half_positive_offset)
+	mov	%edi,%ecx
+	sub	%edx,%ecx		#	hlen - offset
+	cmp	$1,%ecx
+	jle	bpf_slow_path_half
+	movzwl	(SKBDATA,%edx),%eax
+	rol	$8,%ax			# ntohs()
+	ret
+
+FUNC(sk_load_byte)
+	test	%edx,%edx
+	js	bpf_slow_path_byte_neg
+
+FUNC(sk_load_byte_positive_offset)
+	cmp	%edx,%edi   /* if (offset >= hlen) goto bpf_slow_path_byte */
+	jle	bpf_slow_path_byte
+	movzbl	(SKBDATA,%edx),%eax
+	ret
+
+#define bpf_slow_path_common(LEN)		\
+	lea	104(%ebp), %ecx;		\
+	FRAME_BEGIN;				\
+	push    $LEN;				\
+	call	skb_copy_bits;			\
+	add	$4,%esp;			\
+	test    %eax,%eax;			\
+	FRAME_END
+
+
+bpf_slow_path_word:
+	bpf_slow_path_common(4)
+	js	bpf_error
+	mov	104(%ebp),%eax
+	bswap	%eax
+	ret
+
+bpf_slow_path_half:
+	bpf_slow_path_common(2)
+	js	bpf_error
+	mov	104(%ebp),%ax
+	rol	$8,%ax
+	movzwl	%ax,%eax
+	ret
+
+bpf_slow_path_byte:
+	bpf_slow_path_common(1)
+	js	bpf_error
+	movzbl	104(%ebp),%eax
+	ret
+
+#define sk_negative_common(SIZE)				\
+	FRAME_BEGIN;						\
+	mov	$SIZE,%ecx;	/* size */			\
+	call	bpf_internal_load_pointer_neg_helper;		\
+	test	%eax,%eax;					\
+	FRAME_END;						\
+	jz	bpf_error
+
+bpf_slow_path_word_neg:
+	cmp	SKF_MAX_NEG_OFF, %edx	/* test range */
+	jl	bpf_error	/* offset lower -> error  */
+
+FUNC(sk_load_word_negative_offset)
+	sk_negative_common(4)
+	mov	(%eax), %eax
+	bswap	%eax
+	ret
+
+bpf_slow_path_half_neg:
+	cmp	SKF_MAX_NEG_OFF, %edx
+	jl	bpf_error
+
+FUNC(sk_load_half_negative_offset)
+	sk_negative_common(2)
+	mov	(%eax),%ax
+	rol	$8,%ax
+	movzwl	%ax,%eax
+	ret
+
+bpf_slow_path_byte_neg:
+	cmp	SKF_MAX_NEG_OFF, %edx
+	jl	bpf_error
+
+FUNC(sk_load_byte_negative_offset)
+	sk_negative_common(1)
+	movzbl	(%eax), %eax
+	ret
+
+bpf_error:
+# force a return 0 from jit handler
+	xor	%eax,%eax
+	mov	108(%ebp),%ebx
+	mov	112(%ebp),%esi
+	mov	116(%ebp),%edi
+	add	$120, %ebp
+	leave
+	ret
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
new file mode 100644
index 0000000..39f3803
--- /dev/null
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -0,0 +1,2239 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Just-In-Time compiler for eBPF filters on ia32 (32bit x86)
+ *
+ * Copyright (c) 2018 Wang YanQing <udknight@gmail.com>
+ * Copyright (C) 2011-2013 Eric Dumazet (eric.dumazet@gmail.com)
+ * Internal BPF Copyright (c) 2011-2014 PLUMgrid, http://plumgrid.com
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/netdevice.h>
+#include <linux/filter.h>
+#include <linux/if_vlan.h>
+#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
+#include <asm/nospec-branch.h>
+#include <linux/bpf.h>
+
+/*
+ * eBPF prog stack layout:
+ *
+ *                         high
+ * original ESP =>        +-----+
+ *                        |     | callee saved registers
+ *                        +-----+
+ *                        | ... | eBPF JIT scratch space
+ * BPF_FP,IA32_EBP  =>    +-----+
+ *                        | ... | eBPF prog stack
+ *                        +-----+
+ *                        |RSVD | JIT scratchpad
+ * current ESP =>         +-----+
+ *                        |     |
+ *                        | ... | Function call stack
+ *                        |     |
+ *                        +-----+
+ *                          low
+ *
+ * The callee saved registers:
+ *
+ *                                high
+ * original ESP =>        +------------------+ \
+ *                        |        ebp       | |
+ * current EBP =>         +------------------+ } callee saved registers
+ *                        |    ebx,esi,edi   | |
+ *                        +------------------+ /
+ *                                low
+ */
+
+/*
+ * assembly code in arch/x86/net/bpf_jit32.S
+ */
+extern u8 sk_load_word[], sk_load_half[], sk_load_byte[];
+extern u8 sk_load_word_positive_offset[], sk_load_half_positive_offset[];
+extern u8 sk_load_byte_positive_offset[];
+extern u8 sk_load_word_negative_offset[], sk_load_half_negative_offset[];
+extern u8 sk_load_byte_negative_offset[];
+
+static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
+{
+	if (len == 1)
+		*ptr = bytes;
+	else if (len == 2)
+		*(u16 *)ptr = bytes;
+	else {
+		*(u32 *)ptr = bytes;
+		barrier();
+	}
+	return ptr + len;
+}
+
+#define EMIT(bytes, len) \
+	do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
+
+#define EMIT1(b1)		EMIT(b1, 1)
+#define EMIT2(b1, b2)		EMIT((b1) + ((b2) << 8), 2)
+#define EMIT3(b1, b2, b3)	EMIT((b1) + ((b2) << 8) + ((b3) << 16), 3)
+#define EMIT4(b1, b2, b3, b4)   \
+	EMIT((b1) + ((b2) << 8) + ((b3) << 16) + ((b4) << 24), 4)
+
+#define EMIT1_off32(b1, off) \
+	do {EMIT1(b1); EMIT(off, 4); } while (0)
+#define EMIT2_off32(b1, b2, off) \
+	do {EMIT2(b1, b2); EMIT(off, 4); } while (0)
+#define EMIT3_off32(b1, b2, b3, off) \
+	do {EMIT3(b1, b2, b3); EMIT(off, 4); } while (0)
+#define EMIT4_off32(b1, b2, b3, b4, off) \
+	do {EMIT4(b1, b2, b3, b4); EMIT(off, 4); } while (0)
+
+#define jmp_label(label, jmp_insn_len) (label - cnt - jmp_insn_len)
+
+static bool is_imm8(int value)
+{
+	return value <= 127 && value >= -128;
+}
+
+static bool is_simm32(s64 value)
+{
+	return value == (s64) (s32) value;
+}
+
+#define STACK_OFFSET(k)	(k)
+#define TCALL_CNT	(MAX_BPF_JIT_REG + 0)	/* Tail Call Count */
+#define TMP_REG_1	(MAX_BPF_JIT_REG + 1)	/* TEMP Register 1 */
+#define TMP_REG_2	(MAX_BPF_JIT_REG + 2)	/* TEMP Register 2 */
+
+#define IA32_EAX	(0x0)
+#define IA32_EBX	(0x3)
+#define IA32_ECX	(0x1)
+#define IA32_EDX	(0x2)
+#define IA32_ESI	(0x6)
+#define IA32_EDI	(0x7)
+#define IA32_EBP	(0x5)
+#define IA32_ESP	(0x4)
+
+/* list of x86 cond jumps opcodes (. + s8)
+ * Add 0x10 (and an extra 0x0f) to generate far jumps (. + s32)
+ */
+#define IA32_JB  0x72
+#define IA32_JAE 0x73
+#define IA32_JE  0x74
+#define IA32_JNE 0x75
+#define IA32_JBE 0x76
+#define IA32_JA  0x77
+#define IA32_JL  0x7C
+#define IA32_JGE 0x7D
+#define IA32_JLE 0x7E
+#define IA32_JG  0x7F
+
+/*
+ * Map eBPF registers to x86_32 32bit registers or stack scratch space.
+ *
+ * 1. First argument is passed using the x86_32 32bit registers and rest
+ *    of the arguments are passed on stack scratch space.
+ * 2. All callee-saved arguments are mapped to scratch space on stack.
+ * 3. We need two 64 bit temp registers to do complex operations on eBPF
+ *    registers.
+ *
+ * As the eBPF registers are all 64 bit registers and x86_32 has only 32 bit
+ * registers, we have to map each eBPF registers with two x86_32 32 bit regs
+ * or scratch memory space and we have to build eBPF 64 bit register from those.
+ *
+ */
+static const u8 bpf2ia32[][2] = {
+	/* return value from in-kernel function, and exit value from eBPF */
+	[BPF_REG_0] = {STACK_OFFSET(0), STACK_OFFSET(4)},
+
+	/* arguments from eBPF program to in-kernel function */
+	/* Stored on stack scratch space */
+	[BPF_REG_1] = {STACK_OFFSET(8), STACK_OFFSET(12)},
+	[BPF_REG_2] = {STACK_OFFSET(16), STACK_OFFSET(20)},
+	[BPF_REG_3] = {STACK_OFFSET(24), STACK_OFFSET(28)},
+	[BPF_REG_4] = {STACK_OFFSET(32), STACK_OFFSET(36)},
+	[BPF_REG_5] = {STACK_OFFSET(40), STACK_OFFSET(44)},
+
+	/* callee saved registers that in-kernel function will preserve */
+	/* Stored on stack scratch space */
+	[BPF_REG_6] = {STACK_OFFSET(48), STACK_OFFSET(52)},
+	[BPF_REG_7] = {STACK_OFFSET(56), STACK_OFFSET(60)},
+	[BPF_REG_8] = {STACK_OFFSET(64), STACK_OFFSET(68)},
+	[BPF_REG_9] = {STACK_OFFSET(72), STACK_OFFSET(76)},
+
+	/* Read only Frame Pointer to access Stack */
+	[BPF_REG_FP] = {STACK_OFFSET(80), STACK_OFFSET(84)},
+
+	/* temporary register for blinding constants.
+	 * Stored on stack scratch space.
+	 */
+	[BPF_REG_AX] = {STACK_OFFSET(88), STACK_OFFSET(92)},
+
+	/* Tail call count. Stored on stack scratch space. */
+	[TCALL_CNT] = {STACK_OFFSET(96), STACK_OFFSET(100)},
+
+	/* Temporary Register for internal BPF JIT, can be used
+	 * for constant blindings and others.
+	 */
+	[TMP_REG_1] = {IA32_ESI, IA32_EDI},
+	[TMP_REG_2] = {IA32_EAX, IA32_EDX},
+};
+
+#define dst_lo	dst[0]
+#define dst_hi	dst[1]
+#define src_lo	src[0]
+#define src_hi	src[1]
+
+#define STACK_ALIGNMENT	8
+/* Stack space for BPF_REG_1, BPF_REG_2, BPF_REG_3, BPF_REG_4,
+ * BPF_REG_5, BPF_REG_6, BPF_REG_7, BPF_REG_8, BPF_REG_9,
+ * BPF_REG_FP, BPF_REG_AX and Tail call counts.
+ */
+#define SCRATCH_SIZE 104
+
+/* total stack size used in JITed code */
+#define _STACK_SIZE \
+	(stack_depth + \
+	 + SCRATCH_SIZE + \
+	 + 4 /* extra for skb_copy_bits buffer */)
+
+#define STACK_SIZE ALIGN(_STACK_SIZE, STACK_ALIGNMENT)
+
+/* Get the offset of eBPF REGISTERs stored on scratch space. */
+#define STACK_VAR(off) (off)
+
+/* Offset of skb_copy_bits buffer */
+#define SKB_BUFFER STACK_VAR(SCRATCH_SIZE)
+
+/* encode 'dst_reg' register into x86_32 opcode 'byte' */
+static u8 add_1reg(u8 byte, u32 dst_reg)
+{
+	return byte + dst_reg;
+}
+
+/* encode 'dst_reg' and 'src_reg' registers into x86_32 opcode 'byte' */
+static u8 add_2reg(u8 byte, u32 dst_reg, u32 src_reg)
+{
+	return byte + dst_reg + (src_reg << 3);
+}
+
+static void jit_fill_hole(void *area, unsigned int size)
+{
+	/* fill whole space with int3 instructions */
+	memset(area, 0xcc, size);
+}
+
+static inline void emit_ia32_mov_i(const u8 dst, const u32 val,
+				   u8 **pprog)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+
+	EMIT3_off32(0xC7, add_1reg(0x40, IA32_EBP), STACK_VAR(dst), val);
+
+	*pprog = prog;
+}
+
+/* dst = imm (4 bytes)*/
+static inline void emit_ia32_mov_r(const u8 dst, const u8 src, u8 **pprog)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+	const u8 *tmp = bpf2ia32[TMP_REG_1];
+
+	/* mov esi,dword ptr [ebp+off] */
+	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(src));
+	/* mov dword ptr [ebp+off],esi */
+	EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(dst));
+
+	*pprog = prog;
+}
+
+/* dst = src */
+static inline void emit_ia32_mov_r64(const bool is64, const u8 dst[],
+				     const u8 src[], u8 **pprog)
+{
+	emit_ia32_mov_r(dst_lo, src_lo, pprog);
+	if (is64) {
+		/* complete 8 byte move */
+		emit_ia32_mov_r(dst_hi, src_hi, pprog);
+	} else {
+		/* Zero out high 4 bytes */
+		emit_ia32_mov_i(dst_hi, 0, pprog);
+	}
+}
+
+/* Sign extended move */
+static inline void emit_ia32_mov_i64(const bool is64, const u8 dst[],
+				     const u32 val, u8 **pprog)
+{
+	u32 hi = 0;
+
+	if (is64 && (val & (1<<31)))
+		hi = (u32)~0;
+
+	emit_ia32_mov_i(dst_lo, val, pprog);
+	emit_ia32_mov_i(dst_hi, hi, pprog);
+}
+
+/* ALU operation (32 bit)
+ * dst = dst (op) src
+ */
+static inline void emit_ia32_alu_r(const bool is64, const bool hi, const u8 op,
+				   const u8 dst, const u8 src, u8 **pprog)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+	const u8 *tmp = bpf2ia32[TMP_REG_1];
+
+	switch (BPF_OP(op)) {
+	/* dst = dst + src */
+	case BPF_ADD: {
+		/* mov esi,dword ptr [ebp+off] */
+		EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(src));
+
+		if (hi && is64)
+			EMIT3(0x11, add_2reg(0x40, IA32_EBP, tmp[0]),
+			      STACK_VAR(dst));
+		else
+			EMIT3(0x01, add_2reg(0x40, IA32_EBP, tmp[0]),
+			      STACK_VAR(dst));
+		break;
+	}
+	/* dst = dst - src */
+	case BPF_SUB: {
+		/* mov esi,dword ptr [ebp+off] */
+		EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(src));
+
+		if (hi && is64)
+			EMIT3(0x19, add_2reg(0x40, IA32_EBP, tmp[0]),
+			      STACK_VAR(dst));
+		else
+			EMIT3(0x29, add_2reg(0x40, IA32_EBP, tmp[0]),
+			      STACK_VAR(dst));
+		break;
+	}
+	/* dst = dst | src */
+	case BPF_OR: {
+		/* mov esi,dword ptr [ebp+off] */
+		EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(src));
+		EMIT3(0x09, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(dst));
+		break;
+	}
+	/* dst = dst & src */
+	case BPF_AND: {
+		/* mov esi,dword ptr [ebp+off] */
+		EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(src));
+		EMIT3(0x21, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(dst));
+		break;
+	}
+	/* dst = dst ^ src */
+	case BPF_XOR: {
+		/* mov esi,dword ptr [ebp+off] */
+		EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(src));
+		EMIT3(0x31, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(dst));
+		break;
+	}
+	/* dst = dst * src */
+	case BPF_MUL: {
+		const u8 *tmp = bpf2ia32[TMP_REG_2];
+
+		/* mov esi,dword ptr [ebp+off] */
+		EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(dst));
+		EMIT3(0xF7, add_1reg(0x60, IA32_EBP), STACK_VAR(src));
+		EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(dst));
+		break;
+	}
+	/* dst = dst << src */
+	case BPF_LSH: {
+		/* mov ecx,dword ptr [ebp+off] */
+		EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_ECX), STACK_VAR(src));
+		EMIT3(0xD3, add_1reg(0x60, IA32_EBP), STACK_VAR(dst));
+		break;
+	}
+	/* dst = dst >> src */
+	case BPF_RSH: {
+		/* mov ecx,dword ptr [ebp+off] */
+		EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_ECX), STACK_VAR(src));
+		EMIT3(0xD3, add_1reg(0x68, IA32_EBP), STACK_VAR(dst));
+		break;
+	}
+	/* dst = dst >> src (signed)*/
+	case BPF_ARSH:
+		/* mov ecx,dword ptr [ebp+off] */
+		EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_ECX), STACK_VAR(src));
+		EMIT3(0xD3, add_1reg(0x78, IA32_EBP), STACK_VAR(dst));
+		break;
+	}
+	*pprog = prog;
+}
+
+/* ALU operation (64 bit) */
+static inline void emit_ia32_alu_r64(const bool is64, const u8 op,
+				     const u8 dst[], const u8 src[],
+				     u8 **pprog)
+{
+	u8 *prog = *pprog;
+
+	emit_ia32_alu_r(is64, false, op, dst_lo, src_lo, &prog);
+	if (is64)
+		emit_ia32_alu_r(is64, true, op, dst_hi, src_hi, &prog);
+	else
+		emit_ia32_mov_i(dst_hi, 0, &prog);
+	*pprog = prog;
+}
+
+/* ALU operation (32 bit)
+ * dst = dst (op) val
+ */
+static inline void emit_ia32_alu_i(const bool is64, const bool hi, const u8 op,
+				  const u8 dst, const s32 val, u8 **pprog)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+	const u8 *tmp = bpf2ia32[TMP_REG_1];
+
+	switch (op) {
+	/* dst = dst + val */
+	case BPF_ADD: {
+		if (hi && is64) {
+			if (is_imm8(val)) {
+				EMIT3(0x83, add_1reg(0x50, IA32_EBP),
+				      STACK_VAR(dst));
+				EMIT(val, 1);
+			} else {
+				/* mov esi,imm32*/
+				EMIT2_off32(0xC7, add_1reg(0xC0, tmp[0]), val);
+				EMIT3(0x11, add_2reg(0x40, IA32_EBP, tmp[0]),
+				      STACK_VAR(dst));
+			}
+		} else {
+			if (is_imm8(val)) {
+				EMIT4(0x83, add_1reg(0x40, IA32_EBP),
+				      STACK_VAR(dst), val);
+			} else {
+				/* mov esi,imm32*/
+				EMIT2_off32(0xC7, add_1reg(0xC0, tmp[0]), val);
+				EMIT3(0x01, add_2reg(0x40, IA32_EBP, tmp[0]),
+				      STACK_VAR(dst));
+			}
+		}
+		break;
+	}
+	/* dst = dst - val */
+	case BPF_SUB: {
+		if (hi && is64) {
+			if (is_imm8(val)) {
+				EMIT4(0x83, add_1reg(0x58, IA32_EBP),
+				      STACK_VAR(dst), val);
+			} else {
+				/* mov esi,imm32*/
+				EMIT2_off32(0xC7, add_1reg(0xC0, tmp[0]), val);
+				EMIT3(0x19, add_2reg(0x40, IA32_EBP, tmp[0]),
+				      STACK_VAR(dst));
+			}
+		} else {
+			if (is_imm8(val)) {
+				EMIT4(0x83, add_1reg(0x68, IA32_EBP),
+				      STACK_VAR(dst), val);
+			} else {
+				/* mov esi,imm32*/
+				EMIT2_off32(0xC7, add_1reg(0xC0, tmp[0]), val);
+				EMIT3(0x29, add_2reg(0x40, IA32_EBP, tmp[0]),
+				      STACK_VAR(dst));
+			}
+		}
+		break;
+	}
+	/* dst = dst | val */
+	case BPF_OR: {
+		if (is_imm8(val)) {
+			EMIT4(0x83, add_1reg(0x48, IA32_EBP), STACK_VAR(dst),
+			      val);
+		} else {
+			/* mov esi,imm32*/
+			EMIT2_off32(0xC7, add_1reg(0xC0, tmp[0]), val);
+			EMIT3(0x09, add_2reg(0x40, IA32_EBP, tmp[0]),
+			      STACK_VAR(dst));
+		}
+		break;
+	}
+	/* dst = dst & val */
+	case BPF_AND: {
+		if (is_imm8(val)) {
+			EMIT4(0x83, add_1reg(0x60, IA32_EBP), STACK_VAR(dst),
+			      val);
+		} else {
+			/* mov esi,imm32*/
+			EMIT2_off32(0xC7, add_1reg(0xC0, tmp[0]), val);
+			EMIT3(0x21, add_2reg(0x40, IA32_EBP, tmp[0]),
+			      STACK_VAR(dst));
+		}
+		break;
+	}
+	/* dst = dst ^ val */
+	case BPF_XOR: {
+		if (is_imm8(val)) {
+			EMIT4(0x83, add_1reg(0x70, IA32_EBP),
+			      STACK_VAR(dst), val);
+		} else {
+			/* mov esi,imm32*/
+			EMIT2_off32(0xC7, add_1reg(0xC0, tmp[0]), val);
+			EMIT3(0x31, add_2reg(0x40, IA32_EBP, tmp[0]),
+			      STACK_VAR(dst));
+		}
+		break;
+	}
+	/* dst = dst * val */
+	case BPF_MUL: {
+		const u8 *tmp = bpf2ia32[TMP_REG_2];
+
+		/* mov eax,val */
+		EMIT2_off32(0xC7, add_1reg(0xC0, tmp[0]), val);
+		EMIT3(0xF7, add_1reg(0x60, IA32_EBP), STACK_VAR(dst));
+		EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(dst));
+		break;
+	}
+	/* dst = dst << val */
+	case BPF_LSH: {
+		if (is_imm8(val)) {
+			EMIT4(0xC1, add_1reg(0x60, IA32_EBP), STACK_VAR(dst),
+			      val);
+		} else {
+			/* mov esi,imm32*/
+			EMIT2_off32(0xC7, add_1reg(0xC0, tmp[0]), val);
+			EMIT3(0xD3, add_1reg(0x60, IA32_EBP), STACK_VAR(dst));
+		}
+		break;
+	}
+	/* dst = dst >> val */
+	case BPF_RSH: {
+		if (is_imm8(val)) {
+			EMIT4(0xC1, add_1reg(0x68, IA32_EBP), STACK_VAR(dst),
+			      val);
+		} else {
+			/* mov esi,imm32*/
+			EMIT2_off32(0xC7, add_1reg(0xC0, tmp[0]), val);
+			EMIT3(0xD3, add_1reg(0x68, IA32_EBP), STACK_VAR(dst));
+		}
+		break;
+	}
+	/* dst = dst >> val (signed)*/
+	case BPF_ARSH:
+		if (is_imm8(val)) {
+			EMIT4(0xC1, add_1reg(0x78, IA32_EBP), STACK_VAR(dst),
+			      val);
+		} else {
+			/* mov esi,imm32*/
+			EMIT2_off32(0xC7, add_1reg(0xC0, tmp[0]), val);
+			EMIT3(0xD3, add_1reg(0x78, IA32_EBP), STACK_VAR(dst));
+		}
+		break;
+	case BPF_NEG:
+		/* xor esi,esi */
+		EMIT2(0x31, add_2reg(0xC0, tmp[0], tmp[0]));
+		EMIT3(0x2B, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(dst));
+		EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(dst));
+		break;
+	}
+
+	*pprog = prog;
+}
+
+/* ALU operation (64 bit) */
+static inline void emit_ia32_alu_i64(const bool is64, const u8 op,
+				     const u8 dst[], const u32 val,
+				     u8 **pprog)
+{
+	u8 *prog = *pprog;
+	u32 hi = 0;
+
+	if (is64 && (val & (1<<31)))
+		hi = (u32)~0;
+
+	emit_ia32_alu_i(is64, false, op, dst_lo, val, &prog);
+	if (is64)
+		emit_ia32_alu_i(is64, true, op, dst_hi, hi, &prog);
+	else
+		emit_ia32_mov_i(dst_hi, 0, &prog);
+
+	*pprog = prog;
+}
+
+/* dst = ~dst (64 bit) */
+static inline void emit_ia32_neg64(const u8 dst[], u8 **pprog)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+	const u8 *tmp = bpf2ia32[TMP_REG_1];
+
+	/* xor esi,esi */
+	EMIT2(0x31, add_2reg(0xC0, tmp[0], tmp[0]));
+
+	EMIT3(0x2B, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(dst_lo));
+	EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(dst_lo));
+
+	EMIT3(0x19, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(dst_hi));
+	EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(dst_hi));
+
+	*pprog = prog;
+}
+
+/* dst = dst << src */
+static inline void emit_ia32_lsh_r64(const u8 dst[], const u8 src[], u8 **pprog)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+	const u8 *tmp = bpf2ia32[TMP_REG_1];
+	static int jmp_label1 = -1;
+	static int jmp_label2 = -1;
+	static int jmp_label3 = -1;
+
+	/* mov ecx,dword ptr [ebp+off] */
+	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_ECX), STACK_VAR(src_lo));
+
+	/* cmp ecx,32 */
+	EMIT3(0x83, add_1reg(0xF8, IA32_ECX), 32);
+	/* jumps when >= 32 */
+	if (is_imm8(jmp_label(jmp_label1, 2)))
+		EMIT2(IA32_JAE, jmp_label(jmp_label1, 2));
+	else
+		EMIT2_off32(0x0F, IA32_JAE + 0x10, jmp_label(jmp_label1, 6));
+
+	/* < 32 */
+	/* mov esi,32 */
+	EMIT2_off32(0xC7, add_1reg(0xC0, tmp[0]), 32);
+	/* sub esi,ecx */
+	EMIT2(0x29, add_2reg(0xC0, tmp[0], IA32_ECX));
+
+	/* shl dword ptr [ebp+off],cl */
+	EMIT3(0xD3, add_1reg(0x60, IA32_EBP), STACK_VAR(dst_hi));
+	/* mov edi,dword ptr [ebp+off] */
+	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[1]), STACK_VAR(dst_lo));
+	/* shl dword ptr [ebp+off],cl */
+	EMIT3(0xD3, add_1reg(0x60, IA32_EBP), STACK_VAR(dst_lo));
+
+	/* mov ecx,esi */
+	EMIT2(0x89, add_2reg(0xC0, IA32_ECX, tmp[0]));
+	/* shr edi,cl */
+	EMIT2(0xD3, add_1reg(0xE8, tmp[1]));
+	/* or dword ptr [ebp+off],edi */
+	EMIT3(0x09, add_2reg(0x40, IA32_EBP, tmp[1]), STACK_VAR(dst_hi));
+	if (is_imm8(jmp_label(jmp_label3, 2)))
+		EMIT2(0xEB, jmp_label(jmp_label3, 2));
+	else
+		EMIT1_off32(0xE9, jmp_label(jmp_label3, 5));
+
+	/* >= 32 */
+	if (jmp_label1 == -1)
+		jmp_label1 = cnt;
+	/* cmp ecx,64 */
+	EMIT3(0x83, add_1reg(0xF8, IA32_ECX), 64);
+	/* jumps when >= 64 */
+	if (is_imm8(jmp_label(jmp_label2, 2)))
+		EMIT2(IA32_JAE, jmp_label(jmp_label2, 2));
+	else
+		EMIT2_off32(0x0F, IA32_JAE + 0x10, jmp_label(jmp_label2, 6));
+
+	/* >= 32 && < 64 */
+	/* sub ecx,32 */
+	EMIT3(0x83, add_1reg(0xE8, IA32_ECX), 32);
+	/* mov esi,dword ptr [ebp+off] */
+	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(dst_lo));
+	/* shl esi,cl */
+	EMIT2(0xD3, add_1reg(0xE0, tmp[0]));
+	/* mov dword ptr [ebp+off],esi */
+	EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(dst_hi));
+
+	EMIT3(0xC7, add_1reg(0x40, IA32_EBP), STACK_VAR(dst_lo));
+	EMIT(0x0, 4);
+	if (is_imm8(jmp_label(jmp_label3, 2)))
+		EMIT2(0xEB, jmp_label(jmp_label3, 2));
+	else
+		EMIT1_off32(0xE9, jmp_label(jmp_label3, 5));
+
+	/* >= 64 */
+	if (jmp_label2 == -1)
+		jmp_label2 = cnt;
+	EMIT3(0xC7, add_1reg(0x40, IA32_EBP), STACK_VAR(dst_hi));
+	EMIT(0x0, 4);
+	EMIT3(0xC7, add_1reg(0x40, IA32_EBP), STACK_VAR(dst_lo));
+	EMIT(0x0, 4);
+
+	if (jmp_label3 == -1)
+		jmp_label3 = cnt;
+
+	*pprog = prog;
+}
+
+/* dst = dst >> src (signed)*/
+static inline void emit_ia32_arsh_r64(const u8 dst[], const u8 src[],
+				      u8 **pprog)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+	const u8 *tmp = bpf2ia32[TMP_REG_1];
+	static int jmp_label1 = -1;
+	static int jmp_label2 = -1;
+	static int jmp_label3 = -1;
+
+	/* mov ecx,dword ptr [ebp+off] */
+	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_ECX), STACK_VAR(src_lo));
+
+	/* cmp ecx,32 */
+	EMIT3(0x83, add_1reg(0xF8, IA32_ECX), 32);
+	/* jumps when >= 32 */
+	if (is_imm8(jmp_label(jmp_label1, 2)))
+		EMIT2(IA32_JAE, jmp_label(jmp_label1, 2));
+	else
+		EMIT2_off32(0x0F, IA32_JAE + 0x10, jmp_label(jmp_label1, 6));
+
+	/* < 32 */
+	/* mov esi,32 */
+	EMIT2_off32(0xC7, add_1reg(0xC0, tmp[0]), 32);
+	/* sub esi,ecx */
+	EMIT2(0x29, add_2reg(0xC0, tmp[0], IA32_ECX));
+
+	/* lshr dword ptr [ebp+off],cl */
+	EMIT3(0xD3, add_1reg(0x68, IA32_EBP), STACK_VAR(dst_lo));
+	/* mov edi,dword ptr [ebp+off] */
+	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[1]), STACK_VAR(dst_hi));
+	/* ashr dword ptr [ebp+off],cl */
+	EMIT3(0xD3, add_1reg(0x78, IA32_EBP), STACK_VAR(dst_hi));
+
+	/* mov ecx,esi */
+	EMIT2(0x89, add_2reg(0xC0, IA32_ECX, tmp[0]));
+	/* shl edi,cl */
+	EMIT2(0xD3, add_1reg(0xE0, tmp[1]));
+	/* or dword ptr [ebp+off],edi */
+	if (is_imm8(jmp_label(jmp_label3, 2)))
+		EMIT2(0xEB, jmp_label(jmp_label3, 2));
+	else
+		EMIT1_off32(0xE9, jmp_label(jmp_label3, 5));
+
+	/* >= 32 */
+	if (jmp_label1 == -1)
+		jmp_label1 = cnt;
+	/* cmp ecx,64 */
+	EMIT3(0x83, add_1reg(0xF8, IA32_ECX), 64);
+	/* jumps when >= 64 */
+	if (is_imm8(jmp_label(jmp_label2, 2)))
+		EMIT2(IA32_JAE, jmp_label(jmp_label2, 2));
+	else
+		EMIT2_off32(0x0F, IA32_JAE + 0x10, jmp_label(jmp_label2, 6));
+
+	/* >= 32 && < 64 */
+	/* sub ecx,32 */
+	EMIT3(0x83, add_1reg(0xE8, IA32_ECX), 32);
+	/* mov esi,dword ptr [ebp+off] */
+	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(dst_hi));
+	/* ashr esi,cl */
+	EMIT2(0xD3, add_1reg(0xF8, tmp[0]));
+	/* mov dword ptr [ebp+off],esi */
+	EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(dst_lo));
+
+	/* ashr dword ptr [ebp+off],imm8 */
+	EMIT3(0xC1, add_1reg(0x78, IA32_EBP), STACK_VAR(dst_hi));
+	EMIT(31, 1);
+	if (is_imm8(jmp_label(jmp_label3, 2)))
+		EMIT2(0xEB, jmp_label(jmp_label3, 2));
+	else
+		EMIT1_off32(0xE9, jmp_label(jmp_label3, 5));
+
+	/* >= 64 */
+	if (jmp_label2 == -1)
+		jmp_label2 = cnt;
+	/* mov esi,dword ptr [ebp+off] */
+	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(dst_hi));
+	/* ashr esi,imm8 */
+	EMIT3(0xC1, add_1reg(0xF8, tmp[0]), 31);
+	/* mov dword ptr [ebp+off],esi */
+	EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(dst_hi));
+	/* mov dword ptr [ebp+off],esi */
+	EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(dst_lo));
+
+	if (jmp_label3 == -1)
+		jmp_label3 = cnt;
+
+	*pprog = prog;
+}
+
+/* dst = dst >> src */
+static inline void emit_ia32_rsh_r64(const u8 dst[], const u8 src[], u8 **pprog)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+	const u8 *tmp = bpf2ia32[TMP_REG_1];
+	static int jmp_label1 = -1;
+	static int jmp_label2 = -1;
+	static int jmp_label3 = -1;
+
+	/* mov ecx,dword ptr [ebp+off] */
+	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_ECX), STACK_VAR(src_lo));
+
+	/* cmp ecx,32 */
+	EMIT3(0x83, add_1reg(0xF8, IA32_ECX), 32);
+	/* jumps when >= 32 */
+	if (is_imm8(jmp_label(jmp_label1, 2)))
+		EMIT2(IA32_JAE, jmp_label(jmp_label1, 2));
+	else
+		EMIT2_off32(0x0F, IA32_JAE + 0x10, jmp_label(jmp_label1, 6));
+
+	/* < 32 */
+	/* mov esi,32 */
+	EMIT2_off32(0xC7, add_1reg(0xC0, tmp[0]), 32);
+	/* sub esi,ecx */
+	EMIT2(0x29, add_2reg(0xC0, tmp[0], IA32_ECX));
+
+	/* lshr dword ptr [ebp+off],cl */
+	EMIT3(0xD3, add_1reg(0x68, IA32_EBP), STACK_VAR(dst_lo));
+	/* mov edi,dword ptr [ebp+off] */
+	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[1]), STACK_VAR(dst_hi));
+	/* shr dword ptr [ebp+off],cl */
+	EMIT3(0xD3, add_1reg(0x68, IA32_EBP), STACK_VAR(dst_hi));
+
+	/* mov ecx, esi */
+	EMIT2(0x89, add_2reg(0xC0, IA32_ECX, tmp[0]));
+	/* shl edi,cl */
+	EMIT2(0xD3, add_1reg(0xE0, tmp[1]));
+	/* or dword ptr [ebp+off],edi */
+	EMIT3(0x09, add_2reg(0x40, IA32_EBP, tmp[1]), STACK_VAR(dst_lo));
+	if (is_imm8(jmp_label(jmp_label3, 2)))
+		EMIT2(0xEB, jmp_label(jmp_label3, 2));
+	else
+		EMIT1_off32(0xE9, jmp_label(jmp_label3, 5));
+
+	/* >= 32 */
+	if (jmp_label1 == -1)
+		jmp_label1 = cnt;
+	/* cmp ecx,64 */
+	EMIT3(0x83, add_1reg(0xF8, IA32_ECX), 64);
+	/* jumps when >= 64 */
+	if (is_imm8(jmp_label(jmp_label2, 2)))
+		EMIT2(IA32_JAE, jmp_label(jmp_label2, 2));
+	else
+		EMIT2_off32(0x0F, IA32_JAE + 0x10, jmp_label(jmp_label2, 6));
+
+	/* >= 32 && < 64 */
+	/* sub ecx,32 */
+	EMIT3(0x83, add_1reg(0xE8, IA32_ECX), 32);
+	/* mov esi,dword ptr [ebp+off] */
+	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(dst_hi));
+	/* shr esi,cl */
+	EMIT2(0xD3, add_1reg(0xE8, tmp[0]));
+	/* mov dword ptr [ebp+off],esi */
+	EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(dst_lo));
+
+	EMIT3(0xC7, add_1reg(0x40, IA32_EBP), STACK_VAR(dst_hi));
+	EMIT(0x0, 4);
+	if (is_imm8(jmp_label(jmp_label3, 2)))
+		EMIT2(0xEB, jmp_label(jmp_label3, 2));
+	else
+		EMIT1_off32(0xE9, jmp_label(jmp_label3, 5));
+
+	/* >= 64 */
+	if (jmp_label2 == -1)
+		jmp_label2 = cnt;
+	EMIT3(0xC7, add_1reg(0x40, IA32_EBP), STACK_VAR(dst_hi));
+	EMIT(0x0, 4);
+	EMIT3(0xC7, add_1reg(0x40, IA32_EBP), STACK_VAR(dst_lo));
+	EMIT(0x0, 4);
+
+	if (jmp_label3 == -1)
+		jmp_label3 = cnt;
+
+	*pprog = prog;
+}
+
+/* dst = dst << val */
+static inline void emit_ia32_lsh_i64(const u8 dst[], const u32 val, u8 **pprog)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+	const u8 *tmp = bpf2ia32[TMP_REG_1];
+
+	/* Do LSH operation */
+	if (val < 32) {
+		/* mov esi,32 */
+		EMIT2_off32(0xC7, add_1reg(0xC0, tmp[0]), 32);
+		/* sub esi,imm8 */
+		EMIT3(0x83, add_1reg(0xE8, tmp[0]), val);
+
+		/* shl dword ptr [ebp+off],imm8 */
+		EMIT3(0xC1, add_1reg(0x60, IA32_EBP), STACK_VAR(dst_hi));
+		EMIT(val, 1);
+		/* mov edi,dword ptr [ebp+off] */
+		EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[1]),
+		      STACK_VAR(dst_lo));
+		/* shl dword ptr [ebp+off],imm8 */
+		EMIT3(0xC1, add_1reg(0x60, IA32_EBP), STACK_VAR(dst_lo));
+		EMIT(val, 1);
+
+		/* mov ecx,esi */
+		EMIT2(0x89, add_2reg(0xC0, IA32_ECX, tmp[0]));
+		/* shr edi,cl */
+		EMIT2(0xD3, add_1reg(0xE8, tmp[1]));
+		/* or dword ptr [ebp+off],edi */
+		EMIT3(0x09, add_2reg(0x40, IA32_EBP, tmp[1]),
+		      STACK_VAR(dst_hi));
+	} else if (val >= 32 && val < 64) {
+		u32 value = val - 32;
+
+		/* mov esi,dword ptr [ebp+off] */
+		EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]),
+		      STACK_VAR(dst_lo));
+		/* shl esi,imm8 */
+		EMIT3(0xC1, add_1reg(0xE0, tmp[0]), value);
+		/* mov dword ptr [ebp+off],esi */
+		EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp[0]),
+		      STACK_VAR(dst_hi));
+		EMIT3(0xC7, add_1reg(0x40, IA32_EBP), STACK_VAR(dst_lo));
+		EMIT(0x0, 4);
+	} else {
+		EMIT3(0xC7, add_1reg(0x40, IA32_EBP), STACK_VAR(dst_hi));
+		EMIT(0x0, 4);
+		EMIT3(0xC7, add_1reg(0x40, IA32_EBP), STACK_VAR(dst_lo));
+		EMIT(0x0, 4);
+	}
+
+	*pprog = prog;
+}
+
+/* dst = dst >> val */
+static inline void emit_ia32_rsh_i64(const u8 dst[], const u32 val, u8 **pprog)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+	const u8 *tmp = bpf2ia32[TMP_REG_1];
+
+	/* Do RSH operation */
+	if (val < 32) {
+		/* mov esi,32 */
+		EMIT2_off32(0xC7, add_1reg(0xC0, tmp[0]), 32);
+		/* sub esi,imm8 */
+		EMIT3(0x83, add_1reg(0xE8, tmp[0]), val);
+
+		/* shr dword ptr [ebp+off],imm8 */
+		EMIT3(0xC1, add_1reg(0x68, IA32_EBP), STACK_VAR(dst_lo));
+		EMIT(val, 1);
+		/* mov edi,dword ptr [ebp+off] */
+		EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[1]),
+		      STACK_VAR(dst_hi));
+		/* shr dword ptr [ebp+off],imm8 */
+		EMIT3(0xC1, add_1reg(0x68, IA32_EBP), STACK_VAR(dst_hi));
+		EMIT(val, 1);
+
+		/* mov ecx,esi */
+		EMIT2(0x89, add_2reg(0xC0, IA32_ECX, tmp[0]));
+		/* shl edi,cl */
+		EMIT2(0xD3, add_1reg(0xE0, tmp[1]));
+		/* or dword ptr [ebp+off],edi */
+		EMIT3(0x09, add_2reg(0x40, IA32_EBP, tmp[1]),
+		      STACK_VAR(dst_lo));
+	} else if (val >= 32 && val < 64) {
+		u32 value = val - 32;
+
+		/* mov esi,dword ptr [ebp+off] */
+		EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]),
+		      STACK_VAR(dst_hi));
+		/* shr esi,imm8 */
+		EMIT3(0xC1, add_1reg(0xE8, tmp[0]), value);
+		/* mov dword ptr [ebp+off],esi */
+		EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp[0]),
+		      STACK_VAR(dst_lo));
+		EMIT3(0xC7, add_1reg(0x40, IA32_EBP), STACK_VAR(dst_hi));
+		EMIT(0x0, 4);
+	} else {
+		EMIT3(0xC7, add_1reg(0x40, IA32_EBP), STACK_VAR(dst_hi));
+		EMIT(0x0, 4);
+		EMIT3(0xC7, add_1reg(0x40, IA32_EBP), STACK_VAR(dst_lo));
+		EMIT(0x0, 4);
+	}
+
+	*pprog = prog;
+}
+
+/* dst = dst >> val (signed) */
+static inline void emit_ia32_arsh_i64(const u8 dst[], const u32 val, u8 **pprog)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+	const u8 *tmp = bpf2ia32[TMP_REG_1];
+
+	/* Do RSH operation */
+	if (val < 32) {
+		/* mov esi,32 */
+		EMIT2_off32(0xC7, add_1reg(0xC0, tmp[0]), 32);
+		/* sub esi,imm8 */
+		EMIT3(0x83, add_1reg(0xE8, tmp[0]), val);
+
+		/* shr dword ptr [ebp+off],imm8 */
+		EMIT3(0xC1, add_1reg(0x68, IA32_EBP), STACK_VAR(dst_lo));
+		EMIT(val, 1);
+		/* mov edi,dword ptr [ebp+off] */
+		EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[1]),
+		      STACK_VAR(dst_hi));
+		/* ashr dword ptr [ebp+off],imm8 */
+		EMIT3(0xC1, add_1reg(0x78, IA32_EBP), STACK_VAR(dst_hi));
+		EMIT(val, 1);
+
+		/* mov ecx,esi */
+		EMIT2(0x89, add_2reg(0xC0, IA32_ECX, tmp[0]));
+		/* shl edi,cl */
+		EMIT2(0xD3, add_1reg(0xE0, tmp[1]));
+		/* or dword ptr [ebp+off],edi */
+		EMIT3(0x09, add_2reg(0x40, IA32_EBP, tmp[1]),
+		      STACK_VAR(dst_lo));
+	} else if (val >= 32 && val < 64) {
+		u32 value = val - 32;
+
+		/* mov esi,dword ptr [ebp+off] */
+		EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]),
+		      STACK_VAR(dst_hi));
+		/* ashr esi,imm8 */
+		EMIT3(0xC1, add_1reg(0xF8, tmp[0]), value);
+		/* mov dword ptr [ebp+off],esi */
+		EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp[0]),
+		      STACK_VAR(dst_lo));
+
+		/* ashr dword ptr [ebp+off],imm8 */
+		EMIT3(0xC1, add_1reg(0x78, IA32_EBP), STACK_VAR(dst_hi));
+		EMIT(31, 1);
+	} else {
+		/* mov esi,dword ptr [ebp+off] */
+		EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]),
+		      STACK_VAR(dst_hi));
+		/* ashr esi,imm8 */
+		EMIT3(0xC1, add_1reg(0xF8, tmp[0]), 31);
+		/* mov dword ptr [ebp+off],esi */
+		EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp[0]),
+		      STACK_VAR(dst_hi));
+		/* mov dword ptr [ebp+off],esi */
+		EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp[0]),
+		      STACK_VAR(dst_lo));
+	}
+
+	*pprog = prog;
+}
+
+static inline void emit_ia32_mul_r64(const u8 dst[], const u8 src[], u8 **pprog)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+	const u8 *tmp = bpf2ia32[TMP_REG_1];
+	const u8 *tmp2 = bpf2ia32[TMP_REG_2];
+
+	/* mov eax,dword ptr [ebp+off] */
+	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp2[0]), STACK_VAR(dst_hi));
+	/* mul dword ptr [ebp+off] */
+	EMIT3(0xF7, add_1reg(0x60, IA32_EBP), STACK_VAR(src_lo));
+	/* mov esi,eax */
+	EMIT2(0x89, add_2reg(0xC0, tmp[0], tmp2[0]));
+
+	/* mov eax,dword ptr [ebp+off] */
+	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp2[0]), STACK_VAR(dst_lo));
+	/* mul dword ptr [ebp+off] */
+	EMIT3(0xF7, add_1reg(0x60, IA32_EBP), STACK_VAR(src_hi));
+	/* mov edi,eax */
+	EMIT2(0x89, add_2reg(0xC0, tmp[1], tmp2[0]));
+
+	/* add esi,edi */
+	EMIT2(0x01, add_2reg(0xC0, tmp[0], tmp[1]));
+
+	/* mov eax,dword ptr [ebp+off] */
+	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp2[0]), STACK_VAR(dst_lo));
+	/* mul dword ptr [ebp+off] */
+	EMIT3(0xF7, add_1reg(0x60, IA32_EBP), STACK_VAR(src_lo));
+
+	/* add esi,edx */
+	EMIT2(0x01, add_2reg(0xC0, tmp[0], tmp2[1]));
+
+	/* mov dword ptr [ebp+off],eax */
+	EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp2[0]), STACK_VAR(dst_lo));
+
+	/* mov dword ptr [ebp+off],esi */
+	EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(dst_hi));
+
+	*pprog = prog;
+}
+
+static inline void emit_ia32_mul_i64(const u8 dst[], const u32 val, u8 **pprog)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+	const u8 *tmp = bpf2ia32[TMP_REG_1];
+	const u8 *tmp2 = bpf2ia32[TMP_REG_2];
+	u32 hi;
+
+	hi = val & (1<<31) ? (u32)~0 : 0;
+	/* movl eax,imm32 */
+	EMIT2_off32(0xC7, add_1reg(0xC0, tmp2[0]), val);
+	/* mul dword ptr [ebp+off] */
+	EMIT3(0xF7, add_1reg(0x60, IA32_EBP), STACK_VAR(dst_hi));
+	/* mov esi,eax */
+	EMIT2(0x89, add_2reg(0xC0, tmp[0], tmp2[0]));
+
+	/* movl eax,imm32 */
+	EMIT2_off32(0xC7, add_1reg(0xC0, tmp2[0]), hi);
+	/* mul dword ptr [ebp+off] */
+	EMIT3(0xF7, add_1reg(0x60, IA32_EBP), STACK_VAR(dst_lo));
+	/* mov edi,eax */
+	EMIT2(0x89, add_2reg(0xC0, tmp[1], tmp2[0]));
+
+	/* add esi,edi */
+	EMIT2(0x01, add_2reg(0xC0, tmp[0], tmp[1]));
+
+	/* movl eax,imm32 */
+	EMIT2_off32(0xC7, add_1reg(0xC0, tmp2[0]), val);
+	/* mul dword ptr [ebp+off] */
+	EMIT3(0xF7, add_1reg(0x60, IA32_EBP), STACK_VAR(dst_lo));
+
+	/* add esi,edx */
+	EMIT2(0x01, add_2reg(0xC0, tmp[0], tmp2[1]));
+
+	/* mov dword ptr [ebp+off],eax */
+	EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp2[0]), STACK_VAR(dst_lo));
+
+	/* mov dword ptr [ebp+off],esi */
+	EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(dst_hi));
+
+	*pprog = prog;
+}
+
+static int bpf_size_to_x86_bytes(int bpf_size)
+{
+	if (bpf_size == BPF_W)
+		return 4;
+	else if (bpf_size == BPF_H)
+		return 2;
+	else if (bpf_size == BPF_B)
+		return 1;
+	else if (bpf_size == BPF_DW)
+		return 4; /* imm32 */
+	else
+		return 0;
+}
+
+#define CHOOSE_LOAD_FUNC(K, func) \
+	((int)K < 0 ? ((int)K >= SKF_LL_OFF ? func##_negative_offset : func) : \
+	 func##_positive_offset)
+
+struct jit_context {
+	int cleanup_addr; /* epilogue code offset */
+};
+
+/* maximum number of bytes emitted while JITing one eBPF insn */
+#define BPF_MAX_INSN_SIZE	128
+#define BPF_INSN_SAFETY		64
+
+#define PROLOGUE_SIZE 35
+
+/* emit prologue code for BPF program and check it's size.
+ * bpf_tail_call helper will skip it while jumping into another program
+ */
+static void emit_prologue(u8 **pprog, u32 stack_depth)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+	const u8 *r1 = bpf2ia32[BPF_REG_1];
+	const u8 *tmp = bpf2ia32[TMP_REG_1];
+	const u8 *tmp2 = bpf2ia32[TMP_REG_2];
+	const u8 fplo = bpf2ia32[BPF_REG_FP][0];
+	const u8 fphi = bpf2ia32[BPF_REG_FP][1];
+	const u8 *tcc = bpf2ia32[TCALL_CNT];
+
+	/* push ebp */
+	EMIT1(0x55);
+	/* mov ebp,esp */
+	EMIT2(0x89, 0xE5);
+	/* push edi */
+	EMIT1(0x57);
+	/* push esi */
+	EMIT1(0x56);
+	/* push ebx */
+	EMIT1(0x53);
+
+	/* sub esp,STACK_SIZE */
+	EMIT2_off32(0x81, 0xEC, STACK_SIZE);
+	/* sub ebp,SCRATCH_SIZE+4+12*/
+	EMIT3(0x83, add_1reg(0xE8, IA32_EBP), SCRATCH_SIZE + 16);
+	/* xor esi,esi */
+	EMIT2(0x31, add_2reg(0xC0, tmp[0], tmp[0]));
+
+	/* Set up BPF prog stack base register */
+	EMIT3(0x89, add_2reg(0x40, IA32_EBP, IA32_EBP), STACK_VAR(fplo));
+	EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(fphi));
+
+	/* Move BPF_CTX (EAX) to BPF_REG_R1 */
+	/* mov dword ptr [ebp+off],eax */
+	EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp2[0]), STACK_VAR(r1[0]));
+	EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(r1[1]));
+
+	/* Initialize Tail Count */
+	EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(tcc[0]));
+	EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(tcc[1]));
+
+	BUILD_BUG_ON(cnt != PROLOGUE_SIZE);
+	*pprog = prog;
+}
+
+/* Emit epilogue code for BPF program */
+static void emit_epilogue(u8 **pprog, u32 stack_depth)
+{
+	u8 *prog = *pprog;
+	const u8 *r0 = bpf2ia32[BPF_REG_0];
+	int cnt = 0;
+
+	/* mov eax,dword ptr [ebp+off]*/
+	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EAX), STACK_VAR(r0[0]));
+	/* mov edx,dword ptr [ebp+off]*/
+	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EDX), STACK_VAR(r0[1]));
+
+	/* add ebp,SCRATCH_SIZE+4+12*/
+	EMIT3(0x83, add_1reg(0xC0, IA32_EBP), SCRATCH_SIZE + 16);
+
+	/* mov ebx,dword ptr [ebp-12]*/
+	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EBX), -12);
+	/* mov esi,dword ptr [ebp-8]*/
+	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_ESI), -8);
+	/* mov edi,dword ptr [ebp-4]*/
+	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EDI), -4);
+
+	EMIT1(0xC9); /* leave */
+	EMIT1(0xC3); /* ret */
+	*pprog = prog;
+}
+
+/* generate the following code:
+ * ... bpf_tail_call(void *ctx, struct bpf_array *array, u64 index) ...
+ *   if (index >= array->map.max_entries)
+ *     goto out;
+ *   if (++tail_call_cnt > MAX_TAIL_CALL_CNT)
+ *     goto out;
+ *   prog = array->ptrs[index];
+ *   if (prog == NULL)
+ *     goto out;
+ *   goto *(prog->bpf_func + prologue_size);
+ * out:
+ */
+static void emit_bpf_tail_call(u8 **pprog)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+	const u8 *r1 = bpf2ia32[BPF_REG_1];
+	const u8 *r2 = bpf2ia32[BPF_REG_2];
+	const u8 *r3 = bpf2ia32[BPF_REG_3];
+	const u8 *tmp = bpf2ia32[TMP_REG_1];
+	const u8 *tmp2 = bpf2ia32[TMP_REG_2];
+	const u8 *tcc = bpf2ia32[TCALL_CNT];
+	u32 lo, hi;
+	static int jmp_label1 = -1;
+
+	/* if (index >= array->map.max_entries)
+	 *   goto out;
+	 */
+
+	/* mov esi,dword ptr [ebp+off] */
+	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(r2[0]));
+	/* mov edi,dword ptr [ebp+off] */
+	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[1]), STACK_VAR(r3[0]));
+
+	/* cmp dword ptr [esi + 16], edi */
+	EMIT3(0x39, add_2reg(0x40, tmp[0], tmp[1]),
+	      offsetof(struct bpf_array, map.max_entries));
+	/* jbe out */
+	EMIT2(IA32_JBE, jmp_label(jmp_label1, 2));
+
+	/* if (tail_call_cnt > MAX_TAIL_CALL_CNT)
+	 *   goto out;
+	 */
+	lo = (u32)MAX_TAIL_CALL_CNT;
+	hi = (u32)((u64)MAX_TAIL_CALL_CNT >> 32);
+	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp2[0]), STACK_VAR(tcc[0]));
+	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp2[1]), STACK_VAR(tcc[1]));
+
+	EMIT3(0x83, add_1reg(0xF8, tmp2[1]), hi);   /* cmp edx, hi */
+	EMIT2(IA32_JNE, 3);
+	EMIT3(0x83, add_1reg(0xF8, tmp2[0]), lo);   /* cmp ecx, lo */
+
+	EMIT2(IA32_JAE, jmp_label(jmp_label1, 2));   /* ja out */
+
+	EMIT3(0x83, add_1reg(0xC0, tmp2[0]), 0x01);   /* add eax, 0x1 */
+	EMIT3(0x83, add_1reg(0xD0, tmp2[1]), 0x00);   /* adc edx, 0x0 */
+
+	/* mov dword ptr [ebp + off], eax */
+	EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp2[0]), STACK_VAR(tcc[0]));
+	/* mov dword ptr [ebp + off], edx */
+	EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp2[1]), STACK_VAR(tcc[1]));
+
+	/* prog = array->ptrs[index]; */
+	/* mov edx, [esi + edi * 4 + offsetof(...)] */
+	EMIT3_off32(0x8B, 0x94, 0xBE, offsetof(struct bpf_array, ptrs));
+
+	/* if (prog == NULL)
+	 *   goto out;
+	 */
+	EMIT2(0x85, add_2reg(0xC0, tmp2[1], tmp2[1])); /* test edx,edx */
+	EMIT2(IA32_JE, jmp_label(jmp_label1, 2)); /* je out */
+
+	/* goto *(prog->bpf_func + prologue_size); */
+	/* mov edx, dword ptr [edx + 32] */
+	EMIT3(0x8B, add_2reg(0x40, tmp2[1], tmp2[1]),
+	      offsetof(struct bpf_prog, bpf_func));
+	/* add edx, prologue_size */
+	EMIT3(0x83, add_1reg(0xC0, tmp2[1]), PROLOGUE_SIZE);
+
+	/* mov eax,dword ptr [ebp+off] */
+	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp2[0]), STACK_VAR(r1[0]));
+
+	/* now we're ready to jump into next BPF program
+	 * eax == ctx (1st arg)
+	 * edx == prog->bpf_func + prologue_size
+	 */
+	RETPOLINE_EDX_BPF_JIT();
+
+	if (jmp_label1 == -1)
+		jmp_label1 = cnt;
+
+	/* out: */
+	*pprog = prog;
+}
+
+static void emit_load_skb_data_hlen(u8 **pprog)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+	const u8 *reg6 = bpf2ia32[BPF_REG_6];
+	const u8 *tmp = bpf2ia32[TMP_REG_1];
+	const u8 *tmp2 = bpf2ia32[TMP_REG_2];
+
+	/*
+	 * eax : skb pointer
+	 * esi : copy of skb->data
+	 * edi : hlen = skb->len - skb->data_len
+	 */
+
+	/* mov eax,dword ptr [ebp+off] */
+	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp2[0]), STACK_VAR(reg6[0]));
+
+	/* mov %edi, dword ptr [eax+off] */
+	EMIT2_off32(0x8B, add_2reg(0x80, tmp2[0], tmp[1]),
+		    offsetof(struct sk_buff, len));
+
+	/* sub %edi, dword ptr [eax+off] */
+	EMIT2_off32(0x2B, add_2reg(0x80, tmp2[0], tmp[1]),
+		    offsetof(struct sk_buff, data_len));
+
+	/* mov %esi, dword ptr [eax+off] */
+	EMIT2_off32(0x8B, add_2reg(0x80, tmp2[0], tmp[0]),
+		    offsetof(struct sk_buff, data));
+
+	*pprog = prog;
+}
+
+// push the scratch stack register on top of the stack
+static inline void emit_push_r64(const u8 src[], u8 **pprog)
+{
+	const u8 *tmp = bpf2ia32[TMP_REG_1];
+	u8 *prog = *pprog;
+	int cnt = 0;
+
+	/* mov esi,dword ptr [ebp+off] */
+	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(src_hi));
+	/* push esi */
+	EMIT1(0x56);
+
+	/* mov esi,dword ptr [ebp+off] */
+	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]), STACK_VAR(src_lo));
+	/* push esi */
+	EMIT1(0x56);
+
+	*pprog = prog;
+}
+
+static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
+		  int oldproglen, struct jit_context *ctx)
+{
+	struct bpf_insn *insn = bpf_prog->insnsi;
+	int insn_cnt = bpf_prog->len;
+	bool seen_exit = false;
+	u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
+	int i, cnt = 0;
+	int proglen = 0;
+	u8 *prog = temp;
+
+	emit_prologue(&prog, bpf_prog->aux->stack_depth);
+
+	for (i = 0; i < insn_cnt; i++, insn++) {
+		const s32 imm32 = insn->imm;
+		const bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
+		const u8 code = insn->code;
+		const u8 *dst = bpf2ia32[insn->dst_reg];
+		const u8 *src = bpf2ia32[insn->src_reg];
+		const u8 *tmp = bpf2ia32[TMP_REG_1];
+		const u8 *tmp2 = bpf2ia32[TMP_REG_2];
+		const u8 *r0 = bpf2ia32[BPF_REG_0];
+		s64 jmp_offset;
+		u8 jmp_cond;
+		int ilen;
+		u8 *func;
+
+		switch (code) {
+		/* ALU operations */
+		/* dst = src */
+		case BPF_ALU | BPF_MOV | BPF_K:
+		case BPF_ALU | BPF_MOV | BPF_X:
+		case BPF_ALU64 | BPF_MOV | BPF_K:
+		case BPF_ALU64 | BPF_MOV | BPF_X:
+			switch (BPF_SRC(code)) {
+			case BPF_X:
+				emit_ia32_mov_r64(is64, dst, src, &prog);
+				break;
+			case BPF_K:
+				/* Sign-extend immediate value to dst reg */
+				emit_ia32_mov_i64(is64, dst, imm32, &prog);
+				break;
+			}
+			break;
+				/* dst = dst + src/imm */
+		/* dst = dst - src/imm */
+		/* dst = dst | src/imm */
+		/* dst = dst & src/imm */
+		/* dst = dst ^ src/imm */
+		/* dst = dst * src/imm */
+		/* dst = dst << src */
+		/* dst = dst >> src */
+		case BPF_ALU | BPF_ADD | BPF_K:
+		case BPF_ALU | BPF_ADD | BPF_X:
+		case BPF_ALU | BPF_SUB | BPF_K:
+		case BPF_ALU | BPF_SUB | BPF_X:
+		case BPF_ALU | BPF_OR | BPF_K:
+		case BPF_ALU | BPF_OR | BPF_X:
+		case BPF_ALU | BPF_AND | BPF_K:
+		case BPF_ALU | BPF_AND | BPF_X:
+		case BPF_ALU | BPF_XOR | BPF_K:
+		case BPF_ALU | BPF_XOR | BPF_X:
+		case BPF_ALU | BPF_MUL | BPF_K:
+		case BPF_ALU | BPF_MUL | BPF_X:
+		case BPF_ALU | BPF_LSH | BPF_X:
+		case BPF_ALU | BPF_RSH | BPF_X:
+		case BPF_ALU | BPF_ARSH | BPF_K:
+		case BPF_ALU | BPF_ARSH | BPF_X:
+		case BPF_ALU64 | BPF_ADD | BPF_K:
+		case BPF_ALU64 | BPF_ADD | BPF_X:
+		case BPF_ALU64 | BPF_SUB | BPF_K:
+		case BPF_ALU64 | BPF_SUB | BPF_X:
+		case BPF_ALU64 | BPF_OR | BPF_K:
+		case BPF_ALU64 | BPF_OR | BPF_X:
+		case BPF_ALU64 | BPF_AND | BPF_K:
+		case BPF_ALU64 | BPF_AND | BPF_X:
+		case BPF_ALU64 | BPF_XOR | BPF_K:
+		case BPF_ALU64 | BPF_XOR | BPF_X:
+		switch (BPF_SRC(code)) {
+		case BPF_X:
+			emit_ia32_alu_r64(is64, BPF_OP(code), dst, src,
+					  &prog);
+			break;
+		case BPF_K:
+			emit_ia32_alu_i64(is64, BPF_OP(code), dst, imm32,
+					  &prog);
+			break;
+		}
+		break;
+		/* dst = dst / src(imm) */
+		/* dst = dst % src(imm) */
+		case BPF_ALU | BPF_DIV | BPF_K:
+		case BPF_ALU | BPF_DIV | BPF_X:
+		case BPF_ALU | BPF_MOD | BPF_K:
+		case BPF_ALU | BPF_MOD | BPF_X:
+			if (BPF_SRC(code) == BPF_X)
+				/* mov esi,dword ptr [ebp+off] */
+				EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]),
+				      STACK_VAR(src_lo));
+			else
+				/* mov esi,imm32*/
+				EMIT2_off32(0xC7, add_1reg(0xC0, tmp[0]),
+					    imm32);
+
+			/* mov eax,dword ptr [ebp+off] */
+			EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp2[0]),
+			      STACK_VAR(dst_lo));
+			/* xor edx, edx
+			 * equivalent to 'xor rdx, rdx', but one byte less
+			 */
+			EMIT2(0x31, add_2reg(0xC0, tmp2[1], tmp2[1]));
+
+			/* div esi */
+			EMIT2(0xF7, 0xF6);
+
+			if (BPF_OP(code) == BPF_MOD)
+				EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp2[1]),
+				      STACK_VAR(dst_lo));
+			else
+				EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp2[0]),
+				      STACK_VAR(dst_lo));
+
+			EMIT3(0xC7, add_1reg(0x40, IA32_EBP),
+			      STACK_VAR(dst_hi));
+			EMIT(0x0, 4);
+			break;
+		case BPF_ALU64 | BPF_DIV | BPF_K:
+		case BPF_ALU64 | BPF_DIV | BPF_X:
+		case BPF_ALU64 | BPF_MOD | BPF_K:
+		case BPF_ALU64 | BPF_MOD | BPF_X:
+			goto notyet;
+		/* dst = dst >> imm */
+		/* dst = dst << imm */
+		case BPF_ALU | BPF_RSH | BPF_K:
+		case BPF_ALU | BPF_LSH | BPF_K:
+			if (unlikely(imm32 > 31))
+				return -EINVAL;
+			if (imm32)
+				emit_ia32_alu_i(false, false, BPF_OP(code),
+						dst_lo, imm32, &prog);
+			emit_ia32_mov_i(dst_hi, 0, &prog);
+			break;
+		/* dst = dst << imm */
+		case BPF_ALU64 | BPF_LSH | BPF_K:
+			if (unlikely(imm32 > 63))
+				return -EINVAL;
+			emit_ia32_lsh_i64(dst, imm32, &prog);
+			break;
+		/* dst = dst >> imm */
+		case BPF_ALU64 | BPF_RSH | BPF_K:
+			if (unlikely(imm32 > 63))
+				return -EINVAL;
+			emit_ia32_rsh_i64(dst, imm32, &prog);
+			break;
+		/* dst = dst << src */
+		case BPF_ALU64 | BPF_LSH | BPF_X:
+			emit_ia32_lsh_r64(dst, src, &prog);
+			break;
+		/* dst = dst >> src */
+		case BPF_ALU64 | BPF_RSH | BPF_X:
+			emit_ia32_rsh_r64(dst, src, &prog);
+			break;
+		/* dst = dst >> src (signed) */
+		case BPF_ALU64 | BPF_ARSH | BPF_X:
+			emit_ia32_arsh_r64(dst, src, &prog);
+			break;
+		/* dst = dst >> imm (signed) */
+		case BPF_ALU64 | BPF_ARSH | BPF_K:
+			if (unlikely(imm32 > 63))
+				return -EINVAL;
+			emit_ia32_arsh_i64(dst, imm32, &prog);
+			break;
+		/* dst = ~dst */
+		case BPF_ALU | BPF_NEG:
+			emit_ia32_alu_i(is64, false, BPF_OP(code),
+					dst_lo, 0, &prog);
+			emit_ia32_mov_i(dst_hi, 0, &prog);
+			break;
+		/* dst = ~dst (64 bit) */
+		case BPF_ALU64 | BPF_NEG:
+			emit_ia32_neg64(dst, &prog);
+			break;
+		/* dst = dst * src/imm */
+		case BPF_ALU64 | BPF_MUL | BPF_X:
+		case BPF_ALU64 | BPF_MUL | BPF_K:
+			switch (BPF_SRC(code)) {
+			case BPF_X:
+				emit_ia32_mul_r64(dst, src, &prog);
+				break;
+			case BPF_K:
+				emit_ia32_mul_i64(dst, imm32, &prog);
+				break;
+			}
+			break;
+		/* dst = htole(dst) */
+		case BPF_ALU | BPF_END | BPF_FROM_LE:
+			switch (imm32) {
+			case 16:
+				/* emit 'movzwl eax, ax' to zero extend 16-bit
+				 * into 64 bit
+				 */
+				/* mov esi,dword ptr [ebp+off] */
+				EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]),
+				      STACK_VAR(dst_lo));
+				EMIT2(0x0F, 0xB7);
+				EMIT1(add_2reg(0xC0, tmp[0], tmp[0]));
+
+				EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp[0]),
+				      STACK_VAR(dst_lo));
+				EMIT3(0xC7, add_1reg(0x40, IA32_EBP),
+				      STACK_VAR(dst_hi));
+				EMIT(0x0, 4);
+				break;
+			case 32:
+				EMIT3(0xC7, add_1reg(0x40, IA32_EBP),
+				      STACK_VAR(dst_hi));
+				EMIT(0x0, 4);
+				break;
+			case 64:
+				/* nop */
+				break;
+			}
+			break;
+		/* dst = htobe(dst) */
+		case BPF_ALU | BPF_END | BPF_FROM_BE:
+			switch (imm32) {
+			case 16:
+				/* mov esi,dword ptr [ebp+off] */
+				EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]),
+				      STACK_VAR(dst_lo));
+
+				/* emit 'ror %si, 8' to swap lower 2 bytes */
+				EMIT1(0x66);
+				EMIT3(0xC1, add_1reg(0xC8, tmp[0]), 8);
+
+				EMIT2(0x0F, 0xB7);
+				EMIT1(add_2reg(0xC0, tmp[0], tmp[0]));
+				EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp[0]),
+				      STACK_VAR(dst_lo));
+
+				EMIT3(0xC7, add_1reg(0x40, IA32_EBP),
+				      STACK_VAR(dst_hi));
+				EMIT(0x0, 4);
+				break;
+			case 32:
+				/* mov esi,dword ptr [ebp+off] */
+				EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]),
+				      STACK_VAR(dst_lo));
+
+				/* emit 'bswap esi' to swap lower 4 bytes */
+				EMIT1(0x0F);
+				EMIT1(add_1reg(0xC8, tmp[0]));
+
+				EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp[0]),
+				      STACK_VAR(dst_lo));
+
+				EMIT3(0xC7, add_1reg(0x40, IA32_EBP),
+				      STACK_VAR(dst_hi));
+				EMIT(0x0, 4);
+				break;
+			case 64:
+				/* mov esi,dword ptr [ebp+off] */
+				EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]),
+				      STACK_VAR(dst_lo));
+				/* emit 'bswap esi' to swap lower 4 bytes */
+				EMIT1(0x0F);
+				EMIT1(add_1reg(0xC8, tmp[0]));
+
+				/* mov esi,dword ptr [ebp+off] */
+				EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[1]),
+				      STACK_VAR(dst_hi));
+				/* emit 'bswap esi' to swap lower 4 bytes */
+				EMIT1(0x0F);
+				EMIT1(add_1reg(0xC8, tmp[1]));
+
+				EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp[1]),
+				      STACK_VAR(dst_lo));
+				EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp[0]),
+				      STACK_VAR(dst_hi));
+				break;
+			}
+			break;
+		/* dst = imm64 */
+		case BPF_LD | BPF_IMM | BPF_DW:
+			EMIT3(0xC7, add_1reg(0x40, IA32_EBP),
+			      STACK_VAR(dst_lo));
+			EMIT(insn[0].imm, 4);
+
+			EMIT3(0xC7, add_1reg(0x40, IA32_EBP),
+			      STACK_VAR(dst_hi));
+			EMIT(insn[1].imm, 4);
+
+			insn++;
+			i++;
+			break;
+		/* ST: *(u8*)(dst_reg + off) = imm */
+		case BPF_ST | BPF_MEM | BPF_B:
+			/* mov esi,dword ptr [ebp+off] */
+			EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]),
+			      STACK_VAR(dst_lo));
+			EMIT1(0xC6);
+			goto st;
+		case BPF_ST | BPF_MEM | BPF_H:
+			/* mov esi,dword ptr [ebp+off] */
+			EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]),
+			      STACK_VAR(dst_lo));
+			EMIT2(0x66, 0xC7);
+			goto st;
+		case BPF_ST | BPF_MEM | BPF_W:
+		case BPF_ST | BPF_MEM | BPF_DW:
+			/* mov esi,dword ptr [ebp+off] */
+			EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]),
+			      STACK_VAR(dst_lo));
+			EMIT1(0xC7);
+
+st:
+			if (is_imm8(insn->off))
+				EMIT2(add_1reg(0x40, tmp[0]), insn->off);
+			else
+				EMIT1_off32(add_1reg(0x80, tmp[0]), insn->off);
+			EMIT(imm32, bpf_size_to_x86_bytes(BPF_SIZE(code)));
+
+			if (BPF_SIZE(code) == BPF_DW) {
+				u32 hi;
+
+				hi = imm32 & (1<<31) ? (u32)~0 : 0;
+				EMIT2_off32(0xC7, add_1reg(0x80, tmp[0]),
+					    insn->off + 4);
+				EMIT(hi, 4);
+			}
+			break;
+
+		/* STX: *(u8*)(dst_reg + off) = src_reg */
+		case BPF_STX | BPF_MEM | BPF_B:
+			/* mov esi,dword ptr [ebp+off] */
+			EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp2[0]),
+			      STACK_VAR(dst_lo));
+			/* mov edi,dword ptr [ebp+off] */
+			EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp2[1]),
+			      STACK_VAR(src_lo));
+			/* emit 'mov byte ptr [dst + off], al' */
+			EMIT1(0x88);
+			goto stx;
+		case BPF_STX | BPF_MEM | BPF_H:
+			/* mov esi,dword ptr [ebp+off] */
+			EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp2[0]),
+			      STACK_VAR(dst_lo));
+			/* mov edi,dword ptr [ebp+off] */
+			EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp2[1]),
+			      STACK_VAR(src_lo));
+			EMIT2(0x66, 0x89);
+			goto stx;
+		case BPF_STX | BPF_MEM | BPF_W:
+		case BPF_STX | BPF_MEM | BPF_DW:
+			/* mov esi,dword ptr [ebp+off] */
+			EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp2[0]),
+			      STACK_VAR(dst_lo));
+			/* mov edi,dword ptr [ebp+off] */
+			EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp2[1]),
+			      STACK_VAR(src_lo));
+			EMIT1(0x89);
+
+stx:
+			if (is_imm8(insn->off))
+				EMIT2(add_2reg(0x40, tmp2[0], tmp2[1]),
+				      insn->off);
+			else
+				EMIT1_off32(add_2reg(0x80, tmp2[0], tmp2[1]),
+					    insn->off);
+
+			if (BPF_SIZE(code) == BPF_DW) {
+				/* mov edi,dword ptr [ebp+off] */
+				EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp2[1]),
+				      STACK_VAR(src_hi));
+				EMIT1(0x89);
+
+				if (is_imm8(insn->off + 4)) {
+					EMIT2(add_2reg(0x40, tmp2[0], tmp2[1]),
+					      insn->off + 4);
+				} else {
+					EMIT1(add_2reg(0x80, tmp2[0],tmp2[1]));
+					EMIT(insn->off + 4, 4);
+				}
+			}
+			break;
+
+		/* LDX: dst_reg = *(u8*)(src_reg + off) */
+		case BPF_LDX | BPF_MEM | BPF_B:
+			/* mov esi,dword ptr [ebp+off] */
+			EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]),
+			      STACK_VAR(src_lo));
+			/* emit 'movzx esi, byte ptr [ebp+off]' */
+			EMIT2(0x0F, 0xB6);
+			goto ldx;
+		case BPF_LDX | BPF_MEM | BPF_H:
+			/* mov esi,dword ptr [ebp+off] */
+			EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]),
+			      STACK_VAR(src_lo));
+			/* emit 'movzx esi, word ptr [ebp+off]' */
+			EMIT2(0x0F, 0xB7);
+			goto ldx;
+		case BPF_LDX | BPF_MEM | BPF_W:
+		case BPF_LDX | BPF_MEM | BPF_DW:
+			/* mov esi,dword ptr [ebp+off] */
+			EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]),
+			      STACK_VAR(src_lo));
+			/* emit 'mov rax, qword ptr [ebp+off]' */
+			EMIT1(0x8B);
+ldx:
+
+			if (is_imm8(insn->off))
+				EMIT2(add_2reg(0x40, tmp[0], tmp[1]),
+				      insn->off);
+			else
+				EMIT1_off32(add_2reg(0x80, tmp[0], tmp[1]),
+					    insn->off);
+
+			/* mov dword ptr [ebp+off],edi */
+			EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp[1]),
+			      STACK_VAR(dst_lo));
+			switch (BPF_SIZE(code)) {
+			case BPF_B:
+			case BPF_H:
+			case BPF_W:
+				EMIT3(0xC7, add_1reg(0x40, IA32_EBP),
+				      STACK_VAR(dst_hi));
+				EMIT(0x0, 4);
+				break;
+			case BPF_DW:
+				EMIT2_off32(0x8B,
+					    add_2reg(0x80, tmp[0], tmp[1]),
+					    insn->off + 4);
+				EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp[1]),
+				      STACK_VAR(dst_hi));
+				break;
+			default:
+				break;
+			}
+			break;
+		/* call */
+		case BPF_JMP | BPF_CALL:
+		{
+			const u8 *r1 = bpf2ia32[BPF_REG_1];
+			const u8 *r2 = bpf2ia32[BPF_REG_2];
+			const u8 *r3 = bpf2ia32[BPF_REG_3];
+			const u8 *r4 = bpf2ia32[BPF_REG_4];
+			const u8 *r5 = bpf2ia32[BPF_REG_5];
+
+			if (insn->src_reg == BPF_PSEUDO_CALL)
+				goto notyet;
+
+			func = (u8 *) __bpf_call_base + imm32;
+			jmp_offset = func - (image + addrs[i]);
+
+			if (!imm32 || !is_simm32(jmp_offset)) {
+				pr_err("unsupported bpf func %d addr %p image %p\n",
+				       imm32, func, image);
+				return -EINVAL;
+			}
+
+			/* mov eax,dword ptr [ebp+off] */
+			EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp2[0]),
+			      STACK_VAR(r1[0]));
+			/* mov edx,dword ptr [ebp+off] */
+			EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp2[1]),
+			      STACK_VAR(r1[1]));
+
+			emit_push_r64(r5, &prog);
+			emit_push_r64(r4, &prog);
+			emit_push_r64(r3, &prog);
+			emit_push_r64(r2, &prog);
+
+			EMIT1_off32(0xE8, jmp_offset + 9);
+
+			/* mov dword ptr [ebp+off],eax */
+			EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp2[0]),
+			      STACK_VAR(r0[0]));
+			/* mov dword ptr [ebp+off],edx */
+			EMIT3(0x89, add_2reg(0x40, IA32_EBP, tmp2[1]),
+			      STACK_VAR(r0[1]));
+
+			/* add esp,32 */
+			EMIT3(0x83, add_1reg(0xC0, IA32_ESP), 32);
+			break;
+		}
+		case BPF_JMP | BPF_TAIL_CALL:
+			emit_bpf_tail_call(&prog);
+			break;
+
+		/* cond jump */
+		case BPF_JMP | BPF_JEQ | BPF_X:
+		case BPF_JMP | BPF_JNE | BPF_X:
+		case BPF_JMP | BPF_JGT | BPF_X:
+		case BPF_JMP | BPF_JLT | BPF_X:
+		case BPF_JMP | BPF_JGE | BPF_X:
+		case BPF_JMP | BPF_JLE | BPF_X:
+		case BPF_JMP | BPF_JSGT | BPF_X:
+		case BPF_JMP | BPF_JSLE | BPF_X:
+		case BPF_JMP | BPF_JSLT | BPF_X:
+		case BPF_JMP | BPF_JSGE | BPF_X:
+			/* mov esi,dword ptr [ebp+off] */
+			EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]),
+			      STACK_VAR(src_hi));
+			/* cmp dword ptr [ebp+off], esi */
+			EMIT3(0x39, add_2reg(0x40, IA32_EBP, tmp[0]),
+			      STACK_VAR(dst_hi));
+
+			EMIT2(IA32_JNE, 6);
+			/* mov esi,dword ptr [ebp+off] */
+			EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]),
+			      STACK_VAR(src_lo));
+			/* cmp dword ptr [ebp+off], esi */
+			EMIT3(0x39, add_2reg(0x40, IA32_EBP, tmp[0]),
+			      STACK_VAR(dst_lo));
+			goto emit_cond_jmp;
+
+		case BPF_JMP | BPF_JSET | BPF_X:
+			/* mov esi,dword ptr [ebp+off] */
+			EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[0]),
+			      STACK_VAR(dst_lo));
+			/* and esi,dword ptr [ebp+off]*/
+			EMIT3(0x23, add_2reg(0x40, IA32_EBP, tmp[0]),
+			      STACK_VAR(src_lo));
+
+			/* mov edi,dword ptr [ebp+off] */
+			EMIT3(0x8B, add_2reg(0x40, IA32_EBP, tmp[1]),
+			      STACK_VAR(dst_hi));
+			/* and edi,dword ptr [ebp+off] */
+			EMIT3(0x23, add_2reg(0x40, IA32_EBP, tmp[1]),
+			      STACK_VAR(src_hi));
+			/* or esi,edi */
+			EMIT2(0x09, add_2reg(0xC0, tmp[0], tmp[1]));
+			goto emit_cond_jmp;
+
+		case BPF_JMP | BPF_JSET | BPF_K: {
+			u32 hi;
+
+			hi = imm32 & (1<<31) ? (u32)~0 : 0;
+			/* mov esi,imm32 */
+			EMIT2_off32(0xC7, add_1reg(0xC0, tmp[0]), imm32);
+			/* and esi,dword ptr [ebp+off]*/
+			EMIT3(0x23, add_2reg(0x40, IA32_EBP, tmp[0]),
+			      STACK_VAR(dst_lo));
+
+			/* mov esi,imm32 */
+			EMIT2_off32(0xC7, add_1reg(0xC0, tmp[1]), hi);
+			/* and esi,dword ptr [ebp+off] */
+			EMIT3(0x23, add_2reg(0x40, IA32_EBP, tmp[1]),
+			      STACK_VAR(dst_hi));
+			/* or esi,edi */
+			EMIT2(0x09, add_2reg(0xC0, tmp[0], tmp[1]));
+			goto emit_cond_jmp;
+		}
+		case BPF_JMP | BPF_JEQ | BPF_K:
+		case BPF_JMP | BPF_JNE | BPF_K:
+		case BPF_JMP | BPF_JGT | BPF_K:
+		case BPF_JMP | BPF_JLT | BPF_K:
+		case BPF_JMP | BPF_JGE | BPF_K:
+		case BPF_JMP | BPF_JLE | BPF_K:
+		case BPF_JMP | BPF_JSGT | BPF_K:
+		case BPF_JMP | BPF_JSLE | BPF_K:
+		case BPF_JMP | BPF_JSLT | BPF_K:
+		case BPF_JMP | BPF_JSGE | BPF_K: {
+			u32 hi;
+
+			hi = imm32 & (1<<31) ? (u32)~0 : 0;
+			/* mov esi,imm32 */
+			EMIT2_off32(0xC7, add_1reg(0xC0, tmp[0]), hi);
+			/* cmp dword ptr [ebp+off],esi */
+			EMIT3(0x39, add_2reg(0x40, IA32_EBP, tmp[0]),
+			      STACK_VAR(dst_hi));
+
+			EMIT2(IA32_JNE, 6);
+			/* mov esi,imm32 */
+			EMIT2_off32(0xC7, add_1reg(0xC0, tmp[0]), imm32);
+			/* cmp dword ptr [ebp+off],esi */
+			EMIT3(0x39, add_2reg(0x40, IA32_EBP, tmp[0]),
+			      STACK_VAR(dst_lo));
+
+emit_cond_jmp:		/* convert BPF opcode to x86 */
+			switch (BPF_OP(code)) {
+			case BPF_JEQ:
+				jmp_cond = IA32_JE;
+				break;
+			case BPF_JSET:
+			case BPF_JNE:
+				jmp_cond = IA32_JNE;
+				break;
+			case BPF_JGT:
+				/* GT is unsigned '>', JA in x86 */
+				jmp_cond = IA32_JA;
+				break;
+			case BPF_JLT:
+				/* LT is unsigned '<', JB in x86 */
+				jmp_cond = IA32_JB;
+				break;
+			case BPF_JGE:
+				/* GE is unsigned '>=', JAE in x86 */
+				jmp_cond = IA32_JAE;
+				break;
+			case BPF_JLE:
+				/* LE is unsigned '<=', JBE in x86 */
+				jmp_cond = IA32_JBE;
+				break;
+			case BPF_JSGT:
+				/* signed '>', GT in x86 */
+				jmp_cond = IA32_JG;
+				break;
+			case BPF_JSLT:
+				/* signed '<', LT in x86 */
+				jmp_cond = IA32_JL;
+				break;
+			case BPF_JSGE:
+				/* signed '>=', GE in x86 */
+				jmp_cond = IA32_JGE;
+				break;
+			case BPF_JSLE:
+				/* signed '<=', LE in x86 */
+				jmp_cond = IA32_JLE;
+				break;
+			default: /* to silence gcc warning */
+				return -EFAULT;
+			}
+			jmp_offset = addrs[i + insn->off] - addrs[i];
+			if (is_imm8(jmp_offset)) {
+				EMIT2(jmp_cond, jmp_offset);
+			} else if (is_simm32(jmp_offset)) {
+				EMIT2_off32(0x0F, jmp_cond + 0x10, jmp_offset);
+			} else {
+				pr_err("cond_jmp gen bug %llx\n", jmp_offset);
+				return -EFAULT;
+			}
+
+			break;
+		}
+		case BPF_JMP | BPF_JA:
+			jmp_offset = addrs[i + insn->off] - addrs[i];
+			if (!jmp_offset)
+				/* optimize out nop jumps */
+				break;
+emit_jmp:
+			if (is_imm8(jmp_offset)) {
+				EMIT2(0xEB, jmp_offset);
+			} else if (is_simm32(jmp_offset)) {
+				EMIT1_off32(0xE9, jmp_offset);
+			} else {
+				pr_err("jmp gen bug %llx\n", jmp_offset);
+				return -EFAULT;
+			}
+			break;
+
+		case BPF_LD | BPF_IND | BPF_W:
+			func = sk_load_word;
+			goto common_load;
+		case BPF_LD | BPF_ABS | BPF_W:
+			func = CHOOSE_LOAD_FUNC(imm32, sk_load_word);
+common_load:
+			jmp_offset = func - (image + addrs[i]);
+			if (!func || !is_simm32(jmp_offset)) {
+				pr_err("unsupported bpf func %d addr %p image %p\n",
+				       imm32, func, image);
+				return -EINVAL;
+			}
+			if (BPF_MODE(code) == BPF_ABS) {
+				/* mov %edx, imm32 */
+				EMIT1_off32(0xBA, imm32);
+			} else {
+				/* mov edx,dword ptr [ebp+off] */
+				EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EDX),
+				      STACK_VAR(src_lo));
+				if (imm32) {
+					if (is_imm8(imm32))
+						/* add %edx, imm8 */
+						EMIT3(0x83, 0xC2, imm32);
+					else
+						/* add %edx, imm32 */
+						EMIT2_off32(0x81, 0xC2, imm32);
+				}
+			}
+			emit_load_skb_data_hlen(&prog);
+			EMIT1_off32(0xE8, jmp_offset + 10); /* call */
+
+			/* mov dword ptr [ebp+off],eax */
+			EMIT3(0x89, add_2reg(0x40, IA32_EBP, IA32_EAX),
+			      STACK_VAR(r0[0]));
+			EMIT3(0xC7, add_1reg(0x40, IA32_EBP), STACK_VAR(r0[1]));
+			EMIT(0x0, 4);
+			break;
+
+		case BPF_LD | BPF_IND | BPF_H:
+			func = sk_load_half;
+			goto common_load;
+		case BPF_LD | BPF_ABS | BPF_H:
+			func = CHOOSE_LOAD_FUNC(imm32, sk_load_half);
+			goto common_load;
+		case BPF_LD | BPF_IND | BPF_B:
+			func = sk_load_byte;
+			goto common_load;
+		case BPF_LD | BPF_ABS | BPF_B:
+			func = CHOOSE_LOAD_FUNC(imm32, sk_load_byte);
+			goto common_load;
+		/* STX XADD: lock *(u32 *)(dst + off) += src */
+		case BPF_STX | BPF_XADD | BPF_W:
+		/* STX XADD: lock *(u64 *)(dst + off) += src */
+		case BPF_STX | BPF_XADD | BPF_DW:
+			goto notyet;
+		case BPF_JMP | BPF_EXIT:
+			if (seen_exit) {
+				jmp_offset = ctx->cleanup_addr - addrs[i];
+				goto emit_jmp;
+			}
+			seen_exit = true;
+			/* update cleanup_addr */
+			ctx->cleanup_addr = proglen;
+			emit_epilogue(&prog, bpf_prog->aux->stack_depth);
+			break;
+notyet:
+			pr_info_once("*** NOT YET: opcode %02x ***\n", code);
+			return -EFAULT;
+		default:
+			/* This error will be seen if new instruction was added
+			 * to interpreter, but not to JIT
+			 * or if there is junk in bpf_prog
+			 */
+			pr_err("bpf_jit: unknown opcode %02x\n", code);
+			return -EINVAL;
+		}
+
+		ilen = prog - temp;
+		if (ilen > BPF_MAX_INSN_SIZE) {
+			pr_err("bpf_jit: fatal insn size error\n");
+			return -EFAULT;
+		}
+
+		if (image) {
+			if (unlikely(proglen + ilen > oldproglen)) {
+				pr_err("bpf_jit: fatal error\n");
+				return -EFAULT;
+			}
+			memcpy(image + proglen, temp, ilen);
+		}
+		proglen += ilen;
+		addrs[i] = proglen;
+		prog = temp;
+	}
+	return proglen;
+}
+
+struct ia32_jit_data {
+	struct bpf_binary_header *header;
+	int *addrs;
+	u8 *image;
+	int proglen;
+	struct jit_context ctx;
+};
+
+struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+{
+	struct bpf_binary_header *header = NULL;
+	struct bpf_prog *tmp, *orig_prog = prog;
+	struct ia32_jit_data *jit_data;
+	int proglen, oldproglen = 0;
+	struct jit_context ctx = {};
+	bool tmp_blinded = false;
+	bool extra_pass = false;
+	u8 *image = NULL;
+	int *addrs;
+	int pass;
+	int i;
+
+	if (!prog->jit_requested)
+		return orig_prog;
+
+	tmp = bpf_jit_blind_constants(prog);
+	/* If blinding was requested and we failed during blinding,
+	 * we must fall back to the interpreter.
+	 */
+	if (IS_ERR(tmp))
+		return orig_prog;
+	if (tmp != prog) {
+		tmp_blinded = true;
+		prog = tmp;
+	}
+
+	jit_data = prog->aux->jit_data;
+	if (!jit_data) {
+		jit_data = kzalloc(sizeof(*jit_data), GFP_KERNEL);
+		if (!jit_data) {
+			prog = orig_prog;
+			goto out;
+		}
+		prog->aux->jit_data = jit_data;
+	}
+	addrs = jit_data->addrs;
+	if (addrs) {
+		ctx = jit_data->ctx;
+		oldproglen = jit_data->proglen;
+		image = jit_data->image;
+		header = jit_data->header;
+		extra_pass = true;
+		goto skip_init_addrs;
+	}
+	addrs = kmalloc(prog->len * sizeof(*addrs), GFP_KERNEL);
+	if (!addrs) {
+		prog = orig_prog;
+		goto out_addrs;
+	}
+
+	/* Before first pass, make a rough estimation of addrs[]
+	 * each bpf instruction is translated to less than 64 bytes
+	 */
+	for (proglen = 0, i = 0; i < prog->len; i++) {
+		proglen += 64;
+		addrs[i] = proglen;
+	}
+	ctx.cleanup_addr = proglen;
+skip_init_addrs:
+
+	/* JITed image shrinks with every pass and the loop iterates
+	 * until the image stops shrinking. Very large bpf programs
+	 * may converge on the last pass. In such case do one more
+	 * pass to emit the final image
+	 */
+	for (pass = 0; pass < 20 || image; pass++) {
+		proglen = do_jit(prog, addrs, image, oldproglen, &ctx);
+		if (proglen <= 0) {
+			image = NULL;
+			if (header)
+				bpf_jit_binary_free(header);
+			prog = orig_prog;
+			goto out_addrs;
+		}
+		if (image) {
+			if (proglen != oldproglen) {
+				pr_err("bpf_jit: proglen=%d != oldproglen=%d\n",
+				       proglen, oldproglen);
+				prog = orig_prog;
+				goto out_addrs;
+			}
+			break;
+		}
+		if (proglen == oldproglen) {
+			header = bpf_jit_binary_alloc(proglen, &image,
+						      1, jit_fill_hole);
+			if (!header) {
+				prog = orig_prog;
+				goto out_addrs;
+			}
+		}
+		oldproglen = proglen;
+		cond_resched();
+	}
+
+	if (bpf_jit_enable > 1)
+		bpf_jit_dump(prog->len, proglen, pass + 1, image);
+
+	if (image) {
+		if (!prog->is_func || extra_pass) {
+			bpf_jit_binary_lock_ro(header);
+		} else {
+			jit_data->addrs = addrs;
+			jit_data->ctx = ctx;
+			jit_data->proglen = proglen;
+			jit_data->image = image;
+			jit_data->header = header;
+		}
+		prog->bpf_func = (void *)image;
+		prog->jited = 1;
+		prog->jited_len = proglen;
+	} else {
+		prog = orig_prog;
+	}
+
+	if (!prog->is_func || extra_pass) {
+out_addrs:
+		kfree(addrs);
+		kfree(jit_data);
+		prog->aux->jit_data = NULL;
+	}
+out:
+	if (tmp_blinded)
+		bpf_jit_prog_release_other(prog, prog == orig_prog ?
+					   tmp : orig_prog);
+	return prog;
+}
-- 
1.8.5.6.2.g3d8a54e.dirty
