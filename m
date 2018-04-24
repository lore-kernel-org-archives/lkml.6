Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1524591075; cv=none;
        d=google.com; s=arc-20160816;
        b=AtgUEiJxd+vytjX++0l1HeGjTM54Ez1ngWLabX5W5fJX8Pfpgu2haWx5pBVNCNk6LI
         hL45yVBiCeEdwy1/Zy2yPLOV5AuVZKanFBXn07nL6JGPvcJT0SpE6EM3GzPsW4X8kEHR
         36DZidrG1dxPQWBu+stA56MmYuwc4f/M2+lYubMIQull7tdwuAJoK19Yja/8petJY1mV
         +b52NxDKY2yJMxSK60HK2+M425xYgKp97MBn+wLvNbUj5yrEAzx1I3hrMXdR8VNycfOE
         C07JZ0C7istX1LGvZd+BAbS5g0yEXKPmcvsrBYJyyBCpwzGiWC8gIdyZQVYUSf2MZnDL
         6CHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=46yJAB9wRvjH/A5SVZUn62iLxZgjlZ02Sd3Ww4ZeKxU=;
        b=zrT+YoFwD0YUvN98jjevXA58eCMJt/WKuwCjVFQGiaw8xTrTlvdnHxvZUhlqghJwwi
         y+0y085l9hJmQqC6196GsftBzSgCpf4N/23oJoRp4y6N7S98SMpPfQ4FDw8IZWGAw+xB
         o4zlykwEScBBAPs8cT5ANH6l39HLpjXLNc75v+uD2WX8N+iXGNO0DRFp7AK8kG6F/mvb
         rQiEgtt0jrgNKX3FBIOA/6zK/1AaWMhlZW33NPQNCgScU6T4/5v6V6nou7fjR+Tu7kT8
         WMBcql5AixQHyH8Kng/0Me9P4H3UFXWWGKyaAKaM1taVZoBm45Km9qFRG86G3Kj5QKCW
         w51Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=qZMW0vkd;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=qZMW0vkd;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AIpwx48aK9FcU3dNnrJTWeq0TzC6oDRVJ6g7qXQsvZG3KYC10OtnZikuocgd7D9fu5WPu9zWG2IWRA==
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
Subject: [PATCH 03/11] platform: make support for early platform devices conditional
Date: Tue, 24 Apr 2018 19:30:43 +0200
Message-Id: <20180424173051.15099-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424173051.15099-1-brgl@bgdev.pl>
References: <20180424173051.15099-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598649611911110790?=
X-GMAIL-MSGID: =?utf-8?q?1598649611911110790?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We want to add support for device tree based early platform devices.

In order not to introduce additional bloat for all users when we extend
struct device to accomodate early platform DT support, let's make the
current machine code support conditional.

The only current user of the early platform infrastructure is SuperH so
make it select the appropriate Kconfig option.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/sh/Kconfig                 |  1 +
 drivers/base/Kconfig            |  4 ++++
 drivers/base/platform.c         |  3 +++
 include/linux/platform_device.h | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 40 insertions(+)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 97fe29316476..1b2c0b2ce402 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -50,6 +50,7 @@ config SUPERH
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_NMI
+	select EARLY_PLATFORM_DEVICES
 	help
 	  The SuperH is a RISC processor targeted for use in embedded systems
 	  and consumer electronics; it was also used in the Sega Dreamcast
diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 29b0eb452b3a..37de5e1d6217 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -205,6 +205,10 @@ config DEBUG_TEST_DRIVER_REMOVE
 	  unusable. You should say N here unless you are explicitly looking to
 	  test this functionality.
 
+config EARLY_PLATFORM_DEVICES
+	bool
+	default n
+
 source "drivers/base/test/Kconfig"
 
 config SYS_HYPERVISOR
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 8075ddc70a17..af440d703f0b 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1186,6 +1186,8 @@ u64 dma_get_required_mask(struct device *dev)
 EXPORT_SYMBOL_GPL(dma_get_required_mask);
 #endif
 
+#ifdef CONFIG_EARLY_PLATFORM_DEVICES
+
 static __initdata LIST_HEAD(early_platform_driver_list);
 static __initdata LIST_HEAD(early_platform_device_list);
 
@@ -1471,3 +1473,4 @@ void __init early_platform_cleanup(void)
 	}
 }
 
+#endif /* CONFIG_EARLY_PLATFORM_DEVICES */
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index a06b194ba30b..514ada776004 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -297,6 +297,8 @@ struct early_platform_driver {
 #define EARLY_PLATFORM_ID_UNSET -2
 #define EARLY_PLATFORM_ID_ERROR -3
 
+#ifdef CONFIG_EARLY_PLATFORM_DEVICES
+
 extern int early_platform_driver_register(struct early_platform_driver *epdrv,
 					  char *buf);
 extern void early_platform_add_devices(struct platform_device **devs, int num);
@@ -350,6 +352,36 @@ static inline char *early_platform_driver_setup_func(void)		\
 }
 #endif /* MODULE */
 
+#else /* CONFIG_EARLY_PLATFORM_DEVICES */
+static inline int
+early_platform_driver_register(struct early_platform_driver *epdrv, char *buf)
+{
+	return -ENOSYS;
+}
+static inline void
+early_platform_add_devices(struct platform_device **devs, int num) {}
+static inline void early_platform_add_device(struct platform_device *pdev) {}
+static inline int is_early_platform_device(struct platform_device *pdev)
+{
+	return -ENOSYS;
+}
+static inline void early_platform_driver_register_all(char *class_str) {}
+static inline int early_platform_driver_probe(char *class_str,
+					      int nr_probe, int user_only)
+{
+	return -ENOSYS;
+}
+static inline int early_platform_driver_register_probe_all(char *class_str,
+							   int nr_probe,
+							   int user_only)
+{
+	return -ENOSYS;
+}
+static inline void early_platform_cleanup(void) {}
+#define early_platform_init(class_string, platdrv)
+#define early_platform_init_buffer(class_string, platdrv, buf, bufsiz)
+#endif /* CONFIG_EARLY_PLATFORM_DEVICES */
+
 #ifdef CONFIG_SUSPEND
 extern int platform_pm_suspend(struct device *dev);
 extern int platform_pm_resume(struct device *dev);
-- 
2.17.0
