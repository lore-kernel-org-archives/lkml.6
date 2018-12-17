Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D22C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADCE206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="UvhPspAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388248AbeLQQLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:11:16 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:65246 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeLQQLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:11:15 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id wBHG3bRo008119;
        Tue, 18 Dec 2018 01:03:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com wBHG3bRo008119
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545062636;
        bh=9DcjqEmtpr1b4GO1cESJaDoe5JvvAOWZuwQM0QNgknw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UvhPspADlIzQrlh8fdDk3sHogE5Obsyfz5Xbk6iOPgw/3syRRNOCSUp+v19VRTYbF
         yv/kVKF3IUHFyNSDOJ2xSs0KWaU86eCCvr9CUYCBIvSyZzcF07hd1ucJYyYC398Cl1
         1M9DVQPruecUvJvSJIn8udJzLRdtGxg8EG0fIBE+Ky5ycLNf6RZjzyjnk3Ffiih7B4
         q3o8TRd+iEt8z8ioUyvkYjcykB12cGBUmCm/rVQQOHu9aUZzjJ2QeFJd524UPuUpCK
         LGSOU7Ya1VNHFcC0MRO5ecxjDetrFNH28Hkz3ZqrNXeJNrttOAPKI65WljADIlgOc0
         7QehQi0VxnvoQ==
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
        David Woodhouse <dwmw@amazon.co.uk>,
        linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v3 11/12] x86/alternatives: consolidate LOCK_PREFIX macro
Date:   Tue, 18 Dec 2018 01:03:26 +0900
Message-Id: <1545062607-8599-12-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
References: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LOCK_PREFIX is mostly used in inline asm, but also used by
atomic64_cx8_32.S

Let's unify the definition by using ASM() macro.

This was previously cleaned up by 77f48ec28e4c ("x86/alternatives:
Macrofy lock prefixes to work around GCC inlining bugs").

Now, I am refactoring the code without using the macros approach.

The new header <asm/alternative-common.h> contains macros that
can be used by C and assembly.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/include/asm/alternative-asm.h    | 14 +--------
 arch/x86/include/asm/alternative-common.h | 47 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/alternative.h        | 37 +-----------------------
 3 files changed, 49 insertions(+), 49 deletions(-)
 create mode 100644 arch/x86/include/asm/alternative-common.h

diff --git a/arch/x86/include/asm/alternative-asm.h b/arch/x86/include/asm/alternative-asm.h
index 31b627b..7425514 100644
--- a/arch/x86/include/asm/alternative-asm.h
+++ b/arch/x86/include/asm/alternative-asm.h
@@ -4,21 +4,9 @@
 
 #ifdef __ASSEMBLY__
 
+#include <asm/alternative-common.h>
 #include <asm/asm.h>
 
-#ifdef CONFIG_SMP
-	.macro LOCK_PREFIX
-672:	lock
-	.pushsection .smp_locks,"a"
-	.balign 4
-	.long 672b - .
-	.popsection
-	.endm
-#else
-	.macro LOCK_PREFIX
-	.endm
-#endif
-
 /*
  * Issue one struct alt_instr descriptor entry (need to put it into
  * the section .altinstructions, see below). This entry contains
diff --git a/arch/x86/include/asm/alternative-common.h b/arch/x86/include/asm/alternative-common.h
new file mode 100644
index 0000000..ae0b58f
--- /dev/null
+++ b/arch/x86/include/asm/alternative-common.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_ALTERNATIVE_COMMON_H
+#define _ASM_X86_ALTERNATIVE_COMMON_H
+
+#include <linux/linkage.h>
+
+/*
+ * Alternative inline assembly for SMP.
+ *
+ * The LOCK_PREFIX macro defined here replaces the LOCK and
+ * LOCK_PREFIX macros used everywhere in the source tree.
+ *
+ * SMP alternatives use the same data structures as the other
+ * alternatives and the X86_FEATURE_UP flag to indicate the case of a
+ * UP system running a SMP kernel.  The existing apply_alternatives()
+ * works fine for patching a SMP kernel for UP.
+ *
+ * The SMP alternative tables can be kept after boot and contain both
+ * UP and SMP versions of the instructions to allow switching back to
+ * SMP at runtime, when hotplugging in a new CPU, which is especially
+ * useful in virtualized environments.
+ *
+ * The very common lock prefix is handled as special case in a
+ * separate table which is a pure address list without replacement ptr
+ * and size information.  That keeps the table sizes small.
+ */
+
+#include <linux/linkage.h>
+#include <linux/stringify.h>
+
+#ifdef CONFIG_SMP
+
+#define LOCK_PREFIX_HERE			 \
+ASM(	.pushsection .smp_locks,"a"		)\
+ASM(	.balign 4				)\
+ASM(	.long 671f - .				)\
+ASM(	.popsection				)\
+ASM( 671:					)
+
+#define LOCK_PREFIX	LOCK_PREFIX_HERE	ASM(lock)
+
+#else /* ! CONFIG_SMP */
+#define LOCK_PREFIX_HERE	ASM()
+#define LOCK_PREFIX		ASM()
+#endif
+
+#endif  /* _ASM_X86_ALTERNATIVE_COMMON_H */
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 4cd6a3b..157967c 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -7,44 +7,9 @@
 #include <linux/types.h>
 #include <linux/stddef.h>
 #include <linux/stringify.h>
+#include <asm/alternative-common.h>
 #include <asm/asm.h>
 
-/*
- * Alternative inline assembly for SMP.
- *
- * The LOCK_PREFIX macro defined here replaces the LOCK and
- * LOCK_PREFIX macros used everywhere in the source tree.
- *
- * SMP alternatives use the same data structures as the other
- * alternatives and the X86_FEATURE_UP flag to indicate the case of a
- * UP system running a SMP kernel.  The existing apply_alternatives()
- * works fine for patching a SMP kernel for UP.
- *
- * The SMP alternative tables can be kept after boot and contain both
- * UP and SMP versions of the instructions to allow switching back to
- * SMP at runtime, when hotplugging in a new CPU, which is especially
- * useful in virtualized environments.
- *
- * The very common lock prefix is handled as special case in a
- * separate table which is a pure address list without replacement ptr
- * and size information.  That keeps the table sizes small.
- */
-
-#ifdef CONFIG_SMP
-#define LOCK_PREFIX_HERE \
-		".pushsection .smp_locks,\"a\"\n"	\
-		".balign 4\n"				\
-		".long 671f - .\n" /* offset */		\
-		".popsection\n"				\
-		"671:"
-
-#define LOCK_PREFIX LOCK_PREFIX_HERE "\n\tlock; "
-
-#else /* ! CONFIG_SMP */
-#define LOCK_PREFIX_HERE ""
-#define LOCK_PREFIX ""
-#endif
-
 struct alt_instr {
 	s32 instr_offset;	/* original instruction */
 	s32 repl_offset;	/* offset to replacement instruction */
-- 
2.7.4

