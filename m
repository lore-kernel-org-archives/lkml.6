Return-Path: <jpoimboe@redhat.com>
X-Google-Smtp-Source: AB8JxZoMC15MyspwpVufpSAExUVq1j4TQfNr0I5Raeam4AQnXQbdudmfAb094lMFeWfAuVCHvL4q
ARC-Seal: i=1; a=rsa-sha256; t=1525923581; cv=none;
        d=google.com; s=arc-20160816;
        b=rnX+vNOXQup6LkECqGkgBDUG+84x7a06sqgHehLBZG5sXNavHa+tCJcjWUSGT7li/M
         3i6ib2IQAwu7wZRg7RfEz87Ww5sFBP5S9m3aw38oigPcw3SefZKqt5+++6lWAYpzB482
         Dlqn8U7SCDInheowA9UYI5li52gEG7LRFl5OHywIV2J3WhU9GMU5D+IIKvqEHO3CuA/R
         94RQqOOOJ+rrR3xkiTGNIbXnwaqwoAYunrDJQ53cytqwNZb/Q1vVtZUab8I3Af2fGGoG
         pd99+5S/ub9HtG85QYePFdyMh7Q+AWlj+wcrWEmPRgYBYtfxJbqJlaY/LYEU4Gn531/K
         iSUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=EpbCP6KrfjbUhIR6mUZ6Ht4ryRmwzOww+MhbA2StVJU=;
        b=ibYuZERWskII4mgjJDyKG63DoIWxyh4pqL5ZJFKn6gj9T7WMHgyBitqWDGCRbIT3KK
         Fd/08l6T+ng/3rzm3SfHBgZ3modxRr4DGaoecj8DPqfmk8v1dpElyJCBG/LmOoMCgpWM
         QHAc4O/W+QBl1OpKF8qnmi4la0B3BrNFNDtES7gUUv5ac4iyi/htMjDagVMFJCuenEqC
         3FDYsJlqFBvz7pdi02IXA/yTvvRDNfJBqBqI7elnXeqxNHUUQHGe9beKwq9HHepmzZs6
         O5UDGzSIleP3U5dmdiY8ZmnoAROz3RCFHl3T4sJ5KbuIvAsiKtgOEOVqbDVmLUtVq5Z9
         OHwA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Laight <David.Laight@ACULAB.COM>,
	damian <damian.tometzki@icloud.com>
Subject: [PATCH 2/3] objtool: Support GCC 8 cold subfunctions
Date: Wed,  9 May 2018 22:39:15 -0500
Message-Id: <0965e7fcfc5f31a276f0c7f298ff770c19b68706.1525923412.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1525923412.git.jpoimboe@redhat.com>
References: <cover.1525923412.git.jpoimboe@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600046845519592907?=
X-GMAIL-MSGID: =?utf-8?q?1600046845519592907?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

GCC 8 moves a lot of unlikely code out of line to "cold" subfunctions in
.text.unlikely.  Properly detect the new subfunctions and treat them as
extensions of the original functions.

This fixes a bunch of warnings like:

  kernel/cgroup/cgroup.o: warning: objtool: parse_cgroup_root_flags()+0x33: sibling call from callable instruction with modified stack frame
  kernel/cgroup/cgroup.o: warning: objtool: cgroup_addrm_files()+0x290: sibling call from callable instruction with modified stack frame
  kernel/cgroup/cgroup.o: warning: objtool: cgroup_apply_control_enable()+0x25b: sibling call from callable instruction with modified stack frame
  kernel/cgroup/cgroup.o: warning: objtool: rebind_subsystems()+0x325: sibling call from callable instruction with modified stack frame

Reported-by: Arnd Bergmann <arnd@arndb.de>
Reported-and-tested-by: damian <damian.tometzki@icloud.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 93 ++++++++++++++++++++++++-------------------
 tools/objtool/elf.c   | 42 ++++++++++++++++++-
 tools/objtool/elf.h   |  2 +
 3 files changed, 93 insertions(+), 44 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 264522d4e4af..14daf6a27d9f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -59,6 +59,31 @@ static struct instruction *next_insn_same_sec(struct objtool_file *file,
 	return next;
 }
 
+static struct instruction *next_insn_same_func(struct objtool_file *file,
+					       struct instruction *insn)
+{
+	struct instruction *next = list_next_entry(insn, list);
+	struct symbol *func = insn->func;
+
+	if (!func)
+		return NULL;
+
+	if (&next->list != &file->insn_list && next->func == func)
+		return next;
+
+	/* Check if we're already in the subfunction: */
+	if (func == func->cfunc)
+		return NULL;
+
+	/* Move to the subfunction: */
+	return find_insn(file, func->cfunc->sec, func->cfunc->offset);
+}
+
+#define func_for_each_insn_all(file, func, insn)			\
+	for (insn = find_insn(file, func->sec, func->offset);		\
+	     insn;							\
+	     insn = next_insn_same_func(file, insn))
+
 #define func_for_each_insn(file, func, insn)				\
 	for (insn = find_insn(file, func->sec, func->offset);		\
 	     insn && &insn->list != &file->insn_list &&			\
@@ -149,10 +174,14 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 			if (!strcmp(func->name, global_noreturns[i]))
 				return 1;
 
-	if (!func->sec)
+	if (!func->len)
 		return 0;
 
-	func_for_each_insn(file, func, insn) {
+	insn = find_insn(file, func->sec, func->offset);
+	if (!insn->func)
+		return 0;
+
+	func_for_each_insn_all(file, func, insn) {
 		empty = false;
 
 		if (insn->type == INSN_RETURN)
@@ -167,28 +196,17 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 	 * case, the function's dead-end status depends on whether the target
 	 * of the sibling call returns.
 	 */
-	func_for_each_insn(file, func, insn) {
-		if (insn->sec != func->sec ||
-		    insn->offset >= func->offset + func->len)
-			break;
-
+	func_for_each_insn_all(file, func, insn) {
 		if (insn->type == INSN_JUMP_UNCONDITIONAL) {
 			struct instruction *dest = insn->jump_dest;
-			struct symbol *dest_func;
 
 			if (!dest)
 				/* sibling call to another file */
 				return 0;
 
-			if (dest->sec != func->sec ||
-			    dest->offset < func->offset ||
-			    dest->offset >= func->offset + func->len) {
-				/* local sibling call */
-				dest_func = find_symbol_by_offset(dest->sec,
-								  dest->offset);
-				if (!dest_func)
-					continue;
+			if (dest->func && dest->func->pfunc != insn->func->pfunc) {
 
+				/* local sibling call */
 				if (recursion == 5) {
 					/*
 					 * Infinite recursion: two functions
@@ -199,7 +217,7 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 					return 0;
 				}
 
-				return __dead_end_function(file, dest_func,
+				return __dead_end_function(file, dest->func,
 							   recursion + 1);
 			}
 		}
@@ -426,7 +444,7 @@ static void add_ignores(struct objtool_file *file)
 			if (!ignore_func(file, func))
 				continue;
 
-			func_for_each_insn(file, func, insn)
+			func_for_each_insn_all(file, func, insn)
 				insn->ignore = true;
 		}
 	}
@@ -786,9 +804,8 @@ static int add_special_section_alts(struct objtool_file *file)
 	return ret;
 }
 
-static int add_switch_table(struct objtool_file *file, struct symbol *func,
-			    struct instruction *insn, struct rela *table,
-			    struct rela *next_table)
+static int add_switch_table(struct objtool_file *file, struct instruction *insn,
+			    struct rela *table, struct rela *next_table)
 {
 	struct rela *rela = table;
 	struct instruction *alt_insn;
@@ -798,18 +815,13 @@ static int add_switch_table(struct objtool_file *file, struct symbol *func,
 		if (rela == next_table)
 			break;
 
-		if (rela->sym->sec != insn->sec ||
-		    rela->addend <= func->offset ||
-		    rela->addend >= func->offset + func->len)
+		alt_insn = find_insn(file, rela->sym->sec, rela->addend);
+		if (!alt_insn)
 			break;
 
-		alt_insn = find_insn(file, insn->sec, rela->addend);
-		if (!alt_insn) {
-			WARN("%s: can't find instruction at %s+0x%x",
-			     file->rodata->rela->name, insn->sec->name,
-			     rela->addend);
-			return -1;
-		}
+		/* Make sure the jmp dest is in the function or subfunction: */
+		if (alt_insn->func->pfunc != insn->func->pfunc)
+			break;
 
 		alt = malloc(sizeof(*alt));
 		if (!alt) {
@@ -947,7 +959,7 @@ static int add_func_switch_tables(struct objtool_file *file,
 	struct rela *rela, *prev_rela = NULL;
 	int ret;
 
-	func_for_each_insn(file, func, insn) {
+	func_for_each_insn_all(file, func, insn) {
 		if (!last)
 			last = insn;
 
@@ -978,8 +990,7 @@ static int add_func_switch_tables(struct objtool_file *file,
 		 * the beginning of another switch table in the same function.
 		 */
 		if (prev_jump) {
-			ret = add_switch_table(file, func, prev_jump, prev_rela,
-					       rela);
+			ret = add_switch_table(file, prev_jump, prev_rela, rela);
 			if (ret)
 				return ret;
 		}
@@ -989,7 +1000,7 @@ static int add_func_switch_tables(struct objtool_file *file,
 	}
 
 	if (prev_jump) {
-		ret = add_switch_table(file, func, prev_jump, prev_rela, NULL);
+		ret = add_switch_table(file, prev_jump, prev_rela, NULL);
 		if (ret)
 			return ret;
 	}
@@ -1753,15 +1764,13 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 	while (1) {
 		next_insn = next_insn_same_sec(file, insn);
 
-
-		if (file->c_file && func && insn->func && func != insn->func) {
+		if (file->c_file && func && insn->func && func != insn->func->pfunc) {
 			WARN("%s() falls through to next function %s()",
 			     func->name, insn->func->name);
 			return 1;
 		}
 
-		if (insn->func)
-			func = insn->func;
+		func = insn->func ? insn->func->pfunc : NULL;
 
 		if (func && insn->ignore) {
 			WARN_FUNC("BUG: why am I validating an ignored function?",
@@ -1782,7 +1791,7 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 
 				i = insn;
 				save_insn = NULL;
-				func_for_each_insn_continue_reverse(file, func, i) {
+				func_for_each_insn_continue_reverse(file, insn->func, i) {
 					if (i->save) {
 						save_insn = i;
 						break;
@@ -1869,7 +1878,7 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 		case INSN_JUMP_UNCONDITIONAL:
 			if (insn->jump_dest &&
 			    (!func || !insn->jump_dest->func ||
-			     func == insn->jump_dest->func)) {
+			     insn->jump_dest->func->pfunc == func)) {
 				ret = validate_branch(file, insn->jump_dest,
 						      state);
 				if (ret)
@@ -2064,7 +2073,7 @@ static int validate_functions(struct objtool_file *file)
 
 	for_each_sec(file, sec) {
 		list_for_each_entry(func, &sec->symbol_list, list) {
-			if (func->type != STT_FUNC)
+			if (func->type != STT_FUNC || func->pfunc != func)
 				continue;
 
 			insn = find_insn(file, sec, func->offset);
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index c1c338661699..4e60e105583e 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -79,6 +79,19 @@ struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset)
 	return NULL;
 }
 
+struct symbol *find_symbol_by_name(struct elf *elf, const char *name)
+{
+	struct section *sec;
+	struct symbol *sym;
+
+	list_for_each_entry(sec, &elf->sections, list)
+		list_for_each_entry(sym, &sec->symbol_list, list)
+			if (!strcmp(sym->name, name))
+				return sym;
+
+	return NULL;
+}
+
 struct symbol *find_symbol_containing(struct section *sec, unsigned long offset)
 {
 	struct symbol *sym;
@@ -203,10 +216,11 @@ static int read_sections(struct elf *elf)
 
 static int read_symbols(struct elf *elf)
 {
-	struct section *symtab;
-	struct symbol *sym;
+	struct section *symtab, *sec;
+	struct symbol *sym, *pfunc;
 	struct list_head *entry, *tmp;
 	int symbols_nr, i;
+	char *coldstr;
 
 	symtab = find_section_by_name(elf, ".symtab");
 	if (!symtab) {
@@ -281,6 +295,30 @@ static int read_symbols(struct elf *elf)
 		hash_add(sym->sec->symbol_hash, &sym->hash, sym->idx);
 	}
 
+	/* Create parent/child links for any cold subfunctions */
+	list_for_each_entry(sec, &elf->sections, list) {
+		list_for_each_entry(sym, &sec->symbol_list, list) {
+			if (sym->type != STT_FUNC)
+				continue;
+			sym->pfunc = sym->cfunc = sym;
+			coldstr = strstr(sym->name, ".cold.");
+			if (coldstr) {
+				coldstr[0] = '\0';
+				pfunc = find_symbol_by_name(elf, sym->name);
+				coldstr[0] = '.';
+
+				if (!pfunc) {
+					WARN("%s(): can't find parent function",
+					     sym->name);
+					goto err;
+				}
+
+				sym->pfunc = pfunc;
+				pfunc->cfunc = sym;
+			}
+		}
+	}
+
 	return 0;
 
 err:
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index d86e2ff14466..de5cd2ddded9 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -61,6 +61,7 @@ struct symbol {
 	unsigned char bind, type;
 	unsigned long offset;
 	unsigned int len;
+	struct symbol *pfunc, *cfunc;
 };
 
 struct rela {
@@ -86,6 +87,7 @@ struct elf {
 struct elf *elf_open(const char *name, int flags);
 struct section *find_section_by_name(struct elf *elf, const char *name);
 struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset);
+struct symbol *find_symbol_by_name(struct elf *elf, const char *name);
 struct symbol *find_symbol_containing(struct section *sec, unsigned long offset);
 struct rela *find_rela_by_dest(struct section *sec, unsigned long offset);
 struct rela *find_rela_by_dest_range(struct section *sec, unsigned long offset,
-- 
2.17.0
