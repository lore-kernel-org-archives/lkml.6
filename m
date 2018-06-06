Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 452F260555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752141AbeFFMt0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:49:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34395 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751906AbeFFMtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:49:24 -0400
Date: Wed, 6 Jun 2018 05:48:46 -0700
From: tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-cd77849a69cf5d81a86dd88dac7a594a67cb5c87@git.kernel.org>
Cc: hpa@zytor.com, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, jpoimboe@redhat.com, lkp@intel.com,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          jpoimboe@redhat.com, peterz@infradead.org, lkp@intel.com,
          hpa@zytor.com, mingo@kernel.org
In-Reply-To: <d3ba52662cbc8e3a64a3b64d44b4efc5674fd9ab.1527855808.git.jpoimboe@redhat.com>
References: <d3ba52662cbc8e3a64a3b64d44b4efc5674fd9ab.1527855808.git.jpoimboe@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] objtool: Fix GCC 8 cold subfunction detection for
 aliased functions
Git-Commit-ID: cd77849a69cf5d81a86dd88dac7a594a67cb5c87
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

Commit-ID:  cd77849a69cf5d81a86dd88dac7a594a67cb5c87
Gitweb:     https://git.kernel.org/tip/cd77849a69cf5d81a86dd88dac7a594a67cb5c87
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Fri, 1 Jun 2018 07:23:51 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 6 Jun 2018 14:45:22 +0200

objtool: Fix GCC 8 cold subfunction detection for aliased functions

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

Fixes: 13810435b9a7 ("objtool: Support GCC 8's cold subfunctions")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/d3ba52662cbc8e3a64a3b64d44b4efc5674fd9ab.1527855808.git.jpoimboe@redhat.com

---
 tools/objtool/check.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3a31b238f885..38047c6aa575 100644
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
