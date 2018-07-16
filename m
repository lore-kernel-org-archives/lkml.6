Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635F4ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E2B2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E2B2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389458AbeGPIKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:10:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48294 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388522AbeGPIKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:10:52 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 780E0CA0;
        Mon, 16 Jul 2018 07:44:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Rik van Riel <riel@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 20/43] x86/fpu: Get rid of xstate_fault()
Date:   Mon, 16 Jul 2018 09:36:25 +0200
Message-Id: <20180716073514.030716624@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073511.796555857@linuxfoundation.org>
References: <20180716073511.796555857@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit b7106fa0f29f9fd83d2d1905ab690d334ef855c1 upstream

Add macros for the alternative XSAVE*/XRSTOR* operations which
contain the fault handling and use them. Kill xstate_fault().

Also, copy_xregs_to_kernel() didn't have the extended state as
memory reference in the asm.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Casasnovas <quentin.casasnovas@oracle.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1447932326-4371-3-git-send-email-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/include/asm/fpu/internal.h |  105 +++++++++++++++++-------------------
 1 file changed, 52 insertions(+), 53 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -225,19 +225,6 @@ static inline void copy_fxregs_to_kernel
 #define XRSTOR		".byte " REX_PREFIX "0x0f,0xae,0x2f"
 #define XRSTORS		".byte " REX_PREFIX "0x0f,0xc7,0x1f"
 
-/* xstate instruction fault handler: */
-#define xstate_fault(__err)		\
-					\
-	".section .fixup,\"ax\"\n"	\
-					\
-	"3:  movl $-2,%[_err]\n"	\
-	"    jmp  2b\n"			\
-					\
-	".previous\n"			\
-					\
-	_ASM_EXTABLE(1b, 3b)		\
-	: [_err] "=r" (__err)
-
 #define XSTATE_OP(op, st, lmask, hmask, err)				\
 	asm volatile("1:" op "\n\t"					\
 		     "xor %[err], %[err]\n"				\
@@ -251,6 +238,54 @@ static inline void copy_fxregs_to_kernel
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
 
+/*
+ * If XSAVES is enabled, it replaces XSAVEOPT because it supports a compact
+ * format and supervisor states in addition to modified optimization in
+ * XSAVEOPT.
+ *
+ * Otherwise, if XSAVEOPT is enabled, XSAVEOPT replaces XSAVE because XSAVEOPT
+ * supports modified optimization which is not supported by XSAVE.
+ *
+ * We use XSAVE as a fallback.
+ *
+ * The 661 label is defined in the ALTERNATIVE* macros as the address of the
+ * original instruction which gets replaced. We need to use it here as the
+ * address of the instruction where we might get an exception at.
+ */
+#define XSTATE_XSAVE(st, lmask, hmask, err)				\
+	asm volatile(ALTERNATIVE_2(XSAVE,				\
+				   XSAVEOPT, X86_FEATURE_XSAVEOPT,	\
+				   XSAVES,   X86_FEATURE_XSAVES)	\
+		     "\n"						\
+		     "xor %[err], %[err]\n"				\
+		     "3:\n"						\
+		     ".pushsection .fixup,\"ax\"\n"			\
+		     "4: movl $-2, %[err]\n"				\
+		     "jmp 3b\n"						\
+		     ".popsection\n"					\
+		     _ASM_EXTABLE(661b, 4b)				\
+		     : [err] "=r" (err)					\
+		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
+		     : "memory")
+
+/*
+ * Use XRSTORS to restore context if it is enabled. XRSTORS supports compact
+ * XSAVE area format.
+ */
+#define XSTATE_XRESTORE(st, lmask, hmask, err)				\
+	asm volatile(ALTERNATIVE(XRSTOR,				\
+				 XRSTORS, X86_FEATURE_XSAVES)		\
+		     "\n"						\
+		     "xor %[err], %[err]\n"				\
+		     "3:\n"						\
+		     ".pushsection .fixup,\"ax\"\n"			\
+		     "4: movl $-2, %[err]\n"				\
+		     "jmp 3b\n"						\
+		     ".popsection\n"					\
+		     _ASM_EXTABLE(661b, 4b)				\
+		     : [err] "=r" (err)					\
+		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
+		     : "memory")
 
 /*
  * This function is called only during boot time when x86 caps are not set
@@ -304,33 +339,11 @@ static inline void copy_xregs_to_kernel(
 	u64 mask = -1;
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
-	int err = 0;
+	int err;
 
 	WARN_ON(!alternatives_patched);
 
-	/*
-	 * If xsaves is enabled, xsaves replaces xsaveopt because
-	 * it supports compact format and supervisor states in addition to
-	 * modified optimization in xsaveopt.
-	 *
-	 * Otherwise, if xsaveopt is enabled, xsaveopt replaces xsave
-	 * because xsaveopt supports modified optimization which is not
-	 * supported by xsave.
-	 *
-	 * If none of xsaves and xsaveopt is enabled, use xsave.
-	 */
-	alternative_input_2(
-		"1:"XSAVE,
-		XSAVEOPT,
-		X86_FEATURE_XSAVEOPT,
-		XSAVES,
-		X86_FEATURE_XSAVES,
-		[xstate] "D" (xstate), "a" (lmask), "d" (hmask) :
-		"memory");
-	asm volatile("2:\n\t"
-		     xstate_fault(err)
-		     : "0" (err)
-		     : "memory");
+	XSTATE_XSAVE(xstate, lmask, hmask, err);
 
 	/* We should never fault when copying to a kernel buffer: */
 	WARN_ON_FPU(err);
@@ -343,23 +356,9 @@ static inline void copy_kernel_to_xregs(
 {
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
-	int err = 0;
+	int err;
 
-	/*
-	 * Use xrstors to restore context if it is enabled. xrstors supports
-	 * compacted format of xsave area which is not supported by xrstor.
-	 */
-	alternative_input(
-		"1: " XRSTOR,
-		XRSTORS,
-		X86_FEATURE_XSAVES,
-		"D" (xstate), "m" (*xstate), "a" (lmask), "d" (hmask)
-		: "memory");
-
-	asm volatile("2:\n"
-		     xstate_fault(err)
-		     : "0" (err)
-		     : "memory");
+	XSTATE_XRESTORE(xstate, lmask, hmask, err);
 
 	/* We should never fault when copying from a kernel buffer: */
 	WARN_ON_FPU(err);


