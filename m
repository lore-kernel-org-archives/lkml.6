Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09E2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50F1214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B50F1214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389465AbeKVGyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:54:21 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45437 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389441AbeKVGyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:54:20 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gPYxB-0000LX-0r; Wed, 21 Nov 2018 21:18:29 +0100
Message-Id: <20181121201724.414692525@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 21:14:52 +0100
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
        Kees Cook <keescook@chromium.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: [patch 22/24] x86/speculation: Create PRCTL interface to restrict
 indirect branch speculation
References: <20181121201430.559770965@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-speculation-Create-PRCTL-interface-to-restrict-indirect-branch-speculation.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim Chen <tim.c.chen@linux.intel.com>

Add the PR_SPEC_INDIR_BRANCH option for the PR_GET_SPECULATION_CTRL and
PR_SET_SPECULATION_CTRL prctls to allow fine grained per task control of
indirect branch speculation via STIBP.

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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 Documentation/userspace-api/spec_ctrl.rst |    9 +++
 arch/x86/include/asm/nospec-branch.h      |    1 
 arch/x86/kernel/cpu/bugs.c                |   71 ++++++++++++++++++++++++++++++
 include/linux/sched.h                     |    9 +++
 include/uapi/linux/prctl.h                |    1 
 tools/include/uapi/linux/prctl.h          |    1 
 6 files changed, 92 insertions(+)

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
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -232,6 +232,7 @@ enum spectre_v2_mitigation {
 enum spectre_v2_app2app_mitigation {
 	SPECTRE_V2_APP2APP_NONE,
 	SPECTRE_V2_APP2APP_STRICT,
+	SPECTRE_V2_APP2APP_PRCTL,
 };
 
 /* The Speculative Store Bypass disable variants */
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -567,6 +567,8 @@ void arch_smt_update(void)
 	case SPECTRE_V2_APP2APP_STRICT:
 		update_stibp_strict();
 		break;
+	case SPECTRE_V2_APP2APP_PRCTL:
+		break;
 	}
 
 	mutex_unlock(&spec_ctrl_mutex);
@@ -753,12 +755,56 @@ static int ssb_prctl_set(struct task_str
 	return 0;
 }
 
+static int indir_branch_prctl_set(struct task_struct *task, unsigned long ctrl)
+{
+	switch (ctrl) {
+	case PR_SPEC_ENABLE:
+		if (spectre_v2_app2app == SPECTRE_V2_APP2APP_NONE)
+			return 0;
+		/*
+		 * Indirect branch speculation is always disabled in strict
+		 * mode.
+		 */
+		if (spectre_v2_app2app == SPECTRE_V2_APP2APP_STRICT)
+			return -EPERM;
+		task_clear_spec_indir_branch_disable(task);
+		task_update_spec_tif(task, TIF_SPEC_IB, false);
+		break;
+	case PR_SPEC_DISABLE:
+		/*
+		 * Indirect branch speculation is always allowed when
+		 * mitigation is force disabled.
+		 */
+		if (spectre_v2_app2app == SPECTRE_V2_APP2APP_NONE)
+			return -EPERM;
+		if (spectre_v2_app2app == SPECTRE_V2_APP2APP_STRICT)
+			return 0;
+		task_set_spec_indir_branch_disable(task);
+		task_update_spec_tif(task, TIF_SPEC_IB, true);
+		break;
+	case PR_SPEC_FORCE_DISABLE:
+		if (spectre_v2_app2app == SPECTRE_V2_APP2APP_NONE)
+			return -EPERM;
+		if (spectre_v2_app2app == SPECTRE_V2_APP2APP_STRICT)
+			return 0;
+		task_set_spec_indir_branch_disable(task);
+		task_set_spec_indir_branch_force_disable(task);
+		task_update_spec_tif(task, TIF_SPEC_IB, true);
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
@@ -791,11 +837,34 @@ static int ssb_prctl_get(struct task_str
 	}
 }
 
+static int indir_branch_prctl_get(struct task_struct *task)
+{
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
+		return PR_SPEC_NOT_AFFECTED;
+
+	switch (spectre_v2_app2app) {
+	case SPECTRE_V2_APP2APP_NONE:
+		return PR_SPEC_ENABLE;
+	case SPECTRE_V2_APP2APP_PRCTL:
+		if (task_spec_indir_branch_force_disable(task))
+			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
+		if (test_tsk_thread_flag(task, TIF_SPEC_IB))
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
@@ -975,6 +1044,8 @@ static char *stibp_state(void)
 		return ", STIBP: disabled";
 	case SPECTRE_V2_APP2APP_STRICT:
 		return ", STIBP: forced";
+	case SPECTRE_V2_APP2APP_PRCTL:
+		return "";
 	}
 	return "";
 }
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1453,6 +1453,8 @@ static inline bool is_percpu_thread(void
 #define PFA_SPREAD_SLAB			2	/* Spread some slab caches over cpuset */
 #define PFA_SPEC_SSB_DISABLE		3	/* Speculative Store Bypass disabled */
 #define PFA_SPEC_SSB_FORCE_DISABLE	4	/* Speculative Store Bypass force disabled*/
+#define PFA_SPEC_INDIR_BRANCH_DISABLE	5	/* Indirect branch speculation restricted */
+#define PFA_SPEC_INDIR_BRANCH_FORCE_DISABLE 6	/* Indirect branch speculation permanentely restricted */
 
 #define TASK_PFA_TEST(name, func)					\
 	static inline bool task_##func(struct task_struct *p)		\
@@ -1484,6 +1486,13 @@ TASK_PFA_CLEAR(SPEC_SSB_DISABLE, spec_ss
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


