Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B94C64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E152087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E152087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbeI3EbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:31:07 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51544 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726555AbeI3ESV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:21 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N60-0000H0-GG; Sat, 29 Sep 2018 22:48:16 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5v-0006pT-BM; Sat, 29 Sep 2018 22:48:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@kernel.org>, "Borislav Petkov" <bp@suse.de>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.161380962@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 008/131] x86/bugs: Provide boot parameters for the
 spec_store_bypass_disable mitigation
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 24f7fc83b9204d20f878c57cb77d261ae825e033 upstream.

Contemporary high performance processors use a common industry-wide
optimization known as "Speculative Store Bypass" in which loads from
addresses to which a recent store has occurred may (speculatively) see an
older value. Intel refers to this feature as "Memory Disambiguation" which
is part of their "Smart Memory Access" capability.

Memory Disambiguation can expose a cache side-channel attack against such
speculatively read values. An attacker can create exploit code that allows
them to read memory outside of a sandbox environment (for example,
malicious JavaScript in a web page), or to perform more complex attacks
against code running within the same privilege level, e.g. via the stack.

As a first step to mitigate against such attacks, provide two boot command
line control knobs:

 nospec_store_bypass_disable
 spec_store_bypass_disable=[off,auto,on]

By default affected x86 processors will power on with Speculative
Store Bypass enabled. Hence the provided kernel parameters are written
from the point of view of whether to enable a mitigation or not.
The parameters are as follows:

 - auto - Kernel detects whether your CPU model contains an implementation
	  of Speculative Store Bypass and picks the most appropriate
	  mitigation.

 - on   - disable Speculative Store Bypass
 - off  - enable Speculative Store Bypass

[ tglx: Reordered the checks so that the whole evaluation is not done
  	when the CPU does not support RDS ]

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.16:
 - Renumber the feature bit
 - Adjust filenames, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 Documentation/kernel-parameters.txt  |  33 +++++++++
 arch/x86/include/asm/cpufeature.h    |   1 +
 arch/x86/include/asm/nospec-branch.h |   6 ++
 arch/x86/kernel/cpu/bugs.c           | 103 +++++++++++++++++++++++++++
 4 files changed, 143 insertions(+)

--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2172,6 +2172,9 @@ bytes respectively. Such letter suffixes
 			allow data leaks with this option, which is equivalent
 			to spectre_v2=off.
 
+	nospec_store_bypass_disable
+			[HW] Disable all mitigations for the Speculative Store Bypass vulnerability
+
 	noxsave		[BUGS=X86] Disables x86 extended register state save
 			and restore using xsave. The kernel will fallback to
 			enabling legacy floating-point and sse state.
@@ -3194,6 +3197,36 @@ bytes respectively. Such letter suffixes
 			Not specifying this option is equivalent to
 			spectre_v2=auto.
 
+	spec_store_bypass_disable=
+			[HW] Control Speculative Store Bypass (SSB) Disable mitigation
+			(Speculative Store Bypass vulnerability)
+
+			Certain CPUs are vulnerable to an exploit against a
+			a common industry wide performance optimization known
+			as "Speculative Store Bypass" in which recent stores
+			to the same memory location may not be observed by
+			later loads during speculative execution. The idea
+			is that such stores are unlikely and that they can
+			be detected prior to instruction retirement at the
+			end of a particular speculation execution window.
+
+			In vulnerable processors, the speculatively forwarded
+			store can be used in a cache side channel attack, for
+			example to read memory to which the attacker does not
+			directly have access (e.g. inside sandboxed code).
+
+			This parameter controls whether the Speculative Store
+			Bypass optimization is used.
+
+			on     - Unconditionally disable Speculative Store Bypass
+			off    - Unconditionally enable Speculative Store Bypass
+			auto   - Kernel detects whether the CPU model contains an
+				 implementation of Speculative Store Bypass and
+				 picks the most appropriate mitigation
+
+			Not specifying this option is equivalent to
+			spec_store_bypass_disable=auto.
+
 	spia_io_base=	[HW,MTD]
 	spia_fio_base=
 	spia_pedr=
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -191,6 +191,7 @@
 
 #define X86_FEATURE_USE_IBPB	(7*32+12) /* "" Indirect Branch Prediction Barrier enabled */
 #define X86_FEATURE_USE_IBRS_FW (7*32+13) /* "" Use IBRS during runtime firmware calls */
+#define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE (7*32+14) /* "" Disable Speculative Store Bypass. */
 
 #define X86_FEATURE_RETPOLINE	(7*32+29) /* "" Generic Retpoline mitigation for Spectre variant 2 */
 #define X86_FEATURE_RETPOLINE_AMD (7*32+30) /* "" AMD Retpoline mitigation for Spectre variant 2 */
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -193,6 +193,12 @@ extern u64 x86_spec_ctrl_get_default(voi
 extern void x86_spec_ctrl_set_guest(u64);
 extern void x86_spec_ctrl_restore_host(u64);
 
+/* The Speculative Store Bypass disable variants */
+enum ssb_mitigation {
+	SPEC_STORE_BYPASS_NONE,
+	SPEC_STORE_BYPASS_DISABLE,
+};
+
 extern char __indirect_thunk_start[];
 extern char __indirect_thunk_end[];
 
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -26,6 +26,7 @@
 #include <asm/intel-family.h>
 
 static void __init spectre_v2_select_mitigation(void);
+static void __init ssb_select_mitigation(void);
 
 /*
  * Our boot-time value of the SPEC_CTRL MSR. We read it once so that any
@@ -110,6 +111,12 @@ void __init check_bugs(void)
 	/* Select the proper spectre mitigation before patching alternatives */
 	spectre_v2_select_mitigation();
 
+	/*
+	 * Select proper mitigation for any exposure to the Speculative Store
+	 * Bypass vulnerability.
+	 */
+	ssb_select_mitigation();
+
 #ifdef CONFIG_X86_32
 	/*
 	 * Check whether we are able to run this kernel safely on SMP.
@@ -396,6 +403,99 @@ retpoline_auto:
 }
 
 #undef pr_fmt
+#define pr_fmt(fmt)	"Speculative Store Bypass: " fmt
+
+static enum ssb_mitigation ssb_mode = SPEC_STORE_BYPASS_NONE;
+
+/* The kernel command line selection */
+enum ssb_mitigation_cmd {
+	SPEC_STORE_BYPASS_CMD_NONE,
+	SPEC_STORE_BYPASS_CMD_AUTO,
+	SPEC_STORE_BYPASS_CMD_ON,
+};
+
+static const char *ssb_strings[] = {
+	[SPEC_STORE_BYPASS_NONE]	= "Vulnerable",
+	[SPEC_STORE_BYPASS_DISABLE]	= "Mitigation: Speculative Store Bypass disabled"
+};
+
+static const struct {
+	const char *option;
+	enum ssb_mitigation_cmd cmd;
+} ssb_mitigation_options[] = {
+	{ "auto",	SPEC_STORE_BYPASS_CMD_AUTO }, /* Platform decides */
+	{ "on",		SPEC_STORE_BYPASS_CMD_ON },   /* Disable Speculative Store Bypass */
+	{ "off",	SPEC_STORE_BYPASS_CMD_NONE }, /* Don't touch Speculative Store Bypass */
+};
+
+static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
+{
+	enum ssb_mitigation_cmd cmd = SPEC_STORE_BYPASS_CMD_AUTO;
+	char arg[20];
+	int ret, i;
+
+	if (cmdline_find_option_bool(boot_command_line, "nospec_store_bypass_disable")) {
+		return SPEC_STORE_BYPASS_CMD_NONE;
+	} else {
+		ret = cmdline_find_option(boot_command_line, "spec_store_bypass_disable",
+					  arg, sizeof(arg));
+		if (ret < 0)
+			return SPEC_STORE_BYPASS_CMD_AUTO;
+
+		for (i = 0; i < ARRAY_SIZE(ssb_mitigation_options); i++) {
+			if (!match_option(arg, ret, ssb_mitigation_options[i].option))
+				continue;
+
+			cmd = ssb_mitigation_options[i].cmd;
+			break;
+		}
+
+		if (i >= ARRAY_SIZE(ssb_mitigation_options)) {
+			pr_err("unknown option (%s). Switching to AUTO select\n", arg);
+			return SPEC_STORE_BYPASS_CMD_AUTO;
+		}
+	}
+
+	return cmd;
+}
+
+static enum ssb_mitigation_cmd __init __ssb_select_mitigation(void)
+{
+	enum ssb_mitigation mode = SPEC_STORE_BYPASS_NONE;
+	enum ssb_mitigation_cmd cmd;
+
+	if (!boot_cpu_has(X86_FEATURE_RDS))
+		return mode;
+
+	cmd = ssb_parse_cmdline();
+	if (!boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS) &&
+	    (cmd == SPEC_STORE_BYPASS_CMD_NONE ||
+	     cmd == SPEC_STORE_BYPASS_CMD_AUTO))
+		return mode;
+
+	switch (cmd) {
+	case SPEC_STORE_BYPASS_CMD_AUTO:
+	case SPEC_STORE_BYPASS_CMD_ON:
+		mode = SPEC_STORE_BYPASS_DISABLE;
+		break;
+	case SPEC_STORE_BYPASS_CMD_NONE:
+		break;
+	}
+
+	if (mode != SPEC_STORE_BYPASS_NONE)
+		setup_force_cpu_cap(X86_FEATURE_SPEC_STORE_BYPASS_DISABLE);
+	return mode;
+}
+
+static void ssb_select_mitigation()
+{
+	ssb_mode = __ssb_select_mitigation();
+
+	if (boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS))
+		pr_info("%s\n", ssb_strings[ssb_mode]);
+}
+
+#undef pr_fmt
 
 #ifdef CONFIG_SYSFS
 
@@ -421,6 +521,9 @@ ssize_t cpu_show_common(struct device *d
 			       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
 			       spectre_v2_module_string());
 
+	case X86_BUG_SPEC_STORE_BYPASS:
+		return sprintf(buf, "%s\n", ssb_strings[ssb_mode]);
+
 	default:
 		break;
 	}

