Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELtRwoBMq90RQyL8b/Z1t/hd5viIrNZ60kklgb0mtTE6eFYmeeKGQZnmF0BDGJVqcWqanOlW
ARC-Seal: i=1; a=rsa-sha256; t=1520824083; cv=none;
        d=google.com; s=arc-20160816;
        b=Rz+WzVmtGIcSv2PvWUjv9L8JuZFwRrDfz18CMcAILCTW9fajwwiIIa3La1AfDRRSKL
         J2FSw+4crr2deW9fa3zRbOSskaDXoEpCjeKhhbjzZnp4WkSA6lt8D5nVg9giDwrF/J/+
         LiwsqrQt9YALDYc+ZiIqQOks3FjTaUeFqHGM0WfPvPVerwBs6u9tAxnLPaNTaKLt2Afa
         2fHvfJrldxR7AaiKv398I2gnU5aq2BQ6HG8kq4JP5T2u4jnPuLB5turW5TG7X3IevAuh
         849j3KwekBLx3DW1pSbK9bUESt1udrfhTuIplLVnBTs0KcJ5jnfuXrYhlgmCWmCM14Up
         r9lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=8ZsUuu9idLAzSuU4dZAAofBnHOZtFuvARhkCgcTJGm0=;
        b=yL4ybPbhOxPZMEply5LMqwEdjDk2D6l5/WLyKip6tn0HBqaUmTR73aSpDTKC9t+CD5
         +cETkG/tCLmxaLcQn1pK61YkFKDz9u/sWQPeDJUUjFdvmC+J9LhZ/wYc0PPGLptb81Zz
         M3DGLYNDOnF2kCt2BYW+FSWmykdVeVmm/oojPfa2LiAaiZHUjM69uMpkht3nfmE7Aet0
         uE1XNNnpaLq0eko8lxz+iXp3V13oMmlx+Lkkkkz+pfa2Tar7h8XNz2zeROyJSe9XsS+b
         XLPDnWcUhfoj/uyPxHG0X3Yb9SW1phjcZ7no8iBE/vlFcPbGEIAwvRplUSDp83nnLxdH
         jcNA==
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
 "Andi Kleen" <ak@linux.intel.com>,
 "Paul Turner" <pjt@google.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "Andy Lutomirski" <luto@amacapital.net>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 gnomes@lxorguk.ukuu.org.uk,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Kees Cook" <keescook@google.com>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "Jiri Kosina" <jikos@kernel.org>,
 thomas.lendacky@amd.com,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Rik van Riel" <riel@redhat.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.61645125@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 32/76] x86/retpoline: Fill return stack buffer on vmexit
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699645507765723?=
X-GMAIL-MSGID: =?utf-8?q?1594699634647080172?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit 117cc7a908c83697b0b737d15ae1eb5943afe35b upstream.

In accordance with the Intel and AMD documentation, we need to overwrite
all entries in the RSB on exiting a guest, to prevent malicious branch
target predictions from affecting the host kernel. This is needed both
for retpoline and for IBRS.

[ak: numbers again for the RSB stuffing labels]

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: Rik van Riel <riel@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: thomas.lendacky@amd.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Kees Cook <keescook@google.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Cc: Paul Turner <pjt@google.com>
Link: https://lkml.kernel.org/r/1515755487-8524-1-git-send-email-dwmw@amazon.co.uk
[bwh: Backported to 3.16:
 - Drop the ANNOTATE_NOSPEC_ALTERNATIVEs
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -7,6 +7,48 @@
 #include <asm/alternative-asm.h>
 #include <asm/cpufeature.h>
 
+/*
+ * Fill the CPU return stack buffer.
+ *
+ * Each entry in the RSB, if used for a speculative 'ret', contains an
+ * infinite 'pause; jmp' loop to capture speculative execution.
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
+	jmp	773b;				\
+772:						\
+	call	774f;				\
+775:	/* speculation trap */			\
+	pause;					\
+	jmp	775b;				\
+774:						\
+	dec	reg;				\
+	jnz	771b;				\
+	add	$(BITS_PER_LONG/8) * nr, sp;
+
 #ifdef __ASSEMBLY__
 
 /*
@@ -61,6 +103,19 @@
 #endif
 .endm
 
+ /*
+  * A simpler FILL_RETURN_BUFFER macro. Don't make people use the CPP
+  * monstrosity above, manually.
+  */
+.macro FILL_RETURN_BUFFER reg:req nr:req ftr:req
+#ifdef CONFIG_RETPOLINE
+	ALTERNATIVE "jmp .Lskip_rsb_\@",				\
+		__stringify(__FILL_RETURN_BUFFER(\reg,\nr,%_ASM_SP))	\
+		\ftr
+.Lskip_rsb_\@:
+#endif
+.endm
+
 #else /* __ASSEMBLY__ */
 
 #if defined(CONFIG_X86_64) && defined(RETPOLINE)
@@ -97,7 +152,7 @@
 	X86_FEATURE_RETPOLINE)
 
 # define THUNK_TARGET(addr) [thunk_target] "rm" (addr)
-#else /* No retpoline */
+#else /* No retpoline for C / inline asm */
 # define CALL_NOSPEC "call *%[thunk_target]\n"
 # define THUNK_TARGET(addr) [thunk_target] "rm" (addr)
 #endif
@@ -112,5 +167,24 @@ enum spectre_v2_mitigation {
 	SPECTRE_V2_IBRS,
 };
 
+/*
+ * On VMEXIT we must ensure that no RSB predictions learned in the guest
+ * can be followed in the host, by overwriting the RSB completely. Both
+ * retpoline and IBRS mitigations for Spectre v2 need this; only on future
+ * CPUs with IBRS_ATT *might* it be avoided.
+ */
+static inline void vmexit_fill_RSB(void)
+{
+#ifdef CONFIG_RETPOLINE
+	unsigned long loops = RSB_CLEAR_LOOPS / 2;
+
+	asm volatile (ALTERNATIVE("jmp 910f",
+				  __stringify(__FILL_RETURN_BUFFER(%0, RSB_CLEAR_LOOPS, %1)),
+				  X86_FEATURE_RETPOLINE)
+		      "910:"
+		      : "=&r" (loops), ASM_CALL_CONSTRAINT
+		      : "r" (loops) : "memory" );
+#endif
+}
 #endif /* __ASSEMBLY__ */
 #endif /* __NOSPEC_BRANCH_H__ */
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -36,6 +36,7 @@
 #include <asm/desc.h>
 #include <asm/debugreg.h>
 #include <asm/kvm_para.h>
+#include <asm/nospec-branch.h>
 
 #include <asm/virtext.h>
 #include "trace.h"
@@ -3963,6 +3964,9 @@ static void svm_vcpu_run(struct kvm_vcpu
 #endif
 		);
 
+	/* Eliminate branch target predictions from guest mode */
+	vmexit_fill_RSB();
+
 #ifdef CONFIG_X86_64
 	wrmsrl(MSR_GS_BASE, svm->host.gs_base);
 #else
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -45,6 +45,7 @@
 #include <asm/perf_event.h>
 #include <asm/debugreg.h>
 #include <asm/kexec.h>
+#include <asm/nospec-branch.h>
 
 #include "trace.h"
 
@@ -7557,6 +7558,9 @@ static void __noclone vmx_vcpu_run(struc
 #endif
 	      );
 
+	/* Eliminate branch target predictions from guest mode */
+	vmexit_fill_RSB();
+
 	/* MSR_IA32_DEBUGCTLMSR is zeroed on vmexit. Restore it if needed */
 	if (debugctlmsr)
 		update_debugctlmsr(debugctlmsr);
