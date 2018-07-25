Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828F0C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329C42088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="PkoHf9UD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329C42088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbeGYSi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 14:38:58 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:37958 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbeGYSi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 14:38:57 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id ADF03B0096C
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:26:18 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:to:from:from; s=dkim; t=1532539578; x=1533403579; bh=9t
        KtD20rKZKjRTisFuPebs2UZaqqkD1i1pvZ/82XCyU=; b=PkoHf9UD75r+ePJ+h0
        7uq5xSQDW7womt5pLzSB39qHeVDZpufR4xEsKGQUiiOE3nnlL/CHLhYGplVrtud0
        5CLTx1TZHvFA5xMfTv/FO/NiRVlIAtI/0wFcSrw72YLTZ1le5E2r0HzCV6P+s3/s
        ZxZqAGGgDdhXiDGVNfgVgGW9Y=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TUJ9w6QKi3My for <linux-kernel@vger.kernel.org>;
        Wed, 25 Jul 2018 19:26:18 +0200 (CEST)
Received: from ubuntu.localdomain (62-11-51-166.dialup.tiscali.it [62.11.51.166])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id 81DA6B0098C;
        Wed, 25 Jul 2018 19:26:16 +0200 (CEST)
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
To:     alexandre.belloni@bootlin.com
Cc:     a.zummo@towertech.it, andy.shevchenko@gmail.com, robh@kernel.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH v11 3/4] rtc: ds1307: add offset sysfs for mt41txx chips.
Date:   Wed, 25 Jul 2018 19:26:04 +0200
Message-Id: <20180725172605.108040-3-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180725172605.108040-1-giulio.benetti@micronovasrl.com>
References: <20180725172605.108040-1-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

m41txx chips can hold a calibration value to get correct clock bias.

Add offset handling (ranging between -63ppm and 126ppm) via sysfs.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/rtc/rtc-ds1307.c | 77 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 0162a600ff1b..c6d871456f25 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -114,6 +114,20 @@ enum ds_type {
 #	define RX8025_BIT_VDET		0x40
 #	define RX8025_BIT_XST		0x20
 
+#define M41TXX_REG_CONTROL	0x07
+#	define M41TXX_BIT_OUT		BIT(7)
+#	define M41TXX_BIT_FT		BIT(6)
+#	define M41TXX_BIT_CALIB_SIGN	BIT(5)
+#	define M41TXX_M_CALIBRATION	GENMASK(4, 0)
+
+/* negative offset step is -2.034ppm */
+#define M41TXX_NEG_OFFSET_STEP_PPB	2034
+/* positive offset step is +4.068ppm */
+#define M41TXX_POS_OFFSET_STEP_PPB	4068
+/* Min and max values supported with 'offset' interface by M41TXX */
+#define M41TXX_MIN_OFFSET	((-31) * M41TXX_NEG_OFFSET_STEP_PPB)
+#define M41TXX_MAX_OFFSET	((31) * M41TXX_POS_OFFSET_STEP_PPB)
+
 struct ds1307 {
 	enum ds_type		type;
 	unsigned long		flags;
@@ -146,6 +160,9 @@ struct chip_desc {
 
 static int ds1307_get_time(struct device *dev, struct rtc_time *t);
 static int ds1307_set_time(struct device *dev, struct rtc_time *t);
+static int ds1337_read_alarm(struct device *dev, struct rtc_wkalrm *t);
+static int ds1337_set_alarm(struct device *dev, struct rtc_wkalrm *t);
+static int ds1307_alarm_irq_enable(struct device *dev, unsigned int enabled);
 static u8 do_trickle_setup_ds1339(struct ds1307 *, u32 ohms, bool diode);
 static irqreturn_t rx8130_irq(int irq, void *dev_id);
 static int rx8130_read_alarm(struct device *dev, struct rtc_wkalrm *t);
@@ -155,6 +172,8 @@ static irqreturn_t mcp794xx_irq(int irq, void *dev_id);
 static int mcp794xx_read_alarm(struct device *dev, struct rtc_wkalrm *t);
 static int mcp794xx_set_alarm(struct device *dev, struct rtc_wkalrm *t);
 static int mcp794xx_alarm_irq_enable(struct device *dev, unsigned int enabled);
+static int m41txx_rtc_read_offset(struct device *dev, long *offset);
+static int m41txx_rtc_set_offset(struct device *dev, long offset);
 
 static const struct rtc_class_ops rx8130_rtc_ops = {
 	.read_time      = ds1307_get_time,
@@ -172,6 +191,16 @@ static const struct rtc_class_ops mcp794xx_rtc_ops = {
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
@@ -228,10 +257,17 @@ static const struct chip_desc chips[last_ds_type] = {
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
@@ -973,6 +1009,47 @@ static int mcp794xx_alarm_irq_enable(struct device *dev, unsigned int enabled)
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
+		*offset = (val * M41TXX_POS_OFFSET_STEP_PPB);
+	else
+		*offset = -(val * M41TXX_NEG_OFFSET_STEP_PPB);
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
+	if (offset >= 0) {
+		ctrl_reg = DIV_ROUND_CLOSEST(offset,
+					     M41TXX_POS_OFFSET_STEP_PPB);
+		ctrl_reg |= M41TXX_BIT_CALIB_SIGN;
+	} else {
+		ctrl_reg = DIV_ROUND_CLOSEST(abs(offset),
+					     M41TXX_NEG_OFFSET_STEP_PPB);
+	}
+
+	return regmap_update_bits(ds1307->regmap, M41TXX_REG_CONTROL,
+				  M41TXX_M_CALIBRATION | M41TXX_BIT_CALIB_SIGN,
+				  ctrl_reg);
+}
+
 /*----------------------------------------------------------------------*/
 
 static int ds1307_nvram_read(void *priv, unsigned int offset, void *val,
-- 
2.17.1

