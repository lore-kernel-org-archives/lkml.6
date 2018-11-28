Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C3DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CC22081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CC22081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbeK2Bic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:38:32 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41237 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbeK2Bic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:38:32 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wASEZwHK2324537
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 06:35:58 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wASEZw4m2324534;
        Wed, 28 Nov 2018 06:35:58 -0800
Date:   Wed, 28 Nov 2018 06:35:58 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-6b3e64c237c072797a9ec918654a60e3a46488e2@git.kernel.org>
Cc:     peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, arjan@linux.intel.com,
        thomas.lendacky@amd.com, jkosina@suse.cz, aarcange@redhat.com,
        jpoimboe@redhat.com, keescook@chromium.org, mingo@kernel.org,
        ak@linux.intel.com, david.c.stewart@intel.com,
        longman9394@gmail.com, gregkh@linuxfoundation.org, jcm@redhat.com,
        dave.hansen@intel.com, dwmw@amazon.co.uk,
        tim.c.chen@linux.intel.com, hpa@zytor.com,
        asit.k.mallick@intel.com, casey.schaufler@intel.com,
        luto@kernel.org, torvalds@linux-foundation.org
Reply-To: thomas.lendacky@amd.com, jkosina@suse.cz, aarcange@redhat.com,
          jpoimboe@redhat.com, keescook@chromium.org, mingo@kernel.org,
          peterz@infradead.org, tglx@linutronix.de, arjan@linux.intel.com,
          linux-kernel@vger.kernel.org, longman9394@gmail.com,
          gregkh@linuxfoundation.org, ak@linux.intel.com,
          david.c.stewart@intel.com, tim.c.chen@linux.intel.com,
          hpa@zytor.com, asit.k.mallick@intel.com, jcm@redhat.com,
          dave.hansen@intel.com, dwmw@amazon.co.uk,
          torvalds@linux-foundation.org, luto@kernel.org,
          casey.schaufler@intel.com
In-Reply-To: <20181125185006.051663132@linutronix.de>
References: <20181125185006.051663132@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Add seccomp Spectre v2 user space
 protection mode
Git-Commit-ID: 6b3e64c237c072797a9ec918654a60e3a46488e2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6b3e64c237c072797a9ec918654a60e3a46488e2
Gitweb:     https://git.kernel.org/tip/6b3e64c237c072797a9ec918654a60e3a46488e2
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 25 Nov 2018 19:33:55 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Nov 2018 11:57:14 +0100

x86/speculation: Add seccomp Spectre v2 user space protection mode

If 'prctl' mode of user space protection from spectre v2 is selected
on the kernel command-line, STIBP and IBPB are applied on tasks which
restrict their indirect branch speculation via prctl.

SECCOMP enables the SSBD mitigation for sandboxed tasks already, so it
makes sense to prevent spectre v2 user space to user space attacks as
well.

The Intel mitigation guide documents how STIPB works:
    
   Setting bit 1 (STIBP) of the IA32_SPEC_CTRL MSR on a logical processor
   prevents the predicted targets of indirect branches on any logical
   processor of that core from being controlled by software that executes
   (or executed previously) on another logical processor of the same core.

Ergo setting STIBP protects the task itself from being attacked from a task
running on a different hyper-thread and protects the tasks running on
different hyper-threads from being attacked.

While the document suggests that the branch predictors are shielded between
the logical processors, the observed performance regressions suggest that
STIBP simply disables the branch predictor more or less completely. Of
course the document wording is vague, but the fact that there is also no
requirement for issuing IBPB when STIBP is used points clearly in that
direction. The kernel still issues IBPB even when STIBP is used until Intel
clarifies the whole mechanism.

IBPB is issued when the task switches out, so malicious sandbox code cannot
mistrain the branch predictor for the next user space task on the same
logical processor.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Casey Schaufler <casey.schaufler@intel.com>
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Jon Masters <jcm@redhat.com>
Cc: Waiman Long <longman9394@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Dave Stewart <david.c.stewart@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20181125185006.051663132@linutronix.de


---
 Documentation/admin-guide/kernel-parameters.txt |  9 ++++++++-
 arch/x86/include/asm/nospec-branch.h            |  1 +
 arch/x86/kernel/cpu/bugs.c                      | 17 ++++++++++++++++-
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a9b98a4e8789..f405281bb202 100644
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
+			If CONFIG_SECCOMP=y then "seccomp", otherwise "prctl"
 
 			Not specifying this option is equivalent to
 			spectre_v2_user=auto.
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 2adbe7b047fa..032b6009baab 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -233,6 +233,7 @@ enum spectre_v2_user_mitigation {
 	SPECTRE_V2_USER_NONE,
 	SPECTRE_V2_USER_STRICT,
 	SPECTRE_V2_USER_PRCTL,
+	SPECTRE_V2_USER_SECCOMP,
 };
 
 /* The Speculative Store Bypass disable variants */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d0137d10f9a6..c9e304960534 100644
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
@@ -332,10 +335,16 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
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
@@ -347,6 +356,7 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
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
@@ -833,6 +844,8 @@ void arch_seccomp_spec_mitigate(struct task_struct *task)
 {
 	if (ssb_mode == SPEC_STORE_BYPASS_SECCOMP)
 		ssb_prctl_set(task, PR_SPEC_FORCE_DISABLE);
+	if (spectre_v2_user == SPECTRE_V2_USER_SECCOMP)
+		ib_prctl_set(task, PR_SPEC_FORCE_DISABLE);
 }
 #endif
 
@@ -864,6 +877,7 @@ static int ib_prctl_get(struct task_struct *task)
 	case SPECTRE_V2_USER_NONE:
 		return PR_SPEC_ENABLE;
 	case SPECTRE_V2_USER_PRCTL:
+	case SPECTRE_V2_USER_SECCOMP:
 		if (task_spec_ib_force_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
 		if (task_spec_ib_disable(task))
@@ -1063,6 +1077,7 @@ static char *stibp_state(void)
 	case SPECTRE_V2_USER_STRICT:
 		return ", STIBP: forced";
 	case SPECTRE_V2_USER_PRCTL:
+	case SPECTRE_V2_USER_SECCOMP:
 		if (static_key_enabled(&switch_to_cond_stibp))
 			return ", STIBP: conditional";
 	}
