Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227V7hd3vsRWXa2T1n5wF464SfRz5o/Ct+OOv9lgNBqXsAOOWISRd+DAbwgpNl0nGIxCFm+k
ARC-Seal: i=1; a=rsa-sha256; t=1519217970; cv=none;
        d=google.com; s=arc-20160816;
        b=FxmQZrnBhz0dGD+oSQvp5k+gshn16K6PSfotcOCQTomB+aSo2QHBZUv708eXUk/wUg
         6ym3LPWeFHGpmVYqRqe9yYgDLrg7nBiA/LLg8j2oDlsGeIOlzGl6OZctORsb2WiMhxUE
         cOae+9DQb1UIg+TLOA4eH0QcFs27zzIABMNqIJd1VORMB+LciqP2P9GKgd+pleNOrCHa
         cjXlejdZEb9ey8og0aEiaofR4rwQow+0BNsVdl1SNSKjvMOg95upTdmvMzVl9kBKMKec
         m3oUNnmqGUvrE74kCqQN4IIcKHtmFQArxkMWq6oHThJKkCm/CsAbQwsrr1uZZWKiFkyQ
         VNYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yzyqPjdWqhPTAARoZVlrpaxv+i+b7kmTDx42x5ey/aY=;
        b=Eti2JAtTjGzmbx8bfqitmxxkWmqWslMwDENTcMtBmaHyB1D2mirDFXbVLvAhwguH/e
         hoQ4oBjel2uDi2BpO7BdFUJGVwPo2nI8FBRnV4sApI1x2OQsHv6BpezgKhFpdJRnSDwq
         2AHUe8Wa+0yCYECeXk5YhCcozMVP21ycpV5Le7yCmVGEAWoD41tsHU3eBgr/yGamXsn0
         CzHjLxSY+9CknpVbUyumMY5zevbqX2XjSK5bJqVJcyFSonTkfC0mCTkHa3f4jf1iNrce
         RB+G/6wG5J0ZSbg914fFTu8iF/35XrQoWW4RxW0qsMfz0j9TGt+aKTbnMv1mxTibLEsl
         1zwg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 043/167] compiler-gcc.h: __nostackprotector needs gcc-4.4 and up
Date: Wed, 21 Feb 2018 13:47:34 +0100
Message-Id: <20180221124526.943435952@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015501795366068?=
X-GMAIL-MSGID: =?utf-8?q?1593015501795366068?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert@linux-m68k.org>

commit d9afaaa4ff7af8b87d4a205e48cb8a6f666d7f01 upstream.

Gcc versions before 4.4 do not recognize the __optimize__ compiler
attribute:

    warning: ‘__optimize__’ attribute directive ignored

Fixes: 7375ae3a0b79ea07 ("compiler-gcc.h: Introduce __nostackprotector function attribute")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/compiler-gcc.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -167,8 +167,6 @@
 
 #if GCC_VERSION >= 40100
 # define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
-
-#define __nostackprotector	__attribute__((__optimize__("no-stack-protector")))
 #endif
 
 #if GCC_VERSION >= 40300
@@ -198,6 +196,7 @@
 
 #if GCC_VERSION >= 40400
 #define __optimize(level)	__attribute__((__optimize__(level)))
+#define __nostackprotector	__optimize("no-stack-protector")
 #endif /* GCC_VERSION >= 40400 */
 
 #if GCC_VERSION >= 40500
