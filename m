Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6366DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A36208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f8qN89VO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A36208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbeIZTWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:22:48 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55108 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbeIZTWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:22:47 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8QD9k40014957;
        Wed, 26 Sep 2018 08:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537967386;
        bh=7DObjAyWijvqnwyWjDHbAJTrBrB9hou2Z5L3SwUgid0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=f8qN89VOS/GGRMNRQqVsbq6PQVECXW2fUbZeYoLs+AOjrEqLGD/luMBUZqbuESzYN
         2J5Kcf7/+ZrCwUviF298JjIvDPhTdoKVAky9ndIDuAjKeXqxgC3A5y21HL07gmo+g8
         Aw+Ii+RNAroQbYoceQLFJXvBpYk8KWO5SZB9jknA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8QD9kWX020224;
        Wed, 26 Sep 2018 08:09:46 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 26
 Sep 2018 08:09:46 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 26 Sep 2018 08:09:46 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8QD9kJC003517;
        Wed, 26 Sep 2018 08:09:46 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.176.238])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w8QD9jx11627;
        Wed, 26 Sep 2018 08:09:46 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lee.jones@linaro.org>, <linux-omap@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Milo Kim <milo.kim@ti.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [RFC PATCH 1/9] leds: add TI LMU backlight driver
Date:   Wed, 26 Sep 2018 08:09:13 -0500
Message-ID: <20180926130921.12329-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20180926130921.12329-1-dmurphy@ti.com>
References: <20180926130921.12329-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Machek <pavel@ucw.cz>

This adds backlight support for the following TI LMU
chips: LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.

It controls LEDs on Droid 4
smartphone, including keyboard and screen backlights.

Signed-off-by: Milo Kim <milo.kim@ti.com>
[add LED subsystem support for keyboard backlight and rework DT
binding according to Rob Herrings feedback]
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
[remove backlight subsystem support for now]
Signed-off-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/leds/Kconfig             |   8 ++
 drivers/leds/Makefile            |   1 +
 drivers/leds/ti-lmu-led-common.c | 175 +++++++++++++++++++++++++++++++
 drivers/leds/ti-lmu-led-common.h |  43 ++++++++
 4 files changed, 227 insertions(+)
 create mode 100644 drivers/leds/ti-lmu-led-common.c
 create mode 100644 drivers/leds/ti-lmu-led-common.h

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 44097a3e0fcc..dc717b30d9d3 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -756,6 +756,14 @@ config LEDS_NIC78BX
 	  To compile this driver as a module, choose M here: the module
 	  will be called leds-nic78bx.
 
+config LEDS_TI_LMU_COMMON
+	tristate "LED driver for TI LMU"
+	depends on REGMAP
+	help
+          Say Y to enable the LED driver for TI LMU devices.
+          This supports common features between the TI LM3532, LM3631, LM3632,
+	  LM3633, LM3695 and LM3697.
+
 comment "LED Triggers"
 source "drivers/leds/trigger/Kconfig"
 
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 420b5d2cfa62..e09bb27bc7ea 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -78,6 +78,7 @@ obj-$(CONFIG_LEDS_MT6323)		+= leds-mt6323.o
 obj-$(CONFIG_LEDS_LM3692X)		+= leds-lm3692x.o
 obj-$(CONFIG_LEDS_SC27XX_BLTC)		+= leds-sc27xx-bltc.o
 obj-$(CONFIG_LEDS_LM3601X)		+= leds-lm3601x.o
+obj-$(CONFIG_LEDS_TI_LMU_COMMON)	+= ti-lmu-led-common.o
 
 # LED SPI Drivers
 obj-$(CONFIG_LEDS_CR0014114)		+= leds-cr0014114.o
diff --git a/drivers/leds/ti-lmu-led-common.c b/drivers/leds/ti-lmu-led-common.c
new file mode 100644
index 000000000000..60e900b71681
--- /dev/null
+++ b/drivers/leds/ti-lmu-led-common.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2015 Texas Instruments
+ * Copyright 2018 Sebastian Reichel
+ * Copyright 2018 Pavel Machek <pavel@ucw.cz>
+ *
+ * TI LMU Led driver, based on previous work from
+ * Milo Kim <milo.kim@ti.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include "ti-lmu-led-common.h"
+
+const static int ramp_table[16] = { 2, 262, 524, 1049, 2090, 4194, 8389,
+				16780, 33550, 41940, 50330, 58720,
+				67110, 83880, 100660, 117440};
+
+static int ti_lmu_common_enable(struct ti_lmu_bank *lmu_bank, bool enable)
+{
+	struct regmap *regmap = lmu_bank->regmap;
+	unsigned long enable_time = lmu_bank->enable_usec;
+	u8 reg = lmu_bank->enable_reg;
+	u8 mask = BIT(lmu_bank->bank_id);
+	u8 val = (enable == true) ? mask : 0;
+	int ret;
+
+	return 0;
+	if (!reg)
+		return -EINVAL;
+
+	ret = regmap_update_bits(regmap, reg, mask, val);
+	if (ret)
+		return ret;
+
+	if (enable_time > 0)
+		usleep_range(enable_time, enable_time + 100);
+
+	return 0;
+}
+
+static int ti_lmu_common_update_brightness_register(struct ti_lmu_bank *lmu_bank,
+						       int brightness)
+{
+	struct regmap *regmap = lmu_bank->regmap;
+	u8 reg, val;
+	int ret;
+
+	/*
+	 * Brightness register update
+	 *
+	 * 11 bit dimming: update LSB bits and write MSB byte.
+	 *		   MSB brightness should be shifted.
+	 *  8 bit dimming: write MSB byte.
+	 */
+	if (lmu_bank->max_brightness == MAX_BRIGHTNESS_11BIT) {
+		reg = lmu_bank->lsb_brightness_reg;
+		ret = regmap_update_bits(regmap, reg,
+					 LMU_11BIT_LSB_MASK,
+					 brightness);
+		if (ret)
+			return ret;
+
+		val = brightness >> LMU_11BIT_MSB_SHIFT;
+	} else {
+		val = brightness;
+	}
+
+	reg = lmu_bank->msb_brightness_reg;
+printk("%s: Reg 0x%X\n", __func__, reg);
+	return regmap_write(regmap, reg, val);
+}
+
+int ti_lmu_common_set_brightness(struct ti_lmu_bank *lmu_bank,
+				    int brightness)
+{
+	bool enable = brightness > 0;
+	int ret;
+
+	ret = ti_lmu_common_enable(lmu_bank, enable);
+	if (ret)
+		return ret;
+
+	lmu_bank->current_brightness = brightness;
+
+	return ti_lmu_common_update_brightness_register(lmu_bank, brightness);
+}
+EXPORT_SYMBOL(ti_lmu_common_set_brightness);
+
+static int ti_lmu_common_convert_ramp_to_index(unsigned int msec)
+{
+	int size = ARRAY_SIZE(ramp_table);
+	int i;
+
+	if (msec <= ramp_table[0])
+		return 0;
+
+	if (msec > ramp_table[size - 1])
+		return size - 1;
+
+	for (i = 1; i < size; i++) {
+		if (msec == ramp_table[i])
+			return i;
+
+		/* Find an approximate index by looking up the table */
+		if (msec > ramp_table[i - 1] && msec < ramp_table[i]) {
+			if (msec - ramp_table[i - 1] < ramp_table[i] - msec)
+				return i - 1;
+			else
+				return i;
+		}
+	}
+
+	return -EINVAL;
+}
+
+
+int ti_lmu_common_set_ramp(struct ti_lmu_bank *lmu_bank)
+{
+	struct regmap *regmap = lmu_bank->regmap;
+	u8 ramp, ramp_up, ramp_down;
+
+	if (lmu_bank->ramp_up_msec == 0 && lmu_bank->ramp_down_msec == 0) {
+		ramp_up = 0;
+		ramp_down = 0;
+	} else {
+		ramp_up = ti_lmu_common_convert_ramp_to_index(lmu_bank->ramp_up_msec);
+		ramp_down = ti_lmu_common_convert_ramp_to_index(lmu_bank->ramp_down_msec);
+	}
+
+	if (ramp_up < 0 || ramp_down < 0)
+		return -EINVAL;
+
+	ramp = (ramp_up << 4) | ramp_down;
+
+	return regmap_write(regmap, lmu_bank->runtime_ramp_reg, ramp);
+
+}
+EXPORT_SYMBOL(ti_lmu_common_set_ramp);
+
+int ti_lmu_common_get_ramp_params(struct device *dev,
+				  struct fwnode_handle *child,
+				  struct ti_lmu_bank *lmu_data)
+{
+
+	int ret;
+
+	ret = fwnode_property_read_u32(child, "ramp-up-ms",
+				 &lmu_data->ramp_up_msec);
+	if (ret)
+		dev_warn(dev, "ramp-up-ms property missing\n");
+
+
+	ret = fwnode_property_read_u32(child, "ramp-down-ms",
+				 &lmu_data->ramp_down_msec);
+	if (ret)
+		dev_warn(dev, "ramp-down-ms property missing\n");
+
+	return 0;
+}
+EXPORT_SYMBOL(ti_lmu_common_get_ramp_params);
+
+MODULE_DESCRIPTION("TI LMU LED Driver");
+MODULE_AUTHOR("Sebastian Reichel");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:ti-lmu-led");
diff --git a/drivers/leds/ti-lmu-led-common.h b/drivers/leds/ti-lmu-led-common.h
new file mode 100644
index 000000000000..874ebdb62b58
--- /dev/null
+++ b/drivers/leds/ti-lmu-led-common.h
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+// TI LMU Common Core
+// Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+
+#define LMU_DUAL_CHANNEL_USED	(BIT(0) | BIT(1))
+#define LMU_11BIT_LSB_MASK	(BIT(0) | BIT(1) | BIT(2))
+#define LMU_11BIT_MSB_SHIFT	3
+
+#define MAX_BRIGHTNESS_8BIT	255
+#define MAX_BRIGHTNESS_11BIT	2047
+
+#define NUM_DUAL_CHANNEL	2
+
+struct ti_lmu_bank {
+	struct regmap *regmap;
+
+	int bank_id;
+	int fault_monitor_used;
+
+	u8 enable_reg;
+	unsigned long enable_usec;
+
+	int current_brightness;
+	u32 default_brightness;
+	int max_brightness;
+
+	u8 lsb_brightness_reg;
+	u8 msb_brightness_reg;
+
+	u8 runtime_ramp_reg;
+	u32 ramp_up_msec;
+	u32 ramp_down_msec;
+};
+
+
+int ti_lmu_common_set_brightness(struct ti_lmu_bank *lmu_bank,
+				    int brightness);
+
+int ti_lmu_common_set_ramp(struct ti_lmu_bank *lmu_bank);
+
+int ti_lmu_common_get_ramp_params(struct device *dev,
+				  struct fwnode_handle *child,
+				  struct ti_lmu_bank *lmu_data);
-- 
2.19.0

