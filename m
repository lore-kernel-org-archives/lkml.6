Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88050C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502C0213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 502C0213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeKULOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 06:14:35 -0500
Received: from mga05.intel.com ([192.55.52.43]:6937 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbeKULOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 06:14:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 16:42:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,259,1539673200"; 
   d="scan'208";a="251346841"
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
Subject: [Patch v7 12/18] x86/speculation: Create PRCTL interface to restrict indirect branch speculation
Date:   Tue, 20 Nov 2018 16:08:51 -0800
Message-Id: <3b20131a0ca572aa476cdf7fc7885580f5376ef7.1542758656.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1542758656.git.tim.c.chen@linux.intel.com>
References: <cover.1542758656.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1542758656.git.tim.c.chen@linux.intel.com>
References: <cover.1542758656.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create PRCTL interface to restrict an application's indirect branch
speculation.  This will protect the application against spectre v2 attack
from another application.

Invocations:
Check indirect branch speculation status with
- prctl(PR_GET_SPECULATION_CTRL, PR_SPEC_INDIR_BRANCH, 0, 0, 0);

Enable indirect branch speculation with
- prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIR_BRANCH, PR_SPEC_ENABLE, 0, 0);

Disable indirect branch speculation with
- prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIR_BRANCH, PR_SPEC_DISABLE, 0, 0);

Force disable indirect branch speculation with
- prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIR_BRANCH, PR_SPEC_FORCE_DISABLE, 0, 0);

See Documentation/userspace-api/spec_ctrl.rst.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 Documentation/userspace-api/spec_ctrl.rst |  9 ++++
 arch/x86/kernel/cpu/bugs.c                | 80 +++++++++++++++++++++++++++++++
 include/linux/sched.h                     |  9 ++++
 include/uapi/linux/prctl.h                |  1 +
 tools/include/uapi/linux/prctl.h          |  1 +
 5 files changed, 100 insertions(+)

diff --git a/Documentation/userspace-api/spec_ctrl.rst b/Documentation/userspace-api/spec_ctrl.rst
index 32f3d55..8a4e268 100644
--- a/Documentation/userspace-api/spec_ctrl.rst
+++ b/Documentation/userspace-api/spec_ctrl.rst
@@ -92,3 +92,12 @@ Speculation misfeature controls
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_ENABLE, 0, 0);
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_DISABLE, 0, 0);
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_FORCE_DISABLE, 0, 0);
+
+- PR_SPEC_INDIR_BRANCH: Indirect Branch Speculation in User Processes
+                        (Mitigate Spectre V2 style attacks against user processes)
+
+  Invocations:
+   * prctl(PR_GET_SPECULATION_CTRL, PR_SPEC_INDIR_BRANCH, 0, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIR_BRANCH, PR_SPEC_ENABLE, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIR_BRANCH, PR_SPEC_DISABLE, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIR_BRANCH, PR_SPEC_FORCE_DISABLE, 0, 0);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 387de54..26e1a87 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -771,12 +771,69 @@ static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
 	return 0;
 }
 
+static void set_task_restrict_indir_branch(struct task_struct *tsk, bool restrict_on)
+{
+	bool update = false;
+
+	if (restrict_on)
+		update = !test_and_set_tsk_thread_flag(tsk, TIF_SPEC_INDIR_BRANCH);
+	else
+		update = test_and_clear_tsk_thread_flag(tsk, TIF_SPEC_INDIR_BRANCH);
+
+	if (tsk == current && update)
+		speculation_ctrl_update_current();
+}
+
+static int indir_branch_prctl_set(struct task_struct *task, unsigned long ctrl)
+{
+	switch (ctrl) {
+	case PR_SPEC_ENABLE:
+		if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_NONE)
+			return 0;
+		/*
+		 * Indirect branch speculation is always disabled in
+		 * strict mode.
+		 */
+		if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_STRICT)
+			return -EPERM;
+		task_clear_spec_indir_branch_disable(task);
+		set_task_restrict_indir_branch(task, false);
+		break;
+	case PR_SPEC_DISABLE:
+		/*
+		 * Indirect branch speculation is always allowed when
+		 * mitigation is force disabled.
+		 */
+		if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_NONE)
+			return -EPERM;
+		if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_STRICT)
+			return 0;
+		task_set_spec_indir_branch_disable(task);
+		set_task_restrict_indir_branch(task, true);
+		break;
+	case PR_SPEC_FORCE_DISABLE:
+		if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_NONE)
+			return -EPERM;
+		if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_STRICT)
+			return 0;
+		task_set_spec_indir_branch_disable(task);
+		task_set_spec_indir_branch_force_disable(task);
+		set_task_restrict_indir_branch(task, true);
+		break;
+	default:
+		return -ERANGE;
+	}
+	return 0;
+}
+
 int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
 			     unsigned long ctrl)
 {
 	switch (which) {
 	case PR_SPEC_STORE_BYPASS:
 		return ssb_prctl_set(task, ctrl);
+	case PR_SPEC_INDIR_BRANCH:
+		return indir_branch_prctl_set(task, ctrl);
 	default:
 		return -ENODEV;
 	}
@@ -809,11 +866,34 @@ static int ssb_prctl_get(struct task_struct *task)
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
+	case SPECTRE_V2_APP2APP_PRCTL:
+		if (task_spec_indir_branch_force_disable(task))
+			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
+		if (test_tsk_thread_flag(task, TIF_SPEC_INDIR_BRANCH))
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
+	case PR_SPEC_INDIR_BRANCH:
+		return indir_branch_prctl_get(task);
 	default:
 		return -ENODEV;
 	}
diff --git a/include/linux/sched.h b/include/linux/sched.h
index a51c13c..e92e4bf 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1453,6 +1453,8 @@ static inline bool is_percpu_thread(void)
 #define PFA_SPREAD_SLAB			2	/* Spread some slab caches over cpuset */
 #define PFA_SPEC_SSB_DISABLE		3	/* Speculative Store Bypass disabled */
 #define PFA_SPEC_SSB_FORCE_DISABLE	4	/* Speculative Store Bypass force disabled*/
+#define PFA_SPEC_INDIR_BRANCH_DISABLE	5	/* Indirect branch speculation restricted in apps */
+#define PFA_SPEC_INDIR_BRANCH_FORCE_DISABLE 6	/* Indirect branch speculation restricted in apps forced */
 
 #define TASK_PFA_TEST(name, func)					\
 	static inline bool task_##func(struct task_struct *p)		\
@@ -1484,6 +1486,13 @@ TASK_PFA_CLEAR(SPEC_SSB_DISABLE, spec_ssb_disable)
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
index c0d7ea0..577f2ca 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -212,6 +212,7 @@ struct prctl_mm_map {
 #define PR_SET_SPECULATION_CTRL		53
 /* Speculation control variants */
 # define PR_SPEC_STORE_BYPASS		0
+# define PR_SPEC_INDIR_BRANCH		1
 /* Return and control values for PR_SET/GET_SPECULATION_CTRL */
 # define PR_SPEC_NOT_AFFECTED		0
 # define PR_SPEC_PRCTL			(1UL << 0)
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index c0d7ea0..577f2ca 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -212,6 +212,7 @@ struct prctl_mm_map {
 #define PR_SET_SPECULATION_CTRL		53
 /* Speculation control variants */
 # define PR_SPEC_STORE_BYPASS		0
+# define PR_SPEC_INDIR_BRANCH		1
 /* Return and control values for PR_SET/GET_SPECULATION_CTRL */
 # define PR_SPEC_NOT_AFFECTED		0
 # define PR_SPEC_PRCTL			(1UL << 0)
-- 
2.9.4

