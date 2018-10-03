Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584F5C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E756214C2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E756214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbeJDEWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 00:22:48 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:14656 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727356AbeJDEWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 00:22:47 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 3 Oct 2018 14:32:27 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id A6F12407C9;
        Wed,  3 Oct 2018 14:32:32 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Alok Kataria <akataria@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        <virtualization@lists.linux-foundation.org>
Subject: [PATCH v9 07/10] x86: prevent inline distortion by paravirt ops
Date:   Wed, 3 Oct 2018 14:30:57 -0700
Message-ID: <20181003213100.189959-8-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181003213100.189959-1-namit@vmware.com>
References: <20181003213100.189959-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC considers the number of statements in inlined assembly blocks,
according to new-lines and semicolons, as an indication to the cost of
the block in time and space. This data is distorted by the kernel code,
which puts information in alternative sections. As a result, the
compiler may perform incorrect inlining and branch optimizations.

The solution is to set an assembly macro and call it from the inlined
assembly block. As a result GCC considers the inline assembly block as
a single instruction.

The effect of the patch is a more aggressive inlining, which also
causes a size increase of kernel.

   text	   data	    bss	    dec	    hex	filename
18147336 10226688 2957312 31331336 1de1408 ./vmlinux before
18162555 10226288 2957312 31346155 1de4deb ./vmlinux after (+14819)

Static text symbols:
Before:	40053
After:	39942	(-111)

Cc: Alok Kataria <akataria@vmware.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: virtualization@lists.linux-foundation.org
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Tested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/paravirt_types.h | 56 +++++++++++++--------------
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
-- 
2.17.1

