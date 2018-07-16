Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C8CECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1529120837
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1529120837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389740AbeGPINA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:13:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51436 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbeGPIM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:12:59 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D9C75CEF;
        Mon, 16 Jul 2018 07:45:57 +0000 (UTC)
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
Subject: [PATCH 4.4 19/43] x86/fpu: Add an XSTATE_OP() macro
Date:   Mon, 16 Jul 2018 09:36:24 +0200
Message-Id: <20180716073513.937136006@linuxfoundation.org>
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

commit b74a0cf1b3db30173eefa00c411775d2b1697700 upstream

Add an XSTATE_OP() macro which contains the XSAVE* fault handling
and replace all non-alternatives users of xstate_fault() with
it.

This fixes also the buglet in copy_xregs_to_user() and
copy_user_to_xregs() where the inline asm didn't have @xstate as
memory reference and thus potentially causing unwanted
reordering of accesses to the extended state.

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
Link: http://lkml.kernel.org/r/1447932326-4371-2-git-send-email-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/include/asm/fpu/internal.h |   68 ++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 37 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -238,6 +238,20 @@ static inline void copy_fxregs_to_kernel
 	_ASM_EXTABLE(1b, 3b)		\
 	: [_err] "=r" (__err)
 
+#define XSTATE_OP(op, st, lmask, hmask, err)				\
+	asm volatile("1:" op "\n\t"					\
+		     "xor %[err], %[err]\n"				\
+		     "2:\n\t"						\
+		     ".pushsection .fixup,\"ax\"\n\t"			\
+		     "3: movl $-2,%[err]\n\t"				\
+		     "jmp 2b\n\t"					\
+		     ".popsection\n\t"					\
+		     _ASM_EXTABLE(1b, 3b)				\
+		     : [err] "=r" (err)					\
+		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
+		     : "memory")
+
+
 /*
  * This function is called only during boot time when x86 caps are not set
  * up and alternative can not be used yet.
@@ -247,22 +261,14 @@ static inline void copy_xregs_to_kernel_
 	u64 mask = -1;
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
-	int err = 0;
+	int err;
 
 	WARN_ON(system_state != SYSTEM_BOOTING);
 
-	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		asm volatile("1:"XSAVES"\n\t"
-			"2:\n\t"
-			     xstate_fault(err)
-			: "D" (xstate), "m" (*xstate), "a" (lmask), "d" (hmask), "0" (err)
-			: "memory");
+	if (static_cpu_has_safe(X86_FEATURE_XSAVES))
+		XSTATE_OP(XSAVES, xstate, lmask, hmask, err);
 	else
-		asm volatile("1:"XSAVE"\n\t"
-			"2:\n\t"
-			     xstate_fault(err)
-			: "D" (xstate), "m" (*xstate), "a" (lmask), "d" (hmask), "0" (err)
-			: "memory");
+		XSTATE_OP(XSAVE, xstate, lmask, hmask, err);
 
 	/* We should never fault when copying to a kernel buffer: */
 	WARN_ON_FPU(err);
@@ -277,22 +283,14 @@ static inline void copy_kernel_to_xregs_
 	u64 mask = -1;
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
-	int err = 0;
+	int err;
 
 	WARN_ON(system_state != SYSTEM_BOOTING);
 
-	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		asm volatile("1:"XRSTORS"\n\t"
-			"2:\n\t"
-			     xstate_fault(err)
-			: "D" (xstate), "m" (*xstate), "a" (lmask), "d" (hmask), "0" (err)
-			: "memory");
+	if (static_cpu_has_safe(X86_FEATURE_XSAVES))
+		XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
 	else
-		asm volatile("1:"XRSTOR"\n\t"
-			"2:\n\t"
-			     xstate_fault(err)
-			: "D" (xstate), "m" (*xstate), "a" (lmask), "d" (hmask), "0" (err)
-			: "memory");
+		XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
 
 	/* We should never fault when copying from a kernel buffer: */
 	WARN_ON_FPU(err);
@@ -389,12 +387,10 @@ static inline int copy_xregs_to_user(str
 	if (unlikely(err))
 		return -EFAULT;
 
-	__asm__ __volatile__(ASM_STAC "\n"
-			     "1:"XSAVE"\n"
-			     "2: " ASM_CLAC "\n"
-			     xstate_fault(err)
-			     : "D" (buf), "a" (-1), "d" (-1), "0" (err)
-			     : "memory");
+	stac();
+	XSTATE_OP(XSAVE, buf, -1, -1, err);
+	clac();
+
 	return err;
 }
 
@@ -406,14 +402,12 @@ static inline int copy_user_to_xregs(str
 	struct xregs_state *xstate = ((__force struct xregs_state *)buf);
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
-	int err = 0;
+	int err;
+
+	stac();
+	XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
+	clac();
 
-	__asm__ __volatile__(ASM_STAC "\n"
-			     "1:"XRSTOR"\n"
-			     "2: " ASM_CLAC "\n"
-			     xstate_fault(err)
-			     : "D" (xstate), "a" (lmask), "d" (hmask), "0" (err)
-			     : "memory");	/* memory required? */
 	return err;
 }
 


