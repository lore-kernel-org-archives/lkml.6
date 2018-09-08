Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE697C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BAB52086E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdNsgtfZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BAB52086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbeIICNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 22:13:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38756 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727694AbeIICM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 22:12:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id t25-v6so17659934wmi.3;
        Sat, 08 Sep 2018 14:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5ELqCquol9uLIAR1HjMyJP27IPe/3rVJEhfvVxeS1Hw=;
        b=PdNsgtfZbphrH97gnteJQxvLOwe/d9Q+XERb2klYepe2du+0JFriuRKlFW5zlVrSlp
         wEHw71QQNZQCn1TUNywM77KsmigEt2PjX9ygYwegEIls8fBF+YnToXIFxuXFib3I9zM9
         vW8S1GEGkrqkKFNq3wr26d743ZwNGHFMDVzeKklGZd3Jd8jjw9ARybQ7XA+Tk4vnHC4e
         9BBg+em0tK8Bp56JmEuuWdBw7bNFoJM8sMBOgrWlbHQj20ECqcK4HGJzmw+zuFWKXuuH
         0nK7hpBKZCegDXj7QWurqL3N3rps6wyhLrlE19McafIxKH1UhZ+n9fu4Tw3ot7X4hSQ3
         rFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5ELqCquol9uLIAR1HjMyJP27IPe/3rVJEhfvVxeS1Hw=;
        b=qM1/DQVy4uN//tn52Wowb3SYWniVN/f8ZVFgRvDh11CLsX3yxyM8gF2mVKl4Dvfw33
         uYCXD3czJYIdkYrTBpZnm+XNhaeUyNPm1XY8XBNIjPE6XJl0am6UMGvfrNy9Nf5JfvsZ
         Bv4/AKc3WJUDgHsb0x+wGfC1bQzHi42Bkws0Y6T4GNxBuWkj/K0qCjuFrLlOvc7508HT
         iCuorK+4utQJKRSD9NwvgYX8S3e74IoP1tokD+ay5GJgfEFsSFFxjvFE/n6xe6/z1q9f
         8FYhs/CUqzeUHKgOCImhthoCb4AFqk4lNyt3/wn7x/1QgxcPKH2H3rAeUSvee3ii8sOZ
         J5XQ==
X-Gm-Message-State: APzg51Bkn/LYrzgZ3UuicibkXjaDaXZO2wEZbimpnlcE6PsWzLU7IM1D
        a7RTrWJOu2WhMqXaceiTYMs=
X-Google-Smtp-Source: ANB0VdbHFFPDnydgS7Un3kwKCFgxdeK7cKjFUdxBeznpMjQA27/VceL0cvMLw96OnDDHhRk+WB6mBg==
X-Received: by 2002:a1c:f913:: with SMTP id x19-v6mr8759501wmh.63.1536441916672;
        Sat, 08 Sep 2018 14:25:16 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id u40-v6sm17340786wrc.43.2018.09.08.14.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 14:25:16 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-sparse@vger.kernel.org
Subject: [PATCH v4 04/13] Compiler Attributes: homogenize __must_be_array
Date:   Sat,  8 Sep 2018 23:24:50 +0200
Message-Id: <20180908212459.19736-5-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
References: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Different definitions of __must_be_array:

  * gcc: disabled for __CHECKER__

  * clang: same definition as gcc's, but without __CHECKER__

  * intel: the comment claims __builtin_types_compatible_p()
    is unsupported; but icc seems to support it since 13.0.1
    (released in 2012). See https://godbolt.org/z/S0l6QQ

Therefore, we can remove all of them and have a single definition
in compiler.h

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Eli Friedman <efriedma@codeaurora.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler-clang.h | 1 -
 include/linux/compiler-gcc.h   | 7 -------
 include/linux/compiler-intel.h | 3 ---
 include/linux/compiler.h       | 7 +++++++
 4 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index d11cad61ba5c..fa9532f8d885 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -41,6 +41,5 @@
  * compilers, like ICC.
  */
 #define barrier() __asm__ __volatile__("" : : : "memory")
-#define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
 #define __assume_aligned(a, ...)	\
 	__attribute__((__assume_aligned__(a, ## __VA_ARGS__)))
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 371b6fa2d074..76f4907ef707 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -68,13 +68,6 @@
  */
 #define uninitialized_var(x) x = x
 
-#ifdef __CHECKER__
-#define __must_be_array(a)	0
-#else
-/* &a[0] degrades to a pointer: a different type from an array */
-#define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
-#endif
-
 #ifdef RETPOLINE
 #define __noretpoline __attribute__((__indirect_branch__("keep")))
 #endif
diff --git a/include/linux/compiler-intel.h b/include/linux/compiler-intel.h
index fef8bb3e53ef..6004b4588bd4 100644
--- a/include/linux/compiler-intel.h
+++ b/include/linux/compiler-intel.h
@@ -29,9 +29,6 @@
  */
 #define OPTIMIZER_HIDE_VAR(var) barrier()
 
-/* Intel ECC compiler doesn't support __builtin_types_compatible_p() */
-#define __must_be_array(a) 0
-
 #endif
 
 /* icc has this, but it's called _bswap16 */
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index ec4a28bad2c6..165b1d5683ed 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -357,4 +357,11 @@ static inline void *offset_to_ptr(const int *off)
 	compiletime_assert(__native_word(t),				\
 		"Need native word sized stores/loads for atomicity.")
 
+#ifdef __CHECKER__
+#define __must_be_array(a)	0
+#else
+/* &a[0] degrades to a pointer: a different type from an array */
+#define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
+#endif
+
 #endif /* __LINUX_COMPILER_H */
-- 
2.17.1

