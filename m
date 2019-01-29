Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF17C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8D920881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbfA2VQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:16:45 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57627 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfA2VQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 16:16:45 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0TLG0fn2100703
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 29 Jan 2019 13:16:00 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0TLFxX12100698;
        Tue, 29 Jan 2019 13:15:59 -0800
Date:   Tue, 29 Jan 2019 13:15:59 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-71368af9027f18fe5d1c6f372cfdff7e4bde8b48@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, karahmed@amazon.de,
        dwmw@amazon.co.uk, longman@redhat.com, ak@linux.intel.com,
        tglx@linutronix.de, corbet@lwn.net, peterz@infradead.org,
        jpoimboe@redhat.com, hpa@zytor.com, mingo@kernel.org,
        jikos@kernel.org, tim.c.chen@linux.intel.com,
        konrad.wilk@oracle.com
Reply-To: konrad.wilk@oracle.com, longman@redhat.com, mingo@kernel.org,
          jikos@kernel.org, tim.c.chen@linux.intel.com, dwmw@amazon.co.uk,
          karahmed@amazon.de, peterz@infradead.org, jpoimboe@redhat.com,
          hpa@zytor.com, ak@linux.intel.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, bp@alien8.de, corbet@lwn.net
In-Reply-To: <1547676096-3281-1-git-send-email-longman@redhat.com>
References: <1547676096-3281-1-git-send-email-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Add PR_SPEC_DISABLE_NOEXEC
Git-Commit-ID: 71368af9027f18fe5d1c6f372cfdff7e4bde8b48
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

Commit-ID:  71368af9027f18fe5d1c6f372cfdff7e4bde8b48
Gitweb:     https://git.kernel.org/tip/71368af9027f18fe5d1c6f372cfdff7e4bde8b48
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Wed, 16 Jan 2019 17:01:36 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 29 Jan 2019 22:11:49 +0100

x86/speculation: Add PR_SPEC_DISABLE_NOEXEC

With the default SPEC_STORE_BYPASS_SECCOMP/SPEC_STORE_BYPASS_PRCTL mode,
the TIF_SSBD bit will be inherited when a new task is fork'ed or cloned.
It will also remain when a new program is execve'ed.

Only certain class of applications (like Java) that can run on behalf of
multiple users on a single thread will require disabling speculative store
bypass for security purposes. Those applications will call prctl(2) at
startup time to disable SSB. They won't rely on the fact the SSB might have
been disabled. Other applications that don't need SSBD will just move on
without checking if SSBD has been turned on or not.

The fact that the TIF_SSBD is inherited across execve(2) boundary will
cause performance of applications that don't need SSBD but their
predecessors have SSBD on to be unwittingly impacted especially if they
write to memory a lot.

To remedy this problem, a new PR_SPEC_DISABLE_NOEXEC argument for the
PR_SET_SPECULATION_CTRL option of prctl(2) is added to allow applications
to specify that the SSBD feature bit on the task structure should be
cleared whenever a new program is being execve'ed.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Link: https://lkml.kernel.org/r/1547676096-3281-1-git-send-email-longman@redhat.com

---
 Documentation/userspace-api/spec_ctrl.rst | 27 +++++++++++++++------------
 arch/x86/kernel/cpu/bugs.c                | 12 ++++++++++++
 arch/x86/kernel/process.c                 | 12 ++++++++++++
 include/linux/sched.h                     |  5 +++++
 include/uapi/linux/prctl.h                |  1 +
 tools/include/uapi/linux/prctl.h          |  1 +
 6 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/Documentation/userspace-api/spec_ctrl.rst b/Documentation/userspace-api/spec_ctrl.rst
index c4dbe6f7cdae..1129c7550a48 100644
--- a/Documentation/userspace-api/spec_ctrl.rst
+++ b/Documentation/userspace-api/spec_ctrl.rst
@@ -28,18 +28,20 @@ PR_GET_SPECULATION_CTRL returns the state of the speculation misfeature
 which is selected with arg2 of prctl(2). The return value uses bits 0-3 with
 the following meaning:
 
-==== ===================== ===================================================
-Bit  Define                Description
-==== ===================== ===================================================
-0    PR_SPEC_PRCTL         Mitigation can be controlled per task by
-                           PR_SET_SPECULATION_CTRL.
-1    PR_SPEC_ENABLE        The speculation feature is enabled, mitigation is
-                           disabled.
-2    PR_SPEC_DISABLE       The speculation feature is disabled, mitigation is
-                           enabled.
-3    PR_SPEC_FORCE_DISABLE Same as PR_SPEC_DISABLE, but cannot be undone. A
-                           subsequent prctl(..., PR_SPEC_ENABLE) will fail.
-==== ===================== ===================================================
+==== ====================== ==================================================
+Bit  Define                 Description
+==== ====================== ==================================================
+0    PR_SPEC_PRCTL          Mitigation can be controlled per task by
+                            PR_SET_SPECULATION_CTRL.
+1    PR_SPEC_ENABLE         The speculation feature is enabled, mitigation is
+                            disabled.
+2    PR_SPEC_DISABLE        The speculation feature is disabled, mitigation is
+                            enabled.
+3    PR_SPEC_FORCE_DISABLE  Same as PR_SPEC_DISABLE, but cannot be undone. A
+                            subsequent prctl(..., PR_SPEC_ENABLE) will fail.
+4    PR_SPEC_DISABLE_NOEXEC Same as PR_SPEC_DISABLE, but the state will be
+                            cleared on :manpage:`execve(2)`.
+==== ====================== ==================================================
 
 If all bits are 0 the CPU is not affected by the speculation misfeature.
 
@@ -92,6 +94,7 @@ Speculation misfeature controls
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_ENABLE, 0, 0);
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_DISABLE, 0, 0);
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_FORCE_DISABLE, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_DISABLE_NOEXEC, 0, 0);
 
 - PR_SPEC_INDIR_BRANCH: Indirect Branch Speculation in User Processes
                         (Mitigate Spectre V2 style attacks against user processes)
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 1de0f4170178..2faeaf46347a 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -798,15 +798,25 @@ static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
 		if (task_spec_ssb_force_disable(task))
 			return -EPERM;
 		task_clear_spec_ssb_disable(task);
+		task_clear_spec_ssb_noexec(task);
 		task_update_spec_tif(task);
 		break;
 	case PR_SPEC_DISABLE:
 		task_set_spec_ssb_disable(task);
+		task_clear_spec_ssb_noexec(task);
 		task_update_spec_tif(task);
 		break;
 	case PR_SPEC_FORCE_DISABLE:
 		task_set_spec_ssb_disable(task);
 		task_set_spec_ssb_force_disable(task);
+		task_clear_spec_ssb_noexec(task);
+		task_update_spec_tif(task);
+		break;
+	case PR_SPEC_DISABLE_NOEXEC:
+		if (task_spec_ssb_force_disable(task))
+			return -EPERM;
+		task_set_spec_ssb_disable(task);
+		task_set_spec_ssb_noexec(task);
 		task_update_spec_tif(task);
 		break;
 	default:
@@ -885,6 +895,8 @@ static int ssb_prctl_get(struct task_struct *task)
 	case SPEC_STORE_BYPASS_PRCTL:
 		if (task_spec_ssb_force_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
+		if (task_spec_ssb_noexec(task))
+			return PR_SPEC_PRCTL | PR_SPEC_DISABLE_NOEXEC;
 		if (task_spec_ssb_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
 		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 90ae0ca51083..58ac7be52c7a 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -255,6 +255,18 @@ void arch_setup_new_exec(void)
 	/* If cpuid was previously disabled for this task, re-enable it. */
 	if (test_thread_flag(TIF_NOCPUID))
 		enable_cpuid();
+
+	/*
+	 * Don't inherit TIF_SSBD across exec boundary when
+	 * PR_SPEC_DISABLE_NOEXEC is used.
+	 */
+	if (test_thread_flag(TIF_SSBD) &&
+	    task_spec_ssb_noexec(current)) {
+		clear_thread_flag(TIF_SSBD);
+		task_clear_spec_ssb_disable(current);
+		task_clear_spec_ssb_noexec(current);
+		speculation_ctrl_update(task_thread_info(current)->flags);
+	}
 }
 
 static inline void switch_to_bitmap(struct thread_struct *prev,
diff --git a/include/linux/sched.h b/include/linux/sched.h
index d2f90fa92468..fc836dc71bba 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1459,6 +1459,7 @@ static inline bool is_percpu_thread(void)
 #define PFA_SPEC_SSB_FORCE_DISABLE	4	/* Speculative Store Bypass force disabled*/
 #define PFA_SPEC_IB_DISABLE		5	/* Indirect branch speculation restricted */
 #define PFA_SPEC_IB_FORCE_DISABLE	6	/* Indirect branch speculation permanently restricted */
+#define PFA_SPEC_SSB_NOEXEC		7	/* Speculative Store Bypass clear on execve() */
 
 #define TASK_PFA_TEST(name, func)					\
 	static inline bool task_##func(struct task_struct *p)		\
@@ -1487,6 +1488,10 @@ TASK_PFA_TEST(SPEC_SSB_DISABLE, spec_ssb_disable)
 TASK_PFA_SET(SPEC_SSB_DISABLE, spec_ssb_disable)
 TASK_PFA_CLEAR(SPEC_SSB_DISABLE, spec_ssb_disable)
 
+TASK_PFA_TEST(SPEC_SSB_NOEXEC, spec_ssb_noexec)
+TASK_PFA_SET(SPEC_SSB_NOEXEC, spec_ssb_noexec)
+TASK_PFA_CLEAR(SPEC_SSB_NOEXEC, spec_ssb_noexec)
+
 TASK_PFA_TEST(SPEC_SSB_FORCE_DISABLE, spec_ssb_force_disable)
 TASK_PFA_SET(SPEC_SSB_FORCE_DISABLE, spec_ssb_force_disable)
 
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index b4875a93363a..094bb03b9cc2 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -219,6 +219,7 @@ struct prctl_mm_map {
 # define PR_SPEC_ENABLE			(1UL << 1)
 # define PR_SPEC_DISABLE		(1UL << 2)
 # define PR_SPEC_FORCE_DISABLE		(1UL << 3)
+# define PR_SPEC_DISABLE_NOEXEC		(1UL << 4)
 
 /* Reset arm64 pointer authentication keys */
 #define PR_PAC_RESET_KEYS		54
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index b4875a93363a..094bb03b9cc2 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -219,6 +219,7 @@ struct prctl_mm_map {
 # define PR_SPEC_ENABLE			(1UL << 1)
 # define PR_SPEC_DISABLE		(1UL << 2)
 # define PR_SPEC_FORCE_DISABLE		(1UL << 3)
+# define PR_SPEC_DISABLE_NOEXEC		(1UL << 4)
 
 /* Reset arm64 pointer authentication keys */
 #define PR_PAC_RESET_KEYS		54
