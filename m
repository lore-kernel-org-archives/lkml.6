Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B287ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 09:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7DE21532
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 09:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7DE21532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeIVPqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 11:46:42 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41394 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbeIVPqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 11:46:42 -0400
Received: from tmo-109-175.customers.d1-online.com ([80.187.109.175] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g3ebI-00079h-7p; Sat, 22 Sep 2018 11:53:20 +0200
Date:   Sat, 22 Sep 2018 11:53:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jiri Kosina <jikos@kernel.org>
cc:     Peter Zijlstra <peterz@infradead.org>,
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
In-Reply-To: <nycvar.YFH.7.76.1809220936520.15880@cbobk.fhfr.pm>
Message-ID: <alpine.DEB.2.21.1809221022250.1391@nanos.tec.linutronix.de>
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm> <nycvar.YFH.7.76.1809121055070.15880@cbobk.fhfr.pm> <99FC4B6EFCEFD44486C35F4C281DC6732144EA58@ORSMSX107.amr.corp.intel.com> <20180919154828.GJ24124@hirez.programming.kicks-ass.net>
 <nycvar.YFH.7.76.1809220936520.15880@cbobk.fhfr.pm>
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

On Sat, 22 Sep 2018, Jiri Kosina wrote:
> On Wed, 19 Sep 2018, Peter Zijlstra wrote:
> > As far as I can tell, this still has:
> > 
> > 	avc_has_perm_noaudit()
> > 	  security_compute_av()
> > 	    read_lock(&state->ss->policy_rwlock);
> > 	  avc_insert()
> > 	    spin_lock_irqsave();
> > 	  avc_denied()
> > 	    avc_update_node()
> > 	      spin_lock_irqsave();
> > 
> > under the scheduler's raw_spinlock_t, which are invalid lock nestings.
> 
> Agreed. Therefore, if the current form (v6) of the patches is merged, the 
> check before security_ptrace_access_check() should stay.
> 
> Once all the LSM callbacks are potentially audited, it could then go in 
> second phase.
> 
> Is there anything else blocking v6 being merged? (and then Tim's set on 
> top I guess, once the details are sorted out there).

I was waiting for this to resolve. Now, looking at the outcome of this, I
think, that calling into security hooks needs very special care from that
context.

So we better split that up right away instead of adding this magic
PTRACE_MODE_NOACCESS_CHK bit. This split up will be needed for adding the
special LSM speculation control hook anyway because adding yet more magic
bits and conditionals makes this code completely undigestable. It's
convoluted enough already.

Something along the compiled but completely untested patch below should do
the trick. If that is what we want this needs to be split up of course.

Thanks,

	tglx

8<--------------------------
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
@@ -62,14 +62,16 @@ extern void exit_ptrace(struct task_stru
 #define PTRACE_MODE_READ	0x01
 #define PTRACE_MODE_ATTACH	0x02
 #define PTRACE_MODE_NOAUDIT	0x04
-#define PTRACE_MODE_FSCREDS 0x08
-#define PTRACE_MODE_REALCREDS 0x10
+#define PTRACE_MODE_FSCREDS	0x08
+#define PTRACE_MODE_REALCREDS	0x10
+#define PTRACE_MODE_IBPB	0x20
 
 /* shorthands for READ/ATTACH and FSCREDS/REALCREDS combinations */
 #define PTRACE_MODE_READ_FSCREDS (PTRACE_MODE_READ | PTRACE_MODE_FSCREDS)
 #define PTRACE_MODE_READ_REALCREDS (PTRACE_MODE_READ | PTRACE_MODE_REALCREDS)
 #define PTRACE_MODE_ATTACH_FSCREDS (PTRACE_MODE_ATTACH | PTRACE_MODE_FSCREDS)
 #define PTRACE_MODE_ATTACH_REALCREDS (PTRACE_MODE_ATTACH | PTRACE_MODE_REALCREDS)
+#define PTRACE_MODE_SPEC_IBPB (PTRACE_MODE_ATTACH_REALCREDS | PTRACE_MODE_IBPB)
 
 /**
  * ptrace_may_access - check whether the caller is permitted to access
@@ -86,6 +88,7 @@ extern void exit_ptrace(struct task_stru
  * process_vm_writev or ptrace (and should use the real credentials).
  */
 extern bool ptrace_may_access(struct task_struct *task, unsigned int mode);
+extern bool ptrace_may_access_sched(struct task_struct *task, unsigned int mode);
 
 static inline int ptrace_reparented(struct task_struct *child)
 {
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -267,14 +267,8 @@ static int ptrace_has_cap(struct user_na
 		return has_ns_capability(current, ns, CAP_SYS_PTRACE);
 }
 
-/* Returns 0 on success, -errno on denial. */
-static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
+static int __ptrace_may_access_basic(struct task_struct *task, unsigned int mode)
 {
-	const struct cred *cred = current_cred(), *tcred;
-	struct mm_struct *mm;
-	kuid_t caller_uid;
-	kgid_t caller_gid;
-
 	if (!(mode & PTRACE_MODE_FSCREDS) == !(mode & PTRACE_MODE_REALCREDS)) {
 		WARN(1, "denying ptrace access check without PTRACE_MODE_*CREDS\n");
 		return -EPERM;
@@ -292,7 +286,16 @@ static int __ptrace_may_access(struct ta
 	/* Don't let security modules deny introspection */
 	if (same_thread_group(task, current))
 		return 0;
-	rcu_read_lock();
+	/* No final decision yet */
+	return 1;
+}
+
+static int __ptrace_may_access_cred(const struct cred *tcred, unsigned int mode)
+{
+	const struct cred *cred = current_cred();
+	kuid_t caller_uid;
+	kgid_t caller_gid;
+
 	if (mode & PTRACE_MODE_FSCREDS) {
 		caller_uid = cred->fsuid;
 		caller_gid = cred->fsgid;
@@ -308,25 +311,61 @@ static int __ptrace_may_access(struct ta
 		caller_uid = cred->uid;
 		caller_gid = cred->gid;
 	}
-	tcred = __task_cred(task);
 	if (uid_eq(caller_uid, tcred->euid) &&
 	    uid_eq(caller_uid, tcred->suid) &&
 	    uid_eq(caller_uid, tcred->uid)  &&
 	    gid_eq(caller_gid, tcred->egid) &&
 	    gid_eq(caller_gid, tcred->sgid) &&
 	    gid_eq(caller_gid, tcred->gid))
-		goto ok;
-	if (ptrace_has_cap(tcred->user_ns, mode))
-		goto ok;
+		return 0;
+	return 1;
+}
+
+bool ptrace_may_access_sched(struct task_struct *task, unsigned int mode)
+{
+	struct mm_struct *mm;
+	int res;
+
+	res = __ptrace_may_access_basic(task, mode);
+	if (res <= 0)
+		return !res;
+
+	rcu_read_lock();
+	res = __ptrace_may_access_cred(__task_cred(task), mode);
 	rcu_read_unlock();
-	return -EPERM;
-ok:
+	if (res)
+		return false;
+
+	mm = task->mm;
+	if (mm && get_dumpable(mm) != SUID_DUMP_USER)
+		return false;
+	return true;
+}
+
+/* Returns 0 on success, -errno on denial. */
+static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
+{
+	const struct cred *tcred;
+	struct mm_struct *mm;
+	int res;
+
+	res = __ptrace_may_access_basic(task, mode);
+	if (res <= 0)
+		return res;
+
+	rcu_read_lock();
+	tcred = __task_cred(task);
+	res = __ptrace_may_access_cred(tcred, mode);
+	if (res > 0)
+		res = ptrace_has_cap(tcred->user_ns, mode) ? 0 : -EPERM;
 	rcu_read_unlock();
+	if (res < 0)
+		return res;
+
 	mm = task->mm;
-	if (mm &&
-	    ((get_dumpable(mm) != SUID_DUMP_USER) &&
-	     !ptrace_has_cap(mm->user_ns, mode)))
-	    return -EPERM;
+	if (mm && (get_dumpable(mm) != SUID_DUMP_USER &&
+		   !ptrace_has_cap(mm->user_ns, mode)))
+		return -EPERM;
 
 	return security_ptrace_access_check(task, mode);
 }
@@ -334,6 +373,7 @@ static int __ptrace_may_access(struct ta
 bool ptrace_may_access(struct task_struct *task, unsigned int mode)
 {
 	int err;
+
 	task_lock(task);
 	err = __ptrace_may_access(task, mode);
 	task_unlock(task);
