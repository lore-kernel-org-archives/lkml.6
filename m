Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6321FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36123214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeLRCa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 21:30:28 -0500
Received: from mga17.intel.com ([192.55.52.151]:35298 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbeLRCa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 21:30:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2018 18:30:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,367,1539673200"; 
   d="scan'208";a="101465112"
Received: from aubrey-skl.sh.intel.com ([10.239.53.9])
  by orsmga006.jf.intel.com with ESMTP; 17 Dec 2018 18:30:25 -0800
From:   Aubrey Li <aubrey.li@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        hpa@zytor.com
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, aubrey.li@intel.com,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@linux.intel.com>
Subject: [RESEND PATCH v5 1/3] x86/fpu: track AVX-512 usage of tasks
Date:   Tue, 18 Dec 2018 03:12:07 +0800
Message-Id: <20181217191209.6494-1-aubrey.li@intel.com>
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
timestamp tracking to context switch.

Well-written AVX-512 applications are expected to clear the AVX-512
state when not actively using AVX-512 registers, so the tracking
mechanism is imprecise and can theoretically miss AVX-512 usage during
context switch. But it has been measured to be precise enough to be
useful under real-world workloads like tensorflow and linpack.

If higher precision is required, suggest user space tools to use the
PMU-based mechanisms in combination.

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
---
 arch/x86/include/asm/fpu/internal.h | 7 +++++++
 arch/x86/include/asm/fpu/types.h    | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index a38bf5a1e37a..8778ac172255 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -411,6 +411,13 @@ static inline int copy_fpregs_to_fpstate(struct fpu *fpu)
 {
 	if (likely(use_xsave())) {
 		copy_xregs_to_kernel(&fpu->state.xsave);
+
+		/*
+		 * AVX512 state is tracked here because its use is
+		 * known to slow the max clock speed of the core.
+		 */
+		if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
+			fpu->avx512_timestamp = jiffies_64;
 		return 1;
 	}
 
diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 202c53918ecf..81393dabdb46 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -302,6 +302,13 @@ struct fpu {
 	 */
 	unsigned char			initialized;
 
+	/*
+	 * @avx512_timestamp:
+	 *
+	 * Records the timestamp of AVX512 use during last context switch.
+	 */
+	u64				avx512_timestamp;
+
 	/*
 	 * @state:
 	 *
-- 
2.17.1

