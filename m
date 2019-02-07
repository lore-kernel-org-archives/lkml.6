Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3C9C282D7
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9622A21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AuUWpIgi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfBGRBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:01:44 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:10882 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfBGRBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:01:42 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190207170140epoutp04380c3a62e9df46097905441e03b5908b~BI5wV-U-p0210902109epoutp04d;
        Thu,  7 Feb 2019 17:01:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190207170140epoutp04380c3a62e9df46097905441e03b5908b~BI5wV-U-p0210902109epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549558900;
        bh=aGjZmBj4J2RdwxqCubwjqbk7/XJNZ/DzGPohe0TJiIQ=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=AuUWpIgirztIh9vUrSNhN35kZgWONIxCgazRfllO7gOr1aVR+lcyM1mpy5HleYrmA
         z+0JqSMKIVKmVnUH7gVM3Zm06/omVr5iu3DsI5fNeCtWj+7M52o5ivYYajX4NoeZzr
         CqOm9yrrg000BoYrBdBU0b2K5firESRttlNa6icY=
Received: from epsmges2p4.samsung.com (unknown [182.195.42.72]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190207170139epcas2p31d62ff1321b48ca68726993c760d2776~BI5viyqf42769227692epcas2p3g;
        Thu,  7 Feb 2019 17:01:39 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.B6.04093.3746C5C5; Fri,  8 Feb 2019 02:01:39 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190207170138epcas2p31134b2beee877922d27fab5c79fdc7b1~BI5ull-6v2773527735epcas2p3E;
        Thu,  7 Feb 2019 17:01:38 +0000 (GMT)
X-AuditID: b6c32a48-18bff70000000ffd-42-5c5c64730c41
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.C8.03689.1746C5C5; Fri,  8 Feb 2019 02:01:38 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMK00MP9F8VXL10@mmp1.samsung.com>; Fri, 08 Feb 2019
        02:01:37 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 15/22] ASoC: samsung: i2s: Move quirks data to common driver
 data structure
Date:   Thu, 07 Feb 2019 18:00:23 +0100
Message-id: <20190207170028.720-16-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190207170028.720-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsWy7bCmhW5xSkyMwbKFPBZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6M2Rd+shd06VfcmbiTpYHxpFoXIyeH
        hICJxLOf3xi7GLk4hAR2MErMOPuNHcL5zijxetthZpiqc+u3sEIkdjNKbOh8ygTh/GKUWPny
        ATtIFZuAoUTv0T5GEFtEQEzi9pxOZpAiZoEWJok5c5eCjRIWiJWYvfAMK4jNIqAqceH5N7A4
        r4CVxM9nnxkh1slLnO9dBzaUEyh+a/8OFogaQYkfk++B2cxANQevPGcBWSAhcIRN4v+XR2wQ
        zS4SC+evgbKlJZ6t2gg1tFpi1/ZuZoiGDkaJlgvboZ6zljh8/CIrxFQ+iY7Df4E2cwDFeSU6
        2oQgSjwkNvw6yQzxci+jxOm329kmMErNQnLULCRHLWBkWsUollpQnJueWmxUYKJXnJhbXJqX
        rpecn7uJERzpWh47GA+c8znEKMDBqMTDe0E7JkaINbGsuDL3EKMEB7OSCK9sAlCINyWxsiq1
        KD++qDQntfgQozQHi5I470PpudFCAumJJanZqakFqUUwWSYOTqkGRvuHlgcXT3/97OrlV0/e
        yD6VSwu/YMn+6O5Vnc3LdasePGsrDIyOk+/cYKBz9jnPl4Dp86u04yNvrDzxMbNMuLxVwcTS
        MuaX1uwnBn/2xN/6Ubfpvhqb4JsPCm+TL6hWL7xXVHQmJvcT66Z4vyTOKdYn085YNuyQedlS
        4Cx0KWSR+Oblls9knymxFGckGmoxFxUnAgDAe7o68AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsVy+t9jAd2ilJgYg+6FrBZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6M2Rd+shd06VfcmbiTpYHxpFoXIyeH
        hICJxLn1W1i7GLk4hAR2MkqsuPqTHcL5xSjx/e80VpAqNgFDid6jfYwgtoiAmMTtOZ3MIEXM
        Ak1MErtuX2QHSQgLxErMXngGrIFFQFXiwvNvzCA2r4CVxM9nnxkh1slLnO9dB1bPCRS/tX8H
        C4gtJGAp8WFCEytEvaDEj8n3wOLMQPUHrzxnmcDINwtJahaS1AJGplWMkqkFxbnpucVGBUZ5
        qeV6xYm5xaV56XrJ+bmbGIFhvO2wVv8OxsdL4g8xCnAwKvHwXtCOiRFiTSwrrsw9xCjBwawk
        wiubABTiTUmsrEotyo8vKs1JLT7EKM3BoiTOy59/LFJIID2xJDU7NbUgtQgmy8TBKdXAaBNw
        /dueoyv40ja+FXumc1NRcHWEFrdeh/fDlfa/zuTczVmi+eXvm43Jf08eOFWu3uLPKTJr36nO
        17Nc/RWnZEn+1S+QV/t+8quyTeas2ZX3p39o/xoR0bO372pNHkNV6rE/n07sMDfu/HgihJH9
        1TKGRsZJqRuSf+/ln/NXUPPr/LKwH5NjtyqxFGckGmoxFxUnAgCDl2MgXwIAAA==
X-CMS-MailID: 20190207170138epcas2p31134b2beee877922d27fab5c79fdc7b1
CMS-TYPE: 102P
X-CMS-RootMailID: 20190207170138epcas2p31134b2beee877922d27fab5c79fdc7b1
References: <20190207170028.720-1-s.nawrocki@samsung.com>
        <CGME20190207170138epcas2p31134b2beee877922d27fab5c79fdc7b1@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The quirk flags are common for the primary and the secondary DAI
so move respective field from struct i2s_dai to common driver data
structure.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 6ea0f0050fc8..e11d678e9c1f 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -84,7 +84,6 @@ struct i2s_dai {
 	struct snd_dmaengine_dai_dma_data dma_capture;
 	struct snd_dmaengine_dai_dma_data idma_playback;
 	dma_filter_fn filter;
-	u32	quirks;
 
 	struct samsung_i2s_priv *priv;
 };
@@ -122,19 +121,13 @@ struct samsung_i2s_priv {
 	u32 suspend_i2spsr;
 
 	const struct samsung_i2s_variant_regs *variant_regs;
+	u32 quirks;
 
 	/* The clock provider's data */
 	struct clk *clk_table[3];
 	struct clk_onecell_data clk_data;
 };
 
-struct i2s_dai *samsung_i2s_get_pri_dai(struct device *dev)
-{
-	struct samsung_i2s_priv *priv = dev_get_drvdata(dev);
-
-	return &priv->dai[SAMSUNG_I2S_ID_PRIMARY - 1];
-}
-
 /* Returns true if this is the 'overlay' stereo DAI */
 static inline bool is_secondary(struct i2s_dai *i2s)
 {
@@ -343,7 +336,7 @@ static inline void set_bfs(struct i2s_dai *i2s, unsigned bfs)
 {
 	struct samsung_i2s_priv *priv = i2s->priv;
 	u32 mod = readl(priv->addr + I2SMOD);
-	int tdm = i2s->quirks & QUIRK_SUPPORTS_TDM;
+	int tdm = priv->quirks & QUIRK_SUPPORTS_TDM;
 	int bfs_shift = priv->variant_regs->bfs_off;
 
 	/* Non-TDM I2S controllers do not support BCLK > 48 * FS */
@@ -563,7 +556,7 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id, unsigned int rfs,
 	case SAMSUNG_I2S_RCLKSRC_1: /* clock corrsponding to IISMOD[10] := 1 */
 		mask = 1 << i2s_regs->rclksrc_off;
 
-		if ((i2s->quirks & QUIRK_NO_MUXPSR)
+		if ((priv->quirks & QUIRK_NO_MUXPSR)
 				|| (clk_id == SAMSUNG_I2S_RCLKSRC_0))
 			clk_id = 0;
 		else
@@ -830,8 +823,9 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 
 /* We set constraints on the substream acc to the version of I2S */
 static int i2s_startup(struct snd_pcm_substream *substream,
-	  struct snd_soc_dai *dai)
+	struct snd_soc_dai *dai)
 {
+	struct samsung_i2s_priv *priv = snd_soc_dai_get_drvdata(dai);
 	struct i2s_dai *i2s = to_info(dai);
 	struct i2s_dai *other = get_other_dai(i2s);
 	unsigned long flags;
@@ -847,7 +841,7 @@ static int i2s_startup(struct snd_pcm_substream *substream,
 	else
 		i2s->mode |= DAI_MANAGER;
 
-	if (!any_active(i2s) && (i2s->quirks & QUIRK_NEED_RSTCLR))
+	if (!any_active(i2s) && (priv->quirks & QUIRK_NEED_RSTCLR))
 		writel(CON_RSTCLR, i2s->priv->addr + I2SCON);
 
 	spin_unlock_irqrestore(&lock, flags);
@@ -929,7 +923,7 @@ static int config_setup(struct i2s_dai *i2s)
 	if (is_slave(i2s))
 		return 0;
 
-	if (!(i2s->quirks & QUIRK_NO_MUXPSR)) {
+	if (!(priv->quirks & QUIRK_NO_MUXPSR)) {
 		psr = priv->rclk_srcrate / i2s->frmclk / rfs;
 		writel(((psr - 1) << 8) | PSR_PSREN, priv->addr + I2SPSR);
 		dev_dbg(&i2s->pdev->dev,
@@ -1068,10 +1062,10 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 		snd_soc_dai_init_dma_data(dai, &i2s->dma_playback,
 					   &i2s->dma_capture);
 
-		if (i2s->quirks & QUIRK_NEED_RSTCLR)
+		if (priv->quirks & QUIRK_NEED_RSTCLR)
 			writel(CON_RSTCLR, priv->addr + I2SCON);
 
-		if (i2s->quirks & QUIRK_SUPPORTS_IDMA)
+		if (priv->quirks & QUIRK_SUPPORTS_IDMA)
 			idma_reg_addr_init(priv->addr,
 					i2s->sec_dai->idma_playback.addr);
 	}
@@ -1099,13 +1093,14 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 
 static int samsung_i2s_dai_remove(struct snd_soc_dai *dai)
 {
+	struct samsung_i2s_priv *priv = snd_soc_dai_get_drvdata(dai);
 	struct i2s_dai *i2s = to_info(dai);
 	unsigned long flags;
 
 	pm_runtime_get_sync(dai->dev);
 
 	if (!is_secondary(i2s)) {
-		if (i2s->quirks & QUIRK_NEED_RSTCLR) {
+		if (priv->quirks & QUIRK_NEED_RSTCLR) {
 			spin_lock_irqsave(&priv->lock, flags);
 			writel(0, i2s->priv->addr + I2SCON);
 			spin_unlock_irqrestore(&priv->lock, flags);
@@ -1279,7 +1274,6 @@ static int i2s_register_clock_provider(struct samsung_i2s_priv *priv)
 	const char *clk_name[2] = { "i2s_opclk0", "i2s_opclk1" };
 	const char *p_names[2] = { NULL };
 	struct device *dev = &priv->pdev->dev;
-	struct i2s_dai *i2s = samsung_i2s_get_pri_dai(dev);
 	const struct samsung_i2s_variant_regs *reg_info = priv->variant_regs;
 	const char *i2s_clk_name[ARRAY_SIZE(i2s_clk_desc)];
 	struct clk *rclksrc;
@@ -1305,7 +1299,7 @@ static int i2s_register_clock_provider(struct samsung_i2s_priv *priv)
 			return -ENOMEM;
 	}
 
-	if (!(i2s->quirks & QUIRK_NO_MUXPSR)) {
+	if (!(priv->quirks & QUIRK_NO_MUXPSR)) {
 		/* Activate the prescaler */
 		u32 val = readl(priv->addr + I2SPSR);
 		writel(val | PSR_PSREN, priv->addr + I2SPSR);
@@ -1399,11 +1393,11 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->variant_regs = i2s_dai_data->i2s_variant_regs;
-
 	quirks = np ? i2s_dai_data->quirks : i2s_pdata->type.quirks;
 	num_dais = (quirks & QUIRK_SEC_DAI) ? 2 : 1;
 	priv->pdev = pdev;
+	priv->variant_regs = i2s_dai_data->i2s_variant_regs;
+	priv->quirks = quirks;
 
 	ret = i2s_alloc_dais(priv, i2s_dai_data, num_dais);
 	if (ret < 0)
@@ -1458,7 +1452,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	pri_dai->dma_capture.chan_name = "rx";
 	pri_dai->dma_playback.addr_width = 4;
 	pri_dai->dma_capture.addr_width = 4;
-	pri_dai->quirks = quirks;
 	pri_dai->priv = priv;
 
 	if (quirks & QUIRK_PRI_6CHAN)
@@ -1481,7 +1474,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		}
 
 		sec_dai->dma_playback.addr_width = 4;
-		sec_dai->quirks = quirks;
 		sec_dai->idma_playback.addr = idma_addr;
 		sec_dai->pri_dai = pri_dai;
 		sec_dai->priv = priv;
-- 
2.20.1

