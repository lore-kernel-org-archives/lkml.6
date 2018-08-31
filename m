Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5E1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DBC20841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eY7/0drS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06DBC20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeHaWdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 18:33:21 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60382 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbeHaWdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 18:33:21 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7VIOZFL099344;
        Fri, 31 Aug 2018 13:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535739875;
        bh=e3Dfb/bTMGwHcTWfOfY8QNKd/K228rU48HDMsa5yMFk=;
        h=From:To:CC:Subject:Date;
        b=eY7/0drSqpymtjZ2HX1WsGzAS8BQrZ64k2/SOMLGulGXJO0Lt92lNOrxjOaaRf61V
         a9bHprsuqt62EoCXVC2kLb3SFHz88OSD7Q5/Vj4ASfe+56mqO+sPygDyn6/kO/85Eq
         pImZzg0Gl7Y3XYRAraOeZm6ReKaZG8ZYzJbEviXQ=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VIOZv0025394;
        Fri, 31 Aug 2018 13:24:35 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 31
 Aug 2018 13:24:34 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 31 Aug 2018 13:24:34 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VIOYQT021834;
        Fri, 31 Aug 2018 13:24:34 -0500
Received: from localhost (uda0226330.dhcp.ti.com [172.22.167.21])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w7VIOYx07420;
        Fri, 31 Aug 2018 13:24:34 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 1/4] ASoC: tlv320aic31xx: Add short circuit detection support
Date:   Fri, 31 Aug 2018 13:24:31 -0500
Message-ID: <20180831182434.14499-1-afd@ti.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These devices support detecting and reporting short circuits across
the output stages. Add support for reporting these issue. Do this
by registering an interrupt if available and enabling this error
to trigger that interrupt in the device.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 55 ++++++++++++++++++++++++++++++++
 sound/soc/codecs/tlv320aic31xx.h | 16 ++++++++++
 2 files changed, 71 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index f8d0f3ebed9c..d8783af7d31c 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -161,6 +161,7 @@ struct aic31xx_priv {
 	u8 p_div;
 	int rate_div_line;
 	bool master_dapm_route_applied;
+	int irq;
 };
 
 struct aic31xx_rate_divs {
@@ -1338,6 +1339,40 @@ static const struct acpi_device_id aic31xx_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, aic31xx_acpi_match);
 #endif
 
+static irqreturn_t aic31xx_irq(int irq, void *data)
+{
+	struct aic31xx_priv *aic31xx = data;
+	struct device *dev = aic31xx->dev;
+	unsigned int value;
+	bool handled = false;
+	int ret;
+
+	ret = regmap_read(aic31xx->regmap, AIC31XX_INTRDACFLAG, &value);
+	if (ret) {
+		dev_err(dev, "Failed to read interrupt mask: %d\n", ret);
+		goto exit;
+	}
+
+	if (value)
+		handled = true;
+	else
+		goto exit;
+
+	if (value & AIC31XX_HPLSCDETECT)
+		dev_err(dev, "Short circuit on Left output is detected\n");
+	if (value & AIC31XX_HPRSCDETECT)
+		dev_err(dev, "Short circuit on Right output is detected\n");
+	if (value & ~(AIC31XX_HPLSCDETECT |
+		      AIC31XX_HPRSCDETECT))
+		dev_err(dev, "Unknown DAC interrupt flags: 0x%08x\n", value);
+
+exit:
+	if (handled)
+		return IRQ_HANDLED;
+	else
+		return IRQ_NONE;
+}
+
 static int aic31xx_i2c_probe(struct i2c_client *i2c,
 			     const struct i2c_device_id *id)
 {
@@ -1360,6 +1395,7 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 	aic31xx->dev = &i2c->dev;
+	aic31xx->irq = i2c->irq;
 
 	aic31xx->codec_type = id->driver_data;
 
@@ -1404,6 +1440,25 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	if (aic31xx->irq > 0) {
+		regmap_update_bits(aic31xx->regmap, AIC31XX_GPIO1,
+				   AIC31XX_GPIO1_FUNC_MASK,
+				   AIC31XX_GPIO1_INT1 <<
+				   AIC31XX_GPIO1_FUNC_SHIFT);
+
+		regmap_write(aic31xx->regmap, AIC31XX_INT1CTRL,
+			     AIC31XX_SC);
+
+		ret = devm_request_threaded_irq(aic31xx->dev, aic31xx->irq,
+						NULL, aic31xx_irq,
+						IRQF_ONESHOT, "aic31xx-irq",
+						aic31xx);
+		if (ret) {
+			dev_err(aic31xx->dev, "Unable to request IRQ\n");
+			return ret;
+		}
+	}
+
 	if (aic31xx->codec_type & DAC31XX_BIT)
 		return devm_snd_soc_register_component(&i2c->dev,
 				&soc_codec_driver_aic31xx,
diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index 0b587585b38b..52e171988906 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -191,6 +191,22 @@ struct aic31xx_pdata {
 #define AIC31XX_SC			BIT(3)
 #define AIC31XX_ENGINE			BIT(2)
 
+/* AIC31XX_GPIO1 */
+#define AIC31XX_GPIO1_FUNC_MASK		GENMASK(5, 2)
+#define AIC31XX_GPIO1_FUNC_SHIFT	2
+#define AIC31XX_GPIO1_DISABLED		0x00
+#define AIC31XX_GPIO1_INPUT		0x01
+#define AIC31XX_GPIO1_GPI		0x02
+#define AIC31XX_GPIO1_GPO		0x03
+#define AIC31XX_GPIO1_CLKOUT		0x04
+#define AIC31XX_GPIO1_INT1		0x05
+#define AIC31XX_GPIO1_INT2		0x06
+#define AIC31XX_GPIO1_ADC_WCLK		0x07
+#define AIC31XX_GPIO1_SBCLK		0x08
+#define AIC31XX_GPIO1_SWCLK		0x09
+#define AIC31XX_GPIO1_ADC_MOD_CLK	0x10
+#define AIC31XX_GPIO1_SDOUT		0x11
+
 /* AIC31XX_DACSETUP */
 #define AIC31XX_SOFTSTEP_MASK		GENMASK(1, 0)
 
-- 
2.18.0

