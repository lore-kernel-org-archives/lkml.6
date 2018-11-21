Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0ED9C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83AA92146D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83AA92146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeKULOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 06:14:43 -0500
Received: from mga12.intel.com ([192.55.52.136]:16659 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbeKULOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 06:14:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 16:42:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,259,1539673200"; 
   d="scan'208";a="251346837"
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
Subject: [Patch v7 11/18] x86/speculation: Add Spectre v2 app to app protection modes
Date:   Tue, 20 Nov 2018 16:08:50 -0800
Message-Id: <ca44643285979f27b1f60c8719ee15f5307ca313.1542758656.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1542758656.git.tim.c.chen@linux.intel.com>
References: <cover.1542758656.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1542758656.git.tim.c.chen@linux.intel.com>
References: <cover.1542758656.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new protection modes for Spectre v2 mitigations against
Spectre v2 attacks on user processes.  There are three modes:

	none mode:
	In this mode, no mitigations are deployed.

	strict mode:
	In this mode, IBPB and STIBP are deployed on
	on all tasks.

	prctl mode:
	In this mode, IBPB and STIBP are only deployed on
	tasks that choose to restrict indirect branch speculation via
	prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIR_BRANCH, PR_SPEC_ENABLE, 0, 0);

The protection mode can be specified by the spectre_v2_app2app
boot parameter with the following semantics:

spectre_v2_app2app=
	on     - Unconditionally enable mitigations for all tasks.
	off    - Unconditionally disable mitigations for all tasks.
	auto   - Kernel detects whether the CPU model has IBPB
		 and STIBP mitigations against Spectre V2 attacks.
		 If the CPU is not vulnerable, "off" is selected.
		 If the CPU is vulnerable, the default mitigation
		 is "prctl". See below.
	prctl  - Enable mitigations per thread by restricting
		 indirect branch speculation via prctl.
		 Mitigation for a thread is not enabled by default to
		 avoid mitigation overhead. The state of
		 of the control is inherited on fork.

	Not specifying this option is equivalent to
	spectre_v2_app2app=auto.

	Setting spectre_v2=off implies spectre_v2_app2app=off and
	spectre_v2_app2app boot parameter is ignored.

	Setting spectre_v2=on implies spectre_v2_app2app=on and
	spectre_v2_app2app boot parameter is ignored.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  28 +++++
 arch/x86/include/asm/nospec-branch.h            |   9 ++
 arch/x86/kernel/cpu/bugs.c                      | 135 ++++++++++++++++++++++--
 3 files changed, 166 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 81d1d5a..d2255f7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4215,6 +4215,34 @@
 			Not specifying this option is equivalent to
 			spectre_v2=auto.
 
+	spectre_v2_app2app=
+			[X86] Control mitigation of Spectre variant 2
+		        userspace vulnerability due to indirect branch speculation.
+
+			The options are:
+
+			on      - Unconditionally enable mitigations for all tasks.
+			off     - Unconditionally disable mitigations for all tasks.
+			auto    - Kernel detects whether the CPU model has IBPB
+				  and STIBP mitigations against Spectre V2 attacks.
+				  If the CPU is not vulnerable, "off" is selected.
+				  If the CPU is vulnerable, the default mitigation
+				  is "prctl".
+			prctl   - Enable mitigations per thread by restricting
+				  indirect branch speculation via prctl.
+				  Mitigation for a thread is not enabled by default to
+				  avoid mitigation overhead. The state of
+				  of the control is inherited on fork.
+
+			Not specifying this option is equivalent to
+			spectre_v2_app2app=auto.
+
+			Setting spectre_v2=off implies spectre_v2_app2app=off and
+			spectre_v2_app2app boot parameter is ignored.
+
+			Setting spectre_v2=on implies spectre_v2_app2app=on and
+			spectre_v2_app2app boot parameter is ignored.
+
 	spec_store_bypass_disable=
 			[HW] Control Speculative Store Bypass (SSB) Disable mitigation
 			(Speculative Store Bypass vulnerability)
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 80dc144..69d2657 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -3,6 +3,7 @@
 #ifndef _ASM_X86_NOSPEC_BRANCH_H_
 #define _ASM_X86_NOSPEC_BRANCH_H_
 
+#include <linux/static_key.h>
 #include <asm/alternative.h>
 #include <asm/alternative-asm.h>
 #include <asm/cpufeatures.h>
@@ -226,6 +227,12 @@ enum spectre_v2_mitigation {
 	SPECTRE_V2_IBRS_ENHANCED,
 };
 
+enum spectre_v2_app2app_mitigation {
+	SPECTRE_V2_APP2APP_NONE,
+	SPECTRE_V2_APP2APP_STRICT,
+	SPECTRE_V2_APP2APP_PRCTL,
+};
+
 /* The Speculative Store Bypass disable variants */
 enum ssb_mitigation {
 	SPEC_STORE_BYPASS_NONE,
@@ -237,6 +244,8 @@ enum ssb_mitigation {
 extern char __indirect_thunk_start[];
 extern char __indirect_thunk_end[];
 
+DECLARE_STATIC_KEY_FALSE(spectre_v2_app_lite);
+
 /*
  * On VMEXIT we must ensure that no RSB predictions learned in the guest
  * can be followed in the host, by overwriting the RSB completely. Both
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 3e5ae2c..387de54 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -133,6 +133,13 @@ enum spectre_v2_mitigation_cmd {
 	SPECTRE_V2_CMD_RETPOLINE_AMD,
 };
 
+enum spectre_v2_app2app_mitigation_cmd {
+	SPECTRE_V2_APP2APP_CMD_NONE,
+	SPECTRE_V2_APP2APP_CMD_FORCE,
+	SPECTRE_V2_APP2APP_CMD_AUTO,
+	SPECTRE_V2_APP2APP_CMD_PRCTL,
+};
+
 static const char *spectre_v2_strings[] = {
 	[SPECTRE_V2_NONE]			= "Vulnerable",
 	[SPECTRE_V2_RETPOLINE_MINIMAL]		= "Vulnerable: Minimal generic ASM retpoline",
@@ -142,12 +149,24 @@ static const char *spectre_v2_strings[] = {
 	[SPECTRE_V2_IBRS_ENHANCED]		= "Mitigation: Enhanced IBRS",
 };
 
+static const char *spectre_v2_app2app_strings[] = {
+	[SPECTRE_V2_APP2APP_NONE]    = "App-App Vulnerable",
+	[SPECTRE_V2_APP2APP_STRICT]  = "App-App Mitigation: Full app to app attack protection",
+	[SPECTRE_V2_APP2APP_PRCTL]   = "App-App Mitigation: Protect branch speculation restricted tasks",
+};
+
+/* Lightweight mitigation: mitigate only tasks with TIF_SPEC_INDIR_BRANCH */
+DEFINE_STATIC_KEY_FALSE(spectre_v2_app_lite);
+
 #undef pr_fmt
 #define pr_fmt(fmt)     "Spectre V2 : " fmt
 
 static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
 	SPECTRE_V2_NONE;
 
+static enum spectre_v2_app2app_mitigation
+	spectre_v2_app2app_enabled __ro_after_init = SPECTRE_V2_APP2APP_NONE;
+
 void
 x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool setguest)
 {
@@ -169,6 +188,9 @@ x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool setguest)
 		    static_cpu_has(X86_FEATURE_AMD_SSBD))
 			hostval |= ssbd_tif_to_spec_ctrl(ti->flags);
 
+		if (static_branch_unlikely(&spectre_v2_app_lite))
+			hostval |= stibp_tif_to_spec_ctrl(ti->flags);
+
 		if (hostval != guestval) {
 			msrval = setguest ? guestval : hostval;
 			wrmsrl(MSR_IA32_SPEC_CTRL, msrval);
@@ -275,6 +297,60 @@ static const struct {
 	{ "auto",              SPECTRE_V2_CMD_AUTO,              false },
 };
 
+static const struct {
+	const char *option;
+	enum spectre_v2_app2app_mitigation_cmd cmd;
+	bool secure;
+} app2app_options[] = {
+	{ "off",	SPECTRE_V2_APP2APP_CMD_NONE,   false },
+	{ "on",		SPECTRE_V2_APP2APP_CMD_FORCE,  true  },
+	{ "auto",	SPECTRE_V2_APP2APP_CMD_AUTO,   false },
+	{ "prctl",	SPECTRE_V2_APP2APP_CMD_PRCTL,  false },
+};
+
+static enum spectre_v2_app2app_mitigation_cmd __init
+	    spectre_v2_parse_app2app_cmdline(enum spectre_v2_mitigation_cmd v2_cmd)
+{
+	enum spectre_v2_app2app_mitigation_cmd cmd = SPECTRE_V2_APP2APP_CMD_AUTO;
+	char arg[20];
+	int ret, i;
+
+	if (v2_cmd == SPECTRE_V2_CMD_FORCE) {
+		cmd = SPECTRE_V2_APP2APP_CMD_FORCE;
+		goto show_cmd;
+	}
+
+	if (v2_cmd == SPECTRE_V2_CMD_NONE) {
+		cmd = SPECTRE_V2_APP2APP_CMD_NONE;
+		goto show_cmd;
+	}
+
+	ret = cmdline_find_option(boot_command_line, "spectre_v2_app2app",
+				  arg, sizeof(arg));
+	if (ret < 0)
+		return SPECTRE_V2_APP2APP_CMD_AUTO;
+
+	for (i = 0; i < ARRAY_SIZE(app2app_options); i++) {
+		if (!match_option(arg, ret, app2app_options[i].option))
+			continue;
+		cmd = app2app_options[i].cmd;
+		break;
+	}
+
+	if (i >= ARRAY_SIZE(app2app_options)) {
+		pr_err("unknown app to app protection option (%s). Switching to AUTO select\n", arg);
+		return SPECTRE_V2_APP2APP_CMD_AUTO;
+	}
+
+show_cmd:
+	if (app2app_options[cmd].secure)
+		spec2_print_if_secure(app2app_options[cmd].option);
+	else
+		spec2_print_if_insecure(app2app_options[cmd].option);
+
+	return cmd;
+}
+
 static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 {
 	char arg[20];
@@ -326,13 +402,20 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 /* Determine if STIBP should be always on. */
 static bool stibp_needed(void)
 {
-	if (spectre_v2_enabled == SPECTRE_V2_NONE)
+	if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_NONE)
 		return false;
 
 	/* Using enhanced IBRS makes using STIBP unnecessary. */
 	if (static_cpu_has(X86_FEATURE_USE_IBRS_ENHANCED))
 		return false;
 
+	/*
+	 * For lite option, STIBP is used only for task with
+	 * TIF_SPEC_INDIR_BRANCH flag. STIBP is not always on for that case.
+	 */
+	if (static_branch_unlikely(&spectre_v2_app_lite))
+		return false;
+
 	if (!boot_cpu_has(X86_FEATURE_STIBP))
 		return false;
 
@@ -373,6 +456,8 @@ static void __init spectre_v2_select_mitigation(void)
 {
 	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
 	enum spectre_v2_mitigation mode = SPECTRE_V2_NONE;
+	enum spectre_v2_app2app_mitigation_cmd app2app_cmd;
+	enum spectre_v2_app2app_mitigation app2app_mode;
 
 	/*
 	 * If the CPU is not affected and the command line mode is NONE or AUTO
@@ -471,6 +556,43 @@ static void __init spectre_v2_select_mitigation(void)
 		pr_info("Enabling Restricted Speculation for firmware calls\n");
 	}
 
+	app2app_mode = SPECTRE_V2_APP2APP_NONE;
+
+	/* No mitigation if mitigation feature is unavailable */
+	if (!boot_cpu_has(X86_FEATURE_STIBP))
+		goto set_app2app_mode;
+
+	app2app_cmd = spectre_v2_parse_app2app_cmdline(cmd);
+
+	/*
+	 * If the CPU is not affected and the command line mode is NONE or AUTO
+	 * then no mitigation used.
+	 */
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2) &&
+	    (app2app_cmd == SPECTRE_V2_APP2APP_CMD_NONE ||
+	     app2app_cmd == SPECTRE_V2_APP2APP_CMD_AUTO))
+		goto set_app2app_mode;
+
+	switch (app2app_cmd) {
+	case SPECTRE_V2_APP2APP_CMD_NONE:
+		break;
+
+	case SPECTRE_V2_APP2APP_CMD_PRCTL:
+	case SPECTRE_V2_APP2APP_CMD_AUTO:
+		app2app_mode = SPECTRE_V2_APP2APP_PRCTL;
+		break;
+
+	case SPECTRE_V2_APP2APP_CMD_FORCE:
+		app2app_mode = SPECTRE_V2_APP2APP_STRICT;
+		break;
+	}
+
+set_app2app_mode:
+	spectre_v2_app2app_enabled = app2app_mode;
+	pr_info("%s\n", spectre_v2_app2app_strings[app2app_mode]);
+	if (app2app_mode == SPECTRE_V2_APP2APP_PRCTL)
+		static_branch_enable(&spectre_v2_app_lite);
+
 	/* Enable STIBP if appropriate */
 	arch_smt_update();
 }
@@ -862,13 +984,14 @@ static ssize_t l1tf_show_state(char *buf)
 
 static char *stibp_state(void)
 {
-	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
+	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED ||
+	    spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_NONE ||
+	    !cpu_use_smt_and_hotplug)
 		return "";
-
-	if (x86_spec_ctrl_base & SPEC_CTRL_STIBP)
-		return ", STIBP";
+	else if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_PRCTL)
+		return ", STIBP-prctl";
 	else
-		return "";
+		return ", STIBP-all";
 }
 
 static char *ibpb_state(void)
-- 
2.9.4

