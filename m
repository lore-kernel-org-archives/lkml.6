Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325F4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1571214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1571214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389477AbeKVGyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:54:24 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45466 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389463AbeKVGyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:54:23 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gPYxE-0000N8-Ly; Wed, 21 Nov 2018 21:18:33 +0100
Message-Id: <20181121201724.602740969@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 21:14:54 +0100
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
Subject: [patch 24/24] x86/speculation: Add seccomp Spectre v2 app to app
 protection mode
References: <20181121201430.559770965@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-speculation-Add-seccomp-Spectre-v2-app-to-app-protection-mode.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

If 'prctl' mode of app2app protection from spectre v2 is selected on the
kernel command-line, STIBP and IBPB are applied on tasks which restrict
their indirect branch speculation via prctl.

SECCOMP enables the SSBD mitigation for sandboxed tasks already, so it
makes sense to prevent spectre v2 application to application attacks as
well.

The mitigation guide documents how STIPB works:
    
   Setting bit 1 (STIBP) of the IA32_SPEC_CTRL MSR on a logical processor
   prevents the predicted targets of indirect branches on any logical
   processor of that core from being controlled by software that executes
   (or executed previously) on another logical processor of the same core.
    
Ergo setting STIBP protects the task itself from being attacked from a task
running on a different hyper-thread and protects the tasks running on
different hyper-threads from being attacked.
    
IBPB is issued when the task switches out, so malicious sandbox code cannot
mistrain the branch predictor for the next user space task on the same
logical processor.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 Documentation/admin-guide/kernel-parameters.txt |    7 +++++-
 arch/x86/include/asm/nospec-branch.h            |    1 
 arch/x86/kernel/cpu/bugs.c                      |   27 +++++++++++++++++++-----
 3 files changed, 29 insertions(+), 6 deletions(-)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4228,10 +4228,15 @@
 				  by spectre_v2=off
 			auto    - Kernel selects the mitigation depending on
 				  the available CPU features and vulnerability.
-				  Default is prctl.
 			prctl   - Indirect branch speculation is enabled, but
 				  mitigation can be enabled via prctl per thread.
 				  The mitigation control state is inherited on fork.
+			seccomp - Same as "prctl" above, but all seccomp threads
+				  will enable the mitigation unless they explicitly
+				  opt out.
+
+			Default mitigation:
+			If CONFIG_SECCOMP=y "seccomp", otherwise "prctl"
 
 			Not specifying this option is equivalent to
 			spectre_v2_app2app=auto.
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -233,6 +233,7 @@ enum spectre_v2_app2app_mitigation {
 	SPECTRE_V2_APP2APP_NONE,
 	SPECTRE_V2_APP2APP_STRICT,
 	SPECTRE_V2_APP2APP_PRCTL,
+	SPECTRE_V2_APP2APP_SECCOMP,
 };
 
 /* The Speculative Store Bypass disable variants */
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -256,12 +256,14 @@ enum spectre_v2_app2app_cmd {
 	SPECTRE_V2_APP2APP_CMD_AUTO,
 	SPECTRE_V2_APP2APP_CMD_FORCE,
 	SPECTRE_V2_APP2APP_CMD_PRCTL,
+	SPECTRE_V2_APP2APP_CMD_SECCOMP,
 };
 
 static const char *spectre_v2_app2app_strings[] = {
 	[SPECTRE_V2_APP2APP_NONE]	= "App-App Vulnerable",
-	[SPECTRE_V2_APP2APP_STRICT]	= "App-App Mitigation: STIBP protection",
-	[SPECTRE_V2_APP2APP_PRCTL]	= "App-App Mitigation: STIBP via prctl",
+	[SPECTRE_V2_APP2APP_STRICT]	= "App-App Mitigation: forced protection",
+	[SPECTRE_V2_APP2APP_PRCTL]	= "App-App Mitigation: prctl opt-in",
+	[SPECTRE_V2_APP2APP_SECCOMP]	= "App-App Mitigation: seccomp and prctl opt-in",
 };
 
 static const struct {
@@ -332,10 +334,16 @@ spectre_v2_app2app_select_mitigation(enu
 	case SPECTRE_V2_APP2APP_CMD_FORCE:
 	       mode = SPECTRE_V2_APP2APP_STRICT;
 	       break;
-	case SPECTRE_V2_APP2APP_CMD_AUTO:
 	case SPECTRE_V2_APP2APP_CMD_PRCTL:
 		mode = SPECTRE_V2_APP2APP_PRCTL;
 		break;
+	case SPECTRE_V2_APP2APP_CMD_AUTO:
+	case SPECTRE_V2_APP2APP_CMD_SECCOMP:
+		if (IS_ENABLED(CONFIG_SECCOMP))
+			mode = SPECTRE_V2_APP2APP_SECCOMP;
+		else
+			mode = SPECTRE_V2_APP2APP_PRCTL;
+		break;
 	}
 
 	/* Initialize Indirect Branch Prediction Barrier */
@@ -347,6 +355,7 @@ spectre_v2_app2app_select_mitigation(enu
 			static_branch_enable(&switch_to_always_ibpb);
 			break;
 		case SPECTRE_V2_APP2APP_PRCTL:
+		case SPECTRE_V2_APP2APP_SECCOMP:
 			static_branch_enable(&switch_to_cond_ibpb);
 			break;
 		default:
@@ -594,6 +603,7 @@ void arch_smt_update(void)
 		update_stibp_strict();
 		break;
 	case SPECTRE_V2_APP2APP_PRCTL:
+	case SPECTRE_V2_APP2APP_SECCOMP:
 		update_indir_branch_cond();
 		break;
 	}
@@ -842,6 +852,8 @@ void arch_seccomp_spec_mitigate(struct t
 {
 	if (ssb_mode == SPEC_STORE_BYPASS_SECCOMP)
 		ssb_prctl_set(task, PR_SPEC_FORCE_DISABLE);
+	if (spectre_v2_app2app == SPECTRE_V2_APP2APP_SECCOMP)
+		indir_branch_prctl_set(task, PR_SPEC_FORCE_DISABLE);
 }
 #endif
 
@@ -873,6 +885,7 @@ static int indir_branch_prctl_get(struct
 	case SPECTRE_V2_APP2APP_NONE:
 		return PR_SPEC_ENABLE;
 	case SPECTRE_V2_APP2APP_PRCTL:
+	case SPECTRE_V2_APP2APP_SECCOMP:
 		if (task_spec_indir_branch_force_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
 		if (test_tsk_thread_flag(task, TIF_SPEC_IB))
@@ -1072,7 +1085,9 @@ static char *stibp_state(void)
 	case SPECTRE_V2_APP2APP_STRICT:
 		return ", STIBP: forced";
 	case SPECTRE_V2_APP2APP_PRCTL:
-		return ", STIBP: opt-in";
+		return ", STIBP: prctl opt-in";
+	case SPECTRE_V2_APP2APP_SECCOMP:
+		return ", STIBP: seccomp and prctl opt-in";
 	}
 	return "";
 }
@@ -1088,7 +1103,9 @@ static char *ibpb_state(void)
 	case SPECTRE_V2_APP2APP_STRICT:
 		return ", IBPB: forced";
 	case SPECTRE_V2_APP2APP_PRCTL:
-		return ", IBBP: opt-in";
+		return ", IBBP: prctl opt-in";
+	case SPECTRE_V2_APP2APP_SECCOMP:
+		return ", IBPB: seccomp and prctl opt-in";
 	}
 	return "";
 }


