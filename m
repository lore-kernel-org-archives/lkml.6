Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224O5L3nV/9RF+n2zemq1GVcTnhA/73QKbeU/ZpE9bThks+l4mtyYRFM3MVz4AzEKNAFYhli
ARC-Seal: i=1; a=rsa-sha256; t=1517591299; cv=none;
        d=google.com; s=arc-20160816;
        b=qMKR1c3Vo5GPGNTlMvfdBypzjZNNyRmUVc5xKtTnZUAP4zNX9yCJAtY+6KALo0p6UQ
         qPvV7Num9nQUPqGuHdoIbw4bhhs9RXw/C3qaFZjRf/Rf1o/OlDj7pCYgjJRW1ucG++az
         RbRokYi/Y/wUNTIKg1gjmvVoLKzFunA7suVsRpXv4LBObBxvzsz9LGlYwqwDIrEtwfMx
         UIfoH+m/qCAmrHvW7Rd5Dyvu91QA1H2ngcAhKod5trS6R523gEwCVOd7z1foWa7SpgXA
         ZOU7JAuomG2umbtXs36oAhvClio2f3DF29e7GhE/bz+ebnY/Wra3FUmeuxrLMBqc22NC
         fvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=k/7UilHFjSPkM2oJPWje/ujFvhuLHwdT8k/WjuqL+lc=;
        b=BPC7ZEaiGuJZJNZYteVqSffEnlVwMOvZv+GotGvWFsALlxFTXGIZ8RRzwhGvapQaPH
         xIvQ8LE8lc91unAuDi/yJQvdF+iWwYFmP6cijASzZynCX+Jk0Mw60iIh2/695yMNQ8Bw
         sJSe9FBzEtvt5u7M/oCDRE4klqM8/aS0YUXHgSERI06AUF4t7c7Lr0kHcCS5Kp0V1igF
         OUn0HiGjl6IVF+hJXf3Zht4NDQJAh+5lXiQRoZK8LyEoNEAOpOEHwgASZBLuzfwScJKJ
         nOvahpXHemmmsKsrIrazVhB/knkBQHL6eoerxskdzNQKiNNd92mAfLvGgeJS7f37JRJu
         b7dw==
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
Subject: [PATCH 4.14 004/156] tools/gpio: Fix build error with musl libc
Date: Fri,  2 Feb 2018 17:56:25 +0100
Message-Id: <20180202140840.462352854@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309482387772779?=
X-GMAIL-MSGID: =?utf-8?q?1591309814832117757?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
