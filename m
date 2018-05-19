Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbeESGNy (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 02:13:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53451 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbeESGNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 02:13:53 -0400
Date: Fri, 18 May 2018 23:13:25 -0700
From: tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-7dec80ccbe310fb7e225bf21c48c672bb780ce7b@git.kernel.org>
Cc: lkp@intel.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jpoimboe@redhat.com, peterz@infradead.org, mingo@kernel.org,
        torvalds@linux-foundation.org, hpa@zytor.com
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, lkp@intel.com,
        peterz@infradead.org, jpoimboe@redhat.com,
        torvalds@linux-foundation.org, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <f400541613d45689086329432f3095119ffbc328.1526674218.git.jpoimboe@redhat.com>
References: <f400541613d45689086329432f3095119ffbc328.1526674218.git.jpoimboe@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] objtool: Detect RIP-relative switch table
 references, part 2
Git-Commit-ID: 7dec80ccbe310fb7e225bf21c48c672bb780ce7b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7dec80ccbe310fb7e225bf21c48c672bb780ce7b
Gitweb:     https://git.kernel.org/tip/7dec80ccbe310fb7e225bf21c48c672bb780ce7b
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Fri, 18 May 2018 15:10:34 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 19 May 2018 08:10:04 +0200

objtool: Detect RIP-relative switch table references, part 2

With the following commit:

  fd35c88b7417 ("objtool: Support GCC 8 switch tables")

I added a "can't find switch jump table" warning, to stop covering up
silent failures if add_switch_table() can't find anything.

That warning found yet another bug in the objtool switch table detection
logic.  For cases 1 and 2 (as described in the comments of
find_switch_table()), the find_symbol_containing() check doesn't adjust
the offset for RIP-relative switch jumps.

Incidentally, this bug was already fixed for case 3 with:

  6f5ec2993b1f ("objtool: Detect RIP-relative switch table references")

However, that commit missed the fix for cases 1 and 2.

The different cases are now starting to look more and more alike.  So
fix the bug by consolidating them into a single case, by checking the
original dynamic jump instruction in the case 3 loop.

This also simplifies the code and makes it more robust against future
switch table detection issues -- of which I'm sure there will be many...

Switch table detection has been the most fragile area of objtool, by
far.  I long for the day when we'll have a GCC plugin for annotating
switch tables.  Linus asked me to delay such a plugin due to the
flakiness of the plugin infrastructure in older versions of GCC, so this
rickety code is what we're stuck with for now.  At least the code is now
a little simpler than it was.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/f400541613d45689086329432f3095119ffbc328.1526674218.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/objtool/check.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f4bbce838433..3a31b238f885 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -905,40 +905,19 @@ static struct rela *find_switch_table(struct objtool_file *file,
 	struct instruction *orig_insn = insn;
 	unsigned long table_offset;
 
-	/* case 1 & 2 */
-	text_rela = find_rela_by_dest_range(insn->sec, insn->offset, insn->len);
-	if (text_rela && text_rela->sym == file->rodata->sym &&
-	    !find_symbol_containing(file->rodata, text_rela->addend)) {
-
-		table_offset = text_rela->addend;
-		if (text_rela->type == R_X86_64_PC32) {
-			/* case 2 */
-			table_offset += 4;
-			file->ignore_unreachables = true;
-		}
-
-		rodata_rela = find_rela_by_dest(file->rodata, table_offset);
-		if (!rodata_rela)
-			return NULL;
-
-		return rodata_rela;
-	}
-
-	/* case 3 */
 	/*
 	 * Backward search using the @first_jump_src links, these help avoid
 	 * much of the 'in between' code. Which avoids us getting confused by
 	 * it.
 	 */
-	for (insn = list_prev_entry(insn, list);
-
+	for (;
 	     &insn->list != &file->insn_list &&
 	     insn->sec == func->sec &&
 	     insn->offset >= func->offset;
 
 	     insn = insn->first_jump_src ?: list_prev_entry(insn, list)) {
 
-		if (insn->type == INSN_JUMP_DYNAMIC)
+		if (insn != orig_insn && insn->type == INSN_JUMP_DYNAMIC)
 			break;
 
 		/* allow small jumps within the range */
@@ -965,10 +944,18 @@ static struct rela *find_switch_table(struct objtool_file *file,
 		if (find_symbol_containing(file->rodata, table_offset))
 			continue;
 
-		/* mov [rodata addr], %reg */
 		rodata_rela = find_rela_by_dest(file->rodata, table_offset);
-		if (rodata_rela)
+		if (rodata_rela) {
+			/*
+			 * Use of RIP-relative switch jumps is quite rare, and
+			 * indicates a rare GCC quirk/bug which can leave dead
+			 * code behind.
+			 */
+			if (text_rela->type == R_X86_64_PC32)
+				file->ignore_unreachables = true;
+
 			return rodata_rela;
+		}
 	}
 
 	return NULL;
