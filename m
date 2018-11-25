Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237ADC43610
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF42220870
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF42220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeKZFtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 00:49:13 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:52869 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeKZFtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 00:49:12 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gQzaw-0003Rq-Lx; Sun, 25 Nov 2018 19:57:26 +0100
Message-Id: <20181125185005.280855518@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 25 Nov 2018 19:33:47 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
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
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [patch V2 19/28] x86/process: Consolidate and simplify
 switch_to_xtra() code
References: <20181125183328.318175777@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-process--Consolidate-and-simplify-switch_to_xtra---code.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the conditional invocation of __switch_to_xtra() into an inline
function so the logic can be shared between 32 and 64 bit.

Remove the handthrough of the TSS pointer and retrieve the pointer directly
in the bitmap handling function. Use this_cpu_ptr() instead of the
per_cpu() indirection.

This is a preparatory change so integration of conditional indirect branch
speculation optimization happens only in one place.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/switch_to.h |    3 ---
 arch/x86/kernel/process.c        |   12 +++++++-----
 arch/x86/kernel/process.h        |   24 ++++++++++++++++++++++++
 arch/x86/kernel/process_32.c     |   10 +++-------
 arch/x86/kernel/process_64.c     |   10 +++-------
 5 files changed, 37 insertions(+), 22 deletions(-)

--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -11,9 +11,6 @@ struct task_struct *__switch_to_asm(stru
 
 __visible struct task_struct *__switch_to(struct task_struct *prev,
 					  struct task_struct *next);
-struct tss_struct;
-void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p,
-		      struct tss_struct *tss);
 
 /* This runs runs on the previous thread's stack. */
 static inline void prepare_switch_to(struct task_struct *next)
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
@@ -461,8 +464,7 @@ void speculation_ctrl_update(unsigned lo
 	preempt_enable();
 }
 
-void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p,
-		      struct tss_struct *tss)
+void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
 {
 	struct thread_struct *prev, *next;
 	unsigned long tifp, tifn;
@@ -472,7 +474,7 @@ void __switch_to_xtra(struct task_struct
 
 	tifn = READ_ONCE(task_thread_info(next_p)->flags);
 	tifp = READ_ONCE(task_thread_info(prev_p)->flags);
-	switch_to_bitmap(tss, prev, next, tifp, tifn);
+	switch_to_bitmap(prev, next, tifp, tifn);
 
 	propagate_user_return_notify(prev_p, next_p);
 
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
@@ -232,7 +234,6 @@ EXPORT_SYMBOL_GPL(start_thread);
 	struct fpu *prev_fpu = &prev->fpu;
 	struct fpu *next_fpu = &next->fpu;
 	int cpu = smp_processor_id();
-	struct tss_struct *tss = &per_cpu(cpu_tss_rw, cpu);
 
 	/* never put a printk in __switch_to... printk() calls wake_up*() indirectly */
 
@@ -264,12 +265,7 @@ EXPORT_SYMBOL_GPL(start_thread);
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
@@ -553,7 +555,6 @@ void compat_start_thread(struct pt_regs
 	struct fpu *prev_fpu = &prev->fpu;
 	struct fpu *next_fpu = &next->fpu;
 	int cpu = smp_processor_id();
-	struct tss_struct *tss = &per_cpu(cpu_tss_rw, cpu);
 
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ENTRY) &&
 		     this_cpu_read(irq_count) != -1);
@@ -617,12 +618,7 @@ void compat_start_thread(struct pt_regs
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


