Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E614DECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10AD20818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10AD20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeKIGzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:55:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbeKIGzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:55:23 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4BDCFC06021F;
        Thu,  8 Nov 2018 21:18:04 +0000 (UTC)
Received: from treble.redhat.com (ovpn-124-61.rdu2.redhat.com [10.10.124.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD6DA68B16;
        Thu,  8 Nov 2018 21:18:02 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>
Subject: [RFC PATCH 3/3] x86/static_call: Add optimized static call implementation for 64-bit
Date:   Thu,  8 Nov 2018 15:15:53 -0600
Message-Id: <41741f0d3a54003881c19a6fff5110f98dbf86cd.1541711457.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1541711457.git.jpoimboe@redhat.com>
References: <cover.1541711457.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 08 Nov 2018 21:18:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the optimized static call implementation for x86-64.  For each key,
a temporary trampoline is created, named __static_call_tramp_<key>.  The
trampoline has an indirect jump to the destination function.

Objtool uses the trampoline naming convention to detect all the call
sites.  It then annotates those call sites in the .static_call_sites
section.

During boot (and module init), the call sites are patched to call
directly into the destination function.  The temporary trampoline is
then no longer used.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/Kconfig                              |   5 +-
 arch/x86/include/asm/static_call.h            |  24 ++++
 arch/x86/kernel/static_call.c                 |  35 ++++-
 tools/objtool/Makefile                        |   3 +-
 tools/objtool/check.c                         | 126 +++++++++++++++++-
 tools/objtool/check.h                         |   2 +
 tools/objtool/elf.h                           |   1 +
 .../objtool/include/linux/static_call_types.h |  19 +++
 tools/objtool/sync-check.sh                   |   1 +
 9 files changed, 211 insertions(+), 5 deletions(-)
 create mode 100644 tools/objtool/include/linux/static_call_types.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9a83c3edd839..1d9b0e06b3b0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -189,7 +189,8 @@ config X86
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
 	select HAVE_STACK_VALIDATION		if X86_64
-	select HAVE_STATIC_CALL_UNOPTIMIZED
+	select HAVE_STATIC_CALL_OPTIMIZED	if HAVE_STACK_VALIDATION
+	select HAVE_STATIC_CALL_UNOPTIMIZED	if !HAVE_STACK_VALIDATION
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UNSTABLE_SCHED_CLOCK
@@ -203,6 +204,7 @@ config X86
 	select RTC_MC146818_LIB
 	select SPARSE_IRQ
 	select SRCU
+	select STACK_VALIDATION			if HAVE_STACK_VALIDATION && (HAVE_STATIC_CALL_OPTIMIZED || RETPOLINE)
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select USER_STACKTRACE_SUPPORT
@@ -438,7 +440,6 @@ config GOLDFISH
 config RETPOLINE
 	bool "Avoid speculative indirect branches in kernel"
 	default y
-	select STACK_VALIDATION if HAVE_STACK_VALIDATION
 	help
 	  Compile kernel with the retpoline compiler options to guard against
 	  kernel-to-user data leaks by avoiding speculative indirect
diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static_call.h
index de6b032cf809..d3b40c34a00f 100644
--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -2,6 +2,27 @@
 #ifndef _ASM_STATIC_CALL_H
 #define _ASM_STATIC_CALL_H
 
+#ifdef CONFIG_HAVE_STATIC_CALL_OPTIMIZED
+/*
+ * This is a temporary trampoline which is only used during boot (before the
+ * call sites have been patched).  It uses the current value of the key->func
+ * pointer to do an indirect jump to the function.
+ *
+ * The name of this function has a magical aspect.  Objtool uses it to find
+ * static call sites so that it can create the .static_call_sites section.
+ */
+#define ARCH_STATIC_CALL_TEMPORARY_TRAMP(key)				\
+	asm(".pushsection .text, \"ax\"				\n"	\
+	    ".align 4						\n"	\
+	    ".globl " STATIC_CALL_TRAMP_STR(key) "		\n"	\
+	    ".type " STATIC_CALL_TRAMP_STR(key) ", @function	\n"	\
+	    STATIC_CALL_TRAMP_STR(key) ":			\n"	\
+	    ANNOTATE_RETPOLINE_SAFE "				\n"	\
+	    "jmpq *" __stringify(key) "(%rip)			\n"	\
+	    ".popsection					\n")
+
+#else /* !CONFIG_HAVE_STATIC_CALL_OPTIMIZED */
+
 /*
  * This is a permanent trampoline which is the destination for all static calls
  * for the given key.  The direct jump gets patched by static_call_update().
@@ -15,4 +36,7 @@
 	    "jmp " #func "					\n"	\
 	    ".popsection					\n")
 
+
+#endif /* !CONFIG_HAVE_STATIC_CALL_OPTIMIZED */
+
 #endif /* _ASM_STATIC_CALL_H */
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 47ddc655ccda..f3176a7ea6d9 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -10,6 +10,22 @@
 void static_call_bp_handler(void);
 void *bp_handler_dest;
 
+#ifdef CONFIG_HAVE_STATIC_CALL_OPTIMIZED
+
+void *bp_handler_continue;
+
+asm(".pushsection .text, \"ax\"						\n"
+    ".globl static_call_bp_handler					\n"
+    ".type static_call_bp_handler, @function				\n"
+    "static_call_bp_handler:						\n"
+    "ANNOTATE_RETPOLINE_SAFE						\n"
+    "call *bp_handler_dest						\n"
+    "ANNOTATE_RETPOLINE_SAFE						\n"
+    "jmp *bp_handler_continue						\n"
+    ".popsection							\n");
+
+#else /* !CONFIG_HAVE_STATIC_CALL_OPTIMIZED */
+
 asm(".pushsection .text, \"ax\"						\n"
     ".globl static_call_bp_handler					\n"
     ".type static_call_bp_handler, @function				\n"
@@ -18,6 +34,8 @@ asm(".pushsection .text, \"ax\"						\n"
     "jmp *bp_handler_dest						\n"
     ".popsection							\n");
 
+#endif /* !CONFIG_HAVE_STATIC_CALL_OPTIMIZED */
+
 void arch_static_call_transform(unsigned long insn, void *dest)
 {
 	s32 dest_relative;
@@ -38,8 +56,11 @@ void arch_static_call_transform(unsigned long insn, void *dest)
 	opcodes[0] = insn_opcode;
 	memcpy(&opcodes[1], &dest_relative, CALL_INSN_SIZE - 1);
 
-	/* Set up the variable for the breakpoint handler: */
+	/* Set up the variables for the breakpoint handler: */
 	bp_handler_dest = dest;
+#ifdef CONFIG_HAVE_STATIC_CALL_OPTIMIZED
+	bp_handler_continue = (void *)(insn + CALL_INSN_SIZE);
+#endif
 
 	/* Patch the call site: */
 	text_poke_bp((void *)insn, opcodes, CALL_INSN_SIZE,
@@ -49,3 +70,15 @@ void arch_static_call_transform(unsigned long insn, void *dest)
 	mutex_unlock(&text_mutex);
 }
 EXPORT_SYMBOL_GPL(arch_static_call_transform);
+
+#ifdef CONFIG_HAVE_STATIC_CALL_OPTIMIZED
+void arch_static_call_poison_tramp(unsigned long insn)
+{
+	unsigned long tramp = insn + CALL_INSN_SIZE + *(s32 *)(insn + 1);
+	unsigned short opcode = INSN_UD2;
+
+	mutex_lock(&text_mutex);
+	text_poke((void *)tramp, &opcode, 2);
+	mutex_unlock(&text_mutex);
+}
+#endif
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index c9d038f91af6..fb1afa34f10d 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -29,7 +29,8 @@ all: $(OBJTOOL)
 
 INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
-	    -I$(srctree)/tools/objtool/arch/$(ARCH)/include
+	    -I$(srctree)/tools/objtool/arch/$(ARCH)/include \
+	    -I$(srctree)/tools/objtool/include
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
 CFLAGS   += -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES)
 LDFLAGS  += -lelf $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0414a0d52262..ea1ff9ea2d78 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -27,6 +27,7 @@
 
 #include <linux/hashtable.h>
 #include <linux/kernel.h>
+#include <linux/static_call_types.h>
 
 struct alternative {
 	struct list_head list;
@@ -165,6 +166,7 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"fortify_panic",
 		"usercopy_abort",
 		"machine_real_restart",
+		"rewind_stack_do_exit",
 	};
 
 	if (func->bind == STB_WEAK)
@@ -525,6 +527,10 @@ static int add_jump_destinations(struct objtool_file *file)
 		} else {
 			/* sibling call */
 			insn->jump_dest = 0;
+			if (rela->sym->static_call_tramp) {
+				list_add_tail(&insn->static_call_node,
+					      &file->static_call_list);
+			}
 			continue;
 		}
 
@@ -1202,6 +1208,24 @@ static int read_retpoline_hints(struct objtool_file *file)
 	return 0;
 }
 
+static int read_static_call_tramps(struct objtool_file *file)
+{
+	struct section *sec;
+	struct symbol *func;
+
+	for_each_sec(file, sec) {
+		list_for_each_entry(func, &sec->symbol_list, list) {
+			if (func->bind == STB_GLOBAL &&
+			    !strncmp(func->name, STATIC_CALL_TRAMP_PREFIX_STR,
+				     strlen(STATIC_CALL_TRAMP_PREFIX_STR)))
+				func->static_call_tramp = true;
+		}
+
+	}
+
+	return 0;
+}
+
 static void mark_rodata(struct objtool_file *file)
 {
 	struct section *sec;
@@ -1267,6 +1291,10 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	ret = read_static_call_tramps(file);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -1920,6 +1948,11 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
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
@@ -2167,6 +2200,89 @@ static int validate_reachable_instructions(struct objtool_file *file)
 	return 0;
 }
 
+static int create_static_call_sections(struct objtool_file *file)
+{
+	struct section *sec, *rela_sec;
+	struct rela *rela;
+	struct static_call_site *site;
+	struct instruction *insn;
+	char *key_name;
+	struct symbol *key_sym;
+	int idx;
+
+	sec = find_section_by_name(file->elf, ".static_call_sites");
+	if (sec) {
+		WARN("file already has .static_call_sites section, skipping");
+		return 0;
+	}
+
+	if (list_empty(&file->static_call_list))
+		return 0;
+
+	idx = 0;
+	list_for_each_entry(insn, &file->static_call_list, static_call_node)
+		idx++;
+
+	sec = elf_create_section(file->elf, ".static_call_sites",
+				 sizeof(struct static_call_site), idx);
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
+		site = (struct static_call_site *)sec->data->d_buf + idx;
+		memset(site, 0, sizeof(struct static_call_site));
+
+		/* populate rela for 'addr' */
+		rela = malloc(sizeof(*rela));
+		if (!rela) {
+			perror("malloc");
+			return -1;
+		}
+		memset(rela, 0, sizeof(*rela));
+		rela->sym = insn->sec->sym;
+		rela->addend = insn->offset;
+		rela->type = R_X86_64_PC32;
+		rela->offset = idx * sizeof(struct static_call_site);
+		list_add_tail(&rela->list, &rela_sec->rela_list);
+		hash_add(rela_sec->rela_hash, &rela->hash, rela->offset);
+
+		/* find key symbol */
+		key_name = insn->call_dest->name + strlen(STATIC_CALL_TRAMP_PREFIX_STR);
+		key_sym = find_symbol_by_name(file->elf, key_name);
+		if (!key_sym) {
+			WARN("can't find static call key symbol: %s", key_name);
+			return -1;
+		}
+
+		/* populate rela for 'key' */
+		rela = malloc(sizeof(*rela));
+		if (!rela) {
+			perror("malloc");
+			return -1;
+		}
+		memset(rela, 0, sizeof(*rela));
+		rela->sym = key_sym;
+		rela->addend = 0;
+		rela->type = R_X86_64_PC32;
+		rela->offset = idx * sizeof(struct static_call_site) + 4;
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
@@ -2191,12 +2307,13 @@ int check(const char *_objname, bool orc)
 
 	objname = _objname;
 
-	file.elf = elf_open(objname, orc ? O_RDWR : O_RDONLY);
+	file.elf = elf_open(objname, O_RDWR);
 	if (!file.elf)
 		return 1;
 
 	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
+	INIT_LIST_HEAD(&file.static_call_list);
 	file.whitelist = find_section_by_name(file.elf, ".discard.func_stack_frame_non_standard");
 	file.c_file = find_section_by_name(file.elf, ".comment");
 	file.ignore_unreachables = no_unreachable;
@@ -2236,6 +2353,11 @@ int check(const char *_objname, bool orc)
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
@@ -2244,7 +2366,9 @@ int check(const char *_objname, bool orc)
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
diff --git a/tools/objtool/include/linux/static_call_types.h b/tools/objtool/include/linux/static_call_types.h
new file mode 100644
index 000000000000..7dd4b3d7ec2b
--- /dev/null
+++ b/tools/objtool/include/linux/static_call_types.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _STATIC_CALL_TYPES_H
+#define _STATIC_CALL_TYPES_H
+
+#include <linux/stringify.h>
+
+#define STATIC_CALL_TRAMP_PREFIX ____static_call_tramp_
+#define STATIC_CALL_TRAMP_PREFIX_STR __stringify(STATIC_CALL_TRAMP_PREFIX)
+
+#define STATIC_CALL_TRAMP(key) STATIC_CALL_TRAMP_PREFIX##key
+#define STATIC_CALL_TRAMP_STR(key) __stringify(STATIC_CALL_TRAMP(key))
+
+/* The static call site table is created by objtool. */
+struct static_call_site {
+	s32 addr;
+	s32 key;
+};
+
+#endif /* _STATIC_CALL_TYPES_H */
diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index 1470e74e9d66..e1a204bf3556 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -10,6 +10,7 @@ arch/x86/include/asm/insn.h
 arch/x86/include/asm/inat.h
 arch/x86/include/asm/inat_types.h
 arch/x86/include/asm/orc_types.h
+include/linux/static_call_types.h
 '
 
 check()
-- 
2.17.2

