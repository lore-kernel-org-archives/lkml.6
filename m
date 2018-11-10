Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9342CC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC6620883
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KtegI2xx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC6620883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbeKJS2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 13:28:50 -0500
Received: from m50-138.163.com ([123.125.50.138]:42923 "EHLO m50-138.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728766AbeKJS2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 13:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=Bi57lGdU5Lxh8WLvLQ
        HosoYSktxE1uZv+6v9XeQgB2c=; b=KtegI2xxIqO7jeo/NgkVoZxd5eXiVWSxyh
        rBZklKGfLh5DYcmulugnuqQtsDAZ4hwnLc5fsoQK5Osw3uMa/e9Cwd24x6wsoY5G
        bwuwahLBvNQu+kKmSPVgXYXzhDyZQfsyMESJK5BToVfBnVsXcSsdXQ2BCuWHHjCB
        eTa0PbtqY=
Received: from localhost.localdomain (unknown [221.0.93.75])
        by smtp1 (Coremail) with SMTP id C9GowACH8wlKmuZbMGe2AA--.32S3;
        Sat, 10 Nov 2018 16:44:15 +0800 (CST)
From:   zoro <long17.cool@163.com>
To:     a.zummo@towertech.it
Cc:     alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        zoro <long17.cool@163.com>
Subject: [PATCH 2/3] rtc: sd3078: new driver.
Date:   Sat, 10 Nov 2018 16:43:52 +0800
Message-Id: <1541839433-28811-2-git-send-email-long17.cool@163.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1541839433-28811-1-git-send-email-long17.cool@163.com>
References: <1541839433-28811-1-git-send-email-long17.cool@163.com>
X-CM-TRANSID: C9GowACH8wlKmuZbMGe2AA--.32S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jr15uw1rKFyfKw47AFyxXwb_yoWftryUpa
        13AryYvrWqqFsIg39xKF95WF1fJw18Z3s29rs3Cw4S9F1UA3s8t3ZYqryYyF1DJrykurWa
        gr15KFWYgFWUWwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UBMKtUUUUU=
X-Originating-IP: [221.0.93.75]
X-CM-SenderInfo: 5orqwi2xof00ro6rljoofrz/1tbiDR-6F1QHKli+kAAAsw
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sd3078 is a combination RTC and SRAM device with I2C interface.

Signed-off-by: zoro <long17.cool@163.com>
---
 MAINTAINERS              |    6 +
 drivers/rtc/Kconfig      |    9 ++
 drivers/rtc/Makefile     |    1 +
 drivers/rtc/rtc-sd3078.c |  300 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 316 insertions(+)
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
index 290c173..de9b670 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -176,3 +176,4 @@ obj-$(CONFIG_RTC_DRV_WM8350)	+= rtc-wm8350.o
 obj-$(CONFIG_RTC_DRV_X1205)	+= rtc-x1205.o
 obj-$(CONFIG_RTC_DRV_XGENE)	+= rtc-xgene.o
 obj-$(CONFIG_RTC_DRV_ZYNQMP)	+= rtc-zynqmp.o
+obj-$(CONFIG_RTC_DRV_SD3078)	+= rtc-sd3078.o
diff --git a/drivers/rtc/rtc-sd3078.c b/drivers/rtc/rtc-sd3078.c
new file mode 100644
index 0000000..bb24ba1
--- /dev/null
+++ b/drivers/rtc/rtc-sd3078.c
@@ -0,0 +1,300 @@
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
+struct sd3078 {
+	struct rtc_device *rtc;
+};
+
+struct i2c_driver sd3078_driver;
+
+
+static int sd3078_i2c_read_regs(struct i2c_client *client,
+	unsigned char reg, unsigned char buf[], unsigned int len)
+{
+	struct i2c_adapter *adap = client->adapter;
+	unsigned char reg_buf = reg;
+	int ret;
+	struct i2c_msg msgs[] = {
+		{/* setup read ptr */
+			.addr = client->addr,
+			.len = 1,
+			.buf = &reg_buf
+		},
+		{/* read status + date */
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.len = len,
+			.buf = buf
+		},
+	};
+
+	ret = i2c_transfer(adap, msgs, 2);
+	return (ret == 2) ? len : ret;
+}
+
+static int sd3078_i2c_write_reg(struct i2c_client *client,
+	unsigned char reg, unsigned char value)
+{
+	unsigned char data[2];
+	int ret;
+
+	data[0] = reg;
+	data[1] = value;
+	ret = i2c_master_send(client, data, 2);
+	return ret;
+}
+
+/*
+ * In order to prevent arbitrary modification of the time register,
+ * when modification of the register,
+ * the "write" bit needs to be written in a certain order.
+ * 1. set WRITE1 bit
+ * 2. set WRITE2 bit
+ * 1. set WRITE3 bit
+ */
+static void sd3078_enable_reg_write(struct i2c_client *client)
+{
+	unsigned char reg1, reg2;
+
+	sd3078_i2c_read_regs(client, SD3078_REG_CTRL1, &reg1, 1);
+	sd3078_i2c_read_regs(client, SD3078_REG_CTRL2, &reg2, 1);
+
+	reg2 |= KEY_WRITE1;
+	sd3078_i2c_write_reg(client, SD3078_REG_CTRL2, reg2);
+
+	reg1 |= KEY_WRITE2;
+	sd3078_i2c_write_reg(client, SD3078_REG_CTRL1, reg1);
+
+	reg1 |= KEY_WRITE3;
+	sd3078_i2c_write_reg(client, SD3078_REG_CTRL1, reg1);
+
+	sd3078_i2c_read_regs(client, SD3078_REG_CTRL1, &reg1, 1);
+	sd3078_i2c_read_regs(client, SD3078_REG_CTRL2, &reg2, 1);
+}
+
+/*
+ * In order to prevent arbitrary modification of the time register,
+ * we should disable the write function.
+ * when disable write,
+ * the "write" bit needs to be clear in a certain order.
+ * 1. clear WRITE2 bit
+ * 2. clear WRITE3 bit
+ * 3. clear WRITE1 bit
+ */
+static void sd3078_disable_reg_write(struct i2c_client *client)
+{
+	unsigned char reg1, reg2;
+
+	sd3078_i2c_read_regs(client, SD3078_REG_CTRL1, &reg1, 1);
+	sd3078_i2c_read_regs(client, SD3078_REG_CTRL2, &reg2, 1);
+
+	reg1 &= ~KEY_WRITE2;
+	sd3078_i2c_write_reg(client, SD3078_REG_CTRL1, reg1);
+
+	reg1 &= ~KEY_WRITE3;
+	sd3078_i2c_write_reg(client, SD3078_REG_CTRL1, reg1);
+
+	reg2 &= ~KEY_WRITE1;
+	sd3078_i2c_write_reg(client, SD3078_REG_CTRL2, reg2);
+
+	sd3078_i2c_read_regs(client, SD3078_REG_CTRL1, &reg1, 1);
+	sd3078_i2c_read_regs(client, SD3078_REG_CTRL2, &reg2, 1);
+}
+
+static int sd3078_get_datetime(struct i2c_client *client, struct rtc_time *tm)
+{
+	unsigned char buf[7] = {0};
+	unsigned char hour;
+
+	sd3078_i2c_read_regs(client, SD3078_REG_SC, buf, 7);
+
+	tm->tm_sec	= bcd2bin(buf[SD3078_REG_SC] & 0x7F);
+	tm->tm_min	= bcd2bin(buf[SD3078_REG_MN] & 0x7F);
+	hour = buf[SD3078_REG_HR];
+
+	if (hour & 0x80) /* 24H PM */
+		tm->tm_hour = bcd2bin(buf[SD3078_REG_HR] & 0x3F);
+	else if (hour & 0x20) /* 12H PM */
+		tm->tm_hour = bcd2bin(buf[SD3078_REG_HR] & 0x1F) + 12;
+	else /* 12H AM */
+		tm->tm_hour = bcd2bin(buf[SD3078_REG_HR] & 0x1F);
+
+	tm->tm_mday = bcd2bin(buf[SD3078_REG_DM] & 0x3F);
+	tm->tm_wday = buf[SD3078_REG_DW] & 0x07;
+	/* rtc mn 1-12 */
+	tm->tm_mon	= bcd2bin(buf[SD3078_REG_MO] & 0x1F) - 1;
+	tm->tm_year = bcd2bin(buf[SD3078_REG_YR])+100;
+
+	if (rtc_valid_tm(tm) < 0)
+		dev_err(&client->dev, "retrieved date/time is not valid.\n");
+
+	return 0;
+}
+
+static int sd3078_set_datetime(struct i2c_client *client, struct rtc_time *tm)
+{
+	int i, err;
+	unsigned char buf[9];
+
+	dev_dbg(&client->dev,
+		"%s: secs=%d, mins=%d, hours=%d, mday=%d, mon=%d, year=%d, wday=%d\n",
+		__func__,
+		tm->tm_sec, tm->tm_min, tm->tm_hour,
+		tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
+
+    /* hours, minutes and seconds */
+	buf[SD3078_REG_SC] = bin2bcd(tm->tm_sec);
+	buf[SD3078_REG_MN] = bin2bcd(tm->tm_min);
+	/* set 24H mode */
+	buf[SD3078_REG_HR] = bin2bcd(tm->tm_hour) | 0x80;
+
+	buf[SD3078_REG_DM] = bin2bcd(tm->tm_mday);
+
+    /* month, 1 - 12 */
+	buf[SD3078_REG_MO] = bin2bcd(tm->tm_mon) + 1;
+
+    /* year and century */
+	buf[SD3078_REG_YR] = bin2bcd(tm->tm_year % 100);
+	buf[SD3078_REG_DW] = tm->tm_wday & 0x07;
+
+	sd3078_enable_reg_write(client);
+
+    /* write register's data */
+	for (i = 0; i < 7; i++) {
+		err = sd3078_i2c_write_reg(client,
+			SD3078_REG_SC + i, buf[SD3078_REG_SC + i]);
+		if (err != 2)
+			return -EIO;
+	}
+
+	sd3078_disable_reg_write(client);
+
+	return 0;
+}
+
+
+#ifdef CONFIG_RTC_INTF_DEV
+static int sd3078_rtc_ioctl(struct device *dev,
+		unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+#else
+#define sd3078_rtc_ioctl NULL
+#endif
+
+static int sd3078_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	return sd3078_get_datetime(to_i2c_client(dev), tm);
+}
+
+static int sd3078_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	return sd3078_set_datetime(to_i2c_client(dev), tm);
+}
+
+static const struct rtc_class_ops sd3078_rtc_ops = {
+	.ioctl		= sd3078_rtc_ioctl,
+	.read_time	= sd3078_rtc_read_time,
+	.set_time	= sd3078_rtc_set_time,
+};
+
+static int sd3078_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	struct sd3078 *sd3078;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -ENODEV;
+
+	sd3078 = devm_kzalloc(&client->dev, sizeof(*sd3078), GFP_KERNEL);
+	if (!sd3078)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, sd3078);
+
+	sd3078->rtc = devm_rtc_device_register(&client->dev,
+			sd3078_driver.driver.name,
+			&sd3078_rtc_ops, THIS_MODULE);
+
+	if (IS_ERR(sd3078->rtc))
+		return PTR_ERR(sd3078->rtc);
+
+	return 0;
+}
+
+static int sd3078_remove(struct i2c_client *client)
+{
+	return 0;
+}
+
+static const struct i2c_device_id sd3078_id[] = {
+	{"sd3078", 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, sd3078_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id rtc_dt_ids[] = {
+	{ .compatible = "whwave,sd3078" },
+	{},
+};
+#endif
+
+struct i2c_driver sd3078_driver = {
+	.driver     = {
+		.name   = "sd3078",
+		.owner  = THIS_MODULE,
+#ifdef CONFIG_OF
+		.of_match_table = of_match_ptr(rtc_dt_ids),
+#endif
+	},
+	.probe      = sd3078_probe,
+	.remove     = sd3078_remove,
+	.id_table   = sd3078_id,
+};
+
+static int __init sd3078_init(void)
+{
+	return i2c_add_driver(&sd3078_driver);
+}
+
+static void __exit sd3078_exit(void)
+{
+	i2c_del_driver(&sd3078_driver);
+}
+
+module_init(sd3078_init);
+module_exit(sd3078_exit);
+
+MODULE_AUTHOR("Zoro Li <long17.cool@163.com>");
+MODULE_DESCRIPTION("SD3078 RTC driver");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5

