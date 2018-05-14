Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AB8JxZougwxYce9hk52GAoJ/o8l7x0+LCZeCYqUP9LstcI9RLzJCr8kICfAcmLMaXjQsBzucg8mY
ARC-Seal: i=1; a=rsa-sha256; t=1526301519; cv=none;
        d=google.com; s=arc-20160816;
        b=BnvXHQnet7jvBJEHmlP9Xm1qNuKPnXaTK6BANxYg7txSZcknmI2uypsUMnei3Ev/J+
         WVfpe1npQFKC45UeqkxIaJUrK3KboEGCE8Vqoq45cuiRKXPUQQxYFA4U3RjJZMbjXgWI
         s1i/HC0jvMMZR2x0CCWsGRtsQKGbwZEKtjT0VnNEqirTGEOjBH2IxsfNW+YTJgYZJdYL
         ZqDxQCzyWF24EdNWix02MPHUtxURNTh21uNpYAHvzj9+gTzvSjyJ27l+fMtotPVZGjBw
         YlpqQaWAK1NXtG264gNm98GnfeqfJsN0+hP+yRdD+hCs7WWmCmsijvfXmVfGc8Ktttjl
         Y1Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=/lccAsTEr6x7DsioTob7g13AwoUk2yZmt59XJcf9iZ0=;
        b=WFPKFWvghw8GJtz1chAqnbtN7Iz3uT+yUNJ9AEvwrdGDWgWHVoKlDvCpu4WoTXnAma
         aCrgLHgKEv9hVQCMZtMGcKkEmsXt+d75l7Q/YAz3lt/APh1wOc8CG3Y385Ot4ISlzq5n
         XpJA2UAaOE4Cj5Cdcqze8HjjSZeqQSdNSO/X4FwLBlC8PBYs+FJrcpFIqwDLQGBRPJSS
         HZM79enIzvFiw7sdPs1owjb/p75NxJcSrw722ubsb2XguG1u9jybx2aasVFx6EStSrLb
         iAwZOKLLm2SvCWrOd1fISIrfZypAmIRsn1Pc9C2IhxwqpMQy19rBilWslz1IRUWEvEYJ
         hIrA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Mon, 14 May 2018 05:37:47 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-13810435b9a7014fb92eb715f77da488f3b65b99@git.kernel.org>
Cc: mingo@kernel.org, jpoimboe@redhat.com, damian.tometzki@icloud.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, arnd@arndb.de, peterz@infradead.org,
        tglx@linutronix.de, torvalds@linux-foundation.org, hpa@zytor.com,
        David.Laight@ACULAB.COM
Reply-To: peterz@infradead.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, hpa@zytor.com, David.Laight@ACULAB.COM,
        mingo@kernel.org, jpoimboe@redhat.com, gregkh@linuxfoundation.org,
        damian.tometzki@icloud.com, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, arnd@arndb.de
In-Reply-To: <0965e7fcfc5f31a276f0c7f298ff770c19b68706.1525923412.git.jpoimboe@redhat.com>
References: <0965e7fcfc5f31a276f0c7f298ff770c19b68706.1525923412.git.jpoimboe@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] objtool: Support GCC 8's cold subfunctions
Git-Commit-ID: 13810435b9a7014fb92eb715f77da488f3b65b99
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600443142986140379?=
X-GMAIL-MSGID: =?utf-8?q?1600443142986140379?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  13810435b9a7014fb92eb715f77da488f3b65b99
Gitweb:     https://git.kernel.org/tip/13810435b9a7014fb92eb715f77da488f3b65b99
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Wed, 9 May 2018 22:39:15 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 10:20:53 +0200

objtool: Support GCC 8's cold subfunctions

GCC 8 moves a lot of unlikely code out of line to "cold" subfunctions in
.text.unlikely.  Properly detect the new subfunctions and treat them as
extensions of the original functions.

This fixes a bunch of warnings like:

  kernel/cgroup/cgroup.o: warning: objtool: parse_cgroup_root_flags()+0x33: sibling call from callable instruction with modified stack frame
  kernel/cgroup/cgroup.o: warning: objtool: cgroup_addrm_files()+0x290: sibling call from callable instruction with modified stack frame
  kernel/cgroup/cgroup.o: warning: objtool: cgroup_apply_control_enable()+0x25b: sibling call from callable instruction with modified stack frame
  kernel/cgroup/cgroup.o: warning: objtool: rebind_subsystems()+0x325: sibling call from callable instruction with modified stack frame

Reported-and-tested-by: damian <damian.tometzki@icloud.com>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/0965e7fcfc5f31a276f0c7f298ff770c19b68706.1525923412.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/objtool/check.c | 93 ++++++++++++++++++++++++++++-----------------------
 tools/objtool/elf.c   | 42 +++++++++++++++++++++--
 tools/objtool/elf.h   |  2 ++
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
@@ -786,9 +804,8 @@ out:
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
