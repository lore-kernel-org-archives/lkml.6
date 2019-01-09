Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7EEC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFE22075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfAIXAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 18:00:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfAIXAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 18:00:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 02DEFAB41F;
        Wed,  9 Jan 2019 23:00:15 +0000 (UTC)
Received: from treble.redhat.com (ovpn-125-32.rdu2.redhat.com [10.10.125.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AEBFA10A185B;
        Wed,  9 Jan 2019 23:00:11 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH v3 6/6] x86/static_call: Add inline static call implementation for x86-64
Date:   Wed,  9 Jan 2019 16:59:41 -0600
Message-Id: <ef6c52901358b818fe831a62eab16f9ee5b3ad37.1547073843.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1547073843.git.jpoimboe@redhat.com>
References: <cover.1547073843.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 09 Jan 2019 23:00:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an inline static call implementation for x86-64.  Use objtool to
detect all the call sites and annotate them in the .static_call_sites
section.

During boot (and module init), the call sites are patched to call the
destination directly rather than the out-of-line trampoline.

To avoid the complexity of emulating a call instruction in
text_poke_bp(), instead just do atomic writes of the call destinations.
Only the call sites whose destinations *don't* cross cache line
boundaries can be safely patched.

The small percentage of sites which happen to cross cache line
boundaries are out of luck -- they will continue to use the out-of-line
trampoline.

The cross-modifying code implementation was suggested by Andy
Lutomirski, thanks to guidance from Linus Torvalds.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/Kconfig                              |   3 +-
 arch/x86/include/asm/static_call.h            |   6 +
 arch/x86/kernel/static_call.c                 |  23 ++-
 scripts/Makefile.build                        |   3 +
 tools/objtool/Makefile                        |   3 +-
 tools/objtool/builtin-check.c                 |   3 +-
 tools/objtool/builtin.h                       |   2 +-
 tools/objtool/check.c                         | 131 +++++++++++++++++-
 tools/objtool/check.h                         |   2 +
 tools/objtool/elf.h                           |   1 +
 .../objtool/include/linux/static_call_types.h |  22 +++
 tools/objtool/sync-check.sh                   |   1 +
 12 files changed, 193 insertions(+), 7 deletions(-)
 create mode 100644 tools/objtool/include/linux/static_call_types.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 421097322f1b..b306c0ca8d92 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -191,6 +191,7 @@ config X86
 	select HAVE_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
 	select HAVE_STACK_VALIDATION		if X86_64
 	select HAVE_STATIC_CALL
+	select HAVE_STATIC_CALL_INLINE		if HAVE_STACK_VALIDATION
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UNSTABLE_SCHED_CLOCK
@@ -205,6 +206,7 @@ config X86
 	select RTC_MC146818_LIB
 	select SPARSE_IRQ
 	select SRCU
+	select STACK_VALIDATION			if HAVE_STACK_VALIDATION && (HAVE_STATIC_CALL_INLINE || RETPOLINE)
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select USER_STACKTRACE_SUPPORT
@@ -440,7 +442,6 @@ config GOLDFISH
 config RETPOLINE
 	bool "Avoid speculative indirect branches in kernel"
 	default y
-	select STACK_VALIDATION if HAVE_STACK_VALIDATION
 	help
 	  Compile kernel with the retpoline compiler options to guard against
 	  kernel-to-user data leaks by avoiding speculative indirect
diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static_call.h
index fab5facade03..3286c2fa83f7 100644
--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -8,6 +8,12 @@
  * This trampoline is used for out-of-line static calls.  It has a direct jump
  * which gets patched by static_call_update().
  *
+ * With CONFIG_HAVE_STATIC_CALL_INLINE enabled, if a call site fits within a
+ * cache line, it gets promoted to an inline static call and the trampoline is
+ * no longer used for that site.  In this case the name of this trampoline has
+ * a magical aspect: objtool uses it to find static call sites so it can create
+ * the .static_call_sites section.
+ *
  * Trampolines are placed in the .static_call.text section to prevent two-byte
  * tail calls to the trampoline and two-byte jumps from the trampoline.
  *
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index e6ef53fbce20..019aafc3c7f9 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -7,19 +7,38 @@
 
 #define CALL_INSN_SIZE 5
 
+static inline bool within_cache_line(void *addr, int len)
+{
+	unsigned long a = (unsigned long)addr;
+
+	return (a >> L1_CACHE_SHIFT) == ((a + len) >> L1_CACHE_SHIFT);
+}
+
 void __ref arch_static_call_transform(void *site, void *tramp, void *func)
 {
 	s32 dest_relative;
 	unsigned char opcode;
 	void *(*poker)(void *, const void *, size_t);
-	void *insn = tramp;
+	void *insn;
 
 	mutex_lock(&text_mutex);
 
 	/*
 	 * For x86-64, a 32-bit cross-modifying write to a call destination is
-	 * safe as long as it's within a cache line.
+	 * safe as long as it's within a cache line.  In the inline case, if
+	 * the call destination is not within a cache line, fall back to using
+	 * the out-of-line trampoline.
+	 *
+	 * We could instead use text_poke_bp() here, which would allow all
+	 * static calls to be promoted to inline, but that would require some
+	 * trickery to fake a call instruction in the BP handler.
 	 */
+	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE) &&
+	    within_cache_line(site + 1, sizeof(dest_relative)))
+		insn = site;
+	else
+		insn = tramp;
+
 	opcode = *(unsigned char *)insn;
 	if (opcode != 0xe8 && opcode != 0xe9) {
 		WARN_ONCE(1, "unexpected static call insn opcode 0x%x at %pS",
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index fd03d60f6c5a..850f444de56f 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -223,6 +223,9 @@ endif
 ifdef CONFIG_RETPOLINE
   objtool_args += --retpoline
 endif
+ifdef CONFIG_HAVE_STATIC_CALL_INLINE
+  objtool_args += --static-call
+endif
 
 # 'OBJECT_FILES_NON_STANDARD := y': skip objtool checking for a directory
 # 'OBJECT_FILES_NON_STANDARD_foo.o := 'y': skip objtool checking for a file
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
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 694abc628e9b..c480f49571d6 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -29,7 +29,7 @@
 #include "builtin.h"
 #include "check.h"
 
-bool no_fp, no_unreachable, retpoline, module;
+bool no_fp, no_unreachable, retpoline, module, static_call;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -41,6 +41,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('u', "no-unreachable", &no_unreachable, "Skip 'unreachable instruction' warnings"),
 	OPT_BOOLEAN('r', "retpoline", &retpoline, "Validate retpoline assumptions"),
 	OPT_BOOLEAN('m', "module", &module, "Indicates the object will be part of a kernel module"),
+	OPT_BOOLEAN('s', "static-call", &static_call, "Create static call table"),
 	OPT_END(),
 };
 
diff --git a/tools/objtool/builtin.h b/tools/objtool/builtin.h
index 28ff40e19a14..7b59163a293e 100644
--- a/tools/objtool/builtin.h
+++ b/tools/objtool/builtin.h
@@ -20,7 +20,7 @@
 #include <subcmd/parse-options.h>
 
 extern const struct option check_options[];
-extern bool no_fp, no_unreachable, retpoline, module;
+extern bool no_fp, no_unreachable, retpoline, module, static_call;
 
 extern int cmd_check(int argc, const char **argv);
 extern int cmd_orc(int argc, const char **argv);
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0414a0d52262..c3de329f22f0 100644
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
 
@@ -1202,6 +1208,26 @@ static int read_retpoline_hints(struct objtool_file *file)
 	return 0;
 }
 
+static int read_static_call_tramps(struct objtool_file *file)
+{
+	struct section *sec;
+	struct symbol *func;
+
+	if (!static_call)
+		return 0;
+
+	for_each_sec(file, sec) {
+		list_for_each_entry(func, &sec->symbol_list, list) {
+			if (func->bind == STB_GLOBAL &&
+			    !strncmp(func->name, STATIC_CALL_TRAMP_PREFIX_STR,
+				     strlen(STATIC_CALL_TRAMP_PREFIX_STR)))
+				func->static_call_tramp = true;
+		}
+	}
+
+	return 0;
+}
+
 static void mark_rodata(struct objtool_file *file)
 {
 	struct section *sec;
@@ -1267,6 +1293,10 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	ret = read_static_call_tramps(file);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -1920,6 +1950,11 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
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
@@ -2167,6 +2202,92 @@ static int validate_reachable_instructions(struct objtool_file *file)
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
+	if (!static_call)
+		return 0;
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
@@ -2191,12 +2312,13 @@ int check(const char *_objname, bool orc)
 
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
diff --git a/tools/objtool/include/linux/static_call_types.h b/tools/objtool/include/linux/static_call_types.h
new file mode 100644
index 000000000000..09b0a1db7a51
--- /dev/null
+++ b/tools/objtool/include/linux/static_call_types.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _STATIC_CALL_TYPES_H
+#define _STATIC_CALL_TYPES_H
+
+#include <linux/stringify.h>
+
+#define STATIC_CALL_TRAMP_PREFIX ____static_call_tramp_
+#define STATIC_CALL_TRAMP_PREFIX_STR __stringify(STATIC_CALL_TRAMP_PREFIX)
+
+#define STATIC_CALL_TRAMP(key) __PASTE(STATIC_CALL_TRAMP_PREFIX, key)
+#define STATIC_CALL_TRAMP_STR(key) __stringify(STATIC_CALL_TRAMP(key))
+
+/*
+ * The static call site table needs to be created by external tooling (objtool
+ * or a compiler plugin).
+ */
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

