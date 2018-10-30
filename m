Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F3CC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A7520823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A7520823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbeJ3WbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:31:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727870AbeJ3WbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:31:15 -0400
Received: from vmware.local.home (unknown [146.247.46.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A78D2205F4;
        Tue, 30 Oct 2018 13:37:38 +0000 (UTC)
Date:   Tue, 30 Oct 2018 09:37:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [GIT PULL] tracing: Updates for 4.20 (or 5.0)
Message-ID: <20181030093734.6b4118bd@vmware.local.home>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

The biggest change here is the updates to kprobes

Back in January I posted patches to create function based events. These were
the events that you suggested I make to allow developers to easily create
events in code where no trace event exists. After posting those changes for
review, it was suggested that we implement this instead with kprobes.

The problem with kprobes is that the interface is too complex and needs to
be simplified. Masami Hiramatsu posted patches in March and I've been
playing with them a bit. There's been a bit of clean up in the kprobe code
that was inspired by the function based event patches, and a couple of
enhancements to the kprobe event interface.

 - If the arch supports it (we added support for x86), you can place a
   kprobe event at the start of a function and use $arg1, $arg2, etc
   to reference the arguments of a function. (Before you needed to know
   what register or where on the stack the argument was).

 - The second is a way to see array of events. For example, if you reference
   a mac address, you can add:

   echo 'p:mac ip_rcv perm_addr=+574($arg2):x8[6]' > kprobe_events

   And this will produce:

   mac: (ip_rcv+0x0/0x140) perm_addr={0x52,0x54,0x0,0xc0,0x76,0xec}

Other changes include

 - Exporting trace_dump_stack to modules

 - Have the stack tracer trace the entire stack (stop trying to remove
   tracing itself, as we keep removing too much).

 - Added support for SDT in uprobes


Please pull the latest trace-v4.20 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.20

Tag SHA1: ef335507c87fe732bf6f1018fda7a77484559b51
Head SHA1: a2acce536921bd793bae13fa344fcea157638e72


Masami Hiramatsu (15):
      tracing: probeevent: Cleanup print argument functions
      tracing: probeevent: Cleanup argument field definition
      tracing: probeevent: Remove NOKPROBE_SYMBOL from print functions
      tracing: probeevent: Introduce new argument fetching code
      tracing: probeevent: Unify fetch type tables
      tracing: probeevent: Return consumed bytes of dynamic area
      tracing: probeevent: Append traceprobe_ for exported function
      tracing: probeevent: Unify fetch_insn processing common part
      tracing: probeevent: Add symbol type
      tracing: probeevent: Add array type support
      x86: ptrace: Add function argument access API
      tracing: probeevent: Add $argN for accessing function args
      tracing/uprobes: Fix to return -EFAULT if copy_from_user failed
      tracing/kprobes: Check the probe on unloaded module correctly
      tracing/kprobes: Allow kprobe-events to record module symbol

Nikolay Borisov (1):
      tracing: Export trace_dump_stack to modules

Ravi Bangoria (4):
      uprobes: Support SDT markers having reference count (semaphore)
      uprobes/sdt: Prevent multiple reference counter for same uprobe
      trace_uprobe/sdt: Prevent multiple reference counter for same uprobe
      perf probe: Support SDT markers having reference counter (semaphore)

Song Liu (1):
      trace_uprobe: support reference counter in fd-based uprobe

Steven Rostedt (VMware) (3):
      tracing/kprobe: Remove unneeded extra strchr() from create_trace_kprobe()
      tracing: probeevent: Fix uninitialized used of offset in parse args
      tracing: Have stack tracer trace full stack

----
 Documentation/trace/kprobetrace.rst |  23 +-
 arch/Kconfig                        |   7 +
 arch/x86/Kconfig                    |   1 +
 arch/x86/include/asm/ptrace.h       |  38 ++
 include/linux/trace_events.h        |   3 +-
 include/linux/uprobes.h             |   5 +
 kernel/events/core.c                |  49 ++-
 kernel/events/uprobes.c             | 278 ++++++++++++++-
 kernel/trace/trace.c                |  12 +-
 kernel/trace/trace_event_perf.c     |   7 +-
 kernel/trace/trace_kprobe.c         | 412 +++++++++-------------
 kernel/trace/trace_probe.c          | 672 ++++++++++++++++++------------------
 kernel/trace/trace_probe.h          | 289 +++++-----------
 kernel/trace/trace_probe_tmpl.h     | 216 ++++++++++++
 kernel/trace/trace_stack.c          |   2 +-
 kernel/trace/trace_uprobe.c         | 255 ++++++++------
 tools/perf/util/probe-event.c       |  39 ++-
 tools/perf/util/probe-event.h       |   1 +
 tools/perf/util/probe-file.c        |  34 +-
 tools/perf/util/probe-file.h        |   1 +
 tools/perf/util/symbol-elf.c        |  46 ++-
 tools/perf/util/symbol.h            |   7 +
 22 files changed, 1439 insertions(+), 958 deletions(-)
 create mode 100644 kernel/trace/trace_probe_tmpl.h
---------------------------
diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 8bfc75c90806..47e765c2f2c3 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -45,16 +45,18 @@ Synopsis of kprobe_events
   @SYM[+|-offs]	: Fetch memory at SYM +|- offs (SYM should be a data symbol)
   $stackN	: Fetch Nth entry of stack (N >= 0)
   $stack	: Fetch stack address.
-  $retval	: Fetch return value.(*)
+  $argN		: Fetch the Nth function argument. (N >= 1) (\*1)
+  $retval	: Fetch return value.(\*2)
   $comm		: Fetch current task comm.
-  +|-offs(FETCHARG) : Fetch memory at FETCHARG +|- offs address.(**)
+  +|-offs(FETCHARG) : Fetch memory at FETCHARG +|- offs address.(\*3)
   NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
   FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
 		  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
 		  (x8/x16/x32/x64), "string" and bitfield are supported.
 
-  (*) only for return probe.
-  (**) this is useful for fetching a field of data structures.
+  (\*1) only for the probe on function entry (offs == 0).
+  (\*2) only for return probe.
+  (\*3) this is useful for fetching a field of data structures.
 
 Types
 -----
@@ -64,14 +66,27 @@ respectively. 'x' prefix implies it is unsigned. Traced arguments are shown
 in decimal ('s' and 'u') or hexadecimal ('x'). Without type casting, 'x32'
 or 'x64' is used depends on the architecture (e.g. x86-32 uses x32, and
 x86-64 uses x64).
+These value types can be an array. To record array data, you can add '[N]'
+(where N is a fixed number, less than 64) to the base type.
+E.g. 'x16[4]' means an array of x16 (2bytes hex) with 4 elements.
+Note that the array can be applied to memory type fetchargs, you can not
+apply it to registers/stack-entries etc. (for example, '$stack1:x8[8]' is
+wrong, but '+8($stack):x8[8]' is OK.)
 String type is a special type, which fetches a "null-terminated" string from
 kernel space. This means it will fail and store NULL if the string container
 has been paged out.
+The string array type is a bit different from other types. For other base
+types, <base-type>[1] is equal to <base-type> (e.g. +0(%di):x32[1] is same
+as +0(%di):x32.) But string[1] is not equal to string. The string type itself
+represents "char array", but string array type represents "char * array".
+So, for example, +0(%di):string[1] is equal to +0(+0(%di)):string.
 Bitfield is another special type, which takes 3 parameters, bit-width, bit-
 offset, and container-size (usually 32). The syntax is::
 
  b<bit-width>@<bit-offset>/<container-size>
 
+Symbol type('symbol') is an alias of u32 or u64 type (depends on BITS_PER_LONG)
+which shows given pointer in "symbol+offset" style.
 For $comm, the default type is "string"; any other type is invalid.
 
 
diff --git a/arch/Kconfig b/arch/Kconfig
index 6801123932a5..facace0c90fc 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -290,6 +290,13 @@ config HAVE_RSEQ
 	  This symbol should be selected by an architecture if it
 	  supports an implementation of restartable sequences.
 
+config HAVE_FUNCTION_ARG_ACCESS_API
+	bool
+	help
+	  This symbol should be selected by an architecure if it supports
+	  the API needed to access function arguments from pt_regs,
+	  declared in asm/ptrace.h
+
 config HAVE_CLK
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1a0be022f91d..972973851779 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -184,6 +184,7 @@ config X86
 	select HAVE_RCU_TABLE_INVALIDATE	if HAVE_RCU_TABLE_FREE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if X86_64 && (UNWINDER_FRAME_POINTER || UNWINDER_ORC) && STACK_VALIDATION
+	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
 	select HAVE_STACK_VALIDATION		if X86_64
 	select HAVE_RSEQ
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 6de1fd3d0097..c2304b25e2fd 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -256,6 +256,44 @@ static inline unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
 		return 0;
 }
 
+/**
+ * regs_get_kernel_argument() - get Nth function argument in kernel
+ * @regs:	pt_regs of that context
+ * @n:		function argument number (start from 0)
+ *
+ * regs_get_argument() returns @n th argument of the function call.
+ * Note that this chooses most probably assignment, in some case
+ * it can be incorrect.
+ * This is expected to be called from kprobes or ftrace with regs
+ * where the top of stack is the return address.
+ */
+static inline unsigned long regs_get_kernel_argument(struct pt_regs *regs,
+						     unsigned int n)
+{
+	static const unsigned int argument_offs[] = {
+#ifdef __i386__
+		offsetof(struct pt_regs, ax),
+		offsetof(struct pt_regs, cx),
+		offsetof(struct pt_regs, dx),
+#define NR_REG_ARGUMENTS 3
+#else
+		offsetof(struct pt_regs, di),
+		offsetof(struct pt_regs, si),
+		offsetof(struct pt_regs, dx),
+		offsetof(struct pt_regs, cx),
+		offsetof(struct pt_regs, r8),
+		offsetof(struct pt_regs, r9),
+#define NR_REG_ARGUMENTS 6
+#endif
+	};
+
+	if (n >= NR_REG_ARGUMENTS) {
+		n -= NR_REG_ARGUMENTS - 1;
+		return regs_get_kernel_stack_nth(regs, n);
+	} else
+		return regs_get_register(regs, argument_offs[n]);
+}
+
 #define arch_has_single_step()	(1)
 #ifdef CONFIG_X86_DEBUGCTLMSR
 #define arch_has_block_step()	(1)
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 78a010e19ed4..4130a5497d40 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -575,7 +575,8 @@ extern int bpf_get_kprobe_info(const struct perf_event *event,
 			       bool perf_type_tracepoint);
 #endif
 #ifdef CONFIG_UPROBE_EVENTS
-extern int  perf_uprobe_init(struct perf_event *event, bool is_retprobe);
+extern int  perf_uprobe_init(struct perf_event *event,
+			     unsigned long ref_ctr_offset, bool is_retprobe);
 extern void perf_uprobe_destroy(struct perf_event *event);
 extern int bpf_get_uprobe_info(const struct perf_event *event,
 			       u32 *fd_type, const char **filename,
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index bb9d2084af03..103a48a48872 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -123,6 +123,7 @@ extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
 extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
 extern int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
+extern int uprobe_register_refctr(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
 extern int uprobe_mmap(struct vm_area_struct *vma);
@@ -160,6 +161,10 @@ uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
 {
 	return -ENOSYS;
 }
+static inline int uprobe_register_refctr(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc)
+{
+	return -ENOSYS;
+}
 static inline int
 uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool add)
 {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c80549bf82c6..65b30773af3e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8368,30 +8368,39 @@ static struct pmu perf_tracepoint = {
  *
  * PERF_PROBE_CONFIG_IS_RETPROBE if set, create kretprobe/uretprobe
  *                               if not set, create kprobe/uprobe
+ *
+ * The following values specify a reference counter (or semaphore in the
+ * terminology of tools like dtrace, systemtap, etc.) Userspace Statically
+ * Defined Tracepoints (USDT). Currently, we use 40 bit for the offset.
+ *
+ * PERF_UPROBE_REF_CTR_OFFSET_BITS	# of bits in config as th offset
+ * PERF_UPROBE_REF_CTR_OFFSET_SHIFT	# of bits to shift left
  */
 enum perf_probe_config {
 	PERF_PROBE_CONFIG_IS_RETPROBE = 1U << 0,  /* [k,u]retprobe */
+	PERF_UPROBE_REF_CTR_OFFSET_BITS = 32,
+	PERF_UPROBE_REF_CTR_OFFSET_SHIFT = 64 - PERF_UPROBE_REF_CTR_OFFSET_BITS,
 };
 
 PMU_FORMAT_ATTR(retprobe, "config:0");
+#endif
 
-static struct attribute *probe_attrs[] = {
+#ifdef CONFIG_KPROBE_EVENTS
+static struct attribute *kprobe_attrs[] = {
 	&format_attr_retprobe.attr,
 	NULL,
 };
 
-static struct attribute_group probe_format_group = {
+static struct attribute_group kprobe_format_group = {
 	.name = "format",
-	.attrs = probe_attrs,
+	.attrs = kprobe_attrs,
 };
 
-static const struct attribute_group *probe_attr_groups[] = {
-	&probe_format_group,
+static const struct attribute_group *kprobe_attr_groups[] = {
+	&kprobe_format_group,
 	NULL,
 };
-#endif
 
-#ifdef CONFIG_KPROBE_EVENTS
 static int perf_kprobe_event_init(struct perf_event *event);
 static struct pmu perf_kprobe = {
 	.task_ctx_nr	= perf_sw_context,
@@ -8401,7 +8410,7 @@ static struct pmu perf_kprobe = {
 	.start		= perf_swevent_start,
 	.stop		= perf_swevent_stop,
 	.read		= perf_swevent_read,
-	.attr_groups	= probe_attr_groups,
+	.attr_groups	= kprobe_attr_groups,
 };
 
 static int perf_kprobe_event_init(struct perf_event *event)
@@ -8433,6 +8442,24 @@ static int perf_kprobe_event_init(struct perf_event *event)
 #endif /* CONFIG_KPROBE_EVENTS */
 
 #ifdef CONFIG_UPROBE_EVENTS
+PMU_FORMAT_ATTR(ref_ctr_offset, "config:32-63");
+
+static struct attribute *uprobe_attrs[] = {
+	&format_attr_retprobe.attr,
+	&format_attr_ref_ctr_offset.attr,
+	NULL,
+};
+
+static struct attribute_group uprobe_format_group = {
+	.name = "format",
+	.attrs = uprobe_attrs,
+};
+
+static const struct attribute_group *uprobe_attr_groups[] = {
+	&uprobe_format_group,
+	NULL,
+};
+
 static int perf_uprobe_event_init(struct perf_event *event);
 static struct pmu perf_uprobe = {
 	.task_ctx_nr	= perf_sw_context,
@@ -8442,12 +8469,13 @@ static struct pmu perf_uprobe = {
 	.start		= perf_swevent_start,
 	.stop		= perf_swevent_stop,
 	.read		= perf_swevent_read,
-	.attr_groups	= probe_attr_groups,
+	.attr_groups	= uprobe_attr_groups,
 };
 
 static int perf_uprobe_event_init(struct perf_event *event)
 {
 	int err;
+	unsigned long ref_ctr_offset;
 	bool is_retprobe;
 
 	if (event->attr.type != perf_uprobe.type)
@@ -8463,7 +8491,8 @@ static int perf_uprobe_event_init(struct perf_event *event)
 		return -EOPNOTSUPP;
 
 	is_retprobe = event->attr.config & PERF_PROBE_CONFIG_IS_RETPROBE;
-	err = perf_uprobe_init(event, is_retprobe);
+	ref_ctr_offset = event->attr.config >> PERF_UPROBE_REF_CTR_OFFSET_SHIFT;
+	err = perf_uprobe_init(event, ref_ctr_offset, is_retprobe);
 	if (err)
 		return err;
 
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 3207a4d26849..96fb51f3994f 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -73,6 +73,7 @@ struct uprobe {
 	struct uprobe_consumer	*consumers;
 	struct inode		*inode;		/* Also hold a ref to inode */
 	loff_t			offset;
+	loff_t			ref_ctr_offset;
 	unsigned long		flags;
 
 	/*
@@ -88,6 +89,15 @@ struct uprobe {
 	struct arch_uprobe	arch;
 };
 
+struct delayed_uprobe {
+	struct list_head list;
+	struct uprobe *uprobe;
+	struct mm_struct *mm;
+};
+
+static DEFINE_MUTEX(delayed_uprobe_lock);
+static LIST_HEAD(delayed_uprobe_list);
+
 /*
  * Execute out of line area: anonymous executable mapping installed
  * by the probed task to execute the copy of the original instruction
@@ -282,6 +292,166 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
 	return 1;
 }
 
+static struct delayed_uprobe *
+delayed_uprobe_check(struct uprobe *uprobe, struct mm_struct *mm)
+{
+	struct delayed_uprobe *du;
+
+	list_for_each_entry(du, &delayed_uprobe_list, list)
+		if (du->uprobe == uprobe && du->mm == mm)
+			return du;
+	return NULL;
+}
+
+static int delayed_uprobe_add(struct uprobe *uprobe, struct mm_struct *mm)
+{
+	struct delayed_uprobe *du;
+
+	if (delayed_uprobe_check(uprobe, mm))
+		return 0;
+
+	du  = kzalloc(sizeof(*du), GFP_KERNEL);
+	if (!du)
+		return -ENOMEM;
+
+	du->uprobe = uprobe;
+	du->mm = mm;
+	list_add(&du->list, &delayed_uprobe_list);
+	return 0;
+}
+
+static void delayed_uprobe_delete(struct delayed_uprobe *du)
+{
+	if (WARN_ON(!du))
+		return;
+	list_del(&du->list);
+	kfree(du);
+}
+
+static void delayed_uprobe_remove(struct uprobe *uprobe, struct mm_struct *mm)
+{
+	struct list_head *pos, *q;
+	struct delayed_uprobe *du;
+
+	if (!uprobe && !mm)
+		return;
+
+	list_for_each_safe(pos, q, &delayed_uprobe_list) {
+		du = list_entry(pos, struct delayed_uprobe, list);
+
+		if (uprobe && du->uprobe != uprobe)
+			continue;
+		if (mm && du->mm != mm)
+			continue;
+
+		delayed_uprobe_delete(du);
+	}
+}
+
+static bool valid_ref_ctr_vma(struct uprobe *uprobe,
+			      struct vm_area_struct *vma)
+{
+	unsigned long vaddr = offset_to_vaddr(vma, uprobe->ref_ctr_offset);
+
+	return uprobe->ref_ctr_offset &&
+		vma->vm_file &&
+		file_inode(vma->vm_file) == uprobe->inode &&
+		(vma->vm_flags & (VM_WRITE|VM_SHARED)) == VM_WRITE &&
+		vma->vm_start <= vaddr &&
+		vma->vm_end > vaddr;
+}
+
+static struct vm_area_struct *
+find_ref_ctr_vma(struct uprobe *uprobe, struct mm_struct *mm)
+{
+	struct vm_area_struct *tmp;
+
+	for (tmp = mm->mmap; tmp; tmp = tmp->vm_next)
+		if (valid_ref_ctr_vma(uprobe, tmp))
+			return tmp;
+
+	return NULL;
+}
+
+static int
+__update_ref_ctr(struct mm_struct *mm, unsigned long vaddr, short d)
+{
+	void *kaddr;
+	struct page *page;
+	struct vm_area_struct *vma;
+	int ret;
+	short *ptr;
+
+	if (!vaddr || !d)
+		return -EINVAL;
+
+	ret = get_user_pages_remote(NULL, mm, vaddr, 1,
+			FOLL_WRITE, &page, &vma, NULL);
+	if (unlikely(ret <= 0)) {
+		/*
+		 * We are asking for 1 page. If get_user_pages_remote() fails,
+		 * it may return 0, in that case we have to return error.
+		 */
+		return ret == 0 ? -EBUSY : ret;
+	}
+
+	kaddr = kmap_atomic(page);
+	ptr = kaddr + (vaddr & ~PAGE_MASK);
+
+	if (unlikely(*ptr + d < 0)) {
+		pr_warn("ref_ctr going negative. vaddr: 0x%lx, "
+			"curr val: %d, delta: %d\n", vaddr, *ptr, d);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	*ptr += d;
+	ret = 0;
+out:
+	kunmap_atomic(kaddr);
+	put_page(page);
+	return ret;
+}
+
+static void update_ref_ctr_warn(struct uprobe *uprobe,
+				struct mm_struct *mm, short d)
+{
+	pr_warn("ref_ctr %s failed for inode: 0x%lx offset: "
+		"0x%llx ref_ctr_offset: 0x%llx of mm: 0x%pK\n",
+		d > 0 ? "increment" : "decrement", uprobe->inode->i_ino,
+		(unsigned long long) uprobe->offset,
+		(unsigned long long) uprobe->ref_ctr_offset, mm);
+}
+
+static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
+			  short d)
+{
+	struct vm_area_struct *rc_vma;
+	unsigned long rc_vaddr;
+	int ret = 0;
+
+	rc_vma = find_ref_ctr_vma(uprobe, mm);
+
+	if (rc_vma) {
+		rc_vaddr = offset_to_vaddr(rc_vma, uprobe->ref_ctr_offset);
+		ret = __update_ref_ctr(mm, rc_vaddr, d);
+		if (ret)
+			update_ref_ctr_warn(uprobe, mm, d);
+
+		if (d > 0)
+			return ret;
+	}
+
+	mutex_lock(&delayed_uprobe_lock);
+	if (d > 0)
+		ret = delayed_uprobe_add(uprobe, mm);
+	else
+		delayed_uprobe_remove(uprobe, mm);
+	mutex_unlock(&delayed_uprobe_lock);
+
+	return ret;
+}
+
 /*
  * NOTE:
  * Expect the breakpoint instruction to be the smallest size instruction for
@@ -302,9 +472,13 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
 int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 			unsigned long vaddr, uprobe_opcode_t opcode)
 {
+	struct uprobe *uprobe;
 	struct page *old_page, *new_page;
 	struct vm_area_struct *vma;
-	int ret;
+	int ret, is_register, ref_ctr_updated = 0;
+
+	is_register = is_swbp_insn(&opcode);
+	uprobe = container_of(auprobe, struct uprobe, arch);
 
 retry:
 	/* Read the page with vaddr into memory */
@@ -317,6 +491,15 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (ret <= 0)
 		goto put_old;
 
+	/* We are going to replace instruction, update ref_ctr. */
+	if (!ref_ctr_updated && uprobe->ref_ctr_offset) {
+		ret = update_ref_ctr(uprobe, mm, is_register ? 1 : -1);
+		if (ret)
+			goto put_old;
+
+		ref_ctr_updated = 1;
+	}
+
 	ret = anon_vma_prepare(vma);
 	if (ret)
 		goto put_old;
@@ -337,6 +520,11 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 
 	if (unlikely(ret == -EAGAIN))
 		goto retry;
+
+	/* Revert back reference counter if instruction update failed. */
+	if (ret && is_register && ref_ctr_updated)
+		update_ref_ctr(uprobe, mm, -1);
+
 	return ret;
 }
 
@@ -378,8 +566,15 @@ static struct uprobe *get_uprobe(struct uprobe *uprobe)
 
 static void put_uprobe(struct uprobe *uprobe)
 {
-	if (atomic_dec_and_test(&uprobe->ref))
+	if (atomic_dec_and_test(&uprobe->ref)) {
+		/*
+		 * If application munmap(exec_vma) before uprobe_unregister()
+		 * gets called, we don't get a chance to remove uprobe from
+		 * delayed_uprobe_list from remove_breakpoint(). Do it here.
+		 */
+		delayed_uprobe_remove(uprobe, NULL);
 		kfree(uprobe);
+	}
 }
 
 static int match_uprobe(struct uprobe *l, struct uprobe *r)
@@ -484,7 +679,18 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
 	return u;
 }
 
-static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset)
+static void
+ref_ctr_mismatch_warn(struct uprobe *cur_uprobe, struct uprobe *uprobe)
+{
+	pr_warn("ref_ctr_offset mismatch. inode: 0x%lx offset: 0x%llx "
+		"ref_ctr_offset(old): 0x%llx ref_ctr_offset(new): 0x%llx\n",
+		uprobe->inode->i_ino, (unsigned long long) uprobe->offset,
+		(unsigned long long) cur_uprobe->ref_ctr_offset,
+		(unsigned long long) uprobe->ref_ctr_offset);
+}
+
+static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
+				   loff_t ref_ctr_offset)
 {
 	struct uprobe *uprobe, *cur_uprobe;
 
@@ -494,6 +700,7 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset)
 
 	uprobe->inode = inode;
 	uprobe->offset = offset;
+	uprobe->ref_ctr_offset = ref_ctr_offset;
 	init_rwsem(&uprobe->register_rwsem);
 	init_rwsem(&uprobe->consumer_rwsem);
 
@@ -501,6 +708,12 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset)
 	cur_uprobe = insert_uprobe(uprobe);
 	/* a uprobe exists for this inode:offset combination */
 	if (cur_uprobe) {
+		if (cur_uprobe->ref_ctr_offset != uprobe->ref_ctr_offset) {
+			ref_ctr_mismatch_warn(cur_uprobe, uprobe);
+			put_uprobe(cur_uprobe);
+			kfree(uprobe);
+			return ERR_PTR(-EINVAL);
+		}
 		kfree(uprobe);
 		uprobe = cur_uprobe;
 	}
@@ -895,7 +1108,7 @@ EXPORT_SYMBOL_GPL(uprobe_unregister);
  * else return 0 (success)
  */
 static int __uprobe_register(struct inode *inode, loff_t offset,
-			     struct uprobe_consumer *uc)
+			     loff_t ref_ctr_offset, struct uprobe_consumer *uc)
 {
 	struct uprobe *uprobe;
 	int ret;
@@ -912,9 +1125,12 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
 		return -EINVAL;
 
  retry:
-	uprobe = alloc_uprobe(inode, offset);
+	uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
 	if (!uprobe)
 		return -ENOMEM;
+	if (IS_ERR(uprobe))
+		return PTR_ERR(uprobe);
+
 	/*
 	 * We can race with uprobe_unregister()->delete_uprobe().
 	 * Check uprobe_is_active() and retry if it is false.
@@ -938,10 +1154,17 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
 int uprobe_register(struct inode *inode, loff_t offset,
 		    struct uprobe_consumer *uc)
 {
-	return __uprobe_register(inode, offset, uc);
+	return __uprobe_register(inode, offset, 0, uc);
 }
 EXPORT_SYMBOL_GPL(uprobe_register);
 
+int uprobe_register_refctr(struct inode *inode, loff_t offset,
+			   loff_t ref_ctr_offset, struct uprobe_consumer *uc)
+{
+	return __uprobe_register(inode, offset, ref_ctr_offset, uc);
+}
+EXPORT_SYMBOL_GPL(uprobe_register_refctr);
+
 /*
  * uprobe_apply - unregister an already registered probe.
  * @inode: the file in which the probe has to be removed.
@@ -1060,6 +1283,35 @@ static void build_probe_list(struct inode *inode,
 	spin_unlock(&uprobes_treelock);
 }
 
+/* @vma contains reference counter, not the probed instruction. */
+static int delayed_ref_ctr_inc(struct vm_area_struct *vma)
+{
+	struct list_head *pos, *q;
+	struct delayed_uprobe *du;
+	unsigned long vaddr;
+	int ret = 0, err = 0;
+
+	mutex_lock(&delayed_uprobe_lock);
+	list_for_each_safe(pos, q, &delayed_uprobe_list) {
+		du = list_entry(pos, struct delayed_uprobe, list);
+
+		if (du->mm != vma->vm_mm ||
+		    !valid_ref_ctr_vma(du->uprobe, vma))
+			continue;
+
+		vaddr = offset_to_vaddr(vma, du->uprobe->ref_ctr_offset);
+		ret = __update_ref_ctr(vma->vm_mm, vaddr, 1);
+		if (ret) {
+			update_ref_ctr_warn(du->uprobe, vma->vm_mm, 1);
+			if (!err)
+				err = ret;
+		}
+		delayed_uprobe_delete(du);
+	}
+	mutex_unlock(&delayed_uprobe_lock);
+	return err;
+}
+
 /*
  * Called from mmap_region/vma_adjust with mm->mmap_sem acquired.
  *
@@ -1072,7 +1324,15 @@ int uprobe_mmap(struct vm_area_struct *vma)
 	struct uprobe *uprobe, *u;
 	struct inode *inode;
 
-	if (no_uprobe_events() || !valid_vma(vma, true))
+	if (no_uprobe_events())
+		return 0;
+
+	if (vma->vm_file &&
+	    (vma->vm_flags & (VM_WRITE|VM_SHARED)) == VM_WRITE &&
+	    test_bit(MMF_HAS_UPROBES, &vma->vm_mm->flags))
+		delayed_ref_ctr_inc(vma);
+
+	if (!valid_vma(vma, true))
 		return 0;
 
 	inode = file_inode(vma->vm_file);
@@ -1246,6 +1506,10 @@ void uprobe_clear_state(struct mm_struct *mm)
 {
 	struct xol_area *area = mm->uprobes_state.xol_area;
 
+	mutex_lock(&delayed_uprobe_lock);
+	delayed_uprobe_remove(NULL, mm);
+	mutex_unlock(&delayed_uprobe_lock);
+
 	if (!area)
 		return;
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bf6f1d70484d..ff1c4b20cd0a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2727,6 +2727,7 @@ void trace_dump_stack(int skip)
 	__ftrace_trace_stack(global_trace.trace_buffer.buffer,
 			     flags, skip, preempt_count(), NULL);
 }
+EXPORT_SYMBOL_GPL(trace_dump_stack);
 
 static DEFINE_PER_CPU(int, user_stack_count);
 
@@ -4621,13 +4622,18 @@ static const char readme_msg[] =
   "place (kretprobe): [<module>:]<symbol>[+<offset>]|<memaddr>\n"
 #endif
 #ifdef CONFIG_UPROBE_EVENTS
-	"\t    place: <path>:<offset>\n"
+  "   place (uprobe): <path>:<offset>[(ref_ctr_offset)]\n"
 #endif
 	"\t     args: <name>=fetcharg[:type]\n"
 	"\t fetcharg: %<register>, @<address>, @<symbol>[+|-<offset>],\n"
+#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
+	"\t           $stack<index>, $stack, $retval, $comm, $arg<N>\n"
+#else
 	"\t           $stack<index>, $stack, $retval, $comm\n"
-	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string,\n"
-	"\t           b<bit-width>@<bit-offset>/<container-size>\n"
+#endif
+	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string, symbol,\n"
+	"\t           b<bit-width>@<bit-offset>/<container-size>,\n"
+	"\t           <type>\\[<array-size>\\]\n"
 #endif
 	"  events/\t\t- Directory containing all trace event subsystems:\n"
 	"      enable\t\t- Write 0/1 to enable/disable tracing of all events\n"
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 69a3fe926e8c..76217bbef815 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -290,7 +290,8 @@ void perf_kprobe_destroy(struct perf_event *p_event)
 #endif /* CONFIG_KPROBE_EVENTS */
 
 #ifdef CONFIG_UPROBE_EVENTS
-int perf_uprobe_init(struct perf_event *p_event, bool is_retprobe)
+int perf_uprobe_init(struct perf_event *p_event,
+		     unsigned long ref_ctr_offset, bool is_retprobe)
 {
 	int ret;
 	char *path = NULL;
@@ -312,8 +313,8 @@ int perf_uprobe_init(struct perf_event *p_event, bool is_retprobe)
 		goto out;
 	}
 
-	tp_event = create_local_trace_uprobe(
-		path, p_event->attr.probe_offset, is_retprobe);
+	tp_event = create_local_trace_uprobe(path, p_event->attr.probe_offset,
+					     ref_ctr_offset, is_retprobe);
 	if (IS_ERR(tp_event)) {
 		ret = PTR_ERR(tp_event);
 		goto out;
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index c30032367aab..fec67188c4d2 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -14,6 +14,7 @@
 
 #include "trace_kprobe_selftest.h"
 #include "trace_probe.h"
+#include "trace_probe_tmpl.h"
 
 #define KPROBE_EVENT_SYSTEM "kprobes"
 #define KRETPROBE_MAXACTIVE_MAX 4096
@@ -61,9 +62,23 @@ static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
 	return strncmp(mod->name, name, len) == 0 && name[len] == ':';
 }
 
-static nokprobe_inline bool trace_kprobe_is_on_module(struct trace_kprobe *tk)
+static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
 {
-	return !!strchr(trace_kprobe_symbol(tk), ':');
+	char *p;
+	bool ret;
+
+	if (!tk->symbol)
+		return false;
+	p = strchr(tk->symbol, ':');
+	if (!p)
+		return true;
+	*p = '\0';
+	mutex_lock(&module_mutex);
+	ret = !!find_module(tk->symbol);
+	mutex_unlock(&module_mutex);
+	*p = ':';
+
+	return ret;
 }
 
 static nokprobe_inline unsigned long trace_kprobe_nhit(struct trace_kprobe *tk)
@@ -120,184 +135,6 @@ static int kprobe_dispatcher(struct kprobe *kp, struct pt_regs *regs);
 static int kretprobe_dispatcher(struct kretprobe_instance *ri,
 				struct pt_regs *regs);
 
-/* Memory fetching by symbol */
-struct symbol_cache {
-	char		*symbol;
-	long		offset;
-	unsigned long	addr;
-};
-
-unsigned long update_symbol_cache(struct symbol_cache *sc)
-{
-	sc->addr = (unsigned long)kallsyms_lookup_name(sc->symbol);
-
-	if (sc->addr)
-		sc->addr += sc->offset;
-
-	return sc->addr;
-}
-
-void free_symbol_cache(struct symbol_cache *sc)
-{
-	kfree(sc->symbol);
-	kfree(sc);
-}
-
-struct symbol_cache *alloc_symbol_cache(const char *sym, long offset)
-{
-	struct symbol_cache *sc;
-
-	if (!sym || strlen(sym) == 0)
-		return NULL;
-
-	sc = kzalloc(sizeof(struct symbol_cache), GFP_KERNEL);
-	if (!sc)
-		return NULL;
-
-	sc->symbol = kstrdup(sym, GFP_KERNEL);
-	if (!sc->symbol) {
-		kfree(sc);
-		return NULL;
-	}
-	sc->offset = offset;
-	update_symbol_cache(sc);
-
-	return sc;
-}
-
-/*
- * Kprobes-specific fetch functions
- */
-#define DEFINE_FETCH_stack(type)					\
-static void FETCH_FUNC_NAME(stack, type)(struct pt_regs *regs,		\
-					  void *offset, void *dest)	\
-{									\
-	*(type *)dest = (type)regs_get_kernel_stack_nth(regs,		\
-				(unsigned int)((unsigned long)offset));	\
-}									\
-NOKPROBE_SYMBOL(FETCH_FUNC_NAME(stack, type));
-
-DEFINE_BASIC_FETCH_FUNCS(stack)
-/* No string on the stack entry */
-#define fetch_stack_string	NULL
-#define fetch_stack_string_size	NULL
-
-#define DEFINE_FETCH_memory(type)					\
-static void FETCH_FUNC_NAME(memory, type)(struct pt_regs *regs,		\
-					  void *addr, void *dest)	\
-{									\
-	type retval;							\
-	if (probe_kernel_address(addr, retval))				\
-		*(type *)dest = 0;					\
-	else								\
-		*(type *)dest = retval;					\
-}									\
-NOKPROBE_SYMBOL(FETCH_FUNC_NAME(memory, type));
-
-DEFINE_BASIC_FETCH_FUNCS(memory)
-/*
- * Fetch a null-terminated string. Caller MUST set *(u32 *)dest with max
- * length and relative data location.
- */
-static void FETCH_FUNC_NAME(memory, string)(struct pt_regs *regs,
-					    void *addr, void *dest)
-{
-	int maxlen = get_rloc_len(*(u32 *)dest);
-	u8 *dst = get_rloc_data(dest);
-	long ret;
-
-	if (!maxlen)
-		return;
-
-	/*
-	 * Try to get string again, since the string can be changed while
-	 * probing.
-	 */
-	ret = strncpy_from_unsafe(dst, addr, maxlen);
-
-	if (ret < 0) {	/* Failed to fetch string */
-		dst[0] = '\0';
-		*(u32 *)dest = make_data_rloc(0, get_rloc_offs(*(u32 *)dest));
-	} else {
-		*(u32 *)dest = make_data_rloc(ret, get_rloc_offs(*(u32 *)dest));
-	}
-}
-NOKPROBE_SYMBOL(FETCH_FUNC_NAME(memory, string));
-
-/* Return the length of string -- including null terminal byte */
-static void FETCH_FUNC_NAME(memory, string_size)(struct pt_regs *regs,
-						 void *addr, void *dest)
-{
-	mm_segment_t old_fs;
-	int ret, len = 0;
-	u8 c;
-
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	pagefault_disable();
-
-	do {
-		ret = __copy_from_user_inatomic(&c, (u8 *)addr + len, 1);
-		len++;
-	} while (c && ret == 0 && len < MAX_STRING_SIZE);
-
-	pagefault_enable();
-	set_fs(old_fs);
-
-	if (ret < 0)	/* Failed to check the length */
-		*(u32 *)dest = 0;
-	else
-		*(u32 *)dest = len;
-}
-NOKPROBE_SYMBOL(FETCH_FUNC_NAME(memory, string_size));
-
-#define DEFINE_FETCH_symbol(type)					\
-void FETCH_FUNC_NAME(symbol, type)(struct pt_regs *regs, void *data, void *dest)\
-{									\
-	struct symbol_cache *sc = data;					\
-	if (sc->addr)							\
-		fetch_memory_##type(regs, (void *)sc->addr, dest);	\
-	else								\
-		*(type *)dest = 0;					\
-}									\
-NOKPROBE_SYMBOL(FETCH_FUNC_NAME(symbol, type));
-
-DEFINE_BASIC_FETCH_FUNCS(symbol)
-DEFINE_FETCH_symbol(string)
-DEFINE_FETCH_symbol(string_size)
-
-/* kprobes don't support file_offset fetch methods */
-#define fetch_file_offset_u8		NULL
-#define fetch_file_offset_u16		NULL
-#define fetch_file_offset_u32		NULL
-#define fetch_file_offset_u64		NULL
-#define fetch_file_offset_string	NULL
-#define fetch_file_offset_string_size	NULL
-
-/* Fetch type information table */
-static const struct fetch_type kprobes_fetch_type_table[] = {
-	/* Special types */
-	[FETCH_TYPE_STRING] = __ASSIGN_FETCH_TYPE("string", string, string,
-					sizeof(u32), 1, "__data_loc char[]"),
-	[FETCH_TYPE_STRSIZE] = __ASSIGN_FETCH_TYPE("string_size", u32,
-					string_size, sizeof(u32), 0, "u32"),
-	/* Basic types */
-	ASSIGN_FETCH_TYPE(u8,  u8,  0),
-	ASSIGN_FETCH_TYPE(u16, u16, 0),
-	ASSIGN_FETCH_TYPE(u32, u32, 0),
-	ASSIGN_FETCH_TYPE(u64, u64, 0),
-	ASSIGN_FETCH_TYPE(s8,  u8,  1),
-	ASSIGN_FETCH_TYPE(s16, u16, 1),
-	ASSIGN_FETCH_TYPE(s32, u32, 1),
-	ASSIGN_FETCH_TYPE(s64, u64, 1),
-	ASSIGN_FETCH_TYPE_ALIAS(x8,  u8,  u8,  0),
-	ASSIGN_FETCH_TYPE_ALIAS(x16, u16, u16, 0),
-	ASSIGN_FETCH_TYPE_ALIAS(x32, u32, u32, 0),
-	ASSIGN_FETCH_TYPE_ALIAS(x64, u64, u64, 0),
-
-	ASSIGN_FETCH_TYPE_END
-};
-
 /*
  * Allocate new trace_probe and initialize it (including kprobes).
  */
@@ -540,8 +377,11 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 		return -EINVAL;
 	}
 
-	for (i = 0; i < tk->tp.nr_args; i++)
-		traceprobe_update_arg(&tk->tp.args[i]);
+	for (i = 0; i < tk->tp.nr_args; i++) {
+		ret = traceprobe_update_arg(&tk->tp.args[i]);
+		if (ret)
+			return ret;
+	}
 
 	/* Set/clear disabled flag according to tp->flag */
 	if (trace_probe_is_enabled(&tk->tp))
@@ -554,19 +394,13 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 	else
 		ret = register_kprobe(&tk->rp.kp);
 
-	if (ret == 0)
+	if (ret == 0) {
 		tk->tp.flags |= TP_FLAG_REGISTERED;
-	else {
-		if (ret == -ENOENT && trace_kprobe_is_on_module(tk)) {
-			pr_warn("This probe might be able to register after target module is loaded. Continue.\n");
-			ret = 0;
-		} else if (ret == -EILSEQ) {
-			pr_warn("Probing address(0x%p) is not an instruction boundary.\n",
-				tk->rp.kp.addr);
-			ret = -EINVAL;
-		}
+	} else if (ret == -EILSEQ) {
+		pr_warn("Probing address(0x%p) is not an instruction boundary.\n",
+			tk->rp.kp.addr);
+		ret = -EINVAL;
 	}
-
 	return ret;
 }
 
@@ -629,6 +463,11 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 
 	/* Register k*probe */
 	ret = __register_trace_kprobe(tk);
+	if (ret == -ENOENT && !trace_kprobe_module_exist(tk)) {
+		pr_warn("This probe might be able to register after target module is loaded. Continue.\n");
+		ret = 0;
+	}
+
 	if (ret < 0)
 		unregister_kprobe_event(tk);
 	else
@@ -713,13 +552,15 @@ static int create_trace_kprobe(int argc, char **argv)
 	long offset = 0;
 	void *addr = NULL;
 	char buf[MAX_EVENT_NAME_LEN];
+	unsigned int flags = TPARG_FL_KERNEL;
 
 	/* argc must be >= 1 */
 	if (argv[0][0] == 'p')
 		is_return = false;
-	else if (argv[0][0] == 'r')
+	else if (argv[0][0] == 'r') {
 		is_return = true;
-	else if (argv[0][0] == '-')
+		flags |= TPARG_FL_RETURN;
+	} else if (argv[0][0] == '-')
 		is_delete = true;
 	else {
 		pr_info("Probe definition must be started with 'p', 'r' or"
@@ -749,10 +590,13 @@ static int create_trace_kprobe(int argc, char **argv)
 	}
 
 	if (event) {
-		if (strchr(event, '/')) {
+		char *slash;
+
+		slash = strchr(event, '/');
+		if (slash) {
 			group = event;
-			event = strchr(group, '/') + 1;
-			event[-1] = '\0';
+			event = slash + 1;
+			slash[0] = '\0';
 			if (strlen(group) == 0) {
 				pr_info("Group name is not specified\n");
 				return -EINVAL;
@@ -802,8 +646,9 @@ static int create_trace_kprobe(int argc, char **argv)
 			pr_info("Failed to parse either an address or a symbol.\n");
 			return ret;
 		}
-		if (offset && is_return &&
-		    !kprobe_on_func_entry(NULL, symbol, offset)) {
+		if (kprobe_on_func_entry(NULL, symbol, offset))
+			flags |= TPARG_FL_FENTRY;
+		if (offset && is_return && !(flags & TPARG_FL_FENTRY)) {
 			pr_info("Given offset is not valid for return probe.\n");
 			return -EINVAL;
 		}
@@ -873,8 +718,7 @@ static int create_trace_kprobe(int argc, char **argv)
 
 		/* Parse fetch argument */
 		ret = traceprobe_parse_probe_arg(arg, &tk->tp.size, parg,
-						is_return, true,
-						kprobes_fetch_type_table);
+						 flags);
 		if (ret) {
 			pr_info("Parse error at argument[%d]. (%d)\n", i, ret);
 			goto error;
@@ -1028,6 +872,106 @@ static const struct file_operations kprobe_profile_ops = {
 	.release        = seq_release,
 };
 
+/* Kprobe specific fetch functions */
+
+/* Return the length of string -- including null terminal byte */
+static nokprobe_inline int
+fetch_store_strlen(unsigned long addr)
+{
+	mm_segment_t old_fs;
+	int ret, len = 0;
+	u8 c;
+
+	old_fs = get_fs();
+	set_fs(KERNEL_DS);
+	pagefault_disable();
+
+	do {
+		ret = __copy_from_user_inatomic(&c, (u8 *)addr + len, 1);
+		len++;
+	} while (c && ret == 0 && len < MAX_STRING_SIZE);
+
+	pagefault_enable();
+	set_fs(old_fs);
+
+	return (ret < 0) ? ret : len;
+}
+
+/*
+ * Fetch a null-terminated string. Caller MUST set *(u32 *)buf with max
+ * length and relative data location.
+ */
+static nokprobe_inline int
+fetch_store_string(unsigned long addr, void *dest, void *base)
+{
+	int maxlen = get_loc_len(*(u32 *)dest);
+	u8 *dst = get_loc_data(dest, base);
+	long ret;
+
+	if (unlikely(!maxlen))
+		return -ENOMEM;
+	/*
+	 * Try to get string again, since the string can be changed while
+	 * probing.
+	 */
+	ret = strncpy_from_unsafe(dst, (void *)addr, maxlen);
+
+	if (ret >= 0)
+		*(u32 *)dest = make_data_loc(ret, (void *)dst - base);
+	return ret;
+}
+
+static nokprobe_inline int
+probe_mem_read(void *dest, void *src, size_t size)
+{
+	return probe_kernel_read(dest, src, size);
+}
+
+/* Note that we don't verify it, since the code does not come from user space */
+static int
+process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
+		   void *base)
+{
+	unsigned long val;
+
+retry:
+	/* 1st stage: get value from context */
+	switch (code->op) {
+	case FETCH_OP_REG:
+		val = regs_get_register(regs, code->param);
+		break;
+	case FETCH_OP_STACK:
+		val = regs_get_kernel_stack_nth(regs, code->param);
+		break;
+	case FETCH_OP_STACKP:
+		val = kernel_stack_pointer(regs);
+		break;
+	case FETCH_OP_RETVAL:
+		val = regs_return_value(regs);
+		break;
+	case FETCH_OP_IMM:
+		val = code->immediate;
+		break;
+	case FETCH_OP_COMM:
+		val = (unsigned long)current->comm;
+		break;
+#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
+	case FETCH_OP_ARG:
+		val = regs_get_kernel_argument(regs, code->param);
+		break;
+#endif
+	case FETCH_NOP_SYMBOL:	/* Ignore a place holder */
+		code++;
+		goto retry;
+	default:
+		return -EILSEQ;
+	}
+	code++;
+
+	return process_fetch_insn_bottom(code, val, dest, base);
+}
+NOKPROBE_SYMBOL(process_fetch_insn)
+
 /* Kprobe handler */
 static nokprobe_inline void
 __kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs,
@@ -1059,7 +1003,7 @@ __kprobe_trace_func(struct trace_kprobe *tk, struct pt_regs *regs,
 
 	entry = ring_buffer_event_data(event);
 	entry->ip = (unsigned long)tk->rp.kp.addr;
-	store_trace_args(sizeof(*entry), &tk->tp, regs, (u8 *)&entry[1], dsize);
+	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
 
 	event_trigger_unlock_commit_regs(trace_file, buffer, event,
 					 entry, irq_flags, pc, regs);
@@ -1108,7 +1052,7 @@ __kretprobe_trace_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
 	entry = ring_buffer_event_data(event);
 	entry->func = (unsigned long)tk->rp.kp.addr;
 	entry->ret_ip = (unsigned long)ri->ret_addr;
-	store_trace_args(sizeof(*entry), &tk->tp, regs, (u8 *)&entry[1], dsize);
+	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
 
 	event_trigger_unlock_commit_regs(trace_file, buffer, event,
 					 entry, irq_flags, pc, regs);
@@ -1133,8 +1077,6 @@ print_kprobe_event(struct trace_iterator *iter, int flags,
 	struct kprobe_trace_entry_head *field;
 	struct trace_seq *s = &iter->seq;
 	struct trace_probe *tp;
-	u8 *data;
-	int i;
 
 	field = (struct kprobe_trace_entry_head *)iter->ent;
 	tp = container_of(event, struct trace_probe, call.event);
@@ -1146,11 +1088,9 @@ print_kprobe_event(struct trace_iterator *iter, int flags,
 
 	trace_seq_putc(s, ')');
 
-	data = (u8 *)&field[1];
-	for (i = 0; i < tp->nr_args; i++)
-		if (!tp->args[i].type->print(s, tp->args[i].name,
-					     data + tp->args[i].offset, field))
-			goto out;
+	if (print_probe_args(s, tp->args, tp->nr_args,
+			     (u8 *)&field[1], field) < 0)
+		goto out;
 
 	trace_seq_putc(s, '\n');
  out:
@@ -1164,8 +1104,6 @@ print_kretprobe_event(struct trace_iterator *iter, int flags,
 	struct kretprobe_trace_entry_head *field;
 	struct trace_seq *s = &iter->seq;
 	struct trace_probe *tp;
-	u8 *data;
-	int i;
 
 	field = (struct kretprobe_trace_entry_head *)iter->ent;
 	tp = container_of(event, struct trace_probe, call.event);
@@ -1182,11 +1120,9 @@ print_kretprobe_event(struct trace_iterator *iter, int flags,
 
 	trace_seq_putc(s, ')');
 
-	data = (u8 *)&field[1];
-	for (i = 0; i < tp->nr_args; i++)
-		if (!tp->args[i].type->print(s, tp->args[i].name,
-					     data + tp->args[i].offset, field))
-			goto out;
+	if (print_probe_args(s, tp->args, tp->nr_args,
+			     (u8 *)&field[1], field) < 0)
+		goto out;
 
 	trace_seq_putc(s, '\n');
 
@@ -1197,49 +1133,25 @@ print_kretprobe_event(struct trace_iterator *iter, int flags,
 
 static int kprobe_event_define_fields(struct trace_event_call *event_call)
 {
-	int ret, i;
+	int ret;
 	struct kprobe_trace_entry_head field;
 	struct trace_kprobe *tk = (struct trace_kprobe *)event_call->data;
 
 	DEFINE_FIELD(unsigned long, ip, FIELD_STRING_IP, 0);
-	/* Set argument names as fields */
-	for (i = 0; i < tk->tp.nr_args; i++) {
-		struct probe_arg *parg = &tk->tp.args[i];
 
-		ret = trace_define_field(event_call, parg->type->fmttype,
-					 parg->name,
-					 sizeof(field) + parg->offset,
-					 parg->type->size,
-					 parg->type->is_signed,
-					 FILTER_OTHER);
-		if (ret)
-			return ret;
-	}
-	return 0;
+	return traceprobe_define_arg_fields(event_call, sizeof(field), &tk->tp);
 }
 
 static int kretprobe_event_define_fields(struct trace_event_call *event_call)
 {
-	int ret, i;
+	int ret;
 	struct kretprobe_trace_entry_head field;
 	struct trace_kprobe *tk = (struct trace_kprobe *)event_call->data;
 
 	DEFINE_FIELD(unsigned long, func, FIELD_STRING_FUNC, 0);
 	DEFINE_FIELD(unsigned long, ret_ip, FIELD_STRING_RETIP, 0);
-	/* Set argument names as fields */
-	for (i = 0; i < tk->tp.nr_args; i++) {
-		struct probe_arg *parg = &tk->tp.args[i];
 
-		ret = trace_define_field(event_call, parg->type->fmttype,
-					 parg->name,
-					 sizeof(field) + parg->offset,
-					 parg->type->size,
-					 parg->type->is_signed,
-					 FILTER_OTHER);
-		if (ret)
-			return ret;
-	}
-	return 0;
+	return traceprobe_define_arg_fields(event_call, sizeof(field), &tk->tp);
 }
 
 #ifdef CONFIG_PERF_EVENTS
@@ -1286,7 +1198,7 @@ kprobe_perf_func(struct trace_kprobe *tk, struct pt_regs *regs)
 
 	entry->ip = (unsigned long)tk->rp.kp.addr;
 	memset(&entry[1], 0, dsize);
-	store_trace_args(sizeof(*entry), &tk->tp, regs, (u8 *)&entry[1], dsize);
+	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
 	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
 			      head, NULL);
 	return 0;
@@ -1322,7 +1234,7 @@ kretprobe_perf_func(struct trace_kprobe *tk, struct kretprobe_instance *ri,
 
 	entry->func = (unsigned long)tk->rp.kp.addr;
 	entry->ret_ip = (unsigned long)ri->ret_addr;
-	store_trace_args(sizeof(*entry), &tk->tp, regs, (u8 *)&entry[1], dsize);
+	store_trace_args(&entry[1], &tk->tp, regs, sizeof(*entry), dsize);
 	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
 			      head, NULL);
 }
@@ -1457,7 +1369,7 @@ static int register_kprobe_event(struct trace_kprobe *tk)
 
 	init_trace_event_call(tk, call);
 
-	if (set_print_fmt(&tk->tp, trace_kprobe_is_return(tk)) < 0)
+	if (traceprobe_set_print_fmt(&tk->tp, trace_kprobe_is_return(tk)) < 0)
 		return -ENOMEM;
 	ret = register_trace_event(&call->event);
 	if (!ret) {
@@ -1514,7 +1426,7 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 
 	init_trace_event_call(tk, &tk->tp.call);
 
-	if (set_print_fmt(&tk->tp, trace_kprobe_is_return(tk)) < 0) {
+	if (traceprobe_set_print_fmt(&tk->tp, trace_kprobe_is_return(tk)) < 0) {
 		ret = -ENOMEM;
 		goto error;
 	}
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index e99c3ce7aa65..3ef15a6683c0 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -26,14 +26,12 @@ const char *reserved_field_names[] = {
 
 /* Printing  in basic type function template */
 #define DEFINE_BASIC_PRINT_TYPE_FUNC(tname, type, fmt)			\
-int PRINT_TYPE_FUNC_NAME(tname)(struct trace_seq *s, const char *name,	\
-				void *data, void *ent)			\
+int PRINT_TYPE_FUNC_NAME(tname)(struct trace_seq *s, void *data, void *ent)\
 {									\
-	trace_seq_printf(s, " %s=" fmt, name, *(type *)data);		\
+	trace_seq_printf(s, fmt, *(type *)data);			\
 	return !trace_seq_has_overflowed(s);				\
 }									\
-const char PRINT_TYPE_FMT_NAME(tname)[] = fmt;				\
-NOKPROBE_SYMBOL(PRINT_TYPE_FUNC_NAME(tname));
+const char PRINT_TYPE_FMT_NAME(tname)[] = fmt;
 
 DEFINE_BASIC_PRINT_TYPE_FUNC(u8,  u8,  "%u")
 DEFINE_BASIC_PRINT_TYPE_FUNC(u16, u16, "%u")
@@ -48,193 +46,52 @@ DEFINE_BASIC_PRINT_TYPE_FUNC(x16, u16, "0x%x")
 DEFINE_BASIC_PRINT_TYPE_FUNC(x32, u32, "0x%x")
 DEFINE_BASIC_PRINT_TYPE_FUNC(x64, u64, "0x%Lx")
 
+int PRINT_TYPE_FUNC_NAME(symbol)(struct trace_seq *s, void *data, void *ent)
+{
+	trace_seq_printf(s, "%pS", (void *)*(unsigned long *)data);
+	return !trace_seq_has_overflowed(s);
+}
+const char PRINT_TYPE_FMT_NAME(symbol)[] = "%pS";
+
 /* Print type function for string type */
-int PRINT_TYPE_FUNC_NAME(string)(struct trace_seq *s, const char *name,
-				 void *data, void *ent)
+int PRINT_TYPE_FUNC_NAME(string)(struct trace_seq *s, void *data, void *ent)
 {
 	int len = *(u32 *)data >> 16;
 
 	if (!len)
-		trace_seq_printf(s, " %s=(fault)", name);
+		trace_seq_puts(s, "(fault)");
 	else
-		trace_seq_printf(s, " %s=\"%s\"", name,
+		trace_seq_printf(s, "\"%s\"",
 				 (const char *)get_loc_data(data, ent));
 	return !trace_seq_has_overflowed(s);
 }
-NOKPROBE_SYMBOL(PRINT_TYPE_FUNC_NAME(string));
 
 const char PRINT_TYPE_FMT_NAME(string)[] = "\\\"%s\\\"";
 
-#define CHECK_FETCH_FUNCS(method, fn)			\
-	(((FETCH_FUNC_NAME(method, u8) == fn) ||	\
-	  (FETCH_FUNC_NAME(method, u16) == fn) ||	\
-	  (FETCH_FUNC_NAME(method, u32) == fn) ||	\
-	  (FETCH_FUNC_NAME(method, u64) == fn) ||	\
-	  (FETCH_FUNC_NAME(method, string) == fn) ||	\
-	  (FETCH_FUNC_NAME(method, string_size) == fn)) \
-	 && (fn != NULL))
-
-/* Data fetch function templates */
-#define DEFINE_FETCH_reg(type)						\
-void FETCH_FUNC_NAME(reg, type)(struct pt_regs *regs, void *offset, void *dest)	\
-{									\
-	*(type *)dest = (type)regs_get_register(regs,			\
-				(unsigned int)((unsigned long)offset));	\
-}									\
-NOKPROBE_SYMBOL(FETCH_FUNC_NAME(reg, type));
-DEFINE_BASIC_FETCH_FUNCS(reg)
-/* No string on the register */
-#define fetch_reg_string	NULL
-#define fetch_reg_string_size	NULL
-
-#define DEFINE_FETCH_retval(type)					\
-void FETCH_FUNC_NAME(retval, type)(struct pt_regs *regs,		\
-				   void *dummy, void *dest)		\
-{									\
-	*(type *)dest = (type)regs_return_value(regs);			\
-}									\
-NOKPROBE_SYMBOL(FETCH_FUNC_NAME(retval, type));
-DEFINE_BASIC_FETCH_FUNCS(retval)
-/* No string on the retval */
-#define fetch_retval_string		NULL
-#define fetch_retval_string_size	NULL
-
-/* Dereference memory access function */
-struct deref_fetch_param {
-	struct fetch_param	orig;
-	long			offset;
-	fetch_func_t		fetch;
-	fetch_func_t		fetch_size;
+/* Fetch type information table */
+static const struct fetch_type probe_fetch_types[] = {
+	/* Special types */
+	__ASSIGN_FETCH_TYPE("string", string, string, sizeof(u32), 1,
+			    "__data_loc char[]"),
+	/* Basic types */
+	ASSIGN_FETCH_TYPE(u8,  u8,  0),
+	ASSIGN_FETCH_TYPE(u16, u16, 0),
+	ASSIGN_FETCH_TYPE(u32, u32, 0),
+	ASSIGN_FETCH_TYPE(u64, u64, 0),
+	ASSIGN_FETCH_TYPE(s8,  u8,  1),
+	ASSIGN_FETCH_TYPE(s16, u16, 1),
+	ASSIGN_FETCH_TYPE(s32, u32, 1),
+	ASSIGN_FETCH_TYPE(s64, u64, 1),
+	ASSIGN_FETCH_TYPE_ALIAS(x8,  u8,  u8,  0),
+	ASSIGN_FETCH_TYPE_ALIAS(x16, u16, u16, 0),
+	ASSIGN_FETCH_TYPE_ALIAS(x32, u32, u32, 0),
+	ASSIGN_FETCH_TYPE_ALIAS(x64, u64, u64, 0),
+	ASSIGN_FETCH_TYPE_ALIAS(symbol, ADDR_FETCH_TYPE, ADDR_FETCH_TYPE, 0),
+
+	ASSIGN_FETCH_TYPE_END
 };
 
-#define DEFINE_FETCH_deref(type)					\
-void FETCH_FUNC_NAME(deref, type)(struct pt_regs *regs,			\
-				  void *data, void *dest)		\
-{									\
-	struct deref_fetch_param *dprm = data;				\
-	unsigned long addr;						\
-	call_fetch(&dprm->orig, regs, &addr);				\
-	if (addr) {							\
-		addr += dprm->offset;					\
-		dprm->fetch(regs, (void *)addr, dest);			\
-	} else								\
-		*(type *)dest = 0;					\
-}									\
-NOKPROBE_SYMBOL(FETCH_FUNC_NAME(deref, type));
-DEFINE_BASIC_FETCH_FUNCS(deref)
-DEFINE_FETCH_deref(string)
-
-void FETCH_FUNC_NAME(deref, string_size)(struct pt_regs *regs,
-					 void *data, void *dest)
-{
-	struct deref_fetch_param *dprm = data;
-	unsigned long addr;
-
-	call_fetch(&dprm->orig, regs, &addr);
-	if (addr && dprm->fetch_size) {
-		addr += dprm->offset;
-		dprm->fetch_size(regs, (void *)addr, dest);
-	} else
-		*(string_size *)dest = 0;
-}
-NOKPROBE_SYMBOL(FETCH_FUNC_NAME(deref, string_size));
-
-static void update_deref_fetch_param(struct deref_fetch_param *data)
-{
-	if (CHECK_FETCH_FUNCS(deref, data->orig.fn))
-		update_deref_fetch_param(data->orig.data);
-	else if (CHECK_FETCH_FUNCS(symbol, data->orig.fn))
-		update_symbol_cache(data->orig.data);
-}
-NOKPROBE_SYMBOL(update_deref_fetch_param);
-
-static void free_deref_fetch_param(struct deref_fetch_param *data)
-{
-	if (CHECK_FETCH_FUNCS(deref, data->orig.fn))
-		free_deref_fetch_param(data->orig.data);
-	else if (CHECK_FETCH_FUNCS(symbol, data->orig.fn))
-		free_symbol_cache(data->orig.data);
-	kfree(data);
-}
-NOKPROBE_SYMBOL(free_deref_fetch_param);
-
-/* Bitfield fetch function */
-struct bitfield_fetch_param {
-	struct fetch_param	orig;
-	unsigned char		hi_shift;
-	unsigned char		low_shift;
-};
-
-#define DEFINE_FETCH_bitfield(type)					\
-void FETCH_FUNC_NAME(bitfield, type)(struct pt_regs *regs,		\
-				     void *data, void *dest)		\
-{									\
-	struct bitfield_fetch_param *bprm = data;			\
-	type buf = 0;							\
-	call_fetch(&bprm->orig, regs, &buf);				\
-	if (buf) {							\
-		buf <<= bprm->hi_shift;					\
-		buf >>= bprm->low_shift;				\
-	}								\
-	*(type *)dest = buf;						\
-}									\
-NOKPROBE_SYMBOL(FETCH_FUNC_NAME(bitfield, type));
-DEFINE_BASIC_FETCH_FUNCS(bitfield)
-#define fetch_bitfield_string		NULL
-#define fetch_bitfield_string_size	NULL
-
-static void
-update_bitfield_fetch_param(struct bitfield_fetch_param *data)
-{
-	/*
-	 * Don't check the bitfield itself, because this must be the
-	 * last fetch function.
-	 */
-	if (CHECK_FETCH_FUNCS(deref, data->orig.fn))
-		update_deref_fetch_param(data->orig.data);
-	else if (CHECK_FETCH_FUNCS(symbol, data->orig.fn))
-		update_symbol_cache(data->orig.data);
-}
-
-static void
-free_bitfield_fetch_param(struct bitfield_fetch_param *data)
-{
-	/*
-	 * Don't check the bitfield itself, because this must be the
-	 * last fetch function.
-	 */
-	if (CHECK_FETCH_FUNCS(deref, data->orig.fn))
-		free_deref_fetch_param(data->orig.data);
-	else if (CHECK_FETCH_FUNCS(symbol, data->orig.fn))
-		free_symbol_cache(data->orig.data);
-
-	kfree(data);
-}
-
-void FETCH_FUNC_NAME(comm, string)(struct pt_regs *regs,
-					  void *data, void *dest)
-{
-	int maxlen = get_rloc_len(*(u32 *)dest);
-	u8 *dst = get_rloc_data(dest);
-	long ret;
-
-	if (!maxlen)
-		return;
-
-	ret = strlcpy(dst, current->comm, maxlen);
-	*(u32 *)dest = make_data_rloc(ret, get_rloc_offs(*(u32 *)dest));
-}
-NOKPROBE_SYMBOL(FETCH_FUNC_NAME(comm, string));
-
-void FETCH_FUNC_NAME(comm, string_size)(struct pt_regs *regs,
-					       void *data, void *dest)
-{
-	*(u32 *)dest = strlen(current->comm) + 1;
-}
-NOKPROBE_SYMBOL(FETCH_FUNC_NAME(comm, string_size));
-
-static const struct fetch_type *find_fetch_type(const char *type,
-						const struct fetch_type *ftbl)
+static const struct fetch_type *find_fetch_type(const char *type)
 {
 	int i;
 
@@ -255,58 +112,27 @@ static const struct fetch_type *find_fetch_type(const char *type,
 
 		switch (bs) {
 		case 8:
-			return find_fetch_type("u8", ftbl);
+			return find_fetch_type("u8");
 		case 16:
-			return find_fetch_type("u16", ftbl);
+			return find_fetch_type("u16");
 		case 32:
-			return find_fetch_type("u32", ftbl);
+			return find_fetch_type("u32");
 		case 64:
-			return find_fetch_type("u64", ftbl);
+			return find_fetch_type("u64");
 		default:
 			goto fail;
 		}
 	}
 
-	for (i = 0; ftbl[i].name; i++) {
-		if (strcmp(type, ftbl[i].name) == 0)
-			return &ftbl[i];
+	for (i = 0; probe_fetch_types[i].name; i++) {
+		if (strcmp(type, probe_fetch_types[i].name) == 0)
+			return &probe_fetch_types[i];
 	}
 
 fail:
 	return NULL;
 }
 
-/* Special function : only accept unsigned long */
-static void fetch_kernel_stack_address(struct pt_regs *regs, void *dummy, void *dest)
-{
-	*(unsigned long *)dest = kernel_stack_pointer(regs);
-}
-NOKPROBE_SYMBOL(fetch_kernel_stack_address);
-
-static void fetch_user_stack_address(struct pt_regs *regs, void *dummy, void *dest)
-{
-	*(unsigned long *)dest = user_stack_pointer(regs);
-}
-NOKPROBE_SYMBOL(fetch_user_stack_address);
-
-static fetch_func_t get_fetch_size_function(const struct fetch_type *type,
-					    fetch_func_t orig_fn,
-					    const struct fetch_type *ftbl)
-{
-	int i;
-
-	if (type != &ftbl[FETCH_TYPE_STRING])
-		return NULL;	/* Only string type needs size function */
-
-	for (i = 0; i < FETCH_MTD_END; i++)
-		if (type->fetch[i] == orig_fn)
-			return ftbl[FETCH_TYPE_STRSIZE].fetch[i];
-
-	WARN_ON(1);	/* This should not happen */
-
-	return NULL;
-}
-
 /* Split symbol and offset. */
 int traceprobe_split_symbol_offset(char *symbol, long *offset)
 {
@@ -331,41 +157,44 @@ int traceprobe_split_symbol_offset(char *symbol, long *offset)
 #define PARAM_MAX_STACK (THREAD_SIZE / sizeof(unsigned long))
 
 static int parse_probe_vars(char *arg, const struct fetch_type *t,
-			    struct fetch_param *f, bool is_return,
-			    bool is_kprobe)
+			    struct fetch_insn *code, unsigned int flags)
 {
 	int ret = 0;
 	unsigned long param;
 
 	if (strcmp(arg, "retval") == 0) {
-		if (is_return)
-			f->fn = t->fetch[FETCH_MTD_retval];
+		if (flags & TPARG_FL_RETURN)
+			code->op = FETCH_OP_RETVAL;
 		else
 			ret = -EINVAL;
 	} else if (strncmp(arg, "stack", 5) == 0) {
 		if (arg[5] == '\0') {
-			if (strcmp(t->name, DEFAULT_FETCH_TYPE_STR))
-				return -EINVAL;
-
-			if (is_kprobe)
-				f->fn = fetch_kernel_stack_address;
-			else
-				f->fn = fetch_user_stack_address;
+			code->op = FETCH_OP_STACKP;
 		} else if (isdigit(arg[5])) {
 			ret = kstrtoul(arg + 5, 10, &param);
-			if (ret || (is_kprobe && param > PARAM_MAX_STACK))
+			if (ret || ((flags & TPARG_FL_KERNEL) &&
+				    param > PARAM_MAX_STACK))
 				ret = -EINVAL;
 			else {
-				f->fn = t->fetch[FETCH_MTD_stack];
-				f->data = (void *)param;
+				code->op = FETCH_OP_STACK;
+				code->param = (unsigned int)param;
 			}
 		} else
 			ret = -EINVAL;
 	} else if (strcmp(arg, "comm") == 0) {
-		if (strcmp(t->name, "string") != 0 &&
-		    strcmp(t->name, "string_size") != 0)
+		code->op = FETCH_OP_COMM;
+#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
+	} else if (((flags & TPARG_FL_MASK) ==
+		    (TPARG_FL_KERNEL | TPARG_FL_FENTRY)) &&
+		   strncmp(arg, "arg", 3) == 0) {
+		if (!isdigit(arg[3]))
+			return -EINVAL;
+		ret = kstrtoul(arg + 3, 10, &param);
+		if (ret || !param || param > PARAM_MAX_STACK)
 			return -EINVAL;
-		f->fn = t->fetch[FETCH_MTD_comm];
+		code->op = FETCH_OP_ARG;
+		code->param = (unsigned int)param - 1;
+#endif
 	} else
 		ret = -EINVAL;
 
@@ -373,25 +202,27 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
 }
 
 /* Recursive argument parser */
-static int parse_probe_arg(char *arg, const struct fetch_type *t,
-		     struct fetch_param *f, bool is_return, bool is_kprobe,
-		     const struct fetch_type *ftbl)
+static int
+parse_probe_arg(char *arg, const struct fetch_type *type,
+		struct fetch_insn **pcode, struct fetch_insn *end,
+		unsigned int flags)
 {
+	struct fetch_insn *code = *pcode;
 	unsigned long param;
-	long offset;
+	long offset = 0;
 	char *tmp;
 	int ret = 0;
 
 	switch (arg[0]) {
 	case '$':
-		ret = parse_probe_vars(arg + 1, t, f, is_return, is_kprobe);
+		ret = parse_probe_vars(arg + 1, type, code, flags);
 		break;
 
 	case '%':	/* named register */
 		ret = regs_query_register_offset(arg + 1);
 		if (ret >= 0) {
-			f->fn = t->fetch[FETCH_MTD_reg];
-			f->data = (void *)(unsigned long)ret;
+			code->op = FETCH_OP_REG;
+			code->param = (unsigned int)ret;
 			ret = 0;
 		}
 		break;
@@ -401,33 +232,42 @@ static int parse_probe_arg(char *arg, const struct fetch_type *t,
 			ret = kstrtoul(arg + 1, 0, &param);
 			if (ret)
 				break;
-
-			f->fn = t->fetch[FETCH_MTD_memory];
-			f->data = (void *)param;
+			/* load address */
+			code->op = FETCH_OP_IMM;
+			code->immediate = param;
 		} else if (arg[1] == '+') {
 			/* kprobes don't support file offsets */
-			if (is_kprobe)
+			if (flags & TPARG_FL_KERNEL)
 				return -EINVAL;
 
 			ret = kstrtol(arg + 2, 0, &offset);
 			if (ret)
 				break;
 
-			f->fn = t->fetch[FETCH_MTD_file_offset];
-			f->data = (void *)offset;
+			code->op = FETCH_OP_FOFFS;
+			code->immediate = (unsigned long)offset;  // imm64?
 		} else {
 			/* uprobes don't support symbols */
-			if (!is_kprobe)
+			if (!(flags & TPARG_FL_KERNEL))
 				return -EINVAL;
 
-			ret = traceprobe_split_symbol_offset(arg + 1, &offset);
-			if (ret)
-				break;
+			/* Preserve symbol for updating */
+			code->op = FETCH_NOP_SYMBOL;
+			code->data = kstrdup(arg + 1, GFP_KERNEL);
+			if (!code->data)
+				return -ENOMEM;
+			if (++code == end)
+				return -E2BIG;
 
-			f->data = alloc_symbol_cache(arg + 1, offset);
-			if (f->data)
-				f->fn = t->fetch[FETCH_MTD_symbol];
+			code->op = FETCH_OP_IMM;
+			code->immediate = 0;
 		}
+		/* These are fetching from memory */
+		if (++code == end)
+			return -E2BIG;
+		*pcode = code;
+		code->op = FETCH_OP_DEREF;
+		code->offset = offset;
 		break;
 
 	case '+':	/* deref memory */
@@ -435,11 +275,10 @@ static int parse_probe_arg(char *arg, const struct fetch_type *t,
 	case '-':
 		tmp = strchr(arg, '(');
 		if (!tmp)
-			break;
+			return -EINVAL;
 
 		*tmp = '\0';
 		ret = kstrtol(arg, 0, &offset);
-
 		if (ret)
 			break;
 
@@ -447,36 +286,27 @@ static int parse_probe_arg(char *arg, const struct fetch_type *t,
 		tmp = strrchr(arg, ')');
 
 		if (tmp) {
-			struct deref_fetch_param	*dprm;
-			const struct fetch_type		*t2;
+			const struct fetch_type *t2 = find_fetch_type(NULL);
 
-			t2 = find_fetch_type(NULL, ftbl);
 			*tmp = '\0';
-			dprm = kzalloc(sizeof(struct deref_fetch_param), GFP_KERNEL);
-
-			if (!dprm)
-				return -ENOMEM;
-
-			dprm->offset = offset;
-			dprm->fetch = t->fetch[FETCH_MTD_memory];
-			dprm->fetch_size = get_fetch_size_function(t,
-							dprm->fetch, ftbl);
-			ret = parse_probe_arg(arg, t2, &dprm->orig, is_return,
-							is_kprobe, ftbl);
+			ret = parse_probe_arg(arg, t2, &code, end, flags);
 			if (ret)
-				kfree(dprm);
-			else {
-				f->fn = t->fetch[FETCH_MTD_deref];
-				f->data = (void *)dprm;
-			}
+				break;
+			if (code->op == FETCH_OP_COMM)
+				return -EINVAL;
+			if (++code == end)
+				return -E2BIG;
+			*pcode = code;
+
+			code->op = FETCH_OP_DEREF;
+			code->offset = offset;
 		}
 		break;
 	}
-	if (!ret && !f->fn) {	/* Parsed, but do not find fetch method */
-		pr_info("%s type has no corresponding fetch method.\n", t->name);
+	if (!ret && code->op == FETCH_OP_NOP) {
+		/* Parsed, but do not find fetch method */
 		ret = -EINVAL;
 	}
-
 	return ret;
 }
 
@@ -485,22 +315,15 @@ static int parse_probe_arg(char *arg, const struct fetch_type *t,
 /* Bitfield type needs to be parsed into a fetch function */
 static int __parse_bitfield_probe_arg(const char *bf,
 				      const struct fetch_type *t,
-				      struct fetch_param *f)
+				      struct fetch_insn **pcode)
 {
-	struct bitfield_fetch_param *bprm;
+	struct fetch_insn *code = *pcode;
 	unsigned long bw, bo;
 	char *tail;
 
 	if (*bf != 'b')
 		return 0;
 
-	bprm = kzalloc(sizeof(*bprm), GFP_KERNEL);
-	if (!bprm)
-		return -ENOMEM;
-
-	bprm->orig = *f;
-	f->fn = t->fetch[FETCH_MTD_bitfield];
-	f->data = (void *)bprm;
 	bw = simple_strtoul(bf + 1, &tail, 0);	/* Use simple one */
 
 	if (bw == 0 || *tail != '@')
@@ -511,20 +334,26 @@ static int __parse_bitfield_probe_arg(const char *bf,
 
 	if (tail == bf || *tail != '/')
 		return -EINVAL;
+	code++;
+	if (code->op != FETCH_OP_NOP)
+		return -E2BIG;
+	*pcode = code;
 
-	bprm->hi_shift = BYTES_TO_BITS(t->size) - (bw + bo);
-	bprm->low_shift = bprm->hi_shift + bo;
+	code->op = FETCH_OP_MOD_BF;
+	code->lshift = BYTES_TO_BITS(t->size) - (bw + bo);
+	code->rshift = BYTES_TO_BITS(t->size) - bw;
+	code->basesize = t->size;
 
 	return (BYTES_TO_BITS(t->size) < (bw + bo)) ? -EINVAL : 0;
 }
 
 /* String length checking wrapper */
 int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
-		struct probe_arg *parg, bool is_return, bool is_kprobe,
-		const struct fetch_type *ftbl)
+		struct probe_arg *parg, unsigned int flags)
 {
-	const char *t;
-	int ret;
+	struct fetch_insn *code, *scode, *tmp = NULL;
+	char *t, *t2;
+	int ret, len;
 
 	if (strlen(arg) > MAX_ARGSTR_LEN) {
 		pr_info("Argument is too long.: %s\n",  arg);
@@ -535,36 +364,128 @@ int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
 		pr_info("Failed to allocate memory for command '%s'.\n", arg);
 		return -ENOMEM;
 	}
-	t = strchr(parg->comm, ':');
+	t = strchr(arg, ':');
 	if (t) {
-		arg[t - parg->comm] = '\0';
-		t++;
+		*t = '\0';
+		t2 = strchr(++t, '[');
+		if (t2) {
+			*t2 = '\0';
+			parg->count = simple_strtoul(t2 + 1, &t2, 0);
+			if (strcmp(t2, "]") || parg->count == 0)
+				return -EINVAL;
+			if (parg->count > MAX_ARRAY_LEN)
+				return -E2BIG;
+		}
 	}
 	/*
 	 * The default type of $comm should be "string", and it can't be
 	 * dereferenced.
 	 */
 	if (!t && strcmp(arg, "$comm") == 0)
-		t = "string";
-	parg->type = find_fetch_type(t, ftbl);
+		parg->type = find_fetch_type("string");
+	else
+		parg->type = find_fetch_type(t);
 	if (!parg->type) {
 		pr_info("Unsupported type: %s\n", t);
 		return -EINVAL;
 	}
 	parg->offset = *size;
-	*size += parg->type->size;
-	ret = parse_probe_arg(arg, parg->type, &parg->fetch, is_return,
-			      is_kprobe, ftbl);
-
-	if (ret >= 0 && t != NULL)
-		ret = __parse_bitfield_probe_arg(t, parg->type, &parg->fetch);
-
-	if (ret >= 0) {
-		parg->fetch_size.fn = get_fetch_size_function(parg->type,
-							      parg->fetch.fn,
-							      ftbl);
-		parg->fetch_size.data = parg->fetch.data;
+	*size += parg->type->size * (parg->count ?: 1);
+
+	if (parg->count) {
+		len = strlen(parg->type->fmttype) + 6;
+		parg->fmt = kmalloc(len, GFP_KERNEL);
+		if (!parg->fmt)
+			return -ENOMEM;
+		snprintf(parg->fmt, len, "%s[%d]", parg->type->fmttype,
+			 parg->count);
+	}
+
+	code = tmp = kzalloc(sizeof(*code) * FETCH_INSN_MAX, GFP_KERNEL);
+	if (!code)
+		return -ENOMEM;
+	code[FETCH_INSN_MAX - 1].op = FETCH_OP_END;
+
+	ret = parse_probe_arg(arg, parg->type, &code, &code[FETCH_INSN_MAX - 1],
+			      flags);
+	if (ret)
+		goto fail;
+
+	/* Store operation */
+	if (!strcmp(parg->type->name, "string")) {
+		if (code->op != FETCH_OP_DEREF && code->op != FETCH_OP_IMM &&
+		    code->op != FETCH_OP_COMM) {
+			pr_info("string only accepts memory or address.\n");
+			ret = -EINVAL;
+			goto fail;
+		}
+		if (code->op != FETCH_OP_DEREF || parg->count) {
+			/*
+			 * IMM and COMM is pointing actual address, those must
+			 * be kept, and if parg->count != 0, this is an array
+			 * of string pointers instead of string address itself.
+			 */
+			code++;
+			if (code->op != FETCH_OP_NOP) {
+				ret = -E2BIG;
+				goto fail;
+			}
+		}
+		code->op = FETCH_OP_ST_STRING;	/* In DEREF case, replace it */
+		code->size = parg->type->size;
+		parg->dynamic = true;
+	} else if (code->op == FETCH_OP_DEREF) {
+		code->op = FETCH_OP_ST_MEM;
+		code->size = parg->type->size;
+	} else {
+		code++;
+		if (code->op != FETCH_OP_NOP) {
+			ret = -E2BIG;
+			goto fail;
+		}
+		code->op = FETCH_OP_ST_RAW;
+		code->size = parg->type->size;
+	}
+	scode = code;
+	/* Modify operation */
+	if (t != NULL) {
+		ret = __parse_bitfield_probe_arg(t, parg->type, &code);
+		if (ret)
+			goto fail;
 	}
+	/* Loop(Array) operation */
+	if (parg->count) {
+		if (scode->op != FETCH_OP_ST_MEM &&
+		    scode->op != FETCH_OP_ST_STRING) {
+			pr_info("array only accepts memory or address\n");
+			ret = -EINVAL;
+			goto fail;
+		}
+		code++;
+		if (code->op != FETCH_OP_NOP) {
+			ret = -E2BIG;
+			goto fail;
+		}
+		code->op = FETCH_OP_LP_ARRAY;
+		code->param = parg->count;
+	}
+	code++;
+	code->op = FETCH_OP_END;
+
+	/* Shrink down the code buffer */
+	parg->code = kzalloc(sizeof(*code) * (code - tmp + 1), GFP_KERNEL);
+	if (!parg->code)
+		ret = -ENOMEM;
+	else
+		memcpy(parg->code, tmp, sizeof(*code) * (code - tmp + 1));
+
+fail:
+	if (ret) {
+		for (code = tmp; code < tmp + FETCH_INSN_MAX; code++)
+			if (code->op == FETCH_NOP_SYMBOL)
+				kfree(code->data);
+	}
+	kfree(tmp);
 
 	return ret;
 }
@@ -586,35 +507,63 @@ int traceprobe_conflict_field_name(const char *name,
 	return 0;
 }
 
-void traceprobe_update_arg(struct probe_arg *arg)
-{
-	if (CHECK_FETCH_FUNCS(bitfield, arg->fetch.fn))
-		update_bitfield_fetch_param(arg->fetch.data);
-	else if (CHECK_FETCH_FUNCS(deref, arg->fetch.fn))
-		update_deref_fetch_param(arg->fetch.data);
-	else if (CHECK_FETCH_FUNCS(symbol, arg->fetch.fn))
-		update_symbol_cache(arg->fetch.data);
-}
-
 void traceprobe_free_probe_arg(struct probe_arg *arg)
 {
-	if (CHECK_FETCH_FUNCS(bitfield, arg->fetch.fn))
-		free_bitfield_fetch_param(arg->fetch.data);
-	else if (CHECK_FETCH_FUNCS(deref, arg->fetch.fn))
-		free_deref_fetch_param(arg->fetch.data);
-	else if (CHECK_FETCH_FUNCS(symbol, arg->fetch.fn))
-		free_symbol_cache(arg->fetch.data);
+	struct fetch_insn *code = arg->code;
 
+	while (code && code->op != FETCH_OP_END) {
+		if (code->op == FETCH_NOP_SYMBOL)
+			kfree(code->data);
+		code++;
+	}
+	kfree(arg->code);
 	kfree(arg->name);
 	kfree(arg->comm);
+	kfree(arg->fmt);
 }
 
+int traceprobe_update_arg(struct probe_arg *arg)
+{
+	struct fetch_insn *code = arg->code;
+	long offset;
+	char *tmp;
+	char c;
+	int ret = 0;
+
+	while (code && code->op != FETCH_OP_END) {
+		if (code->op == FETCH_NOP_SYMBOL) {
+			if (code[1].op != FETCH_OP_IMM)
+				return -EINVAL;
+
+			tmp = strpbrk("+-", code->data);
+			if (tmp)
+				c = *tmp;
+			ret = traceprobe_split_symbol_offset(code->data,
+							     &offset);
+			if (ret)
+				return ret;
+
+			code[1].immediate =
+				(unsigned long)kallsyms_lookup_name(code->data);
+			if (tmp)
+				*tmp = c;
+			if (!code[1].immediate)
+				return -ENOENT;
+			code[1].immediate += offset;
+		}
+		code++;
+	}
+	return 0;
+}
+
+/* When len=0, we just calculate the needed length */
+#define LEN_OR_ZERO (len ? len - pos : 0)
 static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
 			   bool is_return)
 {
-	int i;
+	struct probe_arg *parg;
+	int i, j;
 	int pos = 0;
-
 	const char *fmt, *arg;
 
 	if (!is_return) {
@@ -625,35 +574,51 @@ static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
 		arg = "REC->" FIELD_STRING_FUNC ", REC->" FIELD_STRING_RETIP;
 	}
 
-	/* When len=0, we just calculate the needed length */
-#define LEN_OR_ZERO (len ? len - pos : 0)
-
 	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"%s", fmt);
 
 	for (i = 0; i < tp->nr_args; i++) {
-		pos += snprintf(buf + pos, LEN_OR_ZERO, " %s=%s",
-				tp->args[i].name, tp->args[i].type->fmt);
+		parg = tp->args + i;
+		pos += snprintf(buf + pos, LEN_OR_ZERO, " %s=", parg->name);
+		if (parg->count) {
+			pos += snprintf(buf + pos, LEN_OR_ZERO, "{%s",
+					parg->type->fmt);
+			for (j = 1; j < parg->count; j++)
+				pos += snprintf(buf + pos, LEN_OR_ZERO, ",%s",
+						parg->type->fmt);
+			pos += snprintf(buf + pos, LEN_OR_ZERO, "}");
+		} else
+			pos += snprintf(buf + pos, LEN_OR_ZERO, "%s",
+					parg->type->fmt);
 	}
 
 	pos += snprintf(buf + pos, LEN_OR_ZERO, "\", %s", arg);
 
 	for (i = 0; i < tp->nr_args; i++) {
-		if (strcmp(tp->args[i].type->name, "string") == 0)
+		parg = tp->args + i;
+		if (parg->count) {
+			if (strcmp(parg->type->name, "string") == 0)
+				fmt = ", __get_str(%s[%d])";
+			else
+				fmt = ", REC->%s[%d]";
+			for (j = 0; j < parg->count; j++)
+				pos += snprintf(buf + pos, LEN_OR_ZERO,
+						fmt, parg->name, j);
+		} else {
+			if (strcmp(parg->type->name, "string") == 0)
+				fmt = ", __get_str(%s)";
+			else
+				fmt = ", REC->%s";
 			pos += snprintf(buf + pos, LEN_OR_ZERO,
-					", __get_str(%s)",
-					tp->args[i].name);
-		else
-			pos += snprintf(buf + pos, LEN_OR_ZERO, ", REC->%s",
-					tp->args[i].name);
+					fmt, parg->name);
+		}
 	}
 
-#undef LEN_OR_ZERO
-
 	/* return the length of print_fmt */
 	return pos;
 }
+#undef LEN_OR_ZERO
 
-int set_print_fmt(struct trace_probe *tp, bool is_return)
+int traceprobe_set_print_fmt(struct trace_probe *tp, bool is_return)
 {
 	int len;
 	char *print_fmt;
@@ -670,3 +635,28 @@ int set_print_fmt(struct trace_probe *tp, bool is_return)
 
 	return 0;
 }
+
+int traceprobe_define_arg_fields(struct trace_event_call *event_call,
+				 size_t offset, struct trace_probe *tp)
+{
+	int ret, i;
+
+	/* Set argument names as fields */
+	for (i = 0; i < tp->nr_args; i++) {
+		struct probe_arg *parg = &tp->args[i];
+		const char *fmt = parg->type->fmttype;
+		int size = parg->type->size;
+
+		if (parg->fmt)
+			fmt = parg->fmt;
+		if (parg->count)
+			size *= parg->count;
+		ret = trace_define_field(event_call, fmt, parg->name,
+					 offset + parg->offset, size,
+					 parg->type->is_signed,
+					 FILTER_OTHER);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 5f52668e165d..974afc1a3e73 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -23,6 +23,7 @@
 #include <linux/stringify.h>
 #include <linux/limits.h>
 #include <linux/uaccess.h>
+#include <linux/bitops.h>
 #include <asm/bitsperlong.h>
 
 #include "trace.h"
@@ -30,6 +31,7 @@
 
 #define MAX_TRACE_ARGS		128
 #define MAX_ARGSTR_LEN		63
+#define MAX_ARRAY_LEN		64
 #define MAX_STRING_SIZE		PATH_MAX
 
 /* Reserved field names */
@@ -54,50 +56,74 @@
 #define TP_FLAG_PROFILE		2
 #define TP_FLAG_REGISTERED	4
 
+/* data_loc: data location, compatible with u32 */
+#define make_data_loc(len, offs)	\
+	(((u32)(len) << 16) | ((u32)(offs) & 0xffff))
+#define get_loc_len(dl)		((u32)(dl) >> 16)
+#define get_loc_offs(dl)	((u32)(dl) & 0xffff)
 
-/* data_rloc: data relative location, compatible with u32 */
-#define make_data_rloc(len, roffs)	\
-	(((u32)(len) << 16) | ((u32)(roffs) & 0xffff))
-#define get_rloc_len(dl)		((u32)(dl) >> 16)
-#define get_rloc_offs(dl)		((u32)(dl) & 0xffff)
-
-/*
- * Convert data_rloc to data_loc:
- *  data_rloc stores the offset from data_rloc itself, but data_loc
- *  stores the offset from event entry.
- */
-#define convert_rloc_to_loc(dl, offs)	((u32)(dl) + (offs))
-
-static nokprobe_inline void *get_rloc_data(u32 *dl)
+static nokprobe_inline void *get_loc_data(u32 *dl, void *ent)
 {
-	return (u8 *)dl + get_rloc_offs(*dl);
+	return (u8 *)ent + get_loc_offs(*dl);
 }
 
-/* For data_loc conversion */
-static nokprobe_inline void *get_loc_data(u32 *dl, void *ent)
+static nokprobe_inline u32 update_data_loc(u32 loc, int consumed)
 {
-	return (u8 *)ent + get_rloc_offs(*dl);
+	u32 maxlen = get_loc_len(loc);
+	u32 offset = get_loc_offs(loc);
+
+	return make_data_loc(maxlen - consumed, offset + consumed);
 }
 
-/* Data fetch function type */
-typedef	void (*fetch_func_t)(struct pt_regs *, void *, void *);
 /* Printing function type */
-typedef int (*print_type_func_t)(struct trace_seq *, const char *, void *, void *);
-
-/* Fetch types */
-enum {
-	FETCH_MTD_reg = 0,
-	FETCH_MTD_stack,
-	FETCH_MTD_retval,
-	FETCH_MTD_comm,
-	FETCH_MTD_memory,
-	FETCH_MTD_symbol,
-	FETCH_MTD_deref,
-	FETCH_MTD_bitfield,
-	FETCH_MTD_file_offset,
-	FETCH_MTD_END,
+typedef int (*print_type_func_t)(struct trace_seq *, void *, void *);
+
+enum fetch_op {
+	FETCH_OP_NOP = 0,
+	// Stage 1 (load) ops
+	FETCH_OP_REG,		/* Register : .param = offset */
+	FETCH_OP_STACK,		/* Stack : .param = index */
+	FETCH_OP_STACKP,	/* Stack pointer */
+	FETCH_OP_RETVAL,	/* Return value */
+	FETCH_OP_IMM,		/* Immediate : .immediate */
+	FETCH_OP_COMM,		/* Current comm */
+	FETCH_OP_ARG,		/* Function argument : .param */
+	FETCH_OP_FOFFS,		/* File offset: .immediate */
+	// Stage 2 (dereference) op
+	FETCH_OP_DEREF,		/* Dereference: .offset */
+	// Stage 3 (store) ops
+	FETCH_OP_ST_RAW,	/* Raw: .size */
+	FETCH_OP_ST_MEM,	/* Mem: .offset, .size */
+	FETCH_OP_ST_STRING,	/* String: .offset, .size */
+	// Stage 4 (modify) op
+	FETCH_OP_MOD_BF,	/* Bitfield: .basesize, .lshift, .rshift */
+	// Stage 5 (loop) op
+	FETCH_OP_LP_ARRAY,	/* Array: .param = loop count */
+	FETCH_OP_END,
+	FETCH_NOP_SYMBOL,	/* Unresolved Symbol holder */
 };
 
+struct fetch_insn {
+	enum fetch_op op;
+	union {
+		unsigned int param;
+		struct {
+			unsigned int size;
+			int offset;
+		};
+		struct {
+			unsigned char basesize;
+			unsigned char lshift;
+			unsigned char rshift;
+		};
+		unsigned long immediate;
+		void *data;
+	};
+};
+
+/* fetch + deref*N + store + mod + end <= 16, this allows N=12, enough */
+#define FETCH_INSN_MAX	16
+
 /* Fetch type information table */
 struct fetch_type {
 	const char		*name;		/* Name of type */
@@ -106,13 +132,6 @@ struct fetch_type {
 	print_type_func_t	print;		/* Print functions */
 	const char		*fmt;		/* Fromat string */
 	const char		*fmttype;	/* Name in format file */
-	/* Fetch functions */
-	fetch_func_t		fetch[FETCH_MTD_END];
-};
-
-struct fetch_param {
-	fetch_func_t		fn;
-	void 			*data;
 };
 
 /* For defining macros, define string/string_size types */
@@ -124,8 +143,7 @@ typedef u32 string_size;
 
 /* Printing  in basic type function template */
 #define DECLARE_BASIC_PRINT_TYPE_FUNC(type)				\
-int PRINT_TYPE_FUNC_NAME(type)(struct trace_seq *s, const char *name,	\
-				void *data, void *ent);			\
+int PRINT_TYPE_FUNC_NAME(type)(struct trace_seq *s, void *data, void *ent);\
 extern const char PRINT_TYPE_FMT_NAME(type)[]
 
 DECLARE_BASIC_PRINT_TYPE_FUNC(u8);
@@ -142,57 +160,7 @@ DECLARE_BASIC_PRINT_TYPE_FUNC(x32);
 DECLARE_BASIC_PRINT_TYPE_FUNC(x64);
 
 DECLARE_BASIC_PRINT_TYPE_FUNC(string);
-
-#define FETCH_FUNC_NAME(method, type)	fetch_##method##_##type
-
-/* Declare macro for basic types */
-#define DECLARE_FETCH_FUNC(method, type)				\
-extern void FETCH_FUNC_NAME(method, type)(struct pt_regs *regs, 	\
-					  void *data, void *dest)
-
-#define DECLARE_BASIC_FETCH_FUNCS(method) 	\
-DECLARE_FETCH_FUNC(method, u8);			\
-DECLARE_FETCH_FUNC(method, u16);		\
-DECLARE_FETCH_FUNC(method, u32);		\
-DECLARE_FETCH_FUNC(method, u64)
-
-DECLARE_BASIC_FETCH_FUNCS(reg);
-#define fetch_reg_string			NULL
-#define fetch_reg_string_size			NULL
-
-DECLARE_BASIC_FETCH_FUNCS(retval);
-#define fetch_retval_string			NULL
-#define fetch_retval_string_size		NULL
-
-DECLARE_BASIC_FETCH_FUNCS(symbol);
-DECLARE_FETCH_FUNC(symbol, string);
-DECLARE_FETCH_FUNC(symbol, string_size);
-
-DECLARE_BASIC_FETCH_FUNCS(deref);
-DECLARE_FETCH_FUNC(deref, string);
-DECLARE_FETCH_FUNC(deref, string_size);
-
-DECLARE_BASIC_FETCH_FUNCS(bitfield);
-#define fetch_bitfield_string			NULL
-#define fetch_bitfield_string_size		NULL
-
-/* comm only makes sense as a string */
-#define fetch_comm_u8		NULL
-#define fetch_comm_u16		NULL
-#define fetch_comm_u32		NULL
-#define fetch_comm_u64		NULL
-DECLARE_FETCH_FUNC(comm, string);
-DECLARE_FETCH_FUNC(comm, string_size);
-
-/*
- * Define macro for basic types - we don't need to define s* types, because
- * we have to care only about bitwidth at recording time.
- */
-#define DEFINE_BASIC_FETCH_FUNCS(method) \
-DEFINE_FETCH_##method(u8)		\
-DEFINE_FETCH_##method(u16)		\
-DEFINE_FETCH_##method(u32)		\
-DEFINE_FETCH_##method(u64)
+DECLARE_BASIC_PRINT_TYPE_FUNC(symbol);
 
 /* Default (unsigned long) fetch type */
 #define __DEFAULT_FETCH_TYPE(t) x##t
@@ -200,8 +168,9 @@ DEFINE_FETCH_##method(u64)
 #define DEFAULT_FETCH_TYPE _DEFAULT_FETCH_TYPE(BITS_PER_LONG)
 #define DEFAULT_FETCH_TYPE_STR __stringify(DEFAULT_FETCH_TYPE)
 
-#define ASSIGN_FETCH_FUNC(method, type)	\
-	[FETCH_MTD_##method] = FETCH_FUNC_NAME(method, type)
+#define __ADDR_FETCH_TYPE(t) u##t
+#define _ADDR_FETCH_TYPE(t) __ADDR_FETCH_TYPE(t)
+#define ADDR_FETCH_TYPE _ADDR_FETCH_TYPE(BITS_PER_LONG)
 
 #define __ASSIGN_FETCH_TYPE(_name, ptype, ftype, _size, sign, _fmttype)	\
 	{.name = _name,				\
@@ -210,64 +179,23 @@ DEFINE_FETCH_##method(u64)
 	 .print = PRINT_TYPE_FUNC_NAME(ptype),		\
 	 .fmt = PRINT_TYPE_FMT_NAME(ptype),		\
 	 .fmttype = _fmttype,				\
-	 .fetch = {					\
-ASSIGN_FETCH_FUNC(reg, ftype),				\
-ASSIGN_FETCH_FUNC(stack, ftype),			\
-ASSIGN_FETCH_FUNC(retval, ftype),			\
-ASSIGN_FETCH_FUNC(comm, ftype),				\
-ASSIGN_FETCH_FUNC(memory, ftype),			\
-ASSIGN_FETCH_FUNC(symbol, ftype),			\
-ASSIGN_FETCH_FUNC(deref, ftype),			\
-ASSIGN_FETCH_FUNC(bitfield, ftype),			\
-ASSIGN_FETCH_FUNC(file_offset, ftype),			\
-	  }						\
 	}
-
+#define _ASSIGN_FETCH_TYPE(_name, ptype, ftype, _size, sign, _fmttype)	\
+	__ASSIGN_FETCH_TYPE(_name, ptype, ftype, _size, sign, #_fmttype)
 #define ASSIGN_FETCH_TYPE(ptype, ftype, sign)			\
-	__ASSIGN_FETCH_TYPE(#ptype, ptype, ftype, sizeof(ftype), sign, #ptype)
+	_ASSIGN_FETCH_TYPE(#ptype, ptype, ftype, sizeof(ftype), sign, ptype)
 
 /* If ptype is an alias of atype, use this macro (show atype in format) */
 #define ASSIGN_FETCH_TYPE_ALIAS(ptype, atype, ftype, sign)		\
-	__ASSIGN_FETCH_TYPE(#ptype, ptype, ftype, sizeof(ftype), sign, #atype)
+	_ASSIGN_FETCH_TYPE(#ptype, ptype, ftype, sizeof(ftype), sign, atype)
 
 #define ASSIGN_FETCH_TYPE_END {}
-
-#define FETCH_TYPE_STRING	0
-#define FETCH_TYPE_STRSIZE	1
+#define MAX_ARRAY_LEN	64
 
 #ifdef CONFIG_KPROBE_EVENTS
-struct symbol_cache;
-unsigned long update_symbol_cache(struct symbol_cache *sc);
-void free_symbol_cache(struct symbol_cache *sc);
-struct symbol_cache *alloc_symbol_cache(const char *sym, long offset);
 bool trace_kprobe_on_func_entry(struct trace_event_call *call);
 bool trace_kprobe_error_injectable(struct trace_event_call *call);
 #else
-/* uprobes do not support symbol fetch methods */
-#define fetch_symbol_u8			NULL
-#define fetch_symbol_u16		NULL
-#define fetch_symbol_u32		NULL
-#define fetch_symbol_u64		NULL
-#define fetch_symbol_string		NULL
-#define fetch_symbol_string_size	NULL
-
-struct symbol_cache {
-};
-static inline unsigned long __used update_symbol_cache(struct symbol_cache *sc)
-{
-	return 0;
-}
-
-static inline void __used free_symbol_cache(struct symbol_cache *sc)
-{
-}
-
-static inline struct symbol_cache * __used
-alloc_symbol_cache(const char *sym, long offset)
-{
-	return NULL;
-}
-
 static inline bool trace_kprobe_on_func_entry(struct trace_event_call *call)
 {
 	return false;
@@ -280,11 +208,13 @@ static inline bool trace_kprobe_error_injectable(struct trace_event_call *call)
 #endif /* CONFIG_KPROBE_EVENTS */
 
 struct probe_arg {
-	struct fetch_param	fetch;
-	struct fetch_param	fetch_size;
+	struct fetch_insn	*code;
+	bool			dynamic;/* Dynamic array (string) is used */
 	unsigned int		offset;	/* Offset from argument entry */
+	unsigned int		count;	/* Array count */
 	const char		*name;	/* Name of this argument */
 	const char		*comm;	/* Command of this argument */
+	char			*fmt;	/* Format string if needed */
 	const struct fetch_type	*type;	/* Type of this argument */
 };
 
@@ -313,12 +243,6 @@ static inline bool trace_probe_is_registered(struct trace_probe *tp)
 	return !!(tp->flags & TP_FLAG_REGISTERED);
 }
 
-static nokprobe_inline void call_fetch(struct fetch_param *fprm,
-				 struct pt_regs *regs, void *dest)
-{
-	return fprm->fn(regs, fprm->data, dest);
-}
-
 /* Check the name is good for event/group/fields */
 static inline bool is_good_name(const char *name)
 {
@@ -343,67 +267,23 @@ find_event_file_link(struct trace_probe *tp, struct trace_event_file *file)
 	return NULL;
 }
 
+#define TPARG_FL_RETURN BIT(0)
+#define TPARG_FL_KERNEL BIT(1)
+#define TPARG_FL_FENTRY BIT(2)
+#define TPARG_FL_MASK	GENMASK(2, 0)
+
 extern int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
-		   struct probe_arg *parg, bool is_return, bool is_kprobe,
-		   const struct fetch_type *ftbl);
+		   struct probe_arg *parg, unsigned int flags);
 
 extern int traceprobe_conflict_field_name(const char *name,
 			       struct probe_arg *args, int narg);
 
-extern void traceprobe_update_arg(struct probe_arg *arg);
+extern int traceprobe_update_arg(struct probe_arg *arg);
 extern void traceprobe_free_probe_arg(struct probe_arg *arg);
 
 extern int traceprobe_split_symbol_offset(char *symbol, long *offset);
 
-/* Sum up total data length for dynamic arraies (strings) */
-static nokprobe_inline int
-__get_data_size(struct trace_probe *tp, struct pt_regs *regs)
-{
-	int i, ret = 0;
-	u32 len;
-
-	for (i = 0; i < tp->nr_args; i++)
-		if (unlikely(tp->args[i].fetch_size.fn)) {
-			call_fetch(&tp->args[i].fetch_size, regs, &len);
-			ret += len;
-		}
-
-	return ret;
-}
-
-/* Store the value of each argument */
-static nokprobe_inline void
-store_trace_args(int ent_size, struct trace_probe *tp, struct pt_regs *regs,
-		 u8 *data, int maxlen)
-{
-	int i;
-	u32 end = tp->size;
-	u32 *dl;	/* Data (relative) location */
-
-	for (i = 0; i < tp->nr_args; i++) {
-		if (unlikely(tp->args[i].fetch_size.fn)) {
-			/*
-			 * First, we set the relative location and
-			 * maximum data length to *dl
-			 */
-			dl = (u32 *)(data + tp->args[i].offset);
-			*dl = make_data_rloc(maxlen, end - tp->args[i].offset);
-			/* Then try to fetch string or dynamic array data */
-			call_fetch(&tp->args[i].fetch, regs, dl);
-			/* Reduce maximum length */
-			end += get_rloc_len(*dl);
-			maxlen -= get_rloc_len(*dl);
-			/* Trick here, convert data_rloc to data_loc */
-			*dl = convert_rloc_to_loc(*dl,
-				 ent_size + tp->args[i].offset);
-		} else
-			/* Just fetching data normally */
-			call_fetch(&tp->args[i].fetch, regs,
-				   data + tp->args[i].offset);
-	}
-}
-
-extern int set_print_fmt(struct trace_probe *tp, bool is_return);
+extern int traceprobe_set_print_fmt(struct trace_probe *tp, bool is_return);
 
 #ifdef CONFIG_PERF_EVENTS
 extern struct trace_event_call *
@@ -412,6 +292,9 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 extern void destroy_local_trace_kprobe(struct trace_event_call *event_call);
 
 extern struct trace_event_call *
-create_local_trace_uprobe(char *name, unsigned long offs, bool is_return);
+create_local_trace_uprobe(char *name, unsigned long offs,
+			  unsigned long ref_ctr_offset, bool is_return);
 extern void destroy_local_trace_uprobe(struct trace_event_call *event_call);
 #endif
+extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
+					size_t offset, struct trace_probe *tp);
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
new file mode 100644
index 000000000000..5c56afc17cf8
--- /dev/null
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -0,0 +1,216 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Traceprobe fetch helper inlines
+ */
+
+static nokprobe_inline void
+fetch_store_raw(unsigned long val, struct fetch_insn *code, void *buf)
+{
+	switch (code->size) {
+	case 1:
+		*(u8 *)buf = (u8)val;
+		break;
+	case 2:
+		*(u16 *)buf = (u16)val;
+		break;
+	case 4:
+		*(u32 *)buf = (u32)val;
+		break;
+	case 8:
+		//TBD: 32bit signed
+		*(u64 *)buf = (u64)val;
+		break;
+	default:
+		*(unsigned long *)buf = val;
+	}
+}
+
+static nokprobe_inline void
+fetch_apply_bitfield(struct fetch_insn *code, void *buf)
+{
+	switch (code->basesize) {
+	case 1:
+		*(u8 *)buf <<= code->lshift;
+		*(u8 *)buf >>= code->rshift;
+		break;
+	case 2:
+		*(u16 *)buf <<= code->lshift;
+		*(u16 *)buf >>= code->rshift;
+		break;
+	case 4:
+		*(u32 *)buf <<= code->lshift;
+		*(u32 *)buf >>= code->rshift;
+		break;
+	case 8:
+		*(u64 *)buf <<= code->lshift;
+		*(u64 *)buf >>= code->rshift;
+		break;
+	}
+}
+
+/*
+ * These functions must be defined for each callsite.
+ * Return consumed dynamic data size (>= 0), or error (< 0).
+ * If dest is NULL, don't store result and return required dynamic data size.
+ */
+static int
+process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs,
+		   void *dest, void *base);
+static nokprobe_inline int fetch_store_strlen(unsigned long addr);
+static nokprobe_inline int
+fetch_store_string(unsigned long addr, void *dest, void *base);
+static nokprobe_inline int
+probe_mem_read(void *dest, void *src, size_t size);
+
+/* From the 2nd stage, routine is same */
+static nokprobe_inline int
+process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
+			   void *dest, void *base)
+{
+	struct fetch_insn *s3 = NULL;
+	int total = 0, ret = 0, i = 0;
+	u32 loc = 0;
+	unsigned long lval = val;
+
+stage2:
+	/* 2nd stage: dereference memory if needed */
+	while (code->op == FETCH_OP_DEREF) {
+		lval = val;
+		ret = probe_mem_read(&val, (void *)val + code->offset,
+					sizeof(val));
+		if (ret)
+			return ret;
+		code++;
+	}
+
+	s3 = code;
+stage3:
+	/* 3rd stage: store value to buffer */
+	if (unlikely(!dest)) {
+		if (code->op == FETCH_OP_ST_STRING) {
+			ret += fetch_store_strlen(val + code->offset);
+			code++;
+			goto array;
+		} else
+			return -EILSEQ;
+	}
+
+	switch (code->op) {
+	case FETCH_OP_ST_RAW:
+		fetch_store_raw(val, code, dest);
+		break;
+	case FETCH_OP_ST_MEM:
+		probe_mem_read(dest, (void *)val + code->offset, code->size);
+		break;
+	case FETCH_OP_ST_STRING:
+		loc = *(u32 *)dest;
+		ret = fetch_store_string(val + code->offset, dest, base);
+		break;
+	default:
+		return -EILSEQ;
+	}
+	code++;
+
+	/* 4th stage: modify stored value if needed */
+	if (code->op == FETCH_OP_MOD_BF) {
+		fetch_apply_bitfield(code, dest);
+		code++;
+	}
+
+array:
+	/* the last stage: Loop on array */
+	if (code->op == FETCH_OP_LP_ARRAY) {
+		total += ret;
+		if (++i < code->param) {
+			code = s3;
+			if (s3->op != FETCH_OP_ST_STRING) {
+				dest += s3->size;
+				val += s3->size;
+				goto stage3;
+			}
+			code--;
+			val = lval + sizeof(char *);
+			if (dest) {
+				dest += sizeof(u32);
+				*(u32 *)dest = update_data_loc(loc, ret);
+			}
+			goto stage2;
+		}
+		code++;
+		ret = total;
+	}
+
+	return code->op == FETCH_OP_END ? ret : -EILSEQ;
+}
+
+/* Sum up total data length for dynamic arraies (strings) */
+static nokprobe_inline int
+__get_data_size(struct trace_probe *tp, struct pt_regs *regs)
+{
+	struct probe_arg *arg;
+	int i, len, ret = 0;
+
+	for (i = 0; i < tp->nr_args; i++) {
+		arg = tp->args + i;
+		if (unlikely(arg->dynamic)) {
+			len = process_fetch_insn(arg->code, regs, NULL, NULL);
+			if (len > 0)
+				ret += len;
+		}
+	}
+
+	return ret;
+}
+
+/* Store the value of each argument */
+static nokprobe_inline void
+store_trace_args(void *data, struct trace_probe *tp, struct pt_regs *regs,
+		 int header_size, int maxlen)
+{
+	struct probe_arg *arg;
+	void *base = data - header_size;
+	void *dyndata = data + tp->size;
+	u32 *dl;	/* Data location */
+	int ret, i;
+
+	for (i = 0; i < tp->nr_args; i++) {
+		arg = tp->args + i;
+		dl = data + arg->offset;
+		/* Point the dynamic data area if needed */
+		if (unlikely(arg->dynamic))
+			*dl = make_data_loc(maxlen, dyndata - base);
+		ret = process_fetch_insn(arg->code, regs, dl, base);
+		if (unlikely(ret < 0 && arg->dynamic))
+			*dl = make_data_loc(0, dyndata - base);
+		else
+			dyndata += ret;
+	}
+}
+
+static inline int
+print_probe_args(struct trace_seq *s, struct probe_arg *args, int nr_args,
+		 u8 *data, void *field)
+{
+	void *p;
+	int i, j;
+
+	for (i = 0; i < nr_args; i++) {
+		struct probe_arg *a = args + i;
+
+		trace_seq_printf(s, " %s=", a->name);
+		if (likely(!a->count)) {
+			if (!a->type->print(s, data + a->offset, field))
+				return -ENOMEM;
+			continue;
+		}
+		trace_seq_putc(s, '{');
+		p = data + a->offset;
+		for (j = 0; j < a->count; j++) {
+			if (!a->type->print(s, p, field))
+				return -ENOMEM;
+			trace_seq_putc(s, j == a->count - 1 ? '}' : ',');
+			p += a->type->size;
+		}
+	}
+	return 0;
+}
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 4237eba4ef20..2b0d1ee3241c 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -111,7 +111,7 @@ check_stack(unsigned long ip, unsigned long *stack)
 	stack_trace_max_size = this_size;
 
 	stack_trace_max.nr_entries = 0;
-	stack_trace_max.skip = 3;
+	stack_trace_max.skip = 0;
 
 	save_stack_trace(&stack_trace_max);
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index e696667da29a..31ea48eceda1 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -15,6 +15,7 @@
 #include <linux/rculist.h>
 
 #include "trace_probe.h"
+#include "trace_probe_tmpl.h"
 
 #define UPROBE_EVENT_SYSTEM	"uprobes"
 
@@ -47,6 +48,7 @@ struct trace_uprobe {
 	struct inode			*inode;
 	char				*filename;
 	unsigned long			offset;
+	unsigned long			ref_ctr_offset;
 	unsigned long			nhit;
 	struct trace_probe		tp;
 };
@@ -98,74 +100,52 @@ static unsigned long get_user_stack_nth(struct pt_regs *regs, unsigned int n)
 /*
  * Uprobes-specific fetch functions
  */
-#define DEFINE_FETCH_stack(type)					\
-static void FETCH_FUNC_NAME(stack, type)(struct pt_regs *regs,		\
-					 void *offset, void *dest)	\
-{									\
-	*(type *)dest = (type)get_user_stack_nth(regs,			\
-					      ((unsigned long)offset)); \
-}
-DEFINE_BASIC_FETCH_FUNCS(stack)
-/* No string on the stack entry */
-#define fetch_stack_string	NULL
-#define fetch_stack_string_size	NULL
-
-#define DEFINE_FETCH_memory(type)					\
-static void FETCH_FUNC_NAME(memory, type)(struct pt_regs *regs,		\
-					  void *addr, void *dest)	\
-{									\
-	type retval;							\
-	void __user *vaddr = (void __force __user *) addr;		\
-									\
-	if (copy_from_user(&retval, vaddr, sizeof(type)))		\
-		*(type *)dest = 0;					\
-	else								\
-		*(type *) dest = retval;				\
+static nokprobe_inline int
+probe_mem_read(void *dest, void *src, size_t size)
+{
+	void __user *vaddr = (void __force __user *)src;
+
+	return copy_from_user(dest, vaddr, size) ? -EFAULT : 0;
 }
-DEFINE_BASIC_FETCH_FUNCS(memory)
 /*
  * Fetch a null-terminated string. Caller MUST set *(u32 *)dest with max
  * length and relative data location.
  */
-static void FETCH_FUNC_NAME(memory, string)(struct pt_regs *regs,
-					    void *addr, void *dest)
+static nokprobe_inline int
+fetch_store_string(unsigned long addr, void *dest, void *base)
 {
 	long ret;
-	u32 rloc = *(u32 *)dest;
-	int maxlen  = get_rloc_len(rloc);
-	u8 *dst = get_rloc_data(dest);
+	u32 loc = *(u32 *)dest;
+	int maxlen  = get_loc_len(loc);
+	u8 *dst = get_loc_data(dest, base);
 	void __user *src = (void __force __user *) addr;
 
-	if (!maxlen)
-		return;
+	if (unlikely(!maxlen))
+		return -ENOMEM;
 
 	ret = strncpy_from_user(dst, src, maxlen);
-	if (ret == maxlen)
-		dst[--ret] = '\0';
-
-	if (ret < 0) {	/* Failed to fetch string */
-		((u8 *)get_rloc_data(dest))[0] = '\0';
-		*(u32 *)dest = make_data_rloc(0, get_rloc_offs(rloc));
-	} else {
-		*(u32 *)dest = make_data_rloc(ret, get_rloc_offs(rloc));
+	if (ret >= 0) {
+		if (ret == maxlen)
+			dst[ret - 1] = '\0';
+		*(u32 *)dest = make_data_loc(ret, (void *)dst - base);
 	}
+
+	return ret;
 }
 
-static void FETCH_FUNC_NAME(memory, string_size)(struct pt_regs *regs,
-						 void *addr, void *dest)
+/* Return the length of string -- including null terminal byte */
+static nokprobe_inline int
+fetch_store_strlen(unsigned long addr)
 {
 	int len;
 	void __user *vaddr = (void __force __user *) addr;
 
 	len = strnlen_user(vaddr, MAX_STRING_SIZE);
 
-	if (len == 0 || len > MAX_STRING_SIZE)  /* Failed to check length */
-		*(u32 *)dest = 0;
-	else
-		*(u32 *)dest = len;
+	return (len > MAX_STRING_SIZE) ? 0 : len;
 }
 
-static unsigned long translate_user_vaddr(void *file_offset)
+static unsigned long translate_user_vaddr(unsigned long file_offset)
 {
 	unsigned long base_addr;
 	struct uprobe_dispatch_data *udd;
@@ -173,44 +153,44 @@ static unsigned long translate_user_vaddr(void *file_offset)
 	udd = (void *) current->utask->vaddr;
 
 	base_addr = udd->bp_addr - udd->tu->offset;
-	return base_addr + (unsigned long)file_offset;
+	return base_addr + file_offset;
 }
 
-#define DEFINE_FETCH_file_offset(type)					\
-static void FETCH_FUNC_NAME(file_offset, type)(struct pt_regs *regs,	\
-					       void *offset, void *dest)\
-{									\
-	void *vaddr = (void *)translate_user_vaddr(offset);		\
-									\
-	FETCH_FUNC_NAME(memory, type)(regs, vaddr, dest);		\
+/* Note that we don't verify it, since the code does not come from user space */
+static int
+process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
+		   void *base)
+{
+	unsigned long val;
+
+	/* 1st stage: get value from context */
+	switch (code->op) {
+	case FETCH_OP_REG:
+		val = regs_get_register(regs, code->param);
+		break;
+	case FETCH_OP_STACK:
+		val = get_user_stack_nth(regs, code->param);
+		break;
+	case FETCH_OP_STACKP:
+		val = user_stack_pointer(regs);
+		break;
+	case FETCH_OP_RETVAL:
+		val = regs_return_value(regs);
+		break;
+	case FETCH_OP_IMM:
+		val = code->immediate;
+		break;
+	case FETCH_OP_FOFFS:
+		val = translate_user_vaddr(code->immediate);
+		break;
+	default:
+		return -EILSEQ;
+	}
+	code++;
+
+	return process_fetch_insn_bottom(code, val, dest, base);
 }
-DEFINE_BASIC_FETCH_FUNCS(file_offset)
-DEFINE_FETCH_file_offset(string)
-DEFINE_FETCH_file_offset(string_size)
-
-/* Fetch type information table */
-static const struct fetch_type uprobes_fetch_type_table[] = {
-	/* Special types */
-	[FETCH_TYPE_STRING] = __ASSIGN_FETCH_TYPE("string", string, string,
-					sizeof(u32), 1, "__data_loc char[]"),
-	[FETCH_TYPE_STRSIZE] = __ASSIGN_FETCH_TYPE("string_size", u32,
-					string_size, sizeof(u32), 0, "u32"),
-	/* Basic types */
-	ASSIGN_FETCH_TYPE(u8,  u8,  0),
-	ASSIGN_FETCH_TYPE(u16, u16, 0),
-	ASSIGN_FETCH_TYPE(u32, u32, 0),
-	ASSIGN_FETCH_TYPE(u64, u64, 0),
-	ASSIGN_FETCH_TYPE(s8,  u8,  1),
-	ASSIGN_FETCH_TYPE(s16, u16, 1),
-	ASSIGN_FETCH_TYPE(s32, u32, 1),
-	ASSIGN_FETCH_TYPE(s64, u64, 1),
-	ASSIGN_FETCH_TYPE_ALIAS(x8,  u8,  u8,  0),
-	ASSIGN_FETCH_TYPE_ALIAS(x16, u16, u16, 0),
-	ASSIGN_FETCH_TYPE_ALIAS(x32, u32, u32, 0),
-	ASSIGN_FETCH_TYPE_ALIAS(x64, u64, u64, 0),
-
-	ASSIGN_FETCH_TYPE_END
-};
+NOKPROBE_SYMBOL(process_fetch_insn)
 
 static inline void init_trace_uprobe_filter(struct trace_uprobe_filter *filter)
 {
@@ -311,6 +291,35 @@ static int unregister_trace_uprobe(struct trace_uprobe *tu)
 	return 0;
 }
 
+/*
+ * Uprobe with multiple reference counter is not allowed. i.e.
+ * If inode and offset matches, reference counter offset *must*
+ * match as well. Though, there is one exception: If user is
+ * replacing old trace_uprobe with new one(same group/event),
+ * then we allow same uprobe with new reference counter as far
+ * as the new one does not conflict with any other existing
+ * ones.
+ */
+static struct trace_uprobe *find_old_trace_uprobe(struct trace_uprobe *new)
+{
+	struct trace_uprobe *tmp, *old = NULL;
+	struct inode *new_inode = d_real_inode(new->path.dentry);
+
+	old = find_probe_event(trace_event_name(&new->tp.call),
+				new->tp.call.class->system);
+
+	list_for_each_entry(tmp, &uprobe_list, list) {
+		if ((old ? old != tmp : true) &&
+		    new_inode == d_real_inode(tmp->path.dentry) &&
+		    new->offset == tmp->offset &&
+		    new->ref_ctr_offset != tmp->ref_ctr_offset) {
+			pr_warn("Reference counter offset mismatch.");
+			return ERR_PTR(-EINVAL);
+		}
+	}
+	return old;
+}
+
 /* Register a trace_uprobe and probe_event */
 static int register_trace_uprobe(struct trace_uprobe *tu)
 {
@@ -320,8 +329,12 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 	mutex_lock(&uprobe_lock);
 
 	/* register as an event */
-	old_tu = find_probe_event(trace_event_name(&tu->tp.call),
-			tu->tp.call.class->system);
+	old_tu = find_old_trace_uprobe(tu);
+	if (IS_ERR(old_tu)) {
+		ret = PTR_ERR(old_tu);
+		goto end;
+	}
+
 	if (old_tu) {
 		/* delete old event */
 		ret = unregister_trace_uprobe(old_tu);
@@ -352,10 +365,10 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 static int create_trace_uprobe(int argc, char **argv)
 {
 	struct trace_uprobe *tu;
-	char *arg, *event, *group, *filename;
+	char *arg, *event, *group, *filename, *rctr, *rctr_end;
 	char buf[MAX_EVENT_NAME_LEN];
 	struct path path;
-	unsigned long offset;
+	unsigned long offset, ref_ctr_offset;
 	bool is_delete, is_return;
 	int i, ret;
 
@@ -364,6 +377,7 @@ static int create_trace_uprobe(int argc, char **argv)
 	is_return = false;
 	event = NULL;
 	group = NULL;
+	ref_ctr_offset = 0;
 
 	/* argc must be >= 1 */
 	if (argv[0][0] == '-')
@@ -438,6 +452,26 @@ static int create_trace_uprobe(int argc, char **argv)
 		goto fail_address_parse;
 	}
 
+	/* Parse reference counter offset if specified. */
+	rctr = strchr(arg, '(');
+	if (rctr) {
+		rctr_end = strchr(rctr, ')');
+		if (rctr > rctr_end || *(rctr_end + 1) != 0) {
+			ret = -EINVAL;
+			pr_info("Invalid reference counter offset.\n");
+			goto fail_address_parse;
+		}
+
+		*rctr++ = '\0';
+		*rctr_end = '\0';
+		ret = kstrtoul(rctr, 0, &ref_ctr_offset);
+		if (ret) {
+			pr_info("Invalid reference counter offset.\n");
+			goto fail_address_parse;
+		}
+	}
+
+	/* Parse uprobe offset. */
 	ret = kstrtoul(arg, 0, &offset);
 	if (ret)
 		goto fail_address_parse;
@@ -472,6 +506,7 @@ static int create_trace_uprobe(int argc, char **argv)
 		goto fail_address_parse;
 	}
 	tu->offset = offset;
+	tu->ref_ctr_offset = ref_ctr_offset;
 	tu->path = path;
 	tu->filename = kstrdup(filename, GFP_KERNEL);
 
@@ -522,8 +557,7 @@ static int create_trace_uprobe(int argc, char **argv)
 
 		/* Parse fetch argument */
 		ret = traceprobe_parse_probe_arg(arg, &tu->tp.size, parg,
-						 is_return, false,
-						 uprobes_fetch_type_table);
+					is_return ? TPARG_FL_RETURN : 0);
 		if (ret) {
 			pr_info("Parse error at argument[%d]. (%d)\n", i, ret);
 			goto error;
@@ -590,6 +624,9 @@ static int probes_seq_show(struct seq_file *m, void *v)
 			trace_event_name(&tu->tp.call), tu->filename,
 			(int)(sizeof(void *) * 2), tu->offset);
 
+	if (tu->ref_ctr_offset)
+		seq_printf(m, "(0x%lx)", tu->ref_ctr_offset);
+
 	for (i = 0; i < tu->tp.nr_args; i++)
 		seq_printf(m, " %s=%s", tu->tp.args[i].name, tu->tp.args[i].comm);
 
@@ -833,7 +870,6 @@ print_uprobe_event(struct trace_iterator *iter, int flags, struct trace_event *e
 	struct trace_seq *s = &iter->seq;
 	struct trace_uprobe *tu;
 	u8 *data;
-	int i;
 
 	entry = (struct uprobe_trace_entry_head *)iter->ent;
 	tu = container_of(event, struct trace_uprobe, tp.call.event);
@@ -850,12 +886,8 @@ print_uprobe_event(struct trace_iterator *iter, int flags, struct trace_event *e
 		data = DATAOF_TRACE_ENTRY(entry, false);
 	}
 
-	for (i = 0; i < tu->tp.nr_args; i++) {
-		struct probe_arg *parg = &tu->tp.args[i];
-
-		if (!parg->type->print(s, parg->name, data + parg->offset, entry))
-			goto out;
-	}
+	if (print_probe_args(s, tu->tp.args, tu->tp.nr_args, data, entry) < 0)
+		goto out;
 
 	trace_seq_putc(s, '\n');
 
@@ -905,7 +937,13 @@ probe_event_enable(struct trace_uprobe *tu, struct trace_event_file *file,
 
 	tu->consumer.filter = filter;
 	tu->inode = d_real_inode(tu->path.dentry);
-	ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
+	if (tu->ref_ctr_offset) {
+		ret = uprobe_register_refctr(tu->inode, tu->offset,
+				tu->ref_ctr_offset, &tu->consumer);
+	} else {
+		ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
+	}
+
 	if (ret)
 		goto err_buffer;
 
@@ -958,7 +996,7 @@ probe_event_disable(struct trace_uprobe *tu, struct trace_event_file *file)
 
 static int uprobe_event_define_fields(struct trace_event_call *event_call)
 {
-	int ret, i, size;
+	int ret, size;
 	struct uprobe_trace_entry_head field;
 	struct trace_uprobe *tu = event_call->data;
 
@@ -970,19 +1008,8 @@ static int uprobe_event_define_fields(struct trace_event_call *event_call)
 		DEFINE_FIELD(unsigned long, vaddr[0], FIELD_STRING_IP, 0);
 		size = SIZEOF_TRACE_ENTRY(false);
 	}
-	/* Set argument names as fields */
-	for (i = 0; i < tu->tp.nr_args; i++) {
-		struct probe_arg *parg = &tu->tp.args[i];
-
-		ret = trace_define_field(event_call, parg->type->fmttype,
-					 parg->name, size + parg->offset,
-					 parg->type->size, parg->type->is_signed,
-					 FILTER_OTHER);
 
-		if (ret)
-			return ret;
-	}
-	return 0;
+	return traceprobe_define_arg_fields(event_call, size, &tu->tp);
 }
 
 #ifdef CONFIG_PERF_EVENTS
@@ -1233,7 +1260,7 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
 	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
 
 	ucb = uprobe_buffer_get();
-	store_trace_args(esize, &tu->tp, regs, ucb->buf, dsize);
+	store_trace_args(ucb->buf, &tu->tp, regs, esize, dsize);
 
 	if (tu->tp.flags & TP_FLAG_TRACE)
 		ret |= uprobe_trace_func(tu, regs, ucb, dsize);
@@ -1268,7 +1295,7 @@ static int uretprobe_dispatcher(struct uprobe_consumer *con,
 	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
 
 	ucb = uprobe_buffer_get();
-	store_trace_args(esize, &tu->tp, regs, ucb->buf, dsize);
+	store_trace_args(ucb->buf, &tu->tp, regs, esize, dsize);
 
 	if (tu->tp.flags & TP_FLAG_TRACE)
 		uretprobe_trace_func(tu, func, regs, ucb, dsize);
@@ -1304,7 +1331,7 @@ static int register_uprobe_event(struct trace_uprobe *tu)
 
 	init_trace_event_call(tu, call);
 
-	if (set_print_fmt(&tu->tp, is_ret_probe(tu)) < 0)
+	if (traceprobe_set_print_fmt(&tu->tp, is_ret_probe(tu)) < 0)
 		return -ENOMEM;
 
 	ret = register_trace_event(&call->event);
@@ -1340,7 +1367,8 @@ static int unregister_uprobe_event(struct trace_uprobe *tu)
 
 #ifdef CONFIG_PERF_EVENTS
 struct trace_event_call *
-create_local_trace_uprobe(char *name, unsigned long offs, bool is_return)
+create_local_trace_uprobe(char *name, unsigned long offs,
+			  unsigned long ref_ctr_offset, bool is_return)
 {
 	struct trace_uprobe *tu;
 	struct path path;
@@ -1372,10 +1400,11 @@ create_local_trace_uprobe(char *name, unsigned long offs, bool is_return)
 
 	tu->offset = offs;
 	tu->path = path;
+	tu->ref_ctr_offset = ref_ctr_offset;
 	tu->filename = kstrdup(name, GFP_KERNEL);
 	init_trace_event_call(tu, &tu->tp.call);
 
-	if (set_print_fmt(&tu->tp, is_ret_probe(tu)) < 0) {
+	if (traceprobe_set_print_fmt(&tu->tp, is_ret_probe(tu)) < 0) {
 		ret = -ENOMEM;
 		goto error;
 	}
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index f119eb628dbb..e86f8be89157 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1819,6 +1819,12 @@ int parse_probe_trace_command(const char *cmd, struct probe_trace_event *tev)
 			tp->offset = strtoul(fmt2_str, NULL, 10);
 	}
 
+	if (tev->uprobes) {
+		fmt2_str = strchr(p, '(');
+		if (fmt2_str)
+			tp->ref_ctr_offset = strtoul(fmt2_str + 1, NULL, 0);
+	}
+
 	tev->nargs = argc - 2;
 	tev->args = zalloc(sizeof(struct probe_trace_arg) * tev->nargs);
 	if (tev->args == NULL) {
@@ -2012,6 +2018,22 @@ static int synthesize_probe_trace_arg(struct probe_trace_arg *arg,
 	return err;
 }
 
+static int
+synthesize_uprobe_trace_def(struct probe_trace_event *tev, struct strbuf *buf)
+{
+	struct probe_trace_point *tp = &tev->point;
+	int err;
+
+	err = strbuf_addf(buf, "%s:0x%lx", tp->module, tp->address);
+
+	if (err >= 0 && tp->ref_ctr_offset) {
+		if (!uprobe_ref_ctr_is_supported())
+			return -1;
+		err = strbuf_addf(buf, "(0x%lx)", tp->ref_ctr_offset);
+	}
+	return err >= 0 ? 0 : -1;
+}
+
 char *synthesize_probe_trace_command(struct probe_trace_event *tev)
 {
 	struct probe_trace_point *tp = &tev->point;
@@ -2041,15 +2063,17 @@ char *synthesize_probe_trace_command(struct probe_trace_event *tev)
 	}
 
 	/* Use the tp->address for uprobes */
-	if (tev->uprobes)
-		err = strbuf_addf(&buf, "%s:0x%lx", tp->module, tp->address);
-	else if (!strncmp(tp->symbol, "0x", 2))
+	if (tev->uprobes) {
+		err = synthesize_uprobe_trace_def(tev, &buf);
+	} else if (!strncmp(tp->symbol, "0x", 2)) {
 		/* Absolute address. See try_to_find_absolute_address() */
 		err = strbuf_addf(&buf, "%s%s0x%lx", tp->module ?: "",
 				  tp->module ? ":" : "", tp->address);
-	else
+	} else {
 		err = strbuf_addf(&buf, "%s%s%s+%lu", tp->module ?: "",
 				tp->module ? ":" : "", tp->symbol, tp->offset);
+	}
+
 	if (err)
 		goto error;
 
@@ -2633,6 +2657,13 @@ static void warn_uprobe_event_compat(struct probe_trace_event *tev)
 {
 	int i;
 	char *buf = synthesize_probe_trace_command(tev);
+	struct probe_trace_point *tp = &tev->point;
+
+	if (tp->ref_ctr_offset && !uprobe_ref_ctr_is_supported()) {
+		pr_warning("A semaphore is associated with %s:%s and "
+			   "seems your kernel doesn't support it.\n",
+			   tev->group, tev->event);
+	}
 
 	/* Old uprobe event doesn't support memory dereference */
 	if (!tev->uprobes || tev->nargs == 0 || !buf)
diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
index 45b14f020558..15a98c3a2a2f 100644
--- a/tools/perf/util/probe-event.h
+++ b/tools/perf/util/probe-event.h
@@ -27,6 +27,7 @@ struct probe_trace_point {
 	char		*symbol;	/* Base symbol */
 	char		*module;	/* Module name */
 	unsigned long	offset;		/* Offset from symbol */
+	unsigned long	ref_ctr_offset;	/* SDT reference counter offset */
 	unsigned long	address;	/* Actual address of the trace point */
 	bool		retprobe;	/* Return probe flag */
 };
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index b76088fadf3d..aac7817d9e14 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -696,8 +696,16 @@ int probe_cache__add_entry(struct probe_cache *pcache,
 #ifdef HAVE_GELF_GETNOTE_SUPPORT
 static unsigned long long sdt_note__get_addr(struct sdt_note *note)
 {
-	return note->bit32 ? (unsigned long long)note->addr.a32[0]
-		 : (unsigned long long)note->addr.a64[0];
+	return note->bit32 ?
+		(unsigned long long)note->addr.a32[SDT_NOTE_IDX_LOC] :
+		(unsigned long long)note->addr.a64[SDT_NOTE_IDX_LOC];
+}
+
+static unsigned long long sdt_note__get_ref_ctr_offset(struct sdt_note *note)
+{
+	return note->bit32 ?
+		(unsigned long long)note->addr.a32[SDT_NOTE_IDX_REFCTR] :
+		(unsigned long long)note->addr.a64[SDT_NOTE_IDX_REFCTR];
 }
 
 static const char * const type_to_suffix[] = {
@@ -775,14 +783,21 @@ static char *synthesize_sdt_probe_command(struct sdt_note *note,
 {
 	struct strbuf buf;
 	char *ret = NULL, **args;
-	int i, args_count;
+	int i, args_count, err;
+	unsigned long long ref_ctr_offset;
 
 	if (strbuf_init(&buf, 32) < 0)
 		return NULL;
 
-	if (strbuf_addf(&buf, "p:%s/%s %s:0x%llx",
-				sdtgrp, note->name, pathname,
-				sdt_note__get_addr(note)) < 0)
+	err = strbuf_addf(&buf, "p:%s/%s %s:0x%llx",
+			sdtgrp, note->name, pathname,
+			sdt_note__get_addr(note));
+
+	ref_ctr_offset = sdt_note__get_ref_ctr_offset(note);
+	if (ref_ctr_offset && err >= 0)
+		err = strbuf_addf(&buf, "(0x%llx)", ref_ctr_offset);
+
+	if (err < 0)
 		goto error;
 
 	if (!note->args)
@@ -998,6 +1013,7 @@ int probe_cache__show_all_caches(struct strfilter *filter)
 enum ftrace_readme {
 	FTRACE_README_PROBE_TYPE_X = 0,
 	FTRACE_README_KRETPROBE_OFFSET,
+	FTRACE_README_UPROBE_REF_CTR,
 	FTRACE_README_END,
 };
 
@@ -1009,6 +1025,7 @@ static struct {
 	[idx] = {.pattern = pat, .avail = false}
 	DEFINE_TYPE(FTRACE_README_PROBE_TYPE_X, "*type: * x8/16/32/64,*"),
 	DEFINE_TYPE(FTRACE_README_KRETPROBE_OFFSET, "*place (kretprobe): *"),
+	DEFINE_TYPE(FTRACE_README_UPROBE_REF_CTR, "*ref_ctr_offset*"),
 };
 
 static bool scan_ftrace_readme(enum ftrace_readme type)
@@ -1064,3 +1081,8 @@ bool kretprobe_offset_is_supported(void)
 {
 	return scan_ftrace_readme(FTRACE_README_KRETPROBE_OFFSET);
 }
+
+bool uprobe_ref_ctr_is_supported(void)
+{
+	return scan_ftrace_readme(FTRACE_README_UPROBE_REF_CTR);
+}
diff --git a/tools/perf/util/probe-file.h b/tools/perf/util/probe-file.h
index 63f29b1d22c1..2a249182f2a6 100644
--- a/tools/perf/util/probe-file.h
+++ b/tools/perf/util/probe-file.h
@@ -69,6 +69,7 @@ struct probe_cache_entry *probe_cache__find_by_name(struct probe_cache *pcache,
 int probe_cache__show_all_caches(struct strfilter *filter);
 bool probe_type_is_available(enum probe_type type);
 bool kretprobe_offset_is_supported(void);
+bool uprobe_ref_ctr_is_supported(void);
 #else	/* ! HAVE_LIBELF_SUPPORT */
 static inline struct probe_cache *probe_cache__new(const char *tgt __maybe_unused, struct nsinfo *nsi __maybe_unused)
 {
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 29770ea61768..0281d5e2cd67 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1947,6 +1947,34 @@ void kcore_extract__delete(struct kcore_extract *kce)
 }
 
 #ifdef HAVE_GELF_GETNOTE_SUPPORT
+
+static void sdt_adjust_loc(struct sdt_note *tmp, GElf_Addr base_off)
+{
+	if (!base_off)
+		return;
+
+	if (tmp->bit32)
+		tmp->addr.a32[SDT_NOTE_IDX_LOC] =
+			tmp->addr.a32[SDT_NOTE_IDX_LOC] + base_off -
+			tmp->addr.a32[SDT_NOTE_IDX_BASE];
+	else
+		tmp->addr.a64[SDT_NOTE_IDX_LOC] =
+			tmp->addr.a64[SDT_NOTE_IDX_LOC] + base_off -
+			tmp->addr.a64[SDT_NOTE_IDX_BASE];
+}
+
+static void sdt_adjust_refctr(struct sdt_note *tmp, GElf_Addr base_addr,
+			      GElf_Addr base_off)
+{
+	if (!base_off)
+		return;
+
+	if (tmp->bit32 && tmp->addr.a32[SDT_NOTE_IDX_REFCTR])
+		tmp->addr.a32[SDT_NOTE_IDX_REFCTR] -= (base_addr - base_off);
+	else if (tmp->addr.a64[SDT_NOTE_IDX_REFCTR])
+		tmp->addr.a64[SDT_NOTE_IDX_REFCTR] -= (base_addr - base_off);
+}
+
 /**
  * populate_sdt_note : Parse raw data and identify SDT note
  * @elf: elf of the opened file
@@ -1964,7 +1992,6 @@ static int populate_sdt_note(Elf **elf, const char *data, size_t len,
 	const char *provider, *name, *args;
 	struct sdt_note *tmp = NULL;
 	GElf_Ehdr ehdr;
-	GElf_Addr base_off = 0;
 	GElf_Shdr shdr;
 	int ret = -EINVAL;
 
@@ -2060,17 +2087,12 @@ static int populate_sdt_note(Elf **elf, const char *data, size_t len,
 	 * base address in the description of the SDT note. If its different,
 	 * then accordingly, adjust the note location.
 	 */
-	if (elf_section_by_name(*elf, &ehdr, &shdr, SDT_BASE_SCN, NULL)) {
-		base_off = shdr.sh_offset;
-		if (base_off) {
-			if (tmp->bit32)
-				tmp->addr.a32[0] = tmp->addr.a32[0] + base_off -
-					tmp->addr.a32[1];
-			else
-				tmp->addr.a64[0] = tmp->addr.a64[0] + base_off -
-					tmp->addr.a64[1];
-		}
-	}
+	if (elf_section_by_name(*elf, &ehdr, &shdr, SDT_BASE_SCN, NULL))
+		sdt_adjust_loc(tmp, shdr.sh_offset);
+
+	/* Adjust reference counter offset */
+	if (elf_section_by_name(*elf, &ehdr, &shdr, SDT_PROBES_SCN, NULL))
+		sdt_adjust_refctr(tmp, shdr.sh_addr, shdr.sh_offset);
 
 	list_add_tail(&tmp->note_list, sdt_notes);
 	return 0;
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index f25fae4b5743..20f49779116b 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -379,12 +379,19 @@ int get_sdt_note_list(struct list_head *head, const char *target);
 int cleanup_sdt_note_list(struct list_head *sdt_notes);
 int sdt_notes__get_count(struct list_head *start);
 
+#define SDT_PROBES_SCN ".probes"
 #define SDT_BASE_SCN ".stapsdt.base"
 #define SDT_NOTE_SCN  ".note.stapsdt"
 #define SDT_NOTE_TYPE 3
 #define SDT_NOTE_NAME "stapsdt"
 #define NR_ADDR 3
 
+enum {
+	SDT_NOTE_IDX_LOC = 0,
+	SDT_NOTE_IDX_BASE,
+	SDT_NOTE_IDX_REFCTR,
+};
+
 struct mem_info *mem_info__new(void);
 struct mem_info *mem_info__get(struct mem_info *mi);
 void   mem_info__put(struct mem_info *mi);
