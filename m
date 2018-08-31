Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4E5C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF02420837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="op+A4Ir7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF02420837
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeHaWdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 18:33:23 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34262 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeHaWdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 18:33:22 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7VIOZoB074517;
        Fri, 31 Aug 2018 13:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535739875;
        bh=/28Vv/EtQpTCoHIV6JUnU0NXoWCMVSqO+u9eu/f7Q8o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=op+A4Ir7zndZcUljLYz37j9ZeEmzI/Gaeverh+r2pVWlD5mHJfgcoc/eQHzsgafAP
         46+EXnPfQ4BaRaG4xx0xC1PyRRVV+LWUeAx1DhwaLZhRpoQaP20V5aHac4oCa7givu
         hklFiWcFQWx1omyTGXVmm71ajNW2KiGWp1k4uqa0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VIOZqN025400;
        Fri, 31 Aug 2018 13:24:35 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 31
 Aug 2018 13:24:35 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 31 Aug 2018 13:24:35 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VIOZl4012992;
        Fri, 31 Aug 2018 13:24:35 -0500
Received: from localhost (uda0226330.dhcp.ti.com [172.22.167.21])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w7VIOYx07428;
        Fri, 31 Aug 2018 13:24:34 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 2/4] ASoC: tlv320aic31xx: Add overflow detection support
Date:   Fri, 31 Aug 2018 13:24:32 -0500
Message-ID: <20180831182434.14499-2-afd@ti.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831182434.14499-1-afd@ti.com>
References: <20180831182434.14499-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to short circuit detection, when the ADC/DAC is saturated and
overflows poor audio quality can result and should be reported to the
user. This device support Automatic Dynamic Range Compression (DRC)
to reduce this but it is not enabled currently in this driver.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 34 ++++++++++++++++++++++++++++++--
 sound/soc/codecs/tlv320aic31xx.h |  7 +++++++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index d8783af7d31c..c49f6796b086 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1356,7 +1356,7 @@ static irqreturn_t aic31xx_irq(int irq, void *data)
 	if (value)
 		handled = true;
 	else
-		goto exit;
+		goto read_overflow;
 
 	if (value & AIC31XX_HPLSCDETECT)
 		dev_err(dev, "Short circuit on Left output is detected\n");
@@ -1366,6 +1366,35 @@ static irqreturn_t aic31xx_irq(int irq, void *data)
 		      AIC31XX_HPRSCDETECT))
 		dev_err(dev, "Unknown DAC interrupt flags: 0x%08x\n", value);
 
+read_overflow:
+	ret = regmap_read(aic31xx->regmap, AIC31XX_OFFLAG, &value);
+	if (ret) {
+		dev_err(dev, "Failed to read overflow flag: %d\n", ret);
+		goto exit;
+	}
+
+	if (value)
+		handled = true;
+	else
+		goto exit;
+
+	if (value & AIC31XX_DAC_OF_LEFT)
+		dev_err(dev, "Left-channel DAC overflow has occurred\n");
+	if (value & AIC31XX_DAC_OF_RIGHT)
+		dev_err(dev, "Right-channel DAC overflow has occurred\n");
+	if (value & AIC31XX_DAC_OF_SHIFTER)
+		dev_err(dev, "DAC barrel shifter overflow has occurred\n");
+	if (value & AIC31XX_ADC_OF)
+		dev_err(dev, "ADC overflow has occurred\n");
+	if (value & AIC31XX_ADC_OF_SHIFTER)
+		dev_err(dev, "ADC barrel shifter overflow has occurred\n");
+	if (value & ~(AIC31XX_DAC_OF_LEFT |
+		      AIC31XX_DAC_OF_RIGHT |
+		      AIC31XX_DAC_OF_SHIFTER |
+		      AIC31XX_ADC_OF |
+		      AIC31XX_ADC_OF_SHIFTER))
+		dev_err(dev, "Unknown overflow interrupt flags: 0x%08x\n", value);
+
 exit:
 	if (handled)
 		return IRQ_HANDLED;
@@ -1447,7 +1476,8 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 				   AIC31XX_GPIO1_FUNC_SHIFT);
 
 		regmap_write(aic31xx->regmap, AIC31XX_INT1CTRL,
-			     AIC31XX_SC);
+			     AIC31XX_SC |
+			     AIC31XX_ENGINE);
 
 		ret = devm_request_threaded_irq(aic31xx->dev, aic31xx->irq,
 						NULL, aic31xx_irq,
diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index 52e171988906..2636f2c6bc79 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -173,6 +173,13 @@ struct aic31xx_pdata {
 #define AIC31XX_HPRDRVPWRSTATUS_MASK	BIT(1)
 #define AIC31XX_SPRDRVPWRSTATUS_MASK	BIT(0)
 
+/* AIC31XX_OFFLAG */
+#define AIC31XX_DAC_OF_LEFT		BIT(7)
+#define AIC31XX_DAC_OF_RIGHT		BIT(6)
+#define AIC31XX_DAC_OF_SHIFTER		BIT(5)
+#define AIC31XX_ADC_OF			BIT(3)
+#define AIC31XX_ADC_OF_SHIFTER		BIT(1)
+
 /* AIC31XX_INTRDACFLAG */
 #define AIC31XX_HPLSCDETECT		BIT(7)
 #define AIC31XX_HPRSCDETECT		BIT(6)
-- 
2.18.0

