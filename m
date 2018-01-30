Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeA3ECL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 23:02:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752399AbeA3EBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 23:01:24 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/4] objtool: Improve retpoline alternative handling
Date: Mon, 29 Jan 2018 22:00:39 -0600
Message-Id: <819e50b6d9c2e1a22e34c1a636c0b2057cc8c6e5.1517284349.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1517284349.git.jpoimboe@redhat.com>
References: <cover.1517284349.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently objtool requires all retpolines to be

  a) patched in with alternatives; and

  b) annotated with ANNOTATE_NOSPEC_ALTERNATIVE.

If you forget to do both of the above, objtool seg faults trying to
dereference a NULL 'insn->call_dest' pointer.

Avoid that situation and print a more helpful error message:

  quirks.o: warning: objtool: efi_delete_dummy_variable()+0x99: unsupported intra-function call
  quirks.o: warning: objtool: If this is a retpoline, please patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE.

Future improvements can be made to make objtool smarter with respect to
retpolines, but this is a good incremental improvement for now.

Reported-and-tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f40d46e24bcc..bc3490d929ff 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -543,18 +543,14 @@ static int add_call_destinations(struct objtool_file *file)
 			dest_off = insn->offset + insn->len + insn->immediate;
 			insn->call_dest = find_symbol_by_offset(insn->sec,
 								dest_off);
-			/*
-			 * FIXME: Thanks to retpolines, it's now considered
-			 * normal for a function to call within itself.  So
-			 * disable this warning for now.
-			 */
-#if 0
-			if (!insn->call_dest) {
-				WARN_FUNC("can't find call dest symbol at offset 0x%lx",
-					  insn->sec, insn->offset, dest_off);
+
+			if (!insn->call_dest && !insn->ignore) {
+				WARN_FUNC("unsupported intra-function call",
+					  insn->sec, insn->offset);
+				WARN("If this is a retpoline, please patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE.");
 				return -1;
 			}
-#endif
+
 		} else if (rela->sym->type == STT_SECTION) {
 			insn->call_dest = find_symbol_by_offset(rela->sym->sec,
 								rela->addend+4);
@@ -648,6 +644,8 @@ static int handle_group_alt(struct objtool_file *file,
 
 		last_new_insn = insn;
 
+		insn->ignore = orig_insn->ignore_alts;
+
 		if (insn->type != INSN_JUMP_CONDITIONAL &&
 		    insn->type != INSN_JUMP_UNCONDITIONAL)
 			continue;
@@ -729,10 +727,6 @@ static int add_special_section_alts(struct objtool_file *file)
 			goto out;
 		}
 
-		/* Ignore retpoline alternatives. */
-		if (orig_insn->ignore_alts)
-			continue;
-
 		new_insn = NULL;
 		if (!special_alt->group || special_alt->new_len) {
 			new_insn = find_insn(file, special_alt->new_sec,
@@ -1089,11 +1083,11 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
-	ret = add_call_destinations(file);
+	ret = add_special_section_alts(file);
 	if (ret)
 		return ret;
 
-	ret = add_special_section_alts(file);
+	ret = add_call_destinations(file);
 	if (ret)
 		return ret;
 
@@ -1720,10 +1714,12 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 
 		insn->visited = true;
 
-		list_for_each_entry(alt, &insn->alts, list) {
-			ret = validate_branch(file, alt->insn, state);
-			if (ret)
-				return 1;
+		if (!insn->ignore_alts) {
+			list_for_each_entry(alt, &insn->alts, list) {
+				ret = validate_branch(file, alt->insn, state);
+				if (ret)
+					return 1;
+			}
 		}
 
 		switch (insn->type) {
-- 
2.14.3
