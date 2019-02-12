Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE36C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7B02229F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tBtU62oy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbfBLSFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:05:13 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:40149 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731608AbfBLSFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:05:10 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190212180508epoutp013e37eb201e49635ed67b56657deaec71~Cr-mWXnr11898018980epoutp01v;
        Tue, 12 Feb 2019 18:05:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190212180508epoutp013e37eb201e49635ed67b56657deaec71~Cr-mWXnr11898018980epoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549994708;
        bh=NDv8LnYTqm5N2f0/VV3sghf31iqvfX+LBK6N+oIv4AY=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=tBtU62oy3OFRD2smriJYOx52JbYUjMVcJ5ryl2JcTFut2zIkZyC/KDQmbpWHdt2A9
         hav1VBIiv/jzG4Tnts038zxmaPT6JhTzITgSc0SXcN5yxn7zHl7OFXuP9nzbpNgB7H
         q/5ulO5vqVZHOMXxvvSiBUjL3GzWCBsFYyaCqb3o=
Received: from epsmges2p3.samsung.com (unknown [182.195.42.71]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190212180507epcas2p129248caeb7c00bd1478db2dd4f353e15~Cr-lSzWwI1897218972epcas2p1I;
        Tue, 12 Feb 2019 18:05:07 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.39.04134.3DA036C5; Wed, 13 Feb 2019 03:05:07 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20190212180506epcas2p43d7efeaec4a4ff63d13e5f79b281707a~Cr-k-EVtz3271632716epcas2p4F;
        Tue, 12 Feb 2019 18:05:06 +0000 (GMT)
X-AuditID: b6c32a47-8c3ff70000001026-61-5c630ad34937
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id E8.30.03689.2DA036C5; Wed, 13 Feb
        2019 03:05:06 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMT0024XRJ2FB10@mmp2.samsung.com>; Wed, 13 Feb 2019
        03:05:06 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 08/21] ASoC: samsung: i2s: Drop spinlock pointer from
 i2s_dai data structure
Date:   Tue, 12 Feb 2019 19:03:29 +0100
Message-id: <20190212180342.32040-9-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190212180342.32040-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7bCmqe5lruQYg742dosrFw8xWWycsZ7V
        YurDJ2wW589vYLf4dqWDyeLyrjlsFjPO72OyWHvkLrvF4TftrBYXV3xhcuDy2PC5ic1j56y7
        7B6bVnWyefRtWcXo8XmTXABrFJdNSmpOZllqkb5dAlfGn736BXusKn5PXsXewLjEoIuRk0NC
        wERie/Ntpi5GLg4hgR2MEmuvPGGHcL4zSuxunsUGU/WvaRkzRGIDo8TbM/MZIZxfjBLH3u5l
        AaliEzCU6D3axwhiiwiISdye0wnWwSzQwiQxZ+5SZpCEsECixKvnTWBFLAKqEr0bXoA18wpY
        S2z6s4EZYp28xPnedewgNqeAjcSzhd+gagQlfky+B2YzA9UcvPKcBWSBhMABNon2rpOsXYwc
        QI6LxNKZKhBzpCWerdrICGFXS+za3s0MUd/BKNFyYTvUMmuJw8cvskIM5ZPoOPyXHWIOr0RH
        mxBEiYfErDfXWSA+7meU6Dm0gHkCo9QsJDfNQnLTAkamVYxiqQXFuempxUYFxnrFibnFpXnp
        esn5uZsYwVGu5b6Dcds5n0OMAhyMSjy8K44mxQixJpYVV+YeYpTgYFYS4U1jTo4R4k1JrKxK
        LcqPLyrNSS0+xCjNwaIkzvtQem60kEB6YklqdmpqQWoRTJaJg1OqgbH1E5fynG9yMm9e6X9Q
        MvZUvBGZJzrd3H/zamZZg2yhi631az3Z3HYo1fIXWrVK918/2mfQZVBkoJHoPnP2AU2eteKf
        1845saCWMVOz3s7K3bj+9nf5m5Mkyyw+64tzbtggGrRIXXpbC5vJ7gnnJCYwyrzvZb5rLvv0
        x92vurcXeEsKaq1dpcRSnJFoqMVcVJwIABppC6ruAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsVy+t9jQd1LXMkxBofO6lpcuXiIyWLjjPWs
        FlMfPmGzOH9+A7vFtysdTBaXd81hs5hxfh+Txdojd9ktDr9pZ7W4uOILkwOXx4bPTWweO2fd
        ZffYtKqTzaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgy/uzVL9hjVfF78ir2BsYlBl2MnBwS
        AiYS/5qWMYPYQgLrGCWezM7oYuQCsn8xShx8M4MNJMEmYCjRe7SPEcQWERCTuD2nkxmkiFmg
        iUli1+2L7CAJYYFEiVfPm8CKWARUJXo3vGABsXkFrCU2/dnADLFNXuJ87zqwek4BG4lnC78B
        1XAAbbOWuLLJFqJcUOLH5HtgrcxA5QevPGeZwMg3C0lqFpLUAkamVYySqQXFuem5xUYFRnmp
        5XrFibnFpXnpesn5uZsYgQG87bBW/w7Gx0viDzEKcDAq8fCuOJoUI8SaWFZcmXuIUYKDWUmE
        N405OUaINyWxsiq1KD++qDQntfgQozQHi5I4L3/+sUghgfTEktTs1NSC1CKYLBMHp1QDY3y+
        btmakNYzK3falv1evTDr5uHcQlb+7GedLSs+r6v0WhGnf9Te2U5R0dZ9zV+5e9P4ZZSP/9N8
        s6fnzQeO3b9ipyUlzH502FT95UyfKDlhT7UgqYoytZCwpO21VavX8rPeCqi+mFJacrP1dU4Q
        x1MmjdwbrZwX1fOPbDTtF+84fV18qnudEktxRqKhFnNRcSIAs2VydFwCAAA=
X-CMS-MailID: 20190212180506epcas2p43d7efeaec4a4ff63d13e5f79b281707a
CMS-TYPE: 102P
X-CMS-RootMailID: 20190212180506epcas2p43d7efeaec4a4ff63d13e5f79b281707a
References: <20190212180342.32040-1-s.nawrocki@samsung.com>
        <CGME20190212180506epcas2p43d7efeaec4a4ff63d13e5f79b281707a@epcas2p4.samsung.com>
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
index 05f1de208307..0da07975d59b 100644
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
@@ -1107,9 +1106,9 @@ static int samsung_i2s_dai_remove(struct snd_soc_dai *dai)
 
 	if (!is_secondary(i2s)) {
 		if (i2s->quirks & QUIRK_NEED_RSTCLR) {
-			spin_lock_irqsave(i2s->lock, flags);
+			spin_lock_irqsave(&priv->lock, flags);
 			writel(0, i2s->priv->addr + I2SCON);
-			spin_unlock_irqrestore(i2s->lock, flags);
+			spin_unlock_irqrestore(&priv->lock, flags);
 		}
 	}
 
@@ -1316,13 +1315,13 @@ static int i2s_register_clock_provider(struct samsung_i2s_priv *priv)
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
@@ -1332,7 +1331,7 @@ static int i2s_register_clock_provider(struct samsung_i2s_priv *priv)
 				i2s_clk_name[CLK_I2S_CDCLK], p_names[0],
 				CLK_SET_RATE_PARENT,
 				priv->addr + I2SMOD, reg_info->cdclkcon_off,
-				CLK_GATE_SET_TO_DISABLE, i2s->lock);
+				CLK_GATE_SET_TO_DISABLE, &priv->lock);
 
 	priv->clk_data.clk_num += 1;
 	priv->clk_data.clks = priv->clk_table;
@@ -1410,8 +1409,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 
 	pri_dai = &priv->dai[SAMSUNG_I2S_ID_PRIMARY - 1];
 
-	spin_lock_init(&priv->spinlock);
-	pri_dai->lock = &priv->spinlock;
+	spin_lock_init(&priv->lock);
 
 	if (!np) {
 		if (i2s_pdata == NULL) {
@@ -1473,7 +1471,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	if (quirks & QUIRK_SEC_DAI) {
 		sec_dai = &priv->dai[SAMSUNG_I2S_ID_SECONDARY - 1];
 
-		sec_dai->lock = &priv->spinlock;
 		sec_dai->variant_regs = pri_dai->variant_regs;
 		sec_dai->dma_playback.addr = regs_base + I2STXDS;
 		sec_dai->dma_playback.chan_name = "tx-sec";
-- 
2.20.1

