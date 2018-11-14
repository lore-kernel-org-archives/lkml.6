Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5F3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 06:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E17E2250E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 06:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E17E2250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbeKOQXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 11:23:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:13841 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbeKOQXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 11:23:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2018 22:17:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,235,1539673200"; 
   d="scan'208";a="281236372"
Received: from aubrey-skl.sh.intel.com ([10.239.53.9])
  by fmsmga006.fm.intel.com with ESMTP; 14 Nov 2018 22:17:16 -0800
From:   Aubrey Li <aubrey.li@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        hpa@zytor.com
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, aubrey.li@intel.com,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@linux.intel.com>
Subject: [PATCH v3 1/2] x86/fpu: track AVX-512 usage of tasks
Date:   Thu, 15 Nov 2018 07:00:06 +0800
Message-Id: <1542236407-4323-1-git-send-email-aubrey.li@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User space tools which do automated task placement need information
about AVX-512 usage of tasks, because AVX-512 usage could cause core
turbo frequency drop and impact the running task on the sibling CPU.

XSAVE header contains a state-component bitmap, which allows software
to discover the state of the init optimization used by XSAVEOPT and
XSAVES. Set bits in the bitmap denotes the usage of the components.

AVX-512 component has 3 states, only Hi16_ZMM state causes notable
frequency drop. Add per task Hi16_ZMM state tracking to context switch.

The tracking turns on the usage flag immediately, but requires 3
consecutive context switches with no usage to clear it. This decay is
required because of AVX-512 using tasks could set Hi16_ZMM state back
to the init state themselves.

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
---
 arch/x86/include/asm/fpu/internal.h | 26 ++++++++++++++++++++++++++
 arch/x86/include/asm/fpu/types.h    |  9 +++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index a38bf5a..f382449 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -275,6 +275,31 @@ static inline void copy_fxregs_to_kernel(struct fpu *fpu)
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
 
+#define	HI16ZMM_STATE_DECAY_COUNT	3
+/*
+ * This function is called during context switch to update Hi16_ZMM state
+ */
+static inline void update_hi16zmm_state(struct fpu *fpu)
+{
+	/*
+	 * XSAVE header contains a state-component bitmap(xfeatures),
+	 * which allows software to discover the state of the init
+	 * optimization used by XSAVEOPT and XSAVES.
+	 *
+	 * Hi16_ZMM state(one state of AVX-512 component) is tracked here
+	 * because its usage could cause notable core turbo frequency drop.
+	 *
+	 * AVX512-using tasks could set Hi16_ZMM state back to the init
+	 * state themselves. Thus, this tracking mechanism can miss.
+	 * The decay usage ensures that false-negatives do not immediately
+	 * make a task be considered as not using Hi16_ZMM registers.
+	 */
+	if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_Hi16_ZMM)
+		fpu->hi16zmm_usage = HI16ZMM_STATE_DECAY_COUNT;
+	else if (fpu->hi16zmm_usage)
+		fpu->hi16zmm_usage--;
+}
+
 /*
  * This function is called only during boot time when x86 caps are not set
  * up and alternative can not be used yet.
@@ -411,6 +436,7 @@ static inline int copy_fpregs_to_fpstate(struct fpu *fpu)
 {
 	if (likely(use_xsave())) {
 		copy_xregs_to_kernel(&fpu->state.xsave);
+		update_hi16zmm_state(fpu);
 		return 1;
 	}
 
diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 202c539..c0c7577 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -303,6 +303,15 @@ struct fpu {
 	unsigned char			initialized;
 
 	/*
+	 * @hi16zmm_usage:
+	 *
+	 * Records the usage of the upper 16 AVX512 registers: ZMM16-ZMM31.
+	 * A value of non-zero is used to indicate whether there is valid
+	 * state in these AVX512 registers.
+	 */
+	unsigned char			hi16zmm_usage;
+
+	/*
 	 * @state:
 	 *
 	 * In-memory copy of all FPU registers that we save/restore
-- 
2.7.4

