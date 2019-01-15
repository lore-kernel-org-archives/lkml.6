Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C723C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 265E320656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390374AbfAOVVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:21:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733166AbfAOVVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:21:53 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 39DE581F0F;
        Tue, 15 Jan 2019 21:21:51 +0000 (UTC)
Received: from llong.com (dhcp-17-223.bos.redhat.com [10.18.17.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 279F11001F3C;
        Tue, 15 Jan 2019 21:21:48 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2] x86/speculation: Add PR_SPEC_DISABLE_NOEXEC
Date:   Tue, 15 Jan 2019 16:21:34 -0500
Message-Id: <1547587294-7132-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 15 Jan 2019 21:21:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the default SPEC_STORE_BYPASS_SECCOMP/SPEC_STORE_BYPASS_PRCTL mode,
the TIF_SSBD bit will be inherited when a new task is fork'ed or cloned.
It will also remain when a new program is execve'ed.

Only certain class of applications (like Java) that can run on behalf
of multiple users on a single thread will require disabling speculative
store bypass for security purpose. Those applications will call prctl(2)
at startup time to disable SSB. They won't rely on the fact the SSB might
have been disabled. Other applications that don't need SSBD will just
move on without checking if SSBD has been turned on or not.

The fact that the TIF_SSBD is inherited across execve(2) boundary
will cause performance of applications that don't need SSBD but their
predecessors have SSBD on to be unwittingly impacted especially if they
write to memory a lot.

To remedy this problem, a new PR_SPEC_DISABLE_NOEXEC argument for the
PR_SET_SPECULATION_CTRL option of prctl(2) is added to allow applications
to specify that the SSBD feature bit on the task structure should be
cleared whenever a new program is being execve'ed.

Signed-off-by: Waiman Long <longman@redhat.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
---
 Documentation/userspace-api/spec_ctrl.rst | 27 +++++++++++++++------------
 arch/x86/kernel/cpu/bugs.c                | 10 ++++++++++
 arch/x86/kernel/process.c                 | 12 ++++++++++++
 include/linux/sched.h                     |  5 +++++
 include/uapi/linux/prctl.h                |  1 +
 tools/include/uapi/linux/prctl.h          |  1 +
 6 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/Documentation/userspace-api/spec_ctrl.rst b/Documentation/userspace-api/spec_ctrl.rst
index c4dbe6f..1129c75 100644
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
index 1de0f41..484aca4 100644
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
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 90ae0ca..58ac7be 100644
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
index 2246662..fa4ea62 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1458,6 +1458,7 @@ static inline bool is_percpu_thread(void)
 #define PFA_SPEC_SSB_FORCE_DISABLE	4	/* Speculative Store Bypass force disabled*/
 #define PFA_SPEC_IB_DISABLE		5	/* Indirect branch speculation restricted */
 #define PFA_SPEC_IB_FORCE_DISABLE	6	/* Indirect branch speculation permanently restricted */
+#define PFA_SPEC_SSB_NOEXEC		7	/* Speculative Store Bypass clear on execve() */
 
 #define TASK_PFA_TEST(name, func)					\
 	static inline bool task_##func(struct task_struct *p)		\
@@ -1486,6 +1487,10 @@ static inline bool is_percpu_thread(void)
 TASK_PFA_SET(SPEC_SSB_DISABLE, spec_ssb_disable)
 TASK_PFA_CLEAR(SPEC_SSB_DISABLE, spec_ssb_disable)
 
+TASK_PFA_TEST(SPEC_SSB_NOEXEC, spec_ssb_noexec)
+TASK_PFA_SET(SPEC_SSB_NOEXEC, spec_ssb_noexec)
+TASK_PFA_CLEAR(SPEC_SSB_NOEXEC, spec_ssb_noexec)
+
 TASK_PFA_TEST(SPEC_SSB_FORCE_DISABLE, spec_ssb_force_disable)
 TASK_PFA_SET(SPEC_SSB_FORCE_DISABLE, spec_ssb_force_disable)
 
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index b4875a9..094bb03 100644
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
index b4875a9..094bb03 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -219,6 +219,7 @@ struct prctl_mm_map {
 # define PR_SPEC_ENABLE			(1UL << 1)
 # define PR_SPEC_DISABLE		(1UL << 2)
 # define PR_SPEC_FORCE_DISABLE		(1UL << 3)
+# define PR_SPEC_DISABLE_NOEXEC		(1UL << 4)
 
 /* Reset arm64 pointer authentication keys */
 #define PR_PAC_RESET_KEYS		54
-- 
1.8.3.1

