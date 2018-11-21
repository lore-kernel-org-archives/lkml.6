Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50AAC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDA6213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EDA6213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeKULPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 06:15:09 -0500
Received: from mga12.intel.com ([192.55.52.136]:16662 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbeKULOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 06:14:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 16:42:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,259,1539673200"; 
   d="scan'208";a="251346843"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by orsmga004.jf.intel.com with ESMTP; 20 Nov 2018 16:42:04 -0800
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        stable@vger.kernel.org
Subject: [Patch v7 13/18] x86/speculation: Enable IBPB for tasks with TIF_SPEC_BRANCH_SPECULATION
Date:   Tue, 20 Nov 2018 16:08:52 -0800
Message-Id: <9f9cfed2830ebf5cce69190409b0716406aeaf22.1542758656.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1542758656.git.tim.c.chen@linux.intel.com>
References: <cover.1542758656.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1542758656.git.tim.c.chen@linux.intel.com>
References: <cover.1542758656.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IBPB currently is applied to all tasks.  However,
when spectre_v2_app2app_enabled is set to default
value SPECTRE_V2_APP2APP_PRCTL, only tasks marked with
TIF_SPEC_BRANCH_SPECULATION via prctl are protected against Spectre V2
sibling thread attack to minimize performance impact.

It makes sense to extend the concept to IBPB to protect only
the tasks marked with TIF_SPEC_BRANCH_SPECULATION needing
mitigation.

Make IBPB usage follow the spectre_v2_app2app_enabled option:
spectre_v2_app2app =
 SPECTRE_V2_APP2APP_PRCTL  : Use IBPB only on tasks with TIF_SPEC_BRANCH_SPECULATION
 SPECTRE_V2_APP2APP_STRICT : Use IBPB on all tasks
 SPECTRE_V2_APP2APP_NONE   : Don't use IBPB

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 arch/x86/kernel/cpu/bugs.c | 29 ++++++++++++++++++-----------
 arch/x86/mm/tlb.c          | 23 ++++++++++++++++++-----
 2 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 26e1a87..44f7127 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -534,12 +534,6 @@ static void __init spectre_v2_select_mitigation(void)
 	setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
 	pr_info("Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch\n");
 
-	/* Initialize Indirect Branch Prediction Barrier if supported */
-	if (boot_cpu_has(X86_FEATURE_IBPB)) {
-		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
-		pr_info("Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier\n");
-	}
-
 	/*
 	 * Retpoline means the kernel is safe because it has no indirect
 	 * branches. Enhanced IBRS protects firmware too, so, enable restricted
@@ -558,8 +552,9 @@ static void __init spectre_v2_select_mitigation(void)
 
 	app2app_mode = SPECTRE_V2_APP2APP_NONE;
 
-	/* No mitigation if mitigation feature is unavailable */
-	if (!boot_cpu_has(X86_FEATURE_STIBP))
+	/* No mitigation if all mitigation features are unavailable */
+	if (!boot_cpu_has(X86_FEATURE_IBPB) &&
+	    !boot_cpu_has(X86_FEATURE_STIBP))
 		goto set_app2app_mode;
 
 	app2app_cmd = spectre_v2_parse_app2app_cmdline(cmd);
@@ -587,6 +582,16 @@ static void __init spectre_v2_select_mitigation(void)
 		break;
 	}
 
+	/*
+	 * Initialize Indirect Branch Prediction Barrier if supported
+	 * and not disabled explicitly
+	 */
+	if (boot_cpu_has(X86_FEATURE_IBPB) &&
+	    app2app_mode != SPECTRE_V2_APP2APP_NONE) {
+		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
+		pr_info("Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier\n");
+	}
+
 set_app2app_mode:
 	spectre_v2_app2app_enabled = app2app_mode;
 	pr_info("%s\n", spectre_v2_app2app_strings[app2app_mode]);
@@ -1076,10 +1081,12 @@ static char *stibp_state(void)
 
 static char *ibpb_state(void)
 {
-	if (boot_cpu_has(X86_FEATURE_USE_IBPB))
-		return ", IBPB";
-	else
+	if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_NONE)
 		return "";
+	else if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_PRCTL)
+		return ", IBPB-prctl";
+	else
+		return ", IBPB-all";
 }
 
 static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index bddd6b3..616694c 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -184,14 +184,27 @@ static void sync_current_stack_to_mm(struct mm_struct *mm)
 static bool ibpb_needed(struct task_struct *tsk, u64 last_ctx_id)
 {
 	/*
-	 * Check if the current (previous) task has access to the memory
-	 * of the @tsk (next) task. If access is denied, make sure to
-	 * issue a IBPB to stop user->user Spectre-v2 attacks.
+	 * Don't issue IBPB when switching to kernel threads or staying in the
+	 * same mm context.
+	 */
+	if (!tsk || !tsk->mm || tsk->mm->context.ctx_id == last_ctx_id)
+		return false;
+
+	/*
+	 * If lite protection mode is enabled, check the STIBP thread flag.
+	 *
+	 * Otherwise check if the current (previous) task has access to the
+	 * the memory of the @tsk (next) task for strict app to app protection.
+	 * If access is denied, make sure to issue a IBPB to stop user->user
+	 * Spectre-v2 attacks.
 	 *
 	 * Note: __ptrace_may_access() returns 0 or -ERRNO.
 	 */
-	return (tsk && tsk->mm && tsk->mm->context.ctx_id != last_ctx_id &&
-		ptrace_may_access_sched(tsk, PTRACE_MODE_SPEC_IBPB));
+
+	if (static_branch_unlikely(&spectre_v2_app_lite))
+		return test_tsk_thread_flag(tsk, TIF_SPEC_INDIR_BRANCH);
+	else
+		return ptrace_may_access_sched(tsk, PTRACE_MODE_SPEC_IBPB);
 }
 
 void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
-- 
2.9.4

