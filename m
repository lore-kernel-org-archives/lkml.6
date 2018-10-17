Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08201ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F1821476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F1821476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbeJRC3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:29:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:29659 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728348AbeJRC3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:29:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 11:32:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,393,1534834800"; 
   d="scan'208";a="82003907"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by orsmga007.jf.intel.com with ESMTP; 17 Oct 2018 11:32:58 -0700
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
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
        x86@kernel.org
Subject: [Patch v3 08/13] x86/speculation: Rename SSBD update functions
Date:   Wed, 17 Oct 2018 10:59:36 -0700
Message-Id: <831010fc27a9009ce3c00d86d1647d499278da66.1539798901.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1539798901.git.tim.c.chen@linux.intel.com>
References: <cover.1539798901.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1539798901.git.tim.c.chen@linux.intel.com>
References: <cover.1539798901.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a clean up patch that doesn't change any
functionality.  We rename intel_set_ssb_state to
spec_ctrl_update_msr, speculative_store_bypass_update to
speculation_ctrl_update and speculative_store_bypass_update_current to
speculation_ctrl_update_current.  This prepares us to update
of other bits in the SPEC_CTRL MSR dynamically.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 arch/x86/include/asm/spec-ctrl.h |  6 +++---
 arch/x86/kernel/cpu/bugs.c       |  4 ++--
 arch/x86/kernel/process.c        | 12 ++++++------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/spec-ctrl.h b/arch/x86/include/asm/spec-ctrl.h
index ae7c2c5..8e2f841 100644
--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -70,11 +70,11 @@ extern void speculative_store_bypass_ht_init(void);
 static inline void speculative_store_bypass_ht_init(void) { }
 #endif
 
-extern void speculative_store_bypass_update(unsigned long tif);
+extern void speculation_ctrl_update(unsigned long tif);
 
-static inline void speculative_store_bypass_update_current(void)
+static inline void speculation_ctrl_update_current(void)
 {
-	speculative_store_bypass_update(current_thread_info()->flags);
+	speculation_ctrl_update(current_thread_info()->flags);
 }
 
 #endif
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 0338fa1..673d434 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -205,7 +205,7 @@ x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool setguest)
 		tif = setguest ? ssbd_spec_ctrl_to_tif(guestval) :
 				 ssbd_spec_ctrl_to_tif(hostval);
 
-		speculative_store_bypass_update(tif);
+		speculation_ctrl_update(tif);
 	}
 }
 EXPORT_SYMBOL_GPL(x86_virt_spec_ctrl);
@@ -647,7 +647,7 @@ static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
 	 * mitigation until it is next scheduled.
 	 */
 	if (task == current && update)
-		speculative_store_bypass_update_current();
+		speculation_ctrl_update_current();
 
 	return 0;
 }
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index c93fcfd..8aa4960 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -395,27 +395,27 @@ static __always_inline void amd_set_ssb_virt_state(unsigned long tifn)
 	wrmsrl(MSR_AMD64_VIRT_SPEC_CTRL, ssbd_tif_to_spec_ctrl(tifn));
 }
 
-static __always_inline void intel_set_ssb_state(unsigned long tifn)
+static __always_inline void spec_ctrl_update_msr(unsigned long tifn)
 {
 	u64 msr = x86_spec_ctrl_base | ssbd_tif_to_spec_ctrl(tifn);
 
 	wrmsrl(MSR_IA32_SPEC_CTRL, msr);
 }
 
-static __always_inline void __speculative_store_bypass_update(unsigned long tifn)
+static __always_inline void __speculation_ctrl_update(unsigned long tifn)
 {
 	if (static_cpu_has(X86_FEATURE_VIRT_SSBD))
 		amd_set_ssb_virt_state(tifn);
 	else if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD))
 		amd_set_core_ssb_state(tifn);
 	else
-		intel_set_ssb_state(tifn);
+		spec_ctrl_update_msr(tifn);
 }
 
-void speculative_store_bypass_update(unsigned long tif)
+void speculation_ctrl_update(unsigned long tif)
 {
 	preempt_disable();
-	__speculative_store_bypass_update(tif);
+	__speculation_ctrl_update(tif);
 	preempt_enable();
 }
 
@@ -452,7 +452,7 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p,
 		set_cpuid_faulting(!!(tifn & _TIF_NOCPUID));
 
 	if ((tifp ^ tifn) & _TIF_SSBD)
-		__speculative_store_bypass_update(tifn);
+		__speculation_ctrl_update(tifn);
 }
 
 /*
-- 
2.9.4

