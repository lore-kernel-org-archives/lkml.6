Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233C0C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69EB20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69EB20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbeJDQ43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:56:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50309 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeJDQ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:56:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w94A35Re2701847
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 4 Oct 2018 03:03:05 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w94A350F2701844;
        Thu, 4 Oct 2018 03:03:05 -0700
Date:   Thu, 4 Oct 2018 03:03:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nadav Amit <tipbot@zytor.com>
Message-ID: <tip-77f48ec28e4ccff94d2e5f4260a83ac27a7f3099@git.kernel.org>
Cc:     keescook@chromium.org, luto@amacapital.net, jpoimboe@redhat.com,
        bp@alien8.de, peterz@infradead.org, linux-kernel@vger.kernel.org,
        dvlasenk@redhat.com, hpa@zytor.com, brgerst@gmail.com,
        namit@vmware.com, torvalds@linux-foundation.org, mingo@kernel.org,
        tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, peterz@infradead.org,
          keescook@chromium.org, bp@alien8.de, luto@amacapital.net,
          jpoimboe@redhat.com, namit@vmware.com, tglx@linutronix.de,
          mingo@kernel.org, torvalds@linux-foundation.org,
          brgerst@gmail.com, dvlasenk@redhat.com, hpa@zytor.com
In-Reply-To: <20181003213100.189959-6-namit@vmware.com>
References: <20181003213100.189959-6-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] x86/alternatives: Macrofy lock prefixes to work
 around GCC inlining bugs
Git-Commit-ID: 77f48ec28e4ccff94d2e5f4260a83ac27a7f3099
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

Commit-ID:  77f48ec28e4ccff94d2e5f4260a83ac27a7f3099
Gitweb:     https://git.kernel.org/tip/77f48ec28e4ccff94d2e5f4260a83ac27a7f3099
Author:     Nadav Amit <namit@vmware.com>
AuthorDate: Wed, 3 Oct 2018 14:30:55 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 4 Oct 2018 11:24:59 +0200

x86/alternatives: Macrofy lock prefixes to work around GCC inlining bugs

As described in:

  77b0bf55bc67: ("kbuild/Makefile: Prepare for using macros in inline assembly code to work around asm() related GCC inlining bugs")

GCC's inlining heuristics are broken with common asm() patterns used in
kernel code, resulting in the effective disabling of inlining.

The workaround is to set an assembly macro and call it from the inline
assembly block - i.e. to macrify the affected block.

As a result GCC considers the inline assembly block as a single instruction.

This patch handles the LOCK prefix, allowing more aggresive inlining:

      text     data     bss      dec     hex  filename
  18140140 10225284 2957312 31322736 1ddf270  ./vmlinux before
  18146889 10225380 2957312 31329581 1de0d2d  ./vmlinux after (+6845)

This is the reduction in non-inlined functions:

  Before: 40286
  After:  40218 (-68)

Tested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181003213100.189959-6-namit@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/alternative-asm.h | 20 ++++++++++++++------
 arch/x86/include/asm/alternative.h     | 11 ++---------
 arch/x86/kernel/macros.S               |  1 +
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/alternative-asm.h b/arch/x86/include/asm/alternative-asm.h
index 31b627b43a8e..8e4ea39e55d0 100644
--- a/arch/x86/include/asm/alternative-asm.h
+++ b/arch/x86/include/asm/alternative-asm.h
@@ -7,16 +7,24 @@
 #include <asm/asm.h>
 
 #ifdef CONFIG_SMP
-	.macro LOCK_PREFIX
-672:	lock
+.macro LOCK_PREFIX_HERE
 	.pushsection .smp_locks,"a"
 	.balign 4
-	.long 672b - .
+	.long 671f - .		# offset
 	.popsection
-	.endm
+671:
+.endm
+
+.macro LOCK_PREFIX insn:vararg
+	LOCK_PREFIX_HERE
+	lock \insn
+.endm
 #else
-	.macro LOCK_PREFIX
-	.endm
+.macro LOCK_PREFIX_HERE
+.endm
+
+.macro LOCK_PREFIX insn:vararg
+.endm
 #endif
 
 /*
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 4cd6a3b71824..d7faa16622d8 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -31,15 +31,8 @@
  */
 
 #ifdef CONFIG_SMP
-#define LOCK_PREFIX_HERE \
-		".pushsection .smp_locks,\"a\"\n"	\
-		".balign 4\n"				\
-		".long 671f - .\n" /* offset */		\
-		".popsection\n"				\
-		"671:"
-
-#define LOCK_PREFIX LOCK_PREFIX_HERE "\n\tlock; "
-
+#define LOCK_PREFIX_HERE "LOCK_PREFIX_HERE\n\t"
+#define LOCK_PREFIX "LOCK_PREFIX "
 #else /* ! CONFIG_SMP */
 #define LOCK_PREFIX_HERE ""
 #define LOCK_PREFIX ""
diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
index f1fe1d570365..852487a9fc56 100644
--- a/arch/x86/kernel/macros.S
+++ b/arch/x86/kernel/macros.S
@@ -8,3 +8,4 @@
 
 #include <linux/compiler.h>
 #include <asm/refcount.h>
+#include <asm/alternative-asm.h>
