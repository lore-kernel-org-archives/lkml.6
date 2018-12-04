Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B826C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBF320851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcsYrk05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFBF320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbeLDLaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:30:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:40880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbeLDK5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:57:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C28702087F;
        Tue,  4 Dec 2018 10:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921029;
        bh=Kq28HKK81PZZE6oBg5LBftuIhF+oLiHsHnlNtPedMHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AcsYrk05t/OY89xewVaXN9Z89i65fiorPmr6PXwC/w5HXGDygJu49UfXab/eoa0Az
         ePWK6aXNuntFHJvuq/SEOM/N+xId5XfvISJw+FTlQ3x+jvPN+pkZg4XSfOFdLFRTVq
         mXANvI9W5spQ5f6Cymz4wAhuhn+q5+gWIS9iOXrs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.19 053/139] x86/speculation: Prepare for conditional IBPB in switch_mm()
Date:   Tue,  4 Dec 2018 11:48:54 +0100
Message-Id: <20181204103652.160156732@linuxfoundation.org>
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

commit 4c71a2b6fd7e42814aa68a6dec88abf3b42ea573 upstream

The IBPB speculation barrier is issued from switch_mm() when the kernel
switches to a user space task with a different mm than the user space task
which ran last on the same CPU.

An additional optimization is to avoid IBPB when the incoming task can be
ptraced by the outgoing task. This optimization only works when switching
directly between two user space tasks. When switching from a kernel task to
a user space task the optimization fails because the previous task cannot
be accessed anymore. So for quite some scenarios the optimization is just
adding overhead.

The upcoming conditional IBPB support will issue IBPB only for user space
tasks which have the TIF_SPEC_IB bit set. This requires to handle the
following cases:

  1) Switch from a user space task (potential attacker) which has
     TIF_SPEC_IB set to a user space task (potential victim) which has
     TIF_SPEC_IB not set.

  2) Switch from a user space task (potential attacker) which has
     TIF_SPEC_IB not set to a user space task (potential victim) which has
     TIF_SPEC_IB set.

This needs to be optimized for the case where the IBPB can be avoided when
only kernel threads ran in between user space tasks which belong to the
same process.

The current check whether two tasks belong to the same context is using the
tasks context id. While correct, it's simpler to use the mm pointer because
it allows to mangle the TIF_SPEC_IB bit into it. The context id based
mechanism requires extra storage, which creates worse code.

When a task is scheduled out its TIF_SPEC_IB bit is mangled as bit 0 into
the per CPU storage which is used to track the last user space mm which was
running on a CPU. This bit can be used together with the TIF_SPEC_IB bit of
the incoming task to make the decision whether IBPB needs to be issued or
not to cover the two cases above.

As conditional IBPB is going to be the default, remove the dubious ptrace
check for the IBPB always case and simply issue IBPB always when the
process changes.

Move the storage to a different place in the struct as the original one
created a hole.

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
Link: https://lkml.kernel.org/r/20181125185005.466447057@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/nospec-branch.h |    2 
 arch/x86/include/asm/tlbflush.h      |    8 +-
 arch/x86/kernel/cpu/bugs.c           |   29 +++++++-
 arch/x86/mm/tlb.c                    |  114 ++++++++++++++++++++++++++---------
 4 files changed, 118 insertions(+), 35 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -312,6 +312,8 @@ do {									\
 } while (0)
 
 DECLARE_STATIC_KEY_FALSE(switch_to_cond_stibp);
+DECLARE_STATIC_KEY_FALSE(switch_mm_cond_ibpb);
+DECLARE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
 
 #endif /* __ASSEMBLY__ */
 
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -185,10 +185,14 @@ struct tlb_state {
 
 #define LOADED_MM_SWITCHING ((struct mm_struct *)1)
 
+	/* Last user mm for optimizing IBPB */
+	union {
+		struct mm_struct	*last_user_mm;
+		unsigned long		last_user_mm_ibpb;
+	};
+
 	u16 loaded_mm_asid;
 	u16 next_asid;
-	/* last user mm's ctx id */
-	u64 last_ctx_id;
 
 	/*
 	 * We can be in one of several states:
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -56,6 +56,10 @@ u64 __ro_after_init x86_amd_ls_cfg_ssbd_
 
 /* Control conditional STIPB in switch_to() */
 DEFINE_STATIC_KEY_FALSE(switch_to_cond_stibp);
+/* Control conditional IBPB in switch_mm() */
+DEFINE_STATIC_KEY_FALSE(switch_mm_cond_ibpb);
+/* Control unconditional IBPB in switch_mm() */
+DEFINE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
 
 void __init check_bugs(void)
 {
@@ -331,7 +335,17 @@ spectre_v2_user_select_mitigation(enum s
 	/* Initialize Indirect Branch Prediction Barrier */
 	if (boot_cpu_has(X86_FEATURE_IBPB)) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
-		pr_info("Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier\n");
+
+		switch (mode) {
+		case SPECTRE_V2_USER_STRICT:
+			static_branch_enable(&switch_mm_always_ibpb);
+			break;
+		default:
+			break;
+		}
+
+		pr_info("mitigation: Enabling %s Indirect Branch Prediction Barrier\n",
+			mode == SPECTRE_V2_USER_STRICT ? "always-on" : "conditional");
 	}
 
 	/* If enhanced IBRS is enabled no STIPB required */
@@ -953,10 +967,15 @@ static char *stibp_state(void)
 
 static char *ibpb_state(void)
 {
-	if (boot_cpu_has(X86_FEATURE_USE_IBPB))
-		return ", IBPB";
-	else
-		return "";
+	if (boot_cpu_has(X86_FEATURE_IBPB)) {
+		switch (spectre_v2_user) {
+		case SPECTRE_V2_USER_NONE:
+			return ", IBPB: disabled";
+		case SPECTRE_V2_USER_STRICT:
+			return ", IBPB: always-on";
+		}
+	}
+	return "";
 }
 
 static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -7,7 +7,6 @@
 #include <linux/export.h>
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
-#include <linux/ptrace.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -31,6 +30,12 @@
  */
 
 /*
+ * Use bit 0 to mangle the TIF_SPEC_IB state into the mm pointer which is
+ * stored in cpu_tlb_state.last_user_mm_ibpb.
+ */
+#define LAST_USER_MM_IBPB	0x1UL
+
+/*
  * We get here when we do something requiring a TLB invalidation
  * but could not go invalidate all of the contexts.  We do the
  * necessary invalidation by clearing out the 'ctx_id' which
@@ -181,17 +186,87 @@ static void sync_current_stack_to_mm(str
 	}
 }
 
-static bool ibpb_needed(struct task_struct *tsk, u64 last_ctx_id)
+static inline unsigned long mm_mangle_tif_spec_ib(struct task_struct *next)
+{
+	unsigned long next_tif = task_thread_info(next)->flags;
+	unsigned long ibpb = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_IBPB;
+
+	return (unsigned long)next->mm | ibpb;
+}
+
+static void cond_ibpb(struct task_struct *next)
 {
+	if (!next || !next->mm)
+		return;
+
 	/*
-	 * Check if the current (previous) task has access to the memory
-	 * of the @tsk (next) task. If access is denied, make sure to
-	 * issue a IBPB to stop user->user Spectre-v2 attacks.
-	 *
-	 * Note: __ptrace_may_access() returns 0 or -ERRNO.
+	 * Both, the conditional and the always IBPB mode use the mm
+	 * pointer to avoid the IBPB when switching between tasks of the
+	 * same process. Using the mm pointer instead of mm->context.ctx_id
+	 * opens a hypothetical hole vs. mm_struct reuse, which is more or
+	 * less impossible to control by an attacker. Aside of that it
+	 * would only affect the first schedule so the theoretically
+	 * exposed data is not really interesting.
 	 */
-	return (tsk && tsk->mm && tsk->mm->context.ctx_id != last_ctx_id &&
-		ptrace_may_access_sched(tsk, PTRACE_MODE_SPEC_IBPB));
+	if (static_branch_likely(&switch_mm_cond_ibpb)) {
+		unsigned long prev_mm, next_mm;
+
+		/*
+		 * This is a bit more complex than the always mode because
+		 * it has to handle two cases:
+		 *
+		 * 1) Switch from a user space task (potential attacker)
+		 *    which has TIF_SPEC_IB set to a user space task
+		 *    (potential victim) which has TIF_SPEC_IB not set.
+		 *
+		 * 2) Switch from a user space task (potential attacker)
+		 *    which has TIF_SPEC_IB not set to a user space task
+		 *    (potential victim) which has TIF_SPEC_IB set.
+		 *
+		 * This could be done by unconditionally issuing IBPB when
+		 * a task which has TIF_SPEC_IB set is either scheduled in
+		 * or out. Though that results in two flushes when:
+		 *
+		 * - the same user space task is scheduled out and later
+		 *   scheduled in again and only a kernel thread ran in
+		 *   between.
+		 *
+		 * - a user space task belonging to the same process is
+		 *   scheduled in after a kernel thread ran in between
+		 *
+		 * - a user space task belonging to the same process is
+		 *   scheduled in immediately.
+		 *
+		 * Optimize this with reasonably small overhead for the
+		 * above cases. Mangle the TIF_SPEC_IB bit into the mm
+		 * pointer of the incoming task which is stored in
+		 * cpu_tlbstate.last_user_mm_ibpb for comparison.
+		 */
+		next_mm = mm_mangle_tif_spec_ib(next);
+		prev_mm = this_cpu_read(cpu_tlbstate.last_user_mm_ibpb);
+
+		/*
+		 * Issue IBPB only if the mm's are different and one or
+		 * both have the IBPB bit set.
+		 */
+		if (next_mm != prev_mm &&
+		    (next_mm | prev_mm) & LAST_USER_MM_IBPB)
+			indirect_branch_prediction_barrier();
+
+		this_cpu_write(cpu_tlbstate.last_user_mm_ibpb, next_mm);
+	}
+
+	if (static_branch_unlikely(&switch_mm_always_ibpb)) {
+		/*
+		 * Only flush when switching to a user space task with a
+		 * different context than the user space task which ran
+		 * last on this CPU.
+		 */
+		if (this_cpu_read(cpu_tlbstate.last_user_mm) != next->mm) {
+			indirect_branch_prediction_barrier();
+			this_cpu_write(cpu_tlbstate.last_user_mm, next->mm);
+		}
+	}
 }
 
 void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
@@ -268,22 +343,13 @@ void switch_mm_irqs_off(struct mm_struct
 	} else {
 		u16 new_asid;
 		bool need_flush;
-		u64 last_ctx_id = this_cpu_read(cpu_tlbstate.last_ctx_id);
 
 		/*
 		 * Avoid user/user BTB poisoning by flushing the branch
 		 * predictor when switching between processes. This stops
 		 * one process from doing Spectre-v2 attacks on another.
-		 *
-		 * As an optimization, flush indirect branches only when
-		 * switching into a processes that can't be ptrace by the
-		 * current one (as in such case, attacker has much more
-		 * convenient way how to tamper with the next process than
-		 * branch buffer poisoning).
 		 */
-		if (static_cpu_has(X86_FEATURE_USE_IBPB) &&
-				ibpb_needed(tsk, last_ctx_id))
-			indirect_branch_prediction_barrier();
+		cond_ibpb(tsk);
 
 		if (IS_ENABLED(CONFIG_VMAP_STACK)) {
 			/*
@@ -340,14 +406,6 @@ void switch_mm_irqs_off(struct mm_struct
 			trace_tlb_flush_rcuidle(TLB_FLUSH_ON_TASK_SWITCH, 0);
 		}
 
-		/*
-		 * Record last user mm's context id, so we can avoid
-		 * flushing branch buffer with IBPB if we switch back
-		 * to the same user.
-		 */
-		if (next != &init_mm)
-			this_cpu_write(cpu_tlbstate.last_ctx_id, next->context.ctx_id);
-
 		/* Make sure we write CR3 before loaded_mm. */
 		barrier();
 
@@ -428,7 +486,7 @@ void initialize_tlbstate_and_flush(void)
 	write_cr3(build_cr3(mm->pgd, 0));
 
 	/* Reinitialize tlbstate. */
-	this_cpu_write(cpu_tlbstate.last_ctx_id, mm->context.ctx_id);
+	this_cpu_write(cpu_tlbstate.last_user_mm_ibpb, LAST_USER_MM_IBPB);
 	this_cpu_write(cpu_tlbstate.loaded_mm_asid, 0);
 	this_cpu_write(cpu_tlbstate.next_asid, 1);
 	this_cpu_write(cpu_tlbstate.ctxs[0].ctx_id, mm->context.ctx_id);


