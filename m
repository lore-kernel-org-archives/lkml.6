Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224TTM2RMDy7r7VakAqFJSsT98VXupRj1NNOhC1j8e3vD+pSCvyExWTaKOwu0qn5sXL04Y+u
ARC-Seal: i=1; a=rsa-sha256; t=1517590982; cv=none;
        d=google.com; s=arc-20160816;
        b=qARnk31Bw4obb6XJwcS7ZFdxAG4NNWeftPWel0RwlLtSRk/bpSvgTViyzZHTzfyc1l
         ArA85Q9Pd4mzrqGnvwffA52/zsUeQy0a9iWTkqM8+fYlRWsNUJ+IMKqFUzCQJq4btMiL
         pubAe2WNcxRsF9984Wye25Wi6EmSfJKQRPLsN9nbax2NoiRoFUqnEOUE7VjezrDVWkYv
         Lp89NiJ3XjSVH5K4Ta/OwTi71k8dzoxhzdIvVcjEgSGLdoxmtzOS6Ps/LzOqxc8TBvEg
         cEq6e3Ky0XoJS1KT+cicgVdx11zBSo8mPkEsNWzGCWCAp2qfFZLfkAgr2Zr7qFuAFxsi
         IbDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=URq7/pOjsGlpSj0CY+hBVgSKAE/703BbiR6iJCH7l7U=;
        b=0WlEBkJe/PuOQ1stvaIRjBJjBw9ucCS4EPwmLts8Qa/m1ImE+Qr4wZvcHPfF93O13F
         b3FswTX9pm6hFDl/KYiLCUusdQFNpW2t2tfbxB/m2Mf0vKtFv+v8/l/nzBWD8981O+P/
         yBHbAdDevIeyS0q7UZXpkzQ7uXLKXTzzsmQjBtb5+/cT0GnlayK/NfaIxEFwi+GJk+fA
         IPtPmp93u0lJtvLaj9VMBdW4lS5iIlz5vclPBWNb0EBL7mowXb/1dHdLraD8+81CVcL2
         AgAxWemaE/xxYBA4gN/hs4c5hIrK11XQqhxxnkPK0qGMho8NGU8oyNhdPhkQqkXd4ZvA
         v42Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Joel Stanley <joel@jms.id.au>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.9 04/86] tools/gpio: Fix build error with musl libc
Date: Fri,  2 Feb 2018 17:57:24 +0100
Message-Id: <20180202140823.098832357@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309482387772779?=
X-GMAIL-MSGID: =?utf-8?q?1591309482387772779?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joel Stanley <joel@jms.id.au>

commit 1696784eb7b52b13b62d160c028ef2c2c981d4f2 upstream.

The GPIO tools build fails when using a buildroot toolchain that uses musl
as it's C library:

arm-broomstick-linux-musleabi-gcc -Wp,-MD,./.gpio-event-mon.o.d \
 -Wp,-MT,gpio-event-mon.o -O2 -Wall -g -D_GNU_SOURCE \
 -Iinclude -D"BUILD_STR(s)=#s" -c -o gpio-event-mon.o gpio-event-mon.c
gpio-event-mon.c:30:6: error: unknown type name ‘u_int32_t’; did you mean ‘uint32_t’?
      u_int32_t handleflags,
      ^~~~~~~~~
      uint32_t

The glibc headers installed on my laptop include sys/types.h in
unistd.h, but it appears that musl does not.

Fixes: 97f69747d8b1 ("tools/gpio: add the gpio-event-mon tool")
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/gpio/gpio-event-mon.c |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/gpio/gpio-event-mon.c
+++ b/tools/gpio/gpio-event-mon.c
@@ -23,6 +23,7 @@
 #include <getopt.h>
 #include <inttypes.h>
 #include <sys/ioctl.h>
+#include <sys/types.h>
 #include <linux/gpio.h>
 
 int monitor_device(const char *device_name,
