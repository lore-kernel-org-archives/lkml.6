Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E238C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F40214DE
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F40214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbeKZFtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 00:49:09 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:52823 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeKZFtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 00:49:09 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gQzat-0003RG-VI; Sun, 25 Nov 2018 19:57:24 +0100
Message-Id: <20181125185005.082720373@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 25 Nov 2018 19:33:45 +0100
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
        Tim Chen <tim.c.chen@linux.intel.com>,
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
Subject: [patch V2 17/28] x86/speculation: Add command line control for
 indirect branch speculation
References: <20181125183328.318175777@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-speculation-Add-command-line-control-for-indirect-branch-speculation.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add command line control for user space indirect branch speculation
mitigations. The new option is: spectre_v2_user=

The initial options are:

    -  on:   Unconditionally enabled
    - off:   Unconditionally disabled
    -auto:   Kernel selects mitigation (default off for now)

When the spectre_v2= command line argument is either 'on' or 'off' this
implies that the application to application control follows that state even
if a contradicting spectre_v2_user= argument is supplied.

Originally-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V1 -> V2: Change the option to spectre_v2_user=
---
 Documentation/admin-guide/kernel-parameters.txt |   32 +++++
 arch/x86/include/asm/nospec-branch.h            |   10 +
 arch/x86/kernel/cpu/bugs.c                      |  133 ++++++++++++++++++++----
 3 files changed, 156 insertions(+), 19 deletions(-)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4194,9 +4194,13 @@
 
 	spectre_v2=	[X86] Control mitigation of Spectre variant 2
 			(indirect branch speculation) vulnerability.
+			The default operation protects the kernel from
+			user space attacks.
 
-			on   - unconditionally enable
-			off  - unconditionally disable
+			on   - unconditionally enable, implies
+			       spectre_v2_user=on
+			off  - unconditionally disable, implies
+			       spectre_v2_user=off
 			auto - kernel detects whether your CPU model is
 			       vulnerable
 
@@ -4206,6 +4210,12 @@
 			CONFIG_RETPOLINE configuration option, and the
 			compiler with which the kernel was built.
 
+			Selecting 'on' will also enable the mitigation
+			against user space to user space task attacks.
+
+			Selecting 'off' will disable both the kernel and
+			the user space protections.
+
 			Specific mitigations can also be selected manually:
 
 			retpoline	  - replace indirect branches
@@ -4215,6 +4225,24 @@
 			Not specifying this option is equivalent to
 			spectre_v2=auto.
 
+	spectre_v2_user=
+			[X86] Control mitigation of Spectre variant 2
+		        (indirect branch speculation) vulnerability between
+		        user space tasks
+
+			on	- Unconditionally enable mitigations. Is
+				  enforced by spectre_v2=on
+
+			off     - Unconditionally disable mitigations. Is
+				  enforced by spectre_v2=off
+
+			auto    - Kernel selects the mitigation depending on
+				  the available CPU features and vulnerability.
+				  Default is off.
+
+			Not specifying this option is equivalent to
+			spectre_v2_user=auto.
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
+enum spectre_v2_user_mitigation {
+	SPECTRE_V2_USER_NONE,
+	SPECTRE_V2_USER_STRICT,
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
 
+static enum spectre_v2_user_mitigation spectre_v2_user __ro_after_init =
+	SPECTRE_V2_USER_NONE;
+
 #ifdef RETPOLINE
 static bool spectre_v2_bad_module;
 
@@ -237,6 +243,104 @@ enum spectre_v2_mitigation_cmd {
 	SPECTRE_V2_CMD_RETPOLINE_AMD,
 };
 
+enum spectre_v2_user_cmd {
+	SPECTRE_V2_USER_CMD_NONE,
+	SPECTRE_V2_USER_CMD_AUTO,
+	SPECTRE_V2_USER_CMD_FORCE,
+};
+
+static const char * const spectre_v2_user_strings[] = {
+	[SPECTRE_V2_USER_NONE]		= "User space: Vulnerable",
+	[SPECTRE_V2_USER_STRICT]	= "User space: Mitigation: STIBP protection",
+};
+
+static const struct {
+	const char			*option;
+	enum spectre_v2_user_cmd	cmd;
+	bool				secure;
+} v2_user_options[] __initdata = {
+	{ "auto",	SPECTRE_V2_USER_CMD_AUTO,	false },
+	{ "off",	SPECTRE_V2_USER_CMD_NONE,	false },
+	{ "on",		SPECTRE_V2_USER_CMD_FORCE,	true  },
+};
+
+static void __init spec_v2_user_print_cond(const char *reason, bool secure)
+{
+	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2) != secure)
+		pr_info("spectre_v2_user=%s forced on command line.\n", reason);
+}
+
+static enum spectre_v2_user_cmd __init
+spectre_v2_parse_user_cmdline(enum spectre_v2_mitigation_cmd v2_cmd)
+{
+	char arg[20];
+	int ret, i;
+
+	switch (v2_cmd) {
+	case SPECTRE_V2_CMD_NONE:
+		return SPECTRE_V2_USER_CMD_NONE;
+	case SPECTRE_V2_CMD_FORCE:
+		return SPECTRE_V2_USER_CMD_FORCE;
+	default:
+		break;
+	}
+
+	ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
+				  arg, sizeof(arg));
+	if (ret < 0)
+		return SPECTRE_V2_USER_CMD_AUTO;
+
+	for (i = 0; i < ARRAY_SIZE(v2_user_options); i++) {
+		if (match_option(arg, ret, v2_user_options[i].option)) {
+			spec_v2_user_print_cond(v2_user_options[i].option,
+						v2_user_options[i].secure);
+			return v2_user_options[i].cmd;
+		}
+	}
+
+	pr_err("Unknown user space protection option (%s). Switching to AUTO select\n", arg);
+	return SPECTRE_V2_USER_CMD_AUTO;
+}
+
+static void __init
+spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
+{
+	enum spectre_v2_user_mitigation mode = SPECTRE_V2_USER_NONE;
+	bool smt_possible = IS_ENABLED(CONFIG_SMP);
+
+	if (!boot_cpu_has(X86_FEATURE_IBPB) && !boot_cpu_has(X86_FEATURE_STIBP))
+		return;
+
+	if (cpu_smt_control == CPU_SMT_FORCE_DISABLED ||
+	    cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
+		smt_possible = false;
+
+	switch (spectre_v2_parse_user_cmdline(v2_cmd)) {
+	case SPECTRE_V2_USER_CMD_AUTO:
+	case SPECTRE_V2_USER_CMD_NONE:
+		goto set_mode;
+	case SPECTRE_V2_USER_CMD_FORCE:
+		mode = SPECTRE_V2_USER_STRICT;
+		break;
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
+	spectre_v2_user = mode;
+	/* Only print the STIBP mode when SMT possible */
+	if (smt_possible)
+		pr_info("%s\n", spectre_v2_user_strings[mode]);
+}
+
 static const char * const spectre_v2_strings[] = {
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
+	spectre_v2_user_select_mitigation(cmd);
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
+	/* Check for strict user mitigation mode */
+	return spectre_v2_user == SPECTRE_V2_USER_STRICT;
 }
 
 static void update_stibp_msr(void *info)
@@ -844,10 +940,13 @@ static char *stibp_state(void)
 	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
 		return "";
 
-	if (x86_spec_ctrl_base & SPEC_CTRL_STIBP)
-		return ", STIBP";
-	else
-		return "";
+	switch (spectre_v2_user) {
+	case SPECTRE_V2_USER_NONE:
+		return ", STIBP: disabled";
+	case SPECTRE_V2_USER_STRICT:
+		return ", STIBP: forced";
+	}
+	return "";
 }
 
 static char *ibpb_state(void)


