Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC4AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD2D213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I0HSuQzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfBYMxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:53:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52240 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfBYMxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:53:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xo2tfGiyhjtal2rtmYhAoFn/d5i99uihshvpIs+V8CA=; b=I0HSuQzwLDCmFQjwR/IXuwGOn+
        JOkc2WpuHpmKmL+WxOJNnPFe/gr1wzPoiy37HS6ldaifUuCu4RUnfjRWbqhivfDdSE3Sh/FFf26Tb
        S4Vd4m4Su+yiCGnkS5pCzJY8xir15NJAIlAjE9kcovkgMsSXDGYq7PATt++S0X1anVITJ3QHKknA9
        M5xU6nBJK3N84NYc98YBPd/zJbtTZQN+xjFA6q5gBdXxxutHzq7oywvwkL7Qao2rnnFqyAFlpHDkY
        0v2iFueJo3ebvcxL245ExO79jxoZ5ttUNbrbqlK5RYRgc2bfInCP00Fvp63Jx+blHbgyMyW33IXNK
        08d3DMTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyFkm-0000Eg-9i; Mon, 25 Feb 2019 12:53:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A2C09207B7F83; Mon, 25 Feb 2019 13:53:02 +0100 (CET)
Message-Id: <20190225125232.107098740@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 25 Feb 2019 13:43:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 4/6] objtool: Replace STACK_FRAME_NON_STANDARD annotation
References: <20190225124330.613028745@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the existing STACK_FRAME_NON_STANDARD annotation with a
'better' scheme.

The old annotation works by taking the address of a function; this
is visible to the compiler and might affect code generation (the
function pointer escapes). The new annotation simply stores the
function name and has objtool do a symtab lookup.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/frame.h |   19 +++++++++++++---
 tools/objtool/check.c |   58 +++++++++++++++++++++-----------------------------
 tools/objtool/check.h |    1 
 3 files changed, 41 insertions(+), 37 deletions(-)

--- a/include/linux/frame.h
+++ b/include/linux/frame.h
@@ -11,9 +11,22 @@
  *
  * For more information, see tools/objtool/Documentation/stack-validation.txt.
  */
-#define STACK_FRAME_NON_STANDARD(func) \
-	static void __used __section(.discard.func_stack_frame_non_standard) \
-		*__func_stack_frame_non_standard_##func = func
+#define STACK_FRAME_NON_STANDARD(func)					\
+	asm (".pushsection .discard.nonstd_frame_strtab, \"S\", @3\n\t"	\
+	     "999: .ascii \"" #func "\"\n\t"				\
+	     "     .byte 0\n\t"						\
+	     ".popsection\n\t"						\
+	     ".pushsection .discard.nonstd_frame\n\t"			\
+	     ".long 999b - .\n\t"					\
+	     ".popsection\n\t")
+
+/*
+ * SHT_STRTAB(@3) sections should start with a \0 byte such that the 0 offset
+ * encodes the NULL string.
+ */
+asm (".pushsection .discard.nonstd_frame_strtab, \"S\", @3\n\t"
+     ".byte 0\n\t"
+     ".popsection\n\t");
 
 #else /* !CONFIG_STACK_VALIDATION */
 
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -105,29 +105,6 @@ static struct instruction *next_insn_sam
 	     insn = next_insn_same_sec(file, insn))
 
 /*
- * Check if the function has been manually whitelisted with the
- * STACK_FRAME_NON_STANDARD macro, or if it should be automatically whitelisted
- * due to its use of a context switching instruction.
- */
-static bool ignore_func(struct objtool_file *file, struct symbol *func)
-{
-	struct rela *rela;
-
-	/* check for STACK_FRAME_NON_STANDARD */
-	if (file->whitelist && file->whitelist->rela)
-		list_for_each_entry(rela, &file->whitelist->rela->rela_list, list) {
-			if (rela->sym->type == STT_SECTION &&
-			    rela->sym->sec == func->sec &&
-			    rela->addend == func->offset)
-				return true;
-			if (rela->sym->type == STT_FUNC && rela->sym == func)
-				return true;
-		}
-
-	return false;
-}
-
-/*
  * This checks to see if the given function is a "noreturn" function.
  *
  * For global functions which are outside the scope of this object file, we
@@ -434,21 +411,37 @@ static int add_dead_ends(struct objtool_
 static void add_ignores(struct objtool_file *file)
 {
 	struct instruction *insn;
-	struct section *sec;
+	struct section *strtab_sec, *sec;
 	struct symbol *func;
+	struct rela *rela;
+	const char *name;
 
-	for_each_sec(file, sec) {
-		list_for_each_entry(func, &sec->symbol_list, list) {
-			if (func->type != STT_FUNC)
-				continue;
+	sec = find_section_by_name(file->elf, ".rela.discard.nonstd_frame");
+	if (!sec)
+		return;
 
-			if (!ignore_func(file, func))
-				continue;
+	strtab_sec = find_section_by_name(file->elf, ".discard.nonstd_frame_strtab");
+	if (!strtab_sec) {
+		WARN("missing nonstd_frame strtab");
+		return;
+	}
 
-			func_for_each_insn_all(file, func, insn)
-				insn->ignore = true;
+	list_for_each_entry(rela, &sec->rela_list, list) {
+		if (rela->sym->type != STT_SECTION) {
+			WARN("unexpected relocation symbol type in %s", sec->name);
+			return;
 		}
+
+		name = elf_strptr(file->elf->elf, strtab_sec->idx, rela->addend);
+		func = find_symbol_by_name(file->elf, name);
+		if (!func)
+			continue;
+
+		func_for_each_insn_all(file, func, insn)
+			insn->ignore = true;
 	}
+
+	return;
 }
 
 /*
@@ -2198,7 +2191,6 @@ int check(const char *_objname, bool orc
 
 	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
-	file.whitelist = find_section_by_name(file.elf, ".discard.func_stack_frame_non_standard");
 	file.c_file = find_section_by_name(file.elf, ".comment");
 	file.ignore_unreachables = no_unreachable;
 	file.hints = false;
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -60,7 +60,6 @@ struct objtool_file {
 	struct elf *elf;
 	struct list_head insn_list;
 	DECLARE_HASHTABLE(insn_hash, 16);
-	struct section *whitelist;
 	bool ignore_unreachables, c_file, hints, rodata;
 };
 


