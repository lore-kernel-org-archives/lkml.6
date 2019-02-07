Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72AAC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F7A21904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AIQ0MiYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfBGRBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:01:38 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:32089 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfBGRBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:01:36 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190207170133epoutp033a1aa7659459037ce77c337d107f35d9~BI5qM9f6Q2895028950epoutp031;
        Thu,  7 Feb 2019 17:01:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190207170133epoutp033a1aa7659459037ce77c337d107f35d9~BI5qM9f6Q2895028950epoutp031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549558893;
        bh=sFgTV7wJVrbLv5ZBZQ7fcAraaJGip7s62VnsufDgPeA=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=AIQ0MiYXBNqPy5hDD8sJm7pEmdJhCvU/armXMJ8IgQ17a1tq/ka0ELLjb/sPzIS0p
         1I/cWO34ZOHwh6eZokehlBNr6BNjvNdIB3UtYBuTGUP1+hOL1UZFwnmOPV9R5uvxn7
         IaN1/fTMsb0D20yYgL/nr4ieHzvpG27NYoB7Z7po=
Received: from epsmges1p1.samsung.com (unknown [182.195.42.53]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190207170132epcas1p2ba4912a3f694bcb1b82efd69a7de9c5c~BI5pBfH641833218332epcas1p2h;
        Thu,  7 Feb 2019 17:01:32 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.B3.04074.C646C5C5; Fri,  8 Feb 2019 02:01:32 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190207170130epcas1p4809b7a8dc797ced2982dc3b305a0991b~BI5n38KGO1456614566epcas1p4L;
        Thu,  7 Feb 2019 17:01:30 +0000 (GMT)
X-AuditID: b6c32a35-297ff70000000fea-75-5c5c646cd5d9
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.D8.04015.A646C5C5; Fri,  8 Feb 2019 02:01:30 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMK00MP9F8VXL10@mmp1.samsung.com>; Fri, 08 Feb 2019
        02:01:30 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 13/22] ASoC: samsung: i2s: Drop spinlock pointer from
 i2s_dai data structure
Date:   Thu, 07 Feb 2019 18:00:21 +0100
Message-id: <20190207170028.720-14-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190207170028.720-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsWy7bCmgW5OSkyMwZcd7BZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6M6fcOMRZ0W1XM7OpgbGD8od/FyMkh
        IWAisePANtYuRi4OIYEdjBKPut6xQzjfGSV2TnvLBlf1pJUZIrGbUWLVj0dQzi9GiQUfnjCC
        VLEJGEr0Hu0Ds0UExCRuz+kEK2IWaGGSmDN3KTNIQlggTuJqTxcLiM0ioCpxY/ZtsBW8AlYS
        j88cg1onL3G+dx07iM0JFL+1fwcLRI2gxI/J98BsZqCag1ees4AskBDYwybx4tJ3VohmF4mz
        16YAJTiAbGmJS0dtIcLVEru2dzND1HcwSrRc2M4MkbCWOHz8IivEUD6Jd197WCF6eSU62oQg
        SjwkttwAuRPk415GiY579xknMErNQnLTLCQ3LWBkWsUollpQnJueWmxYYKhXnJhbXJqXrpec
        n7uJERznWqY7GKec8znEKMDBqMTDq6EXEyPEmlhWXJl7iFGCg1lJhFc2ASjEm5JYWZValB9f
        VJqTWnyIUZqDRUmcd72Dc4yQQHpiSWp2ampBahFMlomDU6qBMVH07ZTCRSz+1ycduLi2YNOL
        EK15Cv8Oxr+ovuQxeQqzVtLlGTYXdgW1rdJcccla7quc9ImDOq+PXgnIeFNTK3jnm/Nsv0Lv
        HjMnbUbu6r1JX2f/teyrW3jj7Zr3KzjLeL/efv3kgOI97nPXshU5N2gK9bPM1Oc8J/aOb1bv
        38jjV12D+VZJNiuxFGckGmoxFxUnAgBzIfCH7wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsVy+t9jAd2slJgYgyc7rCyuXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZ0+8dYizotqqY2dXB2MD4Q7+LkZND
        QsBEYseTVuYuRi4OIYGdjBITd/xjh3B+MUo8f/CTEaSKTcBQovdoH5gtIiAmcXtOJ1gHs0AT
        k8Su2xfZQRLCAnESV5ffArNZBFQlbsy+zQZi8wpYSTw+c4wNYp28xPnedWA1nEDxW/t3sIDY
        QgKWEh8mNLFC1AtK/Jh8DyzODFR/8MpzlgmMfLOQpGYhSS1gZFrFKJlaUJybnltsVGCYl1qu
        V5yYW1yal66XnJ+7iREYxtsOa/XtYLy/JP4QowAHoxIP7wXtmBgh1sSy4srcQ4wSHMxKIryy
        CUAh3pTEyqrUovz4otKc1OJDjNIcLErivLfzjkUKCaQnlqRmp6YWpBbBZJk4OKUaGKN/Lt99
        20wkSjeA8WxE9wHZ+quN1h4ftho/LUiKN9hTp9r9+NksCSmlU7O0lhv7qsi6T0n87sN2PeXX
        /mNsV6ZvtDiwdNrN7tCn/QtfJ23rOf7dzrVW9/zDn0Ehovkyt1jit923D3YpK1P0y7ietdy0
        u/LYHFv3vN99M9xDz81nPSX3JT7BRYmlOCPRUIu5qDgRAOFUnuJfAgAA
X-CMS-MailID: 20190207170130epcas1p4809b7a8dc797ced2982dc3b305a0991b
CMS-TYPE: 101P
X-CMS-RootMailID: 20190207170130epcas1p4809b7a8dc797ced2982dc3b305a0991b
References: <20190207170028.720-1-s.nawrocki@samsung.com>
        <CGME20190207170130epcas1p4809b7a8dc797ced2982dc3b305a0991b@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we now have the 'priv' pointer in most of the places we can use
priv->lock directly, dropping extra indirection in the SFR region
spinlock access.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c | 51 +++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 9fae732bb620..c7499e25ce2b 100644
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

