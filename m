Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1524591074; cv=none;
        d=google.com; s=arc-20160816;
        b=X4o8fw9mqV7Cfrq2/t10u7AUhEYGy8QdM/+kCLHoEcgb5LzN3FxnT6bu9j4/qAheMX
         JpbsKV1QFVB7txbNCTlNMU2B+6PJtWRsb2tMkQ1TbEQMZbvoPjMetOlmSVX0VeufB1yL
         pPnXQDtg4hn0kBQp1IwQYHfC71F0MoVtwGVh1ROr2Et0gdMJNQfoGKkHK9UkaXFV+aGr
         aGEAOSKw77X02z3ljeuNoi/niTdSX8FDF+sVuq6iK8wFAvq9rzm7RgjAoAUcPvjAKauu
         dU8eHXbDnHceAiudAB0Ttn1E7OdKdYhI50F5Z+Dt/hpSNDmAX7PZ9orPGm3HDj843AAk
         gZLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=VT+tLT11Rq2p3LYClNSkAkzYFn3rmA0MFHsEXWhJUZ8=;
        b=U6BEqHDHPWx+vtx+4bYgwQj0ALW4IMOpcuxV3jFdAFs67Ehh492j7Lk9sjUFNiCZg8
         DCrG6J6TQIEOoicnNVKwqOVqIzjDlvWRUCUHpWpIV6hd4muB6PoR+hJjlMcg+6wAaU+w
         qs30X/gbefCuIdgA235uGHaLJMZu6IGDQTG5QNDI26/1FwXg8J0yFUYUhujfE605YRj0
         9AWRJXFnhpK49FTOYXikg/CtA2aZ0I1fWu6JAAPAJ0PVV3AxjBei62e/ZbAfaRlkii+E
         27VA1ByvNQMeYCr2nkAnRF0j5uTcIZB/qBpOF7GHvCQo09cY2cJF99cyhPUrIqThND56
         tXPg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=ay0N+fta;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=ay0N+fta;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AB8JxZqh3svNj82UsDHEf+1MQnmrkZebjT735XQZfhvgfKOh1VQm26IHNhe5HQYOSZir6IMfKYy3hg==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>,
	Kevin Hilman <khilman@kernel.org>,
	David Lechner <david@lechnology.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	Frank Rowand <frowand.list@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Arend van Spriel <aspriel@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Michal Suchanek <msuchanek@suse.de>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 02/11] platform: provide early_platform_driver_register_probe_all()
Date: Tue, 24 Apr 2018 19:30:42 +0200
Message-Id: <20180424173051.15099-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424173051.15099-1-brgl@bgdev.pl>
References: <20180424173051.15099-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598649610068649780?=
X-GMAIL-MSGID: =?utf-8?q?1598649610068649780?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

All users of early_platform_driver_register_all() subsequently call
early_platform_driver_probe(). Provide a helper that calls both
functions.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/platform_device.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 80942ed0f728..a06b194ba30b 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -314,6 +314,15 @@ static inline int is_early_platform_device(struct platform_device *pdev)
 extern void early_platform_driver_register_all(char *class_str);
 extern int early_platform_driver_probe(char *class_str,
 				       int nr_probe, int user_only);
+
+static inline int early_platform_driver_register_probe_all(char *class_str,
+							   int nr_probe,
+							   int user_only)
+{
+	early_platform_driver_register_all(class_str);
+	return early_platform_driver_probe(class_str, nr_probe, user_only);
+}
+
 extern void early_platform_cleanup(void);
 
 #define early_platform_init(class_string, platdrv)		\
-- 
2.17.0
