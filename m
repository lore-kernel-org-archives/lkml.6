Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A458C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32966214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32966214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389486AbeKVGyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:54:32 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45455 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389399AbeKVGyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:54:21 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gPYxC-0000MG-Pi; Wed, 21 Nov 2018 21:18:31 +0100
Message-Id: <20181121201724.508280006@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 21:14:53 +0100
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
Subject: [patch 23/24] x86/speculation: Enable PRCTL mode for
 spectre_v2_app2app
References: <20181121201430.559770965@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-speculation--Enable-PRCTL-mode-for-spectre_v2_app2app.patch
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
 Documentation/admin-guide/kernel-parameters.txt |    5 ++
 arch/x86/kernel/cpu/bugs.c                      |   46 +++++++++++++++++++++---
 2 files changed, 45 insertions(+), 6 deletions(-)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4246,7 +4246,10 @@
 				  by spectre_v2=off
 			auto    - Kernel selects the mitigation depending on
 				  the available CPU features and vulnerability.
-				  Default is off.
+				  Default is prctl.
+			prctl   - Indirect branch speculation is enabled, but
+				  mitigation can be enabled via prctl per thread.
+				  The mitigation control state is inherited on fork.
 
 			Not specifying this option is equivalent to
 			spectre_v2_app2app=auto.
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -255,11 +255,13 @@ enum spectre_v2_app2app_cmd {
 	SPECTRE_V2_APP2APP_CMD_NONE,
 	SPECTRE_V2_APP2APP_CMD_AUTO,
 	SPECTRE_V2_APP2APP_CMD_FORCE,
+	SPECTRE_V2_APP2APP_CMD_PRCTL,
 };
 
 static const char *spectre_v2_app2app_strings[] = {
 	[SPECTRE_V2_APP2APP_NONE]	= "App-App Vulnerable",
 	[SPECTRE_V2_APP2APP_STRICT]	= "App-App Mitigation: STIBP protection",
+	[SPECTRE_V2_APP2APP_PRCTL]	= "App-App Mitigation: STIBP via prctl",
 };
 
 static const struct {
@@ -270,6 +272,7 @@ static const struct {
 	{ "auto",	SPECTRE_V2_APP2APP_CMD_AUTO,	false },
 	{ "off",	SPECTRE_V2_APP2APP_CMD_NONE,	false },
 	{ "on",		SPECTRE_V2_APP2APP_CMD_FORCE,	true  },
+	{ "prctl",	SPECTRE_V2_APP2APP_CMD_PRCTL,	false },
 };
 
 static void __init spec_v2_app_print_cond(const char *reason, bool secure)
@@ -324,12 +327,15 @@ spectre_v2_app2app_select_mitigation(enu
 		smt_possible = false;
 
 	switch (spectre_v2_parse_app2app_cmdline(v2_cmd)) {
-	case SPECTRE_V2_APP2APP_CMD_AUTO:
 	case SPECTRE_V2_APP2APP_CMD_NONE:
 		goto set_mode;
 	case SPECTRE_V2_APP2APP_CMD_FORCE:
 	       mode = SPECTRE_V2_APP2APP_STRICT;
 	       break;
+	case SPECTRE_V2_APP2APP_CMD_AUTO:
+	case SPECTRE_V2_APP2APP_CMD_PRCTL:
+		mode = SPECTRE_V2_APP2APP_PRCTL;
+		break;
 	}
 
 	/* Initialize Indirect Branch Prediction Barrier */
@@ -340,6 +346,9 @@ spectre_v2_app2app_select_mitigation(enu
 		case SPECTRE_V2_APP2APP_STRICT:
 			static_branch_enable(&switch_to_always_ibpb);
 			break;
+		case SPECTRE_V2_APP2APP_PRCTL:
+			static_branch_enable(&switch_to_cond_ibpb);
+			break;
 		default:
 			break;
 		}
@@ -352,6 +361,12 @@ spectre_v2_app2app_select_mitigation(enu
 	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
 		return;
 
+	/*
+	 * If STIBP is not available or SMT is not possible clear the STIPB
+	 * mode.
+	 */
+	if (!smt_possible || !boot_cpu_has(X86_FEATURE_STIBP))
+		mode = SPECTRE_V2_APP2APP_NONE;
 set_mode:
 	spectre_v2_app2app = mode;
 	/* Only print the STIBP mode when SMT possible */
@@ -552,6 +567,18 @@ static void update_stibp_strict(void)
 	on_each_cpu(update_stibp_msr, NULL, 1);
 }
 
+/* Update the static key controlling the evaluation of TIF_SPEC_IB */
+static void update_indir_branch_cond(void)
+{
+	if (!IS_ENABLED(CONFIG_SMP))
+		return;
+
+	if (sched_smt_active())
+		static_branch_enable(&switch_to_cond_stibp);
+	else
+		static_branch_disable(&switch_to_cond_stibp);
+}
+
 void arch_smt_update(void)
 {
 	/* Enhanced IBRS makes using STIBP unnecessary. No update required. */
@@ -567,6 +594,7 @@ void arch_smt_update(void)
 		update_stibp_strict();
 		break;
 	case SPECTRE_V2_APP2APP_PRCTL:
+		update_indir_branch_cond();
 		break;
 	}
 
@@ -1044,17 +1072,25 @@ static char *stibp_state(void)
 	case SPECTRE_V2_APP2APP_STRICT:
 		return ", STIBP: forced";
 	case SPECTRE_V2_APP2APP_PRCTL:
-		return "";
+		return ", STIBP: opt-in";
 	}
 	return "";
 }
 
 static char *ibpb_state(void)
 {
-	if (boot_cpu_has(X86_FEATURE_USE_IBPB))
-		return ", IBPB";
-	else
+	if (!boot_cpu_has(X86_FEATURE_IBPB))
 		return "";
+
+	switch (spectre_v2_app2app) {
+	case SPECTRE_V2_APP2APP_NONE:
+		return ", IBPB: disabled";
+	case SPECTRE_V2_APP2APP_STRICT:
+		return ", IBPB: forced";
+	case SPECTRE_V2_APP2APP_PRCTL:
+		return ", IBBP: opt-in";
+	}
+	return "";
 }
 
 static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,


