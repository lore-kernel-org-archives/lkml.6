Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752985AbeEOV1E (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:27:04 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:48538 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752837AbeEOV0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:26:16 -0400
From: Nadav Amit <namit@vmware.com>
To: <linux-kernel@vger.kernel.org>
CC: <nadav.amit@gmail.com>, Nadav Amit <namit@vmware.com>,
        Juergen Gross <jgross@suse.com>, Alok Kataria <akataria@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        <virtualization@lists.linux-foundation.org>
Subject: [RFC 4/8] x86: prevent inline distortion by paravirt ops
Date: Tue, 15 May 2018 07:11:20 -0700
Message-ID: <20180515141124.84254-14-namit@vmware.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180515141124.84254-1-namit@vmware.com>
References: <20180515141124.84254-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
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
18131468 10068488 2936832 31136788 1db1c14 ./vmlinux before
18146418 10064100 2936832 31147350 1db4556 ./vmlinux after (+10562)

Static text symbols:
Before:	39788
After:	39673	(-115)

Cc: Juergen Gross <jgross@suse.com>
Cc: Alok Kataria <akataria@vmware.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: virtualization@lists.linux-foundation.org

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/paravirt_types.h | 53 +++++++++++++++------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 180bc0bff0fb..3fe99dab8266 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -346,20 +346,37 @@ extern struct pv_lock_ops pv_lock_ops;
 /*
  * Generate some code, and mark it as patchable by the
  * apply_paravirt() alternate instruction patcher.
+ *
+ * This generates an indirect call based on the operation type number.
+ * The type number, computed in PARAVIRT_PATCH, is derived from the
+ * offset into the paravirt_patch_template structure, and can therefore be
+ * freely converted back into a structure offset.
  */
-#define _paravirt_alt(insn_string, type, clobber)	\
-	"771:\n\t" insn_string "\n" "772:\n"		\
-	".pushsection .parainstructions,\"a\"\n"	\
-	_ASM_ALIGN "\n"					\
-	_ASM_PTR " 771b\n"				\
-	"  .byte " type "\n"				\
-	"  .byte 772b-771b\n"				\
-	"  .short " clobber "\n"			\
+
+asm ("\n"
+	".macro __paravirt_alt type:req clobber:req pv_opptr:req\n"
+	"771:\n\t"
+	ANNOTATE_RETPOLINE_SAFE "\n\t"
+	"call *\\pv_opptr\n"
+	"772:\n\t"
+	".pushsection .parainstructions,\"a\"\n\t"
+	_ASM_ALIGN "\n\t"
+	_ASM_PTR " 771b\n\t"
+	".byte \\type\n\t"
+	".byte 772b-771b\n\t"
+	".short \\clobber\n\t"
 	".popsection\n"
+	".endm");
+
+#define _paravirt_alt(type, clobber, pv_opptr)				\
+	"__paravirt_alt type=" __stringify(type)			\
+	" clobber=" __stringify(clobber)				\
+	" pv_opptr=" __stringify(pv_opptr) "\n\t"
 
 /* Generate patchable code, with the default asm parameters. */
-#define paravirt_alt(insn_string)					\
-	_paravirt_alt(insn_string, "%c[paravirt_typenum]", "%c[paravirt_clobber]")
+#define paravirt_alt							\
+	_paravirt_alt("%c[paravirt_typenum]", "%c[paravirt_clobber]",	\
+		      "%c[paravirt_opptr]")
 
 /* Simple instruction patching code. */
 #define NATIVE_LABEL(a,x,b) "\n\t.globl " a #x "_" #b "\n" a #x "_" #b ":\n\t"
@@ -387,16 +404,6 @@ unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 
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
@@ -534,7 +541,7 @@ int paravirt_disable_iospace(void);
 		/* since this condition will never hold */		\
 		if (sizeof(rettype) > sizeof(unsigned long)) {		\
 			asm volatile(pre				\
-				     paravirt_alt(PARAVIRT_CALL)	\
+				     paravirt_alt			\
 				     post				\
 				     : call_clbr, ASM_CALL_CONSTRAINT	\
 				     : paravirt_type(op),		\
@@ -544,7 +551,7 @@ int paravirt_disable_iospace(void);
 			__ret = (rettype)((((u64)__edx) << 32) | __eax); \
 		} else {						\
 			asm volatile(pre				\
-				     paravirt_alt(PARAVIRT_CALL)	\
+				     paravirt_alt			\
 				     post				\
 				     : call_clbr, ASM_CALL_CONSTRAINT	\
 				     : paravirt_type(op),		\
@@ -571,7 +578,7 @@ int paravirt_disable_iospace(void);
 		PVOP_VCALL_ARGS;					\
 		PVOP_TEST_NULL(op);					\
 		asm volatile(pre					\
-			     paravirt_alt(PARAVIRT_CALL)		\
+			     paravirt_alt				\
 			     post					\
 			     : call_clbr, ASM_CALL_CONSTRAINT		\
 			     : paravirt_type(op),			\
-- 
2.17.0
