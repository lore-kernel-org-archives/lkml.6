Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365B2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E4D2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E4D2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbeK2Bh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:37:57 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57581 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbeK2Bh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:37:57 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wASEZNTX2324449
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 06:35:24 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wASEZNO12324438;
        Wed, 28 Nov 2018 06:35:23 -0800
Date:   Wed, 28 Nov 2018 06:35:23 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-7cc765a67d8e04ef7d772425ca5a2a1e2b894c15@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org, david.c.stewart@intel.com,
        longman9394@gmail.com, jkosina@suse.cz, ak@linux.intel.com,
        casey.schaufler@intel.com, gregkh@linuxfoundation.org,
        arjan@linux.intel.com, jcm@redhat.com, tglx@linutronix.de,
        thomas.lendacky@amd.com, dave.hansen@intel.com, luto@kernel.org,
        hpa@zytor.com, asit.k.mallick@intel.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        dwmw@amazon.co.uk, aarcange@redhat.com, keescook@chromium.org,
        tim.c.chen@linux.intel.com
Reply-To: jpoimboe@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
          asit.k.mallick@intel.com, keescook@chromium.org,
          tim.c.chen@linux.intel.com, dwmw@amazon.co.uk,
          torvalds@linux-foundation.org, aarcange@redhat.com,
          jcm@redhat.com, thomas.lendacky@amd.com, dave.hansen@intel.com,
          luto@kernel.org, tglx@linutronix.de, ak@linux.intel.com,
          longman9394@gmail.com, jkosina@suse.cz,
          gregkh@linuxfoundation.org, arjan@linux.intel.com,
          casey.schaufler@intel.com, mingo@kernel.org,
          david.c.stewart@intel.com, peterz@infradead.org
In-Reply-To: <20181125185005.958421388@linutronix.de>
References: <20181125185005.958421388@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Enable prctl mode for
 spectre_v2_user
Git-Commit-ID: 7cc765a67d8e04ef7d772425ca5a2a1e2b894c15
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

Commit-ID:  7cc765a67d8e04ef7d772425ca5a2a1e2b894c15
Gitweb:     https://git.kernel.org/tip/7cc765a67d8e04ef7d772425ca5a2a1e2b894c15
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 25 Nov 2018 19:33:54 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Nov 2018 11:57:13 +0100

x86/speculation: Enable prctl mode for spectre_v2_user

Now that all prerequisites are in place:

 - Add the prctl command line option

 - Default the 'auto' mode to 'prctl'

 - When SMT state changes, update the static key which controls the
   conditional STIBP evaluation on context switch.

 - At init update the static key which controls the conditional IBPB
   evaluation on context switch.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jkosina@suse.cz>
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
Link: https://lkml.kernel.org/r/20181125185005.958421388@linutronix.de


---
 Documentation/admin-guide/kernel-parameters.txt |  7 ++++-
 arch/x86/kernel/cpu/bugs.c                      | 41 +++++++++++++++++++------
 2 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b6e5b33b9d75..a9b98a4e8789 100644
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
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 74359fff87fd..d0137d10f9a6 100644
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
@@ -324,12 +327,15 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
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
@@ -340,6 +346,9 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 		case SPECTRE_V2_USER_STRICT:
 			static_branch_enable(&switch_mm_always_ibpb);
 			break;
+		case SPECTRE_V2_USER_PRCTL:
+			static_branch_enable(&switch_mm_cond_ibpb);
+			break;
 		default:
 			break;
 		}
@@ -352,6 +361,12 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
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
 
@@ -1038,7 +1063,8 @@ static char *stibp_state(void)
 	case SPECTRE_V2_USER_STRICT:
 		return ", STIBP: forced";
 	case SPECTRE_V2_USER_PRCTL:
-		return "";
+		if (static_key_enabled(&switch_to_cond_stibp))
+			return ", STIBP: conditional";
 	}
 	return "";
 }
@@ -1046,14 +1072,11 @@ static char *stibp_state(void)
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
