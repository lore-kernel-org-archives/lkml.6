Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EDCC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D923D2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D923D2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeIZH3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 03:29:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:52990 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbeIZH3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 03:29:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 18:18:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,304,1534834800"; 
   d="scan'208";a="72890396"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by fmsmga007.fm.intel.com with ESMTP; 25 Sep 2018 18:17:19 -0700
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Thomas Lendacky <Thomas.Lendacky@amd.com>,
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
        Jon Masters <jcm@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Tim Chen <tim.c.chen@linux.intel.com>
Subject: [Patch v2 3/4] x86/speculation: Extend per process STIBP to AMD cpus.
Date:   Tue, 25 Sep 2018 17:43:58 -0700
Message-Id: <705b51cba5b5e7805aeb08af7f7d21e6ec897a17.1537920575.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1537920575.git.tim.c.chen@linux.intel.com>
References: <cover.1537920575.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1537920575.git.tim.c.chen@linux.intel.com>
References: <cover.1537920575.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Lendacky <Thomas.Lendacky@amd.com>

We extend the app to app spectre v2 mitigation using STIBP
to the AMD cpus. We need to take care of special
cases for AMD cpu's update of SPEC_CTRL MSR to avoid double
writing of MSRs from update to SSBD and STIBP.

Originally-by: Thomas Lendacky <Thomas.Lendacky@amd.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 arch/x86/kernel/process.c | 48 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index cb24014..4a3a672 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -399,6 +399,10 @@ static __always_inline void set_spec_ctrl_state(unsigned long tifn)
 {
 	u64 msr = x86_spec_ctrl_base;
 
+	/*
+	 * AMD cpu may have used a different method to update SSBD, so
+	 * we need to be sure we are using the SPEC_CTRL MSR for SSBD.
+	 */
 	if (static_cpu_has(X86_FEATURE_SSBD))
 		msr |= ssbd_tif_to_spec_ctrl(tifn);
 
@@ -408,20 +412,45 @@ static __always_inline void set_spec_ctrl_state(unsigned long tifn)
 	wrmsrl(MSR_IA32_SPEC_CTRL, msr);
 }
 
-static __always_inline void __speculative_store_bypass_update(unsigned long tifn)
+static __always_inline void __speculative_store_bypass_update(unsigned long tifp,
+							      unsigned long tifn)
 {
-	if (static_cpu_has(X86_FEATURE_VIRT_SSBD))
-		amd_set_ssb_virt_state(tifn);
-	else if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD))
-		amd_set_core_ssb_state(tifn);
-	else
-		set_spec_ctrl_state(tifn);
+	bool stibp = !!((tifp ^ tifn) & _TIF_STIBP);
+	bool ssbd = !!((tifp ^ tifn) & _TIF_SSBD);
+
+	if (!ssbd && !stibp)
+		return;
+
+	if (ssbd) {
+		/*
+		 * For AMD, try these methods first.  The ssbd variable will
+		 * reflect if the SPEC_CTRL MSR method is needed.
+		 */
+		ssbd = false;
+
+		if (static_cpu_has(X86_FEATURE_VIRT_SSBD))
+			amd_set_ssb_virt_state(tifn);
+		else if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD))
+			amd_set_core_ssb_state(tifn);
+		else
+			ssbd = true;
+	}
+
+	/* Avoid a possible extra MSR write, recheck the flags */
+	if (!ssbd && !stibp)
+		return;
+
+	set_spec_ctrl_state(tifn);
 }
 
 void speculative_store_bypass_update(unsigned long tif)
 {
+	/*
+	 * On this path we're forcing the update, so use ~tif as the
+	 * previous flags.
+	 */
 	preempt_disable();
-	__speculative_store_bypass_update(tif);
+	__speculative_store_bypass_update(~tif, tif);
 	preempt_enable();
 }
 
@@ -457,8 +486,7 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p,
 	if ((tifp ^ tifn) & _TIF_NOCPUID)
 		set_cpuid_faulting(!!(tifn & _TIF_NOCPUID));
 
-	if ((tifp ^ tifn) & (_TIF_SSBD | _TIF_STIBP))
-		__speculative_store_bypass_update(tifn);
+	__speculative_store_bypass_update(tifp, tifn);
 }
 
 /*
-- 
2.9.4

