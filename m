Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F399C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F7420811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cfMykpWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394219AbfBMSxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:53:12 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:30878 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405751AbfBMSnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:43:00 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190213184257epoutp020aeb8444b287818cd4cdde55c4e282cf~DAJ5nFyDK0221502215epoutp02F;
        Wed, 13 Feb 2019 18:42:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190213184257epoutp020aeb8444b287818cd4cdde55c4e282cf~DAJ5nFyDK0221502215epoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550083377;
        bh=UyhfJTbo6SaxmfkXHyy33sPK1/ZKpe2+WV/TfxZKw30=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=cfMykpWYCUJgH2e2Sqlv/WJIIIDsuDupAqoyu4VXSjSAOy1CR0vO2W4BGjOWZyl8V
         trtls4l4xl1xNJyRuYW20zfpBck/zA18f+22f68SUuVZLleVYP6F1ofNkOySmq6zC/
         Bkh/sNwKwnaemZgOCzNiNWwx9m9WSXRaw2hF2Qv0=
Received: from epsmges2p2.samsung.com (unknown [182.195.42.70]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190213184256epcas2p39a7cbcb53d8e4ce3168e5c385b09cd23~DAJ5MBF7s0253402534epcas2p3o;
        Wed, 13 Feb 2019 18:42:56 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8B.5C.04136.035646C5; Thu, 14 Feb 2019 03:42:56 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190213184256epcas2p34078238855e1f9c1730f42e70094b114~DAJ43s0rl0852908529epcas2p3O;
        Wed, 13 Feb 2019 18:42:56 +0000 (GMT)
X-AuditID: b6c32a46-2a7ff70000001028-97-5c64653080fc
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 34.ED.03689.035646C5; Thu, 14 Feb
        2019 03:42:56 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMV00HOONZ3WX60@mmp2.samsung.com>; Thu, 14 Feb 2019
        03:42:55 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 01/13] ASoC: samsung: i2s: Move SFR pointer to common
 driver data structure
Date:   Wed, 13 Feb 2019 19:42:00 +0100
Message-id: <20190213184212.5473-2-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190213184212.5473-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCmqa5BakqMwcI+RYsrFw8xWWycsZ7V
        YurDJ2wW589vYLf4dqWDyeLyrjlsFjPO72OyWHvkLrvF4TftrBYXV3xhcuDy2PC5ic1j56y7
        7B6bVnWyefRtWcXo8XmTXABrFJdNSmpOZllqkb5dAlfG9eUiBZszKy5dOs/WwPg6tIuRg0NC
        wETi+TulLkYuDiGBHYwSd49MYodwvjNKLL4/DcjhBCtq3PuWFcQWEtjAKPH1qAVE0S9GiS0N
        nSwgCTYBQ4neo32MILaIgJjE7TmdzCBFzAItTBJz5i5lBkkICyRI3L7UwgZiswioSjxe+BjM
        5hWwktjZeowFYpu8xOoNB8DqOQWsJf6tfQ52koTAAjaJqdf2QRW5SBzvbWKGsKUlnq3ayAhh
        V0vs2t7NDNHQwSjRcmE7VJG1xOHjF8F+YBbgk+g4/JcdEgC8Eh1tQhAlHhIXnm+F+r+PUWLr
        +1vMExglFjAyrGIUSy0ozk1PLTYqMNIrTswtLs1L10vOz93ECI5BLbcdjEvO+RxiFOBgVOLh
        rRBKiRFiTSwrrsw9xCjBwawkwqsXBRTiTUmsrEotyo8vKs1JLT7EKM3BoiTO+1B6brSQQHpi
        SWp2ampBahFMlomDU6qB8dLuRjfZqtxTJ79pJSwVuPD4+ek3uddsOFIMtSyEi/mcHjV4zZt3
        JfFNGJ+T22qro/M2f6sXmuwpqZj/ovxoZnzDLrMf+r+kP+/fWzdvU6jKPX2eeyLi1803VZ82
        VJrgIeHkWiRsGH09+debhnsXFitHCFyqUYnLMlljcpvFXL13Q8Z9+WvGSizFGYmGWsxFxYkA
        I96ZQb0CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsVy+t9jQV2D1JQYgyl/OC2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZ15eLFGzOrLh06TxbA+Pr0C5GTg4J
        AROJxr1vWbsYuTiEBNYxShz6tJIdwvnFKNHZ95gdpIpNwFCi92gfI4gtIiAmcXtOJzNIEbNA
        E5PErtsXwYqEBRIkdq9fA1bEIqAq8XjhYzYQm1fASmJn6zEWiHXyEqs3HGAGsTkFrCX+rX0O
        1isEVDPxwyXmCYw8CxgZVjFKphYU56bnFhsVGOWllusVJ+YWl+al6yXn525iBAbZtsNa/TsY
        Hy+JP8QowMGoxMNbIZQSI8SaWFZcmXuIUYKDWUmEVy8KKMSbklhZlVqUH19UmpNafIhRmoNF
        SZyXP/9YpJBAemJJanZqakFqEUyWiYNTqoFx5zHW5UfCDnkXMcbrJAW67a3e9WrR4SKbA1NS
        SwNely0M3dJVtj1hiefu7Ad7Ttxbmh0c/UDi8ifflRpXT3W8T3n09MNWmS17uTelPBFbeD9i
        QVry87R40ZsiU4wrhCo2LfontW+iY0i02NEK194kh2s879WC5c5W3Vhsn2a0Qe3BlMbEUql/
        SizFGYmGWsxFxYkAlPBPlS4CAAA=
X-CMS-MailID: 20190213184256epcas2p34078238855e1f9c1730f42e70094b114
CMS-TYPE: 102P
X-CMS-RootMailID: 20190213184256epcas2p34078238855e1f9c1730f42e70094b114
References: <20190213184212.5473-1-s.nawrocki@samsung.com>
        <CGME20190213184256epcas2p34078238855e1f9c1730f42e70094b114@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SFR region is common for both DAIs so move related data structure
field from struct i2s_dai to the common driver data structure.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/i2s.c | 106 ++++++++++++++++++++++------------------
 1 file changed, 59 insertions(+), 47 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 72f0cb7abb30..3f8955608a94 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -60,8 +60,7 @@ struct samsung_i2s_dai_data {
 struct i2s_dai {
 	/* Platform device for this DAI */
 	struct platform_device *pdev;
-	/* Memory mapped SFR region */
-	void __iomem	*addr;
+
 	/* Frame Clock */
 	unsigned frmclk;
 	/*
@@ -100,6 +99,9 @@ struct samsung_i2s_priv {
 	struct platform_device *pdev;
 	struct platform_device *pdev_sec;
 
+	/* Memory mapped SFR region */
+	void __iomem *addr;
+
 	/* Spinlock protecting access to the device's registers */
 	spinlock_t spinlock;
 
@@ -143,7 +145,9 @@ static inline bool is_secondary(struct i2s_dai *i2s)
 /* If operating in SoC-Slave mode */
 static inline bool is_slave(struct i2s_dai *i2s)
 {
-	u32 mod = readl(i2s->addr + I2SMOD);
+	struct samsung_i2s_priv *priv = i2s->priv;
+
+	u32 mod = readl(priv->addr + I2SMOD);
 	return (mod & (1 << i2s->variant_regs->mss_off)) ? true : false;
 }
 
@@ -155,7 +159,7 @@ static inline bool tx_active(struct i2s_dai *i2s)
 	if (!i2s)
 		return false;
 
-	active = readl(i2s->addr + I2SCON);
+	active = readl(i2s->priv->addr + I2SCON);
 
 	if (is_secondary(i2s))
 		active &= CON_TXSDMA_ACTIVE;
@@ -193,7 +197,7 @@ static inline bool rx_active(struct i2s_dai *i2s)
 	if (!i2s)
 		return false;
 
-	active = readl(i2s->addr + I2SCON) & CON_RXDMA_ACTIVE;
+	active = readl(i2s->priv->addr + I2SCON) & CON_RXDMA_ACTIVE;
 
 	return active ? true : false;
 }
@@ -256,8 +260,10 @@ static inline bool is_manager(struct i2s_dai *i2s)
 /* Read RCLK of I2S (in multiples of LRCLK) */
 static inline unsigned get_rfs(struct i2s_dai *i2s)
 {
+	struct samsung_i2s_priv *priv = i2s->priv;
 	u32 rfs;
-	rfs = readl(i2s->addr + I2SMOD) >> i2s->variant_regs->rfs_off;
+
+	rfs = readl(priv->addr + I2SMOD) >> i2s->variant_regs->rfs_off;
 	rfs &= i2s->variant_regs->rfs_mask;
 
 	switch (rfs) {
@@ -275,7 +281,8 @@ static inline unsigned get_rfs(struct i2s_dai *i2s)
 /* Write RCLK of I2S (in multiples of LRCLK) */
 static inline void set_rfs(struct i2s_dai *i2s, unsigned rfs)
 {
-	u32 mod = readl(i2s->addr + I2SMOD);
+	struct samsung_i2s_priv *priv = i2s->priv;
+	u32 mod = readl(priv->addr + I2SMOD);
 	int rfs_shift = i2s->variant_regs->rfs_off;
 
 	mod &= ~(i2s->variant_regs->rfs_mask << rfs_shift);
@@ -307,14 +314,16 @@ static inline void set_rfs(struct i2s_dai *i2s, unsigned rfs)
 		break;
 	}
 
-	writel(mod, i2s->addr + I2SMOD);
+	writel(mod, priv->addr + I2SMOD);
 }
 
 /* Read Bit-Clock of I2S (in multiples of LRCLK) */
 static inline unsigned get_bfs(struct i2s_dai *i2s)
 {
+	struct samsung_i2s_priv *priv = i2s->priv;
 	u32 bfs;
-	bfs = readl(i2s->addr + I2SMOD) >> i2s->variant_regs->bfs_off;
+
+	bfs = readl(priv->addr + I2SMOD) >> i2s->variant_regs->bfs_off;
 	bfs &= i2s->variant_regs->bfs_mask;
 
 	switch (bfs) {
@@ -333,7 +342,8 @@ static inline unsigned get_bfs(struct i2s_dai *i2s)
 /* Write Bit-Clock of I2S (in multiples of LRCLK) */
 static inline void set_bfs(struct i2s_dai *i2s, unsigned bfs)
 {
-	u32 mod = readl(i2s->addr + I2SMOD);
+	struct samsung_i2s_priv *priv = i2s->priv;
+	u32 mod = readl(priv->addr + I2SMOD);
 	int tdm = i2s->quirks & QUIRK_SUPPORTS_TDM;
 	int bfs_shift = i2s->variant_regs->bfs_off;
 
@@ -378,13 +388,13 @@ static inline void set_bfs(struct i2s_dai *i2s, unsigned bfs)
 		return;
 	}
 
-	writel(mod, i2s->addr + I2SMOD);
+	writel(mod, priv->addr + I2SMOD);
 }
 
 /* Sample-Size */
 static inline int get_blc(struct i2s_dai *i2s)
 {
-	int blc = readl(i2s->addr + I2SMOD);
+	int blc = readl(i2s->priv->addr + I2SMOD);
 
 	blc = (blc >> 13) & 0x3;
 
@@ -398,7 +408,8 @@ static inline int get_blc(struct i2s_dai *i2s)
 /* TX Channel Control */
 static void i2s_txctrl(struct i2s_dai *i2s, int on)
 {
-	void __iomem *addr = i2s->addr;
+	struct samsung_i2s_priv *priv = i2s->priv;
+	void __iomem *addr = priv->addr;
 	int txr_off = i2s->variant_regs->txr_off;
 	u32 con = readl(addr + I2SCON);
 	u32 mod = readl(addr + I2SMOD) & ~(3 << txr_off);
@@ -448,7 +459,8 @@ static void i2s_txctrl(struct i2s_dai *i2s, int on)
 /* RX Channel Control */
 static void i2s_rxctrl(struct i2s_dai *i2s, int on)
 {
-	void __iomem *addr = i2s->addr;
+	struct samsung_i2s_priv *priv = i2s->priv;
+	void __iomem *addr = priv->addr;
 	int txr_off = i2s->variant_regs->txr_off;
 	u32 con = readl(addr + I2SCON);
 	u32 mod = readl(addr + I2SMOD) & ~(3 << txr_off);
@@ -485,9 +497,9 @@ static inline void i2s_fifo(struct i2s_dai *i2s, u32 flush)
 		return;
 
 	if (is_secondary(i2s))
-		fic = i2s->addr + I2SFICS;
+		fic = i2s->priv->addr + I2SFICS;
 	else
-		fic = i2s->addr + I2SFIC;
+		fic = i2s->priv->addr + I2SFIC;
 
 	/* Flush the FIFO */
 	writel(readl(fic) | flush, fic);
@@ -516,7 +528,7 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id, unsigned int rfs,
 	pm_runtime_get_sync(dai->dev);
 
 	spin_lock_irqsave(i2s->lock, flags);
-	mod = readl(i2s->addr + I2SMOD);
+	mod = readl(priv->addr + I2SMOD);
 	spin_unlock_irqrestore(i2s->lock, flags);
 
 	switch (clk_id) {
@@ -613,9 +625,9 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id, unsigned int rfs,
 	}
 
 	spin_lock_irqsave(i2s->lock, flags);
-	mod = readl(i2s->addr + I2SMOD);
+	mod = readl(priv->addr + I2SMOD);
 	mod = (mod & ~mask) | val;
-	writel(mod, i2s->addr + I2SMOD);
+	writel(mod, priv->addr + I2SMOD);
 	spin_unlock_irqrestore(i2s->lock, flags);
 done:
 	pm_runtime_put(dai->dev);
@@ -698,7 +710,7 @@ static int i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 
 	pm_runtime_get_sync(dai->dev);
 	spin_lock_irqsave(i2s->lock, flags);
-	mod = readl(i2s->addr + I2SMOD);
+	mod = readl(priv->addr + I2SMOD);
 	/*
 	 * Don't change the I2S mode if any controller is active on this
 	 * channel.
@@ -714,7 +726,7 @@ static int i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 
 	mod &= ~(sdf_mask | lrp_rlow | mod_slave);
 	mod |= tmp;
-	writel(mod, i2s->addr + I2SMOD);
+	writel(mod, priv->addr + I2SMOD);
 	spin_unlock_irqrestore(i2s->lock, flags);
 	pm_runtime_put(dai->dev);
 
@@ -801,9 +813,9 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	spin_lock_irqsave(i2s->lock, flags);
-	mod = readl(i2s->addr + I2SMOD);
+	mod = readl(priv->addr + I2SMOD);
 	mod = (mod & ~mask) | val;
-	writel(mod, i2s->addr + I2SMOD);
+	writel(mod, priv->addr + I2SMOD);
 	spin_unlock_irqrestore(i2s->lock, flags);
 
 	snd_soc_dai_init_dma_data(dai, &i2s->dma_playback, &i2s->dma_capture);
@@ -837,7 +849,7 @@ static int i2s_startup(struct snd_pcm_substream *substream,
 		i2s->mode |= DAI_MANAGER;
 
 	if (!any_active(i2s) && (i2s->quirks & QUIRK_NEED_RSTCLR))
-		writel(CON_RSTCLR, i2s->addr + I2SCON);
+		writel(CON_RSTCLR, i2s->priv->addr + I2SCON);
 
 	spin_unlock_irqrestore(&lock, flags);
 
@@ -920,7 +932,7 @@ static int config_setup(struct i2s_dai *i2s)
 
 	if (!(i2s->quirks & QUIRK_NO_MUXPSR)) {
 		psr = priv->rclk_srcrate / i2s->frmclk / rfs;
-		writel(((psr - 1) << 8) | PSR_PSREN, i2s->addr + I2SPSR);
+		writel(((psr - 1) << 8) | PSR_PSREN, priv->addr + I2SPSR);
 		dev_dbg(&i2s->pdev->dev,
 			"RCLK_SRC=%luHz PSR=%u, RCLK=%dfs, BCLK=%dfs\n",
 				priv->rclk_srcrate, psr, rfs, bfs);
@@ -1008,8 +1020,9 @@ static int i2s_set_clkdiv(struct snd_soc_dai *dai,
 static snd_pcm_sframes_t
 i2s_delay(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 {
+	struct samsung_i2s_priv *priv = snd_soc_dai_get_drvdata(dai);
 	struct i2s_dai *i2s = to_info(dai);
-	u32 reg = readl(i2s->addr + I2SFIC);
+	u32 reg = readl(priv->addr + I2SFIC);
 	snd_pcm_sframes_t delay;
 	const struct samsung_i2s_variant_regs *i2s_regs = i2s->variant_regs;
 
@@ -1018,7 +1031,7 @@ i2s_delay(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
 		delay = FIC_RXCOUNT(reg);
 	else if (is_secondary(i2s))
-		delay = FICS_TXCOUNT(readl(i2s->addr + I2SFICS));
+		delay = FICS_TXCOUNT(readl(priv->addr + I2SFICS));
 	else
 		delay = (reg >> i2s_regs->ftx0cnt_off) & 0x7f;
 
@@ -1042,6 +1055,7 @@ static int i2s_resume(struct snd_soc_dai *dai)
 
 static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 {
+	struct samsung_i2s_priv *priv = snd_soc_dai_get_drvdata(dai);
 	struct i2s_dai *i2s = to_info(dai);
 	struct i2s_dai *other = get_other_dai(i2s);
 	unsigned long flags;
@@ -1056,10 +1070,10 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 					   &i2s->dma_capture);
 
 		if (i2s->quirks & QUIRK_NEED_RSTCLR)
-			writel(CON_RSTCLR, i2s->addr + I2SCON);
+			writel(CON_RSTCLR, priv->addr + I2SCON);
 
 		if (i2s->quirks & QUIRK_SUPPORTS_IDMA)
-			idma_reg_addr_init(i2s->addr,
+			idma_reg_addr_init(priv->addr,
 					i2s->sec_dai->idma_playback.addr);
 	}
 
@@ -1086,6 +1100,7 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 
 static int samsung_i2s_dai_remove(struct snd_soc_dai *dai)
 {
+	struct samsung_i2s_priv *priv = snd_soc_dai_get_drvdata(dai);
 	struct i2s_dai *i2s = to_info(dai);
 	unsigned long flags;
 
@@ -1094,7 +1109,7 @@ static int samsung_i2s_dai_remove(struct snd_soc_dai *dai)
 	if (!is_secondary(i2s)) {
 		if (i2s->quirks & QUIRK_NEED_RSTCLR) {
 			spin_lock_irqsave(i2s->lock, flags);
-			writel(0, i2s->addr + I2SCON);
+			writel(0, priv->addr + I2SCON);
 			spin_unlock_irqrestore(i2s->lock, flags);
 		}
 	}
@@ -1205,11 +1220,10 @@ static int i2s_alloc_dais(struct samsung_i2s_priv *priv,
 static int i2s_runtime_suspend(struct device *dev)
 {
 	struct samsung_i2s_priv *priv = dev_get_drvdata(dev);
-	struct i2s_dai *i2s = samsung_i2s_get_pri_dai(dev);
 
-	priv->suspend_i2smod = readl(i2s->addr + I2SMOD);
-	priv->suspend_i2scon = readl(i2s->addr + I2SCON);
-	priv->suspend_i2spsr = readl(i2s->addr + I2SPSR);
+	priv->suspend_i2smod = readl(priv->addr + I2SMOD);
+	priv->suspend_i2scon = readl(priv->addr + I2SCON);
+	priv->suspend_i2spsr = readl(priv->addr + I2SPSR);
 
 	if (priv->op_clk)
 		clk_disable_unprepare(priv->op_clk);
@@ -1221,7 +1235,6 @@ static int i2s_runtime_suspend(struct device *dev)
 static int i2s_runtime_resume(struct device *dev)
 {
 	struct samsung_i2s_priv *priv = dev_get_drvdata(dev);
-	struct i2s_dai *i2s = samsung_i2s_get_pri_dai(dev);
 	int ret;
 
 	ret = clk_prepare_enable(priv->clk);
@@ -1236,9 +1249,9 @@ static int i2s_runtime_resume(struct device *dev)
 		}
 	}
 
-	writel(priv->suspend_i2scon, i2s->addr + I2SCON);
-	writel(priv->suspend_i2smod, i2s->addr + I2SMOD);
-	writel(priv->suspend_i2spsr, i2s->addr + I2SPSR);
+	writel(priv->suspend_i2scon, priv->addr + I2SCON);
+	writel(priv->suspend_i2smod, priv->addr + I2SMOD);
+	writel(priv->suspend_i2spsr, priv->addr + I2SPSR);
 
 	return 0;
 }
@@ -1296,21 +1309,21 @@ static int i2s_register_clock_provider(struct samsung_i2s_priv *priv)
 
 	if (!(i2s->quirks & QUIRK_NO_MUXPSR)) {
 		/* Activate the prescaler */
-		u32 val = readl(i2s->addr + I2SPSR);
-		writel(val | PSR_PSREN, i2s->addr + I2SPSR);
+		u32 val = readl(priv->addr + I2SPSR);
+		writel(val | PSR_PSREN, priv->addr + I2SPSR);
 
 		priv->clk_table[CLK_I2S_RCLK_SRC] = clk_register_mux(dev,
 				i2s_clk_name[CLK_I2S_RCLK_SRC], p_names,
 				ARRAY_SIZE(p_names),
 				CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
-				i2s->addr + I2SMOD, reg_info->rclksrc_off,
+				priv->addr + I2SMOD, reg_info->rclksrc_off,
 				1, 0, i2s->lock);
 
 		priv->clk_table[CLK_I2S_RCLK_PSR] = clk_register_divider(dev,
 				i2s_clk_name[CLK_I2S_RCLK_PSR],
 				i2s_clk_name[CLK_I2S_RCLK_SRC],
 				CLK_SET_RATE_PARENT,
-				i2s->addr + I2SPSR, 8, 6, 0, i2s->lock);
+				priv->addr + I2SPSR, 8, 6, 0, i2s->lock);
 
 		p_names[0] = i2s_clk_name[CLK_I2S_RCLK_PSR];
 		priv->clk_data.clk_num = 2;
@@ -1319,7 +1332,7 @@ static int i2s_register_clock_provider(struct samsung_i2s_priv *priv)
 	priv->clk_table[CLK_I2S_CDCLK] = clk_register_gate(dev,
 				i2s_clk_name[CLK_I2S_CDCLK], p_names[0],
 				CLK_SET_RATE_PARENT,
-				i2s->addr + I2SMOD, reg_info->cdclkcon_off,
+				priv->addr + I2SMOD, reg_info->cdclkcon_off,
 				CLK_GATE_SET_TO_DISABLE, i2s->lock);
 
 	priv->clk_data.clk_num += 1;
@@ -1423,9 +1436,9 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pri_dai->addr = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(pri_dai->addr))
-		return PTR_ERR(pri_dai->addr);
+	priv->addr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->addr))
+		return PTR_ERR(priv->addr);
 
 	regs_base = res->start;
 
@@ -1472,7 +1485,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		}
 
 		sec_dai->dma_playback.addr_width = 4;
-		sec_dai->addr = pri_dai->addr;
 		sec_dai->quirks = quirks;
 		sec_dai->idma_playback.addr = idma_addr;
 		sec_dai->pri_dai = pri_dai;
-- 
2.17.1

