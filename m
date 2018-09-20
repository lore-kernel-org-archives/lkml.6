Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD809C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6930221531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GE0rQn0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6930221531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388239AbeITXIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:08:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34984 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388191AbeITXIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:08:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id j26-v6so10224146wre.2;
        Thu, 20 Sep 2018 10:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0RA0ONh6m9Yv1rVJTvrOsFSDcGT4jsVl1K//X96wXxE=;
        b=GE0rQn0ChqI0rlDQfCmMochFlu5MMVWGter0daDflRe0EGBZrniL5RHjfQGrTC6GYT
         qfR1w5xluVEr7xEqbyI/VTwPRv/8UvHdBb72KxZbHEuiZqJEVeRfMf/BV+ZnYWwED7p3
         UJ4OOyWsraVc9JrkV48UUJGD/Qxk16WiuB0qMontOBX+ola5TlvBcJk+UHcSJ/kLz352
         Rcj/hmuKUOkEkTQXUIwTqbGkTDsRvDMoUdhxdJI+Gd6zBGhJNh1GQ6nBztzm1q3qHvNu
         8ko6ABiGoBd0/AC7zfH2T5u1VyEeNy3qmpLVDkBx60M2BitxaL0U4CsXKNNQKIF4AlOv
         RW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0RA0ONh6m9Yv1rVJTvrOsFSDcGT4jsVl1K//X96wXxE=;
        b=O7gtivy8POKtRojjuR8A7r/LKA8r0QnQHlIIEmEpH6PC2LJCKgUK8pQcZ53W97XUxa
         SCaVJZyOQUksvYFF2NoKHHH+H/I6nQNPrc/t1JXfq6sejWdIxbTa9WechjIQjtuJapVk
         yuV0qHkgMzt9BofkZSTTh7qiZgZ9dqvJS5+dNiRgQvfs1lin0drbgnCkgThWTopDuIuB
         FiElwmWCMqpYSZhAXCv6N66OduINkJPsav7Hg9ENgd/CV1zngVHCH0EQ0fIP726oEBjh
         lHzLnlB3ZKRQ0Nr0gwhi7Hl3zSw53H9wKKQKS5qap6wqqloogih0XAZljqaqkNCQzL6p
         VXDg==
X-Gm-Message-State: APzg51B2q6EAqYga8J7KsNQpHUZCAwkzqD3asT2Ypqcp8vNIDbvG4N5S
        zFCheKZE5OwiJ1MVB/GKnAI=
X-Google-Smtp-Source: ANB0VdbPnQwPA61LSbOk68RibKZDCx6D9g5+HXMH3vzL0u2Tt+FXc8SSYTN2I8wpooNOM3LvvH/GNA==
X-Received: by 2002:adf:8b50:: with SMTP id v16-v6mr12546686wra.282.1537464230740;
        Thu, 20 Sep 2018 10:23:50 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id q200-v6sm3466562wmd.2.2018.09.20.10.23.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:23:50 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        David Rientjes <rientjes@google.com>, Willy Tarreau <w@1wt.eu>,
        Martin Sebor <msebor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Theodore Ts'o <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH v5 12/15] Compiler Attributes: add support for __nonstring (gcc >= 8)
Date:   Thu, 20 Sep 2018 19:22:58 +0200
Message-Id: <20180920172301.21868-13-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
References: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the GCC manual:

  nonstring

    The nonstring variable attribute specifies that an object or member
    declaration with type array of char, signed char, or unsigned char,
    or pointer to such a type is intended to store character arrays that
    do not necessarily contain a terminating NUL. This is useful in detecting
    uses of such arrays or pointers with functions that expect NUL-terminated
    strings, and to avoid warnings when such an array or pointer is used as
    an argument to a bounded string manipulation function such as strncpy.

  https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html

This attribute can be used for documentation purposes (i.e. replacing
comments), but it is most helpful when the following warnings are enabled:

  -Wstringop-overflow

    Warn for calls to string manipulation functions such as memcpy and
    strcpy that are determined to overflow the destination buffer.

    [...]

  -Wstringop-truncation

    Warn for calls to bounded string manipulation functions such as
    strncat, strncpy, and stpncpy that may either truncate the copied
    string or leave the destination unchanged.

    [...]

    In situations where a character array is intended to store a sequence
    of bytes with no terminating NUL such an array may be annotated with
    attribute nonstring to avoid this warning. Such arrays, however,
    are not suitable arguments to functions that expect NUL-terminated
    strings. To help detect accidental misuses of such arrays GCC issues
    warnings unless it can prove that the use is safe.

  https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html

Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler_attributes.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index f0f9fc398440..6b28c1b7310c 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -34,6 +34,7 @@
 # define __GCC4_has_attribute___externally_visible__  1
 # define __GCC4_has_attribute___noclone__             1
 # define __GCC4_has_attribute___optimize__            1
+# define __GCC4_has_attribute___nonstring__           0
 # define __GCC4_has_attribute___no_sanitize_address__ (__GNUC_MINOR__ >= 8)
 #endif
 
@@ -181,6 +182,19 @@
  */
 #define   noinline                      __attribute__((__noinline__))
 
+/*
+ * Optional: only supported since gcc >= 8
+ * Optional: not supported by clang
+ * Optional: not supported by icc
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-nonstring-variable-attribute
+ */
+#if __has_attribute(__nonstring__)
+# define __nonstring                    __attribute__((__nonstring__))
+#else
+# define __nonstring
+#endif
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-noreturn-function-attribute
  * clang: https://clang.llvm.org/docs/AttributeReference.html#noreturn
-- 
2.17.1

