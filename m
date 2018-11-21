Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6813BC04EBA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B7E21707
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B7E21707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389351AbeKVGyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:54:06 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45260 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731512AbeKVGyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:54:06 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gPYwy-0000Gw-OO; Wed, 21 Nov 2018 21:18:17 +0100
Message-Id: <20181121201723.582851341@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 21:14:43 +0100
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
Subject: [patch 13/24] x86/speculation: Reorder the spec_v2 code
References: <20181121201430.559770965@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-speculation--Sanitize-the-spec_v2-code.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder the code so it is better grouped.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/bugs.c |  168 ++++++++++++++++++++++-----------------------
 1 file changed, 84 insertions(+), 84 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -124,29 +124,6 @@ void __init check_bugs(void)
 #endif
 }
 
-/* The kernel command line selection */
-enum spectre_v2_mitigation_cmd {
-	SPECTRE_V2_CMD_NONE,
-	SPECTRE_V2_CMD_AUTO,
-	SPECTRE_V2_CMD_FORCE,
-	SPECTRE_V2_CMD_RETPOLINE,
-	SPECTRE_V2_CMD_RETPOLINE_GENERIC,
-	SPECTRE_V2_CMD_RETPOLINE_AMD,
-};
-
-static const char *spectre_v2_strings[] = {
-	[SPECTRE_V2_NONE]			= "Vulnerable",
-	[SPECTRE_V2_RETPOLINE_GENERIC]		= "Mitigation: Full generic retpoline",
-	[SPECTRE_V2_RETPOLINE_AMD]		= "Mitigation: Full AMD retpoline",
-	[SPECTRE_V2_IBRS_ENHANCED]		= "Mitigation: Enhanced IBRS",
-};
-
-#undef pr_fmt
-#define pr_fmt(fmt)     "Spectre V2 : " fmt
-
-static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
-	SPECTRE_V2_NONE;
-
 void
 x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool setguest)
 {
@@ -216,6 +193,12 @@ static void x86_amd_ssb_disable(void)
 		wrmsrl(MSR_AMD64_LS_CFG, msrval);
 }
 
+#undef pr_fmt
+#define pr_fmt(fmt)     "Spectre V2 : " fmt
+
+static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
+	SPECTRE_V2_NONE;
+
 #ifdef RETPOLINE
 static bool spectre_v2_bad_module;
 
@@ -237,18 +220,6 @@ static inline const char *spectre_v2_mod
 static inline const char *spectre_v2_module_string(void) { return ""; }
 #endif
 
-static void __init spec2_print_if_insecure(const char *reason)
-{
-	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
-		pr_info("%s selected on command line.\n", reason);
-}
-
-static void __init spec2_print_if_secure(const char *reason)
-{
-	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
-		pr_info("%s selected on command line.\n", reason);
-}
-
 static inline bool match_option(const char *arg, int arglen, const char *opt)
 {
 	int len = strlen(opt);
@@ -256,24 +227,53 @@ static inline bool match_option(const ch
 	return len == arglen && !strncmp(arg, opt, len);
 }
 
+/* The kernel command line selection for spectre v2 */
+enum spectre_v2_mitigation_cmd {
+	SPECTRE_V2_CMD_NONE,
+	SPECTRE_V2_CMD_AUTO,
+	SPECTRE_V2_CMD_FORCE,
+	SPECTRE_V2_CMD_RETPOLINE,
+	SPECTRE_V2_CMD_RETPOLINE_GENERIC,
+	SPECTRE_V2_CMD_RETPOLINE_AMD,
+};
+
+static const char *spectre_v2_strings[] = {
+	[SPECTRE_V2_NONE]			= "Vulnerable",
+	[SPECTRE_V2_RETPOLINE_GENERIC]		= "Mitigation: Full generic retpoline",
+	[SPECTRE_V2_RETPOLINE_AMD]		= "Mitigation: Full AMD retpoline",
+	[SPECTRE_V2_IBRS_ENHANCED]		= "Mitigation: Enhanced IBRS",
+};
+
 static const struct {
 	const char *option;
 	enum spectre_v2_mitigation_cmd cmd;
 	bool secure;
 } mitigation_options[] = {
-	{ "off",               SPECTRE_V2_CMD_NONE,              false },
-	{ "on",                SPECTRE_V2_CMD_FORCE,             true },
-	{ "retpoline",         SPECTRE_V2_CMD_RETPOLINE,         false },
-	{ "retpoline,amd",     SPECTRE_V2_CMD_RETPOLINE_AMD,     false },
-	{ "retpoline,generic", SPECTRE_V2_CMD_RETPOLINE_GENERIC, false },
-	{ "auto",              SPECTRE_V2_CMD_AUTO,              false },
+	{ "off",		SPECTRE_V2_CMD_NONE,		  false },
+	{ "on",			SPECTRE_V2_CMD_FORCE,		  true  },
+	{ "retpoline",		SPECTRE_V2_CMD_RETPOLINE,	  false },
+	{ "retpoline,amd",	SPECTRE_V2_CMD_RETPOLINE_AMD,	  false },
+	{ "retpoline,generic",	SPECTRE_V2_CMD_RETPOLINE_GENERIC, false },
+	{ "auto",		SPECTRE_V2_CMD_AUTO,		  false },
 };
 
+static void __init spec2_print_if_insecure(const char *reason)
+{
+	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
+		pr_info("%s selected on command line.\n", reason);
+}
+
+static void __init spec2_print_if_secure(const char *reason)
+{
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
+		pr_info("%s selected on command line.\n", reason);
+}
+
 static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 {
+	enum spectre_v2_mitigation_cmd cmd = SPECTRE_V2_CMD_AUTO;
 	char arg[20];
 	int ret, i;
-	enum spectre_v2_mitigation_cmd cmd = SPECTRE_V2_CMD_AUTO;
 
 	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
 		return SPECTRE_V2_CMD_NONE;
@@ -317,48 +317,6 @@ static enum spectre_v2_mitigation_cmd __
 	return cmd;
 }
 
-static bool stibp_needed(void)
-{
-	if (spectre_v2_enabled == SPECTRE_V2_NONE)
-		return false;
-
-	/* Enhanced IBRS makes using STIBP unnecessary. */
-	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
-		return false;
-
-	if (!boot_cpu_has(X86_FEATURE_STIBP))
-		return false;
-
-	return true;
-}
-
-static void update_stibp_msr(void *info)
-{
-	wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
-}
-
-void arch_smt_update(void)
-{
-	u64 mask;
-
-	if (!stibp_needed())
-		return;
-
-	mutex_lock(&spec_ctrl_mutex);
-
-	mask = x86_spec_ctrl_base & ~SPEC_CTRL_STIBP;
-	if (sched_smt_active())
-		mask |= SPEC_CTRL_STIBP;
-
-	if (mask != x86_spec_ctrl_base) {
-		pr_info("Spectre v2 cross-process SMT mitigation: %s STIBP\n",
-			mask & SPEC_CTRL_STIBP ? "Enabling" : "Disabling");
-		x86_spec_ctrl_base = mask;
-		on_each_cpu(update_stibp_msr, NULL, 1);
-	}
-	mutex_unlock(&spec_ctrl_mutex);
-}
-
 static void __init spectre_v2_select_mitigation(void)
 {
 	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
@@ -462,6 +420,48 @@ static void __init spectre_v2_select_mit
 	arch_smt_update();
 }
 
+static bool stibp_needed(void)
+{
+	if (spectre_v2_enabled == SPECTRE_V2_NONE)
+		return false;
+
+	/* Enhanced IBRS makes using STIBP unnecessary. */
+	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
+		return false;
+
+	if (!boot_cpu_has(X86_FEATURE_STIBP))
+		return false;
+
+	return true;
+}
+
+static void update_stibp_msr(void *info)
+{
+	wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+}
+
+void arch_smt_update(void)
+{
+	u64 mask;
+
+	if (!stibp_needed())
+		return;
+
+	mutex_lock(&spec_ctrl_mutex);
+
+	mask = x86_spec_ctrl_base & ~SPEC_CTRL_STIBP;
+	if (sched_smt_active())
+		mask |= SPEC_CTRL_STIBP;
+
+	if (mask != x86_spec_ctrl_base) {
+		pr_info("Spectre v2 cross-process SMT mitigation: %s STIBP\n",
+			mask & SPEC_CTRL_STIBP ? "Enabling" : "Disabling");
+		x86_spec_ctrl_base = mask;
+		on_each_cpu(update_stibp_msr, NULL, 1);
+	}
+	mutex_unlock(&spec_ctrl_mutex);
+}
+
 #undef pr_fmt
 #define pr_fmt(fmt)	"Speculative Store Bypass: " fmt
 


