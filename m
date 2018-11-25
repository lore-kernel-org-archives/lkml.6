Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1326C04EBA
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4AE2084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4AE2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeKZFtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 00:49:22 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:52999 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbeKZFtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 00:49:21 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gQzb6-0003V5-2i; Sun, 25 Nov 2018 19:57:36 +0100
Message-Id: <20181125185005.958421388@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 25 Nov 2018 19:33:54 +0100
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
Subject: [patch V2 26/28] x86/speculation: Enable prctl mode for
 spectre_v2_user
References: <20181125183328.318175777@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-speculation-Enable-PRCTL-mode-for-spectre-v2-app2app.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all prerequisites are in place:

 - Add the prctl command line option

 - Default the 'auto' mode to 'prctl'

 - When SMT state changes, update the static key which controls the
   conditional STIBP evaluation on context switch.

 - At init update the static key which controls the conditional IBPB
   evaluation on context switch.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---

V1 -> V2: Fix comments
      	  s/app2app/user/
	  Make the IBPB printout depend on the static keys as it can be
	  independent of the mode, e.g. when SMT is not supported.
	  Remove the CONFIG_SMP conditional
---
 Documentation/admin-guide/kernel-parameters.txt |    7 +++-
 arch/x86/kernel/cpu/bugs.c                      |   41 ++++++++++++++++++------
 2 files changed, 38 insertions(+), 10 deletions(-)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4236,9 +4236,14 @@
 			off     - Unconditionally disable mitigations. Is
 				  enforced by spectre_v2=off
 
+			prctl   - Indirect branch speculation is enabled,
+				  but mitigation can be enabled via prctl
+				  per thread.  The mitigation control state
+				  is inherited on fork.
+
 			auto    - Kernel selects the mitigation depending on
 				  the available CPU features and vulnerability.
-				  Default is off.
+				  Default is prctl.
 
 			Not specifying this option is equivalent to
 			spectre_v2_user=auto.
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -255,11 +255,13 @@ enum spectre_v2_user_cmd {
 	SPECTRE_V2_USER_CMD_NONE,
 	SPECTRE_V2_USER_CMD_AUTO,
 	SPECTRE_V2_USER_CMD_FORCE,
+	SPECTRE_V2_USER_CMD_PRCTL,
 };
 
 static const char * const spectre_v2_user_strings[] = {
 	[SPECTRE_V2_USER_NONE]		= "User space: Vulnerable",
 	[SPECTRE_V2_USER_STRICT]	= "User space: Mitigation: STIBP protection",
+	[SPECTRE_V2_USER_PRCTL]		= "User space: Mitigation: STIBP via prctl",
 };
 
 static const struct {
@@ -270,6 +272,7 @@ static const struct {
 	{ "auto",	SPECTRE_V2_USER_CMD_AUTO,	false },
 	{ "off",	SPECTRE_V2_USER_CMD_NONE,	false },
 	{ "on",		SPECTRE_V2_USER_CMD_FORCE,	true  },
+	{ "prctl",	SPECTRE_V2_USER_CMD_PRCTL,	false },
 };
 
 static void __init spec_v2_user_print_cond(const char *reason, bool secure)
@@ -324,12 +327,15 @@ spectre_v2_user_select_mitigation(enum s
 		smt_possible = false;
 
 	switch (spectre_v2_parse_user_cmdline(v2_cmd)) {
-	case SPECTRE_V2_USER_CMD_AUTO:
 	case SPECTRE_V2_USER_CMD_NONE:
 		goto set_mode;
 	case SPECTRE_V2_USER_CMD_FORCE:
 		mode = SPECTRE_V2_USER_STRICT;
 		break;
+	case SPECTRE_V2_USER_CMD_AUTO:
+	case SPECTRE_V2_USER_CMD_PRCTL:
+		mode = SPECTRE_V2_USER_PRCTL;
+		break;
 	}
 
 	/* Initialize Indirect Branch Prediction Barrier */
@@ -340,6 +346,9 @@ spectre_v2_user_select_mitigation(enum s
 		case SPECTRE_V2_USER_STRICT:
 			static_branch_enable(&switch_mm_always_ibpb);
 			break;
+		case SPECTRE_V2_USER_PRCTL:
+			static_branch_enable(&switch_mm_cond_ibpb);
+			break;
 		default:
 			break;
 		}
@@ -352,6 +361,12 @@ spectre_v2_user_select_mitigation(enum s
 	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
 		return;
 
+	/*
+	 * If SMT is not possible or STIBP is not available clear the STIPB
+	 * mode.
+	 */
+	if (!smt_possible || !boot_cpu_has(X86_FEATURE_STIBP))
+		mode = SPECTRE_V2_USER_NONE;
 set_mode:
 	spectre_v2_user = mode;
 	/* Only print the STIBP mode when SMT possible */
@@ -552,6 +567,15 @@ static void update_stibp_strict(void)
 	on_each_cpu(update_stibp_msr, NULL, 1);
 }
 
+/* Update the static key controlling the evaluation of TIF_SPEC_IB */
+static void update_indir_branch_cond(void)
+{
+	if (sched_smt_active())
+		static_branch_enable(&switch_to_cond_stibp);
+	else
+		static_branch_disable(&switch_to_cond_stibp);
+}
+
 void arch_smt_update(void)
 {
 	/* Enhanced IBRS implies STIBP. No update required. */
@@ -567,6 +591,7 @@ void arch_smt_update(void)
 		update_stibp_strict();
 		break;
 	case SPECTRE_V2_USER_PRCTL:
+		update_indir_branch_cond();
 		break;
 	}
 
@@ -1042,7 +1067,8 @@ static char *stibp_state(void)
 	case SPECTRE_V2_USER_STRICT:
 		return ", STIBP: forced";
 	case SPECTRE_V2_USER_PRCTL:
-		return "";
+		if (static_key_enabled(&switch_to_cond_stibp))
+			return ", STIBP: conditional";
 	}
 	return "";
 }
@@ -1050,14 +1076,11 @@ static char *stibp_state(void)
 static char *ibpb_state(void)
 {
 	if (boot_cpu_has(X86_FEATURE_IBPB)) {
-		switch (spectre_v2_user) {
-		case SPECTRE_V2_USER_NONE:
-			return ", IBPB: disabled";
-		case SPECTRE_V2_USER_STRICT:
+		if (static_key_enabled(&switch_mm_always_ibpb))
 			return ", IBPB: always-on";
-		case SPECTRE_V2_USER_PRCTL:
-			return "";
-		}
+		if (static_key_enabled(&switch_mm_cond_ibpb))
+			return ", IBPB: conditional";
+		return ", IBPB: disabled";
 	}
 	return "";
 }


