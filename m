Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933036AbeCFX6r (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 18:58:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51246 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753466AbeCFX6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 18:58:46 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Sven Joachim <svenjoac@gmx.de>
Subject: [PATCH] objtool: Fix 32-bit build
Date: Tue,  6 Mar 2018 17:58:15 -0600
Message-Id: <2ca46c636c23aa9c9d57d53c75de4ee3ddf7a7df.1520380691.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the objtool build when cross-compiling a 64-bit kernel on a 32-bit
host.  This also simplifies read_retpoline_hints() a bit and makes its
implementation similar to most of the other annotation reading
functions.

Reported-by: Sven Joachim <svenjoac@gmx.de>
Fixes: b5bc2231b8ad ("objtool: Add retpoline validation")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 46c1d239cc1b..92b6a2c21631 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1116,42 +1116,29 @@ static int read_unwind_hints(struct objtool_file *file)
 
 static int read_retpoline_hints(struct objtool_file *file)
 {
-	struct section *sec, *relasec;
+	struct section *sec;
 	struct instruction *insn;
 	struct rela *rela;
-	int i;
 
-	sec = find_section_by_name(file->elf, ".discard.retpoline_safe");
+	sec = find_section_by_name(file->elf, ".rela.discard.retpoline_safe");
 	if (!sec)
 		return 0;
 
-	relasec = sec->rela;
-	if (!relasec) {
-		WARN("missing .rela.discard.retpoline_safe section");
-		return -1;
-	}
-
-	if (sec->len % sizeof(unsigned long)) {
-		WARN("retpoline_safe size mismatch: %d %ld", sec->len, sizeof(unsigned long));
-		return -1;
-	}
-
-	for (i = 0; i < sec->len / sizeof(unsigned long); i++) {
-		rela = find_rela_by_dest(sec, i * sizeof(unsigned long));
-		if (!rela) {
-			WARN("can't find rela for retpoline_safe[%d]", i);
+	list_for_each_entry(rela, &sec->rela_list, list) {
+		if (rela->sym->type != STT_SECTION) {
+			WARN("unexpected relocation symbol type in %s", sec->name);
 			return -1;
 		}
 
 		insn = find_insn(file, rela->sym->sec, rela->addend);
 		if (!insn) {
-			WARN("can't find insn for retpoline_safe[%d]", i);
+			WARN("bad .discard.retpoline_safe entry");
 			return -1;
 		}
 
 		if (insn->type != INSN_JUMP_DYNAMIC &&
 		    insn->type != INSN_CALL_DYNAMIC) {
-			WARN_FUNC("retpoline_safe hint not a indirect jump/call",
+			WARN_FUNC("retpoline_safe hint not an indirect jump/call",
 				  insn->sec, insn->offset);
 			return -1;
 		}
-- 
2.14.3
