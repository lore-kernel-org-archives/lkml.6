Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED26C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C7F213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hmh0hoCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfBYMxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:53:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52246 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbfBYMxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=m9PyMDX0ckrrw43IH+FyBE/Vx4eNoArdvHGj5lqdNBo=; b=hmh0hoCfZ0cw0jlglaehuqm2aL
        C4iX3hL+qII1KFvDPCRP5424gBtwymkpRC52Q5HKPu909YgTLzu6eY8ren14j8mWBt1JeIqeHc6Ge
        NV11R8NmT8T/8dxdAgg9H1nWuNzG7o68m3/vy6w/2L+p0xsul8UHgRm2BOu696gkNKdvXhl3JUVP3
        8cz/dDKaOsBx3hrvRhnBaWUSYpe1H4+V/wDj4D1q/Z/ht0rS41ukyyzEXDbfqMcsLHU2wicLGCw6l
        Zb7A5SrFxpx7Rje+35FOY81HvrcJgDJkin3YP+McBKxMnf11M8qC2yX8whqpN8qhUdh3yMDUm+mnq
        01CkhTCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyFko-0000Es-Ay; Mon, 25 Feb 2019 12:53:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A6550207B7F94; Mon, 25 Feb 2019 13:53:02 +0100 (CET)
Message-Id: <20190225125232.191698923@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 25 Feb 2019 13:43:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 5/6] objtool: Add UACCESS validation
References: <20190225124330.613028745@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is important that UACCESS regions are as small as possible;
furthermore the UACCESS state is not scheduled, so doing anything that
might directly call into the scheduler will cause random code to be
ran with UACCESS enabled.

Teach objtool too track UACCESS state and warn about any CALL made
while UACCESS is enabled. This very much includes the __fentry__()
tracing calls and __preempt_schedule() calls.

Note that exceptions _do_ save/restore the UACCESS state, and therefore
they can drive preemption. This also means that all exception handlers
must have an otherwise dedundant UACCESS disable instruction;
therefore ignore this warning for !STT_FUNC code (exception handlers
are not normal functions).

It also provides a UACCESS_SAFE() annotation which allows explicit
annotation. This is meant to be used for future things like:
unsafe_copy_{to,from}_user().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/frame.h           |   30 +++++++++++-
 tools/objtool/arch.h            |    4 +
 tools/objtool/arch/x86/decode.c |   14 +++++
 tools/objtool/check.c           |  100 ++++++++++++++++++++++++++++++++++++----
 tools/objtool/check.h           |    2 
 tools/objtool/elf.h             |    1 
 6 files changed, 138 insertions(+), 13 deletions(-)

--- a/include/linux/frame.h
+++ b/include/linux/frame.h
@@ -28,10 +28,38 @@ asm (".pushsection .discard.nonstd_frame
      ".byte 0\n\t"
      ".popsection\n\t");
 
+/*
+ * This macro marks functions as UACCESS-safe, that is, it is safe to call from an
+ * UACCESS enabled region (typically user_access_begin() /
+ * user_access_end()).
+ *
+ * These functions in turn will only call UACCESS-safe functions themselves (which
+ * precludes tracing, including __fentry__ and scheduling, including
+ * preempt_enable).
+ *
+ * UACCESS-safe functions will obviously also not change UACCESS themselves.
+ */
+#define UACCESS_SAFE(func)						\
+	asm (".pushsection .discard.uaccess_safe_strtab, \"S\", @3\n\t"	\
+	     "999: .ascii \"" #func "\"\n\t"				\
+	     "     .byte 0\n\t"						\
+	     ".popsection\n\t"						\
+	     ".pushsection .discard.uaccess_safe\n\t"			\
+	     ".long 999b - .\n\t"					\
+	     ".popsection")
+
+/*
+ * SHT_STRTAB(@3) sections should start with a \0 byte such that the 0 offset
+ * encodes the NULL string.
+ */
+asm(".pushsection .discard.uaccess_safe_strtab, \"S\", @3\n\t"
+    ".byte 0\n\t"
+    ".popsection\n\t");
+
 #else /* !CONFIG_STACK_VALIDATION */
 
 #define STACK_FRAME_NON_STANDARD(func)
+#define AC_SAFE(func)
 
 #endif /* CONFIG_STACK_VALIDATION */
-
 #endif /* _LINUX_FRAME_H */
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -33,7 +33,9 @@
 #define INSN_STACK		8
 #define INSN_BUG		9
 #define INSN_NOP		10
-#define INSN_OTHER		11
+#define INSN_STAC		11
+#define INSN_CLAC		12
+#define INSN_OTHER		13
 #define INSN_LAST		INSN_OTHER
 
 enum op_dest_type {
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -369,7 +369,19 @@ int arch_decode_instruction(struct elf *
 
 	case 0x0f:
 
-		if (op2 >= 0x80 && op2 <= 0x8f) {
+		if (op2 == 0x01) {
+
+			if (modrm == 0xca) {
+
+				*type = INSN_CLAC;
+
+			} else if (modrm == 0xcb) {
+
+				*type = INSN_STAC;
+
+			}
+
+		} else if (op2 >= 0x80 && op2 <= 0x8f) {
 
 			*type = INSN_JUMP_CONDITIONAL;
 
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -444,6 +444,40 @@ static void add_ignores(struct objtool_f
 	return;
 }
 
+static void add_uaccess_safe(struct objtool_file *file)
+{
+	struct section *strtab_sec, *sec;
+	struct symbol *func;
+	struct rela *rela;
+	const char *name;
+
+	sec = find_section_by_name(file->elf, ".rela.discard.uaccess_safe");
+	if (!sec)
+		return;
+
+	strtab_sec = find_section_by_name(file->elf, ".discard.uaccess_safe_strtab");
+	if (!strtab_sec) {
+		WARN("missing uaccess_safe strtab");
+		return;
+	}
+
+	list_for_each_entry(rela, &sec->rela_list, list) {
+		if (rela->sym->type != STT_SECTION) {
+			WARN("unexpected relocation symbol type in %s", sec->name);
+			return;
+		}
+
+		name = elf_strptr(file->elf->elf, strtab_sec->idx, rela->addend);
+		func = find_symbol_by_name(file->elf, name);
+		if (!func)
+			continue;
+
+		func->uaccess_safe = true;
+	}
+
+	return;
+}
+
 /*
  * FIXME: For now, just ignore any alternatives which add retpolines.  This is
  * a temporary hack, as it doesn't allow ORC to unwind from inside a retpoline.
@@ -1232,6 +1266,7 @@ static int decode_sections(struct objtoo
 		return ret;
 
 	add_ignores(file);
+	add_uaccess_safe(file);
 
 	ret = add_nospec_ignores(file);
 	if (ret)
@@ -1792,6 +1827,22 @@ static bool insn_state_match(struct inst
 	return false;
 }
 
+static inline bool insn_dest_uaccess_safe(struct instruction *insn)
+{
+	if (!insn->call_dest)
+		return false;
+
+	return insn->call_dest->uaccess_safe;
+}
+
+static inline const char *insn_dest_name(struct instruction *insn)
+{
+	if (!insn->call_dest)
+		return "{dynamic}";
+
+	return insn->call_dest->name;
+}
+
 /*
  * Follow the branch starting at the given instruction, and recursively follow
  * any other branches (jumps).  Meanwhile, track the frame pointer state at
@@ -1896,6 +1947,9 @@ static int validate_branch(struct objtoo
 		switch (insn->type) {
 
 		case INSN_RETURN:
+			if (state.uaccess)
+				WARN_FUNC("return with UACCESS enabled", sec, insn->offset);
+
 			if (func && has_modified_stack_frame(&state)) {
 				WARN_FUNC("return with modified stack frame",
 					  sec, insn->offset);
@@ -1911,17 +1965,24 @@ static int validate_branch(struct objtoo
 			return 0;
 
 		case INSN_CALL:
-			if (is_fentry_call(insn))
-				break;
+		case INSN_CALL_DYNAMIC:
+			if ((state.uaccess_safe || state.uaccess) &&
+			    !insn_dest_uaccess_safe(insn)) {
+				WARN_FUNC("call to %s() with UACCESS enabled",
+					  sec, insn->offset, insn_dest_name(insn));
+			}
 
-			ret = dead_end_function(file, insn->call_dest);
-			if (ret == 1)
-				return 0;
-			if (ret == -1)
-				return 1;
+			if (insn->type == INSN_CALL) {
+				if (is_fentry_call(insn))
+					break;
+
+				ret = dead_end_function(file, insn->call_dest);
+				if (ret == 1)
+					return 0;
+				if (ret == -1)
+					return 1;
+			}
 
-			/* fallthrough */
-		case INSN_CALL_DYNAMIC:
 			if (!no_fp && func && !has_valid_stack_frame(&state)) {
 				WARN_FUNC("call without frame pointer save/setup",
 					  sec, insn->offset);
@@ -1974,6 +2035,25 @@ static int validate_branch(struct objtoo
 
 			break;
 
+		case INSN_STAC:
+			if (state.uaccess_safe || state.uaccess)
+				WARN_FUNC("recursive UACCESS enable", sec, insn->offset);
+
+			state.uaccess = true;
+			break;
+
+		case INSN_CLAC:
+			if (!state.uaccess && insn->func)
+				WARN_FUNC("redundant UACCESS disable", sec, insn->offset);
+
+			if (state.uaccess_safe) {
+				WARN_FUNC("UACCESS-safe disables UACCESS", sec, insn->offset);
+				break;
+			}
+
+			state.uaccess = false;
+			break;
+
 		default:
 			break;
 		}
@@ -2135,6 +2215,8 @@ static int validate_functions(struct obj
 			if (!insn || insn->ignore)
 				continue;
 
+			state.uaccess_safe = func->uaccess_safe;
+
 			ret = validate_branch(file, insn, state);
 			warnings += ret;
 		}
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -31,7 +31,7 @@ struct insn_state {
 	int stack_size;
 	unsigned char type;
 	bool bp_scratch;
-	bool drap, end;
+	bool drap, end, uaccess, uaccess_safe;
 	int drap_reg, drap_offset;
 	struct cfi_reg vals[CFI_NUM_REGS];
 };
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -62,6 +62,7 @@ struct symbol {
 	unsigned long offset;
 	unsigned int len;
 	struct symbol *pfunc, *cfunc;
+	bool uaccess_safe;
 };
 
 struct rela {


