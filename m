Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AA7C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC01021841
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfBZNvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:51:55 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:39438 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727051AbfBZNvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 08:51:40 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1QDlDsF028519;
        Tue, 26 Feb 2019 14:51:17 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qtvh3g8pc-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 26 Feb 2019 14:51:17 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4D85A31;
        Tue, 26 Feb 2019 13:51:17 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 310055476;
        Tue, 26 Feb 2019 13:51:17 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 26 Feb
 2019 14:51:17 +0100
Received: from localhost (10.201.23.16) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 26 Feb 2019 14:51:16
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@st.com>
Subject: [PATCH 3/7] ASoC: stm32: i2s: fix stream count management
Date:   Tue, 26 Feb 2019 14:51:06 +0100
Message-ID: <1551189070-15469-4-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551189070-15469-1-git-send-email-olivier.moysan@st.com>
References: <1551189070-15469-1-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move counter handling to trigger start section
to manage multiple start/stop events.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_i2s.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 7d4c67433916..7f56d7b51ba3 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -554,10 +554,6 @@ static int stm32_i2s_startup(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	spin_lock(&i2s->lock_fd);
-	i2s->refcount++;
-	spin_unlock(&i2s->lock_fd);
-
 	return regmap_write_bits(i2s->regmap, STM32_I2S_IFCR_REG,
 				 I2S_IFCR_MASK, I2S_IFCR_MASK);
 }
@@ -613,18 +609,19 @@ static int stm32_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 		regmap_write_bits(i2s->regmap, STM32_I2S_IFCR_REG,
 				  I2S_IFCR_MASK, I2S_IFCR_MASK);
 
+		spin_lock(&i2s->lock_fd);
+		i2s->refcount++;
 		if (playback_flg) {
 			ier = I2S_IER_UDRIE;
 		} else {
 			ier = I2S_IER_OVRIE;
 
-			spin_lock(&i2s->lock_fd);
 			if (i2s->refcount == 1)
 				/* dummy write to trigger capture */
 				regmap_write(i2s->regmap,
 					     STM32_I2S_TXDR_REG, 0);
-			spin_unlock(&i2s->lock_fd);
 		}
+		spin_unlock(&i2s->lock_fd);
 
 		if (STM32_I2S_IS_SLAVE(i2s))
 			ier |= I2S_IER_TIFREIE;
@@ -649,7 +646,6 @@ static int stm32_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 			spin_unlock(&i2s->lock_fd);
 			break;
 		}
-		spin_unlock(&i2s->lock_fd);
 
 		dev_dbg(cpu_dai->dev, "stop I2S\n");
 
@@ -657,8 +653,10 @@ static int stm32_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 					 I2S_CR1_SPE, 0);
 		if (ret < 0) {
 			dev_err(cpu_dai->dev, "Error %d disabling I2S\n", ret);
+			spin_unlock(&i2s->lock_fd);
 			return ret;
 		}
+		spin_unlock(&i2s->lock_fd);
 
 		cfg1_mask = I2S_CFG1_RXDMAEN | I2S_CFG1_TXDMAEN;
 		regmap_update_bits(i2s->regmap, STM32_I2S_CFG1_REG,
-- 
2.7.4

