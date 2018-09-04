Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD173C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EA72086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KisH3oLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69EA72086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbeIDUCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:02:03 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34728 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeIDUCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:02:02 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w84FaK9i073208;
        Tue, 4 Sep 2018 10:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536075380;
        bh=j0ONo9DvIRf/sEo+wG1pBzhiVJVcOAeoFuc4+agH1g8=;
        h=From:To:CC:Subject:Date;
        b=KisH3oLUBzUBcmAIfheOqKHVBv+XIKvhw1rBYz2Cj48pI7ir/Nkk6Nk6zoU2aY4qM
         nQP/3Ej9IAtTNjemK6V5PxYVSAq8DVENrVl7hAB+Ljt5sPVBAwhn5f1iv2ZUR4FjFL
         xrm844uqGR5dKti+dq0s4iwr/z6sYUoTaCfIaTPU=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w84FaKo5024537;
        Tue, 4 Sep 2018 10:36:20 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 4 Sep
 2018 10:36:19 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 4 Sep 2018 10:36:19 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w84FaJ87003070;
        Tue, 4 Sep 2018 10:36:19 -0500
Received: from localhost (uda0226330.dhcp.ti.com [172.22.184.106])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w84FaJx08265;
        Tue, 4 Sep 2018 10:36:19 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH v2 1/3] ASoC: tlv320aic31xx: Add overflow detection support
Date:   Tue, 4 Sep 2018 10:36:17 -0500
Message-ID: <20180904153619.2199-1-afd@ti.com>
X-Mailer: git-send-email 2.18.0
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

Changes from v1:
 - Change errors to warning for non-fatal events
 - Rebased on broonie/sound.git for-next

 sound/soc/codecs/tlv320aic31xx.c | 34 ++++++++++++++++++++++++++++++--
 sound/soc/codecs/tlv320aic31xx.h |  7 +++++++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index d8783af7d31c..6e8f79ec9629 100644
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
+		dev_warn(dev, "Left-channel DAC overflow has occurred\n");
+	if (value & AIC31XX_DAC_OF_RIGHT)
+		dev_warn(dev, "Right-channel DAC overflow has occurred\n");
+	if (value & AIC31XX_DAC_OF_SHIFTER)
+		dev_warn(dev, "DAC barrel shifter overflow has occurred\n");
+	if (value & AIC31XX_ADC_OF)
+		dev_warn(dev, "ADC overflow has occurred\n");
+	if (value & AIC31XX_ADC_OF_SHIFTER)
+		dev_warn(dev, "ADC barrel shifter overflow has occurred\n");
+	if (value & ~(AIC31XX_DAC_OF_LEFT |
+		      AIC31XX_DAC_OF_RIGHT |
+		      AIC31XX_DAC_OF_SHIFTER |
+		      AIC31XX_ADC_OF |
+		      AIC31XX_ADC_OF_SHIFTER))
+		dev_warn(dev, "Unknown overflow interrupt flags: 0x%08x\n", value);
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

