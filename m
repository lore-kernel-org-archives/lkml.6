Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02677C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19602082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19602082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbeLKHmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 02:42:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:36295 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbeLKHmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 02:42:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 23:42:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,341,1539673200"; 
   d="scan'208";a="117644283"
Received: from aubrey-skl.sh.intel.com ([10.239.53.9])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Dec 2018 23:42:50 -0800
From:   Aubrey Li <aubrey.li@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        hpa@zytor.com
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, aubrey.li@intel.com,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@linux.intel.com>
Subject: [PATCH v4 1/2] x86/fpu: track AVX-512 usage of tasks
Date:   Tue, 11 Dec 2018 08:24:47 +0800
Message-Id: <20181211002448.3520-1-aubrey.li@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User space tools which do automated task placement need information
about AVX-512 usage of tasks, because AVX-512 usage could cause core
turbo frequency drop and impact the running task on the sibling CPU.

The XSAVE hardware structure has bits that indicate when valid state
is present in registers unique to AVX-512 use.  Use these bits to
indicate when AVX-512 has been in use and add per-task AVX-512 state
tracking to context switch.

The tracking turns on the usage flag at the next context switch of
the task, but requires 3 consecutive context switches with no usage
to clear it. This decay is required because well-written AVX-512
applications are expected to clear this state when not actively using
AVX-512 registers.

Although this mechanism is imprecise and can theoretically have both
false-positives and false-negatives, it has been measured to be precise
enough to be useful under real-world workloads like tensorflow and linpack.

If higher precision is required, suggest user space tools to use the
PMU-based mechanisms in combination.

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
---
 arch/x86/include/asm/fpu/internal.h | 22 ++++++++++++++++++++++
 arch/x86/include/asm/fpu/types.h    |  8 ++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index a38bf5a1e37a..0da74d63ba14 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -275,6 +275,27 @@ static inline void copy_fxregs_to_kernel(struct fpu *fpu)
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
 
+#define	AVX512_STATE_DECAY_COUNT	3
+/*
+ * This function is called during context switch to update AVX512 state
+ */
+static inline void update_avx512_state(struct fpu *fpu)
+{
+	/*
+	 * AVX512 state is tracked here because its use is known to slow
+	 * the max clock speed of the core.
+	 *
+	 * However, AVX512-using tasks are expected to clear this state when
+	 * not actively using these registers. Thus, this tracking mechanism
+	 * can miss. To ensure that false-negatives do not immediately show
+	 * up, decay the usage count over time.
+	 */
+	if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
+		fpu->avx512_usage = AVX512_STATE_DECAY_COUNT;
+	else if (fpu->avx512_usage)
+		fpu->avx512_usage--;
+}
+
 /*
  * This function is called only during boot time when x86 caps are not set
  * up and alternative can not be used yet.
@@ -411,6 +432,7 @@ static inline int copy_fpregs_to_fpstate(struct fpu *fpu)
 {
 	if (likely(use_xsave())) {
 		copy_xregs_to_kernel(&fpu->state.xsave);
+		update_avx512_state(fpu);
 		return 1;
 	}
 
diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 202c53918ecf..313b134d3ca3 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -302,6 +302,14 @@ struct fpu {
 	 */
 	unsigned char			initialized;
 
+	/*
+	 * @avx512_usage:
+	 *
+	 * Records the usage of AVX512 registers. A value of non-zero is used
+	 * to indicate whether these AVX512 registers recently had valid state.
+	 */
+	unsigned char			avx512_usage;
+
 	/*
 	 * @state:
 	 *
-- 
2.17.1

