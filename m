Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8988ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E236B21476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E236B21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbeJRCaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:30:00 -0400
Received: from mga12.intel.com ([192.55.52.136]:29682 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728435AbeJRC36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:29:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 11:33:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,393,1534834800"; 
   d="scan'208";a="82003933"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by orsmga007.jf.intel.com with ESMTP; 17 Oct 2018 11:33:02 -0700
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
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
        Jon Masters <jcm@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [Patch v3 13/13] x86/speculation: Create PRCTL interface to restrict indirect branch speculation
Date:   Wed, 17 Oct 2018 10:59:41 -0700
Message-Id: <a04ba925a19af6ad5eaad2bc5501b7ea1ece66a9.1539798901.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1539798901.git.tim.c.chen@linux.intel.com>
References: <cover.1539798901.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1539798901.git.tim.c.chen@linux.intel.com>
References: <cover.1539798901.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create PRCTL interface to restrict an application's indirect branch
speculation.  This will protect the application against spectre v2 attack
from another application.

Invocations:
Check indirect branch speculation status with
- prctl(PR_GET_SPECULATION_CTRL, PR_INDIR_BRANCH, 0, 0, 0);

Enable indirect branch speculation with
- prctl(PR_SET_SPECULATION_CTRL, PR_INDIR_BRANCH, PR_SPEC_ENABLE, 0, 0);

Disable indirect branch speculation with
- prctl(PR_SET_SPECULATION_CTRL, PR_INDIR_BRANCH, PR_SPEC_DISABLE, 0, 0);

Force disable indirect branch speculation with
- prctl(PR_SET_SPECULATION_CTRL, PR_INDIR_BRANCH, PR_SPEC_FORCE_DISABLE, 0, 0);

See Documentation/userspace-api/spec_ctrl.rst.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +-
 Documentation/userspace-api/spec_ctrl.rst       | 10 +++
 arch/x86/kernel/cpu/bugs.c                      | 85 ++++++++++++++++++++++++-
 include/linux/sched.h                           | 11 ++++
 include/uapi/linux/prctl.h                      |  1 +
 tools/include/uapi/linux/prctl.h                |  1 +
 6 files changed, 111 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2feb6b2..9af11be 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4196,7 +4196,10 @@
 			lite   - turn on mitigation for non-dumpable
 				 processes (i.e. protect daemons and other
 				 privileged processes that tend to be
-				 non-dumpable).
+				 non-dumpable), and processes that has indirect
+				 branch speculation restricted via prctl's
+				 PR_SET_SPECULATION_CTRL option
+
 			strict - protect against attacks for all user processes
 			auto   - let kernel decide lite or strict mode
 
diff --git a/Documentation/userspace-api/spec_ctrl.rst b/Documentation/userspace-api/spec_ctrl.rst
index 32f3d55..1acf198 100644
--- a/Documentation/userspace-api/spec_ctrl.rst
+++ b/Documentation/userspace-api/spec_ctrl.rst
@@ -92,3 +92,13 @@ Speculation misfeature controls
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_ENABLE, 0, 0);
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_DISABLE, 0, 0);
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_FORCE_DISABLE, 0, 0);
+
+- PR_INDIR_BRANCH: Indirect Branch Speculation in Applications
+                   (Mitigate Spectre V2 style user space application
+                    to application attack)
+
+  Invocations:
+   * prctl(PR_GET_SPECULATION_CTRL, PR_INDIR_BRANCH, 0, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_INDIR_BRANCH, PR_SPEC_ENABLE, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_INDIR_BRANCH, PR_SPEC_DISABLE, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_INDIR_BRANCH, PR_SPEC_FORCE_DISABLE, 0, 0);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index cc77b9e..d5c5faf 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -763,12 +763,70 @@ static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
 	return 0;
 }
 
+static int indir_branch_prctl_set(struct task_struct *task, unsigned long ctrl)
+{
+	bool update;
+
+	switch (ctrl) {
+	case PR_SPEC_ENABLE:
+		if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_NONE)
+			return 0;
+		/*
+		 * Indirect branch speculation is always disabled in
+		 * strict mode or if the application is non dumpable
+		 * in lite mode. 
+		 */
+		if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_STRICT)
+			return -ENXIO;
+		if (task->mm && get_dumpable(task->mm) != SUID_DUMP_USER)
+			return -ENXIO;
+		task_clear_spec_indir_branch_disable(task);
+		update = test_and_clear_tsk_thread_flag(task, TIF_STIBP);
+		break;
+	case PR_SPEC_DISABLE:
+		/*
+		 * Indirect branch speculation is always enabled when
+		 * app to app mitigation is off.
+		 */
+		if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_NONE)
+			return -ENXIO;
+		if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_STRICT)
+			return 0;
+		task_set_spec_indir_branch_disable(task);
+		update = !test_and_set_tsk_thread_flag(task, TIF_STIBP);
+		break;
+	case PR_SPEC_FORCE_DISABLE:
+		if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_NONE)
+			return -ENXIO;
+		if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_STRICT)
+			return 0;
+		task_set_spec_indir_branch_disable(task);
+		task_set_spec_indir_branch_force_disable(task);
+		update = !test_and_set_tsk_thread_flag(task, TIF_STIBP);
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	/*
+	 * If being set on non-current task, delay setting the CPU
+	 * mitigation until it is next scheduled.
+	 * Use speculative_store_bypass_update will update SPEC_CTRL MSR
+	 */
+	if (task == current && update)
+		speculation_ctrl_update_current();
+
+	return 0;
+}
+
 int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
 			     unsigned long ctrl)
 {
 	switch (which) {
 	case PR_SPEC_STORE_BYPASS:
 		return ssb_prctl_set(task, ctrl);
+	case PR_INDIR_BRANCH:
+		return indir_branch_prctl_set(task, ctrl);
 	default:
 		return -ENODEV;
 	}
@@ -787,7 +845,7 @@ void arch_set_dumpable(struct task_struct *tsk, unsigned int value)
 
 	if (tsk->mm && value != SUID_DUMP_USER)
 		update = !test_and_set_tsk_thread_flag(tsk, TIF_STIBP);
-	else
+	else if (!task_spec_indir_branch_disable(tsk))
 		update = test_and_clear_tsk_thread_flag(tsk, TIF_STIBP);
 
 	if (tsk == current && update)
@@ -821,11 +879,36 @@ static int ssb_prctl_get(struct task_struct *task)
 	}
 }
 
+static int indir_branch_prctl_get(struct task_struct *task)
+{
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
+		return PR_SPEC_NOT_AFFECTED;
+
+	switch (spectre_v2_app2app_enabled) {
+	case SPECTRE_V2_APP2APP_NONE:
+		return PR_SPEC_ENABLE;
+	case SPECTRE_V2_APP2APP_LITE:
+		if (task_spec_indir_branch_force_disable(task))
+			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
+		if (task->mm && get_dumpable(task->mm) != SUID_DUMP_USER)
+			return PR_SPEC_DISABLE;
+		if (task_spec_indir_branch_disable(task))
+			return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
+		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
+	case SPECTRE_V2_APP2APP_STRICT:
+		return PR_SPEC_DISABLE;
+	default:
+		return PR_SPEC_NOT_AFFECTED;
+	}
+}
+
 int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which)
 {
 	switch (which) {
 	case PR_SPEC_STORE_BYPASS:
 		return ssb_prctl_get(task);
+	case PR_INDIR_BRANCH:
+		return indir_branch_prctl_get(task);
 	default:
 		return -ENODEV;
 	}
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 977cb57..8e44de6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1439,6 +1439,10 @@ static inline bool is_percpu_thread(void)
 #define PFA_SPREAD_SLAB			2	/* Spread some slab caches over cpuset */
 #define PFA_SPEC_SSB_DISABLE		3	/* Speculative Store Bypass disabled */
 #define PFA_SPEC_SSB_FORCE_DISABLE	4	/* Speculative Store Bypass force disabled*/
+#define PFA_SPEC_INDIR_BRANCH_DISABLE	5	/* Indirect branch speculation */
+						/* restricted in apps */
+#define PFA_SPEC_INDIR_BRANCH_FORCE_DISABLE 6	/* Indirect branch speculation */
+						/* restricted in apps force disabled */
 
 #define TASK_PFA_TEST(name, func)					\
 	static inline bool task_##func(struct task_struct *p)		\
@@ -1470,6 +1474,13 @@ TASK_PFA_CLEAR(SPEC_SSB_DISABLE, spec_ssb_disable)
 TASK_PFA_TEST(SPEC_SSB_FORCE_DISABLE, spec_ssb_force_disable)
 TASK_PFA_SET(SPEC_SSB_FORCE_DISABLE, spec_ssb_force_disable)
 
+TASK_PFA_TEST(SPEC_INDIR_BRANCH_DISABLE, spec_indir_branch_disable)
+TASK_PFA_SET(SPEC_INDIR_BRANCH_DISABLE, spec_indir_branch_disable)
+TASK_PFA_CLEAR(SPEC_INDIR_BRANCH_DISABLE, spec_indir_branch_disable)
+
+TASK_PFA_TEST(SPEC_INDIR_BRANCH_FORCE_DISABLE, spec_indir_branch_force_disable)
+TASK_PFA_SET(SPEC_INDIR_BRANCH_FORCE_DISABLE, spec_indir_branch_force_disable)
+
 static inline void
 current_restore_flags(unsigned long orig_flags, unsigned long flags)
 {
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index c0d7ea0..06f71f6 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -212,6 +212,7 @@ struct prctl_mm_map {
 #define PR_SET_SPECULATION_CTRL		53
 /* Speculation control variants */
 # define PR_SPEC_STORE_BYPASS		0
+# define PR_INDIR_BRANCH		1
 /* Return and control values for PR_SET/GET_SPECULATION_CTRL */
 # define PR_SPEC_NOT_AFFECTED		0
 # define PR_SPEC_PRCTL			(1UL << 0)
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index c0d7ea0..06f71f6 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -212,6 +212,7 @@ struct prctl_mm_map {
 #define PR_SET_SPECULATION_CTRL		53
 /* Speculation control variants */
 # define PR_SPEC_STORE_BYPASS		0
+# define PR_INDIR_BRANCH		1
 /* Return and control values for PR_SET/GET_SPECULATION_CTRL */
 # define PR_SPEC_NOT_AFFECTED		0
 # define PR_SPEC_PRCTL			(1UL << 0)
-- 
2.9.4

