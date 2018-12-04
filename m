Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFC5C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE4C2082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0yoVw8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE4C2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbeLDLFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:05:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:52598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728072AbeLDLFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:05:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7D5121508;
        Tue,  4 Dec 2018 11:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921505;
        bh=I8rmTHt47UvUXXOXpA0Cxo+8t2ED5dmX/lLFjnP86vY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J0yoVw8yvdfUJe2/IkmtMN8fWkfdgCs2boAP5mF9XDpF3wgNb6Y3f9tF7yLfklN4K
         M/9KvE1YJv4uhI2BvRnGuMvJTI6iD/f0UjMafUDHgFYBrUUINRCBQFYb8UFH0kenjx
         jWzYtWTtYRS9G+beiaLYJ2i90Pr6IIe48UQu9ZhE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.14 096/146] x86/speculation: Add command line control for indirect branch speculation
Date:   Tue,  4 Dec 2018 11:49:42 +0100
Message-Id: <20181204103730.689785907@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner tglx@linutronix.de

commit fa1202ef224391b6f5b26cdd44cc50495e8fab54 upstream

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
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Casey Schaufler <casey.schaufler@intel.com>
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Jon Masters <jcm@redhat.com>
Cc: Waiman Long <longman9394@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Dave Stewart <david.c.stewart@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20181125185005.082720373@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/kernel-parameters.txt |   32 +++++
 arch/x86/include/asm/nospec-branch.h            |   10 +
 arch/x86/kernel/cpu/bugs.c                      |  133 ++++++++++++++++++++----
 3 files changed, 156 insertions(+), 19 deletions(-)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3994,9 +3994,13 @@
 
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
 
@@ -4006,6 +4010,12 @@
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
@@ -4015,6 +4025,24 @@
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
@@ -53,6 +53,9 @@ static u64 __ro_after_init x86_spec_ctrl
 u64 __ro_after_init x86_amd_ls_cfg_base;
 u64 __ro_after_init x86_amd_ls_cfg_ssbd_mask;
 
+/* Control conditional STIPB in switch_to() */
+DEFINE_STATIC_KEY_FALSE(switch_to_cond_stibp);
+
 void __init check_bugs(void)
 {
 	identify_boot_cpu();
@@ -198,6 +201,9 @@ static void x86_amd_ssb_disable(void)
 static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
 	SPECTRE_V2_NONE;
 
+static enum spectre_v2_user_mitigation spectre_v2_user __ro_after_init =
+	SPECTRE_V2_USER_NONE;
+
 #ifdef RETPOLINE
 static bool spectre_v2_bad_module;
 
@@ -236,6 +242,104 @@ enum spectre_v2_mitigation_cmd {
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
@@ -382,12 +486,6 @@ specv2_set_mode:
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
@@ -404,23 +502,21 @@ specv2_set_mode:
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
@@ -841,10 +937,13 @@ static char *stibp_state(void)
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


