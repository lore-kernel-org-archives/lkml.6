Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753808AbeE3QRe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:17:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57014 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753703AbeE3QRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:17:33 -0400
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] objtool: Fix GCC 8 cold subfunction detection for aliased functions
Date: Wed, 30 May 2018 11:16:39 -0500
Message-Id: <6d4fc778da0c8702b0d19882443ea33233af6fc3.1527696986.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kbuild test robot reported the following issue:

  kernel/time/posix-stubs.o: warning: objtool: sys_ni_posix_timers.cold.1()+0x0: unreachable instruction

This file creates symbol aliases for the sys_ni_posix_timers() function.
So there are multiple ELF function symbols for the same function:

  23: 0000000000000150     26 FUNC    GLOBAL DEFAULT        1 __x64_sys_timer_create
  24: 0000000000000150     26 FUNC    GLOBAL DEFAULT        1 sys_ni_posix_timers
  25: 0000000000000150     26 FUNC    GLOBAL DEFAULT        1 __ia32_sys_timer_create
  26: 0000000000000150     26 FUNC    GLOBAL DEFAULT        1 __x64_sys_timer_gettime

Here's the corresponding cold subfunction:

  11: 0000000000000000     45 FUNC    LOCAL  DEFAULT        6 sys_ni_posix_timers.cold.1

When analyzing overlapping functions, objtool only looks at the first
one in the symbol list.  The rest of the functions are basically ignored
because they point to instructions which have already been analyzed.

So in this case it analyzes the __x64_sys_timer_create() function, but
then it fails to recognize that its cold subfunction is
sys_ni_posix_timers.cold.1(), because the names are different.

Make the subfunction detection a little smarter by associating each
subfunction with the first function which jumps to it, since that's the
one which will be analyzed.

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 13810435b9a7 ("objtool: Support GCC 8's cold subfunctions")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 13 +++++++++++++
 tools/objtool/elf.c   | 32 +++++---------------------------
 2 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index bd26d57accc7..479ee76ac21a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -543,6 +543,19 @@ static int add_jump_destinations(struct objtool_file *file)
 				  dest_off);
 			return -1;
 		}
+
+		/*
+		 * For GCC 8+, create parent/child links for any cold
+		 * subfunctions.
+		 */
+		if (insn->func && insn->jump_dest->func &&
+		    insn->func != insn->jump_dest->func &&
+		    insn->func->cfunc == insn->func &&
+		    !strstr(insn->func->name, ".cold.") &&
+		    strstr(insn->jump_dest->func->name, ".cold.")) {
+			insn->func->cfunc = insn->jump_dest->func;
+			insn->jump_dest->func->pfunc = insn->func;
+		}
 	}
 
 	return 0;
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 4e60e105583e..79c92af54c17 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -216,11 +216,10 @@ static int read_sections(struct elf *elf)
 
 static int read_symbols(struct elf *elf)
 {
-	struct section *symtab, *sec;
-	struct symbol *sym, *pfunc;
+	struct section *symtab;
+	struct symbol *sym;
 	struct list_head *entry, *tmp;
 	int symbols_nr, i;
-	char *coldstr;
 
 	symtab = find_section_by_name(elf, ".symtab");
 	if (!symtab) {
@@ -274,6 +273,9 @@ static int read_symbols(struct elf *elf)
 		sym->offset = sym->sym.st_value;
 		sym->len = sym->sym.st_size;
 
+		if (sym->type == STT_FUNC)
+			sym->pfunc = sym->cfunc = sym;
+
 		/* sorted insert into a per-section list */
 		entry = &sym->sec->symbol_list;
 		list_for_each_prev(tmp, &sym->sec->symbol_list) {
@@ -295,30 +297,6 @@ static int read_symbols(struct elf *elf)
 		hash_add(sym->sec->symbol_hash, &sym->hash, sym->idx);
 	}
 
-	/* Create parent/child links for any cold subfunctions */
-	list_for_each_entry(sec, &elf->sections, list) {
-		list_for_each_entry(sym, &sec->symbol_list, list) {
-			if (sym->type != STT_FUNC)
-				continue;
-			sym->pfunc = sym->cfunc = sym;
-			coldstr = strstr(sym->name, ".cold.");
-			if (coldstr) {
-				coldstr[0] = '\0';
-				pfunc = find_symbol_by_name(elf, sym->name);
-				coldstr[0] = '.';
-
-				if (!pfunc) {
-					WARN("%s(): can't find parent function",
-					     sym->name);
-					goto err;
-				}
-
-				sym->pfunc = pfunc;
-				pfunc->cfunc = sym;
-			}
-		}
-	}
-
 	return 0;
 
 err:
-- 
2.17.0
