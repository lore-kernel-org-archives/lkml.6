Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1524591078; cv=none;
        d=google.com; s=arc-20160816;
        b=xwYL12Dqde7Nzdr6g2qom+Emc4lLbS4t/hanPl5JMUHkrmGJU93VPGY6kOmvgVJpci
         CspAjyJ6s6pJ4wC8EAjOxwoTdqHwJ8Um6gqhwZrK5axiYpftybwhcjIjvDj9vUhykVU3
         AS4lcqpCtMhR7imditjGXeaUCnWcHS6tfqCX9z/c2S2a4vc2aZHw3JEtfayYnqOK+m2L
         q0zi6TrM88TYgeSEuo8ImhKES4kAPhQMQxBNAidqjpo3QQmP5RJ41xRuVSkwZv5cI53U
         PvF+vAG3SKFBCJezNDIM10akpWBvWTKxwszj1iqUjyxUxxpSNQE5c9/ndQ7C29TpCB9x
         Yv0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Hphkt6sRKx6VihPh1q2ZHpK8q6ml/dUdDZYmNt/z0/k=;
        b=TEL4vLIebc0qmxrKkMJc9i/oeyZek/d4RcXlyHuizb9Dvy5hRlaWjkX/8aS80C3xvy
         f+vAloildJ6rumsFlHG4nVUy7GMsKUR0sFurT7EXzhemOd6okIXko0yf+t+6ckmDeHdv
         BCC7OkA74xUhWi8WxBz8JR4U77nyRX02b/LX0LB/vdgJbREUxH0GgTZBZiaxplLqP5H0
         j8CQHgLpIMbgrO2pELRyBsZOiULMsylx4rBuXE5wTHmOSKwdMPmzUtQivLsnpQMC+8zm
         AJj73yOcN32rJpaVIi84uiexK4ym5C6bPkl15HoF9m3POCjwjNuC9Uk7+fg1WyWWe/V5
         0CtA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=Lj+Xr/mY;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=Lj+Xr/mY;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AIpwx4/1b4X//4IMsViDWkqXtCVcDP736qba4LCpDOaXcRKyD5XgqwPkhx/QI06smFm2PmGDk8lCRQ==
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
Subject: [PATCH 05/11] platform: use a dedicated list_head for early devices
Date: Tue, 24 Apr 2018 19:30:45 +0200
Message-Id: <20180424173051.15099-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424173051.15099-1-brgl@bgdev.pl>
References: <20180424173051.15099-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598649615095711988?=
X-GMAIL-MSGID: =?utf-8?q?1598649615095711988?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The current implementation of early platform device support uses the
devres list head in struct device. This causes problems when adding
support for device tree based early devices. Use a dedicated list_head
which is included in struct device conditionally in order to avoid
adding bloat for all architectures.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/base/platform.c | 23 +++++++++++------------
 include/linux/device.h  |  4 ++++
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index af440d703f0b..90526acdcb84 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1264,12 +1264,10 @@ void __init early_platform_add_devices(struct platform_device **devs, int num)
 	for (i = 0; i < num; i++) {
 		dev = &devs[i]->dev;
 
-		if (!dev->devres_head.next) {
-			pm_runtime_early_init(dev);
-			INIT_LIST_HEAD(&dev->devres_head);
-			list_add_tail(&dev->devres_head,
-				      &early_platform_device_list);
-		}
+		pm_runtime_early_init(dev);
+		INIT_LIST_HEAD(&dev->early_dev_head);
+		list_add_tail(&dev->early_dev_head,
+			      &early_platform_device_list);
 	}
 }
 
@@ -1310,7 +1308,7 @@ early_platform_match(struct early_platform_driver *epdrv, int id)
 {
 	struct platform_device *pd;
 
-	list_for_each_entry(pd, &early_platform_device_list, dev.devres_head)
+	list_for_each_entry(pd, &early_platform_device_list, dev.early_dev_head)
 		if (platform_match(&pd->dev, &epdrv->pdrv->driver))
 			if (pd->id == id)
 				return pd;
@@ -1328,7 +1326,7 @@ static int __init early_platform_left(struct early_platform_driver *epdrv,
 {
 	struct platform_device *pd;
 
-	list_for_each_entry(pd, &early_platform_device_list, dev.devres_head)
+	list_for_each_entry(pd, &early_platform_device_list, dev.early_dev_head)
 		if (platform_match(&pd->dev, &epdrv->pdrv->driver))
 			if (pd->id >= id)
 				return 1;
@@ -1465,11 +1463,12 @@ void __init early_platform_cleanup(void)
 {
 	struct platform_device *pd, *pd2;
 
-	/* clean up the devres list used to chain devices */
+	/* clean up the list used to chain devices */
 	list_for_each_entry_safe(pd, pd2, &early_platform_device_list,
-				 dev.devres_head) {
-		list_del(&pd->dev.devres_head);
-		memset(&pd->dev.devres_head, 0, sizeof(pd->dev.devres_head));
+				 dev.early_dev_head) {
+		list_del(&pd->dev.early_dev_head);
+		memset(&pd->dev.early_dev_head, 0,
+		       sizeof(pd->dev.early_dev_head));
 	}
 }
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 0059b99e1f25..4fadba0f9a35 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -979,6 +979,10 @@ struct device {
 	spinlock_t		devres_lock;
 	struct list_head	devres_head;
 
+#ifdef CONFIG_EARLY_PLATFORM_DEVICES
+	struct list_head	early_dev_head;
+#endif
+
 	struct klist_node	knode_class;
 	struct class		*class;
 	const struct attribute_group **groups;	/* optional groups */
-- 
2.17.0
