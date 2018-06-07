Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1v+5I7RTGVtwHwAAmS7hNA
	; Thu, 07 Jun 2018 15:48:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E3A526074D; Thu,  7 Jun 2018 15:48:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5B97A60590;
	Thu,  7 Jun 2018 15:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5B97A60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934421AbeFGOkO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:40:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:61095 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934171AbeFGOkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:40:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 07:39:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="54825996"
Received: from 2b52.sc.intel.com ([143.183.136.51])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jun 2018 07:39:58 -0700
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 4/5] x86/fpu/xstate: Add XSAVES system states for shadow stack
Date: Thu,  7 Jun 2018 07:35:43 -0700
Message-Id: <20180607143544.3477-5-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180607143544.3477-1-yu-cheng.yu@intel.com>
References: <20180607143544.3477-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Control-flow Enforcement Technology (CET) introduces the
following MSRs into the XSAVES system states.

    IA32_U_CET (user-mode CET settings),
    IA32_PL3_SSP (user-mode shadow stack),
    IA32_PL0_SSP (kernel-mode shadow stack),
    IA32_PL1_SSP (ring-1 shadow stack),
    IA32_PL2_SSP (ring-2 shadow stack).

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/asm/fpu/types.h            | 22 ++++++++++++++++++++++
 arch/x86/include/asm/fpu/xstate.h           |  4 +++-
 arch/x86/include/uapi/asm/processor-flags.h |  2 ++
 arch/x86/kernel/fpu/xstate.c                | 10 ++++++++++
 4 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 202c53918ecf..e55d51d172f1 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -114,6 +114,9 @@ enum xfeature {
 	XFEATURE_Hi16_ZMM,
 	XFEATURE_PT_UNIMPLEMENTED_SO_FAR,
 	XFEATURE_PKRU,
+	XFEATURE_RESERVED,
+	XFEATURE_SHSTK_USER,
+	XFEATURE_SHSTK_KERNEL,
 
 	XFEATURE_MAX,
 };
@@ -128,6 +131,8 @@ enum xfeature {
 #define XFEATURE_MASK_Hi16_ZMM		(1 << XFEATURE_Hi16_ZMM)
 #define XFEATURE_MASK_PT		(1 << XFEATURE_PT_UNIMPLEMENTED_SO_FAR)
 #define XFEATURE_MASK_PKRU		(1 << XFEATURE_PKRU)
+#define XFEATURE_MASK_SHSTK_USER	(1 << XFEATURE_SHSTK_USER)
+#define XFEATURE_MASK_SHSTK_KERNEL	(1 << XFEATURE_SHSTK_KERNEL)
 
 #define XFEATURE_MASK_FPSSE		(XFEATURE_MASK_FP | XFEATURE_MASK_SSE)
 #define XFEATURE_MASK_AVX512		(XFEATURE_MASK_OPMASK \
@@ -229,6 +234,23 @@ struct pkru_state {
 	u32				pad;
 } __packed;
 
+/*
+ * State component 11 is Control flow Enforcement user states
+ */
+struct cet_user_state {
+	u64 u_cet;	/* user control flow settings */
+	u64 user_ssp;	/* user shadow stack pointer */
+} __packed;
+
+/*
+ * State component 12 is Control flow Enforcement kernel states
+ */
+struct cet_kernel_state {
+	u64 kernel_ssp;	/* kernel shadow stack */
+	u64 pl1_ssp;	/* ring-1 shadow stack */
+	u64 pl2_ssp;	/* ring-2 shadow stack */
+} __packed;
+
 struct xstate_header {
 	u64				xfeatures;
 	u64				xcomp_bv;
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index a32dc5f8c963..662562cbafe9 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -31,7 +31,9 @@
 				  XFEATURE_MASK_Hi16_ZMM | \
 				  XFEATURE_MASK_PKRU | \
 				  XFEATURE_MASK_BNDREGS | \
-				  XFEATURE_MASK_BNDCSR)
+				  XFEATURE_MASK_BNDCSR | \
+				  XFEATURE_MASK_SHSTK_USER | \
+				  XFEATURE_MASK_SHSTK_KERNEL)
 
 #ifdef CONFIG_X86_64
 #define REX_PREFIX	"0x48, "
diff --git a/arch/x86/include/uapi/asm/processor-flags.h b/arch/x86/include/uapi/asm/processor-flags.h
index bcba3c643e63..25311ec4b731 100644
--- a/arch/x86/include/uapi/asm/processor-flags.h
+++ b/arch/x86/include/uapi/asm/processor-flags.h
@@ -130,6 +130,8 @@
 #define X86_CR4_SMAP		_BITUL(X86_CR4_SMAP_BIT)
 #define X86_CR4_PKE_BIT		22 /* enable Protection Keys support */
 #define X86_CR4_PKE		_BITUL(X86_CR4_PKE_BIT)
+#define X86_CR4_CET_BIT		23 /* enable Control flow Enforcement */
+#define X86_CR4_CET		_BITUL(X86_CR4_CET_BIT)
 
 /*
  * x86-64 Task Priority Register, CR8
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index dd2c561c4544..91c0f665567b 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -35,6 +35,9 @@ static const char *xfeature_names[] =
 	"Processor Trace (unused)"	,
 	"Protection Keys User registers",
 	"unknown xstate feature"	,
+	"Control flow User registers"	,
+	"Control flow Kernel registers"	,
+	"unknown xstate feature"	,
 };
 
 static short xsave_cpuid_features[] __initdata = {
@@ -48,6 +51,9 @@ static short xsave_cpuid_features[] __initdata = {
 	X86_FEATURE_AVX512F,
 	X86_FEATURE_INTEL_PT,
 	X86_FEATURE_PKU,
+	0,		   /* Unused */
+	X86_FEATURE_SHSTK, /* XFEATURE_SHSTK_USER */
+	X86_FEATURE_SHSTK, /* XFEATURE_SHSTK_KERNEL */
 };
 
 /*
@@ -316,6 +322,8 @@ static void __init print_xstate_features(void)
 	print_xstate_feature(XFEATURE_MASK_ZMM_Hi256);
 	print_xstate_feature(XFEATURE_MASK_Hi16_ZMM);
 	print_xstate_feature(XFEATURE_MASK_PKRU);
+	print_xstate_feature(XFEATURE_MASK_SHSTK_USER);
+	print_xstate_feature(XFEATURE_MASK_SHSTK_KERNEL);
 }
 
 /*
@@ -562,6 +570,8 @@ static void check_xstate_against_struct(int nr)
 	XCHECK_SZ(sz, nr, XFEATURE_ZMM_Hi256, struct avx_512_zmm_uppers_state);
 	XCHECK_SZ(sz, nr, XFEATURE_Hi16_ZMM,  struct avx_512_hi16_state);
 	XCHECK_SZ(sz, nr, XFEATURE_PKRU,      struct pkru_state);
+	XCHECK_SZ(sz, nr, XFEATURE_SHSTK_USER,   struct cet_user_state);
+	XCHECK_SZ(sz, nr, XFEATURE_SHSTK_KERNEL, struct cet_kernel_state);
 
 	/*
 	 * Make *SURE* to add any feature numbers in below if
-- 
2.15.1
