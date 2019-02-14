Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9657C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21FA222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PhmHorRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437814AbfBNJie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:38:34 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:31064 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395144AbfBNJic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:38:32 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190214093829epoutp040e692b47ca725f96d90f2d1a61a8d1b7~DMXznjF-41377113771epoutp04F;
        Thu, 14 Feb 2019 09:38:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190214093829epoutp040e692b47ca725f96d90f2d1a61a8d1b7~DMXznjF-41377113771epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550137109;
        bh=g26M3vvo7rFQlqLQajT+REpGD/4KuQLx8Lv9IuQdqVM=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=PhmHorRLbw+0631Nl5sVIz5aP/UzcaH8DDxex/efLHG2Jc8aN4FCuqgTRtQLwQI5k
         3Y42wUMx3YCCL0wUbLCFAAPzO9kyEbEGWNtRAowpl+wSTRy3f5v0l8SN/E2H3zVw8B
         y/roNpkWjVTjSFywLa1wN3DIbczDd3zk3esfz85w=
Received: from epsmges2p3.samsung.com (unknown [182.195.42.71]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190214093829epcas2p34d2123e7b1e7d5600a591112e15c7c15~DMXzZ421X2153321533epcas2p32;
        Thu, 14 Feb 2019 09:38:29 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.FC.04134.417356C5; Thu, 14 Feb 2019 18:38:29 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20190214093828epcas2p444b9d819fefb0eb730a716589a00218b~DMXy333hr1746217462epcas2p4K;
        Thu, 14 Feb 2019 09:38:28 +0000 (GMT)
X-AuditID: b6c32a47-8abff70000001026-43-5c6537147b88
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 9B.52.03689.417356C5; Thu, 14 Feb
        2019 18:38:28 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMW0074FTFANE00@mmp2.samsung.com>; Thu, 14 Feb 2019
        18:38:28 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 Resend 02/13] ASoC: samsung: i2s: Drop spinlock pointer
 from i2s_dai data structure
Date:   Thu, 14 Feb 2019 10:37:36 +0100
Message-id: <20190214093747.2414-3-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190214093747.2414-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWy7bCmha6oeWqMwdtpjBZXLh5ispj68Amb
        xfnzG9gtvl3pYLK4vGsOm8XhN+2sFhdXfGFyYPfY8LmJzWPnrLvsHptWdbJ59G1ZxejxeZNc
        AGsUl01Kak5mWWqRvl0CV8bKL2cYC7ZbVbT/W8fSwDjfoIuRk0NCwETi7ZefjCC2kMAORok/
        /wq6GLmA7O+MErNePmCCKdo2YS0jRGIDo0Rb23V2COcXo8Tj57vAqtgEDCV6j/aBjRIREJO4
        PaeTGaSIWWAlo8SWfZvYQBLCAhkSzz/vAWtgEVCVaJ85F6yBV8BK4tedg1Dr5CVWbzjADGJz
        ClhLzNy0HWy1hEAPm8SV/1eZIYpcJM69WcQKYUtLPFu1kRHCrpbYtb2bGaKhg1Gi5cJ2qAZr
        icPHL4I1MAvwSXQc/gv0AwdQnFeio00IwvSQePksHOKzPkaJ3yvvM05glFjAyLCKUSy1oDg3
        PbXYqMBYrzgxt7g0L10vOT93EyM4zrTcdzBuO+dziFGAg1GJh7dCKCVGiDWxrLgy9xCjBAez
        kgjvRaPUGCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8D6XnRgsJpCeWpGanphakFsFkmTg4pRoY
        c2OO+TvU/bwR/Tq+6r/ekq1T/V/Vvr/ptr9opvUP5v9lulvemhw80ZeuGP5TVnXla6vTqfM7
        XNILEqfKXIoXLPJ9lXB23uqN/EHRDezKBRo6BjNP2d88tnLC8ulPbE/HH7FdV6pWxpZvMy/q
        PNdWvYdpqVdLHDJvzr6ttdZry+E9Ah+vV6z9psRSnJFoqMVcVJwIALpr0WKvAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmluLIzCtJLcpLzFFi42I5/e+xoK6IeWqMwZ3dYhZXLh5ispj68Amb
        xfnzG9gtvl3pYLK4vGsOm8XhN+2sFhdXfGFyYPfY8LmJzWPnrLvsHptWdbJ59G1ZxejxeZNc
        AGsUl01Kak5mWWqRvl0CV8bKL2cYC7ZbVbT/W8fSwDjfoIuRk0NCwERi24S1jF2MXBxCAusY
        Jfa9XMAM4fxilDi/tYUFpIpNwFCi92gfI4gtIiAmcXtOJ1gRs8BKRokj31cBJTg4hAUyJPbc
        TgapYRFQlWifOResnlfASuLXnYNMENvkJVZvOMAMYnMKWEvM3LQdrFUIqGbdofIJjDwLGBlW
        MUqmFhTnpucWGxUY5aWW6xUn5haX5qXrJefnbmIEBtG2w1r9OxgfL4k/xCjAwajEw1shlBIj
        xJpYVlyZe4hRgoNZSYT3olFqjBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe/vxjkUIC6Yklqdmp
        qQWpRTBZJg5OqQbG6vxMDuHVX8/rJDCufcaya9WpRLGQ//HrHqixcnps6Xv6596paXY6Xuq7
        zkaWTYraY3yzL5jbs3vaKuVrTrPXnE3SPP+BWcVLQSfqd/yxzOmhO299/P7MQmmFxtqMwuVz
        Oz8GbelfvlPJ7raYfwXL1stPlpd4R5e8ttS8UJQ00d7hjmay2I0dSizFGYmGWsxFxYkAsU7K
        NB4CAAA=
X-CMS-MailID: 20190214093828epcas2p444b9d819fefb0eb730a716589a00218b
CMS-TYPE: 102P
X-CMS-RootMailID: 20190214093828epcas2p444b9d819fefb0eb730a716589a00218b
References: <20190214093747.2414-1-s.nawrocki@samsung.com>
        <CGME20190214093828epcas2p444b9d819fefb0eb730a716589a00218b@epcas2p4.samsung.com>
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

