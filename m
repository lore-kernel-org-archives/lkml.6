Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDD3C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444022084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444022084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbeKZFtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 00:49:25 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:53036 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbeKZFtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 00:49:24 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gQzb8-0003W3-W4; Sun, 25 Nov 2018 19:57:39 +0100
Message-Id: <20181125185006.144047038@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 25 Nov 2018 19:33:56 +0100
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
Subject: [patch V2 28/28] x86/speculation: Provide IBPB always command line
 options
References: <20181125183328.318175777@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-speculation--Provide-IBPB-always-option.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the possibility to enable IBPB always in combination with 'prctl'
and 'seccomp'.

Add the extra command line options and rework the IBPB selection to
evaluate the command instead of the mode selected by the STIPB switch case.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 Documentation/admin-guide/kernel-parameters.txt |   12 ++++++++
 arch/x86/kernel/cpu/bugs.c                      |   34 ++++++++++++++++--------
 2 files changed, 35 insertions(+), 11 deletions(-)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4241,11 +4241,23 @@
 				  per thread.  The mitigation control state
 				  is inherited on fork.
 
+			prctl,ibpb
+				- Like "prctl" above, but only STIBP is
+				  controlled per thread. IBPB is issued
+				  always when switching between different user
+				  space processes.
+
 			seccomp
 				- Same as "prctl" above, but all seccomp
 				  threads will enable the mitigation unless
 				  they explicitly opt out.
 
+			seccomp,ibpb
+				- Like "seccomp" above, but only STIBP is
+				  controlled per thread. IBPB is issued
+				  always when switching between different
+				  user space processes.
+
 			auto    - Kernel selects the mitigation depending on
 				  the available CPU features and vulnerability.
 
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -256,7 +256,9 @@ enum spectre_v2_user_cmd {
 	SPECTRE_V2_USER_CMD_AUTO,
 	SPECTRE_V2_USER_CMD_FORCE,
 	SPECTRE_V2_USER_CMD_PRCTL,
+	SPECTRE_V2_USER_CMD_PRCTL_IBPB,
 	SPECTRE_V2_USER_CMD_SECCOMP,
+	SPECTRE_V2_USER_CMD_SECCOMP_IBPB,
 };
 
 static const char * const spectre_v2_user_strings[] = {
@@ -271,11 +273,13 @@ static const struct {
 	enum spectre_v2_user_cmd	cmd;
 	bool				secure;
 } v2_user_options[] __initdata = {
-	{ "auto",	SPECTRE_V2_USER_CMD_AUTO,	false },
-	{ "off",	SPECTRE_V2_USER_CMD_NONE,	false },
-	{ "on",		SPECTRE_V2_USER_CMD_FORCE,	true  },
-	{ "prctl",	SPECTRE_V2_USER_CMD_PRCTL,	false },
-	{ "seccomp",	SPECTRE_V2_USER_CMD_SECCOMP,	false },
+	{ "auto",		SPECTRE_V2_USER_CMD_AUTO,		false },
+	{ "off",		SPECTRE_V2_USER_CMD_NONE,		false },
+	{ "on",			SPECTRE_V2_USER_CMD_FORCE,		true  },
+	{ "prctl",		SPECTRE_V2_USER_CMD_PRCTL,		false },
+	{ "prctl,ibpb",		SPECTRE_V2_USER_CMD_PRCTL_IBPB,		false },
+	{ "seccomp",		SPECTRE_V2_USER_CMD_SECCOMP,		false },
+	{ "seccomp,ibpb",	SPECTRE_V2_USER_CMD_SECCOMP_IBPB,	false },
 };
 
 static void __init spec_v2_user_print_cond(const char *reason, bool secure)
@@ -321,6 +325,7 @@ spectre_v2_user_select_mitigation(enum s
 {
 	enum spectre_v2_user_mitigation mode = SPECTRE_V2_USER_NONE;
 	bool smt_possible = IS_ENABLED(CONFIG_SMP);
+	enum spectre_v2_user_cmd cmd;
 
 	if (!boot_cpu_has(X86_FEATURE_IBPB) && !boot_cpu_has(X86_FEATURE_STIBP))
 		return;
@@ -329,17 +334,20 @@ spectre_v2_user_select_mitigation(enum s
 	    cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
 		smt_possible = false;
 
-	switch (spectre_v2_parse_user_cmdline(v2_cmd)) {
+	cmd = spectre_v2_parse_user_cmdline(v2_cmd);
+	switch (cmd) {
 	case SPECTRE_V2_USER_CMD_NONE:
 		goto set_mode;
 	case SPECTRE_V2_USER_CMD_FORCE:
 		mode = SPECTRE_V2_USER_STRICT;
 		break;
 	case SPECTRE_V2_USER_CMD_PRCTL:
+	case SPECTRE_V2_USER_CMD_PRCTL_IBPB:
 		mode = SPECTRE_V2_USER_PRCTL;
 		break;
 	case SPECTRE_V2_USER_CMD_AUTO:
 	case SPECTRE_V2_USER_CMD_SECCOMP:
+	case SPECTRE_V2_USER_CMD_SECCOMP_IBPB:
 		if (IS_ENABLED(CONFIG_SECCOMP))
 			mode = SPECTRE_V2_USER_SECCOMP;
 		else
@@ -351,12 +359,15 @@ spectre_v2_user_select_mitigation(enum s
 	if (boot_cpu_has(X86_FEATURE_IBPB)) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
 
-		switch (mode) {
-		case SPECTRE_V2_USER_STRICT:
+		switch (cmd) {
+		case SPECTRE_V2_USER_CMD_FORCE:
+		case SPECTRE_V2_USER_CMD_PRCTL_IBPB:
+		case SPECTRE_V2_USER_CMD_SECCOMP_IBPB:
 			static_branch_enable(&switch_mm_always_ibpb);
 			break;
-		case SPECTRE_V2_USER_PRCTL:
-		case SPECTRE_V2_USER_SECCOMP:
+		case SPECTRE_V2_USER_CMD_PRCTL:
+		case SPECTRE_V2_USER_CMD_AUTO:
+		case SPECTRE_V2_USER_CMD_SECCOMP:
 			static_branch_enable(&switch_mm_cond_ibpb);
 			break;
 		default:
@@ -364,7 +375,8 @@ spectre_v2_user_select_mitigation(enum s
 		}
 
 		pr_info("mitigation: Enabling %s Indirect Branch Prediction Barrier\n",
-			mode == SPECTRE_V2_USER_STRICT ? "always-on" : "conditional");
+			static_key_enabled(&switch_mm_always_ibpb) ?
+			"always-on" : "conditional");
 	}
 
 	/* If enhanced IBRS is enabled no STIPB required */


