Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C0BECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481E220869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481E220869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeJTAE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:04:26 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:25694 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727641AbeJTAEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:04:25 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w9JFrj1b021709;
        Fri, 19 Oct 2018 17:56:40 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2n35u690wp-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 19 Oct 2018 17:56:40 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0D26F34;
        Fri, 19 Oct 2018 15:56:38 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B1F9651E7;
        Fri, 19 Oct 2018 15:56:38 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.44) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 19 Oct
 2018 17:56:38 +0200
Received: from localhost (10.201.23.16) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 19 Oct 2018 17:56:37
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@st.com>
Subject: [PATCH 1/1] ASoC: cs42l51: fix mclk support
Date:   Fri, 19 Oct 2018 17:56:35 +0200
Message-ID: <1539964595-23758-1-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-19_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 5e8d63a726f8 ("ASoC: cs42l51: add mclk support")

The MCLK clock is made optional for cs42l51 codec.
However, ASoC DAPM clock supply widget, expects the clock to be defined
unconditionally.
Register MCLK DAPM conditionally in codec driver,
depending on clock presence in DT.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/codecs/cs42l51.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index eb40bff54cec..fd2bd74024c1 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -21,6 +21,7 @@
  *  - master mode *NOT* supported
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <sound/core.h>
@@ -41,6 +42,7 @@ enum master_slave_mode {
 
 struct cs42l51_private {
 	unsigned int mclk;
+	struct clk *mclk_handle;
 	unsigned int audio_mode;	/* The mode (I2S or left-justified) */
 	enum master_slave_mode func;
 };
@@ -492,9 +494,13 @@ static int cs42l51_component_probe(struct snd_soc_component *component)
 {
 	int ret, reg;
 	struct snd_soc_dapm_context *dapm;
+	struct cs42l51_private *cs42l51;
 
+	cs42l51 = snd_soc_component_get_drvdata(component);
 	dapm = snd_soc_component_get_dapm(component);
-	snd_soc_dapm_new_controls(dapm, cs42l51_dapm_mclk_widgets, 1);
+
+	if (cs42l51->mclk_handle)
+		snd_soc_dapm_new_controls(dapm, cs42l51_dapm_mclk_widgets, 1);
 
 	/*
 	 * DAC configuration
@@ -548,6 +554,13 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 
 	dev_set_drvdata(dev, cs42l51);
 
+	cs42l51->mclk_handle = devm_clk_get(dev, "MCLK");
+	if (IS_ERR(cs42l51->mclk_handle)) {
+		if (PTR_ERR(cs42l51->mclk_handle) != -ENOENT)
+			return PTR_ERR(cs42l51->mclk_handle);
+		cs42l51->mclk_handle = NULL;
+	}
+
 	/* Verify that we have a CS42L51 */
 	ret = regmap_read(regmap, CS42L51_CHIP_REV_ID, &val);
 	if (ret < 0) {
-- 
2.7.4

