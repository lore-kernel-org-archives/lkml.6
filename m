Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4130C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 03:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DB12085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 03:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98DB12085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeJKKcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 06:32:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbeJKKcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 06:32:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3EDFC30012D7;
        Thu, 11 Oct 2018 03:07:43 +0000 (UTC)
Received: from treble (ovpn-124-83.rdu2.redhat.com [10.10.124.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 52D5B89D29;
        Thu, 11 Oct 2018 03:07:40 +0000 (UTC)
Date:   Wed, 10 Oct 2018 22:07:38 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Helsley <mhelsley@vmware.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Lutomirski <luto@kernel.org>
Subject: Re: [POC][RFC][PATCH 1/2] jump_function: Addition of new feature
 "jump_function"
Message-ID: <20181011030738.wwy6grnss67txd2l@treble>
References: <A9379DDB-3210-407C-8157-8DA980944F8C@amacapital.net>
 <20181008155757.GC5663@hirez.programming.kicks-ass.net>
 <F36C6419-7D92-4357-BDB1-D8B90DE09889@amacapital.net>
 <20181009021710.qwt5hpntyeps44h3@treble>
 <20181008235750.59da83ae@gandalf.local.home>
 <20181010175237.e7m3sldcu2maoqcq@treble>
 <CALCETrUOaJ1dAsuX9bQO_+B4G6y5-FAb0=ZYA8QbtAEBZ6MxKg@mail.gmail.com>
 <20181010181605.arsyjxwdztztrjih@treble>
 <20181010181741.lc4l7kjvcmoxrw5b@treble>
 <CALCETrUZMmTDOh5-Mzyj1rk7Q82DgdQLinOfbzF4Sb7OC2aYMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrUZMmTDOh5-Mzyj1rk7Q82DgdQLinOfbzF4Sb7OC2aYMQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 11 Oct 2018 03:07:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 02:13:22PM -0700, Andy Lutomirski wrote:
> On Wed, Oct 10, 2018 at 11:17 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Wed, Oct 10, 2018 at 01:16:05PM -0500, Josh Poimboeuf wrote:
> > > On Wed, Oct 10, 2018 at 11:03:43AM -0700, Andy Lutomirski wrote:
> > > > > +#define DECLARE_STATIC_CALL(tramp, func)                               \
> > > > > +       extern typeof(func) tramp;                                      \
> > > > > +       static void __used __section(.discard.static_call_tramps)       \
> > > > > +               *__static_call_tramp_##tramp = tramp
> > > > > +
> > > >
> > > > Confused.  What's the __static_call_tramp_##tramp variable for?  And
> > > > why is a DECLARE_ macro defining a variable?
> > >
> > > This is the magic needed for objtool to find all the call sites.
> > >
> > > The variable itself isn't needed, but the .discard.static_call_tramps
> > > entry is.  Objtool reads that section to find out which function call
> > > sites are targeted to a static call trampoline.
> >
> > To clarify: objtool reads that section to find out which functions are
> > really static call trampolines.  Then it annotates all the instructions
> > which call/jmp to those trampolines.  Those annotations are then read by
> > the kernel.
> >
> 
> Ah, right, and objtool runs on a per-object basis so it has no other
> way to know what symbols are actually static calls.
> 
> There's another way to skin this cat, though:
> 
> extern typeof(func) __static_call_trampoline_##tramp;
> #define tramp __static_call_trampoline_##tramp
> 
> And objtool could recognize it by name.  But, of course, you can't put
> a #define in a macro.  But maybe there's a way to hack it up with a
> static inline?

Not sure how to do that...

> Anyway, your way is probably fine with a few caveats:
> 
>  - It won't really work if the call comes from a .S file.

Maybe we can have similar macros for asm code.

>  - There should probably be a comment to help de-confuse future people
> like me :)

Done.  I also converted the trampoline to use an indirect jump.  The
latest code is below.  I'm going off the grid this weekend but I can
probably post proper patches next week.

diff --git a/arch/Kconfig b/arch/Kconfig
index 9d329608913e..20ff5624dad7 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -865,6 +865,9 @@ config HAVE_ARCH_PREL32_RELOCATIONS
 	  architectures, and don't require runtime relocation on relocatable
 	  kernels.
 
+config HAVE_ARCH_STATIC_CALL
+	bool
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5136a1281870..1a14c8f87876 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -128,6 +128,7 @@ config X86
 	select HAVE_ARCH_COMPAT_MMAP_BASES	if MMU && COMPAT
 	select HAVE_ARCH_PREL32_RELOCATIONS
 	select HAVE_ARCH_SECCOMP_FILTER
+	select HAVE_ARCH_STATIC_CALL		if X86_64
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static_call.h
new file mode 100644
index 000000000000..50006bcc3352
--- /dev/null
+++ b/arch/x86/include/asm/static_call.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_STATIC_CALL_H
+#define _ASM_STATIC_CALL_H
+
+#ifdef CONFIG_X86_64
+
+#include <linux/frame.h>
+
+void static_call_init(void);
+extern void __static_call_update(void **func_ptr, void *func);
+
+#define STATIC_CALL_PTR(tramp) (__static_call_ptr_##tramp)
+
+/*
+ * In addition to declaring external variables, this macro also spits out some
+ * magic for objtool to read.  The .discard.static_call_tramps section tells
+ * objtool which functions are static call trampolines, so it can then annotate
+ * calls to those functions in the __static_call_table section.
+ */
+#define DECLARE_STATIC_CALL(tramp, func)				\
+	extern typeof(func) tramp;					\
+	extern typeof(func) *STATIC_CALL_PTR(tramp);			\
+	static void __used __section(.discard.static_call_tramps)	\
+		*__static_call_tramp_##tramp = tramp
+
+#define DEFINE_STATIC_CALL(tramp, func)					\
+	DECLARE_STATIC_CALL(tramp, func);				\
+	typeof(func) *STATIC_CALL_PTR(tramp) = func;			\
+	asm(".pushsection .text, \"ax\"				\n"	\
+	    ".align 4						\n"	\
+	    ".globl " #tramp "					\n"	\
+	    ".type " #tramp ", @function			\n"	\
+	    #tramp ":						\n"	\
+	    "jmpq *" __stringify(STATIC_CALL_PTR(tramp)) "(%rip)\n"	\
+	    ".popsection					\n")
+
+#define static_call_update(tramp, func)					\
+({									\
+	/* TODO: validate func type */					\
+	__static_call_update((void **)&STATIC_CALL_PTR(tramp), func);	\
+})
+
+#else /* !CONFIG_X86_64 */
+static inline void static_call_init(void) {}
+#endif
+
+#endif /* _ASM_STATIC_CALL_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 8824d01c0c35..e5d9f3a1e73f 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -62,6 +62,7 @@ obj-y			+= tsc.o tsc_msr.o io_delay.o rtc.o
 obj-y			+= pci-iommu_table.o
 obj-y			+= resource.o
 obj-y			+= irqflags.o
+obj-$(CONFIG_X86_64)	+= static_call.o
 
 obj-y				+= process.o
 obj-y				+= fpu/
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index b4866badb235..447401fc8d65 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -117,6 +117,7 @@
 #include <asm/microcode.h>
 #include <asm/kaslr.h>
 #include <asm/unwind.h>
+#include <asm/static_call.h>
 
 /*
  * max_low_pfn_mapped: highest direct mapped pfn under 4GB
@@ -874,6 +875,7 @@ void __init setup_arch(char **cmdline_p)
 	early_cpu_init();
 	arch_init_ideal_nops();
 	jump_label_init();
+	static_call_init();
 	early_ioremap_init();
 
 	setup_olpc_ofw_pgd();
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
new file mode 100644
index 000000000000..80c0c0de06e7
--- /dev/null
+++ b/arch/x86/kernel/static_call.c
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/init.h>
+#include <linux/static_call.h>
+#include <linux/bug.h>
+#include <linux/smp.h>
+#include <linux/memory.h>
+#include <asm/text-patching.h>
+#include <asm/processor.h>
+
+extern int cmdline_proc_show(void);
+
+/* The static call table is created by objtool */
+struct static_call_entry {
+	s32 insn, func_ptr;
+};
+extern struct static_call_entry __start_static_call_table[],
+			        __stop_static_call_table[];
+
+static int static_call_initialized;
+
+void __init static_call_init(void)
+{
+	struct static_call_entry *entry;
+	unsigned long insn, func_ptr, func;
+	unsigned char insn_opcode;
+	s32 call_dest;
+
+	for (entry = __start_static_call_table;
+	     entry < __stop_static_call_table; entry++) {
+
+		insn = (long)entry->insn + (unsigned long)&entry->insn;
+		func_ptr = (long)entry->func_ptr + (unsigned long)&entry->func_ptr;
+		func = *(unsigned long *)func_ptr;
+
+		/*
+		 * Make sure the original call to be patched is either a call
+		 * or a tail call jump:
+		 */
+		insn_opcode = *(unsigned char *)insn;
+		if (insn_opcode != 0xe8 && insn_opcode != 0xe9) {
+			WARN_ONCE(1, "unexpected static call insn opcode %x at %pS",
+				  insn_opcode, (void *)insn);
+			continue;
+		}
+
+		call_dest = (long)(func) - (long)(insn + 5);
+
+		text_poke_early((void *)(insn + 1), &call_dest, 4);
+	}
+
+	static_call_initialized = 1;
+}
+
+void static_call_bp_handler(void);
+void *bp_handler_func;
+void *bp_handler_continue;
+
+asm(".pushsection .text, \"ax\"						\n"
+    ".globl static_call_bp_handler					\n"
+    ".type static_call_bp_handler, @function				\n"
+    "static_call_bp_handler:						\n"
+    "call *bp_handler_func(%rip)					\n"
+    "jmp *bp_handler_continue(%rip)					\n"
+    ".popsection .text							\n");
+
+void __static_call_update(void **func_ptr, void *func)
+{
+	struct static_call_entry *entry;
+	unsigned long insn, ptr;
+	s32 call_dest;
+	unsigned char opcodes[5];
+
+	/* If called before init, use the trampoline's indirect jump. */
+	if (!static_call_initialized)
+		return;
+
+	*func_ptr = func;
+
+	mutex_lock(&text_mutex);
+
+	for (entry = __start_static_call_table;
+	     entry < __stop_static_call_table; entry++) {
+
+		ptr = (long)entry->func_ptr + (long)&entry->func_ptr;
+		if ((void **)ptr != func_ptr)
+			continue;
+
+		/* Calculate the new call destination: */
+		insn = (long)entry->insn + (unsigned long)&entry->insn;
+		call_dest = (long)(func) - (long)(insn + 5);
+		opcodes[0] = 0xe8;
+		memcpy(&opcodes[1], &call_dest, 4);
+
+		/* Set up the variables for the breakpoint handler: */
+		bp_handler_func = func;
+		bp_handler_continue = (void *)(insn + 5);
+
+		/* Patch the call site: */
+		text_poke_bp((void *)insn, opcodes, 5, static_call_bp_handler);
+	}
+
+	mutex_unlock(&text_mutex);
+}
+
+/*** TEST CODE BELOW -- called from cmdline_proc_show ***/
+
+int my_func_add(int arg1, int arg2)
+{
+	return arg1 + arg2;
+}
+
+int my_func_sub(int arg1, int arg2)
+{
+	return arg1 - arg2;
+}
+
+DEFINE_STATIC_CALL(my_static_call, my_func_add);
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 0d618ee634ac..cf0566f8a13c 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -185,6 +185,9 @@ SECTIONS
 
 	BUG_TABLE
 
+	/* FIXME: move to read-only section */
+	STATIC_CALL_TABLE
+
 	ORC_UNWIND_TABLE
 
 	. = ALIGN(PAGE_SIZE);
diff --git a/fs/proc/cmdline.c b/fs/proc/cmdline.c
index fa762c5fbcb2..c704b9e1fe5f 100644
--- a/fs/proc/cmdline.c
+++ b/fs/proc/cmdline.c
@@ -3,9 +3,27 @@
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/static_call.h>
+
+extern int my_func_add(int arg1, int arg2);
+extern int my_func_sub(int arg1, int arg2);
+DECLARE_STATIC_CALL(my_static_call, my_func_add);
 
 static int cmdline_proc_show(struct seq_file *m, void *v)
 {
+	int ret;
+
+	ret = my_static_call(1, 2);
+	printk("static call (orig): ret=%d\n", ret);
+
+	static_call_update(my_static_call, my_func_sub);
+	ret = my_static_call(1, 2);
+	printk("static call (sub): ret=%d\n", ret);
+
+	static_call_update(my_static_call, my_func_add);
+	ret = my_static_call(1, 2);
+	printk("static call (add): ret=%d\n", ret);
+
 	seq_puts(m, saved_command_line);
 	seq_putc(m, '\n');
 	return 0;
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f09ee3c544bc..a1c7bda1b22a 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -722,6 +722,14 @@
 #define BUG_TABLE
 #endif
 
+#define STATIC_CALL_TABLE						\
+	. = ALIGN(8);							\
+	__static_call_table : AT(ADDR(__static_call_table) - LOAD_OFFSET) { \
+		__start_static_call_table = .;			\
+		KEEP(*(__static_call_table))				\
+		__stop_static_call_table = .;				\
+	}
+
 #ifdef CONFIG_UNWINDER_ORC
 #define ORC_UNWIND_TABLE						\
 	. = ALIGN(4);							\
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
new file mode 100644
index 000000000000..729e7ee4c66b
--- /dev/null
+++ b/include/linux/static_call.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_STATIC_CALL_H
+#define _LINUX_STATIC_CALL_H
+
+#ifdef CONFIG_HAVE_ARCH_STATIC_CALL
+#include <asm/static_call.h>
+#else
+
+#define DECLARE_STATIC_CALL(ptr, func)					\
+	extern typeof(func) *ptr
+
+#define DEFINE_STATIC_CALL(ptr, func)					\
+	typeof(func) *ptr = func
+
+#define static_call_update(ptr, func)					\
+	WRITE_ONCE(ptr, func)
+
+#endif /* !CONFIG_HAVE_ARCH_STATIC_CALL */
+
+#endif /* _LINUX_STATIC_CALL_H */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0414a0d52262..b59770f8ed4b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -525,6 +525,10 @@ static int add_jump_destinations(struct objtool_file *file)
 		} else {
 			/* sibling call */
 			insn->jump_dest = 0;
+			if (rela->sym->static_call_tramp) {
+				list_add_tail(&insn->static_call_node,
+					      &file->static_call_list);
+			}
 			continue;
 		}
 
@@ -1202,6 +1206,21 @@ static int read_retpoline_hints(struct objtool_file *file)
 	return 0;
 }
 
+static int read_static_call_tramps(struct objtool_file *file)
+{
+	struct section *sec;
+	struct rela *rela;
+
+	sec = find_section_by_name(file->elf, ".rela.discard.static_call_tramps");
+	if (!sec)
+		return 0;
+
+	list_for_each_entry(rela, &sec->rela_list, list)
+		rela->sym->static_call_tramp = true;
+
+	return 0;
+}
+
 static void mark_rodata(struct objtool_file *file)
 {
 	struct section *sec;
@@ -1267,6 +1286,10 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	ret = read_static_call_tramps(file);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -1920,6 +1943,11 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 			if (is_fentry_call(insn))
 				break;
 
+			if (insn->call_dest->static_call_tramp) {
+				list_add_tail(&insn->static_call_node,
+					      &file->static_call_list);
+			}
+
 			ret = dead_end_function(file, insn->call_dest);
 			if (ret == 1)
 				return 0;
@@ -2167,6 +2195,99 @@ static int validate_reachable_instructions(struct objtool_file *file)
 	return 0;
 }
 
+struct static_call_entry {
+	s32 insn, func_ptr;
+};
+
+static int create_static_call_sections(struct objtool_file *file)
+{
+	struct section *sec, *rela_sec;
+	struct rela *rela;
+	struct static_call_entry *entry;
+	struct instruction *insn;
+	char func_ptr_name[128];
+	struct symbol *func_ptr;
+	int idx, ret;
+
+	sec = find_section_by_name(file->elf, "__static_call_table");
+	if (sec) {
+		WARN("file already has __static_call_table section, skipping");
+		return -1;
+	}
+
+	if (list_empty(&file->static_call_list))
+		return 0;
+
+	idx = 0;
+	list_for_each_entry(insn, &file->static_call_list, static_call_node)
+		idx++;
+
+	sec = elf_create_section(file->elf, "__static_call_table",
+				 sizeof(struct static_call_entry), idx);
+	if (!sec)
+		return -1;
+
+	rela_sec = elf_create_rela_section(file->elf, sec);
+	if (!rela_sec)
+		return -1;
+
+	idx = 0;
+	list_for_each_entry(insn, &file->static_call_list, static_call_node) {
+
+		entry = (struct static_call_entry *)sec->data->d_buf + idx;
+		memset(entry, 0, sizeof(struct static_call_entry));
+
+		/* populate rela for 'insn' */
+		rela = malloc(sizeof(*rela));
+		if (!rela) {
+			perror("malloc");
+			return -1;
+		}
+		memset(rela, 0, sizeof(*rela));
+		rela->sym = insn->sec->sym;
+		rela->addend = insn->offset;
+		rela->type = R_X86_64_PC32;
+		rela->offset = idx * sizeof(struct static_call_entry);
+		list_add_tail(&rela->list, &rela_sec->rela_list);
+		hash_add(rela_sec->rela_hash, &rela->hash, rela->offset);
+
+		/* find function pointer symbol */
+		ret = snprintf(func_ptr_name, 128, "__static_call_ptr_%s",
+			       insn->call_dest->name);
+		if (ret < 0 || ret >= 128) {
+			WARN("snprintf failed");
+			return -1;
+		}
+
+		func_ptr = find_symbol_by_name(file->elf, func_ptr_name);
+		if (!func_ptr) {
+			WARN("can't find static call ptr symbol: %s", func_ptr_name);
+			return -1;
+		}
+
+		/* populate rela for 'func_ptr' */
+		rela = malloc(sizeof(*rela));
+		if (!rela) {
+			perror("malloc");
+			return -1;
+		}
+		memset(rela, 0, sizeof(*rela));
+		rela->sym = func_ptr;
+		rela->addend = 0;
+		rela->type = R_X86_64_PC32;
+		rela->offset = idx * sizeof(struct static_call_entry) + 4;
+		list_add_tail(&rela->list, &rela_sec->rela_list);
+		hash_add(rela_sec->rela_hash, &rela->hash, rela->offset);
+
+		idx++;
+	}
+
+	if (elf_rebuild_rela_section(rela_sec))
+		return -1;
+
+	return 0;
+}
+
 static void cleanup(struct objtool_file *file)
 {
 	struct instruction *insn, *tmpinsn;
@@ -2197,6 +2318,7 @@ int check(const char *_objname, bool orc)
 
 	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
+	INIT_LIST_HEAD(&file.static_call_list);
 	file.whitelist = find_section_by_name(file.elf, ".discard.func_stack_frame_non_standard");
 	file.c_file = find_section_by_name(file.elf, ".comment");
 	file.ignore_unreachables = no_unreachable;
@@ -2236,6 +2358,11 @@ int check(const char *_objname, bool orc)
 		warnings += ret;
 	}
 
+	ret = create_static_call_sections(&file);
+	if (ret < 0)
+		goto out;
+	warnings += ret;
+
 	if (orc) {
 		ret = create_orc(&file);
 		if (ret < 0)
@@ -2244,7 +2371,9 @@ int check(const char *_objname, bool orc)
 		ret = create_orc_sections(&file);
 		if (ret < 0)
 			goto out;
+	}
 
+	if (orc || !list_empty(&file.static_call_list)) {
 		ret = elf_write(file.elf);
 		if (ret < 0)
 			goto out;
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index e6e8a655b556..56b8b7fb1bd1 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -39,6 +39,7 @@ struct insn_state {
 struct instruction {
 	struct list_head list;
 	struct hlist_node hash;
+	struct list_head static_call_node;
 	struct section *sec;
 	unsigned long offset;
 	unsigned int len;
@@ -60,6 +61,7 @@ struct objtool_file {
 	struct elf *elf;
 	struct list_head insn_list;
 	DECLARE_HASHTABLE(insn_hash, 16);
+	struct list_head static_call_list;
 	struct section *whitelist;
 	bool ignore_unreachables, c_file, hints, rodata;
 };
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index bc97ed86b9cd..3cf44d7cc3ac 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -62,6 +62,7 @@ struct symbol {
 	unsigned long offset;
 	unsigned int len;
 	struct symbol *pfunc, *cfunc;
+	bool static_call_tramp;
 };
 
 struct rela {
