Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32DDECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1D82086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1D82086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbeIZH3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 03:29:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:52990 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbeIZH3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 03:29:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 18:18:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,304,1534834800"; 
   d="scan'208";a="72890335"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by fmsmga007.fm.intel.com with ESMTP; 25 Sep 2018 18:17:16 -0700
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
Subject: [Patch v2 1/4] x86/speculation: Option to select app to app mitigation for spectre_v2
Date:   Tue, 25 Sep 2018 17:43:56 -0700
Message-Id: <cb7314d6deb8d1c58e2ead56fef8848b642e4e5a.1537920575.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1537920575.git.tim.c.chen@linux.intel.com>
References: <cover.1537920575.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1537920575.git.tim.c.chen@linux.intel.com>
References: <cover.1537920575.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Kosina's patch makes IBPB and STIBP available for
general spectre v2 app to app mitigation.  IBPB will be issued for
switching to an app that's not ptraceable by the previous
app and STIBP will be always turned on.

However, app to app exploit is in general difficult
due to address space layout randomization in apps and
the need to know an app's address space layout ahead of time.
Users may not wish to incur app to app performance
overhead from IBPB and STIBP for general non security sensitive apps.

This patch provides a lite option for spectre_v2 app to app
mitigation where IBPB is only issued for security sensitive
non-dumpable app.

The strict option will keep system at high security level
where IBPB and STIBP are used to defend all apps against
spectre_v2 app to app attack.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 11 +++
 arch/x86/include/asm/nospec-branch.h            |  9 +++
 arch/x86/kernel/cpu/bugs.c                      | 95 +++++++++++++++++++++++--
 arch/x86/mm/tlb.c                               | 19 +++--
 4 files changed, 126 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 64a3bf5..6243144 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4186,6 +4186,17 @@
 			Not specifying this option is equivalent to
 			spectre_v2=auto.
 
+	spectre_v2_app2app=
+			[X86] Control app to app mitigation of Spectre variant 2
+			(indirect branch speculation) vulnerability.
+
+			lite   - only turn on mitigation for non-dumpable processes
+			strict - protect against attacks for all user processes
+			auto   - let kernel decide lite or strict mode
+
+			Not specifying this option is equivalent to
+			spectre_v2_app2app=auto.
+
 	spec_store_bypass_disable=
 			[HW] Control Speculative Store Bypass (SSB) Disable mitigation
 			(Speculative Store Bypass vulnerability)
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index fd2a8c1..c59a6c4 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -3,6 +3,7 @@
 #ifndef _ASM_X86_NOSPEC_BRANCH_H_
 #define _ASM_X86_NOSPEC_BRANCH_H_
 
+#include <linux/static_key.h>
 #include <asm/alternative.h>
 #include <asm/alternative-asm.h>
 #include <asm/cpufeatures.h>
@@ -217,6 +218,12 @@ enum spectre_v2_mitigation {
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
@@ -228,6 +235,8 @@ enum ssb_mitigation {
 extern char __indirect_thunk_start[];
 extern char __indirect_thunk_end[];
 
+DECLARE_STATIC_KEY_FALSE(spectre_v2_app_lite);
+
 /*
  * On VMEXIT we must ensure that no RSB predictions learned in the guest
  * can be followed in the host, by overwriting the RSB completely. Both
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ee46dcb..c967012 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -133,6 +133,12 @@ enum spectre_v2_mitigation_cmd {
 	SPECTRE_V2_CMD_RETPOLINE_AMD,
 };
 
+enum spectre_v2_app2app_mitigation_cmd {
+	SPECTRE_V2_APP2APP_CMD_AUTO,
+	SPECTRE_V2_APP2APP_CMD_LITE,
+	SPECTRE_V2_APP2APP_CMD_STRICT,
+};
+
 static const char *spectre_v2_strings[] = {
 	[SPECTRE_V2_NONE]			= "Vulnerable",
 	[SPECTRE_V2_RETPOLINE_MINIMAL]		= "Vulnerable: Minimal generic ASM retpoline",
@@ -142,12 +148,24 @@ static const char *spectre_v2_strings[] = {
 	[SPECTRE_V2_IBRS_ENHANCED]		= "Mitigation: Enhanced IBRS",
 };
 
+static const char *spectre_v2_app2app_strings[] = {
+	[SPECTRE_V2_APP2APP_NONE]		= "App-App Vulnerable",
+	[SPECTRE_V2_APP2APP_LITE]		= "App-App Mitigation: Protect only non-dumpable process",
+	[SPECTRE_V2_APP2APP_STRICT]		= "App-App Mitigation: Full app to app attack protection",
+};
+
+DEFINE_STATIC_KEY_FALSE(spectre_v2_app_lite);
+EXPORT_SYMBOL(spectre_v2_app_lite);
+
 #undef pr_fmt
 #define pr_fmt(fmt)     "Spectre V2 : " fmt
 
 static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
 	SPECTRE_V2_NONE;
 
+static enum spectre_v2_mitigation spectre_v2_app2app_enabled __ro_after_init =
+	SPECTRE_V2_APP2APP_NONE;
+
 void
 x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool setguest)
 {
@@ -275,6 +293,46 @@ static const struct {
 	{ "auto",              SPECTRE_V2_CMD_AUTO,              false },
 };
 
+static const struct {
+	const char *option;
+	enum spectre_v2_app2app_mitigation_cmd cmd;
+	bool secure;
+} app2app_mitigation_options[] = {
+	{ "lite",	SPECTRE_V2_APP2APP_CMD_LITE,   false },
+	{ "strict",	SPECTRE_V2_APP2APP_CMD_STRICT, false },
+	{ "auto",	SPECTRE_V2_APP2APP_CMD_AUTO,   false },
+};
+
+static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_app2app_cmdline(void)
+{
+	char arg[20];
+	int ret, i;
+	enum spectre_v2_mitigation_cmd cmd = SPECTRE_V2_APP2APP_CMD_AUTO;
+
+	ret = cmdline_find_option(boot_command_line, "spectre_v2_app2app", arg, sizeof(arg));
+	if (ret < 0)
+		return SPECTRE_V2_APP2APP_CMD_AUTO;
+
+	for (i = 0; i < ARRAY_SIZE(app2app_mitigation_options); i++) {
+		if (!match_option(arg, ret, app2app_mitigation_options[i].option))
+			continue;
+		cmd = app2app_mitigation_options[i].cmd;
+		break;
+	}
+
+	if (i >= ARRAY_SIZE(app2app_mitigation_options)) {
+		pr_err("unknown app to app protection option (%s). Switching to AUTO select\n", arg);
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
@@ -325,6 +383,9 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 
 static bool stibp_needed(void)
 {
+	if (static_branch_unlikely(&spectre_v2_app_lite))
+		return false;
+
 	if (spectre_v2_enabled == SPECTRE_V2_NONE)
 		return false;
 
@@ -366,7 +427,9 @@ void arch_smt_update(void)
 static void __init spectre_v2_select_mitigation(void)
 {
 	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
+	enum spectre_v2_app2app_mitigation_cmd app2app_cmd = spectre_v2_parse_app2app_cmdline();
 	enum spectre_v2_mitigation mode = SPECTRE_V2_NONE;
+	enum spectre_v2_app2app_mitigation app2app_mode = SPECTRE_V2_APP2APP_NONE;
 
 	/*
 	 * If the CPU is not affected and the command line mode is NONE or AUTO
@@ -376,6 +439,17 @@ static void __init spectre_v2_select_mitigation(void)
 	    (cmd == SPECTRE_V2_CMD_NONE || cmd == SPECTRE_V2_CMD_AUTO))
 		return;
 
+	switch (app2app_cmd) {
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
 	switch (cmd) {
 	case SPECTRE_V2_CMD_NONE:
 		return;
@@ -427,6 +501,11 @@ static void __init spectre_v2_select_mitigation(void)
 	}
 
 specv2_set_mode:
+	spectre_v2_app2app_enabled = app2app_mode;
+	pr_info("%s\n", spectre_v2_app2app_strings[app2app_mode]);
+	if (app2app_mode == SPECTRE_V2_APP2APP_LITE)
+		static_branch_enable(&spectre_v2_app_lite);
+
 	spectre_v2_enabled = mode;
 	pr_info("%s\n", spectre_v2_strings[mode]);
 
@@ -441,8 +520,8 @@ static void __init spectre_v2_select_mitigation(void)
 	setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
 	pr_info("Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch\n");
 
-	/* Initialize Indirect Branch Prediction Barrier if supported */
-	if (boot_cpu_has(X86_FEATURE_IBPB)) {
+	/* Initialize Indirect Branch Prediction Barrier if supported and not disabled */
+	if (boot_cpu_has(X86_FEATURE_IBPB) && app2app_mode != SPECTRE_V2_APP2APP_NONE) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
 		pr_info("Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier\n");
 	}
@@ -875,8 +954,16 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 
 	case X86_BUG_SPECTRE_V2:
 		mutex_lock(&spec_ctrl_mutex);
-		ret = sprintf(buf, "%s%s%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
-			       boot_cpu_has(X86_FEATURE_USE_IBPB) ? ", IBPB" : "",
+		if (static_branch_unlikely(&spectre_v2_app_lite))
+			ret = sprintf(buf, "%s%s%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
+			       boot_cpu_has(X86_FEATURE_USE_IBPB) ? ", IBPB-lite" : "",
+			       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
+			       (x86_spec_ctrl_base & SPEC_CTRL_STIBP) ? ", STIBP" : "",
+			       boot_cpu_has(X86_FEATURE_RSB_CTXSW) ? ", RSB filling" : "",
+			       spectre_v2_module_string());
+		else
+			ret = sprintf(buf, "%s%s%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
+			       boot_cpu_has(X86_FEATURE_USE_IBPB) ? ", IBPB-strict" : "",
 			       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
 			       (x86_spec_ctrl_base & SPEC_CTRL_STIBP) ? ", STIBP" : "",
 			       boot_cpu_has(X86_FEATURE_RSB_CTXSW) ? ", RSB filling" : "",
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index ed44444..14522aa 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -184,14 +184,25 @@ static void sync_current_stack_to_mm(struct mm_struct *mm)
 static bool ibpb_needed(struct task_struct *tsk, u64 last_ctx_id)
 {
 	/*
-	 * Check if the current (previous) task has access to the memory
-	 * of the @tsk (next) task. If access is denied, make sure to
+	 * For lite protection mode, we only protect the non-dumpable
+	 * processes.
+	 *
+	 * Otherwise check if the current (previous) task has access to the memory
+	 * of the @tsk (next) task for strict app to app protection.
+	 * If access is denied, make sure to
 	 * issue a IBPB to stop user->user Spectre-v2 attacks.
 	 *
 	 * Note: __ptrace_may_access() returns 0 or -ERRNO.
 	 */
-	return (tsk && tsk->mm && tsk->mm->context.ctx_id != last_ctx_id &&
-			__ptrace_may_access(tsk, PTRACE_MODE_IBPB));
+
+	/* skip IBPB if no context changes */
+	if (!tsk || !tsk->mm || tsk->mm->context.ctx_id == last_ctx_id)
+		return false;
+
+	if (static_branch_unlikely(&spectre_v2_app_lite))
+		return (get_dumpable(tsk->mm) != SUID_DUMP_USER);
+	else
+		return (__ptrace_may_access(tsk, PTRACE_MODE_IBPB));
 }
 
 void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
-- 
2.9.4

