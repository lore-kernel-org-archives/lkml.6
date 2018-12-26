Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C25C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 08:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121D221720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 08:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbeLZIVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 03:21:09 -0500
Received: from mga01.intel.com ([192.55.52.88]:19494 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbeLZIVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 03:21:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 00:21:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,400,1539673200"; 
   d="scan'208";a="103379568"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.239.13.104])
  by orsmga006.jf.intel.com with ESMTP; 26 Dec 2018 00:21:05 -0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     qemu-devel@nongnu.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com
Cc:     Yang Weijiang <weijiang.yang@intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>
Subject: [Qemu-devel][PATCH 1/4] Add CET xsaves/xrstors related macros and structures.
Date:   Wed, 26 Dec 2018 16:25:17 +0800
Message-Id: <bfb9a32529b3d3374649e2eae48ada85d3f4b793.1545806972.git.weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1545806972.git.weijiang.yang@intel.com>
References: <cover.1545806972.git.weijiang.yang@intel.com>
In-Reply-To: <cover.1545806972.git.weijiang.yang@intel.com>
References: <cover.1545806972.git.weijiang.yang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CET protection in user mode and kernel mode relies on
specific MSRs, these MSRs' contents are automatically
saved/restored by xsaves/xrstors instructions.

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 target/i386/cpu.h | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9c52d0cbeb..f3f724d8e6 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -469,6 +469,9 @@ typedef enum X86Seg {
 #define XSTATE_ZMM_Hi256_BIT            6
 #define XSTATE_Hi16_ZMM_BIT             7
 #define XSTATE_PKRU_BIT                 9
+#define XSTATE_RESERVED_BIT             10
+#define XSTATE_CET_U_BIT                11
+#define XSTATE_CET_S_BIT                12
 
 #define XSTATE_FP_MASK                  (1ULL << XSTATE_FP_BIT)
 #define XSTATE_SSE_MASK                 (1ULL << XSTATE_SSE_BIT)
@@ -479,6 +482,19 @@ typedef enum X86Seg {
 #define XSTATE_ZMM_Hi256_MASK           (1ULL << XSTATE_ZMM_Hi256_BIT)
 #define XSTATE_Hi16_ZMM_MASK            (1ULL << XSTATE_Hi16_ZMM_BIT)
 #define XSTATE_PKRU_MASK                (1ULL << XSTATE_PKRU_BIT)
+#define XSTATE_RESERVED_MASK            (1ULL << XSTATE_RESERVED_BIT)
+#define XSTATE_CET_U_MASK               (1ULL << XSTATE_CET_U_BIT)
+#define XSTATE_CET_S_MASK               (1ULL << XSTATE_CET_S_BIT)
+
+/* CPUID feature bits available in XCR0 */
+#define CPUID_XSTATE_USER_MASK  (XSTATE_FP_MASK | XSTATE_SSE_MASK \
+                                | XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK \
+                                | XSTATE_BNDCSR_MASK | XSTATE_OPMASK_MASK \
+                                | XSTATE_ZMM_Hi256_MASK \
+                                | XSTATE_Hi16_ZMM_MASK | XSTATE_PKRU_MASK)
+
+/* CPUID feature bits available in XSS */
+#define CPUID_XSTATE_KERNEL_MASK    (XSTATE_CET_U_MASK | XSTATE_CET_S_MASK)
 
 /* CPUID feature words */
 typedef enum FeatureWord {
@@ -503,6 +519,8 @@ typedef enum FeatureWord {
     FEAT_XSAVE_COMP_LO, /* CPUID[EAX=0xd,ECX=0].EAX */
     FEAT_XSAVE_COMP_HI, /* CPUID[EAX=0xd,ECX=0].EDX */
     FEAT_ARCH_CAPABILITIES,
+    FEAT_XSAVE_SV_LO,   /* CPUID[EAX=0xd,ECX=1].ECX */
+    FEAT_XSAVE_SV_HI,   /* CPUID[EAX=0xd,ECX=1].EDX */
     FEATURE_WORDS,
 } FeatureWord;
 
@@ -687,7 +705,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_ECX_LA57     (1U << 16)
 #define CPUID_7_0_ECX_RDPID    (1U << 22)
 #define CPUID_7_0_ECX_CLDEMOTE (1U << 25)  /* CLDEMOTE Instruction */
-
+#define CPUID_7_0_ECX_CET_SHSTK     (1U << 7)  /* CET SHSTK feature bit */
 #define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural Network Instructions */
 #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
 #define CPUID_7_0_EDX_PCONFIG (1U << 18)       /* Platform Configuration */
@@ -1021,6 +1039,19 @@ typedef struct XSavePKRU {
     uint32_t padding;
 } XSavePKRU;
 
+/* Ext. save area 11: User mode CET state */
+typedef struct XSaveCETU {
+    uint64_t u_cet;
+    uint64_t user_ssp;
+} XSaveCETU;
+
+/* Ext. save area 12: Supervisor mode CET state */
+typedef struct XSaveCETS {
+    uint64_t kernel_ssp;
+    uint64_t pl1_ssp;
+    uint64_t pl2_ssp;
+} XSaveCETS;
+
 typedef struct X86XSaveArea {
     X86LegacyXSaveArea legacy;
     X86XSaveHeader header;
@@ -1039,6 +1070,9 @@ typedef struct X86XSaveArea {
     XSaveHi16_ZMM hi16_zmm_state;
     /* PKRU State: */
     XSavePKRU pkru_state;
+    /* CET State: */
+    XSaveCETU cet_u;
+    XSaveCETS cet_s;
 } X86XSaveArea;
 
 QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, avx_state) != 0x240);
-- 
2.17.1

