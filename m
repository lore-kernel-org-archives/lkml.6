Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D8EC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E62208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="utdsLwHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E62208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbeLMKDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:03:42 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:55802 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbeLMKDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:03:42 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wBDA1oCm020380;
        Thu, 13 Dec 2018 19:01:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wBDA1oCm020380
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544695311;
        bh=hNmCPFaftK24Dzqx+MQ14NFA8KXiwAEI/vymgmjBy9Y=;
        h=From:To:Cc:Subject:Date:From;
        b=utdsLwHR3Lm9MffMGpF3qsW5uLkEl0uvHN1cXRR7C75x/G++w0wGKUffDDlTiInc0
         6yXgvXTGcBUa9ymsPe9i7+YfOr+UiGGUmN7x+hK1Eydsn64yjdgEbzwIaD56kiDkIl
         oV0gj73kuU+smrGKVQDwhkYEtrC6OkjUih8+lcGtDyWnCCaxOfnH6DN8SzCrQyEXbh
         OCTdIOm1SsxOwFcW++apuJt3GSVKTcFc6MSom3whURyfrP3kVoe7LcLOPykgvRKrml
         QcYq2vsGVw9TCoD1t1F0uY2FcIYLLw13v2WVy9ztnaJqjOD2ZIy8rNKzpynExzwgik
         hbbP8O3/ph/kw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Richard Biener <rguenther@suse.de>, Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] compiler.h: support asm inline qualifier for better inlining
Date:   Thu, 13 Dec 2018 18:59:14 +0900
Message-Id: <1544695154-15250-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the 'inline' qualifier supported for GCC's extended asm, we can
improve inlining where we know the actual code size of asm statement
is smaller than it looks.

You can mark such asm statements as 'asm_inline' instead of 'asm'.
'asm_volatile_goto' is always considered as the minimum code size.

Kconfig checks if the compiler supports 'asm inline'. In unsupported,
'asm_inline' falls back to 'asm'.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

GCC 9 is not released yet, but I wanted to show how easy it is
to improve asm inlining thanks to the brand new 'asm inline' syntax.

The 'inline' qualifier is explained here:
  https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html

To try this patch, the following two prerequisites are necessary.

 [1] Revert in-kernel workarounds

  https://lore.kernel.org/patchwork/patch/1024584/

 [2] Replace the macros like follows:

     __inline    ->  inline
     __inline__  ->  inline

     Peter Zijlstra suggested to do this by scripting:
     https://lkml.org/lkml/2018/10/31/511

Then, replace 'asm' with 'asm_inline', for example, like follows:

 diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
 index 6804d66..5dbe012 100644
 --- a/arch/x86/include/asm/bug.h
 +++ b/arch/x86/include/asm/bug.h
 @@ -32,7 +32,7 @@

  #define _BUG_FLAGS(ins, flags)                                         \
  do {                                                                   \
 -       asm volatile("1:\t" ins "\n"                                    \
 +       asm_inline volatile("1:\t" ins "\n"                             \
                      ".pushsection __bug_table,\"aw\"\n"                \
                      "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"   \
                      "\t"  __BUG_REL(%c0) "\t# bug_entry::file\n"       \


 include/linux/compiler-gcc.h   | 2 +-
 include/linux/compiler_types.h | 8 +++++++-
 init/Kconfig                   | 3 +++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 2010493..c04b350 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -121,7 +121,7 @@
  *
  * (asm goto is automatically volatile - the naming reflects this.)
  */
-#define asm_volatile_goto(x...)	do { asm goto(x); asm (""); } while (0)
+#define asm_volatile_goto(x...)	do { asm_inline goto(x); asm (""); } while (0)
 
 /*
  * sparse (__CHECKER__) pretends to be gcc, but can't do constant
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 5280aee..c989bcf 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -131,7 +131,13 @@ struct ftrace_likely_data {
 #endif
 
 #ifndef asm_volatile_goto
-#define asm_volatile_goto(x...) asm goto(x)
+#define asm_volatile_goto(x...) asm_inline goto(x)
+#endif
+
+#ifdef CONFIG_CC_HAS_ASM_INLINE
+# define asm_inline asm __inline__
+#else
+# define asm_inline asm
 #endif
 
 /* Are two types/vars the same type (ignoring qualifiers)? */
diff --git a/init/Kconfig b/init/Kconfig
index cf5b5a0..52cf7f1 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -23,6 +23,9 @@ config CLANG_VERSION
 	int
 	default $(shell,$(srctree)/scripts/clang-version.sh $(CC))
 
+config CC_HAS_ASM_INLINE
+	def_bool $(success,echo 'void foo(void) { asm inline (""); }' | $(CC) -x c - -c -o /dev/null)
+
 config CONSTRUCTORS
 	bool
 	depends on !UML
-- 
2.7.4

