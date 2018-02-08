Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751706AbeBHNCw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 08:02:52 -0500
Received: from merlin.infradead.org ([205.233.59.134]:46234 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeBHNCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 08:02:50 -0500
Date: Thu, 8 Feb 2018 14:02:32 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>
Subject: [PATCH] objtool: Fix switch-table detection
Message-ID: <20180208130232.GF25235@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus reported that GCC-7.3 generated a switch-table construct that
confused objtool. It turns out that, in particular due to KASAN, it is
possible to have unrelated .rodata usage in between the .rodata setup
for the switch-table and the following indirect jump.

The simple linear reverse search from the indirect jump would hit upon
the KASAN .rodata usage first and fail to find a switch_table,
resulting in a spurious 'sibling call with modified stack frame'
warning.

Fix this by creating a 'jump-stack' which we can 'unwind' during
reversal, thereby skipping over much of the in-between code.

This is not fool proof by any means, but is sufficient to make the
known cases work. Future work would be to construct more comprehensive
flow analysis code.

Also, since Josh keeps asking, add myself to MAINTAINERS.

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 MAINTAINERS           |    1 +
 tools/objtool/check.c |   41 +++++++++++++++++++++++++++++++++++++++--
 tools/objtool/check.h |    1 +
 3 files changed, 41 insertions(+), 2 deletions(-)

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9847,6 +9847,7 @@ F:	drivers/nfc/nxp-nci
 
 OBJTOOL
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
+M:	Peter Zijlstra <peterz@infradead.org>
 S:	Supported
 F:	tools/objtool/
 
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -851,8 +851,14 @@ static int add_switch_table(struct objto
  *    This is a fairly uncommon pattern which is new for GCC 6.  As of this
  *    writing, there are 11 occurrences of it in the allmodconfig kernel.
  *
+ *    As of GCC 7 there are quite a few more of these and the 'in between' code
+ *    is significant. Esp. with KASAN enabled some of the code between the mov
+ *    and jmpq uses .rodata itself, which can confuse things.
+ *
  *    TODO: Once we have DWARF CFI and smarter instruction decoding logic,
  *    ensure the same register is used in the mov and jump instructions.
+ *
+ *    NOTE: RETPOLINE made it harder still to decode dynamic jumps.
  */
 static struct rela *find_switch_table(struct objtool_file *file,
 				      struct symbol *func,
@@ -874,12 +880,25 @@ static struct rela *find_switch_table(st
 						text_rela->addend + 4);
 		if (!rodata_rela)
 			return NULL;
+
 		file->ignore_unreachables = true;
 		return rodata_rela;
 	}
 
 	/* case 3 */
-	func_for_each_insn_continue_reverse(file, func, insn) {
+	/*
+	 * Backward search using the @first_jump_src links, these help avoid
+	 * much of the 'in between' code. Which avoids us getting confused by
+	 * it.
+	 */
+	for (insn = list_prev_entry(insn, list);
+
+	     &insn->list != &file->insn_list &&
+	     insn->sec == func->sec &&
+	     insn->offset >= func->offset;
+
+	     insn = insn->first_jump_src ?: list_prev_entry(insn, list)) {
+
 		if (insn->type == INSN_JUMP_DYNAMIC)
 			break;
 
@@ -909,14 +928,32 @@ static struct rela *find_switch_table(st
 	return NULL;
 }
 
+
 static int add_func_switch_tables(struct objtool_file *file,
 				  struct symbol *func)
 {
-	struct instruction *insn, *prev_jump = NULL;
+	struct instruction *insn, *last = NULL, *prev_jump = NULL;
 	struct rela *rela, *prev_rela = NULL;
 	int ret;
 
 	func_for_each_insn(file, func, insn) {
+		if (!last)
+			last = insn;
+
+		/*
+		 * Store back-pointers for unconditional forward jumps such
+		 * that find_switch_table() can back-track using those and
+		 * avoid some potentially confusing code.
+		 */
+		if (insn->type == INSN_JUMP_UNCONDITIONAL && insn->jump_dest &&
+		    insn->offset > last->offset &&
+		    insn->jump_dest->offset > insn->offset &&
+		    !insn->jump_dest->first_jump_src) {
+
+			insn->jump_dest->first_jump_src = insn;
+			last = insn->jump_dest;
+		}
+
 		if (insn->type != INSN_JUMP_DYNAMIC)
 			continue;
 
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -47,6 +47,7 @@ struct instruction {
 	bool alt_group, visited, dead_end, ignore, hint, save, restore, ignore_alts;
 	struct symbol *call_dest;
 	struct instruction *jump_dest;
+	struct instruction *first_jump_src;
 	struct list_head alts;
 	struct symbol *func;
 	struct stack_op stack_op;
