Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934878AbeBMLl2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 06:41:28 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58465 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934086AbeBMLl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 06:41:26 -0500
Date: Tue, 13 Feb 2018 03:29:46 -0800
From: tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-59d13cd6789e8feb4615bb999d46bbd439a9a396@git.kernel.org>
Cc: brgerst@gmail.com, tglx@linutronix.de, bp@alien8.de,
        torvalds@linux-foundation.org, jpoimboe@redhat.com, luto@kernel.org,
        arjan@linux.intel.com, fengguang.wu@intel.com, peterz@infradead.org,
        mingo@kernel.org, hpa@zytor.com, dvlasenk@redhat.com,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, dvlasenk@redhat.com, hpa@zytor.com,
        mingo@kernel.org, peterz@infradead.org, fengguang.wu@intel.com,
        arjan@linux.intel.com, luto@kernel.org, torvalds@linux-foundation.org,
        jpoimboe@redhat.com, bp@alien8.de, tglx@linutronix.de,
        brgerst@gmail.com
In-Reply-To: <bace77a60d5af9b45eddb8f8fb9c776c8de657ef.1518130694.git.jpoimboe@redhat.com>
References: <bace77a60d5af9b45eddb8f8fb9c776c8de657ef.1518130694.git.jpoimboe@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] objtool: Fix segfault in ignore_unreachable_insn()
Git-Commit-ID: 59d13cd6789e8feb4615bb999d46bbd439a9a396
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

Commit-ID:  59d13cd6789e8feb4615bb999d46bbd439a9a396
Gitweb:     https://git.kernel.org/tip/59d13cd6789e8feb4615bb999d46bbd439a9a396
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Thu, 8 Feb 2018 17:09:25 -0600
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 11:46:59 +0100

objtool: Fix segfault in ignore_unreachable_insn()

Peter Zijlstra's patch for converting WARN() to use UD2 triggered a
bunch of false "unreachable instruction" warnings, which then triggered
a seg fault in ignore_unreachable_insn().

The seg fault happened when it tried to dereference a NULL 'insn->func'
pointer.  Thanks to static_cpu_has(), some functions can jump to a
non-function area in the .altinstr_aux section.  That breaks
ignore_unreachable_insn()'s assumption that it's always inside the
original function.

Make sure ignore_unreachable_insn() only follows jumps within the
current function.

Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kbuild test robot <fengguang.wu@intel.com>
Link: http://lkml.kernel.org/r/bace77a60d5af9b45eddb8f8fb9c776c8de657ef.1518130694.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/objtool/check.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2e458eb..c7fb5c2 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1935,13 +1935,19 @@ static bool ignore_unreachable_insn(struct instruction *insn)
 		if (is_kasan_insn(insn) || is_ubsan_insn(insn))
 			return true;
 
-		if (insn->type == INSN_JUMP_UNCONDITIONAL && insn->jump_dest) {
-			insn = insn->jump_dest;
-			continue;
+		if (insn->type == INSN_JUMP_UNCONDITIONAL) {
+			if (insn->jump_dest &&
+			    insn->jump_dest->func == insn->func) {
+				insn = insn->jump_dest;
+				continue;
+			}
+
+			break;
 		}
 
 		if (insn->offset + insn->len >= insn->func->offset + insn->func->len)
 			break;
+
 		insn = list_next_entry(insn, list);
 	}
 
