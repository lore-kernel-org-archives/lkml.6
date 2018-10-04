Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5994C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F5920652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F5920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeJDQzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:55:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47883 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbeJDQzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:55:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w94A21q92701337
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 4 Oct 2018 03:02:01 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w94A216p2701334;
        Thu, 4 Oct 2018 03:02:01 -0700
Date:   Thu, 4 Oct 2018 03:02:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nadav Amit <tipbot@zytor.com>
Message-ID: <tip-c06c4d8090513f2974dfdbed2ac98634357ac475@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, keescook@chromium.org, luto@amacapital.net,
        namit@vmware.com, sparse@chrisli.org, hpa@zytor.com,
        dvlasenk@redhat.com, mingo@kernel.org, bp@alien8.de,
        torvalds@linux-foundation.org, jpoimboe@redhat.com,
        brgerst@gmail.com
Reply-To: brgerst@gmail.com, bp@alien8.de, torvalds@linux-foundation.org,
          jpoimboe@redhat.com, hpa@zytor.com, sparse@chrisli.org,
          dvlasenk@redhat.com, mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          keescook@chromium.org, namit@vmware.com, luto@amacapital.net
In-Reply-To: <20181003213100.189959-4-namit@vmware.com>
References: <20181003213100.189959-4-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] x86/objtool: Use asm macros to work around GCC
 inlining bugs
Git-Commit-ID: c06c4d8090513f2974dfdbed2ac98634357ac475
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

Commit-ID:  c06c4d8090513f2974dfdbed2ac98634357ac475
Gitweb:     https://git.kernel.org/tip/c06c4d8090513f2974dfdbed2ac98634357ac475
Author:     Nadav Amit <namit@vmware.com>
AuthorDate: Wed, 3 Oct 2018 14:30:53 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 4 Oct 2018 11:24:58 +0200

x86/objtool: Use asm macros to work around GCC inlining bugs

As described in:

  77b0bf55bc67: ("kbuild/Makefile: Prepare for using macros in inline assembly code to work around asm() related GCC inlining bugs")

GCC's inlining heuristics are broken with common asm() patterns used in
kernel code, resulting in the effective disabling of inlining.

In the case of objtool the resulting borkage can be significant, since all the
annotations of objtool are discarded during linkage and never inlined,
yet GCC bogusly considers most functions affected by objtool annotations
as 'too large'.

The workaround is to set an assembly macro and call it from the inline
assembly block. As a result GCC considers the inline assembly block as
a single instruction. (Which it isn't, but that's the best we can get.)

This increases the kernel size slightly:

      text     data     bss      dec     hex filename
  18140829 10224724 2957312 31322865 1ddf2f1 ./vmlinux before
  18140970 10225412 2957312 31323694 1ddf62e ./vmlinux after (+829)

The number of static text symbols (i.e. non-inlined functions) is reduced:

  Before:  40321
  After:   40302 (-19)

[ mingo: Rewrote the changelog. ]

Tested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-sparse@vger.kernel.org
Link: http://lkml.kernel.org/r/20181003213100.189959-4-namit@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/macros.S |  2 ++
 include/linux/compiler.h | 56 +++++++++++++++++++++++++++++++++++++-----------
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
