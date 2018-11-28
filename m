Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B58C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE7D2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE7D2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbeK2Bec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:34:32 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55107 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbeK2Bec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:34:32 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wASEVu8w2323696
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 06:31:56 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wASEVuDH2323693;
        Wed, 28 Nov 2018 06:31:56 -0800
Date:   Wed, 28 Nov 2018 06:31:56 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-4c71a2b6fd7e42814aa68a6dec88abf3b42ea573@git.kernel.org>
Cc:     casey.schaufler@intel.com, jpoimboe@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, keescook@chromium.org, hpa@zytor.com,
        jkosina@suse.cz, david.c.stewart@intel.com, arjan@linux.intel.com,
        torvalds@linux-foundation.org, mingo@kernel.org,
        asit.k.mallick@intel.com, ak@linux.intel.com, jcm@redhat.com,
        dwmw@amazon.co.uk, luto@kernel.org, tglx@linutronix.de,
        gregkh@linuxfoundation.org, dave.hansen@intel.com,
        tim.c.chen@linux.intel.com, longman9394@gmail.com,
        aarcange@redhat.com
Reply-To: tglx@linutronix.de, gregkh@linuxfoundation.org,
          longman9394@gmail.com, aarcange@redhat.com,
          tim.c.chen@linux.intel.com, dave.hansen@intel.com,
          dwmw@amazon.co.uk, jcm@redhat.com, luto@kernel.org,
          torvalds@linux-foundation.org, arjan@linux.intel.com,
          jkosina@suse.cz, david.c.stewart@intel.com, hpa@zytor.com,
          keescook@chromium.org, ak@linux.intel.com,
          asit.k.mallick@intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
          jpoimboe@redhat.com, peterz@infradead.org,
          casey.schaufler@intel.com
In-Reply-To: <20181125185005.466447057@linutronix.de>
References: <20181125185005.466447057@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Prepare for conditional IBPB in
 switch_mm()
Git-Commit-ID: 4c71a2b6fd7e42814aa68a6dec88abf3b42ea573
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

Commit-ID:  4c71a2b6fd7e42814aa68a6dec88abf3b42ea573
Gitweb:     https://git.kernel.org/tip/4c71a2b6fd7e42814aa68a6dec88abf3b42ea573
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 25 Nov 2018 19:33:49 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Nov 2018 11:57:11 +0100

x86/speculation: Prepare for conditional IBPB in switch_mm()

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

---
 arch/x86/include/asm/nospec-branch.h |   2 +
 arch/x86/include/asm/tlbflush.h      |   8 ++-
 arch/x86/kernel/cpu/bugs.c           |  29 +++++++--
 arch/x86/mm/tlb.c                    | 115 ++++++++++++++++++++++++++---------
 4 files changed, 118 insertions(+), 36 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index be0b0aa780e2..d4d35baf0430 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -312,6 +312,8 @@ do {									\
 } while (0)
 
 DECLARE_STATIC_KEY_FALSE(switch_to_cond_stibp);
+DECLARE_STATIC_KEY_FALSE(switch_mm_cond_ibpb);
+DECLARE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index d760611cfc35..f4204bf377fc 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -169,10 +169,14 @@ struct tlb_state {
 
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
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 1e13dbfc0919..7c946a9af947 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -56,6 +56,10 @@ u64 __ro_after_init x86_amd_ls_cfg_ssbd_mask;
 
 /* Control conditional STIPB in switch_to() */
 DEFINE_STATIC_KEY_FALSE(switch_to_cond_stibp);
+/* Control conditional IBPB in switch_mm() */
+DEFINE_STATIC_KEY_FALSE(switch_mm_cond_ibpb);
+/* Control unconditional IBPB in switch_mm() */
+DEFINE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
 
 void __init check_bugs(void)
 {
@@ -331,7 +335,17 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
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
@@ -955,10 +969,15 @@ static char *stibp_state(void)
 
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
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index bddd6b3cee1d..03b6b4c2238d 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -7,7 +7,6 @@
 #include <linux/export.h>
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
-#include <linux/ptrace.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -30,6 +29,12 @@
  *	Implement flush IPI by CALL_FUNCTION_VECTOR, Alex Shi
  */
 
+/*
+ * Use bit 0 to mangle the TIF_SPEC_IB state into the mm pointer which is
+ * stored in cpu_tlb_state.last_user_mm_ibpb.
+ */
+#define LAST_USER_MM_IBPB	0x1UL
+
 /*
  * We get here when we do something requiring a TLB invalidation
  * but could not go invalidate all of the contexts.  We do the
@@ -181,17 +186,87 @@ static void sync_current_stack_to_mm(struct mm_struct *mm)
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
@@ -292,22 +367,12 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		new_asid = prev_asid;
 		need_flush = true;
 	} else {
-		u64 last_ctx_id = this_cpu_read(cpu_tlbstate.last_ctx_id);
-
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
@@ -365,14 +430,6 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		trace_tlb_flush_rcuidle(TLB_FLUSH_ON_TASK_SWITCH, 0);
 	}
 
-	/*
-	 * Record last user mm's context id, so we can avoid
-	 * flushing branch buffer with IBPB if we switch back
-	 * to the same user.
-	 */
-	if (next != &init_mm)
-		this_cpu_write(cpu_tlbstate.last_ctx_id, next->context.ctx_id);
-
 	/* Make sure we write CR3 before loaded_mm. */
 	barrier();
 
@@ -441,7 +498,7 @@ void initialize_tlbstate_and_flush(void)
 	write_cr3(build_cr3(mm->pgd, 0));
 
 	/* Reinitialize tlbstate. */
-	this_cpu_write(cpu_tlbstate.last_ctx_id, mm->context.ctx_id);
+	this_cpu_write(cpu_tlbstate.last_user_mm_ibpb, LAST_USER_MM_IBPB);
 	this_cpu_write(cpu_tlbstate.loaded_mm_asid, 0);
 	this_cpu_write(cpu_tlbstate.next_asid, 1);
 	this_cpu_write(cpu_tlbstate.ctxs[0].ctx_id, mm->context.ctx_id);
