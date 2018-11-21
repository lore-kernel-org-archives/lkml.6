Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D17CC04EBB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485F3214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485F3214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeKULOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 06:14:04 -0500
Received: from mga12.intel.com ([192.55.52.136]:16659 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbeKULOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 06:14:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 16:42:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,259,1539673200"; 
   d="scan'208";a="251346823"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by orsmga004.jf.intel.com with ESMTP; 20 Nov 2018 16:42:04 -0800
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        stable@vger.kernel.org
Subject: [Patch v7 07/18] x86/speculation: Reorganize speculation control MSRs update
Date:   Tue, 20 Nov 2018 16:08:46 -0800
Message-Id: <7c2334e74794e31f01cbfec1d14bc081745436a1.1542758656.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1542758656.git.tim.c.chen@linux.intel.com>
References: <cover.1542758656.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1542758656.git.tim.c.chen@linux.intel.com>
References: <cover.1542758656.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic to detect whether there's a change in the previous
and next task's flag relevant to update speculation control
MSRs are spread out across multiple functions.

Consolidate all checks needed for updating speculation
control MSRs to __speculation_ctrl_update().

This makes it easy to pick the right speculation control MSR,
and the bits in the MSR that needs updating based on
TIF flags changes.

Originally-by: Thomas Lendacky <Thomas.Lendacky@amd.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 arch/x86/kernel/process.c | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 8aa4960..74bef48 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -397,25 +397,48 @@ static __always_inline void amd_set_ssb_virt_state(unsigned long tifn)
 
 static __always_inline void spec_ctrl_update_msr(unsigned long tifn)
 {
-	u64 msr = x86_spec_ctrl_base | ssbd_tif_to_spec_ctrl(tifn);
+	u64 msr = x86_spec_ctrl_base;
+
+	/*
+	 * If X86_FEATURE_SSBD is not set, the SSBD
+	 * bit is not to be touched.
+	 */
+	if (static_cpu_has(X86_FEATURE_SSBD))
+		msr |= ssbd_tif_to_spec_ctrl(tifn);
 
 	wrmsrl(MSR_IA32_SPEC_CTRL, msr);
 }
 
-static __always_inline void __speculation_ctrl_update(unsigned long tifn)
-{
-	if (static_cpu_has(X86_FEATURE_VIRT_SSBD))
-		amd_set_ssb_virt_state(tifn);
-	else if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD))
-		amd_set_core_ssb_state(tifn);
-	else
+/*
+ * Update the MSRs managing speculation control during context switch.
+ *
+ * tifp: previous task's thread flags
+ * tifn: next task's thread flags
+ */
+static __always_inline void __speculation_ctrl_update(unsigned long tifp,
+						      unsigned long tifn)
+{
+	bool updmsr = false;
+
+	/* If TIF_SSBD is different, select the proper mitigation method */
+	if ((tifp ^ tifn) & _TIF_SSBD) {
+		if (static_cpu_has(X86_FEATURE_VIRT_SSBD))
+			amd_set_ssb_virt_state(tifn);
+		else if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD))
+			amd_set_core_ssb_state(tifn);
+		else if (static_cpu_has(X86_FEATURE_SSBD))
+			updmsr  = true;
+	}
+
+	if (updmsr)
 		spec_ctrl_update_msr(tifn);
 }
 
 void speculation_ctrl_update(unsigned long tif)
 {
+	/* Forced update. Make sure all relevant TIF flags are different */
 	preempt_disable();
-	__speculation_ctrl_update(tif);
+	__speculation_ctrl_update(~tif, tif);
 	preempt_enable();
 }
 
@@ -451,8 +474,7 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p,
 	if ((tifp ^ tifn) & _TIF_NOCPUID)
 		set_cpuid_faulting(!!(tifn & _TIF_NOCPUID));
 
-	if ((tifp ^ tifn) & _TIF_SSBD)
-		__speculation_ctrl_update(tifn);
+	__speculation_ctrl_update(tifp, tifn);
 }
 
 /*
-- 
2.9.4

