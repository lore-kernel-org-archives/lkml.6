Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14163C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60122086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60122086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbeK2BdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:33:23 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56649 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeK2BdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:33:23 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wASEUmps2323591
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 06:30:48 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wASEUlhQ2323587;
        Wed, 28 Nov 2018 06:30:47 -0800
Date:   Wed, 28 Nov 2018 06:30:47 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-ff16701a29cba3aafa0bd1656d766813b2d0a811@git.kernel.org>
Cc:     thomas.lendacky@amd.com, asit.k.mallick@intel.com,
        dwmw@amazon.co.uk, jcm@redhat.com, dave.hansen@intel.com,
        mingo@kernel.org, hpa@zytor.com, gregkh@linuxfoundation.org,
        casey.schaufler@intel.com, jpoimboe@redhat.com,
        aarcange@redhat.com, arjan@linux.intel.com, luto@kernel.org,
        longman9394@gmail.com, torvalds@linux-foundation.org,
        peterz@infradead.org, ak@linux.intel.com, jkosina@suse.cz,
        tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        keescook@chromium.org, tglx@linutronix.de,
        david.c.stewart@intel.com
Reply-To: ak@linux.intel.com, jkosina@suse.cz,
          torvalds@linux-foundation.org, peterz@infradead.org,
          keescook@chromium.org, tglx@linutronix.de,
          david.c.stewart@intel.com, tim.c.chen@linux.intel.com,
          linux-kernel@vger.kernel.org, longman9394@gmail.com,
          luto@kernel.org, jpoimboe@redhat.com, gregkh@linuxfoundation.org,
          casey.schaufler@intel.com, arjan@linux.intel.com,
          aarcange@redhat.com, thomas.lendacky@amd.com, hpa@zytor.com,
          asit.k.mallick@intel.com, dwmw@amazon.co.uk,
          dave.hansen@intel.com, jcm@redhat.com, mingo@kernel.org
In-Reply-To: <20181125185005.280855518@linutronix.de>
References: <20181125185005.280855518@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/process: Consolidate and simplify
 switch_to_xtra() code
Git-Commit-ID: ff16701a29cba3aafa0bd1656d766813b2d0a811
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

Commit-ID:  ff16701a29cba3aafa0bd1656d766813b2d0a811
Gitweb:     https://git.kernel.org/tip/ff16701a29cba3aafa0bd1656d766813b2d0a811
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 25 Nov 2018 19:33:47 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Nov 2018 11:57:11 +0100

x86/process: Consolidate and simplify switch_to_xtra() code

Move the conditional invocation of __switch_to_xtra() into an inline
function so the logic can be shared between 32 and 64 bit.

Remove the handthrough of the TSS pointer and retrieve the pointer directly
in the bitmap handling function. Use this_cpu_ptr() instead of the
per_cpu() indirection.

This is a preparatory change so integration of conditional indirect branch
speculation optimization happens only in one place.

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
Link: https://lkml.kernel.org/r/20181125185005.280855518@linutronix.de

---
 arch/x86/include/asm/switch_to.h |  3 ---
 arch/x86/kernel/process.c        | 12 +++++++-----
 arch/x86/kernel/process.h        | 24 ++++++++++++++++++++++++
 arch/x86/kernel/process_32.c     | 10 +++-------
 arch/x86/kernel/process_64.c     | 10 +++-------
 5 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index 36bd243843d6..7cf1a270d891 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -11,9 +11,6 @@ struct task_struct *__switch_to_asm(struct task_struct *prev,
 
 __visible struct task_struct *__switch_to(struct task_struct *prev,
 					  struct task_struct *next);
-struct tss_struct;
-void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p,
-		      struct tss_struct *tss);
 
 /* This runs runs on the previous thread's stack. */
 static inline void prepare_switch_to(struct task_struct *next)
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 574b144d2b53..cdf8e6694f71 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -40,6 +40,8 @@
 #include <asm/prctl.h>
 #include <asm/spec-ctrl.h>
 
+#include "process.h"
+
 /*
  * per-CPU TSS segments. Threads are completely 'soft' on Linux,
  * no more per-task TSS's. The TSS size is kept cacheline-aligned
@@ -252,11 +254,12 @@ void arch_setup_new_exec(void)
 		enable_cpuid();
 }
 
-static inline void switch_to_bitmap(struct tss_struct *tss,
-				    struct thread_struct *prev,
+static inline void switch_to_bitmap(struct thread_struct *prev,
 				    struct thread_struct *next,
 				    unsigned long tifp, unsigned long tifn)
 {
+	struct tss_struct *tss = this_cpu_ptr(&cpu_tss_rw);
+
 	if (tifn & _TIF_IO_BITMAP) {
 		/*
 		 * Copy the relevant range of the IO bitmap.
@@ -448,8 +451,7 @@ void speculation_ctrl_update(unsigned long tif)
 	preempt_enable();
 }
 
-void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p,
-		      struct tss_struct *tss)
+void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
 {
 	struct thread_struct *prev, *next;
 	unsigned long tifp, tifn;
@@ -459,7 +461,7 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p,
 
 	tifn = READ_ONCE(task_thread_info(next_p)->flags);
 	tifp = READ_ONCE(task_thread_info(prev_p)->flags);
-	switch_to_bitmap(tss, prev, next, tifp, tifn);
+	switch_to_bitmap(prev, next, tifp, tifn);
 
 	propagate_user_return_notify(prev_p, next_p);
 
diff --git a/arch/x86/kernel/process.h b/arch/x86/kernel/process.h
new file mode 100644
index 000000000000..020fbfac3a27
--- /dev/null
+++ b/arch/x86/kernel/process.h
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Code shared between 32 and 64 bit
+
+void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p);
+
+/*
+ * This needs to be inline to optimize for the common case where no extra
+ * work needs to be done.
+ */
+static inline void switch_to_extra(struct task_struct *prev,
+				   struct task_struct *next)
+{
+	unsigned long next_tif = task_thread_info(next)->flags;
+	unsigned long prev_tif = task_thread_info(prev)->flags;
+
+	/*
+	 * __switch_to_xtra() handles debug registers, i/o bitmaps,
+	 * speculation mitigations etc.
+	 */
+	if (unlikely(next_tif & _TIF_WORK_CTXSW_NEXT ||
+		     prev_tif & _TIF_WORK_CTXSW_PREV))
+		__switch_to_xtra(prev, next);
+}
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 5046a3c9dec2..d3e593eb189f 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -59,6 +59,8 @@
 #include <asm/intel_rdt_sched.h>
 #include <asm/proto.h>
 
+#include "process.h"
+
 void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 {
 	unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L;
@@ -232,7 +234,6 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	struct fpu *prev_fpu = &prev->fpu;
 	struct fpu *next_fpu = &next->fpu;
 	int cpu = smp_processor_id();
-	struct tss_struct *tss = &per_cpu(cpu_tss_rw, cpu);
 
 	/* never put a printk in __switch_to... printk() calls wake_up*() indirectly */
 
@@ -264,12 +265,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	if (get_kernel_rpl() && unlikely(prev->iopl != next->iopl))
 		set_iopl_mask(next->iopl);
 
-	/*
-	 * Now maybe handle debug registers and/or IO bitmaps
-	 */
-	if (unlikely(task_thread_info(prev_p)->flags & _TIF_WORK_CTXSW_PREV ||
-		     task_thread_info(next_p)->flags & _TIF_WORK_CTXSW_NEXT))
-		__switch_to_xtra(prev_p, next_p, tss);
+	switch_to_extra(prev_p, next_p);
 
 	/*
 	 * Leave lazy mode, flushing any hypercalls made here.
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 0e0b4288a4b2..bbfbf017065c 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -60,6 +60,8 @@
 #include <asm/unistd_32_ia32.h>
 #endif
 
+#include "process.h"
+
 /* Prints also some state that isn't saved in the pt_regs */
 void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 {
@@ -553,7 +555,6 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	struct fpu *prev_fpu = &prev->fpu;
 	struct fpu *next_fpu = &next->fpu;
 	int cpu = smp_processor_id();
-	struct tss_struct *tss = &per_cpu(cpu_tss_rw, cpu);
 
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ENTRY) &&
 		     this_cpu_read(irq_count) != -1);
@@ -617,12 +618,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	/* Reload sp0. */
 	update_task_stack(next_p);
 
-	/*
-	 * Now maybe reload the debug registers and handle I/O bitmaps
-	 */
-	if (unlikely(task_thread_info(next_p)->flags & _TIF_WORK_CTXSW_NEXT ||
-		     task_thread_info(prev_p)->flags & _TIF_WORK_CTXSW_PREV))
-		__switch_to_xtra(prev_p, next_p, tss);
+	switch_to_extra(prev_p, next_p);
 
 #ifdef CONFIG_XEN_PV
 	/*
