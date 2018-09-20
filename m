Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC469ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A5E21523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtD32SbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A5E21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388047AbeITXIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:08:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40128 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbeITXIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:08:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id y8-v6so6562169wrh.7;
        Thu, 20 Sep 2018 10:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3IAlaipCNnrtQXC9KGumpKwQRaKsYxmUF93A0nM9u8k=;
        b=VtD32SbDIbB8mKCUPJoXm+oF2hfSMjUQk6HnHcXYt+Wsy39LwvZ5dYPRqB+Vzuqyid
         mEncoH5wOxwdrRAxKOOl1RFgJ8LaVJViaew5fTMgWprGZYS8Nr2C8zz//2FnBLJumBC2
         N/vaQeS31/bntVshVutpj5dWfxEa4JZcH/H3L0HiBfPpfcHhsr3tzyGHciSq4HY2wl32
         z0utH32YK8sCtinfEtY5OJkpt3/IlK6KktbP4MLrC63SdaQ1PeTna8w2xDZf9bL7y5Ni
         OpIomudruyWj/hlNI7DUJ653rG3H7726+VpeggiTxO5Mpms1LslWJ8nZU9b2aLpJAB6i
         QNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3IAlaipCNnrtQXC9KGumpKwQRaKsYxmUF93A0nM9u8k=;
        b=TMGzCy1JHcpkdoankZwu14inbuqqYGEprQyo73GCqsnuBkktFWUjrA7clb+g1fu+rW
         k4M8VeAParz5zgPbecH0WD7Rt3thPIQIgmjNVQD2XKV2ao6z3RrK/6l/YSFK6ddP80jB
         0Zhya7qtpJwBo04bDO/GhWBH1N9J23hSxN8TM2DF086C2TMqwG2fM3sFTEWsR6Dgojve
         twQuC0wEAjgM/R8/sodPX5ahzO3WwULt+SOxFSdPuqMRKI7enIwNNFuFj7d5gaeXMTdc
         Q2jRusjaxJRJxvpqICwzybnhm05Uv0tOubs8ky7i2ZtYgQPydOarNTojMX6LTjAqe4xD
         8LPA==
X-Gm-Message-State: APzg51BWX/1XHFN3C1Isz7R3UAs32jp2nEaaoDZIsNkJlBI0FFwYTOV9
        KqQ6ib4+FuCPO9gTFVKNTho=
X-Google-Smtp-Source: ANB0VdagG0B/cJ2qgWtdvU1a704upGMJ21SS9X3hnbH32lyUbGuYDT/44Q8vKCUzR2u/XiYwrujlJQ==
X-Received: by 2002:adf:ad34:: with SMTP id p49-v6mr35394591wrc.10.1537464213065;
        Thu, 20 Sep 2018 10:23:33 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id q200-v6sm3466562wmd.2.2018.09.20.10.23.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:23:32 -0700 (PDT)
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
Subject: [PATCH v5 04/15] Compiler Attributes: homogenize __must_be_array
Date:   Thu, 20 Sep 2018 19:22:50 +0200
Message-Id: <20180920172301.21868-5-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
References: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
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

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
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
index 7a1de7683df5..3b32bbfa5a49 100644
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

