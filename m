Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB7BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430B3214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430B3214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbeIZH3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 03:29:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:52995 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbeIZH3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 03:29:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 18:18:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,304,1534834800"; 
   d="scan'208";a="72890399"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by fmsmga007.fm.intel.com with ESMTP; 25 Sep 2018 18:17:20 -0700
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
Subject: [Patch v2 4/4] x86/speculation: Add prctl to control indirect branch speculation per process
Date:   Tue, 25 Sep 2018 17:43:59 -0700
Message-Id: <ae3fb86f74de2001ddab477579afd813bca9baa9.1537920575.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1537920575.git.tim.c.chen@linux.intel.com>
References: <cover.1537920575.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1537920575.git.tim.c.chen@linux.intel.com>
References: <cover.1537920575.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To migitgate possible app to app attack from branch target buffer poisoning,
a new prctl is provided to control branch speculation for applications in
user app.  The following interfaces are provided:

prctl(PR_SET_SPECULATION_CTRL, PR_INDIR_BRANCH, PR_SPEC_DISABLE, 0, 0);
- Disable branch target speculation to protect against app to app
style attack using IBPB and STIBP

prctl(PR_SET_SPECULATION_CTRL, PR_INDIR_BRANCH, PR_SPEC_ENABLE, 0, 0);
- Allow branch target speculation, no mitigation for Spectre V2

prctl(PR_GET_SPECULATION_CTRL, PR_INDIR_BRANCH, 0, 0, 0)
- Query the indirect branch speculation restriction on a process

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 +-
 Documentation/userspace-api/spec_ctrl.rst       |  8 +++
 arch/x86/kernel/cpu/bugs.c                      | 82 ++++++++++++++++++++++++-
 arch/x86/mm/tlb.c                               | 30 ++-------
 fs/exec.c                                       | 13 +++-
 include/linux/sched.h                           |  5 ++
 include/linux/sched/coredump.h                  |  2 +-
 include/uapi/linux/prctl.h                      |  1 +
 kernel/cred.c                                   |  2 +-
 kernel/sys.c                                    |  2 +-
 tools/include/uapi/linux/prctl.h                |  1 +
 11 files changed, 117 insertions(+), 33 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6243144..640ce9a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4190,7 +4190,9 @@
 			[X86] Control app to app mitigation of Spectre variant 2
 			(indirect branch speculation) vulnerability.
 
-			lite   - only turn on mitigation for non-dumpable processes
+			lite   - turn on mitigation for non-dumpable processes
+				 or processes that has indirect branch restricted
+				 via prctl's PR_SET_SPECULATION_CTRL option
 			strict - protect against attacks for all user processes
 			auto   - let kernel decide lite or strict mode
 
diff --git a/Documentation/userspace-api/spec_ctrl.rst b/Documentation/userspace-api/spec_ctrl.rst
index 32f3d55..aa71e84 100644
--- a/Documentation/userspace-api/spec_ctrl.rst
+++ b/Documentation/userspace-api/spec_ctrl.rst
@@ -92,3 +92,11 @@ Speculation misfeature controls
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_ENABLE, 0, 0);
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_DISABLE, 0, 0);
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_FORCE_DISABLE, 0, 0);
+
+- PR_INDIR_BRANCH: Indirect Branch Speculation in Applications
+                   (Mitigate Spectre V2 style user space app to app attack)
+
+  Invocations:
+   * prctl(PR_GET_SPECULATION_CTRL, PR_INDIR_BRANCH, 0, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_INDIR_BRANCH, PR_SPEC_ENABLE, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_INDIR_BRANCH, PR_SPEC_DISABLE, 0, 0);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 052f1a5..2ec531f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/nospec.h>
 #include <linux/prctl.h>
+#include <linux/sched/coredump.h>
 
 #include <asm/spec-ctrl.h>
 #include <asm/cmdline.h>
@@ -150,7 +151,7 @@ static const char *spectre_v2_strings[] = {
 
 static const char *spectre_v2_app2app_strings[] = {
 	[SPECTRE_V2_APP2APP_NONE]		= "App-App Vulnerable",
-	[SPECTRE_V2_APP2APP_LITE]		= "App-App Mitigation: Protect only non-dumpable process",
+	[SPECTRE_V2_APP2APP_LITE]		= "App-App Mitigation: Protect non-dumpable or indir branch restricted process",
 	[SPECTRE_V2_APP2APP_STRICT]		= "App-App Mitigation: Full app to app attack protection",
 };
 
@@ -728,17 +729,74 @@ static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
 	return 0;
 }
 
+static int indir_branch_prctl_set(struct task_struct *task, unsigned long ctrl)
+{
+	bool update;
+
+	if (spectre_v2_app2app_enabled != SPECTRE_V2_APP2APP_LITE &&
+	    spectre_v2_app2app_enabled != SPECTRE_V2_APP2APP_STRICT)
+		return -ENXIO;
+
+	switch (ctrl) {
+	case PR_SPEC_ENABLE:
+		if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_STRICT)
+			return -ENXIO;
+		if (get_dumpable(task->mm) != SUID_DUMP_USER)
+			return -ENXIO;
+		task_clear_spec_indir_branch_disable(task);
+		update = test_and_clear_tsk_thread_flag(task, TIF_STIBP);
+		break;
+	case PR_SPEC_DISABLE:
+		if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_STRICT)
+			return 0;
+		task_set_spec_indir_branch_disable(task);
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
+		speculative_store_bypass_update_current();
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
 }
 
+void arch_set_dumpable(struct task_struct *tsk, struct mm_struct *mm, int value)
+{
+	if (!static_branch_unlikely(&spectre_v2_app_lite))
+		return;
+	if (!static_cpu_has(X86_FEATURE_STIBP))
+		return;
+
+	if ((unsigned) value != SUID_DUMP_USER) {
+		set_tsk_thread_flag(tsk, TIF_STIBP);
+		return;
+	}
+
+	if (!task_spec_indir_branch_disable(tsk)) {
+		clear_tsk_thread_flag(tsk, TIF_STIBP);
+	}
+}
+
 #ifdef CONFIG_SECCOMP
 void arch_seccomp_spec_mitigate(struct task_struct *task)
 {
@@ -766,11 +824,33 @@ static int ssb_prctl_get(struct task_struct *task)
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
+		if (task_spec_indir_branch_disable(task) ||
+			get_dumpable(task->mm) != SUID_DUMP_USER)
+			return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
+		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
+	case SPECTRE_V2_APP2APP_STRICT:
+		return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
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
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index b3d1daa..65329a7 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -184,8 +184,9 @@ static void sync_current_stack_to_mm(struct mm_struct *mm)
 static bool ibpb_needed(struct task_struct *tsk, u64 last_ctx_id)
 {
 	/*
-	 * For lite protection mode, we only protect the non-dumpable
-	 * processes.
+	 * For lite protection mode, we protect processes  
+	 * where the user explicitly disable indirect branch
+	 * speculation or mark the process as non-dumpable. 
 	 *
 	 * Otherwise check if the current (previous) task has access to the memory
 	 * of the @tsk (next) task for strict app to app protection.
@@ -200,30 +201,12 @@ static bool ibpb_needed(struct task_struct *tsk, u64 last_ctx_id)
 		return false;
 
 	if (static_branch_unlikely(&spectre_v2_app_lite))
-		return (get_dumpable(tsk->mm) != SUID_DUMP_USER);
+		return (get_dumpable(tsk->mm) != SUID_DUMP_USER ||
+			task_thread_info(tsk)->flags & _TIF_STIBP);
 	else
 		return (__ptrace_may_access(tsk, PTRACE_MODE_IBPB));
 }
 
-static void set_stibp(struct task_struct *tsk)
-{
-	/*
-	 * For lite protection mode, we set STIBP only 
-	 * for non-dumpable processes.
-	 */
-
-	if (!static_branch_unlikely(&spectre_v2_app_lite))
-		return;
-
-	if (!tsk || !tsk->mm)
-		return;
-
-	if (get_dumpable(tsk->mm) != SUID_DUMP_USER)
-		set_tsk_thread_flag(tsk, TIF_STIBP);
-	else
-		clear_tsk_thread_flag(tsk, TIF_STIBP);
-}
-
 void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 			struct task_struct *tsk)
 {
@@ -315,9 +298,6 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 				ibpb_needed(tsk, last_ctx_id))
 			indirect_branch_prediction_barrier();
 
-		if (static_cpu_has(X86_FEATURE_STIBP))
-			set_stibp(tsk);	
-
 		if (IS_ENABLED(CONFIG_VMAP_STACK)) {
 			/*
 			 * If our current stack is in vmalloc space and isn't
diff --git a/fs/exec.c b/fs/exec.c
index 1ebf6e5..89edadd 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1362,9 +1362,9 @@ void setup_new_exec(struct linux_binprm * bprm)
 	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
 	    !(uid_eq(current_euid(), current_uid()) &&
 	      gid_eq(current_egid(), current_gid())))
-		set_dumpable(current->mm, suid_dumpable);
+		set_dumpable(current, current->mm, suid_dumpable);
 	else
-		set_dumpable(current->mm, SUID_DUMP_USER);
+		set_dumpable(current, current->mm, SUID_DUMP_USER);
 
 	arch_setup_new_exec();
 	perf_event_exec();
@@ -1940,10 +1940,15 @@ void set_binfmt(struct linux_binfmt *new)
 }
 EXPORT_SYMBOL(set_binfmt);
 
+void __weak arch_set_dumpable(struct task_struct *tsk, struct mm_struct *mm, int value)
+{
+	return;
+}
+
 /*
  * set_dumpable stores three-value SUID_DUMP_* into mm->flags.
  */
-void set_dumpable(struct mm_struct *mm, int value)
+void set_dumpable(struct task_struct *tsk, struct mm_struct *mm, int value)
 {
 	unsigned long old, new;
 
@@ -1954,6 +1959,8 @@ void set_dumpable(struct mm_struct *mm, int value)
 		old = READ_ONCE(mm->flags);
 		new = (old & ~MMF_DUMPABLE_MASK) | value;
 	} while (cmpxchg(&mm->flags, old, new) != old);
+
+	arch_set_dumpable(tsk, mm, value);
 }
 
 SYSCALL_DEFINE3(execve,
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 977cb57..b0a78fd 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1439,6 +1439,7 @@ static inline bool is_percpu_thread(void)
 #define PFA_SPREAD_SLAB			2	/* Spread some slab caches over cpuset */
 #define PFA_SPEC_SSB_DISABLE		3	/* Speculative Store Bypass disabled */
 #define PFA_SPEC_SSB_FORCE_DISABLE	4	/* Speculative Store Bypass force disabled*/
+#define PFA_SPEC_INDIR_BRANCH_DISABLE	5	/* Indirect branch speculation restricted in apps */
 
 #define TASK_PFA_TEST(name, func)					\
 	static inline bool task_##func(struct task_struct *p)		\
@@ -1470,6 +1471,10 @@ TASK_PFA_CLEAR(SPEC_SSB_DISABLE, spec_ssb_disable)
 TASK_PFA_TEST(SPEC_SSB_FORCE_DISABLE, spec_ssb_force_disable)
 TASK_PFA_SET(SPEC_SSB_FORCE_DISABLE, spec_ssb_force_disable)
 
+TASK_PFA_TEST(SPEC_INDIR_BRANCH_DISABLE, spec_indir_branch_disable)
+TASK_PFA_SET(SPEC_INDIR_BRANCH_DISABLE, spec_indir_branch_disable)
+TASK_PFA_CLEAR(SPEC_INDIR_BRANCH_DISABLE, spec_indir_branch_disable)
+
 static inline void
 current_restore_flags(unsigned long orig_flags, unsigned long flags)
 {
diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index ec912d0..4284350 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -14,7 +14,7 @@
 #define MMF_DUMPABLE_BITS 2
 #define MMF_DUMPABLE_MASK ((1 << MMF_DUMPABLE_BITS) - 1)
 
-extern void set_dumpable(struct mm_struct *mm, int value);
+extern void set_dumpable(struct task_struct *tsk, struct mm_struct *mm, int value);
 /*
  * This returns the actual value of the suid_dumpable flag. For things
  * that are using this for checking for privilege transitions, it must
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
diff --git a/kernel/cred.c b/kernel/cred.c
index ecf0365..de3f486 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -446,7 +446,7 @@ int commit_creds(struct cred *new)
 	    !gid_eq(old->fsgid, new->fsgid) ||
 	    !cred_cap_issubset(old, new)) {
 		if (task->mm)
-			set_dumpable(task->mm, suid_dumpable);
+			set_dumpable(task, task->mm, suid_dumpable);
 		task->pdeath_signal = 0;
 		smp_wmb();
 	}
diff --git a/kernel/sys.c b/kernel/sys.c
index cf5c675..78af561 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2292,7 +2292,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			error = -EINVAL;
 			break;
 		}
-		set_dumpable(me->mm, arg2);
+		set_dumpable(me, me->mm, arg2);
 		break;
 
 	case PR_SET_UNALIGN:
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

