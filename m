Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB71C004D5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE82B2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE82B2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbeI3ETY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:19:24 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52139 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728891AbeI3ESi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:38 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6H-0000HA-JH; Sat, 29 Sep 2018 22:48:33 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5v-0006qm-SK; Sat, 29 Sep 2018 22:48:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Kees Cook" <keescook@chromium.org>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.949767590@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 024/131] x86/speculation: Make "seccomp" the default
 mode for Speculative Store Bypass
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

From: Kees Cook <keescook@chromium.org>

commit f21b53b20c754021935ea43364dbf53778eeba32 upstream.

Unless explicitly opted out of, anything running under seccomp will have
SSB mitigations enabled. Choosing the "prctl" mode will disable this.

[ tglx: Adjusted it to the new arch_seccomp_spec_mitigate() mechanism ]

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 Documentation/kernel-parameters.txt  | 26 ++++++++++++++--------
 arch/x86/include/asm/nospec-branch.h |  1 +
 arch/x86/kernel/cpu/bugs.c           | 32 ++++++++++++++++++++--------
 3 files changed, 41 insertions(+), 18 deletions(-)

--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -3218,19 +3218,27 @@ bytes respectively. Such letter suffixes
 			This parameter controls whether the Speculative Store
 			Bypass optimization is used.
 
-			on     - Unconditionally disable Speculative Store Bypass
-			off    - Unconditionally enable Speculative Store Bypass
-			auto   - Kernel detects whether the CPU model contains an
-				 implementation of Speculative Store Bypass and
-				 picks the most appropriate mitigation.
-			prctl  - Control Speculative Store Bypass per thread
-				 via prctl. Speculative Store Bypass is enabled
-				 for a process by default. The state of the control
-				 is inherited on fork.
+			on      - Unconditionally disable Speculative Store Bypass
+			off     - Unconditionally enable Speculative Store Bypass
+			auto    - Kernel detects whether the CPU model contains an
+				  implementation of Speculative Store Bypass and
+				  picks the most appropriate mitigation. If the
+				  CPU is not vulnerable, "off" is selected. If the
+				  CPU is vulnerable the default mitigation is
+				  architecture and Kconfig dependent. See below.
+			prctl   - Control Speculative Store Bypass per thread
+				  via prctl. Speculative Store Bypass is enabled
+				  for a process by default. The state of the control
+				  is inherited on fork.
+			seccomp - Same as "prctl" above, but all seccomp threads
+				  will disable SSB unless they explicitly opt out.
 
 			Not specifying this option is equivalent to
 			spec_store_bypass_disable=auto.
 
+			Default mitigations:
+			X86:	If CONFIG_SECCOMP=y "seccomp", otherwise "prctl"
+
 	spia_io_base=	[HW,MTD]
 	spia_fio_base=
 	spia_pedr=
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -188,6 +188,7 @@ enum ssb_mitigation {
 	SPEC_STORE_BYPASS_NONE,
 	SPEC_STORE_BYPASS_DISABLE,
 	SPEC_STORE_BYPASS_PRCTL,
+	SPEC_STORE_BYPASS_SECCOMP,
 };
 
 extern char __indirect_thunk_start[];
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -453,22 +453,25 @@ enum ssb_mitigation_cmd {
 	SPEC_STORE_BYPASS_CMD_AUTO,
 	SPEC_STORE_BYPASS_CMD_ON,
 	SPEC_STORE_BYPASS_CMD_PRCTL,
+	SPEC_STORE_BYPASS_CMD_SECCOMP,
 };
 
 static const char *ssb_strings[] = {
 	[SPEC_STORE_BYPASS_NONE]	= "Vulnerable",
 	[SPEC_STORE_BYPASS_DISABLE]	= "Mitigation: Speculative Store Bypass disabled",
-	[SPEC_STORE_BYPASS_PRCTL]	= "Mitigation: Speculative Store Bypass disabled via prctl"
+	[SPEC_STORE_BYPASS_PRCTL]	= "Mitigation: Speculative Store Bypass disabled via prctl",
+	[SPEC_STORE_BYPASS_SECCOMP]	= "Mitigation: Speculative Store Bypass disabled via prctl and seccomp",
 };
 
 static const struct {
 	const char *option;
 	enum ssb_mitigation_cmd cmd;
 } ssb_mitigation_options[] = {
-	{ "auto",	SPEC_STORE_BYPASS_CMD_AUTO },  /* Platform decides */
-	{ "on",		SPEC_STORE_BYPASS_CMD_ON },    /* Disable Speculative Store Bypass */
-	{ "off",	SPEC_STORE_BYPASS_CMD_NONE },  /* Don't touch Speculative Store Bypass */
-	{ "prctl",	SPEC_STORE_BYPASS_CMD_PRCTL }, /* Disable Speculative Store Bypass via prctl */
+	{ "auto",	SPEC_STORE_BYPASS_CMD_AUTO },    /* Platform decides */
+	{ "on",		SPEC_STORE_BYPASS_CMD_ON },      /* Disable Speculative Store Bypass */
+	{ "off",	SPEC_STORE_BYPASS_CMD_NONE },    /* Don't touch Speculative Store Bypass */
+	{ "prctl",	SPEC_STORE_BYPASS_CMD_PRCTL },   /* Disable Speculative Store Bypass via prctl */
+	{ "seccomp",	SPEC_STORE_BYPASS_CMD_SECCOMP }, /* Disable Speculative Store Bypass via prctl and seccomp */
 };
 
 static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
@@ -518,8 +521,15 @@ static enum ssb_mitigation_cmd __init __
 
 	switch (cmd) {
 	case SPEC_STORE_BYPASS_CMD_AUTO:
-		/* Choose prctl as the default mode */
-		mode = SPEC_STORE_BYPASS_PRCTL;
+	case SPEC_STORE_BYPASS_CMD_SECCOMP:
+		/*
+		 * Choose prctl+seccomp as the default mode if seccomp is
+		 * enabled.
+		 */
+		if (IS_ENABLED(CONFIG_SECCOMP))
+			mode = SPEC_STORE_BYPASS_SECCOMP;
+		else
+			mode = SPEC_STORE_BYPASS_PRCTL;
 		break;
 	case SPEC_STORE_BYPASS_CMD_ON:
 		mode = SPEC_STORE_BYPASS_DISABLE;
@@ -567,12 +577,14 @@ static void ssb_select_mitigation()
 }
 
 #undef pr_fmt
+#define pr_fmt(fmt)     "Speculation prctl: " fmt
 
 static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
 {
 	bool update;
 
-	if (ssb_mode != SPEC_STORE_BYPASS_PRCTL)
+	if (ssb_mode != SPEC_STORE_BYPASS_PRCTL &&
+	    ssb_mode != SPEC_STORE_BYPASS_SECCOMP)
 		return -ENXIO;
 
 	switch (ctrl) {
@@ -620,7 +632,8 @@ int arch_prctl_spec_ctrl_set(struct task
 #ifdef CONFIG_SECCOMP
 void arch_seccomp_spec_mitigate(struct task_struct *task)
 {
-	ssb_prctl_set(task, PR_SPEC_FORCE_DISABLE);
+	if (ssb_mode == SPEC_STORE_BYPASS_SECCOMP)
+		ssb_prctl_set(task, PR_SPEC_FORCE_DISABLE);
 }
 #endif
 
@@ -629,6 +642,7 @@ static int ssb_prctl_get(struct task_str
 	switch (ssb_mode) {
 	case SPEC_STORE_BYPASS_DISABLE:
 		return PR_SPEC_DISABLE;
+	case SPEC_STORE_BYPASS_SECCOMP:
 	case SPEC_STORE_BYPASS_PRCTL:
 		if (task_spec_ssb_force_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;

