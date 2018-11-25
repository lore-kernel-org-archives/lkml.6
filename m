Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55956C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0042084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0042084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeKZFtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 00:49:23 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:53019 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbeKZFtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 00:49:22 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gQzb7-0003VP-Aj; Sun, 25 Nov 2018 19:57:37 +0100
Message-Id: <20181125185006.051663132@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 25 Nov 2018 19:33:55 +0100
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
Subject: [patch V2 27/28] x86/speculation: Add seccomp Spectre v2 user space
 protection mode
References: <20181125183328.318175777@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-speculation-Add-seccomp-Spectre-v2-app-to-app-protection-mode.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'prctl' mode of user space protection from spectre v2 is selected
on the kernel command-line, STIBP and IBPB are applied on tasks which
restrict their indirect branch speculation via prctl.

SECCOMP enables the SSBD mitigation for sandboxed tasks already, so it
makes sense to prevent spectre v2 user space to user space attacks as
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
 Documentation/admin-guide/kernel-parameters.txt |    9 ++++++++-
 arch/x86/include/asm/nospec-branch.h            |    1 +
 arch/x86/kernel/cpu/bugs.c                      |   17 ++++++++++++++++-
 3 files changed, 25 insertions(+), 2 deletions(-)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4241,9 +4241,16 @@
 				  per thread.  The mitigation control state
 				  is inherited on fork.
 
+			seccomp
+				- Same as "prctl" above, but all seccomp
+				  threads will enable the mitigation unless
+				  they explicitly opt out.
+
 			auto    - Kernel selects the mitigation depending on
 				  the available CPU features and vulnerability.
-				  Default is prctl.
+
+			Default mitigation:
+			If CONFIG_SECCOMP=y "seccomp", otherwise "prctl"
 
 			Not specifying this option is equivalent to
 			spectre_v2_user=auto.
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -233,6 +233,7 @@ enum spectre_v2_user_mitigation {
 	SPECTRE_V2_USER_NONE,
 	SPECTRE_V2_USER_STRICT,
 	SPECTRE_V2_USER_PRCTL,
+	SPECTRE_V2_USER_SECCOMP,
 };
 
 /* The Speculative Store Bypass disable variants */
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -256,12 +256,14 @@ enum spectre_v2_user_cmd {
 	SPECTRE_V2_USER_CMD_AUTO,
 	SPECTRE_V2_USER_CMD_FORCE,
 	SPECTRE_V2_USER_CMD_PRCTL,
+	SPECTRE_V2_USER_CMD_SECCOMP,
 };
 
 static const char * const spectre_v2_user_strings[] = {
 	[SPECTRE_V2_USER_NONE]		= "User space: Vulnerable",
 	[SPECTRE_V2_USER_STRICT]	= "User space: Mitigation: STIBP protection",
 	[SPECTRE_V2_USER_PRCTL]		= "User space: Mitigation: STIBP via prctl",
+	[SPECTRE_V2_USER_SECCOMP]	= "User space: Mitigation: STIBP via seccomp and prctl",
 };
 
 static const struct {
@@ -273,6 +275,7 @@ static const struct {
 	{ "off",	SPECTRE_V2_USER_CMD_NONE,	false },
 	{ "on",		SPECTRE_V2_USER_CMD_FORCE,	true  },
 	{ "prctl",	SPECTRE_V2_USER_CMD_PRCTL,	false },
+	{ "seccomp",	SPECTRE_V2_USER_CMD_SECCOMP,	false },
 };
 
 static void __init spec_v2_user_print_cond(const char *reason, bool secure)
@@ -332,10 +335,16 @@ spectre_v2_user_select_mitigation(enum s
 	case SPECTRE_V2_USER_CMD_FORCE:
 		mode = SPECTRE_V2_USER_STRICT;
 		break;
-	case SPECTRE_V2_USER_CMD_AUTO:
 	case SPECTRE_V2_USER_CMD_PRCTL:
 		mode = SPECTRE_V2_USER_PRCTL;
 		break;
+	case SPECTRE_V2_USER_CMD_AUTO:
+	case SPECTRE_V2_USER_CMD_SECCOMP:
+		if (IS_ENABLED(CONFIG_SECCOMP))
+			mode = SPECTRE_V2_USER_SECCOMP;
+		else
+			mode = SPECTRE_V2_USER_PRCTL;
+		break;
 	}
 
 	/* Initialize Indirect Branch Prediction Barrier */
@@ -347,6 +356,7 @@ spectre_v2_user_select_mitigation(enum s
 			static_branch_enable(&switch_mm_always_ibpb);
 			break;
 		case SPECTRE_V2_USER_PRCTL:
+		case SPECTRE_V2_USER_SECCOMP:
 			static_branch_enable(&switch_mm_cond_ibpb);
 			break;
 		default:
@@ -591,6 +601,7 @@ void arch_smt_update(void)
 		update_stibp_strict();
 		break;
 	case SPECTRE_V2_USER_PRCTL:
+	case SPECTRE_V2_USER_SECCOMP:
 		update_indir_branch_cond();
 		break;
 	}
@@ -837,6 +848,8 @@ void arch_seccomp_spec_mitigate(struct t
 {
 	if (ssb_mode == SPEC_STORE_BYPASS_SECCOMP)
 		ssb_prctl_set(task, PR_SPEC_FORCE_DISABLE);
+	if (spectre_v2_user == SPECTRE_V2_USER_SECCOMP)
+		ib_prctl_set(task, PR_SPEC_FORCE_DISABLE);
 }
 #endif
 
@@ -868,6 +881,7 @@ static int ib_prctl_get(struct task_stru
 	case SPECTRE_V2_USER_NONE:
 		return PR_SPEC_ENABLE;
 	case SPECTRE_V2_USER_PRCTL:
+	case SPECTRE_V2_USER_SECCOMP:
 		if (task_spec_ib_force_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
 		if (test_tsk_thread_flag(task, TIF_SPEC_IB))
@@ -1067,6 +1081,7 @@ static char *stibp_state(void)
 	case SPECTRE_V2_USER_STRICT:
 		return ", STIBP: forced";
 	case SPECTRE_V2_USER_PRCTL:
+	case SPECTRE_V2_USER_SECCOMP:
 		if (static_key_enabled(&switch_to_cond_stibp))
 			return ", STIBP: conditional";
 	}


