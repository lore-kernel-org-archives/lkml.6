Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18ACC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646EF222D8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UilMyFYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405797AbfBMSnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:43:06 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:52026 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405772AbfBMSnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:43:03 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190213184300epoutp047429f37fa5d56e01de6e70bba4bfd503~DAJ8wgH3u0657306573epoutp04C;
        Wed, 13 Feb 2019 18:43:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190213184300epoutp047429f37fa5d56e01de6e70bba4bfd503~DAJ8wgH3u0657306573epoutp04C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550083380;
        bh=g26M3vvo7rFQlqLQajT+REpGD/4KuQLx8Lv9IuQdqVM=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=UilMyFYCX5ktdhBDiPn4qPLdwQP9IG2bosvDBiw2GNcPwgPkKVcMupGMLJZuk6H4P
         q2cn/2vh/CcG68CyufI+lPF/dRSBFbaPbP72C1C8ygs9cFIGgzgKuRm5/GPx02L9qf
         ZKaE2YKG+RkS4fcK+cDduMJ3DcV6rNryr6CNiHnw=
Received: from epsmges1p2.samsung.com (unknown [182.195.42.54]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190213184300epcas1p42d88a0cd562d972e3af724164743f1c0~DAJ8iEccA0825008250epcas1p4R;
        Wed, 13 Feb 2019 18:43:00 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        93.B1.04173.435646C5; Thu, 14 Feb 2019 03:43:00 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190213184259epcas1p16fa2f1a7f049d88ad627c823a117fc36~DAJ8HGkMi0131701317epcas1p1j;
        Wed, 13 Feb 2019 18:42:59 +0000 (GMT)
X-AuditID: b6c32a36-5c1ff7000000104d-0c-5c646534132f
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id F4.CE.04015.335646C5; Thu, 14 Feb
        2019 03:42:59 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMV00HOONZ3WX60@mmp2.samsung.com>; Thu, 14 Feb 2019
        03:42:59 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 02/13] ASoC: samsung: i2s: Drop spinlock pointer from
 i2s_dai data structure
Date:   Wed, 13 Feb 2019 19:42:01 +0100
Message-id: <20190213184212.5473-3-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190213184212.5473-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCmvq5JakqMwacj7BZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6MlV/OMBZst6po/7eOpYFxvkEXIyeH
        hICJRHfvI+YuRi4OIYEdjBJ7l29lgnC+M0psbzrI2MXIAVbVO1MTIr6BUWLf6xY2COcXo8SD
        +a9YQEaxCRhK9B7tYwSxRQTEJG7P6QQbyyzQwiQxZ+5SZpCEsECixKmuHlYQm0VAVeL84j9g
        DbwCVhJ3VhxmhbhJXmL1hgNg9ZwC1hL/1j5nh4gvYZO40h8IcZGLxKJZ4RCmtMSlo7YQFdUS
        u7Z3g62VEOhglGi5sJ0ZImEtcfj4RbDxzAJ8Eu++gpwA0ssr0dEmBFHiIbHw2092iL/6GCU2
        r7rIOoFRYgEjwypGsdSC4tz01GLDAiO94sTc4tK8dL3k/NxNjOAI1DLbwbjonM8hRgEORiUe
        3gqhlBgh1sSy4srcQ4wSHMxKIrx6UUAh3pTEyqrUovz4otKc1OJDjNIcLErivOsdnGOEBNIT
        S1KzU1MLUotgskwcnFINjCF3b6S85zYp8TW0TLz2LreuNfJluf2r9XyijstYzryRnnlNZpdB
        5Z8V61XXzbTRMLnK7Rd3qWXr1/+JJT7zz8Y913m/ya/ihf7/yNvsN516OF/NNedP6vQ0976x
        WTjhb4oow/HnB2Y/VYsv+jZxrl2p3gre6zy7zAQXzyv5uypzrYGQYb6piBJLcUaioRZzUXEi
        AAdFqD68AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsVy+t9jQV3j1JQYg1uXNC2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZK7+cYSzYblXR/m8dSwPjfIMuRg4O
        CQETid6Zml2MXBxCAusYJb7uOMgI4fxilJhy+w5bFyMnB5uAoUTv0T5GEFtEQEzi9pxOZpAi
        ZoEmJoldty+ygySEBRIlTnX1sILYLAKqEucX/wFr4BWwkriz4jBYXEJAXmL1hgPMIDangLXE
        v7XPwXqFgGomfrjEPIGRZwEjwypGydSC4tz03GKjAsO81HK94sTc4tK8dL3k/NxNjMAg23ZY
        q28H4/0l8YcYBTgYlXh4FQRSYoRYE8uKK3MPMUpwMCuJ8OpFAYV4UxIrq1KL8uOLSnNSiw8x
        SnOwKInz3s47FikkkJ5YkpqdmlqQWgSTZeLglGpgXNu1yPzDUgell24zZwoJv6urLpeNWGVz
        tu7D+uc/zTu14oMeci0ztEoWqXpU8pXd3THounE1//t18/bc4fjxfNaD0wsK5jl/tGWwjS2I
        Yl302LDiOL/U+8cXond9LJR90lMkKxHZ4J+/2bDozKYbZ5nEArfZbOrvttlyOWDadrOJ5g/e
        x3NvV2Ipzkg01GIuKk4EAAHirqUuAgAA
X-CMS-MailID: 20190213184259epcas1p16fa2f1a7f049d88ad627c823a117fc36
CMS-TYPE: 101P
X-CMS-RootMailID: 20190213184259epcas1p16fa2f1a7f049d88ad627c823a117fc36
References: <20190213184212.5473-1-s.nawrocki@samsung.com>
        <CGME20190213184259epcas1p16fa2f1a7f049d88ad627c823a117fc36@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we now have the 'priv' pointer in most of the places we can use
priv->lock directly, dropping extra indirection in the SFR region
spinlock access.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/i2s.c | 51 +++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 3f8955608a94..cf8615e23879 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -87,8 +87,6 @@ struct i2s_dai {
 	u32	quirks;
 	const struct samsung_i2s_variant_regs *variant_regs;
 
-	spinlock_t *lock;
-
 	struct samsung_i2s_priv *priv;
 };
 
@@ -103,7 +101,7 @@ struct samsung_i2s_priv {
 	void __iomem *addr;
 
 	/* Spinlock protecting access to the device's registers */
-	spinlock_t spinlock;
+	spinlock_t lock;
 
 	/* CPU DAIs and their corresponding drivers */
 	struct i2s_dai *dai;
@@ -527,9 +525,9 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id, unsigned int rfs,
 
 	pm_runtime_get_sync(dai->dev);
 
-	spin_lock_irqsave(i2s->lock, flags);
+	spin_lock_irqsave(&priv->lock, flags);
 	mod = readl(priv->addr + I2SMOD);
-	spin_unlock_irqrestore(i2s->lock, flags);
+	spin_unlock_irqrestore(&priv->lock, flags);
 
 	switch (clk_id) {
 	case SAMSUNG_I2S_OPCLK:
@@ -624,11 +622,11 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id, unsigned int rfs,
 		goto err;
 	}
 
-	spin_lock_irqsave(i2s->lock, flags);
+	spin_lock_irqsave(&priv->lock, flags);
 	mod = readl(priv->addr + I2SMOD);
 	mod = (mod & ~mask) | val;
 	writel(mod, priv->addr + I2SMOD);
-	spin_unlock_irqrestore(i2s->lock, flags);
+	spin_unlock_irqrestore(&priv->lock, flags);
 done:
 	pm_runtime_put(dai->dev);
 
@@ -709,7 +707,7 @@ static int i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	}
 
 	pm_runtime_get_sync(dai->dev);
-	spin_lock_irqsave(i2s->lock, flags);
+	spin_lock_irqsave(&priv->lock, flags);
 	mod = readl(priv->addr + I2SMOD);
 	/*
 	 * Don't change the I2S mode if any controller is active on this
@@ -717,7 +715,7 @@ static int i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	 */
 	if (any_active(i2s) &&
 		((mod & (sdf_mask | lrp_rlow | mod_slave)) != tmp)) {
-		spin_unlock_irqrestore(i2s->lock, flags);
+		spin_unlock_irqrestore(&priv->lock, flags);
 		pm_runtime_put(dai->dev);
 		dev_err(&i2s->pdev->dev,
 				"%s:%d Other DAI busy\n", __func__, __LINE__);
@@ -727,7 +725,7 @@ static int i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	mod &= ~(sdf_mask | lrp_rlow | mod_slave);
 	mod |= tmp;
 	writel(mod, priv->addr + I2SMOD);
-	spin_unlock_irqrestore(i2s->lock, flags);
+	spin_unlock_irqrestore(&priv->lock, flags);
 	pm_runtime_put(dai->dev);
 
 	return 0;
@@ -812,11 +810,11 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	spin_lock_irqsave(i2s->lock, flags);
+	spin_lock_irqsave(&priv->lock, flags);
 	mod = readl(priv->addr + I2SMOD);
 	mod = (mod & ~mask) | val;
 	writel(mod, priv->addr + I2SMOD);
-	spin_unlock_irqrestore(i2s->lock, flags);
+	spin_unlock_irqrestore(&priv->lock, flags);
 
 	snd_soc_dai_init_dma_data(dai, &i2s->dma_playback, &i2s->dma_capture);
 
@@ -944,6 +942,7 @@ static int config_setup(struct i2s_dai *i2s)
 static int i2s_trigger(struct snd_pcm_substream *substream,
 	int cmd, struct snd_soc_dai *dai)
 {
+	struct samsung_i2s_priv *priv = snd_soc_dai_get_drvdata(dai);
 	int capture = (substream->stream == SNDRV_PCM_STREAM_CAPTURE);
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct i2s_dai *i2s = to_info(rtd->cpu_dai);
@@ -954,10 +953,10 @@ static int i2s_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		pm_runtime_get_sync(dai->dev);
-		spin_lock_irqsave(i2s->lock, flags);
+		spin_lock_irqsave(&priv->lock, flags);
 
 		if (config_setup(i2s)) {
-			spin_unlock_irqrestore(i2s->lock, flags);
+			spin_unlock_irqrestore(&priv->lock, flags);
 			return -EINVAL;
 		}
 
@@ -966,12 +965,12 @@ static int i2s_trigger(struct snd_pcm_substream *substream,
 		else
 			i2s_txctrl(i2s, 1);
 
-		spin_unlock_irqrestore(i2s->lock, flags);
+		spin_unlock_irqrestore(&priv->lock, flags);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		spin_lock_irqsave(i2s->lock, flags);
+		spin_lock_irqsave(&priv->lock, flags);
 
 		if (capture) {
 			i2s_rxctrl(i2s, 0);
@@ -981,7 +980,7 @@ static int i2s_trigger(struct snd_pcm_substream *substream,
 			i2s_fifo(i2s, FIC_TXFLUSH);
 		}
 
-		spin_unlock_irqrestore(i2s->lock, flags);
+		spin_unlock_irqrestore(&priv->lock, flags);
 		pm_runtime_put(dai->dev);
 		break;
 	}
@@ -1081,13 +1080,13 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 	i2s->rfs = 0;
 	i2s->bfs = 0;
 
-	spin_lock_irqsave(i2s->lock, flags);
+	spin_lock_irqsave(&priv->lock, flags);
 	i2s_txctrl(i2s, 0);
 	i2s_rxctrl(i2s, 0);
 	i2s_fifo(i2s, FIC_TXFLUSH);
 	i2s_fifo(other, FIC_TXFLUSH);
 	i2s_fifo(i2s, FIC_RXFLUSH);
-	spin_unlock_irqrestore(i2s->lock, flags);
+	spin_unlock_irqrestore(&priv->lock, flags);
 
 	/* Gate CDCLK by default */
 	if (!is_opened(other))
@@ -1108,9 +1107,9 @@ static int samsung_i2s_dai_remove(struct snd_soc_dai *dai)
 
 	if (!is_secondary(i2s)) {
 		if (i2s->quirks & QUIRK_NEED_RSTCLR) {
-			spin_lock_irqsave(i2s->lock, flags);
+			spin_lock_irqsave(&priv->lock, flags);
 			writel(0, priv->addr + I2SCON);
-			spin_unlock_irqrestore(i2s->lock, flags);
+			spin_unlock_irqrestore(&priv->lock, flags);
 		}
 	}
 
@@ -1317,13 +1316,13 @@ static int i2s_register_clock_provider(struct samsung_i2s_priv *priv)
 				ARRAY_SIZE(p_names),
 				CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
 				priv->addr + I2SMOD, reg_info->rclksrc_off,
-				1, 0, i2s->lock);
+				1, 0, &priv->lock);
 
 		priv->clk_table[CLK_I2S_RCLK_PSR] = clk_register_divider(dev,
 				i2s_clk_name[CLK_I2S_RCLK_PSR],
 				i2s_clk_name[CLK_I2S_RCLK_SRC],
 				CLK_SET_RATE_PARENT,
-				priv->addr + I2SPSR, 8, 6, 0, i2s->lock);
+				priv->addr + I2SPSR, 8, 6, 0, &priv->lock);
 
 		p_names[0] = i2s_clk_name[CLK_I2S_RCLK_PSR];
 		priv->clk_data.clk_num = 2;
@@ -1333,7 +1332,7 @@ static int i2s_register_clock_provider(struct samsung_i2s_priv *priv)
 				i2s_clk_name[CLK_I2S_CDCLK], p_names[0],
 				CLK_SET_RATE_PARENT,
 				priv->addr + I2SMOD, reg_info->cdclkcon_off,
-				CLK_GATE_SET_TO_DISABLE, i2s->lock);
+				CLK_GATE_SET_TO_DISABLE, &priv->lock);
 
 	priv->clk_data.clk_num += 1;
 	priv->clk_data.clks = priv->clk_table;
@@ -1411,8 +1410,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 
 	pri_dai = &priv->dai[SAMSUNG_I2S_ID_PRIMARY - 1];
 
-	spin_lock_init(&priv->spinlock);
-	pri_dai->lock = &priv->spinlock;
+	spin_lock_init(&priv->lock);
 
 	if (!np) {
 		if (i2s_pdata == NULL) {
@@ -1474,7 +1472,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	if (quirks & QUIRK_SEC_DAI) {
 		sec_dai = &priv->dai[SAMSUNG_I2S_ID_SECONDARY - 1];
 
-		sec_dai->lock = &priv->spinlock;
 		sec_dai->variant_regs = pri_dai->variant_regs;
 		sec_dai->dma_playback.addr = regs_base + I2STXDS;
 		sec_dai->dma_playback.chan_name = "tx-sec";
-- 
2.17.1

