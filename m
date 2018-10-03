Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7DAC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B37E214C2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B37E214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeJDEWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 00:22:49 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:14656 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727234AbeJDEWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 00:22:47 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 3 Oct 2018 14:32:27 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id BAC94407D2;
        Wed,  3 Oct 2018 14:32:32 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v9 09/10] x86: cpufeature: use macros instead of inline assembly
Date:   Wed, 3 Oct 2018 14:30:59 -0700
Message-ID: <20181003213100.189959-10-namit@vmware.com>
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

Use assembly macros for static_cpu_has() and call them from inline
assembly.  This not only makes the code more readable, but also improves
compilation decision, specifically inline decisions which GCC base on
the number of new lines in inline assembly.

The patch slightly increases the kernel size:

   text	   data	    bss	    dec	    hex	filename
18162879 10226256 2957312 31346447 1de4f0f ./vmlinux before
18163528 10226300 2957312 31347140 1de51c4 ./vmlinux after (+693)

And enables the inlining of function such as free_ldt_pgtables().

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/cpufeature.h | 82 ++++++++++++++++++-------------
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
@@ -226,5 +199,44 @@ static __always_inline __pure bool _static_cpu_has(u16 bit)
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
-- 
2.17.1

