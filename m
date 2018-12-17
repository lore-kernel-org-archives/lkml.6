Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E3CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA112206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Ob0D0mxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388165AbeLQQK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:10:57 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:64908 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387635AbeLQQK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:10:56 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id wBHG3bRh008119;
        Tue, 18 Dec 2018 01:03:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com wBHG3bRh008119
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545062626;
        bh=4SKjXoI2Jxb7F0Ixp5LIs9imyh9UsRJoHsSQtzSTnpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ob0D0mxV+BsEDq6V+1LAf0RhGlCEM1YU31zLHp3MSmuJpGmgessOc4JqsfHqmIRjy
         en0clOvcCoQLoQ1A8LHb9/MHkNZbg3iOmvogaWc1wZWPBHH+xXtiLpoB63U0a+qymH
         7CBQFGfP9IiOOytKQNiXoKyTMMONZvypdX1TjswZx8VCg/Qdsj6t9Pw12PVUqQFEtM
         jdhzDyR+IJaDskeKs6Y6xs7I2nXm6mNzMOGs3a6eP6hi+w5+FOVxPHPv6PmNZJeK0O
         /np0CI0VSaaqALy7qf4Exg/OeLcoMyuIHPxXTXuGI4oeuOjdF6gLIGxF/MuQCBO9+h
         +oG/9cmWVEgHA==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Richard Biener <rguenther@suse.de>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nadav Amit <namit@vmware.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Alok Kataria <akataria@vmware.com>
Subject: [PATCH v3 04/12] Revert "x86/paravirt: Work around GCC inlining bugs when compiling paravirt ops"
Date:   Tue, 18 Dec 2018 01:03:19 +0900
Message-Id: <1545062607-8599-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
References: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 494b5168f2de009eb80f198f668da374295098dd.

The in-kernel workarounds will be replaced with GCC's new
"asm inline" syntax.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/include/asm/paravirt_types.h | 56 ++++++++++++++++++-----------------
 arch/x86/kernel/macros.S              |  1 -
 2 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 26942ad..488c596 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -348,11 +348,23 @@ extern struct paravirt_patch_template pv_ops;
 #define paravirt_clobber(clobber)		\
 	[paravirt_clobber] "i" (clobber)
 
+/*
+ * Generate some code, and mark it as patchable by the
+ * apply_paravirt() alternate instruction patcher.
+ */
+#define _paravirt_alt(insn_string, type, clobber)	\
+	"771:\n\t" insn_string "\n" "772:\n"		\
+	".pushsection .parainstructions,\"a\"\n"	\
+	_ASM_ALIGN "\n"					\
+	_ASM_PTR " 771b\n"				\
+	"  .byte " type "\n"				\
+	"  .byte 772b-771b\n"				\
+	"  .short " clobber "\n"			\
+	".popsection\n"
+
 /* Generate patchable code, with the default asm parameters. */
-#define paravirt_call							\
-	"PARAVIRT_CALL type=\"%c[paravirt_typenum]\""			\
-	" clobber=\"%c[paravirt_clobber]\""				\
-	" pv_opptr=\"%c[paravirt_opptr]\";"
+#define paravirt_alt(insn_string)					\
+	_paravirt_alt(insn_string, "%c[paravirt_typenum]", "%c[paravirt_clobber]")
 
 /* Simple instruction patching code. */
 #define NATIVE_LABEL(a,x,b) "\n\t.globl " a #x "_" #b "\n" a #x "_" #b ":\n\t"
@@ -373,6 +385,16 @@ unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len);
 int paravirt_disable_iospace(void);
 
 /*
+ * This generates an indirect call based on the operation type number.
+ * The type number, computed in PARAVIRT_PATCH, is derived from the
+ * offset into the paravirt_patch_template structure, and can therefore be
+ * freely converted back into a structure offset.
+ */
+#define PARAVIRT_CALL					\
+	ANNOTATE_RETPOLINE_SAFE				\
+	"call *%c[paravirt_opptr];"
+
+/*
  * These macros are intended to wrap calls through one of the paravirt
  * ops structs, so that they can be later identified and patched at
  * runtime.
@@ -509,7 +531,7 @@ int paravirt_disable_iospace(void);
 		/* since this condition will never hold */		\
 		if (sizeof(rettype) > sizeof(unsigned long)) {		\
 			asm volatile(pre				\
-				     paravirt_call			\
+				     paravirt_alt(PARAVIRT_CALL)	\
 				     post				\
 				     : call_clbr, ASM_CALL_CONSTRAINT	\
 				     : paravirt_type(op),		\
@@ -519,7 +541,7 @@ int paravirt_disable_iospace(void);
 			__ret = (rettype)((((u64)__edx) << 32) | __eax); \
 		} else {						\
 			asm volatile(pre				\
-				     paravirt_call			\
+				     paravirt_alt(PARAVIRT_CALL)	\
 				     post				\
 				     : call_clbr, ASM_CALL_CONSTRAINT	\
 				     : paravirt_type(op),		\
@@ -546,7 +568,7 @@ int paravirt_disable_iospace(void);
 		PVOP_VCALL_ARGS;					\
 		PVOP_TEST_NULL(op);					\
 		asm volatile(pre					\
-			     paravirt_call				\
+			     paravirt_alt(PARAVIRT_CALL)		\
 			     post					\
 			     : call_clbr, ASM_CALL_CONSTRAINT		\
 			     : paravirt_type(op),			\
@@ -664,26 +686,6 @@ struct paravirt_patch_site {
 extern struct paravirt_patch_site __parainstructions[],
 	__parainstructions_end[];
 
-#else	/* __ASSEMBLY__ */
-
-/*
- * This generates an indirect call based on the operation type number.
- * The type number, computed in PARAVIRT_PATCH, is derived from the
- * offset into the paravirt_patch_template structure, and can therefore be
- * freely converted back into a structure offset.
- */
-.macro PARAVIRT_CALL type:req clobber:req pv_opptr:req
-771:	ANNOTATE_RETPOLINE_SAFE
-	call *\pv_opptr
-772:	.pushsection .parainstructions,"a"
-	_ASM_ALIGN
-	_ASM_PTR 771b
-	.byte \type
-	.byte 772b-771b
-	.short \clobber
-	.popsection
-.endm
-
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* _ASM_X86_PARAVIRT_TYPES_H */
diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
index 71d8b71..66ccb8e 100644
--- a/arch/x86/kernel/macros.S
+++ b/arch/x86/kernel/macros.S
@@ -10,4 +10,3 @@
 #include <asm/refcount.h>
 #include <asm/alternative-asm.h>
 #include <asm/bug.h>
-#include <asm/paravirt.h>
-- 
2.7.4

