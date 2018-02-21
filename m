Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227OjLezfXzcR67ZOGfL3+tD/5cB0Zyoon6VokGjvrt8q2sbl+0ZIyygS6XBtvQbGpLUTM/6
ARC-Seal: i=1; a=rsa-sha256; t=1519218447; cv=none;
        d=google.com; s=arc-20160816;
        b=HSGq9Y+kG14GOQ8LfB4mqW9mrcaW9p6/dyQC+BRXfWCEtkXGxBWtVbDO2rFfxbzOD3
         zT3Au8aBJBQSKWcI8rhm/cecThTN6VjLvrfTH58NC8Vh4ag4JYVmnWK2q5C9ALfZGn63
         yKTzznfArZd6isYJIdoLn9o91GYIWFXb+jIW7OQn+iw3kNl/I8uMQ3clIcPbv9SApCK2
         e3bh0GlRizBZMpICp6YVsaKU5N2r2tc9/g8+8Rb2KJrUlryJVl6H/PF7H0IwFK7HKOD6
         06pIJAorBPu+umpjQdIvxa+mHGoU0wHZLg7btR//j+d7OVjOIF5hJRthrnz+fwRL7qfi
         3/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YnThUNuI3f8c/NKWT/xfou/BCB5gfSG9aSYKGe3vLbQ=;
        b=JNIyjwyh3jOFvUQTokUkL31+iRjWvt2ilWLL8QQf6a9mLjFy9Io/JJqQT/5dLN95A0
         UWfecalzVnExy+fhUfcjxMnLAE8jRkfsOyg0FrF+BvBMW5L84JP+Zbeuf38Xm2kV53PZ
         r8alWubon8djAT2/SpJcFNPZ6jAhbivApaNyYX3/6YZTypdduZEDuVHEfpWJzoeozEb4
         a0ByhiyMGcZh8o3ldbBsYb0isMQDFUAQWT/KqIJOM4kkrqn8no2vX8f27fMZWNeeCmxc
         2ugCS07UN4t0SPUcZm6MjnLkxPggJN9bG//n1NCvCyFH/LFhjUjcIKf/45nOW77NhVS+
         dOug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.15 042/163] compiler-gcc.h: Introduce __optimize function attribute
Date: Wed, 21 Feb 2018 13:47:51 +0100
Message-Id: <20180221124532.672161446@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015391246785093?=
X-GMAIL-MSGID: =?utf-8?q?1593016002823832073?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert@linux-m68k.org>

commit df5d45aa08f848b79caf395211b222790534ccc7 upstream.

Create a new function attribute __optimize, which allows to specify an
optimization level on a per-function basis.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/compiler-gcc.h |    4 ++++
 include/linux/compiler.h     |    4 ++++
 2 files changed, 8 insertions(+)

--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -196,6 +196,10 @@
 #endif /* __CHECKER__ */
 #endif /* GCC_VERSION >= 40300 */
 
+#if GCC_VERSION >= 40400
+#define __optimize(level)	__attribute__((__optimize__(level)))
+#endif /* GCC_VERSION >= 40400 */
+
 #if GCC_VERSION >= 40500
 
 #ifndef __CHECKER__
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -271,6 +271,10 @@ static __always_inline void __write_once
 
 #endif /* __ASSEMBLY__ */
 
+#ifndef __optimize
+# define __optimize(level)
+#endif
+
 /* Compile time object size, -1 for unknown */
 #ifndef __compiletime_object_size
 # define __compiletime_object_size(obj) -1
