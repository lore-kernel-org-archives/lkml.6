Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030557AbeBNNqF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:46:05 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:40868 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030488AbeBNNoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:44:55 -0500
X-IronPort-AV: E=Sophos;i="5.46,512,1511827200";
   d="scan'208";a="708104510"
From: David Woodhouse <dwmw@amazon.co.uk>
To: tglx@linutronix.de, karahmed@amazon.de, x86@kernel.org,
        kvm@vger.kernel.org, torvalds@linux-foundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        peterz@infradead.org, jmattson@google.com, rkrcmar@redhat.com,
        arjan.van.de.ven@intel.com, dave.hansen@intel.com, mingo@kernel.org
Subject: [PATCH 3/4] Revert "x86/retpoline: Simplify vmexit_fill_RSB()"
Date: Wed, 14 Feb 2018 13:44:33 +0000
Message-Id: <1518615874-13806-4-git-send-email-dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518615874-13806-1-git-send-email-dwmw@amazon.co.uk>
References: <1518615874-13806-1-git-send-email-dwmw@amazon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 1dde7415e99933bb7293d6b2843752cbdb43ec11. By putting
the RSB filling out of line and calling it, we waste one RSB slot for
returning from the function itself, which means one fewer actual function
call we can make if we're doing the Skylake abomination of call-depth
counting.

It also changed the number of RSB stuffings we do on vmexit from 32,
which was correct, to 16. Let's just stop with the bikeshedding; it
didn't actually *fix* anything anyway.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/entry/entry_32.S             |  3 +-
 arch/x86/entry/entry_64.S             |  3 +-
 arch/x86/include/asm/asm-prototypes.h |  3 --
 arch/x86/include/asm/nospec-branch.h  | 70 +++++++++++++++++++++++++++++++----
 arch/x86/lib/Makefile                 |  1 -
 arch/x86/lib/retpoline.S              | 56 ----------------------------
 6 files changed, 65 insertions(+), 71 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 2a35b1e..60c4c34 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -252,8 +252,7 @@ ENTRY(__switch_to_asm)
 	 * exist, overwrite the RSB with entries which capture
 	 * speculative execution to prevent attack.
 	 */
-	/* Clobbers %ebx */
-	FILL_RETURN_BUFFER RSB_CLEAR_LOOPS, X86_FEATURE_RSB_CTXSW
+	FILL_RETURN_BUFFER %ebx, RSB_CLEAR_LOOPS, X86_FEATURE_RSB_CTXSW
 #endif
 
 	/* restore callee-saved registers */
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1c5420420..1d83563 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -364,8 +364,7 @@ ENTRY(__switch_to_asm)
 	 * exist, overwrite the RSB with entries which capture
 	 * speculative execution to prevent attack.
 	 */
-	/* Clobbers %rbx */
-	FILL_RETURN_BUFFER RSB_CLEAR_LOOPS, X86_FEATURE_RSB_CTXSW
+	FILL_RETURN_BUFFER %r12, RSB_CLEAR_LOOPS, X86_FEATURE_RSB_CTXSW
 #endif
 
 	/* restore callee-saved registers */
diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 4d11161..1908214 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -38,7 +38,4 @@ INDIRECT_THUNK(dx)
 INDIRECT_THUNK(si)
 INDIRECT_THUNK(di)
 INDIRECT_THUNK(bp)
-asmlinkage void __fill_rsb(void);
-asmlinkage void __clear_rsb(void);
-
 #endif /* CONFIG_RETPOLINE */
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 34cbce3..94749fb 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -8,6 +8,50 @@
 #include <asm/cpufeatures.h>
 #include <asm/msr-index.h>
 
+/*
+ * Fill the CPU return stack buffer.
+ *
+ * Each entry in the RSB, if used for a speculative 'ret', contains an
+ * infinite 'pause; lfence; jmp' loop to capture speculative execution.
+ *
+ * This is required in various cases for retpoline and IBRS-based
+ * mitigations for the Spectre variant 2 vulnerability. Sometimes to
+ * eliminate potentially bogus entries from the RSB, and sometimes
+ * purely to ensure that it doesn't get empty, which on some CPUs would
+ * allow predictions from other (unwanted!) sources to be used.
+ *
+ * We define a CPP macro such that it can be used from both .S files and
+ * inline assembly. It's possible to do a .macro and then include that
+ * from C via asm(".include <asm/nospec-branch.h>") but let's not go there.
+ */
+
+#define RSB_CLEAR_LOOPS		32	/* To forcibly overwrite all entries */
+#define RSB_FILL_LOOPS		16	/* To avoid underflow */
+
+/*
+ * Google experimented with loop-unrolling and this turned out to be
+ * the optimal version — two calls, each with their own speculation
+ * trap should their return address end up getting used, in a loop.
+ */
+#define __FILL_RETURN_BUFFER(reg, nr, sp)	\
+	mov	$(nr/2), reg;			\
+771:						\
+	call	772f;				\
+773:	/* speculation trap */			\
+	pause;					\
+	lfence;					\
+	jmp	773b;				\
+772:						\
+	call	774f;				\
+775:	/* speculation trap */			\
+	pause;					\
+	lfence;					\
+	jmp	775b;				\
+774:						\
+	dec	reg;				\
+	jnz	771b;				\
+	add	$(BITS_PER_LONG/8) * nr, sp;
+
 #ifdef __ASSEMBLY__
 
 /*
@@ -78,10 +122,17 @@
 #endif
 .endm
 
-/* This clobbers the BX register */
-.macro FILL_RETURN_BUFFER nr:req ftr:req
+ /*
+  * A simpler FILL_RETURN_BUFFER macro. Don't make people use the CPP
+  * monstrosity above, manually.
+  */
+.macro FILL_RETURN_BUFFER reg:req nr:req ftr:req
 #ifdef CONFIG_RETPOLINE
-	ALTERNATIVE "", "call __clear_rsb", \ftr
+	ANNOTATE_NOSPEC_ALTERNATIVE
+	ALTERNATIVE "jmp .Lskip_rsb_\@",				\
+		__stringify(__FILL_RETURN_BUFFER(\reg,\nr,%_ASM_SP))	\
+		\ftr
+.Lskip_rsb_\@:
 #endif
 .endm
 
@@ -163,10 +214,15 @@ extern char __indirect_thunk_end[];
 static inline void vmexit_fill_RSB(void)
 {
 #ifdef CONFIG_RETPOLINE
-	alternative_input("",
-			  "call __fill_rsb",
-			  X86_FEATURE_RETPOLINE,
-			  ASM_NO_INPUT_CLOBBER(_ASM_BX, "memory"));
+	unsigned long loops;
+
+	asm volatile (ANNOTATE_NOSPEC_ALTERNATIVE
+		      ALTERNATIVE("jmp 910f",
+				  __stringify(__FILL_RETURN_BUFFER(%0, RSB_CLEAR_LOOPS, %1)),
+				  X86_FEATURE_RETPOLINE)
+		      "910:"
+		      : "=r" (loops), ASM_CALL_CONSTRAINT
+		      : : "memory" );
 #endif
 }
 
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 69a4739..f23934b 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -27,7 +27,6 @@ lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
 lib-$(CONFIG_INSTRUCTION_DECODER) += insn.o inat.o insn-eval.o
 lib-$(CONFIG_RANDOMIZE_BASE) += kaslr.o
 lib-$(CONFIG_RETPOLINE) += retpoline.o
-OBJECT_FILES_NON_STANDARD_retpoline.o :=y
 
 obj-y += msr.o msr-reg.o msr-reg-export.o hweight.o
 
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 480edc3..c909961 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -7,7 +7,6 @@
 #include <asm/alternative-asm.h>
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
-#include <asm/bitsperlong.h>
 
 .macro THUNK reg
 	.section .text.__x86.indirect_thunk
@@ -47,58 +46,3 @@ GENERATE_THUNK(r13)
 GENERATE_THUNK(r14)
 GENERATE_THUNK(r15)
 #endif
-
-/*
- * Fill the CPU return stack buffer.
- *
- * Each entry in the RSB, if used for a speculative 'ret', contains an
- * infinite 'pause; lfence; jmp' loop to capture speculative execution.
- *
- * This is required in various cases for retpoline and IBRS-based
- * mitigations for the Spectre variant 2 vulnerability. Sometimes to
- * eliminate potentially bogus entries from the RSB, and sometimes
- * purely to ensure that it doesn't get empty, which on some CPUs would
- * allow predictions from other (unwanted!) sources to be used.
- *
- * Google experimented with loop-unrolling and this turned out to be
- * the optimal version - two calls, each with their own speculation
- * trap should their return address end up getting used, in a loop.
- */
-.macro STUFF_RSB nr:req sp:req
-	mov	$(\nr / 2), %_ASM_BX
-	.align 16
-771:
-	call	772f
-773:						/* speculation trap */
-	pause
-	lfence
-	jmp	773b
-	.align 16
-772:
-	call	774f
-775:						/* speculation trap */
-	pause
-	lfence
-	jmp	775b
-	.align 16
-774:
-	dec	%_ASM_BX
-	jnz	771b
-	add	$((BITS_PER_LONG/8) * \nr), \sp
-.endm
-
-#define RSB_FILL_LOOPS		16	/* To avoid underflow */
-
-ENTRY(__fill_rsb)
-	STUFF_RSB RSB_FILL_LOOPS, %_ASM_SP
-	ret
-END(__fill_rsb)
-EXPORT_SYMBOL_GPL(__fill_rsb)
-
-#define RSB_CLEAR_LOOPS		32	/* To forcibly overwrite all entries */
-
-ENTRY(__clear_rsb)
-	STUFF_RSB RSB_CLEAR_LOOPS, %_ASM_SP
-	ret
-END(__clear_rsb)
-EXPORT_SYMBOL_GPL(__clear_rsb)
-- 
2.7.4
