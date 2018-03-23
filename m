Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752115AbeCWJPi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:15:38 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:8094 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752031AbeCWJPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:15:34 -0400
X-UUID: cf1b09778bc04746b67da7c5f4551c55-20180323
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@free-electrons.com>, <eddie.huang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 14/16] power: reset: mediatek: add a power-off driver using PMIC RTC device
Date: Fri, 23 Mar 2018 17:15:11 +0800
Message-ID: <ba7cd65b58f335b44896bd671f8b0f851d04fc01.1521794177.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1521794176.git.sean.wang@mediatek.com>
References: <cover.1521794176.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TM-AS-Result: No-10.060200-8.000000-10
X-TMASE-MatchedRID: JyIAaEVCrzj0D0R+G5TTHG3NvezwBrVmfyrfUN0YezFPGHsd9KuVvWKL
        UFBAt61QFcdCclPPDWDgPjs6tRtgu83AmdtMjGJV7spMO3HwKCBMkOX0UoduuRO8aYSWhGprk2T
        /+ntghnWbNqqkONAOMX7tMNSOBia14Ho+osNU9hC4jAucHcCqnZYcYQ11P5U/xKLCLOyCW5A6qd
        xtMsrheOT03QcW1KNjg1j35+66aZOITy3hkRxZn935+5/2RxqmRvyVHewb0kLb6Y+fnTZULylAn
        CVKw8otPYXgc3Os37S8MOaGTOJX/VEAXL0Ub1O9jQlVVwSbjyd9LQinZ4QefPcjNeVeWlqY+gtH
        j7OwNO3DW0xVTs41PByifjvNlByyWjjqXH6QNIM4Ga9HnpJ2mD/UnX2flMRI
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.060200-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

The power device is responsible for externally down or up the power
of the remote MediaTek SoC through the tiny circuit BBPU inside PMIC RTC.

Though it's a part of RTC device, it would be better to be a standalone
driver against existent RTC driver so as to make concentration on works
about power-controlling topic and help gather more improvements while the
subsystem's constantly growing.

Currently, the most basic functionality supported is to just power off the
system by writing to a special bit field in BBPU register after the system
has reached pm_poweroff.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/power/reset/Kconfig               |   9 +++
 drivers/power/reset/Makefile              |   1 +
 drivers/power/reset/mt6397-rtc-poweroff.c | 100 ++++++++++++++++++++++++++++++
 include/linux/rtc/mt6397.h                |   1 +
 4 files changed, 111 insertions(+)
 create mode 100644 drivers/power/reset/mt6397-rtc-poweroff.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index a102e74..0bd4603 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -121,6 +121,15 @@ config POWER_RESET_LTC2952
 	  This driver supports an external powerdown trigger and board power
 	  down via the LTC2952. Bindings are made in the device tree.
 
+config POWER_RESET_MT6397_RTC
+	bool "MediaTek MT6397 RTC power-off driver"
+	help
+	  This driver supports turning off a remote MediaTek SoC by
+	  controlling BBPU on MT6397 or MT6323 RTC.
+
+	  Select this if you're building a kernel with your MediaTek SoC
+	  with an equipment with MT6397 or MT6323 PMIC.
+
 config POWER_RESET_QNAP
 	bool "QNAP power-off driver"
 	depends on OF_GPIO && PLAT_ORION
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index dcc92f5..d45099e 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_POWER_RESET_GPIO) += gpio-poweroff.o
 obj-$(CONFIG_POWER_RESET_GPIO_RESTART) += gpio-restart.o
 obj-$(CONFIG_POWER_RESET_HISI) += hisi-reboot.o
 obj-$(CONFIG_POWER_RESET_MSM) += msm-poweroff.o
+obj-$(CONFIG_POWER_RESET_MT6397_RTC) += mt6397-rtc-poweroff.o
 obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) += piix4-poweroff.o
 obj-$(CONFIG_POWER_RESET_LTC2952) += ltc2952-poweroff.o
 obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
diff --git a/drivers/power/reset/mt6397-rtc-poweroff.c b/drivers/power/reset/mt6397-rtc-poweroff.c
new file mode 100644
index 0000000..9b57366
--- /dev/null
+++ b/drivers/power/reset/mt6397-rtc-poweroff.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Power-off using MediaTek PMIC RTC device
+ *
+ * Copyright (C) 2018 MediaTek Inc.
+ *
+ * Author: Sean Wang <sean.wang@mediatek.com>
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/rtc/mt6397.h>
+
+struct mt6397_rtc_powercon {
+	struct device *dev;
+	struct mt6397_rtc *rtc;
+};
+
+static struct mt6397_rtc_powercon *mt_powercon;
+
+static void mt6397_rtc_do_poweroff(void)
+{
+	struct mt6397_rtc_powercon *powercon = mt_powercon;
+	struct mt6397_rtc *rtc = powercon->rtc;
+	unsigned int val;
+	int ret;
+
+	regmap_write(rtc->regmap, rtc->addr_base + RTC_BBPU, RTC_BBPU_KEY);
+	regmap_write(rtc->regmap, rtc->addr_base + RTC_WRTGR, 1);
+
+	ret = regmap_read_poll_timeout(rtc->regmap,
+				       rtc->addr_base + RTC_BBPU, val,
+				       !(val & RTC_BBPU_CBUSY),
+				       MTK_RTC_POLL_DELAY_US,
+				       MTK_RTC_POLL_TIMEOUT);
+	if (ret)
+		dev_err(powercon->dev, "failed to write BBPU: %d\n", ret);
+
+	/* Wait some time until system down, otherwise, notice with a warn */
+	mdelay(1000);
+
+	WARN_ONCE(1, "Unable to poweroff system\n");
+}
+
+static int mt6397_rtc_poweroff_probe(struct platform_device *pdev)
+{
+	struct mt6397_rtc *rtc = dev_get_drvdata(pdev->dev.parent);
+	struct mt6397_rtc_powercon *powercon;
+
+	if (!rtc) {
+		dev_err(&pdev->dev, "Can't find RTC as the parent\n");
+		return -ENODEV;
+	}
+
+	powercon = devm_kzalloc(&pdev->dev, sizeof(*powercon), GFP_KERNEL);
+	if (!powercon)
+		return -ENOMEM;
+
+	powercon->dev = &pdev->dev;
+	powercon->rtc = rtc;
+	mt_powercon = powercon;
+
+	pm_power_off = &mt6397_rtc_do_poweroff;
+
+	return 0;
+}
+
+static int mt6397_rtc_poweroff_remove(struct platform_device *pdev)
+{
+	if (pm_power_off == &mt6397_rtc_do_poweroff)
+		pm_power_off = NULL;
+
+	return 0;
+}
+
+static const struct of_device_id mt6397_rtc_poweroff_dt_match[] = {
+	{ .compatible = "mediatek,mt6323-rtc-poweroff" },
+	{ .compatible = "mediatek,mt6397-rtc-poweroff" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mt6397_rtc_poweroff_dt_match);
+
+static struct platform_driver mt6397_rtc_poweroff_driver = {
+	.probe		= mt6397_rtc_poweroff_probe,
+	.remove		= mt6397_rtc_poweroff_remove,
+	.driver		= {
+		.name	= "mt6397-rtc-poweroff",
+		.of_match_table = mt6397_rtc_poweroff_dt_match,
+	},
+};
+
+module_platform_driver(mt6397_rtc_poweroff_driver);
+
+MODULE_DESCRIPTION("Poweroff driver using MediaTek PMIC RTC");
+MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:mt6397-rtc-poweroff");
diff --git a/include/linux/rtc/mt6397.h b/include/linux/rtc/mt6397.h
index 4b19f51..e618974 100644
--- a/include/linux/rtc/mt6397.h
+++ b/include/linux/rtc/mt6397.h
@@ -17,6 +17,7 @@
 
 #define RTC_BBPU		0x0000
 #define RTC_BBPU_CBUSY		BIT(6)
+#define RTC_BBPU_KEY            (0x43 << 8)
 
 #define RTC_WRTGR		0x003c
 
-- 
2.7.4
