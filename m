Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F0EC6786C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72B02084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72B02084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbeLLXv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:51:57 -0500
Received: from anholt.net ([50.246.234.109]:59094 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728460AbeLLXvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 18:51:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id E119310A1D98;
        Wed, 12 Dec 2018 15:51:54 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id u3_SVJ6UX-ya; Wed, 12 Dec 2018 15:51:51 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 3C1A210A0372;
        Wed, 12 Dec 2018 15:51:51 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 320C02FE36EE; Wed, 12 Dec 2018 15:51:50 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH v4 2/5] bcm2835-pm: Move bcm2835-watchdog's DT probe to an MFD.
Date:   Wed, 12 Dec 2018 15:51:47 -0800
Message-Id: <20181212235150.6491-3-eric@anholt.net>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181212235150.6491-1-eric@anholt.net>
References: <20181212235150.6491-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PM block that the wdt driver was binding to actually has multiple
features we want to expose (power domains, reset, watchdog).  Move the
DT attachment to a MFD driver and make WDT probe against MFD.

Signed-off-by: Eric Anholt <eric@anholt.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---

v3: don't reset bcm2835_power_off_wdt on remove, drop pm driver's
    empty remove, sort includes, add a "static".
v4: no change

 arch/arm/mach-bcm/Kconfig      |  1 +
 drivers/mfd/Makefile           |  1 +
 drivers/mfd/bcm2835-pm.c       | 64 ++++++++++++++++++++++++++++++++++
 drivers/watchdog/bcm2835_wdt.c | 26 +++++---------
 include/linux/mfd/bcm2835-pm.h | 13 +++++++
 5 files changed, 88 insertions(+), 17 deletions(-)
 create mode 100644 drivers/mfd/bcm2835-pm.c
 create mode 100644 include/linux/mfd/bcm2835-pm.h

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 25aac6ee2ab1..95242c2162a2 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -167,6 +167,7 @@ config ARCH_BCM2835
 	select BCM2835_TIMER
 	select PINCTRL
 	select PINCTRL_BCM2835
+	select MFD_CORE
 	help
 	  This enables support for the Broadcom BCM2835 and BCM2836 SoCs.
 	  This SoC is used in the Raspberry Pi and Roku 2 devices.
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 12980a4ad460..ee6fb6af655e 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_MFD_88PM805)	+= 88pm805.o 88pm80x.o
 obj-$(CONFIG_MFD_ACT8945A)	+= act8945a.o
 obj-$(CONFIG_MFD_SM501)		+= sm501.o
 obj-$(CONFIG_MFD_ASIC3)		+= asic3.o tmio_core.o
+obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835-pm.o
 obj-$(CONFIG_MFD_BCM590XX)	+= bcm590xx.o
 obj-$(CONFIG_MFD_BD9571MWV)	+= bd9571mwv.o
 cros_ec_core-objs		:= cros_ec.o
diff --git a/drivers/mfd/bcm2835-pm.c b/drivers/mfd/bcm2835-pm.c
new file mode 100644
index 000000000000..53839e6a81e7
--- /dev/null
+++ b/drivers/mfd/bcm2835-pm.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * PM MFD driver for Broadcom BCM2835
+ *
+ * This driver binds to the PM block and creates the MFD device for
+ * the WDT driver.
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/mfd/bcm2835-pm.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+#include <linux/watchdog.h>
+
+static const struct mfd_cell bcm2835_pm_devs[] = {
+	{ .name = "bcm2835-wdt" },
+};
+
+static int bcm2835_pm_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	struct bcm2835_pm *pm;
+
+	pm = devm_kzalloc(dev, sizeof(*pm), GFP_KERNEL);
+	if (!pm)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, pm);
+
+	pm->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pm->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(pm->base))
+		return PTR_ERR(pm->base);
+
+	return devm_mfd_add_devices(dev, -1,
+				    bcm2835_pm_devs, ARRAY_SIZE(bcm2835_pm_devs),
+				    NULL, 0, NULL);
+}
+
+static const struct of_device_id bcm2835_pm_of_match[] = {
+	{ .compatible = "brcm,bcm2835-pm-wdt", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, bcm2835_pm_of_match);
+
+static struct platform_driver bcm2835_pm_driver = {
+	.probe		= bcm2835_pm_probe,
+	.driver = {
+		.name =	"bcm2835-pm",
+		.of_match_table = bcm2835_pm_of_match,
+	},
+};
+module_platform_driver(bcm2835_pm_driver);
+
+MODULE_AUTHOR("Eric Anholt <eric@anholt.net>");
+MODULE_DESCRIPTION("Driver for Broadcom BCM2835 PM MFD");
+MODULE_LICENSE("GPL");
diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
index ed05514cc2dc..1834524ae373 100644
--- a/drivers/watchdog/bcm2835_wdt.c
+++ b/drivers/watchdog/bcm2835_wdt.c
@@ -12,6 +12,7 @@
 
 #include <linux/delay.h>
 #include <linux/types.h>
+#include <linux/mfd/bcm2835-pm.h>
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/watchdog.h>
@@ -47,6 +48,8 @@ struct bcm2835_wdt {
 	spinlock_t		lock;
 };
 
+static struct bcm2835_wdt *bcm2835_power_off_wdt;
+
 static unsigned int heartbeat;
 static bool nowayout = WATCHDOG_NOWAYOUT;
 
@@ -148,10 +151,7 @@ static struct watchdog_device bcm2835_wdt_wdd = {
  */
 static void bcm2835_power_off(void)
 {
-	struct device_node *np =
-		of_find_compatible_node(NULL, NULL, "brcm,bcm2835-pm-wdt");
-	struct platform_device *pdev = of_find_device_by_node(np);
-	struct bcm2835_wdt *wdt = platform_get_drvdata(pdev);
+	struct bcm2835_wdt *wdt = bcm2835_power_off_wdt;
 	u32 val;
 
 	/*
@@ -169,7 +169,7 @@ static void bcm2835_power_off(void)
 
 static int bcm2835_wdt_probe(struct platform_device *pdev)
 {
-	struct resource *res;
+	struct bcm2835_pm *pm = dev_get_drvdata(pdev->dev.parent);
 	struct device *dev = &pdev->dev;
 	struct bcm2835_wdt *wdt;
 	int err;
@@ -181,10 +181,7 @@ static int bcm2835_wdt_probe(struct platform_device *pdev)
 
 	spin_lock_init(&wdt->lock);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	wdt->base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(wdt->base))
-		return PTR_ERR(wdt->base);
+	wdt->base = pm->base;
 
 	watchdog_set_drvdata(&bcm2835_wdt_wdd, wdt);
 	watchdog_init_timeout(&bcm2835_wdt_wdd, heartbeat, dev);
@@ -211,8 +208,10 @@ static int bcm2835_wdt_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	if (pm_power_off == NULL)
+	if (pm_power_off == NULL) {
 		pm_power_off = bcm2835_power_off;
+		bcm2835_power_off_wdt = wdt;
+	}
 
 	dev_info(dev, "Broadcom BCM2835 watchdog timer");
 	return 0;
@@ -226,18 +225,11 @@ static int bcm2835_wdt_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id bcm2835_wdt_of_match[] = {
-	{ .compatible = "brcm,bcm2835-pm-wdt", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, bcm2835_wdt_of_match);
-
 static struct platform_driver bcm2835_wdt_driver = {
 	.probe		= bcm2835_wdt_probe,
 	.remove		= bcm2835_wdt_remove,
 	.driver = {
 		.name =		"bcm2835-wdt",
-		.of_match_table = bcm2835_wdt_of_match,
 	},
 };
 module_platform_driver(bcm2835_wdt_driver);
diff --git a/include/linux/mfd/bcm2835-pm.h b/include/linux/mfd/bcm2835-pm.h
new file mode 100644
index 000000000000..b7d0ee1feffa
--- /dev/null
+++ b/include/linux/mfd/bcm2835-pm.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef BCM2835_MFD_PM_H
+#define BCM2835_MFD_PM_H
+
+#include <linux/regmap.h>
+
+struct bcm2835_pm {
+	struct device *dev;
+	void __iomem *base;
+};
+
+#endif /* BCM2835_MFD_PM_H */
-- 
2.20.0.rc1

