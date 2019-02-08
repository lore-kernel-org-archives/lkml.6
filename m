Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A02AC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB1121919
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfBHKu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:50:26 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:18126 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726081AbfBHKu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:50:26 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x18Akxqd001842;
        Fri, 8 Feb 2019 11:50:00 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qfv9jkbqf-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 08 Feb 2019 11:50:00 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 91DA342;
        Fri,  8 Feb 2019 10:49:59 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 68EF427B8;
        Fri,  8 Feb 2019 10:49:59 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 8 Feb 2019
 11:49:59 +0100
Received: from localhost (10.201.23.16) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 8 Feb 2019 11:49:58
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@st.com>
Subject: [PATCH 2/2] SoC: stm32: i2s: manage clock power
Date:   Fri, 8 Feb 2019 11:49:54 +0100
Message-ID: <1549622994-13810-3-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549622994-13810-1-git-send-email-olivier.moysan@st.com>
References: <1549622994-13810-1-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-08_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel clock management:
Enable/disable I2S kernel clock on audio stream startup/shutdown.

Peripheral clock management:
Manage I2S peripheral clock power through regmap services.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_i2s.c | 44 +++++++++++++++-----------------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index dbe23a709d24..a25919d32187 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -545,9 +545,16 @@ static int stm32_i2s_startup(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *cpu_dai)
 {
 	struct stm32_i2s_data *i2s = snd_soc_dai_get_drvdata(cpu_dai);
+	int ret;
 
 	i2s->substream = substream;
 
+	ret = clk_prepare_enable(i2s->i2sclk);
+	if (ret < 0) {
+		dev_err(cpu_dai->dev, "Failed to enable clock: %d\n", ret);
+		return ret;
+	}
+
 	spin_lock(&i2s->lock_fd);
 	i2s->refcount++;
 	spin_unlock(&i2s->lock_fd);
@@ -674,6 +681,8 @@ static void stm32_i2s_shutdown(struct snd_pcm_substream *substream,
 
 	regmap_update_bits(i2s->regmap, STM32_I2S_CGFR_REG,
 			   I2S_CGFR_MCKOE, (unsigned int)~I2S_CGFR_MCKOE);
+
+	clk_disable_unprepare(i2s->i2sclk);
 }
 
 static int stm32_i2s_dai_probe(struct snd_soc_dai *cpu_dai)
@@ -874,49 +883,26 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	i2s->regmap = devm_regmap_init_mmio(&pdev->dev, i2s->base,
-					    i2s->regmap_conf);
+	i2s->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "pclk",
+						i2s->base, i2s->regmap_conf);
 	if (IS_ERR(i2s->regmap)) {
 		dev_err(&pdev->dev, "regmap init failed\n");
 		return PTR_ERR(i2s->regmap);
 	}
 
-	ret = clk_prepare_enable(i2s->pclk);
-	if (ret) {
-		dev_err(&pdev->dev, "Enable pclk failed: %d\n", ret);
-		return ret;
-	}
-
-	ret = clk_prepare_enable(i2s->i2sclk);
-	if (ret) {
-		dev_err(&pdev->dev, "Enable i2sclk failed: %d\n", ret);
-		goto err_pclk_disable;
-	}
-
 	ret = devm_snd_soc_register_component(&pdev->dev, &stm32_i2s_component,
 					      i2s->dai_drv, 1);
 	if (ret)
-		goto err_clocks_disable;
+		return ret;
 
 	ret = devm_snd_dmaengine_pcm_register(&pdev->dev,
 					      &stm32_i2s_pcm_config, 0);
 	if (ret)
-		goto err_clocks_disable;
+		return ret;
 
 	/* Set SPI/I2S in i2s mode */
-	ret = regmap_update_bits(i2s->regmap, STM32_I2S_CGFR_REG,
-				 I2S_CGFR_I2SMOD, I2S_CGFR_I2SMOD);
-	if (ret)
-		goto err_clocks_disable;
-
-	return ret;
-
-err_clocks_disable:
-	clk_disable_unprepare(i2s->i2sclk);
-err_pclk_disable:
-	clk_disable_unprepare(i2s->pclk);
-
-	return ret;
+	return regmap_update_bits(i2s->regmap, STM32_I2S_CGFR_REG,
+				  I2S_CGFR_I2SMOD, I2S_CGFR_I2SMOD);
 }
 
 static int stm32_i2s_remove(struct platform_device *pdev)
-- 
2.7.4

