Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CF7C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 00:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B0820883
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 00:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B0820883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbeKHKG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 05:06:27 -0500
Received: from mga03.intel.com ([134.134.136.65]:17841 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727525AbeKHKG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 05:06:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 16:33:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,477,1534834800"; 
   d="scan'208";a="279252377"
Received: from aubrey-skl.sh.intel.com ([10.239.53.9])
  by fmsmga006.fm.intel.com with ESMTP; 07 Nov 2018 16:33:34 -0800
From:   Aubrey Li <aubrey.li@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        hpa@zytor.com
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        arjan@linux.intel.com, aubrey.li@intel.com,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@linux.intel.com>
Subject: [RFC PATCH v2 1/2] x86/fpu: detect AVX task
Date:   Thu,  8 Nov 2018 01:16:21 +0800
Message-Id: <1541610982-33478-1-git-send-email-aubrey.li@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XSAVES and its variants use init optimization to reduce the amount of
data that they save to memory during context switch. Init optimization
uses the state component bitmap to denote if a component is in its init
configuration. We use this information to detect if a task contains AVX
instructions.

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
---
 arch/x86/include/asm/fpu/internal.h | 97 +++++++++++++++++++++++++++----------
 arch/x86/include/asm/fpu/types.h    | 17 +++++++
 2 files changed, 88 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index a38bf5a..b0519f4 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -74,6 +74,12 @@ static __always_inline __pure bool use_fxsr(void)
 	return static_cpu_has(X86_FEATURE_FXSR);
 }
 
+static __always_inline __pure bool use_xgetbv1(void)
+{
+	return static_cpu_has(X86_FEATURE_OSXSAVE) &&
+		static_cpu_has(X86_FEATURE_XGETBV1);
+}
+
 /*
  * fpstate handling functions:
  */
@@ -103,6 +109,34 @@ static inline void fpstate_init_fxstate(struct fxregs_state *fx)
 }
 extern void fpstate_sanitize_xstate(struct fpu *fpu);
 
+/*
+ * MXCSR and XCR definitions:
+ */
+
+extern unsigned int mxcsr_feature_mask;
+
+#define	XCR_XFEATURE_ENABLED_MASK	0x00000000
+#define	XINUSE_STATE_BITMAP_INDEX	0x00000001
+
+static inline u64 xgetbv(u32 index)
+{
+	u32 eax, edx;
+
+	asm volatile(".byte 0x0f,0x01,0xd0" /* xgetbv */
+		     : "=a" (eax), "=d" (edx)
+		     : "c" (index));
+	return eax + ((u64)edx << 32);
+}
+
+static inline void xsetbv(u32 index, u64 value)
+{
+	u32 eax = value;
+	u32 edx = value >> 32;
+
+	asm volatile(".byte 0x0f,0x01,0xd1" /* xsetbv */
+		     : : "a" (eax), "d" (edx), "c" (index));
+}
+
 #define user_insn(insn, output, input...)				\
 ({									\
 	int err;							\
@@ -275,6 +309,42 @@ static inline void copy_fxregs_to_kernel(struct fpu *fpu)
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
 
+#define	AVX_STATE_DECAY_COUNT	3
+
+/*
+ * This function is called during context switch to update AVX component state
+ */
+static inline void update_avx_state(struct avx_state *avx)
+{
+	/*
+	 * Check if XGETBV with ECX = 1 supported. XGETBV with ECX = 1
+	 * returns the logical-AND of XCR0 and XINUSE. XINUSE is a bitmap
+	 * by which the processor tracks the status of various components.
+	 */
+	if (!use_xgetbv1()) {
+		avx->state = 0;
+		return;
+	}
+	/*
+	 * XINUSE is dynamic to track component state because VZEROUPPER
+	 * happens on every function end and reset the bitmap to the
+	 * initial configuration.
+	 *
+	 * State decay is introduced to solve the race condition between
+	 * context switch and a function end. State is aggressively set
+	 * once it's detected but need to be cleared by decay 3 context
+	 * switches
+	 */
+	if (xgetbv(XINUSE_STATE_BITMAP_INDEX) & XFEATURE_MASK_Hi16_ZMM) {
+		avx->state = 1;
+		avx->decay_count = AVX_STATE_DECAY_COUNT;
+	} else {
+		if (avx->decay_count)
+			avx->decay_count--;
+		else
+			avx->state = 0;
+	}
+}
 /*
  * This function is called only during boot time when x86 caps are not set
  * up and alternative can not be used yet.
@@ -411,6 +481,7 @@ static inline int copy_fpregs_to_fpstate(struct fpu *fpu)
 {
 	if (likely(use_xsave())) {
 		copy_xregs_to_kernel(&fpu->state.xsave);
+		update_avx_state(&fpu->avx);
 		return 1;
 	}
 
@@ -577,31 +648,5 @@ static inline void user_fpu_begin(void)
 	preempt_enable();
 }
 
-/*
- * MXCSR and XCR definitions:
- */
-
-extern unsigned int mxcsr_feature_mask;
-
-#define XCR_XFEATURE_ENABLED_MASK	0x00000000
-
-static inline u64 xgetbv(u32 index)
-{
-	u32 eax, edx;
-
-	asm volatile(".byte 0x0f,0x01,0xd0" /* xgetbv */
-		     : "=a" (eax), "=d" (edx)
-		     : "c" (index));
-	return eax + ((u64)edx << 32);
-}
-
-static inline void xsetbv(u32 index, u64 value)
-{
-	u32 eax = value;
-	u32 edx = value >> 32;
-
-	asm volatile(".byte 0x0f,0x01,0xd1" /* xsetbv */
-		     : : "a" (eax), "d" (edx), "c" (index));
-}
 
 #endif /* _ASM_X86_FPU_INTERNAL_H */
diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 202c539..39d5bc2 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -274,6 +274,15 @@ union fpregs_state {
 };
 
 /*
+ * This is per task AVX state data structure that indicates
+ * whether the task uses AVX instructions.
+ */
+struct avx_state {
+	unsigned int			state;
+	unsigned int			decay_count;
+};
+
+/*
  * Highest level per task FPU state data structure that
  * contains the FPU register state plus various FPU
  * state fields:
@@ -303,6 +312,14 @@ struct fpu {
 	unsigned char			initialized;
 
 	/*
+	 * @avx_state:
+	 *
+	 * This data structure indicates whether this context
+	 * contains AVX states
+	 */
+	struct avx_state		avx;
+
+	/*
 	 * @state:
 	 *
 	 * In-memory copy of all FPU registers that we save/restore
-- 
2.7.4

