Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67ED5C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378C72084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfBCOUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:20:36 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55406 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729943AbfBCOU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:27 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdG-0006JB-7w; Sun, 03 Feb 2019 14:20:26 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9V-0006qj-22; Sun, 03 Feb 2019 14:49:41 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "WoodhouseDavid" <dwmw@amazon.co.uk>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        "SchauflerCasey" <casey.schaufler@intel.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Jiri Kosina" <jkosina@suse.cz>,
        "Peter Zijlstra" <peterz@infradead.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.524404500@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 045/305] x86/speculation: Apply IBPB more strictly to
 avoid cross-process data leak
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Kosina <jkosina@suse.cz>

commit dbfe2953f63c640463c630746cd5d9de8b2f63ae upstream.

Currently, IBPB is only issued in cases when switching into a non-dumpable
process, the rationale being to protect such 'important and security
sensitive' processess (such as GPG) from data leaking into a different
userspace process via spectre v2.

This is however completely insufficient to provide proper userspace-to-userpace
spectrev2 protection, as any process can poison branch buffers before being
scheduled out, and the newly scheduled process immediately becomes spectrev2
victim.

In order to minimize the performance impact (for usecases that do require
spectrev2 protection), issue the barrier only in cases when switching between
processess where the victim can't be ptraced by the potential attacker (as in
such cases, the attacker doesn't have to bother with branch buffers at all).

[ tglx: Split up PTRACE_MODE_NOACCESS_CHK into PTRACE_MODE_SCHED and
  PTRACE_MODE_IBPB to be able to do ptrace() context tracking reasonably
  fine-grained ]

Fixes: 18bf3c3ea8 ("x86/speculation: Use Indirect Branch Prediction Barrier in context switch")
Originally-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc:  "WoodhouseDavid" <dwmw@amazon.co.uk>
Cc: Andi Kleen <ak@linux.intel.com>
Cc:  "SchauflerCasey" <casey.schaufler@intel.com>
Link: https://lkml.kernel.org/r/nycvar.YFH.7.76.1809251437340.15880@cbobk.fhfr.pm
[bwh: Backported to 3.16: We don't have mm_context_t::ctx_id so can't use
 it to compare task identity.]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
+#include <linux/ptrace.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -95,6 +96,19 @@ void switch_mm(struct mm_struct *prev, s
 	local_irq_restore(flags);
 }
 
+static bool ibpb_needed(struct task_struct *tsk)
+{
+	/*
+	 * Check if the current (previous) task has access to the memory
+	 * of the @tsk (next) task. If access is denied, make sure to
+	 * issue a IBPB to stop user->user Spectre-v2 attacks.
+	 *
+	 * Note: __ptrace_may_access() returns 0 or -ERRNO.
+	 */
+	return (tsk && tsk->mm &&
+		ptrace_may_access_sched(tsk, PTRACE_MODE_SPEC_IBPB));
+}
+
 void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 			struct task_struct *tsk)
 {
@@ -107,16 +121,13 @@ void switch_mm_irqs_off(struct mm_struct
 		 * one process from doing Spectre-v2 attacks on another.
 		 *
 		 * As an optimization, flush indirect branches only when
-		 * switching into processes that disable dumping. This
-		 * protects high value processes like gpg, without having
-		 * too high performance overhead. IBPB is *expensive*!
-		 *
-		 * This will not flush branches when switching into kernel
-		 * threads. It will flush if we switch to a different non-
-		 * dumpable process.
+		 * switching into a processes that can't be ptrace by the
+		 * current one (as in such case, attacker has much more
+		 * convenient way how to tamper with the next process than
+		 * branch buffer poisoning).
 		 */
-		if (tsk && tsk->mm &&
-		    get_dumpable(tsk->mm) != SUID_DUMP_USER)
+		if (static_cpu_has(X86_FEATURE_USE_IBPB) &&
+				ibpb_needed(tsk))
 			indirect_branch_prediction_barrier();
 
 		this_cpu_write(cpu_tlbstate.state, TLBSTATE_OK);
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -59,14 +59,17 @@ extern void exit_ptrace(struct task_stru
 #define PTRACE_MODE_READ	0x01
 #define PTRACE_MODE_ATTACH	0x02
 #define PTRACE_MODE_NOAUDIT	0x04
-#define PTRACE_MODE_FSCREDS 0x08
-#define PTRACE_MODE_REALCREDS 0x10
+#define PTRACE_MODE_FSCREDS	0x08
+#define PTRACE_MODE_REALCREDS	0x10
+#define PTRACE_MODE_SCHED	0x20
+#define PTRACE_MODE_IBPB	0x40
 
 /* shorthands for READ/ATTACH and FSCREDS/REALCREDS combinations */
 #define PTRACE_MODE_READ_FSCREDS (PTRACE_MODE_READ | PTRACE_MODE_FSCREDS)
 #define PTRACE_MODE_READ_REALCREDS (PTRACE_MODE_READ | PTRACE_MODE_REALCREDS)
 #define PTRACE_MODE_ATTACH_FSCREDS (PTRACE_MODE_ATTACH | PTRACE_MODE_FSCREDS)
 #define PTRACE_MODE_ATTACH_REALCREDS (PTRACE_MODE_ATTACH | PTRACE_MODE_REALCREDS)
+#define PTRACE_MODE_SPEC_IBPB (PTRACE_MODE_ATTACH_REALCREDS | PTRACE_MODE_IBPB)
 
 /**
  * ptrace_may_access - check whether the caller is permitted to access
@@ -84,6 +87,20 @@ extern void exit_ptrace(struct task_stru
  */
 extern bool ptrace_may_access(struct task_struct *task, unsigned int mode);
 
+/**
+ * ptrace_may_access - check whether the caller is permitted to access
+ * a target task.
+ * @task: target task
+ * @mode: selects type of access and caller credentials
+ *
+ * Returns true on success, false on denial.
+ *
+ * Similar to ptrace_may_access(). Only to be called from context switch
+ * code. Does not call into audit and the regular LSM hooks due to locking
+ * constraints.
+ */
+extern bool ptrace_may_access_sched(struct task_struct *task, unsigned int mode);
+
 static inline int ptrace_reparented(struct task_struct *child)
 {
 	return !same_thread_group(child->real_parent, child->parent);
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -262,6 +262,9 @@ static int ptrace_check_attach(struct ta
 
 static int ptrace_has_cap(struct user_namespace *ns, unsigned int mode)
 {
+	if (mode & PTRACE_MODE_SCHED)
+		return false;
+
 	if (mode & PTRACE_MODE_NOAUDIT)
 		return has_ns_capability_noaudit(current, ns, CAP_SYS_PTRACE);
 	else
@@ -329,9 +332,16 @@ ok:
 	     !ptrace_has_cap(mm->user_ns, mode)))
 	    return -EPERM;
 
+	if (mode & PTRACE_MODE_SCHED)
+		return 0;
 	return security_ptrace_access_check(task, mode);
 }
 
+bool ptrace_may_access_sched(struct task_struct *task, unsigned int mode)
+{
+	return __ptrace_may_access(task, mode | PTRACE_MODE_SCHED);
+}
+
 bool ptrace_may_access(struct task_struct *task, unsigned int mode)
 {
 	int err;

