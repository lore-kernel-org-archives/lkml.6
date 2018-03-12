Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELsoaieOu+OM6vRbKSuC0SFuPdfUkjFB3rYn1wGxVpVm/7SV5ByYExlxGA0zeAO7OUvsk+ZV
ARC-Seal: i=1; a=rsa-sha256; t=1520824101; cv=none;
        d=google.com; s=arc-20160816;
        b=dRvkhYUxVunfF7gvgQdhOlwSxyIEcFeXVfrL1/rj67GV1FAKF0XcRLNKYcwK2VXLat
         h/1q8dY4F0luPydEf+ES1o+dGybjWZFTxO6LCaO+fnRCmJ2vFwW0OlGeog9R/S7nPbsR
         jVaF0Ya0G3qDCKqABQyV9z4LMG641QrMBwiLNABGZFYVDxUrmXSOfVat/CgEzpvK2myH
         VZmBrMtz+lZCvZziL0Pe2XUPkSCuZIiltv1QqRa0p1PitppTmVazI224qYFAuETDP77B
         R8XaCIwcP2alCKg9wQcR7efIreZAO90x/qUSu7UoLH1MZvU9IPF1WaKhbpupdkT2TOKi
         I/PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=vY04nvIgFjgGWfb4dqdwJ3xa0sfDQ5lVEqYBUrwX3ec=;
        b=xzIC88Wj+Otf3OT4gUlFZyfz9xb/KptTeiS34jhxEjZp6AmzcBRQ2PUHmuZYHY/vRi
         jAt4IoJJniArWjHJfVEivECTYUqciAqvm9aADAj23g17hEwuUTGyUqnE0RSUFJ3YlqML
         3hLKNqTmd0224Bno1Vg/d0MlS7D1T5x0qhVo617ZppD44jILUYFnhq0neY33DTzCLFos
         7o1XLb/jRM623aK5AZthtXRrUfj2dr4vYm/kFcuSQZHWKAkFA+9g6ImcAyXOztT+rxLd
         W1ka0FbU9uh2Y0NEzz28SsxCvPAGZZishIKslRuvGo+1Sk81lY2DL+gksQKjZWV0JOAw
         T9lw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Andy Lutomirski" <luto@amacapital.net>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Ingo Molnar" <mingo@kernel.org>,
 gnomes@lxorguk.ukuu.org.uk,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Kees Cook" <keescook@google.com>,
 thomas.lendacky@amd.com,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "Jiri Kosina" <jikos@kernel.org>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Arjan van de Ven" <arjan@linux.intel.com>,
 "Rik van Riel" <riel@redhat.com>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Paul Turner" <pjt@google.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Tim Chen" <tim.c.chen@linux.intel.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.794095492@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 23/76] x86/retpoline: Add initial retpoline support
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699624373063214?=
X-GMAIL-MSGID: =?utf-8?q?1594699653413632189?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit 76b043848fd22dbf7f8bf3a1452f8c70d557b860 upstream.

Enable the use of -mindirect-branch=thunk-extern in newer GCC, and provide
the corresponding thunks. Provide assembler macros for invoking the thunks
in the same way that GCC does, from native and inline assembler.

This adds X86_FEATURE_RETPOLINE and sets it by default on all CPUs. In
some circumstances, IBRS microcode features may be used instead, and the
retpoline can be disabled.

On AMD CPUs if lfence is serialising, the retpoline can be dramatically
simplified to a simple "lfence; jmp *\reg". A future patch, after it has
been verified that lfence really is serialising in all circumstances, can
enable this by setting the X86_FEATURE_RETPOLINE_AMD feature bit in addition
to X86_FEATURE_RETPOLINE.

Do not align the retpoline in the altinstr section, because there is no
guarantee that it stays aligned when it's copied over the oldinstr during
alternative patching.

[ Andi Kleen: Rename the macros, add CONFIG_RETPOLINE option, export thunks]
[ tglx: Put actual function CALL/JMP in front of the macros, convert to
  	symbolic labels ]
[ dwmw2: Convert back to numeric labels, merge objtool fixes ]

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Arjan van de Ven <arjan@linux.intel.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: Rik van Riel <riel@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: thomas.lendacky@amd.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Kees Cook <keescook@google.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Cc: Paul Turner <pjt@google.com>
Link: https://lkml.kernel.org/r/1515707194-20531-4-git-send-email-dwmw@amazon.co.uk
[bwh: Backported to 3.16:
 - Add C source to export the thunk symbols
 - Drop ANNOTATE_NOSPEC_ALTERNATIVE since we don't have objtool
 - Use the first available feaure numbers
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -339,6 +339,19 @@ config GOLDFISH
        def_bool y
        depends on X86_GOLDFISH
 
+config RETPOLINE
+	bool "Avoid speculative indirect branches in kernel"
+	default y
+	help
+	  Compile kernel with the retpoline compiler options to guard against
+	  kernel-to-user data leaks by avoiding speculative indirect
+	  branches. Requires a compiler with -mindirect-branch=thunk-extern
+	  support for full protection. The kernel may run slower.
+
+	  Without compiler support, at least indirect branches in assembler
+	  code are eliminated. Since this includes the syscall entry path,
+	  it is not entirely pointless.
+
 if X86_32
 config X86_EXTENDED_PLATFORM
 	bool "Support for extended (non-PC) x86 platforms"
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -177,6 +177,16 @@ KBUILD_CFLAGS += $(call cc-option,-mno-a
 KBUILD_CFLAGS += $(mflags-y)
 KBUILD_AFLAGS += $(mflags-y)
 
+# Avoid indirect branches in kernel to deal with Spectre
+ifdef CONFIG_RETPOLINE
+    RETPOLINE_CFLAGS += $(call cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register)
+    ifneq ($(RETPOLINE_CFLAGS),)
+        KBUILD_CFLAGS += $(RETPOLINE_CFLAGS) -DRETPOLINE
+    else
+        $(warning CONFIG_RETPOLINE=y, but not supported by the compiler. Toolchain update recommended.)
+    endif
+endif
+
 archscripts: scripts_basic
 	$(Q)$(MAKE) $(build)=arch/x86/tools relocs
 
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -188,6 +188,8 @@
 #define X86_FEATURE_PROC_FEEDBACK (7*32+ 9) /* AMD ProcFeedbackInterface */
 #define X86_FEATURE_INVPCID_SINGLE (7*32+10) /* Effectively INVPCID && CR4.PCIDE=1 */
 
+#define X86_FEATURE_RETPOLINE	(7*32+29) /* Generic Retpoline mitigation for Spectre variant 2 */
+#define X86_FEATURE_RETPOLINE_AMD (7*32+30) /* AMD Retpoline mitigation for Spectre variant 2 */
 /* Because the ALTERNATIVE scheme is for members of the X86_FEATURE club... */
 #define X86_FEATURE_KAISER	(7*32+31) /* "" CONFIG_PAGE_TABLE_ISOLATION w/o nokaiser */
 
--- /dev/null
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __NOSPEC_BRANCH_H__
+#define __NOSPEC_BRANCH_H__
+
+#include <asm/alternative.h>
+#include <asm/alternative-asm.h>
+#include <asm/cpufeature.h>
+
+#ifdef __ASSEMBLY__
+
+/*
+ * These are the bare retpoline primitives for indirect jmp and call.
+ * Do not use these directly; they only exist to make the ALTERNATIVE
+ * invocation below less ugly.
+ */
+.macro RETPOLINE_JMP reg:req
+	call	.Ldo_rop_\@
+.Lspec_trap_\@:
+	pause
+	jmp	.Lspec_trap_\@
+.Ldo_rop_\@:
+	mov	\reg, (%_ASM_SP)
+	ret
+.endm
+
+/*
+ * This is a wrapper around RETPOLINE_JMP so the called function in reg
+ * returns to the instruction after the macro.
+ */
+.macro RETPOLINE_CALL reg:req
+	jmp	.Ldo_call_\@
+.Ldo_retpoline_jmp_\@:
+	RETPOLINE_JMP \reg
+.Ldo_call_\@:
+	call	.Ldo_retpoline_jmp_\@
+.endm
+
+/*
+ * JMP_NOSPEC and CALL_NOSPEC macros can be used instead of a simple
+ * indirect jmp/call which may be susceptible to the Spectre variant 2
+ * attack.
+ */
+.macro JMP_NOSPEC reg:req
+#ifdef CONFIG_RETPOLINE
+	ALTERNATIVE_2 __stringify(jmp *\reg),				\
+		__stringify(RETPOLINE_JMP \reg), X86_FEATURE_RETPOLINE,	\
+		__stringify(lfence; jmp *\reg), X86_FEATURE_RETPOLINE_AMD
+#else
+	jmp	*\reg
+#endif
+.endm
+
+.macro CALL_NOSPEC reg:req
+#ifdef CONFIG_RETPOLINE
+	ALTERNATIVE_2 __stringify(call *\reg),				\
+		__stringify(RETPOLINE_CALL \reg), X86_FEATURE_RETPOLINE,\
+		__stringify(lfence; call *\reg), X86_FEATURE_RETPOLINE_AMD
+#else
+	call	*\reg
+#endif
+.endm
+
+#else /* __ASSEMBLY__ */
+
+#if defined(CONFIG_X86_64) && defined(RETPOLINE)
+
+/*
+ * Since the inline asm uses the %V modifier which is only in newer GCC,
+ * the 64-bit one is dependent on RETPOLINE not CONFIG_RETPOLINE.
+ */
+# define CALL_NOSPEC						\
+	ALTERNATIVE(						\
+	"call *%[thunk_target]\n",				\
+	"call __x86_indirect_thunk_%V[thunk_target]\n",		\
+	X86_FEATURE_RETPOLINE)
+# define THUNK_TARGET(addr) [thunk_target] "r" (addr)
+
+#elif defined(CONFIG_X86_32) && defined(CONFIG_RETPOLINE)
+/*
+ * For i386 we use the original ret-equivalent retpoline, because
+ * otherwise we'll run out of registers. We don't care about CET
+ * here, anyway.
+ */
+# define CALL_NOSPEC ALTERNATIVE("call *%[thunk_target]\n",	\
+	"       jmp    904f;\n"					\
+	"       .align 16\n"					\
+	"901:	call   903f;\n"					\
+	"902:	pause;\n"					\
+	"       jmp    902b;\n"					\
+	"       .align 16\n"					\
+	"903:	addl   $4, %%esp;\n"				\
+	"       pushl  %[thunk_target];\n"			\
+	"       ret;\n"						\
+	"       .align 16\n"					\
+	"904:	call   901b;\n",				\
+	X86_FEATURE_RETPOLINE)
+
+# define THUNK_TARGET(addr) [thunk_target] "rm" (addr)
+#else /* No retpoline */
+# define CALL_NOSPEC "call *%[thunk_target]\n"
+# define THUNK_TARGET(addr) [thunk_target] "rm" (addr)
+#endif
+
+#endif /* __ASSEMBLY__ */
+#endif /* __NOSPEC_BRANCH_H__ */
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -810,6 +810,10 @@ static void __init early_identify_cpu(st
 
 	setup_force_cpu_bug(X86_BUG_SPECTRE_V1);
 	setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
+
+#ifdef CONFIG_RETPOLINE
+	setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
+#endif
 }
 
 void __init early_cpu_init(void)
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -23,6 +23,8 @@ lib-y += memcpy_$(BITS).o
 lib-$(CONFIG_SMP) += rwlock.o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
 lib-$(CONFIG_INSTRUCTION_DECODER) += insn.o inat.o
+lib-$(CONFIG_RETPOLINE) += retpoline.o
+obj-$(CONFIG_RETPOLINE) += retpoline-export.o
 
 obj-y += msr.o msr-reg.o msr-reg-export.o hash.o
 
--- /dev/null
+++ b/arch/x86/lib/retpoline.S
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/stringify.h>
+#include <linux/linkage.h>
+#include <asm/dwarf2.h>
+#include <asm/cpufeature.h>
+#include <asm/alternative-asm.h>
+#include <asm/nospec-branch.h>
+
+.macro THUNK reg
+	.section .text.__x86.indirect_thunk.\reg
+
+ENTRY(__x86_indirect_thunk_\reg)
+	CFI_STARTPROC
+	JMP_NOSPEC %\reg
+	CFI_ENDPROC
+ENDPROC(__x86_indirect_thunk_\reg)
+.endm
+
+/*
+ * Despite being an assembler file we can't just use .irp here
+ * because __KSYM_DEPS__ only uses the C preprocessor and would
+ * only see one instance of "__x86_indirect_thunk_\reg" rather
+ * than one per register with the correct names. So we do it
+ * the simple and nasty way...
+ */
+#define GENERATE_THUNK(reg) THUNK reg
+
+GENERATE_THUNK(_ASM_AX)
+GENERATE_THUNK(_ASM_BX)
+GENERATE_THUNK(_ASM_CX)
+GENERATE_THUNK(_ASM_DX)
+GENERATE_THUNK(_ASM_SI)
+GENERATE_THUNK(_ASM_DI)
+GENERATE_THUNK(_ASM_BP)
+GENERATE_THUNK(_ASM_SP)
+#ifdef CONFIG_64BIT
+GENERATE_THUNK(r8)
+GENERATE_THUNK(r9)
+GENERATE_THUNK(r10)
+GENERATE_THUNK(r11)
+GENERATE_THUNK(r12)
+GENERATE_THUNK(r13)
+GENERATE_THUNK(r14)
+GENERATE_THUNK(r15)
+#endif
--- /dev/null
+++ b/arch/x86/lib/retpoline-export.c
@@ -0,0 +1,25 @@
+#include <linux/linkage.h>
+
+#ifdef CONFIG_RETPOLINE
+#ifdef CONFIG_X86_32
+#define INDIRECT_THUNK(reg) extern asmlinkage void __x86_indirect_thunk_e ## reg(void); EXPORT_SYMBOL(__x86_indirect_thunk_e ## reg);
+#else
+#define INDIRECT_THUNK(reg) extern asmlinkage void __x86_indirect_thunk_r ## reg(void); EXPORT_SYMBOL(__x86_indirect_thunk_r ## reg);
+INDIRECT_THUNK(8)
+INDIRECT_THUNK(9)
+INDIRECT_THUNK(10)
+INDIRECT_THUNK(11)
+INDIRECT_THUNK(12)
+INDIRECT_THUNK(13)
+INDIRECT_THUNK(14)
+INDIRECT_THUNK(15)
+#endif
+INDIRECT_THUNK(ax)
+INDIRECT_THUNK(bx)
+INDIRECT_THUNK(cx)
+INDIRECT_THUNK(dx)
+INDIRECT_THUNK(si)
+INDIRECT_THUNK(di)
+INDIRECT_THUNK(bp)
+INDIRECT_THUNK(sp)
+#endif /* CONFIG_RETPOLINE */
