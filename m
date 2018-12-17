Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0923AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CDA206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="SZyRKTc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388197AbeLQQII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:08:08 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:61926 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388037AbeLQQIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:08:05 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id wBHG3bRl008119;
        Tue, 18 Dec 2018 01:03:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com wBHG3bRl008119
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545062631;
        bh=YEFM37VoP8iq6zt/Sfo/eyMOxoBwqOHgn1OHsnq/Cpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SZyRKTc2cXrXSdD+byqOkkRXRbjEFecU2OrfzayHBhLpnlQmjrRR0X4d1rYdHi4Gw
         /zxv5vAt6rwxhcldHskdNvQBYucrTVRzueyL4ppQRbhSl4I64Q+fKzeawHK37OYDrA
         KQ8pfJXlpD/RFd5oLx+scOR/MiFCMMsJ9na7PqxrNBS0CCHYpRPbWPkkuO/bVvmalJ
         lUjPk4s1rlhnpfBCDp7VK2loB9lOiMRmI7u98ZN6Uk4MGyQ35OKUbZ/4sU3bHqmnkR
         J8g8lu5F7vELxXUPeqtzwgjsLdsL3ayHjA2F7or1g7LzFym8Lb9iuO8t/AWktmq91c
         UkRKkXTx9T43Q==
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
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v3 08/12] Revert "x86/objtool: Use asm macros to work around GCC inlining bugs"
Date:   Tue, 18 Dec 2018 01:03:23 +0900
Message-Id: <1545062607-8599-9-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
References: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit c06c4d8090513f2974dfdbed2ac98634357ac475.

The in-kernel workarounds will be replaced with GCC's new
"asm inline" syntax.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/kernel/macros.S |  2 --
 include/linux/compiler.h | 56 +++++++++++-------------------------------------
 2 files changed, 13 insertions(+), 45 deletions(-)

diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
index cee28c3..cfc1c7d 100644
--- a/arch/x86/kernel/macros.S
+++ b/arch/x86/kernel/macros.S
@@ -5,5 +5,3 @@
  * commonly used. The macros are precompiled into assmebly file which is later
  * assembled together with each compiled file.
  */
-
-#include <linux/compiler.h>
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 06396c1..fc5004a 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -99,13 +99,22 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  * unique, to convince GCC not to merge duplicate inline asm statements.
  */
 #define annotate_reachable() ({						\
-	asm volatile("ANNOTATE_REACHABLE counter=%c0"			\
-		     : : "i" (__COUNTER__));				\
+	asm volatile("%c0:\n\t"						\
+		     ".pushsection .discard.reachable\n\t"		\
+		     ".long %c0b - .\n\t"				\
+		     ".popsection\n\t" : : "i" (__COUNTER__));		\
 })
 #define annotate_unreachable() ({					\
-	asm volatile("ANNOTATE_UNREACHABLE counter=%c0"			\
-		     : : "i" (__COUNTER__));				\
+	asm volatile("%c0:\n\t"						\
+		     ".pushsection .discard.unreachable\n\t"		\
+		     ".long %c0b - .\n\t"				\
+		     ".popsection\n\t" : : "i" (__COUNTER__));		\
 })
+#define ASM_UNREACHABLE							\
+	"999:\n\t"							\
+	".pushsection .discard.unreachable\n\t"				\
+	".long 999b - .\n\t"						\
+	".popsection\n\t"
 #else
 #define annotate_reachable()
 #define annotate_unreachable()
@@ -293,45 +302,6 @@ static inline void *offset_to_ptr(const int *off)
 	return (void *)((unsigned long)off + *off);
 }
 
-#else /* __ASSEMBLY__ */
-
-#ifdef __KERNEL__
-#ifndef LINKER_SCRIPT
-
-#ifdef CONFIG_STACK_VALIDATION
-.macro ANNOTATE_UNREACHABLE counter:req
-\counter:
-	.pushsection .discard.unreachable
-	.long \counter\()b -.
-	.popsection
-.endm
-
-.macro ANNOTATE_REACHABLE counter:req
-\counter:
-	.pushsection .discard.reachable
-	.long \counter\()b -.
-	.popsection
-.endm
-
-.macro ASM_UNREACHABLE
-999:
-	.pushsection .discard.unreachable
-	.long 999b - .
-	.popsection
-.endm
-#else /* CONFIG_STACK_VALIDATION */
-.macro ANNOTATE_UNREACHABLE counter:req
-.endm
-
-.macro ANNOTATE_REACHABLE counter:req
-.endm
-
-.macro ASM_UNREACHABLE
-.endm
-#endif /* CONFIG_STACK_VALIDATION */
-
-#endif /* LINKER_SCRIPT */
-#endif /* __KERNEL__ */
 #endif /* __ASSEMBLY__ */
 
 /* Compile time object size, -1 for unknown */
-- 
2.7.4

