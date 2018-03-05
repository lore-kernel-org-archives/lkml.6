Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934479AbeCEKoE convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 05:44:04 -0500
Received: from enterprise03.smtp.diehl.com ([193.201.238.214]:12876 "EHLO
        enterprise03.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933054AbeCEKn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 05:43:56 -0500
X-$ESA-Groupmapping: true
X-IronPort-AV: E=Sophos;i="5.47,426,1515452400";
   d="scan'";a="8949807"
From: Denis OSTERLAND <denis.osterland@diehl.com>
To: "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@free-electrons.com"
        <alexandre.belloni@free-electrons.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mgr@pengutronix.de" <mgr@pengutronix.de>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Denis OSTERLAND <denis.osterland@diehl.com>
Subject: [PATCH v3 3/4] rtc: isl1208: add support for isl1219 with tamper
 detection
Thread-Topic: [PATCH v3 3/4] rtc: isl1208: add support for isl1219 with tamper
 detection
Thread-Index: AQHTtG7aretG2oRbs0uZL0jAjmeJ1A==
Date: Mon, 5 Mar 2018 10:43:52 +0000
Message-ID: <1520246373-19023-4-git-send-email-Denis.Osterland@diehl.com>
References: <1520246373-19023-1-git-send-email-Denis.Osterland@diehl.com>
In-Reply-To: <1520246373-19023-1-git-send-email-Denis.Osterland@diehl.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.153.3.249]
MIME-Version: 1.0
X-GBS-PROC: 415AWy8o668fDtCxszluzxYsKPdhedG+cGvwI0vQIBj7B8TyUA3iD1KhHPfJADb3
X-MIMETrack: Itemize by SMTP Server on DIGNS29/SRV/DIEHL-HUB(Release 9.0.1FP10 HF66|February
 09, 2018) at 05.03.2018 11:43:53,
        Serialize by ntm_grab.EXE on DIGNS29/SRV/DIEHL-HUB(Release 9.0.1FP10 HF66|February
 09, 2018) at 05.03.2018 11:43:53,
        Serialize complete at 05.03.2018 11:43:53,
        Itemize by ntm_grab.EXE on DIGNS29/SRV/DIEHL-HUB(Release 9.0.1FP10 HF66|February
 09, 2018) at 05.03.2018 11:43:53,
        Serialize by Router on DIGNS29/SRV/DIEHL-HUB(Release 9.0.1FP10 HF66|February
 09, 2018) at 05.03.2018 11:43:53
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Grzeschik <m.grzeschik@pengutronix.de>

We add support for the ISL1219 chip that got an integrated tamper
detection function. This patch implements the feature by adding
an additional timestamp0 file to sysfs device path.
This file contains seconds since epoch, if an event occurred,
or is empty, if none occurred.

The devicetree documentation for the ISL1219 device tree
binding is added with an short example. It is not a trivial
device, because it supports two interrupt souces.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
---
 .../devicetree/bindings/rtc/isil,isl1219.txt       |  28 ++++
 drivers/rtc/rtc-isl1208.c                          | 160 ++++++++++++++++++---
 2 files changed, 171 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl1219.txt

diff --git a/Documentation/devicetree/bindings/rtc/isil,isl1219.txt b/Documentation/devicetree/bindings/rtc/isil,isl1219.txt
new file mode 100644
index 0000000..7937c13
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/isil,isl1219.txt
@@ -0,0 +1,28 @@
+Intersil ISL1219 I2C RTC/Alarm chip with event in
+
+ISL1219 has additional pins EVIN and #EVDET for tamper detection.
+
+Required properties supported by the device:
+
+ - "compatible": must be "isil,isl1219"
+ - "reg": I2C bus address of the device
+
+Optional properties:
+
+ - "interrupt-names": list which may contains "irq" and "evdet"
+ - "interrupt-parent", "interrupts", "interrupts-extended":
+   for passing the interrupt line of the SoC connected to #IRQ pin
+   and #EVDET pin of the RTC chip.
+
+
+Example isl1219 node with #IRQ pin connected to SoC gpio1 pin12
+ and #EVDET pin connected to SoC gpio2 pin 24:
+
+	isl1219: rtc@68 {
+		compatible = "isil,isl1219";
+		reg = <0x68>;
+		interrupt-names = "irq", "evdet";
+		interrupts-extended = <&gpio1 12 IRQ_TYPE_EDGE_FALLING>,
+			<&gpio2 24 IRQ_TYPE_EDGE_FALLING>;
+	};
+
diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index 1a2c38c..164371b 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -33,6 +33,7 @@
 #define ISL1208_REG_SR_ARST    (1<<7)	/* auto reset */
 #define ISL1208_REG_SR_XTOSCB  (1<<6)	/* crystal oscillator */
 #define ISL1208_REG_SR_WRTC    (1<<4)	/* write rtc */
+#define ISL1208_REG_SR_EVT     (1<<3)	/* event */
 #define ISL1208_REG_SR_ALM     (1<<2)	/* alarm */
 #define ISL1208_REG_SR_BAT     (1<<1)	/* battery */
 #define ISL1208_REG_SR_RTCF    (1<<0)	/* rtc fail */
@@ -57,8 +58,29 @@
 #define ISL1208_REG_USR2 0x13
 #define ISL1208_USR_SECTION_LEN 2
 
+/* event section */
+#define ISL1208_REG_SCT 0x14
+#define ISL1208_REG_MNT 0x15
+#define ISL1208_REG_HRT 0x16
+#define ISL1208_REG_DTT 0x17
+#define ISL1208_REG_MOT 0x18
+#define ISL1208_REG_YRT 0x19
+#define ISL1208_EVT_SECTION_LEN 6
+
 static struct i2c_driver isl1208_driver;
 
+/* ISL1208 various variants */
+enum {
+	TYPE_ISL1208 = 0,
+	TYPE_ISL1218,
+	TYPE_ISL1219,
+};
+
+struct isl1208 {
+	struct rtc_device *rtc;
+	const struct attribute_group *sysfs_files;
+};
+
 /* block read */
 static int
 isl1208_i2c_read_regs(struct i2c_client *client, u8 reg, u8 buf[],
@@ -80,8 +102,8 @@ isl1208_i2c_read_regs(struct i2c_client *client, u8 reg, u8 buf[],
 	};
 	int ret;
 
-	BUG_ON(reg > ISL1208_REG_USR2);
-	BUG_ON(reg + len > ISL1208_REG_USR2 + 1);
+	WARN_ON(reg > ISL1208_REG_YRT);
+	WARN_ON(reg + len > ISL1208_REG_YRT + 1);
 
 	ret = i2c_transfer(client->adapter, msgs, 2);
 	if (ret > 0)
@@ -104,8 +126,8 @@ isl1208_i2c_set_regs(struct i2c_client *client, u8 reg, u8 const buf[],
 	};
 	int ret;
 
-	BUG_ON(reg > ISL1208_REG_USR2);
-	BUG_ON(reg + len > ISL1208_REG_USR2 + 1);
+	WARN_ON(reg > ISL1208_REG_YRT);
+	WARN_ON(reg + len > ISL1208_REG_YRT + 1);
 
 	i2c_buf[0] = reg;
 	memcpy(&i2c_buf[1], &buf[0], len);
@@ -493,12 +515,78 @@ isl1208_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	return isl1208_i2c_set_alarm(to_i2c_client(dev), alarm);
 }
 
+static ssize_t isl1208_rtc_event_clear(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
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
+static ssize_t isl1208_rtc_event_show_timestamp(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	u8 regs[ISL1208_EVT_SECTION_LEN] = { 0, };
+	struct timespec64 tv64;
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
+		return sprintf(buf, "\n");
+
+	sr = isl1208_i2c_read_regs(client, ISL1208_REG_SCT, regs,
+				   ISL1208_EVT_SECTION_LEN);
+	if (sr < 0) {
+		dev_err(dev, "%s: reading event section failed\n",
+			__func__);
+		return 0;
+	}
+
+	/* MSB of each alarm register is an enable bit */
+	tm.tm_sec = bcd2bin(regs[ISL1208_REG_SCT - ISL1208_REG_SCT] & 0x7f);
+	tm.tm_min = bcd2bin(regs[ISL1208_REG_MNT - ISL1208_REG_SCT] & 0x7f);
+	tm.tm_hour = bcd2bin(regs[ISL1208_REG_HRT - ISL1208_REG_SCT] & 0x3f);
+	tm.tm_mday = bcd2bin(regs[ISL1208_REG_DTT - ISL1208_REG_SCT] & 0x3f);
+	tm.tm_mon =
+		bcd2bin(regs[ISL1208_REG_MOT - ISL1208_REG_SCT] & 0x1f) - 1;
+	tm.tm_year = bcd2bin(regs[ISL1208_REG_YRT - ISL1208_REG_SCT]) + 100;
+
+	tv64.tv_sec = rtc_tm_to_time64(&tm);
+
+	return sprintf(buf, "%lld\n", (long long) tv64.tv_sec);
+};
+
+static DEVICE_ATTR(timestamp0, 0640,
+		isl1208_rtc_event_show_timestamp, isl1208_rtc_event_clear);
+
 static irqreturn_t
 isl1208_rtc_interrupt(int irq, void *data)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
 	struct i2c_client *client = data;
-	struct rtc_device *rtc = i2c_get_clientdata(client);
+	struct isl1208 *isl1208 = i2c_get_clientdata(client);
 	int handled = 0, sr, err;
 
 	/*
@@ -521,7 +609,7 @@ isl1208_rtc_interrupt(int irq, void *data)
 	if (sr & ISL1208_REG_SR_ALM) {
 		dev_dbg(&client->dev, "alarm!\n");
 
-		rtc_update_irq(rtc, 1, RTC_IRQF | RTC_AF);
+		rtc_update_irq(isl1208->rtc, 1, RTC_IRQF | RTC_AF);
 
 		/* Clear the alarm */
 		sr &= ~ISL1208_REG_SR_ALM;
@@ -538,6 +626,13 @@ isl1208_rtc_interrupt(int irq, void *data)
 			return err;
 	}
 
+	if (sr & ISL1208_REG_SR_EVT) {
+		sysfs_notify(&client->dev.kobj, NULL,
+			dev_attr_timestamp0.attr.name);
+		dev_warn(&client->dev, "event detected");
+		handled = 1;
+	}
+
 	return handled ? IRQ_HANDLED : IRQ_NONE;
 }
 
@@ -623,11 +718,23 @@ static const struct attribute_group isl1208_rtc_sysfs_files = {
 	.attrs	= isl1208_rtc_attrs,
 };
 
+static struct attribute *isl1219_rtc_attrs[] = {
+	&dev_attr_atrim.attr,
+	&dev_attr_dtrim.attr,
+	&dev_attr_usr.attr,
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
 	int rc = 0;
-	struct rtc_device *rtc;
+	struct isl1208 *isl1208;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
@@ -635,13 +742,18 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (isl1208_i2c_validate_client(client) < 0)
 		return -ENODEV;
 
-	rtc = devm_rtc_allocate_device(&client->dev);
-	if (IS_ERR(rtc))
-		return PTR_ERR(rtc);
+	isl1208 = devm_kzalloc(&client->dev, sizeof(struct isl1208),
+				GFP_KERNEL);
+	if (!isl1208)
+		return -ENOMEM;
 
-	rtc->ops = &isl1208_rtc_ops;
+	isl1208->rtc = devm_rtc_allocate_device(&client->dev);
+	if (IS_ERR(isl1208->rtc))
+		return PTR_ERR(isl1208->rtc);
 
-	i2c_set_clientdata(client, rtc);
+	isl1208->rtc->ops = &isl1208_rtc_ops;
+
+	i2c_set_clientdata(client, isl1208);
 
 	rc = isl1208_i2c_get_sr(client);
 	if (rc < 0) {
@@ -653,7 +765,18 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		dev_warn(&client->dev, "rtc power failure detected, "
 			 "please set clock.\n");
 
-	rc = sysfs_create_group(&client->dev.kobj, &isl1208_rtc_sysfs_files);
+	if (id->driver_data == TYPE_ISL1219) {
+		rc = i2c_smbus_write_byte_data(client, ISL1208_REG_09, 0x10);
+		if (rc < 0) {
+			dev_err(&client->dev, "could not enable tamper detection\n");
+			return rc;
+		}
+		isl1208->sysfs_files = &isl1219_rtc_sysfs_files;
+	} else {
+		isl1208->sysfs_files = &isl1208_rtc_sysfs_files;
+	}
+
+	rc = sysfs_create_group(&client->dev.kobj, isl1208->sysfs_files);
 	if (rc)
 		return rc;
 
@@ -674,20 +797,23 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		}
 	}
 
-	return rtc_register_device(rtc);
+	return rtc_register_device(isl1208->rtc);
 }
 
 static int
 isl1208_remove(struct i2c_client *client)
 {
-	sysfs_remove_group(&client->dev.kobj, &isl1208_rtc_sysfs_files);
+	struct isl1208 *isl1208 = i2c_get_clientdata(client);
+
+	sysfs_remove_group(&client->dev.kobj, isl1208->sysfs_files);
 
 	return 0;
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
-- 
2.7.4


Diehl AKO Stiftung & Co. KG, Pfannerstraße 75-83, 88239 Wangen im Allgäu
Bereichsvorstand: Dr.-Ing. Michael Siedentop (Sprecher), Josef Fellner (Mitglied)
Sitz der Gesellschaft: Wangen i.A. – Registergericht: Amtsgericht Ulm HRA 620609 – Persönlich haftende Gesellschafterin: Diehl Verwaltungs-Stiftung – Sitz: Nürnberg – Registergericht: Amtsgericht Nürnberg HRA 11756 –
Vorstand: Dr.-Ing. E.h. Thomas Diehl (†) (Vorsitzender), Herr Dipl.-Wirtsch.-Ing. Wolfgang Weggen (stellvertretender Vorsitzender), Dipl.-Kfm. Claus Günther, Dipl.-Kfm. Frank Gutzeit, Dr.-Ing. Heinrich Schunk, Dr.-Ing. Michael Siedentop , Dipl.-Kfm. Dr.-Ing. Martin Sommer, Dipl.-Ing. (FH) Rainer von Borstel, Vorsitzender des Aufsichtsrates: Dr. Klaus Maier
___________________________________________________________________________________________________
Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen.
Informieren Sie uns bitte, wenn Sie diese E-Mail faelschlicherweise erhalten haben. Bitte loeschen Sie in diesem Fall die Nachricht. Jede unerlaubte Form der Reproduktion, Bekanntgabe, Aenderung, Verteilung und/oder Publikation dieser E-Mail ist strengstens untersagt.
The contents of the above mentioned e-mail is not legally binding. This e-mail contains confidential and/or legally protected information. Please inform us if you have received this e-mail by mistake and delete it in such a case. Each unauthorized reproduction, disclosure, alteration, distribution and/or publication of this e-mail is strictly prohibited.
