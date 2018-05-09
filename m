Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965532AbeEITeb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 15:34:31 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:33634 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965441AbeEITeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 15:34:03 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
To: a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH v3 3/4] rtc: ds1307: add offset sysfs for mt41txx chips.
Date: Wed,  9 May 2018 21:33:54 +0200
Message-Id: <20180509193355.49466-3-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509193355.49466-1-giulio.benetti@micronovasrl.com>
References: <20180509193355.49466-1-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

m41txx chips can hold a calibration value to get correct clock bias.
If positive offset is passed, it means adding 512 cycles(@32.768Hz)
every tick(1s).
If negative offset is passed, it means subtracting 256 cycles(@32.768Hz)
every tick(1s).

Add offset handling (ranging between (-31) and 31) via sysfs.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/rtc/rtc-ds1307.c | 70 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 0ab0c166da83..33895668b363 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -114,6 +114,16 @@ enum ds_type {
 #	define RX8025_BIT_VDET		0x40
 #	define RX8025_BIT_XST		0x20
 
+#define M41TXX_REG_CONTROL	0x07
+#	define M41TXX_BIT_OUT		0x80
+#	define M41TXX_BIT_FT		0x40
+#	define M41TXX_BIT_CALIB_SIGN	0x20
+#	define M41TXX_M_CALIBRATION	0x1f
+
+/* Min and max values supported with 'offset' interface by M41TXX */
+#define M41TXX_MIN_OFFSET	(-31)
+#define M41TXX_MAX_OFFSET	(31)
+
 struct ds1307 {
 	enum ds_type		type;
 	unsigned long		flags;
@@ -146,6 +156,9 @@ struct chip_desc {
 
 static int ds1307_get_time(struct device *dev, struct rtc_time *t);
 static int ds1307_set_time(struct device *dev, struct rtc_time *t);
+static int ds1337_read_alarm(struct device *dev, struct rtc_wkalrm *t);
+static int ds1337_set_alarm(struct device *dev, struct rtc_wkalrm *t);
+static int ds1307_alarm_irq_enable(struct device *dev, unsigned int enabled);
 static u8 do_trickle_setup_ds1339(struct ds1307 *, u32 ohms, bool diode);
 static irqreturn_t rx8130_irq(int irq, void *dev_id);
 static int rx8130_read_alarm(struct device *dev, struct rtc_wkalrm *t);
@@ -155,6 +168,8 @@ static irqreturn_t mcp794xx_irq(int irq, void *dev_id);
 static int mcp794xx_read_alarm(struct device *dev, struct rtc_wkalrm *t);
 static int mcp794xx_set_alarm(struct device *dev, struct rtc_wkalrm *t);
 static int mcp794xx_alarm_irq_enable(struct device *dev, unsigned int enabled);
+static int m41txx_rtc_read_offset(struct device *dev, long *offset);
+static int m41txx_rtc_set_offset(struct device *dev, long offset);
 
 static const struct rtc_class_ops rx8130_rtc_ops = {
 	.read_time      = ds1307_get_time,
@@ -172,6 +187,16 @@ static const struct rtc_class_ops mcp794xx_rtc_ops = {
 	.alarm_irq_enable = mcp794xx_alarm_irq_enable,
 };
 
+static const struct rtc_class_ops m41txx_rtc_ops = {
+	.read_time      = ds1307_get_time,
+	.set_time       = ds1307_set_time,
+	.read_alarm	= ds1337_read_alarm,
+	.set_alarm	= ds1337_set_alarm,
+	.alarm_irq_enable = ds1307_alarm_irq_enable,
+	.read_offset	= m41txx_rtc_read_offset,
+	.set_offset	= m41txx_rtc_set_offset,
+};
+
 static const struct chip_desc chips[last_ds_type] = {
 	[ds_1307] = {
 		.nvram_offset	= 8,
@@ -227,10 +252,17 @@ static const struct chip_desc chips[last_ds_type] = {
 		.irq_handler = rx8130_irq,
 		.rtc_ops = &rx8130_rtc_ops,
 	},
+	[m41t0] = {
+		.rtc_ops	= &m41txx_rtc_ops,
+	},
+	[m41t00] = {
+		.rtc_ops	= &m41txx_rtc_ops,
+	},
 	[m41t11] = {
 		/* this is battery backed SRAM */
 		.nvram_offset	= 8,
 		.nvram_size	= 56,
+		.rtc_ops	= &m41txx_rtc_ops,
 	},
 	[mcp794xx] = {
 		.alarm		= 1,
@@ -972,6 +1004,44 @@ static int mcp794xx_alarm_irq_enable(struct device *dev, unsigned int enabled)
 				  enabled ? MCP794XX_BIT_ALM0_EN : 0);
 }
 
+static int m41txx_rtc_read_offset(struct device *dev, long *offset)
+{
+	struct ds1307 *ds1307 = dev_get_drvdata(dev);
+	unsigned int ctrl_reg;
+	u8 val;
+
+	regmap_read(ds1307->regmap, M41TXX_REG_CONTROL, &ctrl_reg);
+
+	val = ctrl_reg & M41TXX_M_CALIBRATION;
+
+	/* check if positive */
+	if (ctrl_reg & M41TXX_BIT_CALIB_SIGN)
+		*offset = val;
+	else
+		*offset = -val;
+
+	return 0;
+}
+
+static int m41txx_rtc_set_offset(struct device *dev, long offset)
+{
+	struct ds1307 *ds1307 = dev_get_drvdata(dev);
+	unsigned int ctrl_reg;
+
+	if ((offset < M41TXX_MIN_OFFSET) || (offset > M41TXX_MAX_OFFSET))
+		return -ERANGE;
+
+	regmap_read(ds1307->regmap, M41TXX_REG_CONTROL, &ctrl_reg);
+
+	ctrl_reg &= ~M41TXX_M_CALIBRATION;
+	ctrl_reg |= abs(offset) & M41TXX_M_CALIBRATION;
+
+	if (offset >= 0)
+		ctrl_reg |= M41TXX_BIT_CALIB_SIGN;
+
+	return regmap_write(ds1307->regmap, M41TXX_REG_CONTROL,	ctrl_reg);
+}
+
 /*----------------------------------------------------------------------*/
 
 static int ds1307_nvram_read(void *priv, unsigned int offset, void *val,
-- 
2.17.0
