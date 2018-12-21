Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4F7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931AF21917
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3bQLKpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404272AbeLUPWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:22:42 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42342 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390972AbeLUPVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:21:24 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so5048468lja.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 07:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=acjXl/ZaoeTwfrYah/bbezD4My/k31GlnJiqaMNlHlk=;
        b=j3bQLKptvBG25yLOrZld8QsSMRYiG0HezMk6GEg6QuqD73AjutLPIIIFtF3iby341Q
         BIFVBSENNEgv58RfIOrlm3EBfJ5PuuBPWMleSeI+T0EBoBHnKlg+Tj6XH7W76rm6ZgML
         Tfs7ibGwRkiF1h07s1j9Q4lNErt87SNTQbuTl0na7CVVxGpIsd+cCImfREkjxS8xJsug
         7yXtBhw/FY0/7F1vl25b5MGE+MNLOR9rtNWFcv9qP2fqX+a6ZlxzFgeXx1P6bMlfaaFY
         Sz2pH2jxu9MWfdDjZ8fT9gtU7P6A9a7wRYlv0R2pt5xxcIYdmVnO0D2rdBsabptNGKh0
         M8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=acjXl/ZaoeTwfrYah/bbezD4My/k31GlnJiqaMNlHlk=;
        b=ipf0qKuMgBs7esD1fgxLApqk2Td8YjvTA1UvRN8pVZFhOLi53BTNEscnYhba9KFdL6
         jYYhPEzH8i7hfe/nlvrfV5qsSE1XInWSVgjwykHPlVeZ8Fp5QhZrjqIKijk7Dl8puxAh
         wyodEE2/6LB12dBVMOZsd4+2vGfAOexIXqCEd8/gsrQqelT3m/EHd9OKpg2pcdEckZR4
         iEQFFQDyKVm9gdGyQA+7w3W0G89TlCsxVg002ckgD0OK32qsiKCxKOnXxsUC5NgaMnaE
         zUfKRXbncNUKEwAzxC+mxRRrsj7FVEXiE+SeSYC5KxVOViKhzL0cJlGjLPILHQTM3dlo
         VYnA==
X-Gm-Message-State: AJcUuke2S8IMqtdh07mGGb8YEJm+A10KyfnkO7/fm2CXYkf/qm9X2WsB
        UOXjtAAKXaEvpD4XELNELMQ=
X-Google-Smtp-Source: ALg8bN5xk+PRAyX8yZO52dbiqAbR0E0+wcBxwo7o2+mSWowWEM08LJjg2K9tiZ0Xy5rLrOxgDnCfig==
X-Received: by 2002:a2e:9e16:: with SMTP id e22-v6mr1922750ljk.4.1545405681551;
        Fri, 21 Dec 2018 07:21:21 -0800 (PST)
Received: from localhost.localdomain (c90-142-43-138.bredband.comhem.se. [90.142.43.138])
        by smtp.gmail.com with ESMTPSA id q30sm5005601lfi.94.2018.12.21.07.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 07:21:20 -0800 (PST)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v3 7/9] ASoC: sun4i-i2s: Do not divide clocks when slave
Date:   Fri, 21 Dec 2018 16:21:08 +0100
Message-Id: <20181221152110.17982-8-codekipper@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181221152110.17982-1-codekipper@gmail.com>
References: <20181221152110.17982-1-codekipper@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

There is no need to set the clock and calculate the division of
the audio pll for the bclk and sync signals when they are not
required.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 144 +++++++++++++++++++-----------------
 1 file changed, 77 insertions(+), 67 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index e85789d84c0c..8cec2f42c94e 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -194,6 +194,8 @@ struct sun4i_i2s {
 	struct regmap_field	*field_rxchansel;
 
 	const struct sun4i_i2s_quirks	*variant;
+
+	bool bit_clk_master;
 };
 
 struct sun4i_i2s_clk_div {
@@ -298,82 +300,86 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 	int bclk_div, mclk_div;
 	int ret;
 
-	switch (rate) {
-	case 176400:
-	case 88200:
-	case 44100:
-	case 22050:
-	case 11025:
-		clk_rate = 22579200;
-		break;
+	if (i2s->bit_clk_master) {
+		switch (rate) {
+		case 176400:
+		case 88200:
+		case 44100:
+		case 22050:
+		case 11025:
+			clk_rate = 22579200;
+			break;
 
-	case 192000:
-	case 128000:
-	case 96000:
-	case 64000:
-	case 48000:
-	case 32000:
-	case 24000:
-	case 16000:
-	case 12000:
-	case 8000:
-		clk_rate = 24576000;
-		break;
+		case 192000:
+		case 128000:
+		case 96000:
+		case 64000:
+		case 48000:
+		case 32000:
+		case 24000:
+		case 16000:
+		case 12000:
+		case 8000:
+			clk_rate = 24576000;
+			break;
 
-	default:
-		dev_err(dai->dev, "Unsupported sample rate: %u\n", rate);
-		return -EINVAL;
-	}
+		default:
+			dev_err(dai->dev, "Unsupported sample rate: %u\n", rate);
+			return -EINVAL;
+		}
 
-	ret = clk_set_rate(i2s->mod_clk, clk_rate);
-	if (ret)
-		return ret;
+		ret = clk_set_rate(i2s->mod_clk, clk_rate);
+		if (ret) {
+			dev_err(dai->dev, "Unable to set clock\n");
+			return ret;
+		}
 
-	oversample_rate = i2s->mclk_freq / rate;
-	if (!sun4i_i2s_oversample_is_valid(oversample_rate)) {
-		dev_err(dai->dev, "Unsupported oversample rate: %d\n",
-			oversample_rate);
-		return -EINVAL;
-	}
+		oversample_rate = i2s->mclk_freq / rate;
+		if (!sun4i_i2s_oversample_is_valid(oversample_rate)) {
+			dev_err(dai->dev, "Unsupported oversample rate: %d\n",
+				oversample_rate);
+			return -EINVAL;
+		}
 
-	if (i2s->variant->has_fmt_set_lrck_period)
-		bclk_div = sun4i_i2s_get_bclk_div(i2s, clk_rate / rate,
-						  word_size,
-						  sun8i_i2s_clk_div,
-						  ARRAY_SIZE(sun8i_i2s_clk_div));
-	else
-		bclk_div = sun4i_i2s_get_bclk_div(i2s, oversample_rate,
-						  word_size,
-						  sun4i_i2s_bclk_div,
-						  ARRAY_SIZE(sun4i_i2s_bclk_div));
-	if (bclk_div < 0) {
-		dev_err(dai->dev, "Unsupported BCLK divider: %d\n",
-			bclk_div);
-		return -EINVAL;
-	}
+		if (i2s->variant->has_fmt_set_lrck_period)
+			bclk_div = sun4i_i2s_get_bclk_div(i2s, clk_rate / rate,
+							  word_size,
+							  sun8i_i2s_clk_div,
+							  ARRAY_SIZE(sun8i_i2s_clk_div));
+		else
+			bclk_div = sun4i_i2s_get_bclk_div(i2s, oversample_rate,
+							  word_size,
+							  sun4i_i2s_bclk_div,
+							  ARRAY_SIZE(sun4i_i2s_bclk_div));
+		if (bclk_div < 0) {
+			dev_err(dai->dev, "Unsupported BCLK divider: %d\n",
+				bclk_div);
+			return -EINVAL;
+		}
 
 
-	if (i2s->variant->has_fmt_set_lrck_period)
-		mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
-						  clk_rate, rate,
-						  sun8i_i2s_clk_div,
-						  ARRAY_SIZE(sun8i_i2s_clk_div));
-	else
-		mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
-						  clk_rate, rate,
-						  sun4i_i2s_mclk_div,
-						  ARRAY_SIZE(sun4i_i2s_mclk_div));
-	if (mclk_div < 0) {
-		dev_err(dai->dev, "Unsupported MCLK divider: %d\n",
-			mclk_div);
-		return -EINVAL;
-	}
+		if (i2s->variant->has_fmt_set_lrck_period)
+			mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
+							  clk_rate, rate,
+							  sun8i_i2s_clk_div,
+							  ARRAY_SIZE(sun8i_i2s_clk_div));
+		else
+			mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
+							  clk_rate, rate,
+							  sun4i_i2s_mclk_div,
+							  ARRAY_SIZE(sun4i_i2s_mclk_div));
+		if (mclk_div < 0) {
+			dev_err(dai->dev, "Unsupported MCLK divider: %d\n",
+				mclk_div);
+			return -EINVAL;
+		}
 
-	regmap_write(i2s->regmap, SUN4I_I2S_CLK_DIV_REG,
-		     SUN4I_I2S_CLK_DIV_BCLK(bclk_div) |
-		     SUN4I_I2S_CLK_DIV_MCLK(mclk_div));
+		regmap_write(i2s->regmap, SUN4I_I2S_CLK_DIV_REG,
+			     SUN4I_I2S_CLK_DIV_BCLK(bclk_div) |
+			     SUN4I_I2S_CLK_DIV_MCLK(mclk_div));
 
-	regmap_field_write(i2s->field_clkdiv_mclk_en, 1);
+		regmap_field_write(i2s->field_clkdiv_mclk_en, 1);
+	}
 
 	/* Set sync period */
 	if (i2s->variant->has_fmt_set_lrck_period)
@@ -574,10 +580,12 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		case SND_SOC_DAIFMT_CBS_CFS:
 			/* BCLK and LRCLK master */
 			val = SUN4I_I2S_CTRL_MODE_MASTER;
+			i2s->bit_clk_master = true;
 			break;
 		case SND_SOC_DAIFMT_CBM_CFM:
 			/* BCLK and LRCLK slave */
 			val = SUN4I_I2S_CTRL_MODE_SLAVE;
+			i2s->bit_clk_master = false;
 			break;
 		default:
 			dev_err(dai->dev, "Unsupported slave setting: %d\n",
@@ -598,10 +606,12 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 			/* BCLK and LRCLK master */
 			val = SUN8I_I2S_CTRL_BCLK_OUT |
 				SUN8I_I2S_CTRL_LRCK_OUT;
+			i2s->bit_clk_master = true;
 			break;
 		case SND_SOC_DAIFMT_CBM_CFM:
 			/* BCLK and LRCLK slave */
 			val = 0;
+			i2s->bit_clk_master = false;
 			break;
 		default:
 			dev_err(dai->dev, "Unsupported slave setting: %d\n",
-- 
2.20.1

