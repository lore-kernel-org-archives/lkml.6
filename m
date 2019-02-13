Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A590C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7D720811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="toZJ4u0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405844AbfBMSnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:43:17 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:30893 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405804AbfBMSnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:43:11 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190213184307epoutp0253ddfca272ef498e81bedab457e4d39c~DAKDVfEAj0217602176epoutp02U;
        Wed, 13 Feb 2019 18:43:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190213184307epoutp0253ddfca272ef498e81bedab457e4d39c~DAKDVfEAj0217602176epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550083387;
        bh=cdxa69xtYLHciSEnv9sUjq5OE7F/lZIZBuYcOBsw/Hw=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=toZJ4u0VhBuQiBp/IQbyYaoPSKJ7nzM6zYxa8T9pv0BshLnzF82VyPRKu6vNfzbT7
         PizN8G58FopXaC1bLKNJfSQIU2aazsdmxCs4d1iLrzov/VY5cfL6dh8bV18Mx2YPxK
         CsDSv8pgfO+Mc8Efo4mW9GkJTKupmGUlIaAuoYeE=
Received: from epsmges1p3.samsung.com (unknown [182.195.42.55]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190213184307epcas1p3ecb73f3a314061f5fcf6bde4d0f552be~DAKDHt8uO0391703917epcas1p3O;
        Wed, 13 Feb 2019 18:43:07 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.DB.04069.B35646C5; Thu, 14 Feb 2019 03:43:07 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190213184306epcas1p4ff854f370c8ea8371430e26c3bfeac19~DAKCqUaYU2228522285epcas1p4X;
        Wed, 13 Feb 2019 18:43:06 +0000 (GMT)
X-AuditID: b6c32a37-989ff70000000fe5-00-5c64653b04fe
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 26.CE.04015.A35646C5; Thu, 14 Feb
        2019 03:43:06 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMV00HOONZ3WX60@mmp2.samsung.com>; Thu, 14 Feb 2019
        03:43:06 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 04/13] ASoC: samsung: i2s: Move quirks data to common
 driver data structure
Date:   Wed, 13 Feb 2019 19:42:03 +0100
Message-id: <20190213184212.5473-5-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190213184212.5473-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCmrq51akqMwZGLXBZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6M2U3CBW26FXdnXWJtYPyj0sXIySEh
        YCJxYFkTaxcjF4eQwA5GiRUHJrJAON8ZJZbOaGKEqZoz5xhUYgOjRPeGfkYI5xejxIyb39lA
        qtgEDCV6j/aBdYgIiEncntPJDFLELNDCJDFn7lJmkISwQIJEy/IvTCA2i4CqxNmGv0A2Bwev
        gJXE7e+KENvkJVZvOABWzilgLfFv7XN2kDkSAkvYJFb03mWHKHKRuNm2gBmkV0JAWuLSUVuI
        cLXEru3dzBD1HYwSLRe2M0MkrCUOH7/ICmIzC/BJvPvawwrRyyvR0SYEUeIhMXv9MyaIx/oY
        JSYcXcQygVFiASPDKkax1ILi3PTUYsMCY73ixNzi0rx0veT83E2M4BjUMt/BuOGczyFGAQ5G
        JR7eCqGUGCHWxLLiytxDjBIczEoivHpRQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK86x2cY4QE
        0hNLUrNTUwtSi2CyTBycUg2MPZPtgkuv8fe4RJo7/dyc9bzrEdesc/8/XuaP/nezkW/x/4pD
        K293bXn4NNN26707jxlKjK7Mti9YfmLjfLdXG5/0ndgXUrX609+jcqce2y7e3+t6KvB+avmc
        Bi5zSc6iWWWHTzc++pt0aXuT2NnmqofuCXxl7i2LuE673mqduHRagFTcP+n4o0osxRmJhlrM
        RcWJAE75H7K9AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJLMWRmVeSWpSXmKPExsVy+t9jQV2r1JQYg/aDehZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6M2U3CBW26FXdnXWJtYPyj0sXIySEh
        YCIxZ84xli5GLg4hgXWMEsf6VzCDJIQEfjFKrH7FAWKzCRhK9B7tYwSxRQTEJG7P6WQGaWAW
        aGKS2HX7IjtIQlggQeLbu3msIDaLgKrE2Ya/TF2MHBy8AlYSt78rQiyTl1i94QDYfE4Ba4l/
        a5+zQ+yykpj44RLzBEaeBYwMqxglUwuKc9Nzi40KDPNSy/WKE3OLS/PS9ZLzczcxAgNs22Gt
        vh2M95fEH2IU4GBU4uFVEEiJEWJNLCuuzD3EKMHBrCTCqxcFFOJNSaysSi3Kjy8qzUktPsQo
        zcGiJM57O+9YpJBAemJJanZqakFqEUyWiYNTqoFRdlqg5akbKh0XQiMm1/2b7Zmuf52NLbnq
        vGRxiY7Kg2N5bbzHq3duXHdA1GL/84hHs+89/Jy2b3r+jDfPs8U9976Jenzombz78p1Hiydv
        ZF7VkfXl6Sy/498z4tXP5n7yjL/zeStDYKGy+ra0qYunXYidU1Ybx2T+u7TGWHdapaGy1OOq
        pv07lViKMxINtZiLihMBS81NFSwCAAA=
X-CMS-MailID: 20190213184306epcas1p4ff854f370c8ea8371430e26c3bfeac19
CMS-TYPE: 101P
X-CMS-RootMailID: 20190213184306epcas1p4ff854f370c8ea8371430e26c3bfeac19
References: <20190213184212.5473-1-s.nawrocki@samsung.com>
        <CGME20190213184306epcas1p4ff854f370c8ea8371430e26c3bfeac19@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The quirk flags are common for the primary and the secondary DAI
so move respective field from struct i2s_dai to common driver data
structure.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/i2s.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 0c4c4de8c7e9..8f0af4b0f25a 100644
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
@@ -832,6 +825,7 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 static int i2s_startup(struct snd_pcm_substream *substream,
 	  struct snd_soc_dai *dai)
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
@@ -1106,7 +1100,7 @@ static int samsung_i2s_dai_remove(struct snd_soc_dai *dai)
 	pm_runtime_get_sync(dai->dev);
 
 	if (!is_secondary(i2s)) {
-		if (i2s->quirks & QUIRK_NEED_RSTCLR) {
+		if (priv->quirks & QUIRK_NEED_RSTCLR) {
 			spin_lock_irqsave(&priv->lock, flags);
 			writel(0, priv->addr + I2SCON);
 			spin_unlock_irqrestore(&priv->lock, flags);
@@ -1280,7 +1274,6 @@ static int i2s_register_clock_provider(struct samsung_i2s_priv *priv)
 	const char *clk_name[2] = { "i2s_opclk0", "i2s_opclk1" };
 	const char *p_names[2] = { NULL };
 	struct device *dev = &priv->pdev->dev;
-	struct i2s_dai *i2s = samsung_i2s_get_pri_dai(dev);
 	const struct samsung_i2s_variant_regs *reg_info = priv->variant_regs;
 	const char *i2s_clk_name[ARRAY_SIZE(i2s_clk_desc)];
 	struct clk *rclksrc;
@@ -1306,7 +1299,7 @@ static int i2s_register_clock_provider(struct samsung_i2s_priv *priv)
 			return -ENOMEM;
 	}
 
-	if (!(i2s->quirks & QUIRK_NO_MUXPSR)) {
+	if (!(priv->quirks & QUIRK_NO_MUXPSR)) {
 		/* Activate the prescaler */
 		u32 val = readl(priv->addr + I2SPSR);
 		writel(val | PSR_PSREN, priv->addr + I2SPSR);
@@ -1400,11 +1393,11 @@ static int samsung_i2s_probe(struct platform_device *pdev)
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
@@ -1459,7 +1452,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	pri_dai->dma_capture.chan_name = "rx";
 	pri_dai->dma_playback.addr_width = 4;
 	pri_dai->dma_capture.addr_width = 4;
-	pri_dai->quirks = quirks;
 	pri_dai->priv = priv;
 
 	if (quirks & QUIRK_PRI_6CHAN)
@@ -1482,7 +1474,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		}
 
 		sec_dai->dma_playback.addr_width = 4;
-		sec_dai->quirks = quirks;
 		sec_dai->idma_playback.addr = idma_addr;
 		sec_dai->pri_dai = pri_dai;
 		sec_dai->priv = priv;
-- 
2.17.1

