Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136B0C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8073206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8073206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbeI3Eb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:31:27 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51530 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726313AbeI3ESU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:20 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N60-0000H8-Pi; Sat, 29 Sep 2018 22:48:16 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5v-0006q7-Ip; Sat, 29 Sep 2018 22:48:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.509362799@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 016/131] x86/speculation: Add prctl for Speculative
 Store Bypass mitigation
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

From: Thomas Gleixner <tglx@linutronix.de>

commit a73ec77ee17ec556fe7f165d00314cb7c047b1ac upstream.

Add prctl based control for Speculative Store Bypass mitigation and make it
the default mitigation for Intel and AMD.

Andi Kleen provided the following rationale (slightly redacted):

 There are multiple levels of impact of Speculative Store Bypass:

 1) JITed sandbox.
    It cannot invoke system calls, but can do PRIME+PROBE and may have call
    interfaces to other code

 2) Native code process.
    No protection inside the process at this level.

 3) Kernel.

 4) Between processes.

 The prctl tries to protect against case (1) doing attacks.

 If the untrusted code can do random system calls then control is already
 lost in a much worse way. So there needs to be system call protection in
 some way (using a JIT not allowing them or seccomp). Or rather if the
 process can subvert its environment somehow to do the prctl it can already
 execute arbitrary code, which is much worse than SSB.

 To put it differently, the point of the prctl is to not allow JITed code
 to read data it shouldn't read from its JITed sandbox. If it already has
 escaped its sandbox then it can already read everything it wants in its
 address space, and do much worse.

 The ability to control Speculative Store Bypass allows to enable the
 protection selectively without affecting overall system performance.

Based on an initial patch from Tim Chen. Completely rewritten.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 Documentation/kernel-parameters.txt  |  6 +-
 arch/x86/include/asm/nospec-branch.h |  1 +
 arch/x86/kernel/cpu/bugs.c           | 83 ++++++++++++++++++++++++----
 3 files changed, 79 insertions(+), 11 deletions(-)

--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -3222,7 +3222,11 @@ bytes respectively. Such letter suffixes
 			off    - Unconditionally enable Speculative Store Bypass
 			auto   - Kernel detects whether the CPU model contains an
 				 implementation of Speculative Store Bypass and
-				 picks the most appropriate mitigation
+				 picks the most appropriate mitigation.
+			prctl  - Control Speculative Store Bypass per thread
+				 via prctl. Speculative Store Bypass is enabled
+				 for a process by default. The state of the control
+				 is inherited on fork.
 
 			Not specifying this option is equivalent to
 			spec_store_bypass_disable=auto.
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -187,6 +187,7 @@ extern u64 x86_spec_ctrl_get_default(voi
 enum ssb_mitigation {
 	SPEC_STORE_BYPASS_NONE,
 	SPEC_STORE_BYPASS_DISABLE,
+	SPEC_STORE_BYPASS_PRCTL,
 };
 
 extern char __indirect_thunk_start[];
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -11,6 +11,8 @@
 #include <linux/utsname.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
+#include <linux/nospec.h>
+#include <linux/prctl.h>
 
 #include <asm/spec-ctrl.h>
 #include <asm/cmdline.h>
@@ -450,20 +452,23 @@ enum ssb_mitigation_cmd {
 	SPEC_STORE_BYPASS_CMD_NONE,
 	SPEC_STORE_BYPASS_CMD_AUTO,
 	SPEC_STORE_BYPASS_CMD_ON,
+	SPEC_STORE_BYPASS_CMD_PRCTL,
 };
 
 static const char *ssb_strings[] = {
 	[SPEC_STORE_BYPASS_NONE]	= "Vulnerable",
-	[SPEC_STORE_BYPASS_DISABLE]	= "Mitigation: Speculative Store Bypass disabled"
+	[SPEC_STORE_BYPASS_DISABLE]	= "Mitigation: Speculative Store Bypass disabled",
+	[SPEC_STORE_BYPASS_PRCTL]	= "Mitigation: Speculative Store Bypass disabled via prctl"
 };
 
 static const struct {
 	const char *option;
 	enum ssb_mitigation_cmd cmd;
 } ssb_mitigation_options[] = {
-	{ "auto",	SPEC_STORE_BYPASS_CMD_AUTO }, /* Platform decides */
-	{ "on",		SPEC_STORE_BYPASS_CMD_ON },   /* Disable Speculative Store Bypass */
-	{ "off",	SPEC_STORE_BYPASS_CMD_NONE }, /* Don't touch Speculative Store Bypass */
+	{ "auto",	SPEC_STORE_BYPASS_CMD_AUTO },  /* Platform decides */
+	{ "on",		SPEC_STORE_BYPASS_CMD_ON },    /* Disable Speculative Store Bypass */
+	{ "off",	SPEC_STORE_BYPASS_CMD_NONE },  /* Don't touch Speculative Store Bypass */
+	{ "prctl",	SPEC_STORE_BYPASS_CMD_PRCTL }, /* Disable Speculative Store Bypass via prctl */
 };
 
 static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
@@ -513,14 +518,15 @@ static enum ssb_mitigation_cmd __init __
 
 	switch (cmd) {
 	case SPEC_STORE_BYPASS_CMD_AUTO:
-		/*
-		 * AMD platforms by default don't need SSB mitigation.
-		 */
-		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
-			break;
+		/* Choose prctl as the default mode */
+		mode = SPEC_STORE_BYPASS_PRCTL;
+		break;
 	case SPEC_STORE_BYPASS_CMD_ON:
 		mode = SPEC_STORE_BYPASS_DISABLE;
 		break;
+	case SPEC_STORE_BYPASS_CMD_PRCTL:
+		mode = SPEC_STORE_BYPASS_PRCTL;
+		break;
 	case SPEC_STORE_BYPASS_CMD_NONE:
 		break;
 	}
@@ -531,7 +537,7 @@ static enum ssb_mitigation_cmd __init __
 	 *  - X86_FEATURE_RDS - CPU is able to turn off speculative store bypass
 	 *  - X86_FEATURE_SPEC_STORE_BYPASS_DISABLE - engage the mitigation
 	 */
-	if (mode != SPEC_STORE_BYPASS_NONE) {
+	if (mode == SPEC_STORE_BYPASS_DISABLE) {
 		setup_force_cpu_cap(X86_FEATURE_SPEC_STORE_BYPASS_DISABLE);
 		/*
 		 * Intel uses the SPEC CTRL MSR Bit(2) for this, while AMD uses
@@ -562,6 +568,63 @@ static void ssb_select_mitigation()
 
 #undef pr_fmt
 
+static int ssb_prctl_set(unsigned long ctrl)
+{
+	bool rds = !!test_tsk_thread_flag(current, TIF_RDS);
+
+	if (ssb_mode != SPEC_STORE_BYPASS_PRCTL)
+		return -ENXIO;
+
+	if (ctrl == PR_SPEC_ENABLE)
+		clear_tsk_thread_flag(current, TIF_RDS);
+	else
+		set_tsk_thread_flag(current, TIF_RDS);
+
+	if (rds != !!test_tsk_thread_flag(current, TIF_RDS))
+		speculative_store_bypass_update();
+
+	return 0;
+}
+
+static int ssb_prctl_get(void)
+{
+	switch (ssb_mode) {
+	case SPEC_STORE_BYPASS_DISABLE:
+		return PR_SPEC_DISABLE;
+	case SPEC_STORE_BYPASS_PRCTL:
+		if (test_tsk_thread_flag(current, TIF_RDS))
+			return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
+		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
+	default:
+		if (boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS))
+			return PR_SPEC_ENABLE;
+		return PR_SPEC_NOT_AFFECTED;
+	}
+}
+
+int arch_prctl_spec_ctrl_set(unsigned long which, unsigned long ctrl)
+{
+	if (ctrl != PR_SPEC_ENABLE && ctrl != PR_SPEC_DISABLE)
+		return -ERANGE;
+
+	switch (which) {
+	case PR_SPEC_STORE_BYPASS:
+		return ssb_prctl_set(ctrl);
+	default:
+		return -ENODEV;
+	}
+}
+
+int arch_prctl_spec_ctrl_get(unsigned long which)
+{
+	switch (which) {
+	case PR_SPEC_STORE_BYPASS:
+		return ssb_prctl_get();
+	default:
+		return -ENODEV;
+	}
+}
+
 void x86_spec_ctrl_setup_ap(void)
 {
 	if (boot_cpu_has(X86_FEATURE_IBRS))

