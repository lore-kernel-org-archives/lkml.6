Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CDBC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011C520C0F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011C520C0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeHTT4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:56:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbeHTT4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:56:50 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7947920C0F;
        Mon, 20 Aug 2018 16:40:23 +0000 (UTC)
Date:   Mon, 20 Aug 2018 12:40:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [GIT PULL] tracing: Updates for 4.19
Message-ID: <20180820124022.3ea3f9ee@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Updates for v4.19:

 - Restructure of lockdep and latency tracers

   This is the biggest change. Joel Fernandes restructured the hooks
   from irqs and preemption disabling and enabling. He got rid of
   a lot of the preprocessor #ifdef mess that they caused.

   He turned both lockdep and the latency tracers to use trace events
   inserted in the preempt/irqs disabling paths. But unfortunately,
   these started to cause issues in corner cases. Thus, parts of the
   code was reverted back to where lockde and the latency tracers
   just get called directly (without using the trace events).
   But because the original change cleaned up the code very nicely
   we kept that, as well as the trace events for preempt and irqs
   disabling, but they are limited to not being called in NMIs.

 - Have trace events use SRCU for "rcu idle" calls. This was required
   for the preempt/irqs off trace events. But it also had to not
   allow them to be called in NMI context. Waiting till Paul makes
   an NMI safe SRCU API.

 - New notrace SRCU API to allow trace events to use SRCU.

 - Addition of mcount-nop option support

 - SPDX headers replacing GPL templates.

 - Various other fixes and clean ups.

 - Some fixes are marked for stable, but were not fully tested
   before the merge window opened.


Please pull the latest trace-v4.19 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.19

Tag SHA1: 2a474b070a08f6b2db0361c8ee672d8bf8e725d8
Head SHA1: bb730b5833b5bddf5cb226865e5f4496770d00b0


Colin Ian King (1):
      ftrace: Remove unused pointer ftrace_swapper_pid

Erica Bugden (1):
      ftrace: Add missing check for existing hwlat thread

Francis Deslauriers (1):
      selftest/ftrace: Move kprobe selftest function to separate compile unit

Gustavo A. R. Silva (1):
      ftrace: Use true and false for boolean values in ops_references_rec()

Joel Fernandes (Google) (9):
      srcu: Add notrace variant of srcu_dereference
      tracing/irqsoff: Split reset into separate functions
      lib: Add module for testing preemptoff/irqsoff latency tracers
      kselftests: Add tests for the preemptoff and irqsoff tracers
      lockdep: Use this_cpu_ptr instead of get_cpu_var stats
      tracepoint: Make rcuidle tracepoint callers use SRCU
      tracing: Centralize preemptirq tracepoints and unify their usage
      trace: Use rcu_dereference_raw for hooks from trace-event subsystem
      tracing: irqsoff: Account for additional preempt_disable

Masami Hiramatsu (5):
      tracing: Remove orphaned function using_ftrace_ops_list_func().
      tracing: Remove orphaned function ftrace_nr_registered_ops()
      tracing: kprobes: Prohibit probing on notrace function
      selftests/ftrace: Fix kprobe string testcase to not probe notrace function
      tracing/kprobes: Fix within_notrace_func() to check only notrace functions

Paul McKenney (1):
      srcu: Add notrace variants of srcu_read_{lock,unlock}

Ravi Bangoria (2):
      Uprobes: Simplify uprobe_register() body
      Uprobe: Additional argument arch_uprobe to uprobe_write_opcode()

Steven Rostedt (VMware) (17):
      tracing: Make unregister_trigger() static
      tracing/kprobes: Simplify the logic of enable_trace_kprobe()
      tracing: Do not call start/stop() functions when tracing_on does not change
      tracing: Do a WARN_ON() if start_thread() in hwlat is called when thread exists
      tracing: Make tracer_tracing_is_on() return bool
      ring-buffer: Make ring_buffer_record_is_on() return bool
      ring-buffer: Make ring_buffer_record_is_set_on() return bool
      tracing: Partial revert of "tracing: Centralize preemptirq tracepoints and unify their usage"
      tracing/irqsoff: Handle preempt_count for different configs
      tracing: More reverting of "tracing: Centralize preemptirq tracepoints and unify their usage"
      tracing: Fix synchronizing to event changes with tracepoint_synchronize_unregister()
      uprobes: Use synchronize_rcu() not synchronize_sched()
      tracepoints: Free early tracepoints after RCU is initialized
      blktrace: Add SPDX License format header
      tracing: Add SPDX License format to bpf_trace.c
      tracing: Add SPDX License format tags to tracing files
      tracing: Fix SPDX format headers to use C++ style comments

Vasily Gorbik (4):
      tracing: Handle CC_FLAGS_FTRACE more accurately
      tracing: Avoid calling cc-option -mrecord-mcount for every Makefile
      tracing: Add -mcount-nop option support
      s390/ftrace: Add -mfentry and -mnop-mcount support

Zubin Mithra (1):
      tracefs: Annotate tracefs_ops with __ro_after_init

kbuild test robot (1):
      tracing: preemptirq_delay_run() can be static

----
 Makefile                                           |  24 +-
 arch/arm/probes/uprobes/core.c                     |   2 +-
 arch/mips/kernel/uprobes.c                         |   2 +-
 arch/s390/Kconfig                                  |   2 +
 arch/s390/Makefile                                 |  16 +-
 arch/s390/include/asm/ftrace.h                     |   6 +-
 arch/s390/kernel/ftrace.c                          |   2 +-
 arch/s390/kernel/mcount.S                          |   2 +-
 fs/tracefs/inode.c                                 |   5 +-
 include/linux/ftrace.h                             |  17 +-
 include/linux/irqflags.h                           |  15 +-
 include/linux/lockdep.h                            |   6 +-
 include/linux/preempt.h                            |   2 +-
 include/linux/ring_buffer.h                        |   4 +-
 include/linux/srcu.h                               |  22 ++
 include/linux/tracepoint.h                         |  40 ++-
 include/linux/uprobes.h                            |   2 +-
 include/trace/events/preemptirq.h                  |  23 +-
 init/main.c                                        |   3 +-
 kernel/events/uprobes.c                            |  78 +++---
 kernel/locking/lockdep.c                           |  35 +--
 kernel/sched/core.c                                |   2 +-
 kernel/trace/Kconfig                               |  62 ++++-
 kernel/trace/Makefile                              |   8 +-
 kernel/trace/blktrace.c                            |  14 +-
 kernel/trace/bpf_trace.c                           |   5 +-
 kernel/trace/ftrace.c                              |  44 +---
 kernel/trace/preemptirq_delay_test.c               |  72 ++++++
 kernel/trace/ring_buffer.c                         |   5 +-
 kernel/trace/ring_buffer_benchmark.c               |   1 +
 kernel/trace/trace.c                               |   7 +-
 kernel/trace/trace.h                               |  23 +-
 kernel/trace/trace_benchmark.h                     |   2 +-
 kernel/trace/trace_clock.c                         |   1 +
 kernel/trace/trace_entries.h                       |   2 +-
 kernel/trace/trace_event_perf.c                    |   1 +
 kernel/trace/trace_events.c                        |  13 +-
 kernel/trace/trace_events_filter.c                 |  30 +--
 kernel/trace/trace_events_filter_test.h            |   2 +-
 kernel/trace/trace_events_hist.c                   |  13 +-
 kernel/trace/trace_events_trigger.c                |  27 +--
 kernel/trace/trace_hwlat.c                         |   7 +-
 kernel/trace/trace_irqsoff.c                       | 270 +++++++--------------
 kernel/trace/trace_kprobe.c                        | 116 +++++----
 kernel/trace/trace_kprobe_selftest.c               |  10 +
 kernel/trace/trace_kprobe_selftest.h               |   7 +
 kernel/trace/trace_output.c                        |   1 +
 kernel/trace/trace_output.h                        |   2 +-
 kernel/trace/trace_preemptirq.c                    |  89 +++++++
 kernel/trace/trace_printk.c                        |   1 +
 kernel/trace/trace_probe.c                         |  14 +-
 kernel/trace/trace_probe.h                         |  14 +-
 kernel/trace/trace_seq.c                           |   1 +
 kernel/trace/trace_stat.h                          |   2 +-
 kernel/trace/trace_uprobe.c                        |  16 +-
 kernel/trace/tracing_map.c                         |  11 +-
 kernel/trace/tracing_map.h                         |   2 +-
 kernel/tracepoint.c                                |  48 +++-
 scripts/Makefile.build                             |   9 +-
 tools/testing/selftests/ftrace/config              |   3 +
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |  30 +--
 .../selftests/ftrace/test.d/kprobe/probepoint.tc   |   2 +-
 .../ftrace/test.d/preemptirq/irqsoff_tracer.tc     |  73 ++++++
 63 files changed, 789 insertions(+), 581 deletions(-)
 create mode 100644 kernel/trace/preemptirq_delay_test.c
 create mode 100644 kernel/trace/trace_kprobe_selftest.c
 create mode 100644 kernel/trace/trace_kprobe_selftest.h
 create mode 100644 kernel/trace/trace_preemptirq.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
---------------------------
diff --git a/Makefile b/Makefile
index 67d9d20f8564..c5b0cd7f3c2a 100644
--- a/Makefile
+++ b/Makefile
@@ -743,12 +743,28 @@ ifdef CONFIG_FUNCTION_TRACER
 ifndef CC_FLAGS_FTRACE
 CC_FLAGS_FTRACE := -pg
 endif
-export CC_FLAGS_FTRACE
+ifdef CONFIG_FTRACE_MCOUNT_RECORD
+  # gcc 5 supports generating the mcount tables directly
+  ifeq ($(call cc-option-yn,-mrecord-mcount),y)
+    CC_FLAGS_FTRACE	+= -mrecord-mcount
+    export CC_USING_RECORD_MCOUNT := 1
+  endif
+  ifdef CONFIG_HAVE_NOP_MCOUNT
+    ifeq ($(call cc-option-yn, -mnop-mcount),y)
+      CC_FLAGS_FTRACE	+= -mnop-mcount
+      CC_FLAGS_USING	+= -DCC_USING_NOP_MCOUNT
+    endif
+  endif
+endif
 ifdef CONFIG_HAVE_FENTRY
-CC_USING_FENTRY	:= $(call cc-option, -mfentry -DCC_USING_FENTRY)
+  ifeq ($(call cc-option-yn, -mfentry),y)
+    CC_FLAGS_FTRACE	+= -mfentry
+    CC_FLAGS_USING	+= -DCC_USING_FENTRY
+  endif
 endif
-KBUILD_CFLAGS	+= $(CC_FLAGS_FTRACE) $(CC_USING_FENTRY)
-KBUILD_AFLAGS	+= $(CC_USING_FENTRY)
+export CC_FLAGS_FTRACE
+KBUILD_CFLAGS	+= $(CC_FLAGS_FTRACE) $(CC_FLAGS_USING)
+KBUILD_AFLAGS	+= $(CC_FLAGS_USING)
 ifdef CONFIG_DYNAMIC_FTRACE
 	ifdef CONFIG_HAVE_C_RECORDMCOUNT
 		BUILD_C_RECORDMCOUNT := y
diff --git a/arch/arm/probes/uprobes/core.c b/arch/arm/probes/uprobes/core.c
index d1329f1ba4e4..bf992264060e 100644
--- a/arch/arm/probes/uprobes/core.c
+++ b/arch/arm/probes/uprobes/core.c
@@ -32,7 +32,7 @@ bool is_swbp_insn(uprobe_opcode_t *insn)
 int set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	     unsigned long vaddr)
 {
-	return uprobe_write_opcode(mm, vaddr,
+	return uprobe_write_opcode(auprobe, mm, vaddr,
 		   __opcode_to_mem_arm(auprobe->bpinsn));
 }
 
diff --git a/arch/mips/kernel/uprobes.c b/arch/mips/kernel/uprobes.c
index f7a0645ccb82..4aaff3b3175c 100644
--- a/arch/mips/kernel/uprobes.c
+++ b/arch/mips/kernel/uprobes.c
@@ -224,7 +224,7 @@ unsigned long arch_uretprobe_hijack_return_addr(
 int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	unsigned long vaddr)
 {
-	return uprobe_write_opcode(mm, vaddr, UPROBE_SWBP_INSN);
+	return uprobe_write_opcode(auprobe, mm, vaddr, UPROBE_SWBP_INSN);
 }
 
 void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index e44bb2b2873e..4e914445553e 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -136,6 +136,7 @@ config S390
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
+	select HAVE_FENTRY
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
@@ -157,6 +158,7 @@ config S390
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_MEMBLOCK_PHYS_MAP
 	select HAVE_MOD_ARCH_SPECIFIC
+	select HAVE_NOP_MCOUNT
 	select HAVE_OPROFILE
 	select HAVE_PERF_EVENTS
 	select HAVE_REGS_AND_STACK_ACCESS_API
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 68a690442be0..8498babb5dad 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -86,13 +86,15 @@ ifdef CONFIG_EXPOLINE
 endif
 
 ifdef CONFIG_FUNCTION_TRACER
-# make use of hotpatch feature if the compiler supports it
-cc_hotpatch	:= -mhotpatch=0,3
-ifeq ($(call cc-option-yn,$(cc_hotpatch)),y)
-CC_FLAGS_FTRACE := $(cc_hotpatch)
-KBUILD_AFLAGS	+= -DCC_USING_HOTPATCH
-KBUILD_CFLAGS	+= -DCC_USING_HOTPATCH
-endif
+  ifeq ($(call cc-option-yn,-mfentry -mnop-mcount),n)
+    # make use of hotpatch feature if the compiler supports it
+    cc_hotpatch	:= -mhotpatch=0,3
+    ifeq ($(call cc-option-yn,$(cc_hotpatch)),y)
+      CC_FLAGS_FTRACE := $(cc_hotpatch)
+      KBUILD_AFLAGS	+= -DCC_USING_HOTPATCH
+      KBUILD_CFLAGS	+= -DCC_USING_HOTPATCH
+    endif
+  endif
 endif
 
 # Test CFI features of binutils
diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index cfccc0edd00d..8ea270fdc7fb 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -4,7 +4,7 @@
 
 #define ARCH_SUPPORTS_FTRACE_OPS 1
 
-#ifdef CC_USING_HOTPATCH
+#if defined(CC_USING_HOTPATCH) || defined(CC_USING_NOP_MCOUNT)
 #define MCOUNT_INSN_SIZE	6
 #else
 #define MCOUNT_INSN_SIZE	24
@@ -42,7 +42,7 @@ struct ftrace_insn {
 static inline void ftrace_generate_nop_insn(struct ftrace_insn *insn)
 {
 #ifdef CONFIG_FUNCTION_TRACER
-#ifdef CC_USING_HOTPATCH
+#if defined(CC_USING_HOTPATCH) || defined(CC_USING_NOP_MCOUNT)
 	/* brcl 0,0 */
 	insn->opc = 0xc004;
 	insn->disp = 0;
@@ -57,7 +57,7 @@ static inline void ftrace_generate_nop_insn(struct ftrace_insn *insn)
 static inline int is_ftrace_nop(struct ftrace_insn *insn)
 {
 #ifdef CONFIG_FUNCTION_TRACER
-#ifdef CC_USING_HOTPATCH
+#if defined(CC_USING_HOTPATCH) || defined(CC_USING_NOP_MCOUNT)
 	if (insn->disp == 0)
 		return 1;
 #else
diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index dc76d813e420..84be7f02d0c2 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -61,7 +61,7 @@ unsigned long ftrace_plt;
 
 static inline void ftrace_generate_orig_insn(struct ftrace_insn *insn)
 {
-#ifdef CC_USING_HOTPATCH
+#if defined(CC_USING_HOTPATCH) || defined(CC_USING_NOP_MCOUNT)
 	/* brcl 0,0 */
 	insn->opc = 0xc004;
 	insn->disp = 0;
diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
index 27110f3294ed..e93fbf02490c 100644
--- a/arch/s390/kernel/mcount.S
+++ b/arch/s390/kernel/mcount.S
@@ -35,7 +35,7 @@ ENTRY(ftrace_caller)
 	.globl	ftrace_regs_caller
 	.set	ftrace_regs_caller,ftrace_caller
 	lgr	%r1,%r15
-#ifndef CC_USING_HOTPATCH
+#if !(defined(CC_USING_HOTPATCH) || defined(CC_USING_NOP_MCOUNT))
 	aghi	%r0,MCOUNT_RETURN_FIXUP
 #endif
 	aghi	%r15,-STACK_FRAME_SIZE
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index bea8ad876bf9..7098c49f3693 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -53,7 +53,7 @@ static const struct file_operations tracefs_file_operations = {
 static struct tracefs_dir_ops {
 	int (*mkdir)(const char *name);
 	int (*rmdir)(const char *name);
-} tracefs_ops;
+} tracefs_ops __ro_after_init;
 
 static char *get_dname(struct dentry *dentry)
 {
@@ -478,7 +478,8 @@ struct dentry *tracefs_create_dir(const char *name, struct dentry *parent)
  *
  * Returns the dentry of the instances directory.
  */
-struct dentry *tracefs_create_instance_dir(const char *name, struct dentry *parent,
+__init struct dentry *tracefs_create_instance_dir(const char *name,
+					  struct dentry *parent,
 					  int (*mkdir)(const char *name),
 					  int (*rmdir)(const char *name))
 {
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index ebb77674be90..a397907e8d72 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -234,10 +234,6 @@ extern void ftrace_stub(unsigned long a0, unsigned long a1,
  */
 #define register_ftrace_function(ops) ({ 0; })
 #define unregister_ftrace_function(ops) ({ 0; })
-static inline int ftrace_nr_registered_ops(void)
-{
-	return 0;
-}
 static inline void ftrace_kill(void) { }
 static inline void ftrace_free_init_mem(void) { }
 static inline void ftrace_free_mem(struct module *mod, void *start, void *end) { }
@@ -328,8 +324,6 @@ struct seq_file;
 
 extern int ftrace_text_reserved(const void *start, const void *end);
 
-extern int ftrace_nr_registered_ops(void);
-
 struct ftrace_ops *ftrace_ops_trampoline(unsigned long addr);
 
 bool is_ftrace_trampoline(unsigned long addr);
@@ -707,16 +701,7 @@ static inline unsigned long get_lock_parent_ip(void)
 	return CALLER_ADDR2;
 }
 
-#ifdef CONFIG_IRQSOFF_TRACER
-  extern void time_hardirqs_on(unsigned long a0, unsigned long a1);
-  extern void time_hardirqs_off(unsigned long a0, unsigned long a1);
-#else
-  static inline void time_hardirqs_on(unsigned long a0, unsigned long a1) { }
-  static inline void time_hardirqs_off(unsigned long a0, unsigned long a1) { }
-#endif
-
-#if defined(CONFIG_PREEMPT_TRACER) || \
-	(defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_PREEMPTIRQ_EVENTS))
+#ifdef CONFIG_TRACE_PREEMPT_TOGGLE
   extern void trace_preempt_on(unsigned long a0, unsigned long a1);
   extern void trace_preempt_off(unsigned long a0, unsigned long a1);
 #else
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 9700f00bbc04..21619c92c377 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -15,9 +15,20 @@
 #include <linux/typecheck.h>
 #include <asm/irqflags.h>
 
-#ifdef CONFIG_TRACE_IRQFLAGS
+/* Currently trace_softirqs_on/off is used only by lockdep */
+#ifdef CONFIG_PROVE_LOCKING
   extern void trace_softirqs_on(unsigned long ip);
   extern void trace_softirqs_off(unsigned long ip);
+  extern void lockdep_hardirqs_on(unsigned long ip);
+  extern void lockdep_hardirqs_off(unsigned long ip);
+#else
+  static inline void trace_softirqs_on(unsigned long ip) { }
+  static inline void trace_softirqs_off(unsigned long ip) { }
+  static inline void lockdep_hardirqs_on(unsigned long ip) { }
+  static inline void lockdep_hardirqs_off(unsigned long ip) { }
+#endif
+
+#ifdef CONFIG_TRACE_IRQFLAGS
   extern void trace_hardirqs_on(void);
   extern void trace_hardirqs_off(void);
 # define trace_hardirq_context(p)	((p)->hardirq_context)
@@ -43,8 +54,6 @@ do {						\
 #else
 # define trace_hardirqs_on()		do { } while (0)
 # define trace_hardirqs_off()		do { } while (0)
-# define trace_softirqs_on(ip)		do { } while (0)
-# define trace_softirqs_off(ip)		do { } while (0)
 # define trace_hardirq_context(p)	0
 # define trace_softirq_context(p)	0
 # define trace_hardirqs_enabled(p)	0
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 6fc77d4dbdcd..b0d0b51c4d85 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -266,7 +266,7 @@ struct held_lock {
 /*
  * Initialization, self-test and debugging-output methods:
  */
-extern void lockdep_info(void);
+extern void lockdep_init(void);
 extern void lockdep_reset(void);
 extern void lockdep_reset_lock(struct lockdep_map *lock);
 extern void lockdep_free_key_range(void *start, unsigned long size);
@@ -406,7 +406,7 @@ static inline void lockdep_on(void)
 # define lock_downgrade(l, i)			do { } while (0)
 # define lock_set_class(l, n, k, s, i)		do { } while (0)
 # define lock_set_subclass(l, s, i)		do { } while (0)
-# define lockdep_info()				do { } while (0)
+# define lockdep_init()				do { } while (0)
 # define lockdep_init_map(lock, name, key, sub) \
 		do { (void)(name); (void)(key); } while (0)
 # define lockdep_set_class(lock, key)		do { (void)(key); } while (0)
@@ -532,7 +532,7 @@ do {								\
 
 #endif /* CONFIG_LOCKDEP */
 
-#ifdef CONFIG_TRACE_IRQFLAGS
+#ifdef CONFIG_PROVE_LOCKING
 extern void print_irqtrace_events(struct task_struct *curr);
 #else
 static inline void print_irqtrace_events(struct task_struct *curr)
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 5bd3f151da78..c01813c3fbe9 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -150,7 +150,7 @@
  */
 #define in_atomic_preempt_off() (preempt_count() != PREEMPT_DISABLE_OFFSET)
 
-#if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_PREEMPT_TRACER)
+#if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_TRACE_PREEMPT_TOGGLE)
 extern void preempt_count_add(int val);
 extern void preempt_count_sub(int val);
 #define preempt_count_dec_and_test() \
diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 003d09ab308d..0940fda59872 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -164,8 +164,8 @@ void ring_buffer_record_disable(struct ring_buffer *buffer);
 void ring_buffer_record_enable(struct ring_buffer *buffer);
 void ring_buffer_record_off(struct ring_buffer *buffer);
 void ring_buffer_record_on(struct ring_buffer *buffer);
-int ring_buffer_record_is_on(struct ring_buffer *buffer);
-int ring_buffer_record_is_set_on(struct ring_buffer *buffer);
+bool ring_buffer_record_is_on(struct ring_buffer *buffer);
+bool ring_buffer_record_is_set_on(struct ring_buffer *buffer);
 void ring_buffer_record_disable_cpu(struct ring_buffer *buffer, int cpu);
 void ring_buffer_record_enable_cpu(struct ring_buffer *buffer, int cpu);
 
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 91494d7e8e41..67135d4a8a30 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -169,6 +169,11 @@ static inline int srcu_read_lock_held(const struct srcu_struct *sp)
  */
 #define srcu_dereference(p, sp) srcu_dereference_check((p), (sp), 0)
 
+/**
+ * srcu_dereference_notrace - no tracing and no lockdep calls from here
+ */
+#define srcu_dereference_notrace(p, sp) srcu_dereference_check((p), (sp), 1)
+
 /**
  * srcu_read_lock - register a new reader for an SRCU-protected structure.
  * @sp: srcu_struct in which to register the new reader.
@@ -195,6 +200,16 @@ static inline int srcu_read_lock(struct srcu_struct *sp) __acquires(sp)
 	return retval;
 }
 
+/* Used by tracing, cannot be traced and cannot invoke lockdep. */
+static inline notrace int
+srcu_read_lock_notrace(struct srcu_struct *sp) __acquires(sp)
+{
+	int retval;
+
+	retval = __srcu_read_lock(sp);
+	return retval;
+}
+
 /**
  * srcu_read_unlock - unregister a old reader from an SRCU-protected structure.
  * @sp: srcu_struct in which to unregister the old reader.
@@ -209,6 +224,13 @@ static inline void srcu_read_unlock(struct srcu_struct *sp, int idx)
 	__srcu_read_unlock(sp, idx);
 }
 
+/* Used by tracing, cannot be traced and cannot call lockdep. */
+static inline notrace void
+srcu_read_unlock_notrace(struct srcu_struct *sp, int idx) __releases(sp)
+{
+	__srcu_read_unlock(sp, idx);
+}
+
 /**
  * smp_mb__after_srcu_read_unlock - ensure full ordering after srcu_read_unlock
  *
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 19a690b559ca..d9a084c72541 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -15,6 +15,7 @@
  */
 
 #include <linux/smp.h>
+#include <linux/srcu.h>
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/cpumask.h>
@@ -33,6 +34,8 @@ struct trace_eval_map {
 
 #define TRACEPOINT_DEFAULT_PRIO	10
 
+extern struct srcu_struct tracepoint_srcu;
+
 extern int
 tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
 extern int
@@ -75,10 +78,16 @@ int unregister_tracepoint_module_notifier(struct notifier_block *nb)
  * probe unregistration and the end of module exit to make sure there is no
  * caller executing a probe when it is freed.
  */
+#ifdef CONFIG_TRACEPOINTS
 static inline void tracepoint_synchronize_unregister(void)
 {
+	synchronize_srcu(&tracepoint_srcu);
 	synchronize_sched();
 }
+#else
+static inline void tracepoint_synchronize_unregister(void)
+{ }
+#endif
 
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
 extern int syscall_regfunc(void);
@@ -129,18 +138,31 @@ extern void syscall_unregfunc(void);
  * as "(void *, void)". The DECLARE_TRACE_NOARGS() will pass in just
  * "void *data", where as the DECLARE_TRACE() will pass in "void *data, proto".
  */
-#define __DO_TRACE(tp, proto, args, cond, rcucheck)			\
+#define __DO_TRACE(tp, proto, args, cond, rcuidle)			\
 	do {								\
 		struct tracepoint_func *it_func_ptr;			\
 		void *it_func;						\
 		void *__data;						\
+		int __maybe_unused idx = 0;				\
 									\
 		if (!(cond))						\
 			return;						\
-		if (rcucheck)						\
-			rcu_irq_enter_irqson();				\
-		rcu_read_lock_sched_notrace();				\
-		it_func_ptr = rcu_dereference_sched((tp)->funcs);	\
+									\
+		/* srcu can't be used from NMI */			\
+		WARN_ON_ONCE(rcuidle && in_nmi());			\
+									\
+		/* keep srcu and sched-rcu usage consistent */		\
+		preempt_disable_notrace();				\
+									\
+		/*							\
+		 * For rcuidle callers, use srcu since sched-rcu	\
+		 * doesn't work from the idle path.			\
+		 */							\
+		if (rcuidle)						\
+			idx = srcu_read_lock_notrace(&tracepoint_srcu);	\
+									\
+		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
+									\
 		if (it_func_ptr) {					\
 			do {						\
 				it_func = (it_func_ptr)->func;		\
@@ -148,9 +170,11 @@ extern void syscall_unregfunc(void);
 				((void(*)(proto))(it_func))(args);	\
 			} while ((++it_func_ptr)->func);		\
 		}							\
-		rcu_read_unlock_sched_notrace();			\
-		if (rcucheck)						\
-			rcu_irq_exit_irqson();				\
+									\
+		if (rcuidle)						\
+			srcu_read_unlock_notrace(&tracepoint_srcu, idx);\
+									\
+		preempt_enable_notrace();				\
 	} while (0)
 
 #ifndef MODULE
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 0a294e950df8..bb9d2084af03 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -121,7 +121,7 @@ extern bool is_swbp_insn(uprobe_opcode_t *insn);
 extern bool is_trap_insn(uprobe_opcode_t *insn);
 extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
-extern int uprobe_write_opcode(struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
+extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
 extern int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
diff --git a/include/trace/events/preemptirq.h b/include/trace/events/preemptirq.h
index 9c4eb33c5a1d..9a0d4ceeb166 100644
--- a/include/trace/events/preemptirq.h
+++ b/include/trace/events/preemptirq.h
@@ -1,4 +1,4 @@
-#ifdef CONFIG_PREEMPTIRQ_EVENTS
+#ifdef CONFIG_PREEMPTIRQ_TRACEPOINTS
 
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM preemptirq
@@ -32,7 +32,7 @@ DECLARE_EVENT_CLASS(preemptirq_template,
 		  (void *)((unsigned long)(_stext) + __entry->parent_offs))
 );
 
-#ifndef CONFIG_PROVE_LOCKING
+#ifdef CONFIG_TRACE_IRQFLAGS
 DEFINE_EVENT(preemptirq_template, irq_disable,
 	     TP_PROTO(unsigned long ip, unsigned long parent_ip),
 	     TP_ARGS(ip, parent_ip));
@@ -40,9 +40,14 @@ DEFINE_EVENT(preemptirq_template, irq_disable,
 DEFINE_EVENT(preemptirq_template, irq_enable,
 	     TP_PROTO(unsigned long ip, unsigned long parent_ip),
 	     TP_ARGS(ip, parent_ip));
+#else
+#define trace_irq_enable(...)
+#define trace_irq_disable(...)
+#define trace_irq_enable_rcuidle(...)
+#define trace_irq_disable_rcuidle(...)
 #endif
 
-#ifdef CONFIG_DEBUG_PREEMPT
+#ifdef CONFIG_TRACE_PREEMPT_TOGGLE
 DEFINE_EVENT(preemptirq_template, preempt_disable,
 	     TP_PROTO(unsigned long ip, unsigned long parent_ip),
 	     TP_ARGS(ip, parent_ip));
@@ -50,22 +55,22 @@ DEFINE_EVENT(preemptirq_template, preempt_disable,
 DEFINE_EVENT(preemptirq_template, preempt_enable,
 	     TP_PROTO(unsigned long ip, unsigned long parent_ip),
 	     TP_ARGS(ip, parent_ip));
+#else
+#define trace_preempt_enable(...)
+#define trace_preempt_disable(...)
+#define trace_preempt_enable_rcuidle(...)
+#define trace_preempt_disable_rcuidle(...)
 #endif
 
 #endif /* _TRACE_PREEMPTIRQ_H */
 
 #include <trace/define_trace.h>
 
-#endif /* !CONFIG_PREEMPTIRQ_EVENTS */
-
-#if !defined(CONFIG_PREEMPTIRQ_EVENTS) || defined(CONFIG_PROVE_LOCKING)
+#else /* !CONFIG_PREEMPTIRQ_TRACEPOINTS */
 #define trace_irq_enable(...)
 #define trace_irq_disable(...)
 #define trace_irq_enable_rcuidle(...)
 #define trace_irq_disable_rcuidle(...)
-#endif
-
-#if !defined(CONFIG_PREEMPTIRQ_EVENTS) || !defined(CONFIG_DEBUG_PREEMPT)
 #define trace_preempt_enable(...)
 #define trace_preempt_disable(...)
 #define trace_preempt_enable_rcuidle(...)
diff --git a/init/main.c b/init/main.c
index 3b4ada11ed52..5d42e577643a 100644
--- a/init/main.c
+++ b/init/main.c
@@ -648,6 +648,7 @@ asmlinkage __visible void __init start_kernel(void)
 	profile_init();
 	call_function_init();
 	WARN(!irqs_disabled(), "Interrupts were enabled early\n");
+
 	early_boot_irqs_disabled = false;
 	local_irq_enable();
 
@@ -663,7 +664,7 @@ asmlinkage __visible void __init start_kernel(void)
 		panic("Too many boot %s vars at `%s'", panic_later,
 		      panic_param);
 
-	lockdep_info();
+	lockdep_init();
 
 	/*
 	 * Need to run this when irqs are enabled, because it wants
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ccc579a7d32e..c0418ba52ba8 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -299,8 +299,8 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
  * Called with mm->mmap_sem held for write.
  * Return 0 (success) or a negative errno.
  */
-int uprobe_write_opcode(struct mm_struct *mm, unsigned long vaddr,
-			uprobe_opcode_t opcode)
+int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
+			unsigned long vaddr, uprobe_opcode_t opcode)
 {
 	struct page *old_page, *new_page;
 	struct vm_area_struct *vma;
@@ -351,7 +351,7 @@ int uprobe_write_opcode(struct mm_struct *mm, unsigned long vaddr,
  */
 int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
 {
-	return uprobe_write_opcode(mm, vaddr, UPROBE_SWBP_INSN);
+	return uprobe_write_opcode(auprobe, mm, vaddr, UPROBE_SWBP_INSN);
 }
 
 /**
@@ -366,7 +366,8 @@ int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned
 int __weak
 set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
 {
-	return uprobe_write_opcode(mm, vaddr, *(uprobe_opcode_t *)&auprobe->insn);
+	return uprobe_write_opcode(auprobe, mm, vaddr,
+			*(uprobe_opcode_t *)&auprobe->insn);
 }
 
 static struct uprobe *get_uprobe(struct uprobe *uprobe)
@@ -840,13 +841,8 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 	return err;
 }
 
-static int __uprobe_register(struct uprobe *uprobe, struct uprobe_consumer *uc)
-{
-	consumer_add(uprobe, uc);
-	return register_for_each_vma(uprobe, uc);
-}
-
-static void __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
+static void
+__uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
 	int err;
 
@@ -860,24 +856,46 @@ static void __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *u
 }
 
 /*
- * uprobe_register - register a probe
+ * uprobe_unregister - unregister a already registered probe.
+ * @inode: the file in which the probe has to be removed.
+ * @offset: offset from the start of the file.
+ * @uc: identify which probe if multiple probes are colocated.
+ */
+void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
+{
+	struct uprobe *uprobe;
+
+	uprobe = find_uprobe(inode, offset);
+	if (WARN_ON(!uprobe))
+		return;
+
+	down_write(&uprobe->register_rwsem);
+	__uprobe_unregister(uprobe, uc);
+	up_write(&uprobe->register_rwsem);
+	put_uprobe(uprobe);
+}
+EXPORT_SYMBOL_GPL(uprobe_unregister);
+
+/*
+ * __uprobe_register - register a probe
  * @inode: the file in which the probe has to be placed.
  * @offset: offset from the start of the file.
  * @uc: information on howto handle the probe..
  *
- * Apart from the access refcount, uprobe_register() takes a creation
+ * Apart from the access refcount, __uprobe_register() takes a creation
  * refcount (thro alloc_uprobe) if and only if this @uprobe is getting
  * inserted into the rbtree (i.e first consumer for a @inode:@offset
  * tuple).  Creation refcount stops uprobe_unregister from freeing the
  * @uprobe even before the register operation is complete. Creation
  * refcount is released when the last @uc for the @uprobe
- * unregisters. Caller of uprobe_register() is required to keep @inode
+ * unregisters. Caller of __uprobe_register() is required to keep @inode
  * (and the containing mount) referenced.
  *
  * Return errno if it cannot successully install probes
  * else return 0 (success)
  */
-int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
+static int __uprobe_register(struct inode *inode, loff_t offset,
+			     struct uprobe_consumer *uc)
 {
 	struct uprobe *uprobe;
 	int ret;
@@ -904,7 +922,8 @@ int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *
 	down_write(&uprobe->register_rwsem);
 	ret = -EAGAIN;
 	if (likely(uprobe_is_active(uprobe))) {
-		ret = __uprobe_register(uprobe, uc);
+		consumer_add(uprobe, uc);
+		ret = register_for_each_vma(uprobe, uc);
 		if (ret)
 			__uprobe_unregister(uprobe, uc);
 	}
@@ -915,6 +934,12 @@ int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *
 		goto retry;
 	return ret;
 }
+
+int uprobe_register(struct inode *inode, loff_t offset,
+		    struct uprobe_consumer *uc)
+{
+	return __uprobe_register(inode, offset, uc);
+}
 EXPORT_SYMBOL_GPL(uprobe_register);
 
 /*
@@ -946,27 +971,6 @@ int uprobe_apply(struct inode *inode, loff_t offset,
 	return ret;
 }
 
-/*
- * uprobe_unregister - unregister a already registered probe.
- * @inode: the file in which the probe has to be removed.
- * @offset: offset from the start of the file.
- * @uc: identify which probe if multiple probes are colocated.
- */
-void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
-{
-	struct uprobe *uprobe;
-
-	uprobe = find_uprobe(inode, offset);
-	if (WARN_ON(!uprobe))
-		return;
-
-	down_write(&uprobe->register_rwsem);
-	__uprobe_unregister(uprobe, uc);
-	up_write(&uprobe->register_rwsem);
-	put_uprobe(uprobe);
-}
-EXPORT_SYMBOL_GPL(uprobe_unregister);
-
 static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 5fa4d3138bf1..e406c5fdb41e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -55,6 +55,7 @@
 
 #include "lockdep_internals.h"
 
+#include <trace/events/preemptirq.h>
 #define CREATE_TRACE_POINTS
 #include <trace/events/lock.h>
 
@@ -248,12 +249,7 @@ void clear_lock_stats(struct lock_class *class)
 
 static struct lock_class_stats *get_lock_stats(struct lock_class *class)
 {
-	return &get_cpu_var(cpu_lock_stats)[class - lock_classes];
-}
-
-static void put_lock_stats(struct lock_class_stats *stats)
-{
-	put_cpu_var(cpu_lock_stats);
+	return &this_cpu_ptr(cpu_lock_stats)[class - lock_classes];
 }
 
 static void lock_release_holdtime(struct held_lock *hlock)
@@ -271,7 +267,6 @@ static void lock_release_holdtime(struct held_lock *hlock)
 		lock_time_inc(&stats->read_holdtime, holdtime);
 	else
 		lock_time_inc(&stats->write_holdtime, holdtime);
-	put_lock_stats(stats);
 }
 #else
 static inline void lock_release_holdtime(struct held_lock *hlock)
@@ -2845,10 +2840,8 @@ static void __trace_hardirqs_on_caller(unsigned long ip)
 	debug_atomic_inc(hardirqs_on_events);
 }
 
-__visible void trace_hardirqs_on_caller(unsigned long ip)
+void lockdep_hardirqs_on(unsigned long ip)
 {
-	time_hardirqs_on(CALLER_ADDR0, ip);
-
 	if (unlikely(!debug_locks || current->lockdep_recursion))
 		return;
 
@@ -2887,23 +2880,14 @@ __visible void trace_hardirqs_on_caller(unsigned long ip)
 	__trace_hardirqs_on_caller(ip);
 	current->lockdep_recursion = 0;
 }
-EXPORT_SYMBOL(trace_hardirqs_on_caller);
-
-void trace_hardirqs_on(void)
-{
-	trace_hardirqs_on_caller(CALLER_ADDR0);
-}
-EXPORT_SYMBOL(trace_hardirqs_on);
 
 /*
  * Hardirqs were disabled:
  */
-__visible void trace_hardirqs_off_caller(unsigned long ip)
+void lockdep_hardirqs_off(unsigned long ip)
 {
 	struct task_struct *curr = current;
 
-	time_hardirqs_off(CALLER_ADDR0, ip);
-
 	if (unlikely(!debug_locks || current->lockdep_recursion))
 		return;
 
@@ -2925,13 +2909,6 @@ __visible void trace_hardirqs_off_caller(unsigned long ip)
 	} else
 		debug_atomic_inc(redundant_hardirqs_off);
 }
-EXPORT_SYMBOL(trace_hardirqs_off_caller);
-
-void trace_hardirqs_off(void)
-{
-	trace_hardirqs_off_caller(CALLER_ADDR0);
-}
-EXPORT_SYMBOL(trace_hardirqs_off);
 
 /*
  * Softirqs will be enabled:
@@ -4090,7 +4067,6 @@ __lock_contended(struct lockdep_map *lock, unsigned long ip)
 		stats->contending_point[contending_point]++;
 	if (lock->cpu != smp_processor_id())
 		stats->bounces[bounce_contended + !!hlock->read]++;
-	put_lock_stats(stats);
 }
 
 static void
@@ -4138,7 +4114,6 @@ __lock_acquired(struct lockdep_map *lock, unsigned long ip)
 	}
 	if (lock->cpu != cpu)
 		stats->bounces[bounce_acquired + !!hlock->read]++;
-	put_lock_stats(stats);
 
 	lock->cpu = cpu;
 	lock->ip = ip;
@@ -4338,7 +4313,7 @@ void lockdep_reset_lock(struct lockdep_map *lock)
 	raw_local_irq_restore(flags);
 }
 
-void __init lockdep_info(void)
+void __init lockdep_init(void)
 {
 	printk("Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar\n");
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fe365c9a08e9..5de1a4343424 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3189,7 +3189,7 @@ static inline void sched_tick_stop(int cpu) { }
 #endif
 
 #if defined(CONFIG_PREEMPT) && (defined(CONFIG_DEBUG_PREEMPT) || \
-				defined(CONFIG_PREEMPT_TRACER))
+				defined(CONFIG_TRACE_PREEMPT_TOGGLE))
 /*
  * If the value passed in is equal to the current preempt count
  * then we just disabled preemption. Start timing the latency.
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index dcc0166d1997..fd6754b88f87 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -47,6 +47,11 @@ config HAVE_FENTRY
 	help
 	  Arch supports the gcc options -pg with -mfentry
 
+config HAVE_NOP_MCOUNT
+	bool
+	help
+	  Arch supports the gcc options -pg with -mrecord-mcount and -nop-mcount
+
 config HAVE_C_RECORDMCOUNT
 	bool
 	help
@@ -82,6 +87,15 @@ config RING_BUFFER_ALLOW_SWAP
 	 Allow the use of ring_buffer_swap_cpu.
 	 Adds a very slight overhead to tracing when enabled.
 
+config PREEMPTIRQ_TRACEPOINTS
+	bool
+	depends on TRACE_PREEMPT_TOGGLE || TRACE_IRQFLAGS
+	select TRACING
+	default y
+	help
+	  Create preempt/irq toggle tracepoints if needed, so that other parts
+	  of the kernel can use them to generate or add hooks to them.
+
 # All tracer options should select GENERIC_TRACER. For those options that are
 # enabled by all tracers (context switch and event tracer) they select TRACING.
 # This allows those options to appear when no other tracer is selected. But the
@@ -155,18 +169,20 @@ config FUNCTION_GRAPH_TRACER
 	  the return value. This is done by setting the current return
 	  address on the current task structure into a stack of calls.
 
+config TRACE_PREEMPT_TOGGLE
+	bool
+	help
+	  Enables hooks which will be called when preemption is first disabled,
+	  and last enabled.
 
 config PREEMPTIRQ_EVENTS
 	bool "Enable trace events for preempt and irq disable/enable"
 	select TRACE_IRQFLAGS
-	depends on DEBUG_PREEMPT || !PROVE_LOCKING
-	depends on TRACING
+	select TRACE_PREEMPT_TOGGLE if PREEMPT
+	select GENERIC_TRACER
 	default n
 	help
 	  Enable tracing of disable and enable events for preemption and irqs.
-	  For tracing preempt disable/enable events, DEBUG_PREEMPT must be
-	  enabled. For tracing irq disable/enable events, PROVE_LOCKING must
-	  be disabled.
 
 config IRQSOFF_TRACER
 	bool "Interrupts-off Latency Tracer"
@@ -203,6 +219,7 @@ config PREEMPT_TRACER
 	select RING_BUFFER_ALLOW_SWAP
 	select TRACER_SNAPSHOT
 	select TRACER_SNAPSHOT_PER_CPU_SWAP
+	select TRACE_PREEMPT_TOGGLE
 	help
 	  This option measures the time spent in preemption-off critical
 	  sections, with microsecond accuracy.
@@ -456,6 +473,26 @@ config KPROBE_EVENTS
 	  This option is also required by perf-probe subcommand of perf tools.
 	  If you want to use perf tools, this option is strongly recommended.
 
+config KPROBE_EVENTS_ON_NOTRACE
+	bool "Do NOT protect notrace function from kprobe events"
+	depends on KPROBE_EVENTS
+	depends on KPROBES_ON_FTRACE
+	default n
+	help
+	  This is only for the developers who want to debug ftrace itself
+	  using kprobe events.
+
+	  If kprobes can use ftrace instead of breakpoint, ftrace related
+	  functions are protected from kprobe-events to prevent an infinit
+	  recursion or any unexpected execution path which leads to a kernel
+	  crash.
+
+	  This option disables such protection and allows you to put kprobe
+	  events on ftrace functions for debugging ftrace by itself.
+	  Note that this might let you shoot yourself in the foot.
+
+	  If unsure, say N.
+
 config UPROBE_EVENTS
 	bool "Enable uprobes-based dynamic events"
 	depends on ARCH_SUPPORTS_UPROBES
@@ -687,6 +724,21 @@ config RING_BUFFER_STARTUP_TEST
 
 	 If unsure, say N
 
+config PREEMPTIRQ_DELAY_TEST
+	tristate "Preempt / IRQ disable delay thread to test latency tracers"
+	depends on m
+	help
+	  Select this option to build a test module that can help test latency
+	  tracers by executing a preempt or irq disable section with a user
+	  configurable delay. The module busy waits for the duration of the
+	  critical section.
+
+	  For example, the following invocation forces a one-time irq-disabled
+	  critical section for 500us:
+	  modprobe preemptirq_delay_test test_mode=irq delay=500000
+
+	  If unsure, say N
+
 config TRACE_EVAL_MAP_FILE
        bool "Show eval mappings for trace events"
        depends on TRACING
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index e2538c7638d4..98d53b39a8ee 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -13,6 +13,11 @@ obj-y += trace_selftest_dynamic.o
 endif
 endif
 
+ifdef CONFIG_FTRACE_STARTUP_TEST
+CFLAGS_trace_kprobe_selftest.o = $(CC_FLAGS_FTRACE)
+obj-$(CONFIG_KPROBE_EVENTS) += trace_kprobe_selftest.o
+endif
+
 # If unlikely tracing is enabled, do not trace these files
 ifdef CONFIG_TRACING_BRANCHES
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
@@ -33,9 +38,10 @@ obj-$(CONFIG_TRACING) += trace_seq.o
 obj-$(CONFIG_TRACING) += trace_stat.o
 obj-$(CONFIG_TRACING) += trace_printk.o
 obj-$(CONFIG_TRACING_MAP) += tracing_map.o
+obj-$(CONFIG_PREEMPTIRQ_DELAY_TEST) += preemptirq_delay_test.o
 obj-$(CONFIG_CONTEXT_SWITCH_TRACER) += trace_sched_switch.o
 obj-$(CONFIG_FUNCTION_TRACER) += trace_functions.o
-obj-$(CONFIG_PREEMPTIRQ_EVENTS) += trace_irqsoff.o
+obj-$(CONFIG_PREEMPTIRQ_TRACEPOINTS) += trace_preemptirq.o
 obj-$(CONFIG_IRQSOFF_TRACER) += trace_irqsoff.o
 obj-$(CONFIG_PREEMPT_TRACER) += trace_irqsoff.o
 obj-$(CONFIG_SCHED_TRACER) += trace_sched_wakeup.o
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 987d9a9ae283..b82e546083e1 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2006 Jens Axboe <axboe@kernel.dk>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
  */
 #include <linux/kernel.h>
 #include <linux/blkdev.h>
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0ae6829804bc..08fcfe440c63 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1,9 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2011-2015 PLUMgrid, http://plumgrid.com
  * Copyright (c) 2016 Facebook
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
  */
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index caf9cbf35816..f536f601bd46 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Infrastructure for profiling code inserted by 'gcc -pg'.
  *
@@ -157,30 +158,6 @@ static inline void ftrace_ops_init(struct ftrace_ops *ops)
 #endif
 }
 
-/**
- * ftrace_nr_registered_ops - return number of ops registered
- *
- * Returns the number of ftrace_ops registered and tracing functions
- */
-int ftrace_nr_registered_ops(void)
-{
-	struct ftrace_ops *ops;
-	int cnt = 0;
-
-	mutex_lock(&ftrace_lock);
-
-	for (ops = rcu_dereference_protected(ftrace_ops_list,
-					     lockdep_is_held(&ftrace_lock));
-	     ops != &ftrace_list_end;
-	     ops = rcu_dereference_protected(ops->next,
-					     lockdep_is_held(&ftrace_lock)))
-		cnt++;
-
-	mutex_unlock(&ftrace_lock);
-
-	return cnt;
-}
-
 static void ftrace_pid_func(unsigned long ip, unsigned long parent_ip,
 			    struct ftrace_ops *op, struct pt_regs *regs)
 {
@@ -313,11 +290,6 @@ static void update_ftrace_function(void)
 	ftrace_trace_function = func;
 }
 
-int using_ftrace_ops_list_func(void)
-{
-	return ftrace_trace_function == ftrace_ops_list_func;
-}
-
 static void add_ftrace_ops(struct ftrace_ops __rcu **list,
 			   struct ftrace_ops *ops)
 {
@@ -1049,8 +1021,6 @@ static __init void ftrace_profile_tracefs(struct dentry *d_tracer)
 }
 #endif /* CONFIG_FUNCTION_PROFILER */
 
-static struct pid * const ftrace_swapper_pid = &init_struct_pid;
-
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 static int ftrace_graph_active;
 #else
@@ -2927,22 +2897,22 @@ ops_references_rec(struct ftrace_ops *ops, struct dyn_ftrace *rec)
 {
 	/* If ops isn't enabled, ignore it */
 	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
-		return 0;
+		return false;
 
 	/* If ops traces all then it includes this function */
 	if (ops_traces_mod(ops))
-		return 1;
+		return true;
 
 	/* The function must be in the filter */
 	if (!ftrace_hash_empty(ops->func_hash->filter_hash) &&
 	    !__ftrace_lookup_ip(ops->func_hash->filter_hash, rec->ip))
-		return 0;
+		return false;
 
 	/* If in notrace hash, we ignore it too */
 	if (ftrace_lookup_ip(ops->func_hash->notrace_hash, rec->ip))
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
 static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
@@ -2981,12 +2951,14 @@ static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
 			p = &pg->records[i];
 			p->flags = rec_flags;
 
+#ifndef CC_USING_NOP_MCOUNT
 			/*
 			 * Do the initial record conversion from mcount jump
 			 * to the NOP instructions.
 			 */
 			if (!ftrace_code_disable(mod, p))
 				break;
+#endif
 
 			update_cnt++;
 		}
diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
new file mode 100644
index 000000000000..f704390db9fc
--- /dev/null
+++ b/kernel/trace/preemptirq_delay_test.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Preempt / IRQ disable delay thread to test latency tracers
+ *
+ * Copyright (C) 2018 Joel Fernandes (Google) <joel@joelfernandes.org>
+ */
+
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/ktime.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/string.h>
+
+static ulong delay = 100;
+static char test_mode[10] = "irq";
+
+module_param_named(delay, delay, ulong, S_IRUGO);
+module_param_string(test_mode, test_mode, 10, S_IRUGO);
+MODULE_PARM_DESC(delay, "Period in microseconds (100 uS default)");
+MODULE_PARM_DESC(test_mode, "Mode of the test such as preempt or irq (default irq)");
+
+static void busy_wait(ulong time)
+{
+	ktime_t start, end;
+	start = ktime_get();
+	do {
+		end = ktime_get();
+		if (kthread_should_stop())
+			break;
+	} while (ktime_to_ns(ktime_sub(end, start)) < (time * 1000));
+}
+
+static int preemptirq_delay_run(void *data)
+{
+	unsigned long flags;
+
+	if (!strcmp(test_mode, "irq")) {
+		local_irq_save(flags);
+		busy_wait(delay);
+		local_irq_restore(flags);
+	} else if (!strcmp(test_mode, "preempt")) {
+		preempt_disable();
+		busy_wait(delay);
+		preempt_enable();
+	}
+
+	return 0;
+}
+
+static int __init preemptirq_delay_init(void)
+{
+	char task_name[50];
+	struct task_struct *test_task;
+
+	snprintf(task_name, sizeof(task_name), "%s_test", test_mode);
+
+	test_task = kthread_run(preemptirq_delay_run, NULL, task_name);
+	return PTR_ERR_OR_ZERO(test_task);
+}
+
+static void __exit preemptirq_delay_exit(void)
+{
+	return;
+}
+
+module_init(preemptirq_delay_init)
+module_exit(preemptirq_delay_exit)
+MODULE_LICENSE("GPL v2");
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 0b0b688ea166..1d92d4a982fd 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Generic ring buffer
  *
@@ -3221,7 +3222,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_record_on);
  *
  * Returns true if the ring buffer is in a state that it accepts writes.
  */
-int ring_buffer_record_is_on(struct ring_buffer *buffer)
+bool ring_buffer_record_is_on(struct ring_buffer *buffer)
 {
 	return !atomic_read(&buffer->record_disabled);
 }
@@ -3237,7 +3238,7 @@ int ring_buffer_record_is_on(struct ring_buffer *buffer)
  * ring_buffer_record_disable(), as that is a temporary disabling of
  * the ring buffer.
  */
-int ring_buffer_record_is_set_on(struct ring_buffer *buffer)
+bool ring_buffer_record_is_set_on(struct ring_buffer *buffer)
 {
 	return !(atomic_read(&buffer->record_disabled) & RB_BUFFER_OFF);
 }
diff --git a/kernel/trace/ring_buffer_benchmark.c b/kernel/trace/ring_buffer_benchmark.c
index 68ee79afe31c..ffba6789c0e2 100644
--- a/kernel/trace/ring_buffer_benchmark.c
+++ b/kernel/trace/ring_buffer_benchmark.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ring buffer tester and benchmark
  *
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 823687997b01..4ecd8950b513 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ring buffer based function tracer
  *
@@ -1087,7 +1088,7 @@ void disable_trace_on_warning(void)
  *
  * Shows real state of the ring buffer if it is enabled or not.
  */
-int tracer_tracing_is_on(struct trace_array *tr)
+bool tracer_tracing_is_on(struct trace_array *tr)
 {
 	if (tr->trace_buffer.buffer)
 		return ring_buffer_record_is_on(tr->trace_buffer.buffer);
@@ -7628,7 +7629,9 @@ rb_simple_write(struct file *filp, const char __user *ubuf,
 
 	if (buffer) {
 		mutex_lock(&trace_types_lock);
-		if (val) {
+		if (!!val == tracer_tracing_is_on(tr)) {
+			val = 0; /* do nothing */
+		} else if (val) {
 			tracer_tracing_on(tr);
 			if (tr->current_trace->start)
 				tr->current_trace->start(tr);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index f8f86231ad90..3b8c0e24ab30 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
 
 #ifndef _LINUX_KERNEL_TRACE_H
 #define _LINUX_KERNEL_TRACE_H
@@ -594,7 +594,7 @@ void tracing_reset_current(int cpu);
 void tracing_reset_all_online_cpus(void);
 int tracing_open_generic(struct inode *inode, struct file *filp);
 bool tracing_is_disabled(void);
-int tracer_tracing_is_on(struct trace_array *tr);
+bool tracer_tracing_is_on(struct trace_array *tr);
 void tracer_tracing_on(struct trace_array *tr);
 void tracer_tracing_off(struct trace_array *tr);
 struct dentry *trace_create_file(const char *name,
@@ -937,7 +937,6 @@ void ftrace_destroy_function_files(struct trace_array *tr);
 void ftrace_init_global_array_ops(struct trace_array *tr);
 void ftrace_init_array_ops(struct trace_array *tr, ftrace_func_t func);
 void ftrace_reset_array_ops(struct trace_array *tr);
-int using_ftrace_ops_list_func(void);
 void ftrace_init_tracefs(struct trace_array *tr, struct dentry *d_tracer);
 void ftrace_init_tracefs_toplevel(struct trace_array *tr,
 				  struct dentry *d_tracer);
@@ -1533,9 +1532,6 @@ extern int event_trigger_init(struct event_trigger_ops *ops,
 extern int trace_event_trigger_enable_disable(struct trace_event_file *file,
 					      int trigger_enable);
 extern void update_cond_flag(struct trace_event_file *file);
-extern void unregister_trigger(char *glob, struct event_trigger_ops *ops,
-			       struct event_trigger_data *test,
-			       struct trace_event_file *file);
 extern int set_trigger_filter(char *filter_str,
 			      struct event_trigger_data *trigger_data,
 			      struct trace_event_file *file);
@@ -1831,6 +1827,21 @@ static inline int tracing_alloc_snapshot_instance(struct trace_array *tr)
 }
 #endif
 
+#ifdef CONFIG_PREEMPT_TRACER
+void tracer_preempt_on(unsigned long a0, unsigned long a1);
+void tracer_preempt_off(unsigned long a0, unsigned long a1);
+#else
+static inline void tracer_preempt_on(unsigned long a0, unsigned long a1) { }
+static inline void tracer_preempt_off(unsigned long a0, unsigned long a1) { }
+#endif
+#ifdef CONFIG_IRQSOFF_TRACER
+void tracer_hardirqs_on(unsigned long a0, unsigned long a1);
+void tracer_hardirqs_off(unsigned long a0, unsigned long a1);
+#else
+static inline void tracer_hardirqs_on(unsigned long a0, unsigned long a1) { }
+static inline void tracer_hardirqs_off(unsigned long a0, unsigned long a1) { }
+#endif
+
 extern struct trace_iterator *tracepoint_print_iter;
 
 #endif /* _LINUX_KERNEL_TRACE_H */
diff --git a/kernel/trace/trace_benchmark.h b/kernel/trace/trace_benchmark.h
index be1d86ff753d..79e6fbe5b365 100644
--- a/kernel/trace/trace_benchmark.h
+++ b/kernel/trace/trace_benchmark.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM benchmark
 
diff --git a/kernel/trace/trace_clock.c b/kernel/trace/trace_clock.c
index d8a188e0418a..aaf6793ededa 100644
--- a/kernel/trace/trace_clock.c
+++ b/kernel/trace/trace_clock.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * tracing clocks
  *
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index 1d67464ed95e..06bb2fd9a56c 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file defines the trace event structures that go into the ring
  * buffer directly. They are created via macros so that changes for them
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index c79193e598f5..69a3fe926e8c 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * trace event based perf event profiling/tracing
  *
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 14ff4ff3caab..f94be0c2827b 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * event tracer
  *
@@ -239,7 +240,7 @@ bool trace_event_ignore_this_pid(struct trace_event_file *trace_file)
 	struct trace_array_cpu *data;
 	struct trace_pid_list *pid_list;
 
-	pid_list = rcu_dereference_sched(tr->filtered_pids);
+	pid_list = rcu_dereference_raw(tr->filtered_pids);
 	if (!pid_list)
 		return false;
 
@@ -512,7 +513,7 @@ event_filter_pid_sched_process_exit(void *data, struct task_struct *task)
 	struct trace_pid_list *pid_list;
 	struct trace_array *tr = data;
 
-	pid_list = rcu_dereference_sched(tr->filtered_pids);
+	pid_list = rcu_dereference_raw(tr->filtered_pids);
 	trace_filter_add_remove_task(pid_list, NULL, task);
 }
 
@@ -636,7 +637,7 @@ static void __ftrace_clear_event_pids(struct trace_array *tr)
 	rcu_assign_pointer(tr->filtered_pids, NULL);
 
 	/* Wait till all users are no longer using pid filtering */
-	synchronize_sched();
+	tracepoint_synchronize_unregister();
 
 	trace_free_pid_list(pid_list);
 }
@@ -1622,7 +1623,7 @@ ftrace_event_pid_write(struct file *filp, const char __user *ubuf,
 	}
 
 	if (filtered_pids) {
-		synchronize_sched();
+		tracepoint_synchronize_unregister();
 		trace_free_pid_list(filtered_pids);
 	} else if (pid_list) {
 		/*
@@ -3036,8 +3037,8 @@ int event_trace_del_tracer(struct trace_array *tr)
 	/* Disable any running events */
 	__ftrace_set_clr_event_nolock(tr, NULL, NULL, NULL, 0);
 
-	/* Access to events are within rcu_read_lock_sched() */
-	synchronize_sched();
+	/* Make sure no more events are being executed */
+	tracepoint_synchronize_unregister();
 
 	down_write(&trace_event_sem);
 	__trace_remove_event_dirs(tr);
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 893a206bcba4..84a65173b1e9 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * trace_events_filter - generic event filtering
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- *
  * Copyright (C) 2009 Tom Zanussi <tzanussi@gmail.com>
  */
 
@@ -899,7 +886,8 @@ int filter_match_preds(struct event_filter *filter, void *rec)
 	if (!filter)
 		return 1;
 
-	prog = rcu_dereference_sched(filter->prog);
+	/* Protected by either SRCU(tracepoint_srcu) or preempt_disable */
+	prog = rcu_dereference_raw(filter->prog);
 	if (!prog)
 		return 1;
 
@@ -1626,10 +1614,10 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 
 	/*
 	 * The calls can still be using the old filters.
-	 * Do a synchronize_sched() to ensure all calls are
+	 * Do a synchronize_sched() and to ensure all calls are
 	 * done with them before we free them.
 	 */
-	synchronize_sched();
+	tracepoint_synchronize_unregister();
 	list_for_each_entry_safe(filter_item, tmp, &filter_list, list) {
 		__free_filter(filter_item->filter);
 		list_del(&filter_item->list);
@@ -1648,7 +1636,7 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 	kfree(filter);
 	/* If any call succeeded, we still need to sync */
 	if (!fail)
-		synchronize_sched();
+		tracepoint_synchronize_unregister();
 	list_for_each_entry_safe(filter_item, tmp, &filter_list, list) {
 		__free_filter(filter_item->filter);
 		list_del(&filter_item->list);
@@ -1790,7 +1778,7 @@ int apply_event_filter(struct trace_event_file *file, char *filter_string)
 		event_clear_filter(file);
 
 		/* Make sure the filter is not being used */
-		synchronize_sched();
+		tracepoint_synchronize_unregister();
 		__free_filter(filter);
 
 		return 0;
@@ -1817,7 +1805,7 @@ int apply_event_filter(struct trace_event_file *file, char *filter_string)
 
 		if (tmp) {
 			/* Make sure the call is done with the filter */
-			synchronize_sched();
+			tracepoint_synchronize_unregister();
 			__free_filter(tmp);
 		}
 	}
@@ -1847,7 +1835,7 @@ int apply_subsystem_event_filter(struct trace_subsystem_dir *dir,
 		filter = system->filter;
 		system->filter = NULL;
 		/* Ensure all filters are no longer used */
-		synchronize_sched();
+		tracepoint_synchronize_unregister();
 		filter_free_subsystem_filters(dir, tr);
 		__free_filter(filter);
 		goto out_unlock;
diff --git a/kernel/trace/trace_events_filter_test.h b/kernel/trace/trace_events_filter_test.h
index 39d7ef4f57cb..e651dfbd345e 100644
--- a/kernel/trace/trace_events_filter_test.h
+++ b/kernel/trace/trace_events_filter_test.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM test
 
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index aae18af94c94..85f6b01431c7 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1,16 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * trace_events_hist - trace event hist triggers
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  * Copyright (C) 2015 Tom Zanussi <tom.zanussi@linux.intel.com>
  */
 
@@ -5141,7 +5132,7 @@ static void hist_clear(struct event_trigger_data *data)
 	if (data->name)
 		pause_named_trigger(data);
 
-	synchronize_sched();
+	tracepoint_synchronize_unregister();
 
 	tracing_map_clear(hist_data->map);
 
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 5dea177cef53..2152d1e530cb 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * trace_events_trigger - trace event triggers
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- *
  * Copyright (C) 2013 Tom Zanussi <tom.zanussi@linux.intel.com>
  */
 
@@ -34,7 +21,9 @@ void trigger_data_free(struct event_trigger_data *data)
 	if (data->cmd_ops->set_filter)
 		data->cmd_ops->set_filter(NULL, data, NULL);
 
-	synchronize_sched(); /* make sure current triggers exit before free */
+	/* make sure current triggers exit before free */
+	tracepoint_synchronize_unregister();
+
 	kfree(data);
 }
 
@@ -579,9 +568,9 @@ static int register_trigger(char *glob, struct event_trigger_ops *ops,
  * Usually used directly as the @unreg method in event command
  * implementations.
  */
-void unregister_trigger(char *glob, struct event_trigger_ops *ops,
-			struct event_trigger_data *test,
-			struct trace_event_file *file)
+static void unregister_trigger(char *glob, struct event_trigger_ops *ops,
+			       struct event_trigger_data *test,
+			       struct trace_event_file *file)
 {
 	struct event_trigger_data *data;
 	bool unregistered = false;
@@ -752,7 +741,7 @@ int set_trigger_filter(char *filter_str,
 
 	if (tmp) {
 		/* Make sure the call is done with the filter */
-		synchronize_sched();
+		tracepoint_synchronize_unregister();
 		free_event_filter(tmp);
 	}
 
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index d7c8e4ec3d9d..1e6db9cbe4dc 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * trace_hwlatdetect.c - A simple Hardware Latency detector.
  *
@@ -35,9 +36,6 @@
  *
  * Includes useful feedback from Clark Williams <clark@redhat.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/kthread.h>
 #include <linux/tracefs.h>
@@ -354,6 +352,9 @@ static int start_kthread(struct trace_array *tr)
 	struct task_struct *kthread;
 	int next_cpu;
 
+	if (WARN_ON(hwlat_kthread))
+		return 0;
+
 	/* Just pick the first CPU on first iteration */
 	current_mask = &save_cpumask;
 	get_online_cpus();
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 03ecb4465ee4..b7357f9f82a3 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * trace irqs off critical timings
  *
@@ -16,7 +17,6 @@
 
 #include "trace.h"
 
-#define CREATE_TRACE_POINTS
 #include <trace/events/preemptirq.h>
 
 #if defined(CONFIG_IRQSOFF_TRACER) || defined(CONFIG_PREEMPT_TRACER)
@@ -41,12 +41,12 @@ static int start_irqsoff_tracer(struct trace_array *tr, int graph);
 
 #ifdef CONFIG_PREEMPT_TRACER
 static inline int
-preempt_trace(void)
+preempt_trace(int pc)
 {
-	return ((trace_type & TRACER_PREEMPT_OFF) && preempt_count());
+	return ((trace_type & TRACER_PREEMPT_OFF) && pc);
 }
 #else
-# define preempt_trace() (0)
+# define preempt_trace(pc) (0)
 #endif
 
 #ifdef CONFIG_IRQSOFF_TRACER
@@ -367,7 +367,7 @@ check_critical_timing(struct trace_array *tr,
 }
 
 static inline void
-start_critical_timing(unsigned long ip, unsigned long parent_ip)
+start_critical_timing(unsigned long ip, unsigned long parent_ip, int pc)
 {
 	int cpu;
 	struct trace_array *tr = irqsoff_trace;
@@ -395,7 +395,7 @@ start_critical_timing(unsigned long ip, unsigned long parent_ip)
 
 	local_save_flags(flags);
 
-	__trace_function(tr, ip, parent_ip, flags, preempt_count());
+	__trace_function(tr, ip, parent_ip, flags, pc);
 
 	per_cpu(tracing_cpu, cpu) = 1;
 
@@ -403,7 +403,7 @@ start_critical_timing(unsigned long ip, unsigned long parent_ip)
 }
 
 static inline void
-stop_critical_timing(unsigned long ip, unsigned long parent_ip)
+stop_critical_timing(unsigned long ip, unsigned long parent_ip, int pc)
 {
 	int cpu;
 	struct trace_array *tr = irqsoff_trace;
@@ -429,7 +429,7 @@ stop_critical_timing(unsigned long ip, unsigned long parent_ip)
 	atomic_inc(&data->disabled);
 
 	local_save_flags(flags);
-	__trace_function(tr, ip, parent_ip, flags, preempt_count());
+	__trace_function(tr, ip, parent_ip, flags, pc);
 	check_critical_timing(tr, data, parent_ip ? : ip, cpu);
 	data->critical_start = 0;
 	atomic_dec(&data->disabled);
@@ -438,77 +438,21 @@ stop_critical_timing(unsigned long ip, unsigned long parent_ip)
 /* start and stop critical timings used to for stoppage (in idle) */
 void start_critical_timings(void)
 {
-	if (preempt_trace() || irq_trace())
-		start_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
+	int pc = preempt_count();
+
+	if (preempt_trace(pc) || irq_trace())
+		start_critical_timing(CALLER_ADDR0, CALLER_ADDR1, pc);
 }
 EXPORT_SYMBOL_GPL(start_critical_timings);
 
 void stop_critical_timings(void)
 {
-	if (preempt_trace() || irq_trace())
-		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
-}
-EXPORT_SYMBOL_GPL(stop_critical_timings);
-
-#ifdef CONFIG_IRQSOFF_TRACER
-#ifdef CONFIG_PROVE_LOCKING
-void time_hardirqs_on(unsigned long a0, unsigned long a1)
-{
-	if (!preempt_trace() && irq_trace())
-		stop_critical_timing(a0, a1);
-}
-
-void time_hardirqs_off(unsigned long a0, unsigned long a1)
-{
-	if (!preempt_trace() && irq_trace())
-		start_critical_timing(a0, a1);
-}
-
-#else /* !CONFIG_PROVE_LOCKING */
-
-/*
- * We are only interested in hardirq on/off events:
- */
-static inline void tracer_hardirqs_on(void)
-{
-	if (!preempt_trace() && irq_trace())
-		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
-}
+	int pc = preempt_count();
 
-static inline void tracer_hardirqs_off(void)
-{
-	if (!preempt_trace() && irq_trace())
-		start_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
-}
-
-static inline void tracer_hardirqs_on_caller(unsigned long caller_addr)
-{
-	if (!preempt_trace() && irq_trace())
-		stop_critical_timing(CALLER_ADDR0, caller_addr);
-}
-
-static inline void tracer_hardirqs_off_caller(unsigned long caller_addr)
-{
-	if (!preempt_trace() && irq_trace())
-		start_critical_timing(CALLER_ADDR0, caller_addr);
-}
-
-#endif /* CONFIG_PROVE_LOCKING */
-#endif /*  CONFIG_IRQSOFF_TRACER */
-
-#ifdef CONFIG_PREEMPT_TRACER
-static inline void tracer_preempt_on(unsigned long a0, unsigned long a1)
-{
-	if (preempt_trace() && !irq_trace())
-		stop_critical_timing(a0, a1);
-}
-
-static inline void tracer_preempt_off(unsigned long a0, unsigned long a1)
-{
-	if (preempt_trace() && !irq_trace())
-		start_critical_timing(a0, a1);
+	if (preempt_trace(pc) || irq_trace())
+		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1, pc);
 }
-#endif /* CONFIG_PREEMPT_TRACER */
+EXPORT_SYMBOL_GPL(stop_critical_timings);
 
 #ifdef CONFIG_FUNCTION_TRACER
 static bool function_enabled;
@@ -634,7 +578,7 @@ static int __irqsoff_tracer_init(struct trace_array *tr)
 	return 0;
 }
 
-static void irqsoff_tracer_reset(struct trace_array *tr)
+static void __irqsoff_tracer_reset(struct trace_array *tr)
 {
 	int lat_flag = save_flags & TRACE_ITER_LATENCY_FMT;
 	int overwrite_flag = save_flags & TRACE_ITER_OVERWRITE;
@@ -659,12 +603,37 @@ static void irqsoff_tracer_stop(struct trace_array *tr)
 }
 
 #ifdef CONFIG_IRQSOFF_TRACER
+/*
+ * We are only interested in hardirq on/off events:
+ */
+void tracer_hardirqs_on(unsigned long a0, unsigned long a1)
+{
+	unsigned int pc = preempt_count();
+
+	if (!preempt_trace(pc) && irq_trace())
+		stop_critical_timing(a0, a1, pc);
+}
+
+void tracer_hardirqs_off(unsigned long a0, unsigned long a1)
+{
+	unsigned int pc = preempt_count();
+
+	if (!preempt_trace(pc) && irq_trace())
+		start_critical_timing(a0, a1, pc);
+}
+
 static int irqsoff_tracer_init(struct trace_array *tr)
 {
 	trace_type = TRACER_IRQS_OFF;
 
 	return __irqsoff_tracer_init(tr);
 }
+
+static void irqsoff_tracer_reset(struct trace_array *tr)
+{
+	__irqsoff_tracer_reset(tr);
+}
+
 static struct tracer irqsoff_tracer __read_mostly =
 {
 	.name		= "irqsoff",
@@ -684,12 +653,25 @@ static struct tracer irqsoff_tracer __read_mostly =
 	.allow_instances = true,
 	.use_max_tr	= true,
 };
-# define register_irqsoff(trace) register_tracer(&trace)
-#else
-# define register_irqsoff(trace) do { } while (0)
-#endif
+#endif /*  CONFIG_IRQSOFF_TRACER */
 
 #ifdef CONFIG_PREEMPT_TRACER
+void tracer_preempt_on(unsigned long a0, unsigned long a1)
+{
+	int pc = preempt_count();
+
+	if (preempt_trace(pc) && !irq_trace())
+		stop_critical_timing(a0, a1, pc);
+}
+
+void tracer_preempt_off(unsigned long a0, unsigned long a1)
+{
+	int pc = preempt_count();
+
+	if (preempt_trace(pc) && !irq_trace())
+		start_critical_timing(a0, a1, pc);
+}
+
 static int preemptoff_tracer_init(struct trace_array *tr)
 {
 	trace_type = TRACER_PREEMPT_OFF;
@@ -697,11 +679,16 @@ static int preemptoff_tracer_init(struct trace_array *tr)
 	return __irqsoff_tracer_init(tr);
 }
 
+static void preemptoff_tracer_reset(struct trace_array *tr)
+{
+	__irqsoff_tracer_reset(tr);
+}
+
 static struct tracer preemptoff_tracer __read_mostly =
 {
 	.name		= "preemptoff",
 	.init		= preemptoff_tracer_init,
-	.reset		= irqsoff_tracer_reset,
+	.reset		= preemptoff_tracer_reset,
 	.start		= irqsoff_tracer_start,
 	.stop		= irqsoff_tracer_stop,
 	.print_max	= true,
@@ -716,13 +703,9 @@ static struct tracer preemptoff_tracer __read_mostly =
 	.allow_instances = true,
 	.use_max_tr	= true,
 };
-# define register_preemptoff(trace) register_tracer(&trace)
-#else
-# define register_preemptoff(trace) do { } while (0)
-#endif
+#endif /* CONFIG_PREEMPT_TRACER */
 
-#if defined(CONFIG_IRQSOFF_TRACER) && \
-	defined(CONFIG_PREEMPT_TRACER)
+#if defined(CONFIG_IRQSOFF_TRACER) && defined(CONFIG_PREEMPT_TRACER)
 
 static int preemptirqsoff_tracer_init(struct trace_array *tr)
 {
@@ -731,11 +714,16 @@ static int preemptirqsoff_tracer_init(struct trace_array *tr)
 	return __irqsoff_tracer_init(tr);
 }
 
+static void preemptirqsoff_tracer_reset(struct trace_array *tr)
+{
+	__irqsoff_tracer_reset(tr);
+}
+
 static struct tracer preemptirqsoff_tracer __read_mostly =
 {
 	.name		= "preemptirqsoff",
 	.init		= preemptirqsoff_tracer_init,
-	.reset		= irqsoff_tracer_reset,
+	.reset		= preemptirqsoff_tracer_reset,
 	.start		= irqsoff_tracer_start,
 	.stop		= irqsoff_tracer_stop,
 	.print_max	= true,
@@ -750,115 +738,21 @@ static struct tracer preemptirqsoff_tracer __read_mostly =
 	.allow_instances = true,
 	.use_max_tr	= true,
 };
-
-# define register_preemptirqsoff(trace) register_tracer(&trace)
-#else
-# define register_preemptirqsoff(trace) do { } while (0)
 #endif
 
 __init static int init_irqsoff_tracer(void)
 {
-	register_irqsoff(irqsoff_tracer);
-	register_preemptoff(preemptoff_tracer);
-	register_preemptirqsoff(preemptirqsoff_tracer);
-
-	return 0;
-}
-core_initcall(init_irqsoff_tracer);
-#endif /* IRQSOFF_TRACER || PREEMPTOFF_TRACER */
-
-#ifndef CONFIG_IRQSOFF_TRACER
-static inline void tracer_hardirqs_on(void) { }
-static inline void tracer_hardirqs_off(void) { }
-static inline void tracer_hardirqs_on_caller(unsigned long caller_addr) { }
-static inline void tracer_hardirqs_off_caller(unsigned long caller_addr) { }
+#ifdef CONFIG_IRQSOFF_TRACER
+	register_tracer(&irqsoff_tracer);
 #endif
-
-#ifndef CONFIG_PREEMPT_TRACER
-static inline void tracer_preempt_on(unsigned long a0, unsigned long a1) { }
-static inline void tracer_preempt_off(unsigned long a0, unsigned long a1) { }
+#ifdef CONFIG_PREEMPT_TRACER
+	register_tracer(&preemptoff_tracer);
 #endif
-
-#if defined(CONFIG_TRACE_IRQFLAGS) && !defined(CONFIG_PROVE_LOCKING)
-/* Per-cpu variable to prevent redundant calls when IRQs already off */
-static DEFINE_PER_CPU(int, tracing_irq_cpu);
-
-void trace_hardirqs_on(void)
-{
-	if (!this_cpu_read(tracing_irq_cpu))
-		return;
-
-	trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
-	tracer_hardirqs_on();
-
-	this_cpu_write(tracing_irq_cpu, 0);
-}
-EXPORT_SYMBOL(trace_hardirqs_on);
-
-void trace_hardirqs_off(void)
-{
-	if (this_cpu_read(tracing_irq_cpu))
-		return;
-
-	this_cpu_write(tracing_irq_cpu, 1);
-
-	trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
-	tracer_hardirqs_off();
-}
-EXPORT_SYMBOL(trace_hardirqs_off);
-
-__visible void trace_hardirqs_on_caller(unsigned long caller_addr)
-{
-	if (!this_cpu_read(tracing_irq_cpu))
-		return;
-
-	trace_irq_enable_rcuidle(CALLER_ADDR0, caller_addr);
-	tracer_hardirqs_on_caller(caller_addr);
-
-	this_cpu_write(tracing_irq_cpu, 0);
-}
-EXPORT_SYMBOL(trace_hardirqs_on_caller);
-
-__visible void trace_hardirqs_off_caller(unsigned long caller_addr)
-{
-	if (this_cpu_read(tracing_irq_cpu))
-		return;
-
-	this_cpu_write(tracing_irq_cpu, 1);
-
-	trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
-	tracer_hardirqs_off_caller(caller_addr);
-}
-EXPORT_SYMBOL(trace_hardirqs_off_caller);
-
-/*
- * Stubs:
- */
-
-void trace_softirqs_on(unsigned long ip)
-{
-}
-
-void trace_softirqs_off(unsigned long ip)
-{
-}
-
-inline void print_irqtrace_events(struct task_struct *curr)
-{
-}
+#if defined(CONFIG_IRQSOFF_TRACER) && defined(CONFIG_PREEMPT_TRACER)
+	register_tracer(&preemptirqsoff_tracer);
 #endif
 
-#if defined(CONFIG_PREEMPT_TRACER) || \
-	(defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_PREEMPTIRQ_EVENTS))
-void trace_preempt_on(unsigned long a0, unsigned long a1)
-{
-	trace_preempt_enable_rcuidle(a0, a1);
-	tracer_preempt_on(a0, a1);
-}
-
-void trace_preempt_off(unsigned long a0, unsigned long a1)
-{
-	trace_preempt_disable_rcuidle(a0, a1);
-	tracer_preempt_off(a0, a1);
+	return 0;
 }
-#endif
+core_initcall(init_irqsoff_tracer);
+#endif /* IRQSOFF_TRACER || PREEMPTOFF_TRACER */
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 6b71860f3998..65a4157af851 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1,20 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Kprobes-based tracing events
  *
  * Created by Masami Hiramatsu <mhiramat@redhat.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #define pr_fmt(fmt)	"trace_kprobe: " fmt
 
@@ -23,6 +12,7 @@
 #include <linux/rculist.h>
 #include <linux/error-injection.h>
 
+#include "trace_kprobe_selftest.h"
 #include "trace_probe.h"
 
 #define KPROBE_EVENT_SYSTEM "kprobes"
@@ -87,6 +77,23 @@ static nokprobe_inline unsigned long trace_kprobe_nhit(struct trace_kprobe *tk)
 	return nhit;
 }
 
+/* Return 0 if it fails to find the symbol address */
+static nokprobe_inline
+unsigned long trace_kprobe_address(struct trace_kprobe *tk)
+{
+	unsigned long addr;
+
+	if (tk->symbol) {
+		addr = (unsigned long)
+			kallsyms_lookup_name(trace_kprobe_symbol(tk));
+		if (addr)
+			addr += tk->rp.kp.offset;
+	} else {
+		addr = (unsigned long)tk->rp.kp.addr;
+	}
+	return addr;
+}
+
 bool trace_kprobe_on_func_entry(struct trace_event_call *call)
 {
 	struct trace_kprobe *tk = (struct trace_kprobe *)call->data;
@@ -99,16 +106,8 @@ bool trace_kprobe_on_func_entry(struct trace_event_call *call)
 bool trace_kprobe_error_injectable(struct trace_event_call *call)
 {
 	struct trace_kprobe *tk = (struct trace_kprobe *)call->data;
-	unsigned long addr;
 
-	if (tk->symbol) {
-		addr = (unsigned long)
-			kallsyms_lookup_name(trace_kprobe_symbol(tk));
-		addr += tk->rp.kp.offset;
-	} else {
-		addr = (unsigned long)tk->rp.kp.addr;
-	}
-	return within_error_injection_list(addr);
+	return within_error_injection_list(trace_kprobe_address(tk));
 }
 
 static int register_kprobe_event(struct trace_kprobe *tk);
@@ -393,6 +392,20 @@ static struct trace_kprobe *find_trace_kprobe(const char *event,
 	return NULL;
 }
 
+static inline int __enable_trace_kprobe(struct trace_kprobe *tk)
+{
+	int ret = 0;
+
+	if (trace_probe_is_registered(&tk->tp) && !trace_kprobe_has_gone(tk)) {
+		if (trace_kprobe_is_return(tk))
+			ret = enable_kretprobe(&tk->rp);
+		else
+			ret = enable_kprobe(&tk->rp.kp);
+	}
+
+	return ret;
+}
+
 /*
  * Enable trace_probe
  * if the file is NULL, enable "perf" handler, or enable "trace" handler.
@@ -400,7 +413,7 @@ static struct trace_kprobe *find_trace_kprobe(const char *event,
 static int
 enable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
 {
-	struct event_file_link *link = NULL;
+	struct event_file_link *link;
 	int ret = 0;
 
 	if (file) {
@@ -414,26 +427,18 @@ enable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
 		list_add_tail_rcu(&link->list, &tk->tp.files);
 
 		tk->tp.flags |= TP_FLAG_TRACE;
-	} else
-		tk->tp.flags |= TP_FLAG_PROFILE;
-
-	if (trace_probe_is_registered(&tk->tp) && !trace_kprobe_has_gone(tk)) {
-		if (trace_kprobe_is_return(tk))
-			ret = enable_kretprobe(&tk->rp);
-		else
-			ret = enable_kprobe(&tk->rp.kp);
-	}
-
-	if (ret) {
-		if (file) {
-			/* Notice the if is true on not WARN() */
-			if (!WARN_ON_ONCE(!link))
-				list_del_rcu(&link->list);
+		ret = __enable_trace_kprobe(tk);
+		if (ret) {
+			list_del_rcu(&link->list);
 			kfree(link);
 			tk->tp.flags &= ~TP_FLAG_TRACE;
-		} else {
-			tk->tp.flags &= ~TP_FLAG_PROFILE;
 		}
+
+	} else {
+		tk->tp.flags |= TP_FLAG_PROFILE;
+		ret = __enable_trace_kprobe(tk);
+		if (ret)
+			tk->tp.flags &= ~TP_FLAG_PROFILE;
 	}
  out:
 	return ret;
@@ -498,6 +503,22 @@ disable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
 	return ret;
 }
 
+#if defined(CONFIG_KPROBES_ON_FTRACE) && \
+	!defined(CONFIG_KPROBE_EVENTS_ON_NOTRACE)
+static bool within_notrace_func(struct trace_kprobe *tk)
+{
+	unsigned long offset, size, addr;
+
+	addr = trace_kprobe_address(tk);
+	if (!addr || !kallsyms_lookup_size_offset(addr, &size, &offset))
+		return false;
+
+	return !ftrace_location_range(addr - offset, addr - offset + size);
+}
+#else
+#define within_notrace_func(tk)	(false)
+#endif
+
 /* Internal register function - just handle k*probes and flags */
 static int __register_trace_kprobe(struct trace_kprobe *tk)
 {
@@ -506,6 +527,12 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 	if (trace_probe_is_registered(&tk->tp))
 		return -EINVAL;
 
+	if (within_notrace_func(tk)) {
+		pr_warn("Could not probe notrace function %s\n",
+			trace_kprobe_symbol(tk));
+		return -EINVAL;
+	}
+
 	for (i = 0; i < tk->tp.nr_args; i++)
 		traceprobe_update_arg(&tk->tp.args[i]);
 
@@ -1552,17 +1579,6 @@ fs_initcall(init_kprobe_trace);
 
 
 #ifdef CONFIG_FTRACE_STARTUP_TEST
-/*
- * The "__used" keeps gcc from removing the function symbol
- * from the kallsyms table. 'noinline' makes sure that there
- * isn't an inlined version used by the test method below
- */
-static __used __init noinline int
-kprobe_trace_selftest_target(int a1, int a2, int a3, int a4, int a5, int a6)
-{
-	return a1 + a2 + a3 + a4 + a5 + a6;
-}
-
 static __init struct trace_event_file *
 find_trace_probe_file(struct trace_kprobe *tk, struct trace_array *tr)
 {
diff --git a/kernel/trace/trace_kprobe_selftest.c b/kernel/trace/trace_kprobe_selftest.c
new file mode 100644
index 000000000000..16548ee4c8c6
--- /dev/null
+++ b/kernel/trace/trace_kprobe_selftest.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Function used during the kprobe self test. This function is in a separate
+ * compile unit so it can be compile with CC_FLAGS_FTRACE to ensure that it
+ * can be probed by the selftests.
+ */
+int kprobe_trace_selftest_target(int a1, int a2, int a3, int a4, int a5, int a6)
+{
+	return a1 + a2 + a3 + a4 + a5 + a6;
+}
diff --git a/kernel/trace/trace_kprobe_selftest.h b/kernel/trace/trace_kprobe_selftest.h
new file mode 100644
index 000000000000..c4fc7268ba7c
--- /dev/null
+++ b/kernel/trace/trace_kprobe_selftest.h
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Function used during the kprobe self test. This function is in a separate
+ * compile unit so it can be compile with CC_FLAGS_FTRACE to ensure that it
+ * can be probed by the selftests.
+ */
+int kprobe_trace_selftest_target(int a1, int a2, int a3, int a4, int a5, int a6);
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 1c8e30fda46a..6e6cc64faa38 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * trace_output.c
  *
diff --git a/kernel/trace/trace_output.h b/kernel/trace/trace_output.h
index dbba03ed96de..2f742b74e7e6 100644
--- a/kernel/trace/trace_output.h
+++ b/kernel/trace/trace_output.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
 #ifndef __TRACE_EVENTS_H
 #define __TRACE_EVENTS_H
 
diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
new file mode 100644
index 000000000000..71f553cceb3c
--- /dev/null
+++ b/kernel/trace/trace_preemptirq.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * preemptoff and irqoff tracepoints
+ *
+ * Copyright (C) Joel Fernandes (Google) <joel@joelfernandes.org>
+ */
+
+#include <linux/kallsyms.h>
+#include <linux/uaccess.h>
+#include <linux/module.h>
+#include <linux/ftrace.h>
+#include "trace.h"
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/preemptirq.h>
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+/* Per-cpu variable to prevent redundant calls when IRQs already off */
+static DEFINE_PER_CPU(int, tracing_irq_cpu);
+
+void trace_hardirqs_on(void)
+{
+	if (this_cpu_read(tracing_irq_cpu)) {
+		if (!in_nmi())
+			trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
+		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
+		this_cpu_write(tracing_irq_cpu, 0);
+	}
+
+	lockdep_hardirqs_on(CALLER_ADDR0);
+}
+EXPORT_SYMBOL(trace_hardirqs_on);
+
+void trace_hardirqs_off(void)
+{
+	if (!this_cpu_read(tracing_irq_cpu)) {
+		this_cpu_write(tracing_irq_cpu, 1);
+		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
+		if (!in_nmi())
+			trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
+	}
+
+	lockdep_hardirqs_off(CALLER_ADDR0);
+}
+EXPORT_SYMBOL(trace_hardirqs_off);
+
+__visible void trace_hardirqs_on_caller(unsigned long caller_addr)
+{
+	if (this_cpu_read(tracing_irq_cpu)) {
+		if (!in_nmi())
+			trace_irq_enable_rcuidle(CALLER_ADDR0, caller_addr);
+		tracer_hardirqs_on(CALLER_ADDR0, caller_addr);
+		this_cpu_write(tracing_irq_cpu, 0);
+	}
+
+	lockdep_hardirqs_on(CALLER_ADDR0);
+}
+EXPORT_SYMBOL(trace_hardirqs_on_caller);
+
+__visible void trace_hardirqs_off_caller(unsigned long caller_addr)
+{
+	if (!this_cpu_read(tracing_irq_cpu)) {
+		this_cpu_write(tracing_irq_cpu, 1);
+		tracer_hardirqs_off(CALLER_ADDR0, caller_addr);
+		if (!in_nmi())
+			trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
+	}
+
+	lockdep_hardirqs_off(CALLER_ADDR0);
+}
+EXPORT_SYMBOL(trace_hardirqs_off_caller);
+#endif /* CONFIG_TRACE_IRQFLAGS */
+
+#ifdef CONFIG_TRACE_PREEMPT_TOGGLE
+
+void trace_preempt_on(unsigned long a0, unsigned long a1)
+{
+	if (!in_nmi())
+		trace_preempt_enable_rcuidle(a0, a1);
+	tracer_preempt_on(a0, a1);
+}
+
+void trace_preempt_off(unsigned long a0, unsigned long a1)
+{
+	if (!in_nmi())
+		trace_preempt_disable_rcuidle(a0, a1);
+	tracer_preempt_off(a0, a1);
+}
+#endif
diff --git a/kernel/trace/trace_printk.c b/kernel/trace/trace_printk.c
index 50f44b7b2b32..b0875b327f5c 100644
--- a/kernel/trace/trace_printk.c
+++ b/kernel/trace/trace_printk.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * trace binary printk
  *
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index daf54bda4dc8..e99c3ce7aa65 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Common code for probe-based Dynamic events.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
  * This code was copied from kernel/trace/trace_kprobe.c written by
  * Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
  *
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 75daff22ccea..5f52668e165d 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Common header file for probe-based Dynamic events.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
  * This code was copied from kernel/trace/trace_kprobe.h written by
  * Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
  *
diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
index e694c9f9efa4..6b1c562ffdaf 100644
--- a/kernel/trace/trace_seq.c
+++ b/kernel/trace/trace_seq.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * trace_seq.c
  *
diff --git a/kernel/trace/trace_stat.h b/kernel/trace/trace_stat.h
index 76d30b4ebe83..8786d17caf49 100644
--- a/kernel/trace/trace_stat.h
+++ b/kernel/trace/trace_stat.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
 #ifndef __TRACE_STAT_H
 #define __TRACE_STAT_H
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index bf89a51e740d..e696667da29a 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * uprobes-based tracing events
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
  * Copyright (C) IBM Corporation, 2010-2012
  * Author:	Srikar Dronamraju <srikar@linux.vnet.ibm.com>
  */
@@ -952,7 +940,7 @@ probe_event_disable(struct trace_uprobe *tu, struct trace_event_file *file)
 
 		list_del_rcu(&link->list);
 		/* synchronize with u{,ret}probe_trace_func */
-		synchronize_sched();
+		synchronize_rcu();
 		kfree(link);
 
 		if (!list_empty(&tu->tp.files))
diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 752d8042bad4..9a1c22310323 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -1,16 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * tracing_map - lock-free map for tracing
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  * Copyright (C) 2015 Tom Zanussi <tom.zanussi@linux.intel.com>
  *
  * tracing_map implementation inspired by lock-free map algorithms
diff --git a/kernel/trace/tracing_map.h b/kernel/trace/tracing_map.h
index 053eb92b2d31..a6de61fc22de 100644
--- a/kernel/trace/tracing_map.h
+++ b/kernel/trace/tracing_map.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
 #ifndef __TRACING_MAP_H
 #define __TRACING_MAP_H
 
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 6dc6356c3327..96db841bf0fc 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -31,6 +31,9 @@
 extern struct tracepoint * const __start___tracepoints_ptrs[];
 extern struct tracepoint * const __stop___tracepoints_ptrs[];
 
+DEFINE_SRCU(tracepoint_srcu);
+EXPORT_SYMBOL_GPL(tracepoint_srcu);
+
 /* Set to 1 to enable tracepoint debug output */
 static const int tracepoint_debug;
 
@@ -50,6 +53,9 @@ static LIST_HEAD(tracepoint_module_list);
  */
 static DEFINE_MUTEX(tracepoints_mutex);
 
+static struct rcu_head *early_probes;
+static bool ok_to_free_tracepoints;
+
 /*
  * Note about RCU :
  * It is used to delay the free of multiple probes array until a quiescent
@@ -67,16 +73,56 @@ static inline void *allocate_probes(int count)
 	return p == NULL ? NULL : p->probes;
 }
 
-static void rcu_free_old_probes(struct rcu_head *head)
+static void srcu_free_old_probes(struct rcu_head *head)
 {
 	kfree(container_of(head, struct tp_probes, rcu));
 }
 
+static void rcu_free_old_probes(struct rcu_head *head)
+{
+	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
+}
+
+static __init int release_early_probes(void)
+{
+	struct rcu_head *tmp;
+
+	ok_to_free_tracepoints = true;
+
+	while (early_probes) {
+		tmp = early_probes;
+		early_probes = tmp->next;
+		call_rcu_sched(tmp, rcu_free_old_probes);
+	}
+
+	return 0;
+}
+
+/* SRCU is initialized at core_initcall */
+postcore_initcall(release_early_probes);
+
 static inline void release_probes(struct tracepoint_func *old)
 {
 	if (old) {
 		struct tp_probes *tp_probes = container_of(old,
 			struct tp_probes, probes[0]);
+
+		/*
+		 * We can't free probes if SRCU is not initialized yet.
+		 * Postpone the freeing till after SRCU is initialized.
+		 */
+		if (unlikely(!ok_to_free_tracepoints)) {
+			tp_probes->rcu.next = early_probes;
+			early_probes = &tp_probes->rcu;
+			return;
+		}
+
+		/*
+		 * Tracepoint probes are protected by both sched RCU and SRCU,
+		 * by calling the SRCU callback in the sched RCU callback we
+		 * cover both cases. So let us chain the SRCU and sched RCU
+		 * callbacks to wait for both grace periods.
+		 */
 		call_rcu_sched(&tp_probes->rcu, rcu_free_old_probes);
 	}
 }
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 514ed63ff571..42ecb8cf7666 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -206,11 +206,8 @@ cmd_modversions_c =								\
 endif
 
 ifdef CONFIG_FTRACE_MCOUNT_RECORD
-# gcc 5 supports generating the mcount tables directly
-ifneq ($(call cc-option,-mrecord-mcount,y),y)
-KBUILD_CFLAGS += -mrecord-mcount
-else
-# else do it all manually
+ifndef CC_USING_RECORD_MCOUNT
+# compiler will not generate __mcount_loc use recordmcount or recordmcount.pl
 ifdef BUILD_C_RECORDMCOUNT
 ifeq ("$(origin RECORDMCOUNT_WARN)", "command line")
   RECORDMCOUNT_FLAGS = -w
@@ -239,7 +236,7 @@ cmd_record_mcount =						\
 	     "$(CC_FLAGS_FTRACE)" ]; then			\
 		$(sub_cmd_record_mcount)			\
 	fi;
-endif # -record-mcount
+endif # CC_USING_RECORD_MCOUNT
 endif # CONFIG_FTRACE_MCOUNT_RECORD
 
 ifdef CONFIG_STACK_VALIDATION
diff --git a/tools/testing/selftests/ftrace/config b/tools/testing/selftests/ftrace/config
index b01924c71c09..07db5ab09cc7 100644
--- a/tools/testing/selftests/ftrace/config
+++ b/tools/testing/selftests/ftrace/config
@@ -4,3 +4,6 @@ CONFIG_FUNCTION_PROFILER=y
 CONFIG_TRACER_SNAPSHOT=y
 CONFIG_STACK_TRACER=y
 CONFIG_HIST_TRIGGERS=y
+CONFIG_PREEMPT_TRACER=y
+CONFIG_IRQSOFF_TRACER=y
+CONFIG_PREEMPTIRQ_DELAY_TEST=m
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
index a0002563e9ee..1ad70cdaf442 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
@@ -9,28 +9,22 @@ echo > kprobe_events
 
 case `uname -m` in
 x86_64)
-  ARG2=%si
-  OFFS=8
+  ARG1=%di
 ;;
 i[3456]86)
-  ARG2=%cx
-  OFFS=4
+  ARG1=%ax
 ;;
 aarch64)
-  ARG2=%x1
-  OFFS=8
+  ARG1=%x0
 ;;
 arm*)
-  ARG2=%r1
-  OFFS=4
+  ARG1=%r0
 ;;
 ppc64*)
-  ARG2=%r4
-  OFFS=8
+  ARG1=%r3
 ;;
 ppc*)
-  ARG2=%r4
-  OFFS=4
+  ARG1=%r3
 ;;
 *)
   echo "Please implement other architecture here"
@@ -38,17 +32,17 @@ ppc*)
 esac
 
 : "Test get argument (1)"
-echo "p:testprobe create_trace_kprobe arg1=+0(+0(${ARG2})):string" > kprobe_events
+echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):string" > kprobe_events
 echo 1 > events/kprobes/testprobe/enable
-! echo test >> kprobe_events
-tail -n 1 trace | grep -qe "testprobe.* arg1=\"test\""
+echo "p:test _do_fork" >> kprobe_events
+grep -qe "testprobe.* arg1=\"test\"" trace
 
 echo 0 > events/kprobes/testprobe/enable
 : "Test get argument (2)"
-echo "p:testprobe create_trace_kprobe arg1=+0(+0(${ARG2})):string arg2=+0(+${OFFS}(${ARG2})):string" > kprobe_events
+echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):string arg2=+0(${ARG1}):string" > kprobe_events
 echo 1 > events/kprobes/testprobe/enable
-! echo test1 test2 >> kprobe_events
-tail -n 1 trace | grep -qe "testprobe.* arg1=\"test1\" arg2=\"test2\""
+echo "p:test _do_fork" >> kprobe_events
+grep -qe "testprobe.* arg1=\"test\" arg2=\"test\"" trace
 
 echo 0 > events/enable
 echo > kprobe_events
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc b/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
index 4fda01a08da4..519d2763f5d2 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
@@ -4,7 +4,7 @@
 
 [ -f kprobe_events ] || exit_unsupported # this is configurable
 
-TARGET_FUNC=create_trace_kprobe
+TARGET_FUNC=tracefs_create_dir
 
 dec_addr() { # hexaddr
   printf "%d" "0x"`echo $1 | tail -c 8`
diff --git a/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
new file mode 100644
index 000000000000..cbd174334a48
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
@@ -0,0 +1,73 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: test for the preemptirqsoff tracer
+
+MOD=preemptirq_delay_test
+
+fail() {
+    reset_tracer
+    rmmod $MOD || true
+    exit_fail
+}
+
+unsup() { #msg
+    reset_tracer
+    rmmod $MOD || true
+    echo $1
+    exit_unsupported
+}
+
+modprobe $MOD || unsup "$MOD module not available"
+rmmod $MOD
+
+grep -q "preemptoff" available_tracers || unsup "preemptoff tracer not enabled"
+grep -q "irqsoff" available_tracers || unsup "irqsoff tracer not enabled"
+
+reset_tracer
+
+# Simulate preemptoff section for half a second couple of times
+echo preemptoff > current_tracer
+sleep 1
+modprobe $MOD test_mode=preempt delay=500000 || fail
+rmmod $MOD || fail
+modprobe $MOD test_mode=preempt delay=500000 || fail
+rmmod $MOD || fail
+modprobe $MOD test_mode=preempt delay=500000 || fail
+rmmod $MOD || fail
+
+cat trace
+
+# Confirm which tracer
+grep -q "tracer: preemptoff" trace || fail
+
+# Check the end of the section
+egrep -q "5.....us : <stack trace>" trace || fail
+
+# Check for 500ms of latency
+egrep -q "latency: 5..... us" trace || fail
+
+reset_tracer
+
+# Simulate irqsoff section for half a second couple of times
+echo irqsoff > current_tracer
+sleep 1
+modprobe $MOD test_mode=irq delay=500000 || fail
+rmmod $MOD || fail
+modprobe $MOD test_mode=irq delay=500000 || fail
+rmmod $MOD || fail
+modprobe $MOD test_mode=irq delay=500000 || fail
+rmmod $MOD || fail
+
+cat trace
+
+# Confirm which tracer
+grep -q "tracer: irqsoff" trace || fail
+
+# Check the end of the section
+egrep -q "5.....us : <stack trace>" trace || fail
+
+# Check for 500ms of latency
+egrep -q "latency: 5..... us" trace || fail
+
+reset_tracer
+exit 0
