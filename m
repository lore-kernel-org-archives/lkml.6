Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992AFC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 13:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3382221522
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 13:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3382221522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbeIVTYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 15:24:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41644 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeIVTYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 15:24:11 -0400
Received: from tmo-109-175.customers.d1-online.com ([80.187.109.175] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g3hz6-0000nm-FC; Sat, 22 Sep 2018 15:30:08 +0200
Date:   Sat, 22 Sep 2018 15:30:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Jiri Kosina <jikos@kernel.org>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 0/3] Harden spectrev2 userspace-userspace protection
In-Reply-To: <alpine.DEB.2.21.1809221219270.1391@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1809221527140.1391@nanos.tec.linutronix.de>
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm> <nycvar.YFH.7.76.1809121055070.15880@cbobk.fhfr.pm> <99FC4B6EFCEFD44486C35F4C281DC6732144EA58@ORSMSX107.amr.corp.intel.com> <20180919154828.GJ24124@hirez.programming.kicks-ass.net>
 <nycvar.YFH.7.76.1809220936520.15880@cbobk.fhfr.pm> <alpine.DEB.2.21.1809221022250.1391@nanos.tec.linutronix.de> <20180922101844.GF24124@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1809221219270.1391@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Sep 2018, Thomas Gleixner wrote:
> On Sat, 22 Sep 2018, Peter Zijlstra wrote:
> > This has some unfortunate duplication.
> > 
> > Lets go with it for now, but I'll see if I can do something about that
> > later.
> 
> Yes, I know. I tried to make the duplication smaller, but all attempts
> ended up being a convoluted mess. I'll try again after applying more
> coffee.

Lunch and coffee indeed made brain work better. The simple solution was way
too obvious.

Thanks,

	tglx

8<--------------------
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -7,6 +7,7 @@
 #include <linux/export.h>
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
+#include <linux/ptrace.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -180,6 +181,19 @@ static void sync_current_stack_to_mm(str
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
@@ -262,18 +276,13 @@ void switch_mm_irqs_off(struct mm_struct
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
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -62,14 +62,17 @@ extern void exit_ptrace(struct task_stru
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
+#define PTRACE_MODE_SPEC_IBPB (PTRACE_MODE_ATTACH_REALCREDS | PTRACE_MOD_IBPB)
 
 /**
  * ptrace_may_access - check whether the caller is permitted to access
@@ -87,6 +90,20 @@ extern void exit_ptrace(struct task_stru
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
@@ -261,6 +261,9 @@ static int ptrace_check_attach(struct ta
 
 static int ptrace_has_cap(struct user_namespace *ns, unsigned int mode)
 {
+	if (mode & PTRACE_MODE_SCHED)
+		return false;
+
 	if (mode & PTRACE_MODE_NOAUDIT)
 		return has_ns_capability_noaudit(current, ns, CAP_SYS_PTRACE);
 	else
@@ -328,9 +331,16 @@ static int __ptrace_may_access(struct ta
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
