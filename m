Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E969EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D0E214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D0E214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389487AbeKVGzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:55:06 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45287 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731512AbeKVGyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:54:08 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gPYx0-0000HH-Ne; Wed, 21 Nov 2018 21:18:18 +0100
Message-Id: <20181121201723.764150349@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 21:14:45 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
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
        Kees Cook <keescook@chromium.org>
Subject: [patch 15/24] x86/speculation: Add command line control for indirect
 branch speculation
References: <20181121201430.559770965@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-speculation--Add-command-line-control-for-indirect-branch-speculation.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add command line control for application to application indirect branch
speculation mitigations.

The initial options are:

    -  on:   Unconditionally enabled
    - off:   Unconditionally disabled
    -auto:   Kernel selects mitigation (default off for now)

When the spectre_v2= command line argument is either 'on' or 'off' this
implies that the application to application control follows that state even
if when a contradicting spectre_v2_app2app= argument is supplied.

Originally-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 Documentation/admin-guide/kernel-parameters.txt |   22 +++
 arch/x86/include/asm/nospec-branch.h            |   10 +
 arch/x86/kernel/cpu/bugs.c                      |  133 ++++++++++++++++++++----
 3 files changed, 146 insertions(+), 19 deletions(-)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4213,8 +4213,10 @@
 	spectre_v2=	[X86] Control mitigation of Spectre variant 2
 			(indirect branch speculation) vulnerability.
 
-			on   - unconditionally enable
-			off  - unconditionally disable
+			on   - unconditionally enable, implies
+			       spectre_v2_app2app=on
+			off  - unconditionally disable, implies
+			       spectre_v2_app2app=off
 			auto - kernel detects whether your CPU model is
 			       vulnerable
 
@@ -4233,6 +4235,22 @@
 			Not specifying this option is equivalent to
 			spectre_v2=auto.
 
+	spectre_v2_app2app=
+			[X86] Control mitigation of Spectre variant 2
+		        application to application (indirect branch speculation)
+			vulnerability.
+
+			on      - Unconditionally enable mitigations. Is enforced
+				  by spectre_v2=on
+			off     - Unconditionally disable mitigations. Is enforced
+				  by spectre_v2=off
+			auto    - Kernel selects the mitigation depending on
+				  the available CPU features and vulnerability.
+				  Default is off.
+
+			Not specifying this option is equivalent to
+			spectre_v2_app2app=auto.
+
 	spec_store_bypass_disable=
 			[HW] Control Speculative Store Bypass (SSB) Disable mitigation
 			(Speculative Store Bypass vulnerability)
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -3,6 +3,8 @@
 #ifndef _ASM_X86_NOSPEC_BRANCH_H_
 #define _ASM_X86_NOSPEC_BRANCH_H_
 
+#include <linux/static_key.h>
+
 #include <asm/alternative.h>
 #include <asm/alternative-asm.h>
 #include <asm/cpufeatures.h>
@@ -226,6 +228,12 @@ enum spectre_v2_mitigation {
 	SPECTRE_V2_IBRS_ENHANCED,
 };
 
+/* The indirect branch speculation control variants */
+enum spectre_v2_app2app_mitigation {
+	SPECTRE_V2_APP2APP_NONE,
+	SPECTRE_V2_APP2APP_STRICT,
+};
+
 /* The Speculative Store Bypass disable variants */
 enum ssb_mitigation {
 	SPEC_STORE_BYPASS_NONE,
@@ -303,6 +311,8 @@ do {									\
 	preempt_enable();						\
 } while (0)
 
+DECLARE_STATIC_KEY_FALSE(switch_to_cond_stibp);
+
 #endif /* __ASSEMBLY__ */
 
 /*
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -54,6 +54,9 @@ static u64 __ro_after_init x86_spec_ctrl
 u64 __ro_after_init x86_amd_ls_cfg_base;
 u64 __ro_after_init x86_amd_ls_cfg_ssbd_mask;
 
+/* Control conditional STIPB in switch_to() */
+DEFINE_STATIC_KEY_FALSE(switch_to_cond_stibp);
+
 void __init check_bugs(void)
 {
 	identify_boot_cpu();
@@ -199,6 +202,9 @@ static void x86_amd_ssb_disable(void)
 static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
 	SPECTRE_V2_NONE;
 
+static enum spectre_v2_app2app_mitigation spectre_v2_app2app __ro_after_init =
+	SPECTRE_V2_APP2APP_NONE;
+
 #ifdef RETPOLINE
 static bool spectre_v2_bad_module;
 
@@ -237,6 +243,104 @@ enum spectre_v2_mitigation_cmd {
 	SPECTRE_V2_CMD_RETPOLINE_AMD,
 };
 
+enum spectre_v2_app2app_cmd {
+	SPECTRE_V2_APP2APP_CMD_NONE,
+	SPECTRE_V2_APP2APP_CMD_AUTO,
+	SPECTRE_V2_APP2APP_CMD_FORCE,
+};
+
+static const char *spectre_v2_app2app_strings[] = {
+	[SPECTRE_V2_APP2APP_NONE]	= "App-App Vulnerable",
+	[SPECTRE_V2_APP2APP_STRICT]	= "App-App Mitigation: STIBP protection",
+};
+
+static const struct {
+	const char			*option;
+	enum spectre_v2_app2app_cmd	cmd;
+	bool				secure;
+} app2app_options[] = {
+	{ "auto",	SPECTRE_V2_APP2APP_CMD_AUTO,	false },
+	{ "off",	SPECTRE_V2_APP2APP_CMD_NONE,	false },
+	{ "on",		SPECTRE_V2_APP2APP_CMD_FORCE,	true  },
+};
+
+static void __init spec_v2_app_print_cond(const char *reason, bool secure)
+{
+	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2) != secure)
+		pr_info("app2app %s selected on command line.\n", reason);
+}
+
+static enum spectre_v2_app2app_cmd __init
+spectre_v2_parse_app2app_cmdline(enum spectre_v2_mitigation_cmd v2_cmd)
+{
+	char arg[20];
+	int ret, i;
+
+	switch (v2_cmd) {
+	case SPECTRE_V2_CMD_NONE:
+		return SPECTRE_V2_APP2APP_CMD_NONE;
+	case SPECTRE_V2_CMD_FORCE:
+		return SPECTRE_V2_APP2APP_CMD_FORCE;
+	default:
+		break;
+	}
+
+	ret = cmdline_find_option(boot_command_line, "spectre_v2_app2app",
+				  arg, sizeof(arg));
+	if (ret < 0)
+		return SPECTRE_V2_APP2APP_CMD_AUTO;
+
+	for (i = 0; i < ARRAY_SIZE(app2app_options); i++) {
+		if (match_option(arg, ret, app2app_options[i].option)) {
+			spec_v2_app_print_cond(app2app_options[i].option,
+					       app2app_options[i].secure);
+			return app2app_options[i].cmd;
+		}
+	}
+
+	pr_err("Unknown app to app protection option (%s). Switching to AUTO select\n", arg);
+	return SPECTRE_V2_APP2APP_CMD_AUTO;
+}
+
+static void __init
+spectre_v2_app2app_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
+{
+	enum spectre_v2_app2app_mitigation mode = SPECTRE_V2_APP2APP_NONE;
+	bool smt_possible = IS_ENABLED(CONFIG_SMP);
+
+	if (!boot_cpu_has(X86_FEATURE_IBPB) && !boot_cpu_has(X86_FEATURE_STIBP))
+		return;
+
+	if (cpu_smt_control == CPU_SMT_FORCE_DISABLED ||
+	    cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
+		smt_possible = false;
+
+	switch (spectre_v2_parse_app2app_cmdline(v2_cmd)) {
+	case SPECTRE_V2_APP2APP_CMD_AUTO:
+	case SPECTRE_V2_APP2APP_CMD_NONE:
+		goto set_mode;
+	case SPECTRE_V2_APP2APP_CMD_FORCE:
+	       mode = SPECTRE_V2_APP2APP_STRICT;
+	       break;
+	}
+
+	/* Initialize Indirect Branch Prediction Barrier */
+	if (boot_cpu_has(X86_FEATURE_IBPB)) {
+		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
+		pr_info("Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier\n");
+	}
+
+	/* If enhanced IBRS is enabled no STIPB required */
+	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
+		return;
+
+set_mode:
+	spectre_v2_app2app = mode;
+	/* Only print the STIBP mode when SMT possible */
+	if (smt_possible)
+		pr_info("%s\n", spectre_v2_app2app_strings[mode]);
+}
+
 static const char *spectre_v2_strings[] = {
 	[SPECTRE_V2_NONE]			= "Vulnerable",
 	[SPECTRE_V2_RETPOLINE_GENERIC]		= "Mitigation: Full generic retpoline",
@@ -385,12 +489,6 @@ static void __init spectre_v2_select_mit
 	setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
 	pr_info("Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch\n");
 
-	/* Initialize Indirect Branch Prediction Barrier if supported */
-	if (boot_cpu_has(X86_FEATURE_IBPB)) {
-		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
-		pr_info("Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier\n");
-	}
-
 	/*
 	 * Retpoline means the kernel is safe because it has no indirect
 	 * branches. Enhanced IBRS protects firmware too, so, enable restricted
@@ -407,23 +505,21 @@ static void __init spectre_v2_select_mit
 		pr_info("Enabling Restricted Speculation for firmware calls\n");
 	}
 
+	/* Set up IBPB and STIBP depending on the general spectre V2 command */
+	spectre_v2_app2app_select_mitigation(cmd);
+
 	/* Enable STIBP if appropriate */
 	arch_smt_update();
 }
 
 static bool stibp_needed(void)
 {
-	if (spectre_v2_enabled == SPECTRE_V2_NONE)
-		return false;
-
 	/* Enhanced IBRS makes using STIBP unnecessary. */
 	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
 		return false;
 
-	if (!boot_cpu_has(X86_FEATURE_STIBP))
-		return false;
-
-	return true;
+	/* Check for strict app2app mitigation mode */
+	return spectre_v2_app2app == SPECTRE_V2_APP2APP_STRICT;
 }
 
 static void update_stibp_msr(void *info)
@@ -844,10 +940,13 @@ static char *stibp_state(void)
 	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
 		return "";
 
-	if (x86_spec_ctrl_base & SPEC_CTRL_STIBP)
-		return ", STIBP";
-	else
-		return "";
+	switch (spectre_v2_app2app) {
+	case SPECTRE_V2_APP2APP_NONE:
+		return ", STIBP: disabled";
+	case SPECTRE_V2_APP2APP_STRICT:
+		return ", STIBP: forced";
+	}
+	return "";
 }
 
 static char *ibpb_state(void)


