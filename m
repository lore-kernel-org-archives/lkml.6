Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719A5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8BA2192B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbnRDcCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390962AbeLUPVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:21:18 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40455 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730002AbeLUPVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:21:16 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18-v6so5060835lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 07:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qEcYU4dIdCj1tEvw3O0OUqERPL+d1F9Ff4CVGy8XRSI=;
        b=bbnRDcCj/uIkEBl9QZJ69SY22RPvzzn+IrDbWj+ln/31R8X5h1Bvh7r3QWpThpH3iV
         ZL1qFf7PWvzmZ5HPtZgdmBC1WN3M7bc0BC0SeHHvqrpM8xHcRexzd7K82SuSDq4ItFg6
         sA1MCPPpYDiw1y00ifuK/PQEe3UnTvL5yFqDL/EWHxQUGc16w84otdm8+BHDnWkblNlc
         mEbjbYk0fuLN5oIlEg41wsKxzyCMveMRSeCkyfIceJSk6IB4kzyx4TshCvvQeSAsTTY+
         RaQ3LMDgLp811mVdI/kSrWOwWmx3ioq/HTM8jsFr3brmIwhjihJJ1KNoYXn1a39vxjoQ
         7O8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qEcYU4dIdCj1tEvw3O0OUqERPL+d1F9Ff4CVGy8XRSI=;
        b=RTlVOgpP2NWAhVVS+b4fEbnYktp34Ueby6on8P0lqlv9FAxkmZh3GjKkfiv3DjoUQk
         gMeGgOnjYqDHbgcou6wHLB+koS9Ggv4nUfdZg8U23JRAtLBsvxuISHPBSOSwtQOhQMyY
         CiSAalp1wre5xSj8exIosI+QMcLaaIvest3P5v2ayhPWKgiikhpBJl9M7NBJw/PhwU1S
         uv1iBNF8EZjI6EBBZbHEp2x7VDsRAY0YdSmjTxR04Cmv/63p6kUm8N5/oOMc589q753u
         e88UjvqHvbPL2f/Y+F1JpnZ5nKN46KXTJ5kXzk+EMf2pGzc6saG08SUtdJxgcQFUekCQ
         Sg4w==
X-Gm-Message-State: AJcUukeZ3j2B+TD6BY0+u1Mh7BTqgt8ziqTwJW8ceGaPvUqzBd7jLu9r
        dPbn/W2srf33wWJWpkKA4QQ=
X-Google-Smtp-Source: ALg8bN7w7hW0VBgGhQC2cFPSqUzf9GIlxqRXQjASurv8lmd5PbdF0IDGUQnOlRmjccBCgEaCI0ryDQ==
X-Received: by 2002:a2e:6595:: with SMTP id e21-v6mr2068298ljf.123.1545405673924;
        Fri, 21 Dec 2018 07:21:13 -0800 (PST)
Received: from localhost.localdomain (c90-142-43-138.bredband.comhem.se. [90.142.43.138])
        by smtp.gmail.com with ESMTPSA id q30sm5005601lfi.94.2018.12.21.07.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 07:21:13 -0800 (PST)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v3 1/9] ASoC: sun4i-i2s: Adjust regmap settings
Date:   Fri, 21 Dec 2018 16:21:02 +0100
Message-Id: <20181221152110.17982-2-codekipper@gmail.com>
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

Bypass the regmap cache when flushing the i2s FIFOs and modify the tables
to reflect this.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index d5ec1a20499d..64d073cb2aee 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -548,9 +548,11 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
 {
 	/* Flush RX FIFO */
+	regcache_cache_bypass(i2s->regmap, true);
 	regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
 			   SUN4I_I2S_FIFO_CTRL_FLUSH_RX,
 			   SUN4I_I2S_FIFO_CTRL_FLUSH_RX);
+	regcache_cache_bypass(i2s->regmap, false);
 
 	/* Clear RX counter */
 	regmap_write(i2s->regmap, SUN4I_I2S_RX_CNT_REG, 0);
@@ -569,9 +571,11 @@ static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
 static void sun4i_i2s_start_playback(struct sun4i_i2s *i2s)
 {
 	/* Flush TX FIFO */
+	regcache_cache_bypass(i2s->regmap, true);
 	regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
 			   SUN4I_I2S_FIFO_CTRL_FLUSH_TX,
 			   SUN4I_I2S_FIFO_CTRL_FLUSH_TX);
+	regcache_cache_bypass(i2s->regmap, false);
 
 	/* Clear TX counter */
 	regmap_write(i2s->regmap, SUN4I_I2S_TX_CNT_REG, 0);
@@ -703,13 +707,7 @@ static const struct snd_soc_component_driver sun4i_i2s_component = {
 
 static bool sun4i_i2s_rd_reg(struct device *dev, unsigned int reg)
 {
-	switch (reg) {
-	case SUN4I_I2S_FIFO_TX_REG:
-		return false;
-
-	default:
-		return true;
-	}
+	return true;
 }
 
 static bool sun4i_i2s_wr_reg(struct device *dev, unsigned int reg)
@@ -728,6 +726,8 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case SUN4I_I2S_FIFO_RX_REG:
+	case SUN4I_I2S_FIFO_TX_REG:
+	case SUN4I_I2S_FIFO_STA_REG:
 	case SUN4I_I2S_INT_STA_REG:
 	case SUN4I_I2S_RX_CNT_REG:
 	case SUN4I_I2S_TX_CNT_REG:
@@ -738,23 +738,12 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-static bool sun8i_i2s_rd_reg(struct device *dev, unsigned int reg)
-{
-	switch (reg) {
-	case SUN8I_I2S_FIFO_TX_REG:
-		return false;
-
-	default:
-		return true;
-	}
-}
-
 static bool sun8i_i2s_volatile_reg(struct device *dev, unsigned int reg)
 {
 	if (reg == SUN8I_I2S_INT_STA_REG)
 		return true;
 	if (reg == SUN8I_I2S_FIFO_TX_REG)
-		return false;
+		return true;
 
 	return sun4i_i2s_volatile_reg(dev, reg);
 }
@@ -809,7 +798,7 @@ static const struct regmap_config sun8i_i2s_regmap_config = {
 	.reg_defaults	= sun8i_i2s_reg_defaults,
 	.num_reg_defaults	= ARRAY_SIZE(sun8i_i2s_reg_defaults),
 	.writeable_reg	= sun4i_i2s_wr_reg,
-	.readable_reg	= sun8i_i2s_rd_reg,
+	.readable_reg	= sun4i_i2s_rd_reg,
 	.volatile_reg	= sun8i_i2s_volatile_reg,
 };
 
-- 
2.20.1

