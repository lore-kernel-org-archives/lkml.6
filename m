Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbeBHXK1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 18:10:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752018AbeBHXJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 18:09:59 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>
Subject: [PATCH 1/2] objtool: Fix seg fault in ignore_unreachable_insn()
Date: Thu,  8 Feb 2018 17:09:25 -0600
Message-Id: <bace77a60d5af9b45eddb8f8fb9c776c8de657ef.1518130694.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1518130694.git.jpoimboe@redhat.com>
References: <20180208203146.GF577@pd.tnic> <cover.1518130694.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 tools/objtool/check.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b00b1896547e..4ec1a3bf7bf2 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1899,13 +1899,19 @@ static bool ignore_unreachable_insn(struct instruction *insn)
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
 
-- 
2.14.3
