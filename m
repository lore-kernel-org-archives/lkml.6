Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9B8C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5DB214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jh1egg4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B5DB214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbeLDK53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:57:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:41292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbeLDK5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:57:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03DAC214DA;
        Tue,  4 Dec 2018 10:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921044;
        bh=EcZxHCZezCyU4AFYBrzSPiXRtS4nFCYC815nHCco10o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jh1egg4+r7FBmUy+RgzRq0hw2x1XGm2jYQ1j1KoH8dLo/iQU3Qo/gaP9D3+u8RPRO
         ef3+1dwlCafttKhOWWiSaFQpZPA5eDYGD8nMr8C8CtXFoFLpLSkFz1f9MmrG9HgVRB
         Sqgv1g5EPmmzDjlCU5jU06qT6BMfGwZETco3SnS4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.19 058/139] x86/speculation: Add prctl() control for indirect branch speculation
Date:   Tue,  4 Dec 2018 11:48:59 +0100
Message-Id: <20181204103652.354066865@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner tglx@linutronix.de

commit 9137bb27e60e554dab694eafa4cca241fa3a694f upstream

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/userspace-api/spec_ctrl.rst |    9 ++++
 arch/x86/include/asm/nospec-branch.h      |    1 
 arch/x86/kernel/cpu/bugs.c                |   67 ++++++++++++++++++++++++++++++
 arch/x86/kernel/process.c                 |    5 ++
 include/linux/sched.h                     |    9 ++++
 include/uapi/linux/prctl.h                |    1 
 tools/include/uapi/linux/prctl.h          |    1 
 7 files changed, 93 insertions(+)

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
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -232,6 +232,7 @@ enum spectre_v2_mitigation {
 enum spectre_v2_user_mitigation {
 	SPECTRE_V2_USER_NONE,
 	SPECTRE_V2_USER_STRICT,
+	SPECTRE_V2_USER_PRCTL,
 };
 
 /* The Speculative Store Bypass disable variants */
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -564,6 +564,8 @@ void arch_smt_update(void)
 	case SPECTRE_V2_USER_STRICT:
 		update_stibp_strict();
 		break;
+	case SPECTRE_V2_USER_PRCTL:
+		break;
 	}
 
 	mutex_unlock(&spec_ctrl_mutex);
@@ -750,12 +752,50 @@ static int ssb_prctl_set(struct task_str
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
@@ -788,11 +828,34 @@ static int ssb_prctl_get(struct task_str
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
@@ -972,6 +1035,8 @@ static char *stibp_state(void)
 		return ", STIBP: disabled";
 	case SPECTRE_V2_USER_STRICT:
 		return ", STIBP: forced";
+	case SPECTRE_V2_USER_PRCTL:
+		return "";
 	}
 	return "";
 }
@@ -984,6 +1049,8 @@ static char *ibpb_state(void)
 			return ", IBPB: disabled";
 		case SPECTRE_V2_USER_STRICT:
 			return ", IBPB: always-on";
+		case SPECTRE_V2_USER_PRCTL:
+			return "";
 		}
 	}
 	return "";
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -450,6 +450,11 @@ static unsigned long speculation_ctrl_up
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
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1439,6 +1439,8 @@ static inline bool is_percpu_thread(void
 #define PFA_SPREAD_SLAB			2	/* Spread some slab caches over cpuset */
 #define PFA_SPEC_SSB_DISABLE		3	/* Speculative Store Bypass disabled */
 #define PFA_SPEC_SSB_FORCE_DISABLE	4	/* Speculative Store Bypass force disabled*/
+#define PFA_SPEC_IB_DISABLE		5	/* Indirect branch speculation restricted */
+#define PFA_SPEC_IB_FORCE_DISABLE	6	/* Indirect branch speculation permanently restricted */
 
 #define TASK_PFA_TEST(name, func)					\
 	static inline bool task_##func(struct task_struct *p)		\
@@ -1470,6 +1472,13 @@ TASK_PFA_CLEAR(SPEC_SSB_DISABLE, spec_ss
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


