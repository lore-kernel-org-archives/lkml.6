Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B8FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805C321479
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=birdec.tech header.i=@birdec.tech header.b="PR2hetz3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfBKGuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 01:50:17 -0500
Received: from host.euro-space.net ([87.117.239.2]:44480 "EHLO
        host.euro-space.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKGuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 01:50:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=birdec.tech
        ; s=default; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lwnW/JHlN5eYk3GJpeaYoOn1D1JAEwAc/l7KSKiAuCI=; b=PR2hetz3j1yMwOGdw16Zkxc2YL
        2TgeXmHFsdALp7oB8RsQWjuErIBEN/F3l2SeUcr+WWHSUvGfSgs85Ux8A1EJZ1llu+eSD9k8AZgjf
        73JYeZABmtPjaVCfPGAjPqx9NOwJtYs5pULtGxBWTavU6++hQFr6zIX4qMfCvMNr/DGZptzgpMv6z
        SSAN5xVT62lS5Z0UeoAvlcLHMK6VJm1durzidPY2LYNdSNXlAW/9STC8YwH96tOkV6Sg7J+6UKoyK
        ST+UP22yztkXFWghKJ8aFsOLJCRY5o6mMawrm0LLZa4bmITxxbMuOkEt/yVgBt8Ne9NgFQi7nKu7q
        7FG1ZcuA==;
Received: from x4d03a3f8.dyn.telefonica.de ([77.3.163.248]:51990 helo=gentoo0.localdomain)
        by host.euro-space.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <kmarinushkin@birdec.tech>)
        id 1gt4jR-0005JU-Mn; Mon, 11 Feb 2019 06:06:17 +0000
From:   Kirill Marinushkin <kmarinushkin@birdec.tech>
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Kirill Marinushkin <kmarinushkin@birdec.tech>
Subject: [PATCH 2/2] ASoC: pcm3060: Add clock select
Date:   Mon, 11 Feb 2019 07:08:39 +0100
Message-Id: <20190211060839.21417-2-kmarinushkin@birdec.tech>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190211060839.21417-1-kmarinushkin@birdec.tech>
References: <20190211060839.21417-1-kmarinushkin@birdec.tech>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.euro-space.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - birdec.tech
X-Get-Message-Sender-Via: host.euro-space.net: authenticated_id: kmarinushkin@birdec.tech
X-Authenticated-Sender: host.euro-space.net: kmarinushkin@birdec.tech
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADC and DAC can be clocked from separate or same sources CLK1 and CLK2.
By default, ADC is clocked from CLK1, and DAC - from CLK2.

This commits allows sound cards to selest a proper clock source during
`hw_params()` via `snd_soc_dai_set_sysclk()`. It makes possible to have a
single clock source for both ADC and DAC.

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
---
 sound/soc/codecs/pcm3060.c | 27 +++++++++++++++++++++++++++
 sound/soc/codecs/pcm3060.h |  5 +++++
 2 files changed, 32 insertions(+)

diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index 543cb86fd764..32b26f1c2282 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -18,12 +18,39 @@ static int pcm3060_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 {
 	struct snd_soc_component *comp = dai->component;
 	struct pcm3060_priv *priv = snd_soc_component_get_drvdata(comp);
+	unsigned int reg;
+	unsigned int val;
 
 	if (dir != SND_SOC_CLOCK_IN) {
 		dev_err(comp->dev, "unsupported sysclock dir: %d\n", dir);
 		return -EINVAL;
 	}
 
+	switch (clk_id) {
+	case PCM3060_CLK_DEF:
+		val = 0;
+		break;
+
+	case PCM3060_CLK1:
+		val = (dai->id == PCM3060_DAI_ID_DAC ? PCM3060_REG_CSEL : 0);
+		break;
+
+	case PCM3060_CLK2:
+		val = (dai->id == PCM3060_DAI_ID_DAC ? 0 : PCM3060_REG_CSEL);
+		break;
+
+	default:
+		dev_err(comp->dev, "unsupported sysclock id: %d\n", clk_id);
+		return -EINVAL;
+	}
+
+	if (dai->id == PCM3060_DAI_ID_DAC)
+		reg = PCM3060_REG67;
+	else
+		reg = PCM3060_REG72;
+
+	regmap_update_bits(priv->regmap, reg, PCM3060_REG_CSEL, val);
+
 	priv->dai[dai->id].sclk_freq = freq;
 
 	return 0;
diff --git a/sound/soc/codecs/pcm3060.h b/sound/soc/codecs/pcm3060.h
index 6a027b4a845d..75931c9a9d85 100644
--- a/sound/soc/codecs/pcm3060.h
+++ b/sound/soc/codecs/pcm3060.h
@@ -17,6 +17,11 @@ extern const struct regmap_config pcm3060_regmap;
 #define PCM3060_DAI_ID_ADC	1
 #define PCM3060_DAI_IDS_NUM	2
 
+/* ADC and DAC can be clocked from separate or same sources CLK1 and CLK2 */
+#define PCM3060_CLK_DEF	0 /* default: CLK1->ADC, CLK2->DAC */
+#define PCM3060_CLK1		1
+#define PCM3060_CLK2		2
+
 struct pcm3060_priv_dai {
 	bool is_master;
 	unsigned int sclk_freq;
-- 
2.13.6

