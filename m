Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048BDC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C004E20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C004E20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbeJDQ5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:57:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41959 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbeJDQ5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:57:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w94A4Dps2703465
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 4 Oct 2018 03:04:13 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w94A4Cv62703462;
        Thu, 4 Oct 2018 03:04:12 -0700
Date:   Thu, 4 Oct 2018 03:04:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nadav Amit <tipbot@zytor.com>
Message-ID: <tip-494b5168f2de009eb80f198f668da374295098dd@git.kernel.org>
Cc:     hpa@zytor.com, keescook@chromium.org, mingo@kernel.org,
        bp@alien8.de, jgross@suse.com, namit@vmware.com,
        akataria@vmware.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, dvlasenk@redhat.com, brgerst@gmail.com,
        luto@amacapital.net
Reply-To: torvalds@linux-foundation.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          dvlasenk@redhat.com, brgerst@gmail.com, luto@amacapital.net,
          hpa@zytor.com, keescook@chromium.org, mingo@kernel.org,
          jgross@suse.com, bp@alien8.de, namit@vmware.com,
          akataria@vmware.com
In-Reply-To: <20181003213100.189959-8-namit@vmware.com>
References: <20181003213100.189959-8-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] x86/paravirt: Work around GCC inlining bugs when
 compiling paravirt ops
Git-Commit-ID: 494b5168f2de009eb80f198f668da374295098dd
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  494b5168f2de009eb80f198f668da374295098dd
Gitweb:     https://git.kernel.org/tip/494b5168f2de009eb80f198f668da374295098dd
Author:     Nadav Amit <namit@vmware.com>
AuthorDate: Wed, 3 Oct 2018 14:30:57 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 4 Oct 2018 11:25:00 +0200

x86/paravirt: Work around GCC inlining bugs when compiling paravirt ops

As described in:

  77b0bf55bc67: ("kbuild/Makefile: Prepare for using macros in inline assembly code to work around asm() related GCC inlining bugs")

GCC's inlining heuristics are broken with common asm() patterns used in
kernel code, resulting in the effective disabling of inlining.

The workaround is to set an assembly macro and call it from the inline
assembly block. As a result GCC considers the inline assembly block as
a single instruction. (Which it isn't, but that's the best we can get.)

In this patch we wrap the paravirt call section tricks in a macro,
to hide it from GCC.

The effect of the patch is a more aggressive inlining, which also
causes a size increase of kernel.

      text     data     bss      dec     hex  filename
  18147336 10226688 2957312 31331336 1de1408  ./vmlinux before
  18162555 10226288 2957312 31346155 1de4deb  ./vmlinux after (+14819)

The number of static text symbols (non-inlined functions) goes down:

  Before: 40053
  After:  39942 (-111)

[ mingo: Rewrote the changelog. ]

Tested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alok Kataria <akataria@vmware.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: virtualization@lists.linux-foundation.org
Link: http://lkml.kernel.org/r/20181003213100.189959-8-namit@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/paravirt_types.h | 56 +++++++++++++++++------------------
 arch/x86/kernel/macros.S              |  1 +
 2 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 4b75acc23b30..83ce282eed0a 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -346,23 +346,11 @@ extern struct pv_lock_ops pv_lock_ops;
 #define paravirt_clobber(clobber)		\
 	[paravirt_clobber] "i" (clobber)
 
-/*
- * Generate some code, and mark it as patchable by the
- * apply_paravirt() alternate instruction patcher.
- */
-#define _paravirt_alt(insn_string, type, clobber)	\
-	"771:\n\t" insn_string "\n" "772:\n"		\
-	".pushsection .parainstructions,\"a\"\n"	\
-	_ASM_ALIGN "\n"					\
-	_ASM_PTR " 771b\n"				\
-	"  .byte " type "\n"				\
-	"  .byte 772b-771b\n"				\
-	"  .short " clobber "\n"			\
-	".popsection\n"
-
 /* Generate patchable code, with the default asm parameters. */
-#define paravirt_alt(insn_string)					\
-	_paravirt_alt(insn_string, "%c[paravirt_typenum]", "%c[paravirt_clobber]")
+#define paravirt_call							\
+	"PARAVIRT_CALL type=\"%c[paravirt_typenum]\""			\
+	" clobber=\"%c[paravirt_clobber]\""				\
+	" pv_opptr=\"%c[paravirt_opptr]\";"
 
 /* Simple instruction patching code. */
 #define NATIVE_LABEL(a,x,b) "\n\t.globl " a #x "_" #b "\n" a #x "_" #b ":\n\t"
@@ -390,16 +378,6 @@ unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 
 int paravirt_disable_iospace(void);
 
-/*
- * This generates an indirect call based on the operation type number.
- * The type number, computed in PARAVIRT_PATCH, is derived from the
- * offset into the paravirt_patch_template structure, and can therefore be
- * freely converted back into a structure offset.
- */
-#define PARAVIRT_CALL					\
-	ANNOTATE_RETPOLINE_SAFE				\
-	"call *%c[paravirt_opptr];"
-
 /*
  * These macros are intended to wrap calls through one of the paravirt
  * ops structs, so that they can be later identified and patched at
@@ -537,7 +515,7 @@ int paravirt_disable_iospace(void);
 		/* since this condition will never hold */		\
 		if (sizeof(rettype) > sizeof(unsigned long)) {		\
 			asm volatile(pre				\
-				     paravirt_alt(PARAVIRT_CALL)	\
+				     paravirt_call			\
 				     post				\
 				     : call_clbr, ASM_CALL_CONSTRAINT	\
 				     : paravirt_type(op),		\
@@ -547,7 +525,7 @@ int paravirt_disable_iospace(void);
 			__ret = (rettype)((((u64)__edx) << 32) | __eax); \
 		} else {						\
 			asm volatile(pre				\
-				     paravirt_alt(PARAVIRT_CALL)	\
+				     paravirt_call			\
 				     post				\
 				     : call_clbr, ASM_CALL_CONSTRAINT	\
 				     : paravirt_type(op),		\
@@ -574,7 +552,7 @@ int paravirt_disable_iospace(void);
 		PVOP_VCALL_ARGS;					\
 		PVOP_TEST_NULL(op);					\
 		asm volatile(pre					\
-			     paravirt_alt(PARAVIRT_CALL)		\
+			     paravirt_call				\
 			     post					\
 			     : call_clbr, ASM_CALL_CONSTRAINT		\
 			     : paravirt_type(op),			\
@@ -694,6 +672,26 @@ struct paravirt_patch_site {
 extern struct paravirt_patch_site __parainstructions[],
 	__parainstructions_end[];
 
+#else	/* __ASSEMBLY__ */
+
+/*
+ * This generates an indirect call based on the operation type number.
+ * The type number, computed in PARAVIRT_PATCH, is derived from the
+ * offset into the paravirt_patch_template structure, and can therefore be
+ * freely converted back into a structure offset.
+ */
+.macro PARAVIRT_CALL type:req clobber:req pv_opptr:req
+771:	ANNOTATE_RETPOLINE_SAFE
+	call *\pv_opptr
+772:	.pushsection .parainstructions,"a"
+	_ASM_ALIGN
+	_ASM_PTR 771b
+	.byte \type
+	.byte 772b-771b
+	.short \clobber
+	.popsection
+.endm
+
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* _ASM_X86_PARAVIRT_TYPES_H */
diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
index 66ccb8e823b1..71d8b716b111 100644
--- a/arch/x86/kernel/macros.S
+++ b/arch/x86/kernel/macros.S
@@ -10,3 +10,4 @@
 #include <asm/refcount.h>
 #include <asm/alternative-asm.h>
 #include <asm/bug.h>
+#include <asm/paravirt.h>
