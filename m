Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43754C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F858206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="c6TeJLgN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388234AbeLQQLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:11:12 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:65176 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeLQQLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:11:09 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id wBHG3bRj008119;
        Tue, 18 Dec 2018 01:03:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com wBHG3bRj008119
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545062629;
        bh=dFD8Gwu+yAksuGT9Rgxw6GpB3bscgIYkgUVU4dNRgro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c6TeJLgNTA4bcMva8jdxX45ybV4vRZWXTAqdl67ttw7FPo3EjLPr48N+sGdg7zdFW
         7Vrvy5bm3Hq7mjr9+GgUih0w0wXf/fgHbcPBQhDFLlD9y7fMhZdUn4XSagxch/OHq+
         YYFPh4R/PygzJx4UeZrhWeni/GoU/2NYAB47PfaPP9Z9v6t2+4G4Czjz6sGBbPGkF2
         bY3UhFLzExhQaJs4sao8TvaXQ7kDTBspHXqvxSFRgXAp6jU1ounhmLYaWLN+82FC2N
         s4C4K8e0ZovZlfYWYHYqkG7QGI5FYHQ+bBbS+SjygOV4oTkeyrWgNBP4Zg9kURcRek
         CZtA2Cc0Tx59g==
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
Subject: [PATCH v3 06/12] Revert "x86/alternatives: Macrofy lock prefixes to work around GCC inlining bugs"
Date:   Tue, 18 Dec 2018 01:03:21 +0900
Message-Id: <1545062607-8599-7-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
References: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 77f48ec28e4ccff94d2e5f4260a83ac27a7f3099.

The in-kernel workarounds will be replaced with GCC's new
"asm inline" syntax.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

I blindly reverted here, but I will clean it up
in a different way later.

 arch/x86/include/asm/alternative-asm.h | 20 ++++++--------------
 arch/x86/include/asm/alternative.h     | 11 +++++++++--
 arch/x86/kernel/macros.S               |  1 -
 3 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/alternative-asm.h b/arch/x86/include/asm/alternative-asm.h
index 8e4ea39..31b627b 100644
--- a/arch/x86/include/asm/alternative-asm.h
+++ b/arch/x86/include/asm/alternative-asm.h
@@ -7,24 +7,16 @@
 #include <asm/asm.h>
 
 #ifdef CONFIG_SMP
-.macro LOCK_PREFIX_HERE
+	.macro LOCK_PREFIX
+672:	lock
 	.pushsection .smp_locks,"a"
 	.balign 4
-	.long 671f - .		# offset
+	.long 672b - .
 	.popsection
-671:
-.endm
-
-.macro LOCK_PREFIX insn:vararg
-	LOCK_PREFIX_HERE
-	lock \insn
-.endm
+	.endm
 #else
-.macro LOCK_PREFIX_HERE
-.endm
-
-.macro LOCK_PREFIX insn:vararg
-.endm
+	.macro LOCK_PREFIX
+	.endm
 #endif
 
 /*
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index d7faa16..4cd6a3b 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -31,8 +31,15 @@
  */
 
 #ifdef CONFIG_SMP
-#define LOCK_PREFIX_HERE "LOCK_PREFIX_HERE\n\t"
-#define LOCK_PREFIX "LOCK_PREFIX "
+#define LOCK_PREFIX_HERE \
+		".pushsection .smp_locks,\"a\"\n"	\
+		".balign 4\n"				\
+		".long 671f - .\n" /* offset */		\
+		".popsection\n"				\
+		"671:"
+
+#define LOCK_PREFIX LOCK_PREFIX_HERE "\n\tlock; "
+
 #else /* ! CONFIG_SMP */
 #define LOCK_PREFIX_HERE ""
 #define LOCK_PREFIX ""
diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
index 852487a..f1fe1d5 100644
--- a/arch/x86/kernel/macros.S
+++ b/arch/x86/kernel/macros.S
@@ -8,4 +8,3 @@
 
 #include <linux/compiler.h>
 #include <asm/refcount.h>
-#include <asm/alternative-asm.h>
-- 
2.7.4

