Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666D2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CC620989
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23CC620989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbeK2BhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:37:24 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46451 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeK2BhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:37:23 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wASEYmK82324220
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 06:34:48 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wASEYm3p2324217;
        Wed, 28 Nov 2018 06:34:48 -0800
Date:   Wed, 28 Nov 2018 06:34:48 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-9137bb27e60e554dab694eafa4cca241fa3a694f@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        david.c.stewart@intel.com, asit.k.mallick@intel.com,
        tim.c.chen@linux.intel.com, keescook@chromium.org,
        dwmw@amazon.co.uk, mingo@kernel.org, thomas.lendacky@amd.com,
        peterz@infradead.org, dave.hansen@intel.com, jpoimboe@redhat.com,
        torvalds@linux-foundation.org, hpa@zytor.com, jcm@redhat.com,
        gregkh@linuxfoundation.org, casey.schaufler@intel.com,
        arjan@linux.intel.com, longman9394@gmail.com, jkosina@suse.cz,
        luto@kernel.org, ak@linux.intel.com, aarcange@redhat.com
Reply-To: longman9394@gmail.com, arjan@linux.intel.com,
          casey.schaufler@intel.com, ak@linux.intel.com, jkosina@suse.cz,
          luto@kernel.org, aarcange@redhat.com, asit.k.mallick@intel.com,
          david.c.stewart@intel.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, keescook@chromium.org,
          tim.c.chen@linux.intel.com, thomas.lendacky@amd.com,
          peterz@infradead.org, dave.hansen@intel.com, mingo@kernel.org,
          dwmw@amazon.co.uk, gregkh@linuxfoundation.org, jcm@redhat.com,
          hpa@zytor.com, torvalds@linux-foundation.org, jpoimboe@redhat.com
In-Reply-To: <20181125185005.866780996@linutronix.de>
References: <20181125185005.866780996@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Add prctl() control for indirect
 branch speculation
Git-Commit-ID: 9137bb27e60e554dab694eafa4cca241fa3a694f
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

Commit-ID:  9137bb27e60e554dab694eafa4cca241fa3a694f
Gitweb:     https://git.kernel.org/tip/9137bb27e60e554dab694eafa4cca241fa3a694f
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 25 Nov 2018 19:33:53 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Nov 2018 11:57:13 +0100

x86/speculation: Add prctl() control for indirect branch speculation

Add the PR_SPEC_INDIRECT_BRANCH option for the PR_GET_SPECULATION_CTRL and
PR_SET_SPECULATION_CTRL prctls to allow fine grained per task control of
indirect branch speculation via STIBP and IBPB.

Invocations:
 Check indirect branch speculation status with
 - prctl(PR_GET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, 0, 0, 0);

 Enable indirect branch speculation with
 - prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, PR_SPEC_ENABLE, 0, 0);

 Disable indirect branch speculation with
 - prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, PR_SPEC_DISABLE, 0, 0);

 Force disable indirect branch speculation with
 - prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, PR_SPEC_FORCE_DISABLE, 0, 0);

See Documentation/userspace-api/spec_ctrl.rst.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
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
Link: https://lkml.kernel.org/r/20181125185005.866780996@linutronix.de

---
 Documentation/userspace-api/spec_ctrl.rst |  9 +++++
 arch/x86/include/asm/nospec-branch.h      |  1 +
 arch/x86/kernel/cpu/bugs.c                | 67 +++++++++++++++++++++++++++++++
 arch/x86/kernel/process.c                 |  5 +++
 include/linux/sched.h                     |  9 +++++
 include/uapi/linux/prctl.h                |  1 +
 tools/include/uapi/linux/prctl.h          |  1 +
 7 files changed, 93 insertions(+)

diff --git a/Documentation/userspace-api/spec_ctrl.rst b/Documentation/userspace-api/spec_ctrl.rst
index 32f3d55c54b7..c4dbe6f7cdae 100644
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
+   * prctl(PR_GET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, 0, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, PR_SPEC_ENABLE, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, PR_SPEC_DISABLE, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, PR_SPEC_FORCE_DISABLE, 0, 0);
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index d4d35baf0430..2adbe7b047fa 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -232,6 +232,7 @@ enum spectre_v2_mitigation {
 enum spectre_v2_user_mitigation {
 	SPECTRE_V2_USER_NONE,
 	SPECTRE_V2_USER_STRICT,
+	SPECTRE_V2_USER_PRCTL,
 };
 
 /* The Speculative Store Bypass disable variants */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 9cab538e10f1..74359fff87fd 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -566,6 +566,8 @@ void arch_smt_update(void)
 	case SPECTRE_V2_USER_STRICT:
 		update_stibp_strict();
 		break;
+	case SPECTRE_V2_USER_PRCTL:
+		break;
 	}
 
 	mutex_unlock(&spec_ctrl_mutex);
@@ -752,12 +754,50 @@ static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
 	return 0;
 }
 
+static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
+{
+	switch (ctrl) {
+	case PR_SPEC_ENABLE:
+		if (spectre_v2_user == SPECTRE_V2_USER_NONE)
+			return 0;
+		/*
+		 * Indirect branch speculation is always disabled in strict
+		 * mode.
+		 */
+		if (spectre_v2_user == SPECTRE_V2_USER_STRICT)
+			return -EPERM;
+		task_clear_spec_ib_disable(task);
+		task_update_spec_tif(task);
+		break;
+	case PR_SPEC_DISABLE:
+	case PR_SPEC_FORCE_DISABLE:
+		/*
+		 * Indirect branch speculation is always allowed when
+		 * mitigation is force disabled.
+		 */
+		if (spectre_v2_user == SPECTRE_V2_USER_NONE)
+			return -EPERM;
+		if (spectre_v2_user == SPECTRE_V2_USER_STRICT)
+			return 0;
+		task_set_spec_ib_disable(task);
+		if (ctrl == PR_SPEC_FORCE_DISABLE)
+			task_set_spec_ib_force_disable(task);
+		task_update_spec_tif(task);
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
+	case PR_SPEC_INDIRECT_BRANCH:
+		return ib_prctl_set(task, ctrl);
 	default:
 		return -ENODEV;
 	}
@@ -790,11 +830,34 @@ static int ssb_prctl_get(struct task_struct *task)
 	}
 }
 
+static int ib_prctl_get(struct task_struct *task)
+{
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
+		return PR_SPEC_NOT_AFFECTED;
+
+	switch (spectre_v2_user) {
+	case SPECTRE_V2_USER_NONE:
+		return PR_SPEC_ENABLE;
+	case SPECTRE_V2_USER_PRCTL:
+		if (task_spec_ib_force_disable(task))
+			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
+		if (task_spec_ib_disable(task))
+			return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
+		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
+	case SPECTRE_V2_USER_STRICT:
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
+	case PR_SPEC_INDIRECT_BRANCH:
+		return ib_prctl_get(task);
 	default:
 		return -ENODEV;
 	}
@@ -974,6 +1037,8 @@ static char *stibp_state(void)
 		return ", STIBP: disabled";
 	case SPECTRE_V2_USER_STRICT:
 		return ", STIBP: forced";
+	case SPECTRE_V2_USER_PRCTL:
+		return "";
 	}
 	return "";
 }
@@ -986,6 +1051,8 @@ static char *ibpb_state(void)
 			return ", IBPB: disabled";
 		case SPECTRE_V2_USER_STRICT:
 			return ", IBPB: always-on";
+		case SPECTRE_V2_USER_PRCTL:
+			return "";
 		}
 	}
 	return "";
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index afbe2eb4a1c6..7d31192296a8 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -450,6 +450,11 @@ static unsigned long speculation_ctrl_update_tif(struct task_struct *tsk)
 			set_tsk_thread_flag(tsk, TIF_SSBD);
 		else
 			clear_tsk_thread_flag(tsk, TIF_SSBD);
+
+		if (task_spec_ib_disable(tsk))
+			set_tsk_thread_flag(tsk, TIF_SPEC_IB);
+		else
+			clear_tsk_thread_flag(tsk, TIF_SPEC_IB);
 	}
 	/* Return the updated threadinfo flags*/
 	return task_thread_info(tsk)->flags;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index a51c13c2b1a0..d607db5fcc6a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1453,6 +1453,8 @@ static inline bool is_percpu_thread(void)
 #define PFA_SPREAD_SLAB			2	/* Spread some slab caches over cpuset */
 #define PFA_SPEC_SSB_DISABLE		3	/* Speculative Store Bypass disabled */
 #define PFA_SPEC_SSB_FORCE_DISABLE	4	/* Speculative Store Bypass force disabled*/
+#define PFA_SPEC_IB_DISABLE		5	/* Indirect branch speculation restricted */
+#define PFA_SPEC_IB_FORCE_DISABLE	6	/* Indirect branch speculation permanently restricted */
 
 #define TASK_PFA_TEST(name, func)					\
 	static inline bool task_##func(struct task_struct *p)		\
@@ -1484,6 +1486,13 @@ TASK_PFA_CLEAR(SPEC_SSB_DISABLE, spec_ssb_disable)
 TASK_PFA_TEST(SPEC_SSB_FORCE_DISABLE, spec_ssb_force_disable)
 TASK_PFA_SET(SPEC_SSB_FORCE_DISABLE, spec_ssb_force_disable)
 
+TASK_PFA_TEST(SPEC_IB_DISABLE, spec_ib_disable)
+TASK_PFA_SET(SPEC_IB_DISABLE, spec_ib_disable)
+TASK_PFA_CLEAR(SPEC_IB_DISABLE, spec_ib_disable)
+
+TASK_PFA_TEST(SPEC_IB_FORCE_DISABLE, spec_ib_force_disable)
+TASK_PFA_SET(SPEC_IB_FORCE_DISABLE, spec_ib_force_disable)
+
 static inline void
 current_restore_flags(unsigned long orig_flags, unsigned long flags)
 {
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index c0d7ea0bf5b6..b17201edfa09 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -212,6 +212,7 @@ struct prctl_mm_map {
 #define PR_SET_SPECULATION_CTRL		53
 /* Speculation control variants */
 # define PR_SPEC_STORE_BYPASS		0
+# define PR_SPEC_INDIRECT_BRANCH	1
 /* Return and control values for PR_SET/GET_SPECULATION_CTRL */
 # define PR_SPEC_NOT_AFFECTED		0
 # define PR_SPEC_PRCTL			(1UL << 0)
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index c0d7ea0bf5b6..b17201edfa09 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -212,6 +212,7 @@ struct prctl_mm_map {
 #define PR_SET_SPECULATION_CTRL		53
 /* Speculation control variants */
 # define PR_SPEC_STORE_BYPASS		0
+# define PR_SPEC_INDIRECT_BRANCH	1
 /* Return and control values for PR_SET/GET_SPECULATION_CTRL */
 # define PR_SPEC_NOT_AFFECTED		0
 # define PR_SPEC_PRCTL			(1UL << 0)
