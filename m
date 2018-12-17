Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D3DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DB0206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="XNvaAx4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388172AbeLQQH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:07:57 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:61736 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbeLQQHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:07:55 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id wBHG3bRf008119;
        Tue, 18 Dec 2018 01:03:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com wBHG3bRf008119
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545062623;
        bh=MJuvZVpe0PUrWwaBeLI0BXBLt8S1WA40UEFmOtxgUc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XNvaAx4Xn+c6F1dV+dq6w7wJ132UuTo+Z5IAcCLveUl+0eRwllBVcXd1T2uV6uebo
         iIGyVlywRojDwimX6EAC/cgQK1UHqnIvNvr/nJhdzIrdghLRfIjGpC69NF60jdfgZV
         QIVNAMje1aYvaxwMK5tB4hhDm3TI5hAQi0ujdgJxhU9TWPgpT/n6rwvbuQmqe2ysdK
         qjqG8fXGmkqtTHvZoFZOE9j+H0ZL3VSPU1n7qY2XURs0P5bqBY27JyMbmpmmkYlsOG
         iYbwozJIdfyS5xwCtYabBVGd06NCl7AyFAmkbURKfRfPn0fnm0aFzo1gwwofu+8Nnv
         WCHQqN6uH90jw==
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
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>
Subject: [PATCH v3 02/12] Revert "x86/cpufeature: Macrofy inline assembly code to work around GCC inlining bugs"
Date:   Tue, 18 Dec 2018 01:03:17 +0900
Message-Id: <1545062607-8599-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
References: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit d5a581d84ae6b8a4a740464b80d8d9cf1e7947b2.

The in-kernel workarounds will be replaced with GCC's new
"asm inline" syntax.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/include/asm/cpufeature.h | 82 +++++++++++++++++----------------------
 arch/x86/kernel/macros.S          |  1 -
 2 files changed, 35 insertions(+), 48 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 7d44272..aced6c9 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -2,10 +2,10 @@
 #ifndef _ASM_X86_CPUFEATURE_H
 #define _ASM_X86_CPUFEATURE_H
 
-#ifdef __KERNEL__
-#ifndef __ASSEMBLY__
-
 #include <asm/processor.h>
+
+#if defined(__KERNEL__) && !defined(__ASSEMBLY__)
+
 #include <asm/asm.h>
 #include <linux/bitops.h>
 
@@ -161,10 +161,37 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
  */
 static __always_inline __pure bool _static_cpu_has(u16 bit)
 {
-	asm_volatile_goto("STATIC_CPU_HAS bitnum=%[bitnum] "
-			  "cap_byte=\"%[cap_byte]\" "
-			  "feature=%P[feature] t_yes=%l[t_yes] "
-			  "t_no=%l[t_no] always=%P[always]"
+	asm_volatile_goto("1: jmp 6f\n"
+		 "2:\n"
+		 ".skip -(((5f-4f) - (2b-1b)) > 0) * "
+			 "((5f-4f) - (2b-1b)),0x90\n"
+		 "3:\n"
+		 ".section .altinstructions,\"a\"\n"
+		 " .long 1b - .\n"		/* src offset */
+		 " .long 4f - .\n"		/* repl offset */
+		 " .word %P[always]\n"		/* always replace */
+		 " .byte 3b - 1b\n"		/* src len */
+		 " .byte 5f - 4f\n"		/* repl len */
+		 " .byte 3b - 2b\n"		/* pad len */
+		 ".previous\n"
+		 ".section .altinstr_replacement,\"ax\"\n"
+		 "4: jmp %l[t_no]\n"
+		 "5:\n"
+		 ".previous\n"
+		 ".section .altinstructions,\"a\"\n"
+		 " .long 1b - .\n"		/* src offset */
+		 " .long 0\n"			/* no replacement */
+		 " .word %P[feature]\n"		/* feature bit */
+		 " .byte 3b - 1b\n"		/* src len */
+		 " .byte 0\n"			/* repl len */
+		 " .byte 0\n"			/* pad len */
+		 ".previous\n"
+		 ".section .altinstr_aux,\"ax\"\n"
+		 "6:\n"
+		 " testb %[bitnum],%[cap_byte]\n"
+		 " jnz %l[t_yes]\n"
+		 " jmp %l[t_no]\n"
+		 ".previous\n"
 		 : : [feature]  "i" (bit),
 		     [always]   "i" (X86_FEATURE_ALWAYS),
 		     [bitnum]   "i" (1 << (bit & 7)),
@@ -199,44 +226,5 @@ static __always_inline __pure bool _static_cpu_has(u16 bit)
 #define CPU_FEATURE_TYPEVAL		boot_cpu_data.x86_vendor, boot_cpu_data.x86, \
 					boot_cpu_data.x86_model
 
-#else /* __ASSEMBLY__ */
-
-.macro STATIC_CPU_HAS bitnum:req cap_byte:req feature:req t_yes:req t_no:req always:req
-1:
-	jmp 6f
-2:
-	.skip -(((5f-4f) - (2b-1b)) > 0) * ((5f-4f) - (2b-1b)),0x90
-3:
-	.section .altinstructions,"a"
-	.long 1b - .		/* src offset */
-	.long 4f - .		/* repl offset */
-	.word \always		/* always replace */
-	.byte 3b - 1b		/* src len */
-	.byte 5f - 4f		/* repl len */
-	.byte 3b - 2b		/* pad len */
-	.previous
-	.section .altinstr_replacement,"ax"
-4:
-	jmp \t_no
-5:
-	.previous
-	.section .altinstructions,"a"
-	.long 1b - .		/* src offset */
-	.long 0			/* no replacement */
-	.word \feature		/* feature bit */
-	.byte 3b - 1b		/* src len */
-	.byte 0			/* repl len */
-	.byte 0			/* pad len */
-	.previous
-	.section .altinstr_aux,"ax"
-6:
-	testb \bitnum,\cap_byte
-	jnz \t_yes
-	jmp \t_no
-	.previous
-.endm
-
-#endif /* __ASSEMBLY__ */
-
-#endif /* __KERNEL__ */
+#endif /* defined(__KERNEL__) && !defined(__ASSEMBLY__) */
 #endif /* _ASM_X86_CPUFEATURE_H */
diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
index bf8b9c9..7baa40d 100644
--- a/arch/x86/kernel/macros.S
+++ b/arch/x86/kernel/macros.S
@@ -12,4 +12,3 @@
 #include <asm/bug.h>
 #include <asm/paravirt.h>
 #include <asm/asm.h>
-#include <asm/cpufeature.h>
-- 
2.7.4

