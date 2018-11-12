Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02026C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B302C21722
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="krtxL/JU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B302C21722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731681AbeKLPxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:53:16 -0500
Received: from m50-134.163.com ([123.125.50.134]:37731 "EHLO m50-134.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731226AbeKLPxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=X94dcTxRbnX7bBgU52
        uzELKIAW37OrLnfwxKkmGGu3w=; b=krtxL/JUY01Gm1wNifh8l9wXa5TILc4Yyw
        z7eV5UzjDzdtoatcoPKRn2nCee/1FADCnuToU0913FkYw5REIV3ih1BJvPlTu3CV
        JZjkDgBezwntxFH9ZIXDQiOrn5ot8WV6fgh1UEE9wFCNG/mYdgbc8d2tH8dxDa7w
        wLBZkBUNA=
Received: from localhost.localdomain (unknown [221.0.93.75])
        by smtp4 (Coremail) with SMTP id DtGowAAXHkZsE+lb52OQAQ--.34S3;
        Mon, 12 Nov 2018 13:45:41 +0800 (CST)
From:   zoro <long17.cool@163.com>
To:     alexandre.belloni@bootlin.com
Cc:     a.zummo@towertech.it, mark.rutland@arm.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, zoro <long17.cool@163.com>
Subject: [PATCH 2/4] rtc: sd3078: new driver.
Date:   Mon, 12 Nov 2018 13:45:13 +0800
Message-Id: <1542001514-8167-2-git-send-email-long17.cool@163.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1542001514-8167-1-git-send-email-long17.cool@163.com>
References: <1542001514-8167-1-git-send-email-long17.cool@163.com>
X-CM-TRANSID: DtGowAAXHkZsE+lb52OQAQ--.34S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xr1kWw4DAF1UKw4ruFy8Xwb_yoWfGF1fpa
        13AFy5tF4DtF43G3y5KFy8WF13Jw18Aw1IvF13Gw429w1UA3s8J3ZagryYy3Z8tr97CFWa
        gr1YyFWYgr1DuaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UVUDAUUUUU=
X-Originating-IP: [221.0.93.75]
X-CM-SenderInfo: 5orqwi2xof00ro6rljoofrz/1tbiPQX8F1SIY5JEDwAAs1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sd3078 is a combination RTC and SRAM device with I2C interface.

Signed-off-by: zoro <long17.cool@163.com>
---
 MAINTAINERS              |    6 ++
 drivers/rtc/Kconfig      |    9 ++
 drivers/rtc/Makefile     |    1 +
 drivers/rtc/rtc-sd3078.c |  235 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 251 insertions(+)
 create mode 100644 drivers/rtc/rtc-sd3078.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2f3eba4..002fcd7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16125,6 +16125,12 @@ L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-wcove.c
 
+WHWAVE RTC DRIVER
+M:	Zoro Li <long17.cool@163.com>
+L:	linux-rtc@vger.kernel.org
+S:	Maintained
+F:	drivers/rtc/rtc-sd3078.c
+
 WIIMOTE HID DRIVER
 M:	David Herrmann <dh.herrmann@googlemail.com>
 L:	linux-input@vger.kernel.org
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index a819ef0..5b4b1b4 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -646,6 +646,15 @@ config RTC_DRV_S5M
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-s5m.
 
+config RTC_DRV_SD3078
+    tristate "ZXW Crystal SD3078"
+    help
+      If you say yes here you get support for the ZXW Crystal
+      SD3078 RTC chips.
+
+      This driver can also be built as a module. If so, the module
+      will be called rtc-sd3078.
+
 endif # I2C
 
 comment "SPI RTC drivers"
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 290c173..f973bd0 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -148,6 +148,7 @@ obj-$(CONFIG_RTC_DRV_S3C)	+= rtc-s3c.o
 obj-$(CONFIG_RTC_DRV_S5M)	+= rtc-s5m.o
 obj-$(CONFIG_RTC_DRV_SA1100)	+= rtc-sa1100.o
 obj-$(CONFIG_RTC_DRV_SC27XX)	+= rtc-sc27xx.o
+obj-$(CONFIG_RTC_DRV_SD3078)	+= rtc-sd3078.o
 obj-$(CONFIG_RTC_DRV_SH)	+= rtc-sh.o
 obj-$(CONFIG_RTC_DRV_SIRFSOC)	+= rtc-sirfsoc.o
 obj-$(CONFIG_RTC_DRV_SNVS)	+= rtc-snvs.o
diff --git a/drivers/rtc/rtc-sd3078.c b/drivers/rtc/rtc-sd3078.c
new file mode 100644
index 0000000..97e8f4b
--- /dev/null
+++ b/drivers/rtc/rtc-sd3078.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Real Time Clock (RTC) Driver for sd3078
+ * Copyright (C) 2018 Zoro Li
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/bcd.h>
+#include <linux/rtc.h>
+#include <linux/slab.h>
+#include <linux/regmap.h>
+
+#define SD3078_REG_SC			0x00
+#define SD3078_REG_MN			0x01
+#define SD3078_REG_HR			0x02
+#define SD3078_REG_DW			0x03
+#define SD3078_REG_DM			0x04
+#define SD3078_REG_MO			0x05
+#define SD3078_REG_YR			0x06
+
+#define SD3078_REG_CTRL1		0x0f
+#define SD3078_REG_CTRL2		0x10
+#define SD3078_REG_CTRL3		0x11
+
+#define KEY_WRITE1		0x80
+#define KEY_WRITE2		0x04
+#define KEY_WRITE3		0x80
+
+#define NUM_TIME_REGS   (SD3078_REG_YR - SD3078_REG_SC + 1)
+
+/*
+ * The sd3078 has write protection
+ * and we can choose whether or not to use it.
+ * Write protection is turned off by default.
+ */
+#define WRITE_PROTECT_EN	0
+
+struct sd3078 {
+	struct rtc_device	*rtc;
+	struct regmap		*regmap;
+};
+
+/*
+ * In order to prevent arbitrary modification of the time register,
+ * when modification of the register,
+ * the "write" bit needs to be written in a certain order.
+ * 1. set WRITE1 bit
+ * 2. set WRITE2 bit
+ * 3. set WRITE3 bit
+ */
+static void sd3078_enable_reg_write(struct sd3078 *sd3078)
+{
+	regmap_update_bits(sd3078->regmap, SD3078_REG_CTRL2,
+		KEY_WRITE1, KEY_WRITE1);
+	regmap_update_bits(sd3078->regmap, SD3078_REG_CTRL1,
+		KEY_WRITE2, KEY_WRITE2);
+	regmap_update_bits(sd3078->regmap, SD3078_REG_CTRL1,
+		KEY_WRITE3, KEY_WRITE3);
+}
+
+#if WRITE_PROTECT_EN
+/*
+ * In order to prevent arbitrary modification of the time register,
+ * we should disable the write function.
+ * when disable write,
+ * the "write" bit needs to be clear in a certain order.
+ * 1. clear WRITE2 bit
+ * 2. clear WRITE3 bit
+ * 3. clear WRITE1 bit
+ */
+static void sd3078_disable_reg_write(struct sd3078 *sd3078)
+{
+	regmap_update_bits(sd3078->regmap, SD3078_REG_CTRL1,
+		KEY_WRITE2, 0);
+	regmap_update_bits(sd3078->regmap, SD3078_REG_CTRL1,
+		KEY_WRITE3, 0);
+	regmap_update_bits(sd3078->regmap, SD3078_REG_CTRL2,
+		KEY_WRITE1, 0);
+}
+#endif
+
+static int sd3078_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	unsigned char hour;
+	unsigned char rtc_data[NUM_TIME_REGS] = {0};
+	struct i2c_client *client = to_i2c_client(dev);
+	struct sd3078 *sd3078 = i2c_get_clientdata(client);
+	int ret;
+
+	ret = regmap_bulk_read(sd3078->regmap, SD3078_REG_SC, rtc_data,
+			NUM_TIME_REGS);
+	if (ret < 0) {
+		dev_err(dev, "reading from RTC failed with err:%d\n", ret);
+		return ret;
+	}
+
+	tm->tm_sec	= bcd2bin(rtc_data[SD3078_REG_SC] & 0x7F);
+	tm->tm_min	= bcd2bin(rtc_data[SD3078_REG_MN] & 0x7F);
+
+	/*
+	 * The sd3078 supports 12/24 hour mode.
+	 * When getting time,
+	 * we need to convert the 12 hour mode to the 24 hour mode.
+	 */
+	hour = rtc_data[SD3078_REG_HR];
+	if (hour & 0x80) /* 24H MODE */
+		tm->tm_hour = bcd2bin(rtc_data[SD3078_REG_HR] & 0x3F);
+	else if (hour & 0x20) /* 12H MODE PM */
+		tm->tm_hour = bcd2bin(rtc_data[SD3078_REG_HR] & 0x1F) + 12;
+	else /* 12H MODE AM */
+		tm->tm_hour = bcd2bin(rtc_data[SD3078_REG_HR] & 0x1F);
+
+	tm->tm_mday = bcd2bin(rtc_data[SD3078_REG_DM] & 0x3F);
+	tm->tm_wday = rtc_data[SD3078_REG_DW] & 0x07;
+	tm->tm_mon	= bcd2bin(rtc_data[SD3078_REG_MO] & 0x1F) - 1;
+	tm->tm_year = bcd2bin(rtc_data[SD3078_REG_YR])+100;
+
+	return 0;
+}
+
+static int sd3078_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	unsigned char rtc_data[NUM_TIME_REGS];
+	struct i2c_client *client = to_i2c_client(dev);
+	struct sd3078 *sd3078 = i2c_get_clientdata(client);
+	int ret;
+
+	rtc_data[SD3078_REG_SC] = bin2bcd(tm->tm_sec);
+	rtc_data[SD3078_REG_MN] = bin2bcd(tm->tm_min);
+	rtc_data[SD3078_REG_HR] = bin2bcd(tm->tm_hour) | 0x80;
+	rtc_data[SD3078_REG_DM] = bin2bcd(tm->tm_mday);
+	rtc_data[SD3078_REG_DW] = tm->tm_wday & 0x07;
+	rtc_data[SD3078_REG_MO] = bin2bcd(tm->tm_mon) + 1;
+	rtc_data[SD3078_REG_YR] = bin2bcd(tm->tm_year - 100);
+
+#if WRITE_PROTECT_EN
+	sd3078_enable_reg_write(sd3078);
+#endif
+
+	ret = regmap_bulk_write(sd3078->regmap, SD3078_REG_SC, rtc_data,
+			NUM_TIME_REGS);
+	if (ret < 0) {
+		dev_err(dev, "writing to RTC failed with err:%d\n", ret);
+		return ret;
+	}
+
+#if WRITE_PROTECT_EN
+	sd3078_disable_reg_write(sd3078);
+#endif
+
+	return 0;
+}
+
+static const struct rtc_class_ops sd3078_rtc_ops = {
+	.read_time	= sd3078_rtc_read_time,
+	.set_time	= sd3078_rtc_set_time,
+};
+
+static const struct regmap_config regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x11,
+};
+
+static int sd3078_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	int ret;
+	struct sd3078 *sd3078;
+
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -ENODEV;
+
+	sd3078 = devm_kzalloc(&client->dev, sizeof(*sd3078), GFP_KERNEL);
+	if (!sd3078)
+		return -ENOMEM;
+
+	sd3078->regmap = devm_regmap_init_i2c(client, &regmap_config);
+	if (IS_ERR(sd3078->regmap)) {
+		dev_err(&client->dev, "regmap allocation failed\n");
+		return PTR_ERR(sd3078->regmap);
+	}
+
+	i2c_set_clientdata(client, sd3078);
+
+	sd3078->rtc = devm_rtc_allocate_device(&client->dev);
+	if (IS_ERR(sd3078->rtc))
+		return PTR_ERR(sd3078->rtc);
+
+	sd3078->rtc->ops = &sd3078_rtc_ops;
+	sd3078->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	sd3078->rtc->range_max = RTC_TIMESTAMP_END_2099;
+	sd3078->rtc->start_secs = RTC_TIMESTAMP_BEGIN_2000;
+	sd3078->rtc->set_start_time = true;
+
+	ret = rtc_register_device(sd3078->rtc);
+	if (ret) {
+		dev_err(&client->dev, "failed to register rtc device\n");
+		return ret;
+	}
+
+	sd3078_enable_reg_write(sd3078);
+
+	return 0;
+}
+
+static const struct i2c_device_id sd3078_id[] = {
+	{"sd3078", 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, sd3078_id);
+
+static const struct of_device_id rtc_dt_match[] = {
+	{ .compatible = "whwave,sd3078" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rtc_dt_match);
+
+struct i2c_driver sd3078_driver = {
+	.driver     = {
+		.name   = "sd3078",
+		.owner  = THIS_MODULE,
+		.of_match_table = of_match_ptr(rtc_dt_match),
+	},
+	.probe      = sd3078_probe,
+	.id_table   = sd3078_id,
+};
+
+module_i2c_driver(sd3078_driver);
+
+MODULE_AUTHOR("Zoro Li <long17.cool@163.com>");
+MODULE_DESCRIPTION("SD3078 RTC driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5


