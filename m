Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B71C5ACC7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB86214DB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB86214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeKUIIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:08:23 -0500
Received: from anholt.net ([50.246.234.109]:52736 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbeKUIIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 03:08:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id F194C10A162F;
        Tue, 20 Nov 2018 13:37:09 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id FMPkUa72XtPC; Tue, 20 Nov 2018 13:37:05 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id A27B210A15B1;
        Tue, 20 Nov 2018 13:37:03 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 867F42FE1FE8; Tue, 20 Nov 2018 13:37:02 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 2/5] bcm2835-pm: Move bcm2835-watchdog's DT probe to an MFD.
Date:   Tue, 20 Nov 2018 13:36:59 -0800
Message-Id: <20181120213702.27958-3-eric@anholt.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120213702.27958-1-eric@anholt.net>
References: <20181120213702.27958-1-eric@anholt.net>
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
---
 arch/arm/mach-bcm/Kconfig      |  1 +
 drivers/mfd/Makefile           |  1 +
 drivers/mfd/bcm2835-pm.c       | 70 ++++++++++++++++++++++++++++++++++
 drivers/watchdog/bcm2835_wdt.c | 30 ++++++---------
 include/linux/mfd/bcm2835-pm.h | 13 +++++++
 5 files changed, 97 insertions(+), 18 deletions(-)
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
index 000000000000..197ff8bcca90
--- /dev/null
+++ b/drivers/mfd/bcm2835-pm.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * PM MFD driver for Broadcom BCM2835
+ *
+ * This driver binds to the PM block and creates the MFD device for
+ * the WDT driver.
+ */
+
+#include <linux/delay.h>
+#include <linux/types.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/bcm2835-pm.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/watchdog.h>
+#include <linux/platform_device.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
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
+static int bcm2835_pm_remove(struct platform_device *pdev)
+{
+	return 0;
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
+	.remove		= bcm2835_pm_remove,
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
index ed05514cc2dc..9061436fbf90 100644
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
 
+struct bcm2835_wdt *bcm2835_power_off_wdt;
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
@@ -220,24 +219,19 @@ static int bcm2835_wdt_probe(struct platform_device *pdev)
 
 static int bcm2835_wdt_remove(struct platform_device *pdev)
 {
-	if (pm_power_off == bcm2835_power_off)
+	if (pm_power_off == bcm2835_power_off) {
 		pm_power_off = NULL;
+		bcm2835_power_off_wdt = NULL;
+	}
 
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
2.19.1

