Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51985C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA6B2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA6B2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbeK2BgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:36:12 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56029 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeK2BgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:36:12 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wASEXeNJ2324064
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 06:33:40 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wASEXels2324061;
        Wed, 28 Nov 2018 06:33:40 -0800
Date:   Wed, 28 Nov 2018 06:33:40 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-6d991ba509ebcfcc908e009d1db51972a4f7a064@git.kernel.org>
Cc:     dwmw@amazon.co.uk, torvalds@linux-foundation.org, jcm@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        aarcange@redhat.com, ak@linux.intel.com, jkosina@suse.cz,
        thomas.lendacky@amd.com, dave.hansen@intel.com,
        david.c.stewart@intel.com, jpoimboe@redhat.com,
        arjan@linux.intel.com, casey.schaufler@intel.com, mingo@kernel.org,
        asit.k.mallick@intel.com, peterz@infradead.org,
        keescook@chromium.org, longman9394@gmail.com,
        tim.c.chen@linux.intel.com, gregkh@linuxfoundation.org,
        luto@kernel.org
Reply-To: jcm@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, dwmw@amazon.co.uk,
          dave.hansen@intel.com, thomas.lendacky@amd.com,
          casey.schaufler@intel.com, mingo@kernel.org,
          arjan@linux.intel.com, david.c.stewart@intel.com,
          jpoimboe@redhat.com, aarcange@redhat.com, tglx@linutronix.de,
          jkosina@suse.cz, ak@linux.intel.com, keescook@chromium.org,
          peterz@infradead.org, asit.k.mallick@intel.com,
          gregkh@linuxfoundation.org, tim.c.chen@linux.intel.com,
          luto@kernel.org, longman9394@gmail.com
In-Reply-To: <alpine.DEB.2.21.1811272247140.1875@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1811272247140.1875@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Prevent stale SPEC_CTRL msr content
Git-Commit-ID: 6d991ba509ebcfcc908e009d1db51972a4f7a064
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

Commit-ID:  6d991ba509ebcfcc908e009d1db51972a4f7a064
Gitweb:     https://git.kernel.org/tip/6d991ba509ebcfcc908e009d1db51972a4f7a064
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 28 Nov 2018 10:56:57 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Nov 2018 11:57:12 +0100

x86/speculation: Prevent stale SPEC_CTRL msr content

The seccomp speculation control operates on all tasks of a process, but
only the current task of a process can update the MSR immediately. For the
other threads the update is deferred to the next context switch.

This creates the following situation with Process A and B:

Process A task 2 and Process B task 1 are pinned on CPU1. Process A task 2
does not have the speculation control TIF bit set. Process B task 1 has the
speculation control TIF bit set.

CPU0					CPU1
					MSR bit is set
					ProcB.T1 schedules out
					ProcA.T2 schedules in
					MSR bit is cleared
ProcA.T1
  seccomp_update()
  set TIF bit on ProcA.T2
					ProcB.T1 schedules in
					MSR is not updated  <-- FAIL

This happens because the context switch code tries to avoid the MSR update
if the speculation control TIF bits of the incoming and the outgoing task
are the same. In the worst case ProcB.T1 and ProcA.T2 are the only tasks
scheduling back and forth on CPU1, which keeps the MSR stale forever.

In theory this could be remedied by IPIs, but chasing the remote task which
could be migrated is complex and full of races.

The straight forward solution is to avoid the asychronous update of the TIF
bit and defer it to the next context switch. The speculation control state
is stored in task_struct::atomic_flags by the prctl and seccomp updates
already.

Add a new TIF_SPEC_FORCE_UPDATE bit and set this after updating the
atomic_flags. Check the bit on context switch and force a synchronous
update of the speculation control if set. Use the same mechanism for
updating the current task.

Reported-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
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
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1811272247140.1875@nanos.tec.linutronix.de

---
 arch/x86/include/asm/spec-ctrl.h   |  6 +-----
 arch/x86/include/asm/thread_info.h |  4 +++-
 arch/x86/kernel/cpu/bugs.c         | 18 +++++++-----------
 arch/x86/kernel/process.c          | 30 +++++++++++++++++++++++++++++-
 4 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/spec-ctrl.h b/arch/x86/include/asm/spec-ctrl.h
index 27b0bce3933b..5393babc0598 100644
--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -83,10 +83,6 @@ static inline void speculative_store_bypass_ht_init(void) { }
 #endif
 
 extern void speculation_ctrl_update(unsigned long tif);
-
-static inline void speculation_ctrl_update_current(void)
-{
-	speculation_ctrl_update(current_thread_info()->flags);
-}
+extern void speculation_ctrl_update_current(void);
 
 #endif
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 6d201699c651..82b73b75d67c 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -84,6 +84,7 @@ struct thread_info {
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SECCOMP		8	/* secure computing */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
+#define TIF_SPEC_FORCE_UPDATE	10	/* Force speculation MSR update in context switch */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
 #define TIF_UPROBE		12	/* breakpointed or singlestepping */
 #define TIF_PATCH_PENDING	13	/* pending live patching update */
@@ -112,6 +113,7 @@ struct thread_info {
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
+#define _TIF_SPEC_FORCE_UPDATE	(1 << TIF_SPEC_FORCE_UPDATE)
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
@@ -149,7 +151,7 @@ struct thread_info {
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW_BASE						\
 	(_TIF_IO_BITMAP|_TIF_NOCPUID|_TIF_NOTSC|_TIF_BLOCKSTEP|		\
-	 _TIF_SSBD)
+	 _TIF_SSBD | _TIF_SPEC_FORCE_UPDATE)
 
 /*
  * Avoid calls to __switch_to_xtra() on UP as STIBP is not evaluated.
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 3b65a53d2c33..29f40a92f5a8 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -702,14 +702,10 @@ static void ssb_select_mitigation(void)
 #undef pr_fmt
 #define pr_fmt(fmt)     "Speculation prctl: " fmt
 
-static void task_update_spec_tif(struct task_struct *tsk, int tifbit, bool on)
+static void task_update_spec_tif(struct task_struct *tsk)
 {
-	bool update;
-
-	if (on)
-		update = !test_and_set_tsk_thread_flag(tsk, tifbit);
-	else
-		update = test_and_clear_tsk_thread_flag(tsk, tifbit);
+	/* Force the update of the real TIF bits */
+	set_tsk_thread_flag(tsk, TIF_SPEC_FORCE_UPDATE);
 
 	/*
 	 * Immediately update the speculation control MSRs for the current
@@ -719,7 +715,7 @@ static void task_update_spec_tif(struct task_struct *tsk, int tifbit, bool on)
 	 * This can only happen for SECCOMP mitigation. For PRCTL it's
 	 * always the current task.
 	 */
-	if (tsk == current && update)
+	if (tsk == current)
 		speculation_ctrl_update_current();
 }
 
@@ -735,16 +731,16 @@ static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
 		if (task_spec_ssb_force_disable(task))
 			return -EPERM;
 		task_clear_spec_ssb_disable(task);
-		task_update_spec_tif(task, TIF_SSBD, false);
+		task_update_spec_tif(task);
 		break;
 	case PR_SPEC_DISABLE:
 		task_set_spec_ssb_disable(task);
-		task_update_spec_tif(task, TIF_SSBD, true);
+		task_update_spec_tif(task);
 		break;
 	case PR_SPEC_FORCE_DISABLE:
 		task_set_spec_ssb_disable(task);
 		task_set_spec_ssb_force_disable(task);
-		task_update_spec_tif(task, TIF_SSBD, true);
+		task_update_spec_tif(task);
 		break;
 	default:
 		return -ERANGE;
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index cdf8e6694f71..afbe2eb4a1c6 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -443,6 +443,18 @@ static __always_inline void __speculation_ctrl_update(unsigned long tifp,
 		wrmsrl(MSR_IA32_SPEC_CTRL, msr);
 }
 
+static unsigned long speculation_ctrl_update_tif(struct task_struct *tsk)
+{
+	if (test_and_clear_tsk_thread_flag(tsk, TIF_SPEC_FORCE_UPDATE)) {
+		if (task_spec_ssb_disable(tsk))
+			set_tsk_thread_flag(tsk, TIF_SSBD);
+		else
+			clear_tsk_thread_flag(tsk, TIF_SSBD);
+	}
+	/* Return the updated threadinfo flags*/
+	return task_thread_info(tsk)->flags;
+}
+
 void speculation_ctrl_update(unsigned long tif)
 {
 	/* Forced update. Make sure all relevant TIF flags are different */
@@ -451,6 +463,14 @@ void speculation_ctrl_update(unsigned long tif)
 	preempt_enable();
 }
 
+/* Called from seccomp/prctl update */
+void speculation_ctrl_update_current(void)
+{
+	preempt_disable();
+	speculation_ctrl_update(speculation_ctrl_update_tif(current));
+	preempt_enable();
+}
+
 void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
 {
 	struct thread_struct *prev, *next;
@@ -482,7 +502,15 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
 	if ((tifp ^ tifn) & _TIF_NOCPUID)
 		set_cpuid_faulting(!!(tifn & _TIF_NOCPUID));
 
-	__speculation_ctrl_update(tifp, tifn);
+	if (likely(!((tifp | tifn) & _TIF_SPEC_FORCE_UPDATE))) {
+		__speculation_ctrl_update(tifp, tifn);
+	} else {
+		speculation_ctrl_update_tif(prev_p);
+		tifn = speculation_ctrl_update_tif(next_p);
+
+		/* Enforce MSR update to ensure consistent state */
+		__speculation_ctrl_update(~tifn, tifn);
+	}
 }
 
 /*
