Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227YCaQv2Smm5wpcBDHs+LNyrRk2+w1EO24nbb0gPxtkz/MwQXFKdIFXyYal7GFvLVVgSC4i
ARC-Seal: i=1; a=rsa-sha256; t=1519217864; cv=none;
        d=google.com; s=arc-20160816;
        b=qp/NK11JkKuQeNsUDAT+wYoZAC5cfRF2VkvFdJAmKIWmwxKXcztQ+rxndyqJtZ2n1E
         XxDTOYgzABTxk5s8aaKOCfZu59QyZkk+MzwiffzF2Q+sCTGb4rDinw4rswkp/NfmTZn5
         ypuj9ot39/QSanj65+UGtX9z1LQHjeJcdw1UQhb4C7wkMhIMyyukXkBR5VIMFRq3AR/1
         vUsb9gu3EZd1FJm7MIOFw2I9QmyPw7QEQlxM0bPMY2Ui/VRQhTi3QSl1jnq0AZTxaX0u
         M+6JKqswuD1B87+N2dofWHBcmpCWTJ3aovcvGoai5yw6rsBVzORvPXjtktSv0SCRTWKF
         4uZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gZCZy5abDw1+B1mpijWaHgjeAY1JNuzQ79pKS8cw7sY=;
        b=c0HVwYvLor5GME9iCcPFpz8QgZfo9T9dlJTtcc5ApXP7wFEruFVHf7tqsuyU7trDMl
         DQvRVdt5wczNTHgdeRqhy8SUQLvsHRn4ELUeXmuWx2OoV9B2bzBFzvxWaXOTVJ7FyZdC
         Xoq53vaQExN+qh43RXFBDOJX1950Q+XqnUExfE6faN2fzPpBv3PdIJw+tJGp90SyofDt
         4ixijpzjEueFMxLhe+YRnZjseEGpyQqlpc8Jg8DGOlXGJytlg0MejqXaPux4OcNltfA9
         aNGbFiU8PNVrU/uEKK/Ms3lO9cqBdejSSqVI8CyaXAihKWVTdkzcKVJZtXhhU9Gm0fuN
         FX4w==
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
Subject: [PATCH 4.9 51/77] compiler-gcc.h: Introduce __optimize function attribute
Date: Wed, 21 Feb 2018 13:49:00 +0100
Message-Id: <20180221124434.371604297@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015391246785093?=
X-GMAIL-MSGID: =?utf-8?q?1593015391246785093?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -187,6 +187,10 @@
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
@@ -469,6 +469,10 @@ static __always_inline void __write_once
 # define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
 #endif
 
+#ifndef __optimize
+# define __optimize(level)
+#endif
+
 /* Compile time object size, -1 for unknown */
 #ifndef __compiletime_object_size
 # define __compiletime_object_size(obj) -1
