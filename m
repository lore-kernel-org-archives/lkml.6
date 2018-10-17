Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86711ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E24214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E24214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeJRC35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:29:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:29659 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728348AbeJRC35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:29:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 11:33:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,393,1534834800"; 
   d="scan'208";a="82003920"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by orsmga007.jf.intel.com with ESMTP; 17 Oct 2018 11:33:00 -0700
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
Subject: [Patch v3 11/13] x86/speculation: Add Spectre v2 lite app to app protection mode
Date:   Wed, 17 Oct 2018 10:59:39 -0700
Message-Id: <a03fbbc07890ef40efece08680c597faea2a1d26.1539798901.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1539798901.git.tim.c.chen@linux.intel.com>
References: <cover.1539798901.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1539798901.git.tim.c.chen@linux.intel.com>
References: <cover.1539798901.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the STIBP is always turned on for CPUs vulnerable to Spectre V2.
A new lite protection mode option is created.  In this new mode, we protect
security sensitive processes with STIBP and IBPB against application to
application attack based on its process property or security level. This
will allow non security sensitive processes not needing the protection
avoid overhead associated with STIBP and IBPB.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  18 ++++
 arch/x86/include/asm/nospec-branch.h            |   7 ++
 arch/x86/kernel/cpu/bugs.c                      | 135 ++++++++++++++++++++++--
 arch/x86/mm/tlb.c                               |  19 +++-
 4 files changed, 166 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 64a3bf5..2feb6b2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4186,6 +4186,24 @@
 			Not specifying this option is equivalent to
 			spectre_v2=auto.
 
+	spectre_v2_app2app=
+			[X86] Control mitigation of Spectre variant 2
+		        application to application (indirect branch speculation)
+			vulnerability.
+
+			off    - turn off Spectre v2 application to
+				 application attack mitigation
+			lite   - turn on mitigation for non-dumpable
+				 processes (i.e. protect daemons and other
+				 privileged processes that tend to be
+				 non-dumpable).
+			strict - protect against attacks for all user processes
+			auto   - let kernel decide lite or strict mode
+
+			Not specifying this option is equivalent to
+			spectre_v2_app2app=auto.  Setting spectre_v2=off will 
+			also turn off this mitigation.
+
 	spec_store_bypass_disable=
 			[HW] Control Speculative Store Bypass (SSB) Disable mitigation
 			(Speculative Store Bypass vulnerability)
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index d57e84e..ad1c141 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -218,6 +218,12 @@ enum spectre_v2_mitigation {
 	SPECTRE_V2_IBRS_ENHANCED,
 };
 
+enum spectre_v2_app2app_mitigation {
+	SPECTRE_V2_APP2APP_NONE,
+	SPECTRE_V2_APP2APP_LITE,
+	SPECTRE_V2_APP2APP_STRICT,
+};
+
 /* The Speculative Store Bypass disable variants */
 enum ssb_mitigation {
 	SPEC_STORE_BYPASS_NONE,
@@ -229,6 +235,7 @@ enum ssb_mitigation {
 extern char __indirect_thunk_start[];
 extern char __indirect_thunk_end[];
 
+DECLARE_STATIC_KEY_FALSE(spectre_v2_app_lite);
 DECLARE_STATIC_KEY_FALSE(spectre_v2_enhanced_ibrs);
 
 /*
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 673d434..1d317f2 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -133,6 +133,13 @@ enum spectre_v2_mitigation_cmd {
 	SPECTRE_V2_CMD_RETPOLINE_AMD,
 };
 
+enum spectre_v2_app2app_mitigation_cmd {
+	SPECTRE_V2_APP2APP_CMD_NONE,
+	SPECTRE_V2_APP2APP_CMD_AUTO,
+	SPECTRE_V2_APP2APP_CMD_LITE,
+	SPECTRE_V2_APP2APP_CMD_STRICT,
+};
+
 static const char *spectre_v2_strings[] = {
 	[SPECTRE_V2_NONE]			= "Vulnerable",
 	[SPECTRE_V2_RETPOLINE_MINIMAL]		= "Vulnerable: Minimal generic ASM retpoline",
@@ -142,6 +149,17 @@ static const char *spectre_v2_strings[] = {
 	[SPECTRE_V2_IBRS_ENHANCED]		= "Mitigation: Enhanced IBRS",
 };
 
+static const char *spectre_v2_app2app_strings[] = {
+	[SPECTRE_V2_APP2APP_NONE]   = "App-App Vulnerable",
+	[SPECTRE_V2_APP2APP_LITE]   = "App-App Mitigation: Protect non-dumpable"
+				      " and indirect branch restricted process",
+	[SPECTRE_V2_APP2APP_STRICT] = "App-App Mitigation: Full app to app"
+				      " attack protection",
+};
+
+DEFINE_STATIC_KEY_FALSE(spectre_v2_app_lite);
+EXPORT_SYMBOL(spectre_v2_app_lite);
+
 DEFINE_STATIC_KEY_FALSE(spectre_v2_enhanced_ibrs);
 EXPORT_SYMBOL(spectre_v2_enhanced_ibrs);
 
@@ -151,6 +169,9 @@ EXPORT_SYMBOL(spectre_v2_enhanced_ibrs);
 static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
 	SPECTRE_V2_NONE;
 
+static enum spectre_v2_app2app_mitigation
+	spectre_v2_app2app_enabled __ro_after_init = SPECTRE_V2_APP2APP_NONE;
+
 void
 x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool setguest)
 {
@@ -172,6 +193,9 @@ x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool setguest)
 		    static_cpu_has(X86_FEATURE_AMD_SSBD))
 			hostval |= ssbd_tif_to_spec_ctrl(ti->flags);
 
+		if (static_branch_unlikely(&spectre_v2_app_lite))
+			hostval |= stibp_tif_to_spec_ctrl(ti->flags);
+
 		if (hostval != guestval) {
 			msrval = setguest ? guestval : hostval;
 			wrmsrl(MSR_IA32_SPEC_CTRL, msrval);
@@ -278,6 +302,52 @@ static const struct {
 	{ "auto",              SPECTRE_V2_CMD_AUTO,              false },
 };
 
+static const struct {
+	const char *option;
+	enum spectre_v2_app2app_mitigation_cmd cmd;
+	bool secure;
+} app2app_mitigation_options[] = {
+	{ "off",	SPECTRE_V2_APP2APP_CMD_NONE,   false },
+	{ "lite",	SPECTRE_V2_APP2APP_CMD_LITE,   false },
+	{ "strict",	SPECTRE_V2_APP2APP_CMD_STRICT, false },
+	{ "auto",	SPECTRE_V2_APP2APP_CMD_AUTO,   false },
+};
+
+static enum spectre_v2_app2app_mitigation_cmd __init
+		spectre_v2_parse_app2app_cmdline(void)
+{
+	enum spectre_v2_app2app_mitigation_cmd cmd;
+	char arg[20];
+	int ret, i;
+
+	cmd = SPECTRE_V2_APP2APP_CMD_AUTO;
+	ret = cmdline_find_option(boot_command_line, "spectre_v2_app2app",
+					arg, sizeof(arg));
+	if (ret < 0)
+		return SPECTRE_V2_APP2APP_CMD_AUTO;
+
+	for (i = 0; i < ARRAY_SIZE(app2app_mitigation_options); i++) {
+		if (!match_option(arg, ret,
+				  app2app_mitigation_options[i].option))
+			continue;
+		cmd = app2app_mitigation_options[i].cmd;
+		break;
+	}
+
+	if (i >= ARRAY_SIZE(app2app_mitigation_options)) {
+		pr_err("unknown app to app protection option (%s). "
+		       "Switching to AUTO select\n", arg);
+		return SPECTRE_V2_APP2APP_CMD_AUTO;
+	}
+
+	if (app2app_mitigation_options[i].secure)
+		spec2_print_if_secure(app2app_mitigation_options[i].option);
+	else
+		spec2_print_if_insecure(app2app_mitigation_options[i].option);
+
+	return cmd;
+}
+
 static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 {
 	char arg[20];
@@ -330,14 +400,22 @@ static bool stibp_needed(void)
 	/*
 	 * Determine if we want to leave STIBP always on.
 	 * Using enhanced IBRS makes using STIBP unnecessary.
+	 * For lite option, we enable STIBP based on a process's
+	 * flag during context switch.
 	 */
 
 	if (static_branch_unlikely(&spectre_v2_enhanced_ibrs))
 		return false;
 
+	if (static_branch_unlikely(&spectre_v2_app_lite))
+		return false;
+
 	if (spectre_v2_enabled == SPECTRE_V2_NONE)
 		return false;
 
+	if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_NONE)
+		return false;
+
 	if (!boot_cpu_has(X86_FEATURE_STIBP))
 		return false;
 
@@ -377,7 +455,11 @@ static void __init spectre_v2_select_mitigation(void)
 {
 	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
 	enum spectre_v2_mitigation mode = SPECTRE_V2_NONE;
+	enum spectre_v2_app2app_mitigation_cmd app2app_cmd;
+	enum spectre_v2_app2app_mitigation app2app_mode;
 
+	app2app_cmd = spectre_v2_parse_app2app_cmdline();
+	app2app_mode = SPECTRE_V2_APP2APP_NONE;
 	/*
 	 * If the CPU is not affected and the command line mode is NONE or AUTO
 	 * then nothing to do.
@@ -398,7 +480,7 @@ static void __init spectre_v2_select_mitigation(void)
 			x86_spec_ctrl_base |= SPEC_CTRL_IBRS;
 			wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
 			static_branch_enable(&spectre_v2_enhanced_ibrs);
-			goto specv2_set_mode;
+			goto specv2_app_set_mode;
 		}
 		if (IS_ENABLED(CONFIG_RETPOLINE))
 			goto retpoline_auto;
@@ -437,7 +519,31 @@ static void __init spectre_v2_select_mitigation(void)
 		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
 	}
 
+specv2_app_set_mode:
+	if (!boot_cpu_has(X86_FEATURE_IBPB) ||
+	    !boot_cpu_has(X86_FEATURE_STIBP))
+		goto specv2_set_mode;	
+
+	switch (app2app_cmd) {
+	case SPECTRE_V2_APP2APP_CMD_NONE:
+		break;	
+
+	case SPECTRE_V2_APP2APP_CMD_LITE:
+	case SPECTRE_V2_APP2APP_CMD_AUTO:
+		app2app_mode = SPECTRE_V2_APP2APP_LITE;
+		break;
+
+	case SPECTRE_V2_APP2APP_CMD_STRICT:
+		app2app_mode = SPECTRE_V2_APP2APP_STRICT;
+		break;
+	}
+
 specv2_set_mode:
+	spectre_v2_app2app_enabled = app2app_mode;
+	pr_info("%s\n", spectre_v2_app2app_strings[app2app_mode]);
+	if (app2app_mode == SPECTRE_V2_APP2APP_LITE)
+		static_branch_enable(&spectre_v2_app_lite);
+
 	spectre_v2_enabled = mode;
 	pr_info("%s\n", spectre_v2_strings[mode]);
 
@@ -452,8 +558,12 @@ static void __init spectre_v2_select_mitigation(void)
 	setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
 	pr_info("Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch\n");
 
-	/* Initialize Indirect Branch Prediction Barrier if supported */
-	if (boot_cpu_has(X86_FEATURE_IBPB)) {
+	/*
+	 * Initialize Indirect Branch Prediction Barrier if supported
+	 * and not disabled
+	 */
+	if (boot_cpu_has(X86_FEATURE_IBPB) && 
+	    app2app_mode != SPECTRE_V2_APP2APP_NONE) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
 		pr_info("Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier\n");
 	}
@@ -883,16 +993,23 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 		return sprintf(buf, "Mitigation: __user pointer sanitization\n");
 
 	case X86_BUG_SPECTRE_V2:
-		return sprintf(buf, "%s%s%s%s%s%s\n",
+		return sprintf(buf, "%s%s%s%s%s%s%s\n",
 			spectre_v2_strings[spectre_v2_enabled],
-			boot_cpu_has(X86_FEATURE_USE_IBPB) ?
-				   ", IBPB" : "",
+			spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_NONE ||
+			    !boot_cpu_has(X86_FEATURE_USE_IBPB) ?
+				   "" :
+			    spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_LITE ?
+				   ", IBPB-lite" : ", IBPB-strict",
+			spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_NONE ||
+		            spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED ||
+			    !boot_cpu_has(X86_FEATURE_STIBP) ?
+				   "" :
+			    spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_LITE ?
+				   ", STIBP-lite" : ", STIBP-strict",
 			boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ?
 				   ", IBRS_FW" : "",
 			spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED ?
-				   ", Enhanced IBRS" :
-			    (x86_spec_ctrl_base & SPEC_CTRL_STIBP) ?
-				   ", STIBP" : "",
+				   ", Enhanced IBRS" : "",
 			boot_cpu_has(X86_FEATURE_RSB_CTXSW) ?
 				   ", RSB filling" : "",
 			spectre_v2_module_string());
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 073b8df..1bd1597 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -184,14 +184,25 @@ static void sync_current_stack_to_mm(struct mm_struct *mm)
 static bool ibpb_needed(struct task_struct *tsk, u64 last_ctx_id)
 {
 	/*
-	 * Check if the current (previous) task has access to the memory
-	 * of the @tsk (next) task. If access is denied, make sure to
+	 * For lite protection mode, we protect processes  
+	 * marked with STIBP flag needing app to app proection.
+	 *
+	 * Otherwise check if the current (previous) task has access to the
+	 * the memory of the @tsk (next) task for strict app to app protection.
+	 * If access is denied, make sure to
 	 * issue a IBPB to stop user->user Spectre-v2 attacks.
 	 *
 	 * Note: __ptrace_may_access() returns 0 or -ERRNO.
 	 */
-	return (tsk && tsk->mm && tsk->mm->context.ctx_id != last_ctx_id &&
-		ptrace_may_access_sched(tsk, PTRACE_MODE_SPEC_IBPB));
+
+	/* skip IBPB if no context changes */
+	if (!tsk || !tsk->mm || tsk->mm->context.ctx_id == last_ctx_id)
+		return false;
+
+	if (static_branch_unlikely(&spectre_v2_app_lite))
+		return task_thread_info(tsk)->flags & _TIF_STIBP;
+	else
+		return ptrace_may_access_sched(tsk, PTRACE_MODE_SPEC_IBPB);
 }
 
 void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
-- 
2.9.4

