Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764B7C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3162229F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lf4v2QxD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731716AbfBLSFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:05:23 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:22564 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731608AbfBLSFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:05:19 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190212180515epoutp0298bd964a7b13e2f0844190edf390e2bf~Cr-tI4vX62786327863epoutp027;
        Tue, 12 Feb 2019 18:05:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190212180515epoutp0298bd964a7b13e2f0844190edf390e2bf~Cr-tI4vX62786327863epoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549994715;
        bh=Z21vxVORT3Wmbw7H8ccHZm5nDTBzy6Pn1mvaXFj0K3M=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=lf4v2QxDUzh+0M0y9RPJ4VDDj/6rUBsjvTZUrIqtiA/KqF0CxsN7RovI+vjha54Ey
         fYnZJe8rWK/X4qr+4C7B/FRVXpS2o0R8v0EjoDrH96SQ2UU2gKD1LB5NocKxTVsPtO
         D+9BjLSP2ZtdqKj2V39dzDzmJH0PG0LXWGVZ/n9w=
Received: from epsmges2p3.samsung.com (unknown [182.195.42.71]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190212180514epcas2p2a9521e8bc97b2abe38fa7fc83b5d9ba9~Cr-r9U6P32848628486epcas2p2T;
        Tue, 12 Feb 2019 18:05:14 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.39.04134.ADA036C5; Wed, 13 Feb 2019 03:05:14 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190212180513epcas2p128eae26df9eef86550a4f628afd12603~Cr-rmT2cj1898118981epcas2p1E;
        Tue, 12 Feb 2019 18:05:13 +0000 (GMT)
X-AuditID: b6c32a47-8abff70000001026-6e-5c630adadd5f
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id B9.30.03689.9DA036C5; Wed, 13 Feb
        2019 03:05:13 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMT0024XRJ2FB10@mmp2.samsung.com>; Wed, 13 Feb 2019
        03:05:13 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 10/21] ASoC: samsung: i2s: Move quirks data to common
 driver data structure
Date:   Tue, 12 Feb 2019 19:03:31 +0100
Message-id: <20190212180342.32040-11-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190212180342.32040-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsWy7bCmue4truQYg1+/eCyuXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZX6auYy24olfR//4HewPjUrUuRg4O
        CQETib5Lrl2MXBxCAjsYJS6sOcQE4XxnlPi6dC9zFyMnWNH0cxuhEhsYJY52/2WGcH4xSkzd
        384IUsUmYCjRe7QPzBYREJO4PacTrIhZoIVJYs7cpWCjhAUSJHZcbwWzWQRUJdbPmAJm8wrY
        SCyYc4QVYp28xPnedewgNidQ/NnCbywQNYISPybfA7OZgWoOXnnOArJAQuAIm8SJ/09YIJpd
        JNb+72KDsKUlnq3ayAhhV0vs2t7NDNHQwSjRcmE71HPWEoePX2SFmMon0XH4LzskZHglOtqE
        IEo8JCYuWQ71cj+jxNXVm5kmMErNQnLULCRHLWBkWsUollpQnJueWmxUYKxXnJhbXJqXrpec
        n7uJERznWu47GLed8znEKMDBqMTDu+JoUowQa2JZcWXuIUYJDmYlEd405uQYId6UxMqq1KL8
        +KLSnNTiQ4zSHCxK4rwPpedGCwmkJ5akZqemFqQWwWSZODilGhgjJhz+5eqXJJzMLaa9MCT8
        0lGxbVruX04GeKftmq/N8i1G5YXXjhXqmUbp8ua+d5iZH5vUb2lvz5G9Uro4+LD8vf963ToT
        XK8ctVeVSH3m2XwpKinS5o/crfgo/c+cUyc5zHV4H9KlL7z6kVuxx1V/4UUMbYaXfTeVvAqL
        v2CQmzP5D69zsRJLcUaioRZzUXEiAJJ2QrLvAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t9jQd2bXMkxBgv3m1pcuXiIyWLjjPWs
        FlMfPmGzOH9+A7vFtysdTBaXd81hs5hxfh+Txdojd9ktDr9pZ7W4uOILkwOXx4bPTWweO2fd
        ZffYtKqTzaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyvkxdx1pwRa+i//0P9gbGpWpdjJwc
        EgImEtPPbWTqYuTiEBJYxyhx7MJtZgjnF6PEkwPnWUCq2AQMJXqP9jGC2CICYhK353SCFTEL
        NDFJ7Lp9kb2LkYNDWCBBYvoJU5AaFgFVifUzpjCD2LwCNhIL5hxhhdgmL3G+dx07iM0JFH+2
        8BsLSKuQgLXElU22EOWCEj8m3wNbywxUfvDKc5YJjHyzkKRmIUktYGRaxSiZWlCcm55bbFRg
        lJdarlecmFtcmpeul5yfu4kRGMLbDmv172B8vCT+EKMAB6MSD++Ko0kxQqyJZcWVuYcYJTiY
        lUR405iTY4R4UxIrq1KL8uOLSnNSiw8xSnOwKInz8ucfixQSSE8sSc1OTS1ILYLJMnFwSjUw
        xsjfUlzlVNAYrSZ7LG32xkWB9o43VfPUGxIcagI7lkcuMzDd8IvbhiP13T0Pl/knLbfPKVgR
        HMHwzl/gaI3HulNzfC6mn/i3QKGwKN3ho+bHX5ossy3FpgTf+nzdNPZ79LoHWcEbVrLFabuf
        /K9yqUf53tyn3zzv/d8oFVxtZLDWReJOR7uiEktxRqKhFnNRcSIAlJzz4F0CAAA=
X-CMS-MailID: 20190212180513epcas2p128eae26df9eef86550a4f628afd12603
CMS-TYPE: 102P
X-CMS-RootMailID: 20190212180513epcas2p128eae26df9eef86550a4f628afd12603
References: <20190212180342.32040-1-s.nawrocki@samsung.com>
        <CGME20190212180513epcas2p128eae26df9eef86550a4f628afd12603@epcas2p1.samsung.com>
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
 sound/soc/samsung/i2s.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 8352f610ce35..14d9fd658cfd 100644
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

