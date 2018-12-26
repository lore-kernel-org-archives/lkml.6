Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC06EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 10:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AABA12171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 10:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeLZKBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 05:01:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:3462 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbeLZKBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 05:01:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 02:00:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,400,1539673200"; 
   d="scan'208";a="112107162"
Received: from devel-ww.sh.intel.com ([10.239.48.119])
  by fmsmga008.fm.intel.com with ESMTP; 26 Dec 2018 02:00:57 -0800
From:   Wei Wang <wei.w.wang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, peterz@infradead.org
Cc:     kan.liang@intel.com, mingo@redhat.com, rkrcmar@redhat.com,
        like.xu@intel.com, wei.w.wang@intel.com, jannh@google.com,
        arei.gonglei@huawei.com
Subject: [PATCH v4 09/10] perf/x86: function to check lbr user callstack mode
Date:   Wed, 26 Dec 2018 17:25:37 +0800
Message-Id: <1545816338-1171-10-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com>
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a function to check if the lbr_sel value has the user
callstack mode set. The related LBR_* macros are moved to the
perf_event.h as well.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/events/intel/lbr.c       | 38 -------------------------------
 arch/x86/include/asm/perf_event.h | 48 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 38 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 0225ac9..71fd76a 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -27,44 +27,6 @@ static const enum {
 	[LBR_FORMAT_EIP_FLAGS2] = LBR_EIP_FLAGS | LBR_TSX,
 };
 
-/*
- * Intel LBR_SELECT bits
- * Intel Vol3a, April 2011, Section 16.7 Table 16-10
- *
- * Hardware branch filter (not available on all CPUs)
- */
-#define LBR_KERNEL_BIT		0 /* do not capture at ring0 */
-#define LBR_USER_BIT		1 /* do not capture at ring > 0 */
-#define LBR_JCC_BIT		2 /* do not capture conditional branches */
-#define LBR_REL_CALL_BIT	3 /* do not capture relative calls */
-#define LBR_IND_CALL_BIT	4 /* do not capture indirect calls */
-#define LBR_RETURN_BIT		5 /* do not capture near returns */
-#define LBR_IND_JMP_BIT		6 /* do not capture indirect jumps */
-#define LBR_REL_JMP_BIT		7 /* do not capture relative jumps */
-#define LBR_FAR_BIT		8 /* do not capture far branches */
-#define LBR_CALL_STACK_BIT	9 /* enable call stack */
-
-/*
- * Following bit only exists in Linux; we mask it out before writing it to
- * the actual MSR. But it helps the constraint perf code to understand
- * that this is a separate configuration.
- */
-#define LBR_NO_INFO_BIT	       63 /* don't read LBR_INFO. */
-
-#define LBR_KERNEL	(1 << LBR_KERNEL_BIT)
-#define LBR_USER	(1 << LBR_USER_BIT)
-#define LBR_JCC		(1 << LBR_JCC_BIT)
-#define LBR_REL_CALL	(1 << LBR_REL_CALL_BIT)
-#define LBR_IND_CALL	(1 << LBR_IND_CALL_BIT)
-#define LBR_RETURN	(1 << LBR_RETURN_BIT)
-#define LBR_REL_JMP	(1 << LBR_REL_JMP_BIT)
-#define LBR_IND_JMP	(1 << LBR_IND_JMP_BIT)
-#define LBR_FAR		(1 << LBR_FAR_BIT)
-#define LBR_CALL_STACK	(1 << LBR_CALL_STACK_BIT)
-#define LBR_NO_INFO	(1ULL << LBR_NO_INFO_BIT)
-
-#define LBR_PLM (LBR_KERNEL | LBR_USER)
-
 #define LBR_SEL_MASK	0x3ff	/* valid bits in LBR_SELECT */
 #define LBR_NOT_SUPP	-1	/* LBR filter not supported */
 #define LBR_IGN		0	/* ignored */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index eee09b7..5c1d3ed 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -90,6 +90,45 @@
 #define X86_PERF_CAP_MASK_LBR_FMT			0x3f
 
 /*
+ * Intel LBR_SELECT bits
+ * Intel Vol3a, April 2011, Section 16.7 Table 16-10
+ *
+ * Hardware branch filter (not available on all CPUs)
+ */
+#define LBR_KERNEL_BIT		0 /* do not capture at ring0 */
+#define LBR_USER_BIT		1 /* do not capture at ring > 0 */
+#define LBR_JCC_BIT		2 /* do not capture conditional branches */
+#define LBR_REL_CALL_BIT	3 /* do not capture relative calls */
+#define LBR_IND_CALL_BIT	4 /* do not capture indirect calls */
+#define LBR_RETURN_BIT		5 /* do not capture near returns */
+#define LBR_IND_JMP_BIT		6 /* do not capture indirect jumps */
+#define LBR_REL_JMP_BIT		7 /* do not capture relative jumps */
+#define LBR_FAR_BIT		8 /* do not capture far branches */
+#define LBR_CALL_STACK_BIT	9 /* enable call stack */
+
+/*
+ * Following bit only exists in Linux; we mask it out before writing it to
+ * the actual MSR. But it helps the constraint perf code to understand
+ * that this is a separate configuration.
+ */
+#define LBR_NO_INFO_BIT	       63 /* don't read LBR_INFO. */
+
+#define LBR_KERNEL	(1 << LBR_KERNEL_BIT)
+#define LBR_USER	(1 << LBR_USER_BIT)
+#define LBR_JCC		(1 << LBR_JCC_BIT)
+#define LBR_REL_CALL	(1 << LBR_REL_CALL_BIT)
+#define LBR_IND_CALL	(1 << LBR_IND_CALL_BIT)
+#define LBR_RETURN	(1 << LBR_RETURN_BIT)
+#define LBR_REL_JMP	(1 << LBR_REL_JMP_BIT)
+#define LBR_IND_JMP	(1 << LBR_IND_JMP_BIT)
+#define LBR_FAR		(1 << LBR_FAR_BIT)
+#define LBR_CALL_STACK	(1 << LBR_CALL_STACK_BIT)
+#define LBR_NO_INFO	(1ULL << LBR_NO_INFO_BIT)
+
+#define LBR_PLM (LBR_KERNEL | LBR_USER)
+#define LBR_USER_CALLSTACK (LBR_CALL_STACK | LBR_USER)
+
+/*
  * Intel "Architectural Performance Monitoring" CPUID
  * detection/enumeration details:
  */
@@ -311,6 +350,15 @@ static inline void perf_events_lapic_init(void)	{ }
 static inline void perf_check_microcode(void) { }
 #endif
 
+/*
+ * Returns true if the msr value is configured to the user callstack mode.
+ * Otherwise, false.
+ */
+static inline bool lbr_select_user_callstack(u64 lbr_select)
+{
+	return !!(lbr_select & LBR_USER_CALLSTACK);
+}
+
 #ifdef CONFIG_CPU_SUP_INTEL
  extern void intel_pt_handle_vmx(int on);
 #endif
-- 
2.7.4

