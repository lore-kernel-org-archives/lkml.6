Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC4AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2642086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2642086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeJKBPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 21:15:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47476 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeJKBPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 21:15:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5FCB0307C718;
        Wed, 10 Oct 2018 17:52:41 +0000 (UTC)
Received: from treble (ovpn-124-83.rdu2.redhat.com [10.10.124.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 097D37FD49;
        Wed, 10 Oct 2018 17:52:38 +0000 (UTC)
Date:   Wed, 10 Oct 2018 12:52:37 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Helsley <mhelsley@vmware.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        ard.biesheuvel@linaro.org, Andy Lutomirski <luto@kernel.org>
Subject: Re: [POC][RFC][PATCH 1/2] jump_function: Addition of new feature
 "jump_function"
Message-ID: <20181010175237.e7m3sldcu2maoqcq@treble>
References: <20181006015110.653946300@goodmis.org>
 <20181006015720.634688468@goodmis.org>
 <20181006121211.GA5663@hirez.programming.kicks-ass.net>
 <20181006093905.46276505@vmware.local.home>
 <20181008072134.GB5663@hirez.programming.kicks-ass.net>
 <A9379DDB-3210-407C-8157-8DA980944F8C@amacapital.net>
 <20181008155757.GC5663@hirez.programming.kicks-ass.net>
 <F36C6419-7D92-4357-BDB1-D8B90DE09889@amacapital.net>
 <20181009021710.qwt5hpntyeps44h3@treble>
 <20181008235750.59da83ae@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181008235750.59da83ae@gandalf.local.home>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 10 Oct 2018 17:52:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 11:57:50PM -0400, Steven Rostedt wrote:
> On Mon, 8 Oct 2018 21:17:10 -0500
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > I'm not really convinced we need objtool for this, maybe I'll try
> > whipping up a POC.
> 
> Awesome!
> 
> I wasn't thinking of actually having objtool itself perform this task,
> but instead breaking the internals of objtool up into more of a generic
> infrastructure, that recordmcount.c, objtool, and whatever this does
> can use.

So I had been thinking that we could find the call sites at runtime, by
looking at the relocations.  But I managed to forget that vmlinux
relocations are resolved during linking.  So yeah, some kind of tooling
magic would be needed.

I worked up a POC using objtool.  It doesn't *have* to be done with
objtool, but since it's already reading/writing all the ELF stuff
anyway, it was pretty easy to add this on.

This patch has at least a few issues:

- No module support.

- For some reason, the sync_cores in text_poke_bp() don't always seem to
  be working as expected.  Running this patch on my VM, the test code in
  cmdline_proc_show() works *most* of the time, but it occasionally
  branches off into the weeds.  I have no idea what the problem is yet.

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
index 000000000000..40fec631b760
--- /dev/null
+++ b/arch/x86/include/asm/static_call.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_STATIC_CALL_H
+#define _ASM_STATIC_CALL_H
+
+#ifdef CONFIG_X86_64
+
+#include <linux/frame.h>
+
+void static_call_init(void);
+extern void __static_call_update(void *tramp, void *func);
+
+#define DECLARE_STATIC_CALL(tramp, func)				\
+	extern typeof(func) tramp;					\
+	static void __used __section(.discard.static_call_tramps)	\
+		*__static_call_tramp_##tramp = tramp
+
+#define DEFINE_STATIC_CALL(tramp, func)					\
+	DECLARE_STATIC_CALL(tramp, func);				\
+	asm(".pushsection .text, \"ax\"				\n"	\
+	    ".align 4						\n"	\
+	    ".globl " #tramp "					\n"	\
+	    ".type " #tramp ", @function			\n"	\
+	    #tramp ":						\n"	\
+	    "jmp " #func "					\n"	\
+	    ASM_NOP3 "						\n"	\
+	    ".popsection					\n")
+
+#define static_call_update(tramp, func)					\
+	__static_call_update(tramp, func)
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
index 000000000000..e7a17ee6942d
--- /dev/null
+++ b/arch/x86/kernel/static_call.c
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/init.h>
+#include <linux/static_call.h>
+#include <linux/printk.h>
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
+	s32 insn, tramp;
+};
+extern struct static_call_entry __start_static_call_table[],
+			        __stop_static_call_table[];
+
+void __init static_call_init(void)
+{
+	struct static_call_entry *entry;
+	unsigned long insn, tramp, func;
+	unsigned char insn_opcode, tramp_opcode;
+	s32 call_dest;
+
+	for (entry = __start_static_call_table;
+	     entry < __stop_static_call_table; entry++) {
+
+		insn = (long)entry->insn + (unsigned long)&entry->insn;
+		tramp = (long)entry->tramp + (unsigned long)&entry->tramp;
+
+		insn_opcode = *(unsigned char *)insn;
+		if (insn_opcode != 0xe8 && insn_opcode != 0xe9) {
+			WARN_ONCE(1, "unexpected static call insn opcode %x at %pS",
+				  insn_opcode, (void *)insn);
+			continue;
+		}
+
+		tramp_opcode = *(unsigned char *)tramp;
+		if (tramp_opcode != 0xeb && tramp_opcode != 0xe9) {
+			WARN_ONCE(1, "unexpected trampoline jump opcode %x at %ps",
+				 tramp_opcode, (void *)tramp);
+			continue;
+		}
+
+		if (tramp_opcode == 0xeb)
+			func = *(s8 *)(tramp + 1) + (tramp + 2);
+		else
+			func = *(s32 *)(tramp + 1) + (tramp + 5);
+
+		call_dest = (long)(func) - (long)(insn + 5);
+
+		printk("static_call_init: poking %lx at %lx\n", (unsigned long)call_dest, (insn+1));
+
+		text_poke_early((void *)(insn + 1), &call_dest, 4);
+	}
+}
+
+/* cribbed from arch/x86/kernel/alternative.c */
+static void do_sync_core(void *info)
+{
+	sync_core();
+}
+
+void __static_call_update(void *tramp, void *func)
+{
+	struct static_call_entry *entry;
+	unsigned long insn, t;
+	s32 call_dest;
+	unsigned char opcodes[5];
+
+	mutex_lock(&text_mutex);
+
+	/*
+	 * Reuse the (now unused) trampoline to be the fallback handler
+	 * for text_poke_bp():
+	 */
+	call_dest = (long)(func) - (long)(tramp + 5);
+	opcodes[0] = 0xe8;
+	memcpy(&opcodes[1], &call_dest, 4);
+	text_poke(tramp, opcodes, 5);
+	on_each_cpu(do_sync_core, NULL, 1);
+
+	/* Patch the call sites: */
+	for (entry = __start_static_call_table;
+	     entry < __stop_static_call_table; entry++) {
+
+		t = (long)entry->tramp + (unsigned long)&entry->tramp;
+		if ((void *)t != tramp)
+			continue;
+
+		insn = (long)entry->insn + (unsigned long)&entry->insn;
+		call_dest = (long)(func) - (long)(insn + 5);
+		opcodes[0] = 0xe8;
+		memcpy(&opcodes[1], &call_dest, 4);
+
+		text_poke_bp((void *)insn, opcodes, 5, tramp);
+	}
+
+	mutex_unlock(&text_mutex);
+}
+
+/*** TEST CODE BELOW - called from cmdline_proc_show() ***/
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
index 0414a0d52262..a8e7d3b92513 100644
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
@@ -2167,6 +2195,83 @@ static int validate_reachable_instructions(struct objtool_file *file)
 	return 0;
 }
 
+struct static_call_entry {
+	s32 insn, tramp;
+};
+
+static int create_static_call_sections(struct objtool_file *file)
+{
+	struct section *sec, *rela_sec;
+	struct rela *rela;
+	struct static_call_entry *entry;
+	struct instruction *insn;
+	int idx;
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
+		/* populate rela for 'tramp' */
+		rela = malloc(sizeof(*rela));
+		if (!rela) {
+			perror("malloc");
+			return -1;
+		}
+		memset(rela, 0, sizeof(*rela));
+		rela->sym = insn->call_dest;
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
@@ -2197,6 +2302,7 @@ int check(const char *_objname, bool orc)
 
 	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
+	INIT_LIST_HEAD(&file.static_call_list);
 	file.whitelist = find_section_by_name(file.elf, ".discard.func_stack_frame_non_standard");
 	file.c_file = find_section_by_name(file.elf, ".comment");
 	file.ignore_unreachables = no_unreachable;
@@ -2236,6 +2342,11 @@ int check(const char *_objname, bool orc)
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
@@ -2244,7 +2355,9 @@ int check(const char *_objname, bool orc)
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
