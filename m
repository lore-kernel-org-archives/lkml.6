Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvnMRnW9uNo2yv6tSMdjzusW18wlUXO3O9guSimS2XKZzWB+CLdrZyY5qdtXNkxbZwc/5nE
ARC-Seal: i=1; a=rsa-sha256; t=1520955681; cv=none;
        d=google.com; s=arc-20160816;
        b=BpQ4BQgtb0KpxkX/LIIbNH5PuYRVArBlEbHeZ60UrXbxTUg1xt7byvT3VXcmJLnm1Z
         2wLTpKZJaYA89V8b9UZBGqks++jXMmfkhl9vZ5MZR+ceKRxujUtY8aPrVFE0ZVgcLuUx
         gMXE8oUcyjIYV2wmmpsXekHvE7gYfHpsvB5dY8dOs8Q9t1vZVoeJMtcEcCUb+3zGuVSY
         VUMY7iWzdQEeH6t8415K0IutOnufgDpmQAIa6RlytL6/fZ6tRIxijCOocMSLBxI52oRN
         YPltJn6iz0RU2T574I735cS7Zy6ac73F81JMxS+i9nZslCYAlpYNOWFE4WwUcNRX+v8Q
         o48w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uLw1pysXvRcN6iYdyztWciYJxhMYr7zC0la4eV6Hmpo=;
        b=GIB4DMAMoMOsMZeDrIZ9yijreedQnxgxKJ/JzYGWa8O7Gw64slW3sICK6R00JDABpj
         38x+fTG0es7ewQTreFMASUP1oqnRoJGTXkLkKL+OpmDlOesmuaOScg7tZUHQJborCLXX
         5JRCDjPTXaF1BoYwEueULi6oiL/5nYNnErh9zr0V215PqMOganq63BgHI0eICEjffGrU
         nMqTiWtTChGWu73dU8v4JRD5GHJi1StO/ZXAEh4Ek7TyVeXmk8lQBRXkxNtOOpgiwgJM
         4HHey+HBy+ZAsydWpdirKvHdXDrxVujM4Im3KF0AFCxRByYr/3HgPidyvgFmvs4Ms6AF
         RXCA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	arjan.van.de.ven@intel.com,
	bp@alien8.de,
	dave.hansen@intel.com,
	jmattson@google.com,
	karahmed@amazon.de,
	kvm@vger.kernel.org,
	pbonzini@redhat.com,
	rkrcmar@redhat.com,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 123/140] Revert "x86/retpoline: Simplify vmexit_fill_RSB()"
Date: Tue, 13 Mar 2018 16:25:26 +0100
Message-Id: <20180313152506.439985421@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837018277263377?=
X-GMAIL-MSGID: =?utf-8?q?1594837624791976829?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit d1c99108af3c5992640aa2afa7d2e88c3775c06e upstream.

This reverts commit 1dde7415e99933bb7293d6b2843752cbdb43ec11. By putting
the RSB filling out of line and calling it, we waste one RSB slot for
returning from the function itself, which means one fewer actual function
call we can make if we're doing the Skylake abomination of call-depth
counting.

It also changed the number of RSB stuffings we do on vmexit from 32,
which was correct, to 16. Let's just stop with the bikeshedding; it
didn't actually *fix* anything anyway.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: arjan.van.de.ven@intel.com
Cc: bp@alien8.de
Cc: dave.hansen@intel.com
Cc: jmattson@google.com
Cc: karahmed@amazon.de
Cc: kvm@vger.kernel.org
Cc: pbonzini@redhat.com
Cc: rkrcmar@redhat.com
Link: http://lkml.kernel.org/r/1519037457-7643-4-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/entry_32.S             |    3 -
 arch/x86/entry/entry_64.S             |    3 -
 arch/x86/include/asm/asm-prototypes.h |    3 -
 arch/x86/include/asm/nospec-branch.h  |   70 ++++++++++++++++++++++++++++++----
 arch/x86/lib/Makefile                 |    1 
 arch/x86/lib/retpoline.S              |   56 ---------------------------
 6 files changed, 65 insertions(+), 71 deletions(-)

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
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -360,8 +360,7 @@ ENTRY(__switch_to_asm)
 	 * exist, overwrite the RSB with entries which capture
 	 * speculative execution to prevent attack.
 	 */
-	/* Clobbers %rbx */
-	FILL_RETURN_BUFFER RSB_CLEAR_LOOPS, X86_FEATURE_RSB_CTXSW
+	FILL_RETURN_BUFFER %r12, RSB_CLEAR_LOOPS, X86_FEATURE_RSB_CTXSW
 #endif
 
 	/* restore callee-saved registers */
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
 
@@ -156,10 +207,15 @@ extern char __indirect_thunk_end[];
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
 
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -27,7 +27,6 @@ lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) +=
 lib-$(CONFIG_INSTRUCTION_DECODER) += insn.o inat.o
 lib-$(CONFIG_RANDOMIZE_BASE) += kaslr.o
 lib-$(CONFIG_RETPOLINE) += retpoline.o
-OBJECT_FILES_NON_STANDARD_retpoline.o :=y
 
 obj-y += msr.o msr-reg.o msr-reg-export.o hweight.o
 
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
