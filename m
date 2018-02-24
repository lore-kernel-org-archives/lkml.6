Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbeBXAJA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 19:09:00 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:41704 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752294AbeBXAI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 19:08:57 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 2/3] rtc: pcf85363: add alarm support
Date: Sat, 24 Feb 2018 01:08:52 +0100
Message-Id: <20180224000853.29365-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180224000853.29365-1-alexandre.belloni@bootlin.com>
References: <20180224000853.29365-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Handle alarms, currently only on INTA

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-pcf85363.c | 159 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index 3c5e5e1a5ead..3fa5bda59987 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -73,6 +73,39 @@
 #define CTRL_RESETS	0x2f
 #define CTRL_RAM	0x40
 
+#define ALRM_SEC_A1E	BIT(0)
+#define ALRM_MIN_A1E	BIT(1)
+#define ALRM_HR_A1E	BIT(2)
+#define ALRM_DAY_A1E	BIT(3)
+#define ALRM_MON_A1E	BIT(4)
+#define ALRM_MIN_A2E	BIT(5)
+#define ALRM_HR_A2E	BIT(6)
+#define ALRM_DAY_A2E	BIT(7)
+
+#define INT_WDIE	BIT(0)
+#define INT_BSIE	BIT(1)
+#define INT_TSRIE	BIT(2)
+#define INT_A2IE	BIT(3)
+#define INT_A1IE	BIT(4)
+#define INT_OIE		BIT(5)
+#define INT_PIE		BIT(6)
+#define INT_ILP		BIT(7)
+
+#define FLAGS_TSR1F	BIT(0)
+#define FLAGS_TSR2F	BIT(1)
+#define FLAGS_TSR3F	BIT(2)
+#define FLAGS_BSF	BIT(3)
+#define FLAGS_WDF	BIT(4)
+#define FLAGS_A1F	BIT(5)
+#define FLAGS_A2F	BIT(6)
+#define FLAGS_PIF	BIT(7)
+
+#define PIN_IO_INTAPM	GENMASK(1, 0)
+#define PIN_IO_INTA_CLK	0
+#define PIN_IO_INTA_BAT	1
+#define PIN_IO_INTA_OUT	2
+#define PIN_IO_INTA_HIZ	3
+
 #define NVRAM_SIZE	0x40
 
 static struct i2c_driver pcf85363_driver;
@@ -131,11 +164,123 @@ static int pcf85363_rtc_set_time(struct device *dev, struct rtc_time *tm)
 				 buf, len);
 }
 
+static int pcf85363_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct pcf85363 *pcf85363 = dev_get_drvdata(dev);
+	unsigned char buf[DT_MONTH_ALM1 - DT_SECOND_ALM1 + 1];
+	unsigned int val;
+	int ret;
+
+	ret = regmap_bulk_read(pcf85363->regmap, DT_SECOND_ALM1, buf,
+			       sizeof(buf));
+	if (ret)
+		return ret;
+
+	alrm->time.tm_sec = bcd2bin(buf[0]);
+	alrm->time.tm_min = bcd2bin(buf[1]);
+	alrm->time.tm_hour = bcd2bin(buf[2]);
+	alrm->time.tm_mday = bcd2bin(buf[3]);
+	alrm->time.tm_mon = bcd2bin(buf[4]) - 1;
+
+	ret = regmap_read(pcf85363->regmap, CTRL_INTA_EN, &val);
+	if (ret)
+		return ret;
+
+	alrm->enabled =  !!(val & INT_A1IE);
+
+	return 0;
+}
+
+static int _pcf85363_rtc_alarm_irq_enable(struct pcf85363 *pcf85363, unsigned
+					  int enabled)
+{
+	unsigned int alarm_flags = ALRM_SEC_A1E | ALRM_MIN_A1E | ALRM_HR_A1E |
+				   ALRM_DAY_A1E | ALRM_MON_A1E;
+	int ret;
+
+	ret = regmap_update_bits(pcf85363->regmap, DT_ALARM_EN, alarm_flags,
+				 enabled ? alarm_flags : 0);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(pcf85363->regmap, CTRL_INTA_EN,
+				 INT_A1IE, enabled ? INT_A1IE : 0);
+
+	if (ret || enabled)
+		return ret;
+
+	/* clear current flags */
+	return regmap_update_bits(pcf85363->regmap, CTRL_FLAGS, FLAGS_A1F, 0);
+}
+
+static int pcf85363_rtc_alarm_irq_enable(struct device *dev,
+					 unsigned int enabled)
+{
+	struct pcf85363 *pcf85363 = dev_get_drvdata(dev);
+
+	return _pcf85363_rtc_alarm_irq_enable(pcf85363, enabled);
+}
+
+static int pcf85363_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct pcf85363 *pcf85363 = dev_get_drvdata(dev);
+	unsigned char buf[DT_MONTH_ALM1 - DT_SECOND_ALM1 + 1];
+	int ret;
+
+	buf[0] = bin2bcd(alrm->time.tm_sec);
+	buf[1] = bin2bcd(alrm->time.tm_min);
+	buf[2] = bin2bcd(alrm->time.tm_hour);
+	buf[3] = bin2bcd(alrm->time.tm_mday);
+	buf[4] = bin2bcd(alrm->time.tm_mon + 1);
+
+	/*
+	 * Disable the alarm interrupt before changing the value to avoid
+	 * spurious interrupts
+	 */
+	ret = _pcf85363_rtc_alarm_irq_enable(pcf85363, 0);
+	if (ret)
+		return ret;
+
+	ret = regmap_bulk_write(pcf85363->regmap, DT_SECOND_ALM1, buf,
+				sizeof(buf));
+	if (ret)
+		return ret;
+
+	return _pcf85363_rtc_alarm_irq_enable(pcf85363, alrm->enabled);
+}
+
+static irqreturn_t pcf85363_rtc_handle_irq(int irq, void *dev_id)
+{
+	struct pcf85363 *pcf85363 = i2c_get_clientdata(dev_id);
+	unsigned int flags;
+	int err;
+
+	err = regmap_read(pcf85363->regmap, CTRL_FLAGS, &flags);
+	if (err)
+		return IRQ_NONE;
+
+	if (flags & FLAGS_A1F) {
+		rtc_update_irq(pcf85363->rtc, 1, RTC_IRQF | RTC_AF);
+		regmap_update_bits(pcf85363->regmap, CTRL_FLAGS, FLAGS_A1F, 0);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
 static const struct rtc_class_ops rtc_ops = {
 	.read_time	= pcf85363_rtc_read_time,
 	.set_time	= pcf85363_rtc_set_time,
 };
 
+static const struct rtc_class_ops rtc_ops_alarm = {
+	.read_time	= pcf85363_rtc_read_time,
+	.set_time	= pcf85363_rtc_set_time,
+	.read_alarm	= pcf85363_rtc_read_alarm,
+	.set_alarm	= pcf85363_rtc_set_alarm,
+	.alarm_irq_enable = pcf85363_rtc_alarm_irq_enable,
+};
+
 static int pcf85363_nvram_read(void *priv, unsigned int offset, void *val,
 			       size_t bytes)
 {
@@ -197,6 +342,20 @@ static int pcf85363_probe(struct i2c_client *client,
 
 	pcf85363->rtc->ops = &rtc_ops;
 
+	if (client->irq > 0) {
+		regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
+		regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
+				   PIN_IO_INTA_OUT, PIN_IO_INTAPM);
+		ret = devm_request_threaded_irq(pcf85363->dev, client->irq,
+						NULL, pcf85363_rtc_handle_irq,
+						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+						"pcf85363", client);
+		if (ret)
+			dev_warn(&client->dev, "unable to request IRQ, alarms disabled\n");
+		else
+			pcf85363->rtc->ops = &rtc_ops_alarm;
+	}
+
 	ret = rtc_register_device(pcf85363->rtc);
 
 	nvmem_cfg.priv = pcf85363;
-- 
2.16.1
