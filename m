Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeFAMX7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 08:23:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751301AbeFAMXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 08:23:54 -0400
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2] objtool: Fix GCC 8 cold subfunction detection for aliased functions
Date: Fri,  1 Jun 2018 07:23:51 -0500
Message-Id: <d3ba52662cbc8e3a64a3b64d44b4efc5674fd9ab.1527855808.git.jpoimboe@redhat.com>
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

Unfortunately we still have to leave the original subfunction detection
code in place, thanks to GCC switch tables.  (See the comment for more
details.)

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 13810435b9a7 ("objtool: Support GCC 8's cold subfunctions")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index bd26d57accc7..1f226f22ad75 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -543,6 +543,28 @@ static int add_jump_destinations(struct objtool_file *file)
 				  dest_off);
 			return -1;
 		}
+
+		/*
+		 * For GCC 8+, create parent/child links for any cold
+		 * subfunctions.  This is _mostly_ redundant with a similar
+		 * initialization in read_symbols().
+		 *
+		 * If a function has aliases, we want the *first* such function
+		 * in the symbol table to be the subfunction's parent.  In that
+		 * case we overwrite the initialization done in read_symbols().
+		 *
+		 * However this code can't completely replace the
+		 * read_symbols() code because this doesn't detect the case
+		 * where the parent function's only reference to a subfunction
+		 * is through a switch table.
+		 */
+		if (insn->func && insn->jump_dest->func &&
+		    insn->func != insn->jump_dest->func &&
+		    !strstr(insn->func->name, ".cold.") &&
+		    strstr(insn->jump_dest->func->name, ".cold.")) {
+			insn->func->cfunc = insn->jump_dest->func;
+			insn->jump_dest->func->pfunc = insn->func;
+		}
 	}
 
 	return 0;
-- 
2.17.0
