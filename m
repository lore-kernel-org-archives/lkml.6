Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEE3C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EABA22083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IuC2amla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABA22083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeHaWdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 18:33:23 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34260 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbeHaWdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 18:33:22 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7VIOahD074521;
        Fri, 31 Aug 2018 13:24:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535739876;
        bh=Z8ETgYXHINJnZUyH4H0xAD2sn6rY+LHuoFLPKI5+ghQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IuC2amla0frzGpgk0UZ30+gBgTFAaE4+BPS7rRXQJdRgA/LDqXMd8dUqSTUGDURZv
         IS8oWCLrTfY0WwlGRIVPPBbk8RgK3KdN3Hv+/30H3VnbG3/lfRtxrywnTr/BqQ0yt6
         6/JtSwtmFY9Xp/KnzCNtX4+ehtcUhDr32nmrVHxI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VIOakV004185;
        Fri, 31 Aug 2018 13:24:36 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 31
 Aug 2018 13:24:36 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 31 Aug 2018 13:24:36 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VIOaxV013004;
        Fri, 31 Aug 2018 13:24:36 -0500
Received: from localhost (uda0226330.dhcp.ti.com [172.22.167.21])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w7VIOZx07436;
        Fri, 31 Aug 2018 13:24:35 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 3/4] ASoC: tlv320aic31xx: Add headphone/headset detection
Date:   Fri, 31 Aug 2018 13:24:33 -0500
Message-ID: <20180831182434.14499-3-afd@ti.com>
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

This device can detect the insertion/removal of headphones and headsets.
Enable reporting this status by enabling this interrupt and forwarding
this to upper-layers if a jack has been defined.

This jack definition and the resulting operation from a jack detection
event must currently be defined by sound card platform code until CODEC
outputs to jack mappings can be defined generically.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 48 +++++++++++++++++++++++++++++++-
 sound/soc/codecs/tlv320aic31xx.h | 11 ++++++++
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index c49f6796b086..0e57c7bbbabb 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -25,6 +25,7 @@
 #include <linux/of_gpio.h>
 #include <linux/slab.h>
 #include <sound/core.h>
+#include <sound/jack.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -89,6 +90,7 @@ static bool aic31xx_volatile(struct device *dev, unsigned int reg)
 	case AIC31XX_INTRADCFLAG: /* Sticky interrupt flags */
 	case AIC31XX_INTRDACFLAG2:
 	case AIC31XX_INTRADCFLAG2:
+	case AIC31XX_HSDETECT:
 		return true;
 	}
 	return false;
@@ -157,6 +159,7 @@ struct aic31xx_priv {
 	int micbias_vg;
 	struct aic31xx_pdata pdata;
 	struct regulator_bulk_data supplies[AIC31XX_NUM_SUPPLIES];
+	struct snd_soc_jack *jack;
 	unsigned int sysclk;
 	u8 p_div;
 	int rate_div_line;
@@ -1233,6 +1236,20 @@ static int aic31xx_set_bias_level(struct snd_soc_component *component,
 	return 0;
 }
 
+int aic31xx_set_jack(struct snd_soc_component *component,
+		     struct snd_soc_jack *jack, void *data)
+{
+	struct aic31xx_priv *aic31xx = snd_soc_component_get_drvdata(component);
+
+	aic31xx->jack = jack;
+
+	/* Enable/Disable jack detection */
+	regmap_write(aic31xx->regmap, AIC31XX_HSDETECT,
+		     jack ? AIC31XX_HSD_ENABLE : 0);
+
+	return 0;
+}
+
 static int aic31xx_codec_probe(struct snd_soc_component *component)
 {
 	struct aic31xx_priv *aic31xx = snd_soc_component_get_drvdata(component);
@@ -1258,6 +1275,7 @@ static int aic31xx_codec_probe(struct snd_soc_component *component)
 
 static const struct snd_soc_component_driver soc_codec_driver_aic31xx = {
 	.probe			= aic31xx_codec_probe,
+	.set_jack		= aic31xx_set_jack,
 	.set_bias_level		= aic31xx_set_bias_level,
 	.controls		= common31xx_snd_controls,
 	.num_controls		= ARRAY_SIZE(common31xx_snd_controls),
@@ -1362,8 +1380,35 @@ static irqreturn_t aic31xx_irq(int irq, void *data)
 		dev_err(dev, "Short circuit on Left output is detected\n");
 	if (value & AIC31XX_HPRSCDETECT)
 		dev_err(dev, "Short circuit on Right output is detected\n");
+	if (value & AIC31XX_HSPLUG) {
+		unsigned int val;
+		int status = 0;
+
+		ret = regmap_read(aic31xx->regmap, AIC31XX_HSDETECT, &val);
+		if (ret) {
+			dev_err(dev, "Failed to read headset type: %d\n", ret);
+			goto exit;
+		}
+
+		switch ((val & AIC31XX_HSD_TYPE_MASK) >>
+			AIC31XX_HSD_TYPE_SHIFT) {
+		case AIC31XX_HSD_HP:
+			status |= SND_JACK_HEADPHONE;
+			break;
+		case AIC31XX_HSD_HS:
+			status |= SND_JACK_HEADSET;
+			break;
+		default:
+			break;
+		}
+
+		if (aic31xx->jack)
+			snd_soc_jack_report(aic31xx->jack, status,
+					    AIC31XX_JACK_MASK);
+	}
 	if (value & ~(AIC31XX_HPLSCDETECT |
-		      AIC31XX_HPRSCDETECT))
+		      AIC31XX_HPRSCDETECT |
+		      AIC31XX_HSPLUG))
 		dev_err(dev, "Unknown DAC interrupt flags: 0x%08x\n", value);
 
 read_overflow:
@@ -1476,6 +1521,7 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 				   AIC31XX_GPIO1_FUNC_SHIFT);
 
 		regmap_write(aic31xx->regmap, AIC31XX_INT1CTRL,
+			     AIC31XX_HSPLUGDET |
 			     AIC31XX_SC |
 			     AIC31XX_ENGINE);
 
diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index 2636f2c6bc79..9985ceed97ae 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -20,6 +20,9 @@
 #define AIC31XX_MINIDSP_BIT		BIT(2)
 #define DAC31XX_BIT			BIT(3)
 
+#define AIC31XX_JACK_MASK (SND_JACK_HEADPHONE | \
+			   SND_JACK_HEADSET)
+
 enum aic31xx_type {
 	AIC3100	= 0,
 	AIC3110 = AIC31XX_STEREO_CLASS_D_BIT,
@@ -220,6 +223,14 @@ struct aic31xx_pdata {
 /* AIC31XX_DACMUTE */
 #define AIC31XX_DACMUTE_MASK		GENMASK(3, 2)
 
+/* AIC31XX_HSDETECT */
+#define AIC31XX_HSD_ENABLE		BIT(7)
+#define AIC31XX_HSD_TYPE_MASK		GENMASK(6, 5)
+#define AIC31XX_HSD_TYPE_SHIFT		5
+#define AIC31XX_HSD_NONE		0x00
+#define AIC31XX_HSD_HP			0x01
+#define AIC31XX_HSD_HS			0x03
+
 /* AIC31XX_MICBIAS */
 #define AIC31XX_MICBIAS_MASK		GENMASK(1, 0)
 #define AIC31XX_MICBIAS_SHIFT		0
-- 
2.18.0

