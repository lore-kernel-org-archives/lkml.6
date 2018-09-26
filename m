Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F46C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0882089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B0882089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeIZSpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:45:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47093 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbeIZSpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:45:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8QCUrnV3830568
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Sep 2018 05:30:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8QCUqnh3830565;
        Wed, 26 Sep 2018 05:30:52 -0700
Date:   Wed, 26 Sep 2018 05:30:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Kosina <tipbot@zytor.com>
Message-ID: <tip-dbfe2953f63c640463c630746cd5d9de8b2f63ae@git.kernel.org>
Cc:     jpoimboe@redhat.com, ak@linux.intel.com,
        linux-kernel@vger.kernel.org, jkosina@suse.cz, dwmw@amazon.co.uk,
        aarcange@redhat.com, casey.schaufler@intel.com,
        peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        tim.c.chen@linux.intel.com, hpa@zytor.com
Reply-To: hpa@zytor.com, tim.c.chen@linux.intel.com, mingo@kernel.org,
          tglx@linutronix.de, peterz@infradead.org,
          casey.schaufler@intel.com, aarcange@redhat.com,
          dwmw@amazon.co.uk, ak@linux.intel.com, jkosina@suse.cz,
          linux-kernel@vger.kernel.org, jpoimboe@redhat.com
In-Reply-To: <nycvar.YFH.7.76.1809251437340.15880@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1809251437340.15880@cbobk.fhfr.pm>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Apply IBPB more strictly to avoid
 cross-process data leak
Git-Commit-ID: dbfe2953f63c640463c630746cd5d9de8b2f63ae
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

Commit-ID:  dbfe2953f63c640463c630746cd5d9de8b2f63ae
Gitweb:     https://git.kernel.org/tip/dbfe2953f63c640463c630746cd5d9de8b2f63ae
Author:     Jiri Kosina <jkosina@suse.cz>
AuthorDate: Tue, 25 Sep 2018 14:38:18 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 26 Sep 2018 14:26:51 +0200

x86/speculation: Apply IBPB more strictly to avoid cross-process data leak

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

---
 arch/x86/mm/tlb.c      | 31 ++++++++++++++++++++-----------
 include/linux/ptrace.h | 21 +++++++++++++++++++--
 kernel/ptrace.c        | 10 ++++++++++
 3 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index e96b99eb800c..073b8df349a0 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -7,6 +7,7 @@
 #include <linux/export.h>
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
+#include <linux/ptrace.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -180,6 +181,19 @@ static void sync_current_stack_to_mm(struct mm_struct *mm)
 	}
 }
 
+static bool ibpb_needed(struct task_struct *tsk, u64 last_ctx_id)
+{
+	/*
+	 * Check if the current (previous) task has access to the memory
+	 * of the @tsk (next) task. If access is denied, make sure to
+	 * issue a IBPB to stop user->user Spectre-v2 attacks.
+	 *
+	 * Note: __ptrace_may_access() returns 0 or -ERRNO.
+	 */
+	return (tsk && tsk->mm && tsk->mm->context.ctx_id != last_ctx_id &&
+		ptrace_may_access_sched(tsk, PTRACE_MODE_SPEC_IBPB));
+}
+
 void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 			struct task_struct *tsk)
 {
@@ -262,18 +276,13 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		 * one process from doing Spectre-v2 attacks on another.
 		 *
 		 * As an optimization, flush indirect branches only when
-		 * switching into processes that disable dumping. This
-		 * protects high value processes like gpg, without having
-		 * too high performance overhead. IBPB is *expensive*!
-		 *
-		 * This will not flush branches when switching into kernel
-		 * threads. It will also not flush if we switch to idle
-		 * thread and back to the same process. It will flush if we
-		 * switch to a different non-dumpable process.
+		 * switching into a processes that can't be ptrace by the
+		 * current one (as in such case, attacker has much more
+		 * convenient way how to tamper with the next process than
+		 * branch buffer poisoning).
 		 */
-		if (tsk && tsk->mm &&
-		    tsk->mm->context.ctx_id != last_ctx_id &&
-		    get_dumpable(tsk->mm) != SUID_DUMP_USER)
+		if (static_cpu_has(X86_FEATURE_USE_IBPB) &&
+				ibpb_needed(tsk, last_ctx_id))
 			indirect_branch_prediction_barrier();
 
 		if (IS_ENABLED(CONFIG_VMAP_STACK)) {
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 4f36431c380b..e5e5ef513df3 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -62,14 +62,17 @@ extern void exit_ptrace(struct task_struct *tracer, struct list_head *dead);
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
@@ -87,6 +90,20 @@ extern void exit_ptrace(struct task_struct *tracer, struct list_head *dead);
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
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 21fec73d45d4..99cfddde6a55 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -261,6 +261,9 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 
 static int ptrace_has_cap(struct user_namespace *ns, unsigned int mode)
 {
+	if (mode & PTRACE_MODE_SCHED)
+		return false;
+
 	if (mode & PTRACE_MODE_NOAUDIT)
 		return has_ns_capability_noaudit(current, ns, CAP_SYS_PTRACE);
 	else
@@ -328,9 +331,16 @@ ok:
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
