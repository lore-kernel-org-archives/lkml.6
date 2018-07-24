Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F07C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7BA20685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7BA20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388879AbeGXWC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 18:02:28 -0400
Received: from mga05.intel.com ([192.55.52.43]:33122 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388651AbeGXWC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 18:02:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2018 13:54:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,399,1526367600"; 
   d="scan'208";a="69597167"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.52])
  by orsmga003.jf.intel.com with ESMTP; 24 Jul 2018 13:54:10 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Sai Praneeth <sai.praneeth.prakhya@intel.com>,
        Tim C Chen <tim.c.chen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] x86/speculation: Support Enhanced IBRS on future CPUs
Date:   Tue, 24 Jul 2018 13:53:56 -0700
Message-Id: <1532465636-25240-1-git-send-email-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth <sai.praneeth.prakhya@intel.com>

Some future Intel processors may support "Enhanced IBRS" which is an
"always on" mode i.e. IBRS bit in SPEC_CTRL MSR is enabled once and
never disabled. According to specification[1], this should simplify
software enabling and improve performance.

[With enhanced IBRS, the predicted targets of indirect branches executed
cannot be controlled by software that was executed in a less privileged
predictor mode or on another logical processor. As a result, software
operating on a processor with enhanced IBRS need not use WRMSR to set
IA32_SPEC_CTRL.IBRS after every transition to a more privileged
predictor mode. Software can isolate predictor modes effectively simply
by setting the bit once. Software need not disable enhanced IBRS prior
to entering a sleep state such as MWAIT or HLT.] - Specification

Even with enhanced IBRS, we still need to make sure that IBRS bit in
SPEC_CTRL MSR is always set i.e. while booting, if we detect support for
Enhanced IBRS, we enable IBRS bit in SPEC_CTRL MSR and we should also
make sure that it remains set always. In other words, if the guest has
cleared IBRS bit, upon VMEXIT the bit should still be set.

Fortunately, kernel already has the infrastructure ready. kvm/vmx.c does
x86_spec_ctrl_set_guest() before entering guest and
x86_spec_ctrl_restore_host() after leaving guest. So, the guest view of
SPEC_CTRL MSR is restored before entering guest and the host view of
SPEC_CTRL MSR is restored before entering host and hence IBRS will be
set after VMEXIT.

For Intel CPUs that support Enhanced IBRS, this patch also makes
Enhanced IBRS as the default Spectre V2 mitigation technique instead of
retpoline. Also, we still need IBPB even with enhanced IBRS.

[1] https://software.intel.com/sites/default/files/managed/c5/63/336996-Speculative-Execution-Side-Channel-Mitigations.pdf

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Originally-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: Tim C Chen <tim.c.chen@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/cpufeatures.h   |  1 +
 arch/x86/include/asm/nospec-branch.h |  2 +-
 arch/x86/kernel/cpu/bugs.c           | 29 +++++++++++++++++++++++++++--
 arch/x86/kernel/cpu/common.c         |  3 +++
 4 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 5701f5cecd31..f75815b1dbee 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -219,6 +219,7 @@
 #define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD family 0x17 (Zen) */
+#define X86_FEATURE_IBRS_ENHANCED		( 7*32+29) /* "ibrs_enhanced" Use Enhanced IBRS in kernel */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index f6f6c63da62f..fd2a8c1b88bc 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -214,7 +214,7 @@ enum spectre_v2_mitigation {
 	SPECTRE_V2_RETPOLINE_MINIMAL_AMD,
 	SPECTRE_V2_RETPOLINE_GENERIC,
 	SPECTRE_V2_RETPOLINE_AMD,
-	SPECTRE_V2_IBRS,
+	SPECTRE_V2_IBRS_ENHANCED,
 };
 
 /* The Speculative Store Bypass disable variants */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 5c0ea39311fe..a66517de1301 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -130,6 +130,7 @@ static const char *spectre_v2_strings[] = {
 	[SPECTRE_V2_RETPOLINE_MINIMAL_AMD]	= "Vulnerable: Minimal AMD ASM retpoline",
 	[SPECTRE_V2_RETPOLINE_GENERIC]		= "Mitigation: Full generic retpoline",
 	[SPECTRE_V2_RETPOLINE_AMD]		= "Mitigation: Full AMD retpoline",
+	[SPECTRE_V2_IBRS_ENHANCED]		= "Mitigation: Enhanced IBRS",
 };
 
 #undef pr_fmt
@@ -349,6 +350,8 @@ static void __init spectre_v2_select_mitigation(void)
 
 	case SPECTRE_V2_CMD_FORCE:
 	case SPECTRE_V2_CMD_AUTO:
+		if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED))
+			goto skip_retpoline_enable_ibrs;
 		if (IS_ENABLED(CONFIG_RETPOLINE))
 			goto retpoline_auto;
 		break;
@@ -385,7 +388,22 @@ static void __init spectre_v2_select_mitigation(void)
 					 SPECTRE_V2_RETPOLINE_MINIMAL;
 		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
 	}
+	goto enable_other_mitigations;
 
+skip_retpoline_enable_ibrs:
+	mode = SPECTRE_V2_IBRS_ENHANCED;
+
+	/*
+	 * As we don't use IBRS in kernel, nobody should have set
+	 * SPEC_CTRL_IBRS until now. Shout loud if somebody did enable
+	 * SPEC_CTRL_IBRS before us.
+	 */
+	WARN_ON_ONCE(x86_spec_ctrl_base & SPEC_CTRL_IBRS);
+
+	/* Ensure SPEC_CTRL_IBRS is set after VMEXIT from a guest */
+	x86_spec_ctrl_base |= SPEC_CTRL_IBRS;
+
+enable_other_mitigations:
 	spectre_v2_enabled = mode;
 	pr_info("%s\n", spectre_v2_strings[mode]);
 
@@ -415,9 +433,16 @@ static void __init spectre_v2_select_mitigation(void)
 
 	/*
 	 * Retpoline means the kernel is safe because it has no indirect
-	 * branches. But firmware isn't, so use IBRS to protect that.
+	 * branches. Enhanced IBRS protects firmware too, so, enable restricted
+	 * speculation around firmware calls only when Enhanced IBRS isn't
+	 * supported.
+	 *
+	 * Use "mode" to check Enhanced IBRS instead of boot_cpu_has(), because
+	 * user might select retpoline on command line and if CPU supports
+	 * Enhanced IBRS, we might un-intentionally not enable IBRS around
+	 * firmware calls.
 	 */
-	if (boot_cpu_has(X86_FEATURE_IBRS)) {
+	if (boot_cpu_has(X86_FEATURE_IBRS) && mode != SPECTRE_V2_IBRS_ENHANCED) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBRS_FW);
 		pr_info("Enabling Restricted Speculation for firmware calls\n");
 	}
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index eb4cb3efd20e..8ed73a46511f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1005,6 +1005,9 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	   !cpu_has(c, X86_FEATURE_AMD_SSB_NO))
 		setup_force_cpu_bug(X86_BUG_SPEC_STORE_BYPASS);
 
+	if (ia32_cap & ARCH_CAP_IBRS_ALL)
+		setup_force_cpu_cap(X86_FEATURE_IBRS_ENHANCED);
+
 	if (x86_match_cpu(cpu_no_meltdown))
 		return;
 
-- 
2.7.4

