Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbeCGG4G (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 01:56:06 -0500
Received: from terminus.zytor.com ([198.137.202.136]:32847 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeCGG4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 01:56:03 -0500
Date: Tue, 6 Mar 2018 22:55:02 -0800
From: tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-63474dc4ac7ed3848a4786b9592dd061901f606d@git.kernel.org>
Cc: torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        peterz@infradead.org, mingo@kernel.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, svenjoac@gmx.de
Reply-To: torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        peterz@infradead.org, mingo@kernel.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, svenjoac@gmx.de
In-Reply-To: <2ca46c636c23aa9c9d57d53c75de4ee3ddf7a7df.1520380691.git.jpoimboe@redhat.com>
References: <2ca46c636c23aa9c9d57d53c75de4ee3ddf7a7df.1520380691.git.jpoimboe@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] objtool: Fix 32-bit build
Git-Commit-ID: 63474dc4ac7ed3848a4786b9592dd061901f606d
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

Commit-ID:  63474dc4ac7ed3848a4786b9592dd061901f606d
Gitweb:     https://git.kernel.org/tip/63474dc4ac7ed3848a4786b9592dd061901f606d
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Tue, 6 Mar 2018 17:58:15 -0600
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 7 Mar 2018 07:50:38 +0100

objtool: Fix 32-bit build

Fix the objtool build when cross-compiling a 64-bit kernel on a 32-bit
host.  This also simplifies read_retpoline_hints() a bit and makes its
implementation similar to most of the other annotation reading
functions.

Reported-by: Sven Joachim <svenjoac@gmx.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: b5bc2231b8ad ("objtool: Add retpoline validation")
Link: http://lkml.kernel.org/r/2ca46c636c23aa9c9d57d53c75de4ee3ddf7a7df.1520380691.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
