Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E0CC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 10:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09182170E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 10:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09182170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbeHUN7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 09:59:24 -0400
Received: from smtprelay0241.hostedemail.com ([216.40.44.241]:36416 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726842AbeHUN7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 09:59:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id C96EB181D3417;
        Tue, 21 Aug 2018 10:39:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: prose77_8f4bcddb4ff0c
X-Filterd-Recvd-Size: 2734
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 21 Aug 2018 10:39:44 +0000 (UTC)
Message-ID: <7bbf0a3c97f817c81df2316fca0ec88d5a6b4302.camel@perches.com>
Subject: Re: [PATCH] compiler-gcc: get back Clang build
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 21 Aug 2018 03:39:43 -0700
In-Reply-To: <1534834088-15835-1-git-send-email-yamada.masahiro@socionext.com>
References: <1534834088-15835-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-21 at 15:48 +0900, Masahiro Yamada wrote:
> Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
> missed the fact that <linux/compiler-gcc.h> is included by Clang
> as well as by GCC.
> 
> Clang actually defines __GNUC__, __GNUC_MINOR__, __GNUC_PATCHLEVEL__
> and it looks like GCC 4.2.1.
> 
>   $ scripts/gcc-version.sh -p clang
>   040201

Perhaps this would work, but I can't test it as
my clang version doesn't otherwise build a defconfig
and errors out with

$ make CC=clang
arch/x86/Makefile:179: *** Compiler lacks asm-goto support..  Stop.

---
 include/linux/compiler-gcc.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 3e70b7d4e9ed..3a06ad823fa4 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -3,6 +3,23 @@
 #error "Please don't include <linux/compiler-gcc.h> directly, include <linux/compiler.h> instead."
 #endif
 
+/*
+ * Override clang compiler version #defines
+ *
+ * compiler_types.h always #includes compiler-gcc.h before compiler-clang,h
+ * but clang sets these __GNUC version #defines to 4.2.1.
+ * This breaks the gcc minimum version of 4.6.0, so override the clang
+ * definitions to 4.6.0
+ */
+#ifdef __clang__
+    #undef __GNUC__
+    #undef __GNUC_MINOR__
+    #undef __GNUC_PATCHLEVEL__
+    #define __GNUC__ 4
+    #define __GNUC_MINOR__ 6
+    #define __GNUC_PATCHLEVEL__ 0
+#endif
+
 
