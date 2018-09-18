Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9579C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC10214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC10214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbeISDFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:05:09 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:1294 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730519AbeISDFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:05:07 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 18 Sep 2018 14:30:10 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 7C0D4B0BFE;
        Tue, 18 Sep 2018 17:30:35 -0400 (EDT)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Christopher Li <sparse@chrisli.org>,
        <linux-sparse@vger.kernel.org>
Subject: [PATCH v8 03/10] x86: objtool: use asm macro for better compiler decisions
Date:   Tue, 18 Sep 2018 14:28:40 -0700
Message-ID: <20180918212847.199085-4-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180918212847.199085-1-namit@vmware.com>
References: <20180918212847.199085-1-namit@vmware.com>
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

In the case of objtool, this distortion is extreme, since anyhow the
annotations of objtool are discarded during linkage.

The solution is to set an assembly macro and call it from the inline
assembly block. As a result GCC considers the inline assembly block as
a single instruction.

This patch slightly increases the kernel size.

   text	   data	    bss	    dec	    hex	filename
18140829 10224724 2957312 31322865 1ddf2f1 ./vmlinux before
18140970 10225412 2957312 31323694 1ddf62e ./vmlinux after (+829)

Static text symbols:
Before:	40321
After:	40302	(-19)

Cc: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/kernel/macros.S |  2 ++
 include/linux/compiler.h | 56 ++++++++++++++++++++++++++++++----------
 2 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
index cfc1c7d1a6eb..cee28c3246dc 100644
--- a/arch/x86/kernel/macros.S
+++ b/arch/x86/kernel/macros.S
@@ -5,3 +5,5 @@
  * commonly used. The macros are precompiled into assmebly file which is later
  * assembled together with each compiled file.
  */
+
+#include <linux/compiler.h>
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 681d866efb1e..1921545c6351 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -99,22 +99,13 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  * unique, to convince GCC not to merge duplicate inline asm statements.
  */
 #define annotate_reachable() ({						\
-	asm volatile("%c0:\n\t"						\
-		     ".pushsection .discard.reachable\n\t"		\
-		     ".long %c0b - .\n\t"				\
-		     ".popsection\n\t" : : "i" (__COUNTER__));		\
+	asm volatile("ANNOTATE_REACHABLE counter=%c0"			\
+		     : : "i" (__COUNTER__));				\
 })
 #define annotate_unreachable() ({					\
-	asm volatile("%c0:\n\t"						\
-		     ".pushsection .discard.unreachable\n\t"		\
-		     ".long %c0b - .\n\t"				\
-		     ".popsection\n\t" : : "i" (__COUNTER__));		\
+	asm volatile("ANNOTATE_UNREACHABLE counter=%c0"			\
+		     : : "i" (__COUNTER__));				\
 })
-#define ASM_UNREACHABLE							\
-	"999:\n\t"							\
-	".pushsection .discard.unreachable\n\t"				\
-	".long 999b - .\n\t"						\
-	".popsection\n\t"
 #else
 #define annotate_reachable()
 #define annotate_unreachable()
@@ -299,6 +290,45 @@ static inline void *offset_to_ptr(const int *off)
 	return (void *)((unsigned long)off + *off);
 }
 
+#else /* __ASSEMBLY__ */
+
+#ifdef __KERNEL__
+#ifndef LINKER_SCRIPT
+
+#ifdef CONFIG_STACK_VALIDATION
+.macro ANNOTATE_UNREACHABLE counter:req
+\counter:
+	.pushsection .discard.unreachable
+	.long \counter\()b -.
+	.popsection
+.endm
+
+.macro ANNOTATE_REACHABLE counter:req
+\counter:
+	.pushsection .discard.reachable
+	.long \counter\()b -.
+	.popsection
+.endm
+
+.macro ASM_UNREACHABLE
+999:
+	.pushsection .discard.unreachable
+	.long 999b - .
+	.popsection
+.endm
+#else /* CONFIG_STACK_VALIDATION */
+.macro ANNOTATE_UNREACHABLE counter:req
+.endm
+
+.macro ANNOTATE_REACHABLE counter:req
+.endm
+
+.macro ASM_UNREACHABLE
+.endm
+#endif /* CONFIG_STACK_VALIDATION */
+
+#endif /* LINKER_SCRIPT */
+#endif /* __KERNEL__ */
 #endif /* __ASSEMBLY__ */
 
 #ifndef __optimize
-- 
2.17.1

