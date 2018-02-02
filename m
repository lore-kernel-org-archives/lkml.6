Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226ljwQZkpHB9dLedlCQ4RDb8K1wlwMXntBSixQdGnTkUpVWwyy8MH5ewoCr4TpIH0b55chS
ARC-Seal: i=1; a=rsa-sha256; t=1517591707; cv=none;
        d=google.com; s=arc-20160816;
        b=aabJahYz+8IwT5X3x9n0ekDrIHHFTJEM46793rfqo6StK4xRcgSS43hpYuLeXVri2U
         UMMmR6X+fPxngml2GP9xk4aU3BT+O+IenKSFTff/X94+HeNIGlmH+NNBuHrIhUwHzsd2
         +f2R4CIlf5bhGKlhL/6xTZZwD+oPTYqCkJbL/l9lTN9hpX5lNcPKBmDZ7qdt692uD9KU
         Lho6Qy2vRFZ3hrCfVpHbQlzfjc+7fy7ac1HC82WQscs57vs03vVBfGxhjPZ+KGwpQ2SM
         PVu38OqjEGq/Ce+mlym6bYwJuMGVCyZDtLamc38n4t63DjLoLqt9S1Nz6WaqQLOjidyR
         FrGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RE84CPH3IsocaJsNHvo345nLL/GDzZoa0aeBFVMyAyo=;
        b=OlJzaC3fG+LaE0V7h1fBTEtvJH3kTvCVFWfRybh1up0HFoazUNByOkpgJGv4bqbZ7d
         4IAd9onRRuEOjJP+vBfsZK+qYsP1d4w3KlGcnMefC/BTwRU+uVZcCEkNnbRi3CfDeJlT
         bX7jz+tDsN0BHHx2eZ4AXai07myfaanNigmkLn3Xmpt+NP8iuUX0l6zC0KdU8O9tasKm
         U30rQ/AixU06fUAodf/0cgptQwxFM/HfZ9xw0FD6zEHdbRIKFfn9oGkf8VD/CZhonmFa
         axXNDzTcYtGaf5Rh7HDVT2wXCMM9XJrmoK21hJXVZaJ/Nugs/c1opk3uFVwY3mzYFGpt
         DtpQ==
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
Subject: [PATCH 4.15 02/55] tools/gpio: Fix build error with musl libc
Date: Fri,  2 Feb 2018 17:58:20 +0100
Message-Id: <20180202140826.321493960@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309482387772779?=
X-GMAIL-MSGID: =?utf-8?q?1591310241936586171?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
