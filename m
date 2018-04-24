Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1524591072; cv=none;
        d=google.com; s=arc-20160816;
        b=xNuGqlslYmKCD+6UEQJe+fFa08p9Sirq9pJVtSuMQSMYetYSgSaU5BA6mKn46w1T2c
         3nYpafc4guNMN4Bnta27fN1uVWjUDE1DE6vY8PaX9CwCtJPBnZEsAf+659cERTjK1roT
         yMsGzlnuObjkbFbsNXbEJUBxRIWB6yQ2jub9eHIe3MBGNBs373A30md7TzKtZ1mGmgTG
         32LTSpQqKQtXJQbKG522jvc1Dpmt513O+97qaN0VauFXTAU/cUrRaQoje9RYUYiR6AKV
         17tveuPPmBsPNCMOvgznLOj7H22XrziPZRZAvs6CfFNeuaVZc2mmvq2cqSgiFuIfS5A4
         5Xlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=TLphgLDITGLWBW8+v0MCFaYzGJJYv3PJMes+2gWVaNQ=;
        b=CZItRVlh2S9aY3GWPHFjeTbKTze5dpUgZJSvvD42gPEJtVb5gTmBx1p0vGcmpRN3P8
         5zVjXSF2F5lzBFx+XoBKHQ5mCPBF2Ui8+RolEf/KwlXjH0KipAkouAIlhpvGTSsFVBpG
         kH088yLtA6yGYFDwaWSS0N708fGrV/jmd6a/aKY+tk2qJ71NlKXbh8AKrq6Y2Hqb3W6z
         PzeFYORopr/92uCSxQ+bhepXKnuUYlY1evIbNF/7yxYd1jqezSVcfJZpDaF3HmH1HsbP
         XQZvVFGtbY0fVxhQsDMdcY8fH5c+FpADNsGrViBw67XYZ096APF0I3eA00j63UpWFzQn
         GHJA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=Aoc4iZ36;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=Aoc4iZ36;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AIpwx4/D7Z+9ziV8Vnr7+pvtpIfwMHSN/5f5TgEGvuZkYydExoAYPkkaPcCuY237yzEfVRDk/WRlBQ==
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
Subject: [PATCH 01/11] platform: early: provide early_platform_add_device()
Date: Tue, 24 Apr 2018 19:30:41 +0200
Message-Id: <20180424173051.15099-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424173051.15099-1-brgl@bgdev.pl>
References: <20180424173051.15099-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598649608628512261?=
X-GMAIL-MSGID: =?utf-8?q?1598649608628512261?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Currently we only have early_platform_add_devices() which takes struct
platform_device ** as argument, requiring the users to have an
intermediate array of platform_device pointers even if we're only
adding a single device. Provide a helper for adding a single device at
a time.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/platform_device.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 49f634d96118..80942ed0f728 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -301,6 +301,11 @@ extern int early_platform_driver_register(struct early_platform_driver *epdrv,
 					  char *buf);
 extern void early_platform_add_devices(struct platform_device **devs, int num);
 
+static inline void early_platform_add_device(struct platform_device *pdev)
+{
+	early_platform_add_devices(&pdev, 1);
+}
+
 static inline int is_early_platform_device(struct platform_device *pdev)
 {
 	return !pdev->dev.driver;
-- 
2.17.0
