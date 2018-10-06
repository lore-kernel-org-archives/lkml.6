Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8102C65C31
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 14:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C37E2089D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 14:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C37E2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeJFVro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 17:47:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41045 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbeJFVro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 17:47:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w96EhSuB3576900
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 6 Oct 2018 07:43:28 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w96EhSeH3576897;
        Sat, 6 Oct 2018 07:43:28 -0700
Date:   Sat, 6 Oct 2018 07:43:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nadav Amit <tipbot@zytor.com>
Message-ID: <tip-d5a581d84ae6b8a4a740464b80d8d9cf1e7947b2@git.kernel.org>
Cc:     mingo@kernel.org, bp@alien8.de, torvalds@linux-foundation.org,
        luto@amacapital.net, tglx@linutronix.de, keescook@chromium.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        brgerst@gmail.com, hpa@zytor.com, namit@vmware.com,
        dvlasenk@redhat.com
Reply-To: bp@alien8.de, luto@amacapital.net, torvalds@linux-foundation.org,
          mingo@kernel.org, hpa@zytor.com, brgerst@gmail.com,
          namit@vmware.com, dvlasenk@redhat.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          keescook@chromium.org, tglx@linutronix.de
In-Reply-To: <20181005202718.229565-3-namit@vmware.com>
References: <20181005202718.229565-3-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] x86/cpufeature: Macrofy inline assembly code to
 work around GCC inlining bugs
Git-Commit-ID: d5a581d84ae6b8a4a740464b80d8d9cf1e7947b2
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

Commit-ID:  d5a581d84ae6b8a4a740464b80d8d9cf1e7947b2
Gitweb:     https://git.kernel.org/tip/d5a581d84ae6b8a4a740464b80d8d9cf1e7947b2
Author:     Nadav Amit <namit@vmware.com>
AuthorDate: Fri, 5 Oct 2018 13:27:17 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 6 Oct 2018 15:52:16 +0200

x86/cpufeature: Macrofy inline assembly code to work around GCC inlining bugs

As described in:

  77b0bf55bc67: ("kbuild/Makefile: Prepare for using macros in inline assembly code to work around asm() related GCC inlining bugs")

GCC's inlining heuristics are broken with common asm() patterns used in
kernel code, resulting in the effective disabling of inlining.

The workaround is to set an assembly macro and call it from the inline
assembly block - which is pretty pointless indirection in the static_cpu_has()
case, but is worth it to improve overall inlining quality.

The patch slightly increases the kernel size:

      text     data     bss      dec     hex  filename
  18162879 10226256 2957312 31346447 1de4f0f  ./vmlinux before
  18163528 10226300 2957312 31347140 1de51c4  ./vmlinux after (+693)

And enables the inlining of function such as free_ldt_pgtables().

Tested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181005202718.229565-3-namit@vmware.com
Link: https://lore.kernel.org/lkml/20181003213100.189959-10-namit@vmware.com/T/#u
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/cpufeature.h | 82 ++++++++++++++++++++++-----------------
 arch/x86/kernel/macros.S          |  1 +
 2 files changed, 48 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index aced6c9290d6..7d442722ef24 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -2,10 +2,10 @@
 #ifndef _ASM_X86_CPUFEATURE_H
 #define _ASM_X86_CPUFEATURE_H
 
-#include <asm/processor.h>
-
-#if defined(__KERNEL__) && !defined(__ASSEMBLY__)
+#ifdef __KERNEL__
+#ifndef __ASSEMBLY__
 
+#include <asm/processor.h>
 #include <asm/asm.h>
 #include <linux/bitops.h>
 
@@ -161,37 +161,10 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
  */
 static __always_inline __pure bool _static_cpu_has(u16 bit)
 {
-	asm_volatile_goto("1: jmp 6f\n"
-		 "2:\n"
-		 ".skip -(((5f-4f) - (2b-1b)) > 0) * "
-			 "((5f-4f) - (2b-1b)),0x90\n"
-		 "3:\n"
-		 ".section .altinstructions,\"a\"\n"
-		 " .long 1b - .\n"		/* src offset */
-		 " .long 4f - .\n"		/* repl offset */
-		 " .word %P[always]\n"		/* always replace */
-		 " .byte 3b - 1b\n"		/* src len */
-		 " .byte 5f - 4f\n"		/* repl len */
-		 " .byte 3b - 2b\n"		/* pad len */
-		 ".previous\n"
-		 ".section .altinstr_replacement,\"ax\"\n"
-		 "4: jmp %l[t_no]\n"
-		 "5:\n"
-		 ".previous\n"
-		 ".section .altinstructions,\"a\"\n"
-		 " .long 1b - .\n"		/* src offset */
-		 " .long 0\n"			/* no replacement */
-		 " .word %P[feature]\n"		/* feature bit */
-		 " .byte 3b - 1b\n"		/* src len */
-		 " .byte 0\n"			/* repl len */
-		 " .byte 0\n"			/* pad len */
-		 ".previous\n"
-		 ".section .altinstr_aux,\"ax\"\n"
-		 "6:\n"
-		 " testb %[bitnum],%[cap_byte]\n"
-		 " jnz %l[t_yes]\n"
-		 " jmp %l[t_no]\n"
-		 ".previous\n"
+	asm_volatile_goto("STATIC_CPU_HAS bitnum=%[bitnum] "
+			  "cap_byte=\"%[cap_byte]\" "
+			  "feature=%P[feature] t_yes=%l[t_yes] "
+			  "t_no=%l[t_no] always=%P[always]"
 		 : : [feature]  "i" (bit),
 		     [always]   "i" (X86_FEATURE_ALWAYS),
 		     [bitnum]   "i" (1 << (bit & 7)),
@@ -226,5 +199,44 @@ t_no:
 #define CPU_FEATURE_TYPEVAL		boot_cpu_data.x86_vendor, boot_cpu_data.x86, \
 					boot_cpu_data.x86_model
 
-#endif /* defined(__KERNEL__) && !defined(__ASSEMBLY__) */
+#else /* __ASSEMBLY__ */
+
+.macro STATIC_CPU_HAS bitnum:req cap_byte:req feature:req t_yes:req t_no:req always:req
+1:
+	jmp 6f
+2:
+	.skip -(((5f-4f) - (2b-1b)) > 0) * ((5f-4f) - (2b-1b)),0x90
+3:
+	.section .altinstructions,"a"
+	.long 1b - .		/* src offset */
+	.long 4f - .		/* repl offset */
+	.word \always		/* always replace */
+	.byte 3b - 1b		/* src len */
+	.byte 5f - 4f		/* repl len */
+	.byte 3b - 2b		/* pad len */
+	.previous
+	.section .altinstr_replacement,"ax"
+4:
+	jmp \t_no
+5:
+	.previous
+	.section .altinstructions,"a"
+	.long 1b - .		/* src offset */
+	.long 0			/* no replacement */
+	.word \feature		/* feature bit */
+	.byte 3b - 1b		/* src len */
+	.byte 0			/* repl len */
+	.byte 0			/* pad len */
+	.previous
+	.section .altinstr_aux,"ax"
+6:
+	testb \bitnum,\cap_byte
+	jnz \t_yes
+	jmp \t_no
+	.previous
+.endm
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __KERNEL__ */
 #endif /* _ASM_X86_CPUFEATURE_H */
diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
index 7baa40d5bf16..bf8b9c93e255 100644
--- a/arch/x86/kernel/macros.S
+++ b/arch/x86/kernel/macros.S
@@ -12,3 +12,4 @@
 #include <asm/bug.h>
 #include <asm/paravirt.h>
 #include <asm/asm.h>
+#include <asm/cpufeature.h>
