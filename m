Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225gKefyljrXDLdxtosL6IHCAjhHiXIHr6plmVNiA3S57iNI1YzyezGT9MlRHMXkphWjC1ZS
ARC-Seal: i=1; a=rsa-sha256; t=1519217967; cv=none;
        d=google.com; s=arc-20160816;
        b=CKalsNorEebRnKu9F8FGY8H8FH/0AMw1dPSEK6n/OQJuXcV0PQfXPCd8h90Zh2PbhT
         HKlwuGGBHmrNz/Wqfev5KBxrLX1/rdZQbU2j3TIaHGV9nV1Sg3QXricnC/DFi0pSL/BA
         AJEbO20IH2f6fNrIKiQ+BbWIWWcZ8rmkhp+I43wQSVfC23v0x5LPPJUlzNENZykNdjH3
         CEJoEqf6Lea+9l8q1JS4zg2RQx45Zmc/ihB55GdEjZXL9Ie/tuCzCh9nbHGO3FehVtnN
         gnxpziqWC4SAjmsBDRlIXydSvkU767q/8Pmo5pGAZg8z+JLtZItGVH3vElkOSttm9efZ
         GVPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=G9bfjPJoGIoBNhANZVEfavYW37Ck/MMywRwhGu7QQ7E=;
        b=NYmys5kRPooIuNnhn2EOq45drVbc2csZSByqA0OCT0V3rTkEqWJoLO3F95427LYpZy
         hd+NJCc/xfL3Bb9id+l2yZXTEhKKs9pZJ4AwoT059kG41xIGqFNE1lqQOdVezsCTfWlR
         a0leToaJavcD+VOi0Hj3HQeb2BFIOQWOtLirnsobG85haWVoe5qN0spZ0gJe56UpFh4s
         st6Et9FIGgB3A69jsel5ueoXKWfWJvpIE/A8JCBtySk9vpJnsJH6ey4+m/TU4q4VOZ9Q
         L9llq278xmLpXP8OWqAtkmacBLKE18m0J0BSe5zZpjVrfPoEHU7aXYSjwRBvBzVGLxFP
         fGNg==
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
Subject: [PATCH 4.14 042/167] compiler-gcc.h: Introduce __optimize function attribute
Date: Wed, 21 Feb 2018 13:47:33 +0100
Message-Id: <20180221124526.889117611@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015391246785093?=
X-GMAIL-MSGID: =?utf-8?q?1593015499302981202?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -266,6 +266,10 @@ static __always_inline void __write_once
 
 #endif /* __ASSEMBLY__ */
 
+#ifndef __optimize
+# define __optimize(level)
+#endif
+
 /* Compile time object size, -1 for unknown */
 #ifndef __compiletime_object_size
 # define __compiletime_object_size(obj) -1
