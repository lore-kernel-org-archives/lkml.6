Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C85FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D4D421917
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuWu1PCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390976AbeLUPVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:21:22 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37259 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730002AbeLUPVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:21:19 -0500
Received: by mail-lj1-f196.google.com with SMTP id t18-v6so5055409ljd.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 07:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k1qbR0f7/OKaG3uk0h/lc5XdCr3NJKWBkdbvBaKq80A=;
        b=EuWu1PClYpwp9gdZ17n750bQjIT94h6/zAyN33C9bfXmrfT+wvk5gOL7dNRZaGYwah
         8FxmTqFa1XS5Ejuh7K7UJaB1b5hqTw/rNIdf8/lhH06psbomy0Jr2DNpuvkZOIU8Dc55
         CijO19JmtXQyA1p34V+suC2X3IyiK1EVNwyNhMZbIs/cirB9qvHA3gxrXwZ/uN20ACWS
         UH/St2n/Go9gu93UXpwWsA4+5h3O+iHFwaR8YLij8x94BbPUqGrSGLES9DY22ULZjf+s
         MUDLHOhOpiwesuKj4LUPx6rFb7wjDlmvbD1ZgEXR0l7odLPfa7qzFaZq2jVpCzHApmrq
         /rHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k1qbR0f7/OKaG3uk0h/lc5XdCr3NJKWBkdbvBaKq80A=;
        b=AeNOMzMQDQN8RGBUSCbyVrfgt8oBTKPd091an/0oT/w7rd8IN5/LhFE9tAqxLqFRuw
         gkMbzBTUt3GZt4QR5vapOW6xffRb4yz+gHTPJGYsdLhJtg4LwEhIYntoExK06CSSRyxo
         rQtvsivyV+YBWjrzv2IrKr+TGadZ3AwE+2/G8cI7wBBPh+CzX4KYB7LENII3Tb9ckn1o
         EyBRzqEanI6XA8fgiJsIiMQAyuipCFHVbXnCm85wiE7r8cSLJfF/SoDutE+nu4RhIhoB
         6qmNx+ozdsiijNsUArF+yT/24luDG4owlUI/R+CrY6shKeGKA2+Q4Ah8bY50zv6PFkEs
         2nHg==
X-Gm-Message-State: AA+aEWZeHHVbyIinlEmyLWY+b2azKDFY8dcVcr4/uhslWiengI0+PdVY
        Inu6fqKNU5++XHU7I5F0sUA=
X-Google-Smtp-Source: ALg8bN7CioKpx+xsbgSjLD0bnfPUdQM43lHkATv4YHbnzslwvMy2Pgzi3IQPMeWIWPP96sf5VonMwA==
X-Received: by 2002:a2e:5356:: with SMTP id t22-v6mr1827643ljd.26.1545405677647;
        Fri, 21 Dec 2018 07:21:17 -0800 (PST)
Received: from localhost.localdomain (c90-142-43-138.bredband.comhem.se. [90.142.43.138])
        by smtp.gmail.com with ESMTPSA id q30sm5005601lfi.94.2018.12.21.07.21.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 07:21:16 -0800 (PST)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v3 4/9] ASoC: sun4i-i2s: Fix offset mask
Date:   Fri, 21 Dec 2018 16:21:05 +0100
Message-Id: <20181221152110.17982-5-codekipper@gmail.com>
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

Also add offset to RX channel select

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index adb988ae9ac5..93a484d7e228 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -110,7 +110,7 @@
 
 #define SUN8I_I2S_TX_CHAN_MAP_REG	0x44
 #define SUN8I_I2S_TX_CHAN_SEL_REG	0x34
-#define SUN8I_I2S_TX_CHAN_OFFSET_MASK		GENMASK(13, 11)
+#define SUN8I_I2S_TX_CHAN_OFFSET_MASK		GENMASK(13, 12)
 #define SUN8I_I2S_TX_CHAN_OFFSET(offset)	(offset << 12)
 #define SUN8I_I2S_TX_CHAN_EN_MASK		GENMASK(11, 4)
 #define SUN8I_I2S_TX_CHAN_EN(num_chan)		(((1 << num_chan) - 1) << 4)
@@ -482,6 +482,10 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
 				   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
 				   SUN8I_I2S_TX_CHAN_OFFSET(offset));
+
+		regmap_update_bits(i2s->regmap, SUN8I_I2S_RX_CHAN_SEL_REG,
+				   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
+				   SUN8I_I2S_TX_CHAN_OFFSET(offset));
 	}
 
 	regmap_field_write(i2s->field_fmt_mode, val);
-- 
2.20.1

