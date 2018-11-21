Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84948C04EBB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E301721479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E301721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeKULFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 06:05:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:30250 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727314AbeKULFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 06:05:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 16:33:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,259,1539673200"; 
   d="scan'208";a="93650231"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by orsmga008.jf.intel.com with ESMTP; 20 Nov 2018 16:33:28 -0800
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        linux-kernel@vger.kernel.org, x86@kernel.org,
        stable@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: [Patch v6 12/16] x86/speculation: Add 'seccomp' Spectre v2 app to app protection mode
Date:   Tue, 20 Nov 2018 16:00:04 -0800
Message-Id: <fc2524a59454509f505e120b0b63d60efcadfc98.1542757030.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1542757030.git.tim.c.chen@linux.intel.com>
References: <cover.1542757030.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1542757030.git.tim.c.chen@linux.intel.com>
References: <cover.1542757030.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jikos@kernel.org>

From: Jiri Kosina <jkosina@suse.cz>

If 'prctl' mode of app2app protection from spectre_v2 is selected on
kernel command-line, we are currently applying STIBP protection to
tasks that restrict their indirect branch speculation via

	prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIR_BRANCH, PR_SPEC_ENABLE, 0, 0);

Let's extend this to cover also SECCOMP tasks (analogically to how we
apply SSBD protection).

According to software guidance:

"Setting ... STIBP ... on a logical processor prevents the predicted
targets of indirect branches on any logical processor of that core
from being controlled by software that executes (or executed
previously) on another logical processor of the same core."

https://software.intel.com/security-software-guidance/insights/deep-dive-single-thread-indirect-branch-predictors

Hence setting STIBP on a sandboxed task will prevent the task
from attacking other sibling threads or getting attacked.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 ++++++-
 arch/x86/include/asm/nospec-branch.h            |  1 +
 arch/x86/kernel/cpu/bugs.c                      | 21 +++++++++++++++++++--
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d2255f7..89b193c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4227,12 +4227,17 @@
 				  and STIBP mitigations against Spectre V2 attacks.
 				  If the CPU is not vulnerable, "off" is selected.
 				  If the CPU is vulnerable, the default mitigation
-				  is "prctl".
+				  is architecture and Kconfig dependent. See below.
 			prctl   - Enable mitigations per thread by restricting
 				  indirect branch speculation via prctl.
 				  Mitigation for a thread is not enabled by default to
 				  avoid mitigation overhead. The state of
 				  of the control is inherited on fork.
+			seccomp - Same as "prctl" above, but all seccomp threads
+				  will disable SSB unless they explicitly opt out.
+
+			Default mitigations:
+			If CONFIG_SECCOMP=y "seccomp", otherwise "prctl"
 
 			Not specifying this option is equivalent to
 			spectre_v2_app2app=auto.
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 69d2657..077ec54 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -231,6 +231,7 @@ enum spectre_v2_app2app_mitigation {
 	SPECTRE_V2_APP2APP_NONE,
 	SPECTRE_V2_APP2APP_STRICT,
 	SPECTRE_V2_APP2APP_PRCTL,
+	SPECTRE_V2_APP2APP_SECCOMP,
 };
 
 /* The Speculative Store Bypass disable variants */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 44f7127..f349b3f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -138,6 +138,7 @@ enum spectre_v2_app2app_mitigation_cmd {
 	SPECTRE_V2_APP2APP_CMD_FORCE,
 	SPECTRE_V2_APP2APP_CMD_AUTO,
 	SPECTRE_V2_APP2APP_CMD_PRCTL,
+	SPECTRE_V2_APP2APP_CMD_SECCOMP,
 };
 
 static const char *spectre_v2_strings[] = {
@@ -153,6 +154,7 @@ static const char *spectre_v2_app2app_strings[] = {
 	[SPECTRE_V2_APP2APP_NONE]    = "App-App Vulnerable",
 	[SPECTRE_V2_APP2APP_STRICT]  = "App-App Mitigation: Full app to app attack protection",
 	[SPECTRE_V2_APP2APP_PRCTL]   = "App-App Mitigation: Protect branch speculation restricted tasks",
+	[SPECTRE_V2_APP2APP_SECCOMP] = "App-App Mitigation: Protect branch speculation restricted and seccomp tasks",
 };
 
 /* Lightweight mitigation: mitigate only tasks with TIF_SPEC_INDIR_BRANCH */
@@ -573,10 +575,17 @@ static void __init spectre_v2_select_mitigation(void)
 		break;
 
 	case SPECTRE_V2_APP2APP_CMD_PRCTL:
-	case SPECTRE_V2_APP2APP_CMD_AUTO:
 		app2app_mode = SPECTRE_V2_APP2APP_PRCTL;
 		break;
 
+	case SPECTRE_V2_APP2APP_CMD_AUTO:
+	case SPECTRE_V2_APP2APP_CMD_SECCOMP:
+		if (IS_ENABLED(CONFIG_SECCOMP))
+			app2app_mode = SPECTRE_V2_APP2APP_SECCOMP;
+		else
+			app2app_mode = SPECTRE_V2_APP2APP_PRCTL;
+		break;
+
 	case SPECTRE_V2_APP2APP_CMD_FORCE:
 		app2app_mode = SPECTRE_V2_APP2APP_STRICT;
 		break;
@@ -595,7 +604,8 @@ static void __init spectre_v2_select_mitigation(void)
 set_app2app_mode:
 	spectre_v2_app2app_enabled = app2app_mode;
 	pr_info("%s\n", spectre_v2_app2app_strings[app2app_mode]);
-	if (app2app_mode == SPECTRE_V2_APP2APP_PRCTL)
+	if (app2app_mode == SPECTRE_V2_APP2APP_PRCTL ||
+	    app2app_mode == SPECTRE_V2_APP2APP_SECCOMP)
 		static_branch_enable(&spectre_v2_app_lite);
 
 	/* Enable STIBP if appropriate */
@@ -849,6 +859,8 @@ void arch_seccomp_spec_mitigate(struct task_struct *task)
 {
 	if (ssb_mode == SPEC_STORE_BYPASS_SECCOMP)
 		ssb_prctl_set(task, PR_SPEC_FORCE_DISABLE);
+	if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_SECCOMP)
+		set_task_restrict_indir_branch(task, true);
 }
 #endif
 
@@ -879,6 +891,7 @@ static int indir_branch_prctl_get(struct task_struct *task)
 	switch (spectre_v2_app2app_enabled) {
 	case SPECTRE_V2_APP2APP_NONE:
 		return PR_SPEC_ENABLE;
+	case SPECTRE_V2_APP2APP_SECCOMP:
 	case SPECTRE_V2_APP2APP_PRCTL:
 		if (task_spec_indir_branch_force_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
@@ -1075,6 +1088,8 @@ static char *stibp_state(void)
 		return "";
 	else if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_PRCTL)
 		return ", STIBP-prctl";
+	else if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_SECCOMP)
+		return ", STIBP-seccomp";
 	else
 		return ", STIBP-all";
 }
@@ -1085,6 +1100,8 @@ static char *ibpb_state(void)
 		return "";
 	else if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_PRCTL)
 		return ", IBPB-prctl";
+	else if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_SECCOMP)
+		return ", IBPB-seccomp";
 	else
 		return ", IBPB-all";
 }
-- 
2.9.4

