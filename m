Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0558ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CA220874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6CA220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=diehl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388488AbeGXMr7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:47:59 -0400
Received: from enterprise01.smtp.diehl.com ([193.201.238.219]:46989 "EHLO
        enterprise01.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388275AbeGXMr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:47:58 -0400
X-$ESA-Groupmapping: true
X-IronPort-AV: E=Sophos;i="5.51,397,1526335200"; 
   d="scan'208";a="53953752"
From:   Denis OSTERLAND <denis.osterland@diehl.com>
To:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Denis OSTERLAND <denis.osterland@diehl.com>
Subject: [PATCH v5 2/5] rtc: isl1208: add support for isl1219 with tamper
 detection
Thread-Topic: [PATCH v5 2/5] rtc: isl1208: add support for isl1219 with tamper
 detection
Thread-Index: AQHUI0HY81VSrc3FZUGh3VyN63eCEg==
Date:   Tue, 24 Jul 2018 11:31:21 +0000
Message-ID: <20180724095437.6016-3-Denis.Osterland@diehl.com>
References: <20180724095437.6016-1-Denis.Osterland@diehl.com>
In-Reply-To: <20180724095437.6016-1-Denis.Osterland@diehl.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
MIME-Version: 1.0
X-TrailerSkip: 1
X-GBS-PROC: byQFdw3ukCM+zy1/poiPc3S+cPOwesVRp3YOtqJ1nLGzDTCHgOUEK+Oxjt5YvNJU
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Grzeschik <m.grzeschik@pengutronix.de>

We add support for the ISL1219 chip that got an integrated tamper
detection function. This patch implements the feature by adding
an additional timestamp0 file to sysfs device path.
This file contains seconds since epoch, if an event occurred,
or is empty, if none occurred.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
---
 drivers/rtc/rtc-isl1208.c | 131 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 124 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index 1a2c38cc0178..3150ebdcb179 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -14,6 +14,7 @@
 #include <linux/i2c.h>
 #include <linux/bcd.h>
 #include <linux/rtc.h>
+#include "rtc-core.h"
 
 /* Register map */
 /* rtc section */
@@ -33,13 +34,15 @@
 #define ISL1208_REG_SR_ARST    (1<<7)	/* auto reset */
 #define ISL1208_REG_SR_XTOSCB  (1<<6)	/* crystal oscillator */
 #define ISL1208_REG_SR_WRTC    (1<<4)	/* write rtc */
+#define ISL1208_REG_SR_EVT     (1<<3)	/* event */
 #define ISL1208_REG_SR_ALM     (1<<2)	/* alarm */
 #define ISL1208_REG_SR_BAT     (1<<1)	/* battery */
 #define ISL1208_REG_SR_RTCF    (1<<0)	/* rtc fail */
 #define ISL1208_REG_INT 0x08
 #define ISL1208_REG_INT_ALME   (1<<6)   /* alarm enable */
 #define ISL1208_REG_INT_IM     (1<<7)   /* interrupt/alarm mode */
-#define ISL1208_REG_09  0x09	/* reserved */
+#define ISL1219_REG_EV  0x09
+#define ISL1219_REG_EV_EVEN    (1<<4)   /* event detection enable */
 #define ISL1208_REG_ATR 0x0a
 #define ISL1208_REG_DTR 0x0b
 
@@ -57,8 +60,24 @@
 #define ISL1208_REG_USR2 0x13
 #define ISL1208_USR_SECTION_LEN 2
 
+/* event section */
+#define ISL1219_REG_SCT 0x14
+#define ISL1219_REG_MNT 0x15
+#define ISL1219_REG_HRT 0x16
+#define ISL1219_REG_DTT 0x17
+#define ISL1219_REG_MOT 0x18
+#define ISL1219_REG_YRT 0x19
+#define ISL1219_EVT_SECTION_LEN 6
+
 static struct i2c_driver isl1208_driver;
 
+/* ISL1208 various variants */
+enum {
+	TYPE_ISL1208 = 0,
+	TYPE_ISL1218,
+	TYPE_ISL1219,
+};
+
 /* block read */
 static int
 isl1208_i2c_read_regs(struct i2c_client *client, u8 reg, u8 buf[],
@@ -80,8 +99,8 @@ isl1208_i2c_read_regs(struct i2c_client *client, u8 reg, u8 buf[],
 	};
 	int ret;
 
-	BUG_ON(reg > ISL1208_REG_USR2);
-	BUG_ON(reg + len > ISL1208_REG_USR2 + 1);
+	WARN_ON(reg > ISL1219_REG_YRT);
+	WARN_ON(reg + len > ISL1219_REG_YRT + 1);
 
 	ret = i2c_transfer(client->adapter, msgs, 2);
 	if (ret > 0)
@@ -104,8 +123,8 @@ isl1208_i2c_set_regs(struct i2c_client *client, u8 reg, u8 const buf[],
 	};
 	int ret;
 
-	BUG_ON(reg > ISL1208_REG_USR2);
-	BUG_ON(reg + len > ISL1208_REG_USR2 + 1);
+	WARN_ON(reg > ISL1219_REG_YRT);
+	WARN_ON(reg + len > ISL1219_REG_YRT + 1);
 
 	i2c_buf[0] = reg;
 	memcpy(&i2c_buf[1], &buf[0], len);
@@ -493,6 +512,73 @@ isl1208_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	return isl1208_i2c_set_alarm(to_i2c_client(dev), alarm);
 }
 
+static ssize_t timestamp0_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct i2c_client *client = dev_get_drvdata(dev);
+	int sr;
+
+	sr = isl1208_i2c_get_sr(client);
+	if (sr < 0) {
+		dev_err(dev, "%s: reading SR failed\n", __func__);
+		return sr;
+	}
+
+	sr &= ~ISL1208_REG_SR_EVT;
+
+	sr = i2c_smbus_write_byte_data(client, ISL1208_REG_SR, sr);
+	if (sr < 0)
+		dev_err(dev, "%s: writing SR failed\n",
+			__func__);
+
+	return count;
+};
+
+static ssize_t timestamp0_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = dev_get_drvdata(dev);
+	u8 regs[ISL1219_EVT_SECTION_LEN] = { 0, };
+	struct rtc_time tm;
+	int sr;
+
+	sr = isl1208_i2c_get_sr(client);
+	if (sr < 0) {
+		dev_err(dev, "%s: reading SR failed\n", __func__);
+		return sr;
+	}
+
+	if (!(sr & ISL1208_REG_SR_EVT))
+		return 0;
+
+	sr = isl1208_i2c_read_regs(client, ISL1219_REG_SCT, regs,
+				   ISL1219_EVT_SECTION_LEN);
+	if (sr < 0) {
+		dev_err(dev, "%s: reading event section failed\n",
+			__func__);
+		return 0;
+	}
+
+	/* MSB of each alarm register is an enable bit */
+	tm.tm_sec = bcd2bin(regs[ISL1219_REG_SCT - ISL1219_REG_SCT] & 0x7f);
+	tm.tm_min = bcd2bin(regs[ISL1219_REG_MNT - ISL1219_REG_SCT] & 0x7f);
+	tm.tm_hour = bcd2bin(regs[ISL1219_REG_HRT - ISL1219_REG_SCT] & 0x3f);
+	tm.tm_mday = bcd2bin(regs[ISL1219_REG_DTT - ISL1219_REG_SCT] & 0x3f);
+	tm.tm_mon =
+		bcd2bin(regs[ISL1219_REG_MOT - ISL1219_REG_SCT] & 0x1f) - 1;
+	tm.tm_year = bcd2bin(regs[ISL1219_REG_YRT - ISL1219_REG_SCT]) + 100;
+
+	sr = rtc_valid_tm(&tm);
+	if (sr)
+		return sr;
+
+	return sprintf(buf, "%llu\n",
+				(unsigned long long)rtc_tm_to_time64(&tm));
+};
+
+static DEVICE_ATTR_RW(timestamp0);
+
 static irqreturn_t
 isl1208_rtc_interrupt(int irq, void *data)
 {
@@ -538,6 +624,13 @@ isl1208_rtc_interrupt(int irq, void *data)
 			return err;
 	}
 
+	if (sr & ISL1208_REG_SR_EVT) {
+		sysfs_notify(&rtc->dev.kobj, NULL,
+			dev_attr_timestamp0.attr.name);
+		dev_warn(&client->dev, "event detected");
+		handled = 1;
+	}
+
 	return handled ? IRQ_HANDLED : IRQ_NONE;
 }
 
@@ -623,6 +716,15 @@ static const struct attribute_group isl1208_rtc_sysfs_files = {
 	.attrs	= isl1208_rtc_attrs,
 };
 
+static struct attribute *isl1219_rtc_attrs[] = {
+	&dev_attr_timestamp0.attr,
+	NULL
+};
+
+static const struct attribute_group isl1219_rtc_sysfs_files = {
+	.attrs	= isl1219_rtc_attrs,
+};
+
 static int
 isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
@@ -642,6 +744,7 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	rtc->ops = &isl1208_rtc_ops;
 
 	i2c_set_clientdata(client, rtc);
+	dev_set_drvdata(&rtc->dev, client);
 
 	rc = isl1208_i2c_get_sr(client);
 	if (rc < 0) {
@@ -653,6 +756,18 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		dev_warn(&client->dev, "rtc power failure detected, "
 			 "please set clock.\n");
 
+	if (id->driver_data == TYPE_ISL1219) {
+		rc = i2c_smbus_write_byte_data(client, ISL1219_REG_EV,
+							ISL1219_REG_EV_EVEN);
+		if (rc < 0) {
+			dev_err(&client->dev, "could not enable tamper detection\n");
+			return rc;
+		}
+		rc = rtc_add_group(rtc, &isl1219_rtc_sysfs_files);
+		if (rc)
+			return rc;
+	}
+
 	rc = sysfs_create_group(&client->dev.kobj, &isl1208_rtc_sysfs_files);
 	if (rc)
 		return rc;
@@ -686,8 +801,9 @@ isl1208_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id isl1208_id[] = {
-	{ "isl1208", 0 },
-	{ "isl1218", 0 },
+	{ "isl1208", TYPE_ISL1208 },
+	{ "isl1218", TYPE_ISL1218 },
+	{ "isl1219", TYPE_ISL1219 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, isl1208_id);
@@ -695,6 +811,7 @@ MODULE_DEVICE_TABLE(i2c, isl1208_id);
 static const struct of_device_id isl1208_of_match[] = {
 	{ .compatible = "isil,isl1208" },
 	{ .compatible = "isil,isl1218" },
+	{ .compatible = "isil,isl1219" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, isl1208_of_match);
-- 
2.18.0



Diehl Connectivity Solutions GmbH
Geschäftsführung: Horst Leonberger
Sitz der Gesellschaft: Nürnberg - Registergericht: Amtsgericht
Nürnberg: HRB 32315
___________________________________________________________________________________________________

Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen.
Informieren Sie uns bitte, wenn Sie diese E-Mail faelschlicherweise erhalten haben. Bitte loeschen Sie in diesem Fall die Nachricht.
Jede unerlaubte Form der Reproduktion, Bekanntgabe, Aenderung, Verteilung und/oder Publikation dieser E-Mail ist strengstens untersagt.
The contents of the above mentioned e-mail is not legally binding. This e-mail contains confidential and/or legally protected information. Please inform us if you have received this e-mail by
mistake and delete it in such a case. Each unauthorized reproduction, disclosure, alteration, distribution and/or publication of this e-mail is strictly prohibited. 
