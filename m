Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1524591083; cv=none;
        d=google.com; s=arc-20160816;
        b=E3X0KAK/MnOMLqzrqc3YpmsxCs2M2rDLHb8spxlDuQEpr8W1XPBBYbwAasnZ0SD8nz
         DTKgbVOsiZ9iCgkNkd27ZH1hX4+UNOg3Gpqyy+DP+/VrX3UHm7XEQA+bvSSdJxfi/VRO
         p9HBXzTUEPlagm/AXMahyE7DEdkpFkMIw8/7JFN3bFo7OBMqFd55GtX13Deo501OG10n
         rLYmSxvfdnCAjtADgKCu31HmoJpvXRDTUvPYgiCdrK5s/dOhG7RJanpawqMz0ytZ+o1g
         cqiauN3x2xwiSza/vq5mEUITrasrdr3nJhYJ6/lIbSzSpRpf9k0r7QKpqECUeSDmpKGf
         Dvug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=AF5i7bopzONNfMZoNU+bcfzxnKd1UsOyQaS7YHs6Q2Q=;
        b=Sgo9SZOP6Kq8WHTU6U56YeUZ04+i3YecVv5ISOpfxSY7pqRdaFtpxeJrpoyAL28UJo
         RFS1fd8go1qsSgyu/x8ZYO7/TL42XovYE2kpf4YS2om5W9jz0mEwOwn7+T7jVHxH3xEW
         1AVyNtjuFDQ0pyH8tFVZNKzPeg7ulRHaDkeQMHWr8N1BIh2yWfJWrsU+j51UGcaUabYz
         q8mU+eAEVxRWVC0qC4RIMFNZd5nl+7uTo/dSQMsFXPZ4PwE37uXcZwTwou05B1XLcp/C
         TJ5d44xd5+kYqjGlv9lc5eT5HwHKdGocCmRs85Vyauoqc0X9i0NVr/mTYOXsSyiK8kvv
         cZ1A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=UM8fMEoQ;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=UM8fMEoQ;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AIpwx4+uBjJCeuLhpObQyBFs/aR+GIJq886quj/apC3bdAf2IZLE6sbI79V3J8qo4PL33amANz0EPw==
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
Subject: [PATCH 09/11] platform: provide early_platform_driver()
Date: Tue, 24 Apr 2018 19:30:49 +0200
Message-Id: <20180424173051.15099-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424173051.15099-1-brgl@bgdev.pl>
References: <20180424173051.15099-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598649620120941196?=
X-GMAIL-MSGID: =?utf-8?q?1598649620120941196?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Implement a macro similar to module_platform_driver() which allows to
register early platform drivers with the default early class.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/platform_device.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 514ada776004..b565a1237fa6 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -297,6 +297,8 @@ struct early_platform_driver {
 #define EARLY_PLATFORM_ID_UNSET -2
 #define EARLY_PLATFORM_ID_ERROR -3
 
+#define EARLY_PLATFORM_DEFAULT_CLASS	"earlydev"
+
 #ifdef CONFIG_EARLY_PLATFORM_DEVICES
 
 extern int early_platform_driver_register(struct early_platform_driver *epdrv,
@@ -352,6 +354,9 @@ static inline char *early_platform_driver_setup_func(void)		\
 }
 #endif /* MODULE */
 
+#define early_platform_driver(__platdrv)				\
+	early_platform_init(EARLY_PLATFORM_DEFAULT_CLASS, &(__platdrv))
+
 #else /* CONFIG_EARLY_PLATFORM_DEVICES */
 static inline int
 early_platform_driver_register(struct early_platform_driver *epdrv, char *buf)
@@ -380,6 +385,7 @@ static inline int early_platform_driver_register_probe_all(char *class_str,
 static inline void early_platform_cleanup(void) {}
 #define early_platform_init(class_string, platdrv)
 #define early_platform_init_buffer(class_string, platdrv, buf, bufsiz)
+#define early_platform_driver(__platdrv)
 #endif /* CONFIG_EARLY_PLATFORM_DEVICES */
 
 #ifdef CONFIG_SUSPEND
-- 
2.17.0
