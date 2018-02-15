Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032367AbeBOAgr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 19:36:47 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55653 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032329AbeBOAgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 19:36:44 -0500
Date: Wed, 14 Feb 2018 16:26:11 -0800
From: tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-fe24e27128252c230a34a6c628da2bf1676781ea@git.kernel.org>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org, luto@kernel.org,
        dvlasenk@redhat.com, arjan@linux.intel.com, jpoimboe@redhat.com,
        brgerst@gmail.com, bp@alien8.de, hpa@zytor.com, fengguang.wu@intel.com,
        tglx@linutronix.de
Reply-To: luto@kernel.org, mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org, bp@alien8.de,
        fengguang.wu@intel.com, tglx@linutronix.de, hpa@zytor.com,
        jpoimboe@redhat.com, brgerst@gmail.com, arjan@linux.intel.com,
        dvlasenk@redhat.com
In-Reply-To: <bace77a60d5af9b45eddb8f8fb9c776c8de657ef.1518130694.git.jpoimboe@redhat.com>
References: <bace77a60d5af9b45eddb8f8fb9c776c8de657ef.1518130694.git.jpoimboe@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] objtool: Fix segfault in ignore_unreachable_insn()
Git-Commit-ID: fe24e27128252c230a34a6c628da2bf1676781ea
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

Commit-ID:  fe24e27128252c230a34a6c628da2bf1676781ea
Gitweb:     https://git.kernel.org/tip/fe24e27128252c230a34a6c628da2bf1676781ea
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Thu, 8 Feb 2018 17:09:25 -0600
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 15 Feb 2018 01:15:49 +0100

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
 
