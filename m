Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C1FC282CC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF8221904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kTFhFXY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfBGRBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:01:42 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:10869 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbfBGRBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:01:39 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190207170136epoutp04ba4ca1fad605a97f12946ecaaf90e9a5~BI5tJ7zkm0210902109epoutp04c;
        Thu,  7 Feb 2019 17:01:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190207170136epoutp04ba4ca1fad605a97f12946ecaaf90e9a5~BI5tJ7zkm0210902109epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549558896;
        bh=v0QYoUYQ1jkCiuyAyrRfcxHIWZM8fqjtDbainT6kzvQ=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=kTFhFXY9/k2lfwcQmRs4KpTrhR6TygT+KNnucZcOh/PU14kcLpgYMmUm1KNPgnW+o
         zEIC6LKCHDDTcPdOAN3XhuCvtaKV/9XEQzSV2dQbD4gIH1aErxoaF9XW3OQhY6yQn5
         xY3P4THovtRiyAvRmuFR9bYcIQeNhcZ0sNrfmNpc=
Received: from epsmges2p3.samsung.com (unknown [182.195.42.71]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190207170135epcas2p21e393f999ac0480e6f0a957825b89c57~BI5sCGNLQ1763817638epcas2p2U;
        Thu,  7 Feb 2019 17:01:35 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        70.07.04134.F646C5C5; Fri,  8 Feb 2019 02:01:35 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190207170134epcas2p1a22a5c2f680f33fe562fa22f3aec9e6a~BI5rO30nu2511325113epcas2p1L;
        Thu,  7 Feb 2019 17:01:34 +0000 (GMT)
X-AuditID: b6c32a47-8c3ff70000001026-76-5c5c646fe3b6
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.B8.03689.E646C5C5; Fri,  8 Feb 2019 02:01:34 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMK00MP9F8VXL10@mmp1.samsung.com>; Fri, 08 Feb 2019
        02:01:34 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 14/22] ASoC: samsung: i2s: Move IP variant data to common
 driver data structure
Date:   Thu, 07 Feb 2019 18:00:22 +0100
Message-id: <20190207170028.720-15-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190207170028.720-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsWy7bCmmW5+SkyMwcFFEhZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6Mm8/amAt2mFW8OvSBtYHxmU4XIyeH
        hICJxJw1P9i7GLk4hAR2MEpc3HGfDcL5zigxcedMIIcDrOrdaUOI+G5Gie+fv0B1/GKUODNx
        LiPIKDYBQ4neo31gtoiAmMTtOZ3MIEXMAi1MEnPmLmUGSQgLJEqsX/gNrIhFQFVi4qHZTCA2
        r4CVxPMNyxkhbpKXON+7jh3E5gSK39q/gwWiRlDix+R7YDYzUM3BK89ZQBZICBxhk7jYsI8F
        otlFYmnbHCYIW1ri2aqNUEOrJXZt72aGaOhglGi5sJ0ZImEtcfj4RVaIqXwSHYf/skP8zCvR
        0SYEUeIhseD7UxaIl3sZJZZ0f2SfwCg1C8lRs5ActYCRaRWjWGpBcW56arFRgbFecWJucWle
        ul5yfu4mRnCca7nvYNx2zucQowAHoxIP7wXtmBgh1sSy4srcQ4wSHMxKIryyCUAh3pTEyqrU
        ovz4otKc1OJDjNIcLErivA+l50YLCaQnlqRmp6YWpBbBZJk4OKUaGCfYPvB/vDDztrhB18zE
        //rRqznqplmelZ9wLM3UdqHjhZVrtk5SWML792KH2fmXdcFTJ/K96Ip4KffV41xowkax3LX2
        729zbn124JWMGAcz57crdlcPFu/9FteQf9n5smr6lUcZNZf0AxVXOyelHjN0u7Hydc/qgszr
        mkc5uQLuPjwxe4mFQ4cSS3FGoqEWc1FxIgBkyUtf7wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsVy+t9jAd28lJgYg7ZJChZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6Mm8/amAt2mFW8OvSBtYHxmU4XIweH
        hICJxLvThl2MXBxCAjsZJTaf+84G4fxilOi98Y25i5GTg03AUKL3aB8jiC0iICZxe04nM0gR
        s0ATk8Su2xfZQRLCAokS6xd+AytiEVCVmHhoNhOIzStgJfF8w3KwuISAvMT53nVg9ZxA8Vv7
        d7CA2EIClhIfJjSxQtQLSvyYfA8szgxUf/DKc5YJjHyzkKRmIUktYGRaxSiZWlCcm55bbFRg
        lJdarlecmFtcmpeul5yfu4kRGMTbDmv172B8vCT+EKMAB6MSD+8F7ZgYIdbEsuLK3EOMEhzM
        SiK8sglAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rz8+ccihQTSE0tSs1NTC1KLYLJMHJxSDYy8
        ZZuT/TK/h5U8bnsSXdBzL8Q1bU2ta9Q6XXnjA7KC9y1ZpvN/jfnatYDvOjvH9psHTl65/J91
        SryV4XSfvh7B+yJlzO8m8/m4C1yfx57+IWSOztKPymvULKaxes2c2ygeUVo8d9W3KapnpBr3
        K1UtLlgcYp0ozvbI9b9PnuouoUXq3RoHnyqxFGckGmoxFxUnAgC150j4XgIAAA==
X-CMS-MailID: 20190207170134epcas2p1a22a5c2f680f33fe562fa22f3aec9e6a
CMS-TYPE: 102P
X-CMS-RootMailID: 20190207170134epcas2p1a22a5c2f680f33fe562fa22f3aec9e6a
References: <20190207170028.720-1-s.nawrocki@samsung.com>
        <CGME20190207170134epcas2p1a22a5c2f680f33fe562fa22f3aec9e6a@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IP variant data is another thing common for both DAIs, move it
to the driver's common data structure.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c | 42 ++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index c7499e25ce2b..6ea0f0050fc8 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -85,7 +85,6 @@ struct i2s_dai {
 	struct snd_dmaengine_dai_dma_data idma_playback;
 	dma_filter_fn filter;
 	u32	quirks;
-	const struct samsung_i2s_variant_regs *variant_regs;
 
 	struct samsung_i2s_priv *priv;
 };
@@ -122,6 +121,8 @@ struct samsung_i2s_priv {
 	u32 suspend_i2scon;
 	u32 suspend_i2spsr;
 
+	const struct samsung_i2s_variant_regs *variant_regs;
+
 	/* The clock provider's data */
 	struct clk *clk_table[3];
 	struct clk_onecell_data clk_data;
@@ -146,7 +147,7 @@ static inline bool is_slave(struct i2s_dai *i2s)
 	struct samsung_i2s_priv *priv = i2s->priv;
 
 	u32 mod = readl(priv->addr + I2SMOD);
-	return (mod & (1 << i2s->variant_regs->mss_off)) ? true : false;
+	return (mod & (1 << priv->variant_regs->mss_off)) ? true : false;
 }
 
 /* If this interface of the controller is transmitting data */
@@ -261,8 +262,8 @@ static inline unsigned get_rfs(struct i2s_dai *i2s)
 	struct samsung_i2s_priv *priv = i2s->priv;
 	u32 rfs;
 
-	rfs = readl(priv->addr + I2SMOD) >> i2s->variant_regs->rfs_off;
-	rfs &= i2s->variant_regs->rfs_mask;
+	rfs = readl(priv->addr + I2SMOD) >> priv->variant_regs->rfs_off;
+	rfs &= priv->variant_regs->rfs_mask;
 
 	switch (rfs) {
 	case 7: return 192;
@@ -281,9 +282,9 @@ static inline void set_rfs(struct i2s_dai *i2s, unsigned rfs)
 {
 	struct samsung_i2s_priv *priv = i2s->priv;
 	u32 mod = readl(priv->addr + I2SMOD);
-	int rfs_shift = i2s->variant_regs->rfs_off;
+	int rfs_shift = priv->variant_regs->rfs_off;
 
-	mod &= ~(i2s->variant_regs->rfs_mask << rfs_shift);
+	mod &= ~(priv->variant_regs->rfs_mask << rfs_shift);
 
 	switch (rfs) {
 	case 192:
@@ -321,8 +322,8 @@ static inline unsigned get_bfs(struct i2s_dai *i2s)
 	struct samsung_i2s_priv *priv = i2s->priv;
 	u32 bfs;
 
-	bfs = readl(priv->addr + I2SMOD) >> i2s->variant_regs->bfs_off;
-	bfs &= i2s->variant_regs->bfs_mask;
+	bfs = readl(priv->addr + I2SMOD) >> priv->variant_regs->bfs_off;
+	bfs &= priv->variant_regs->bfs_mask;
 
 	switch (bfs) {
 	case 8: return 256;
@@ -343,7 +344,7 @@ static inline void set_bfs(struct i2s_dai *i2s, unsigned bfs)
 	struct samsung_i2s_priv *priv = i2s->priv;
 	u32 mod = readl(priv->addr + I2SMOD);
 	int tdm = i2s->quirks & QUIRK_SUPPORTS_TDM;
-	int bfs_shift = i2s->variant_regs->bfs_off;
+	int bfs_shift = priv->variant_regs->bfs_off;
 
 	/* Non-TDM I2S controllers do not support BCLK > 48 * FS */
 	if (!tdm && bfs > 48) {
@@ -351,7 +352,7 @@ static inline void set_bfs(struct i2s_dai *i2s, unsigned bfs)
 		return;
 	}
 
-	mod &= ~(i2s->variant_regs->bfs_mask << bfs_shift);
+	mod &= ~(priv->variant_regs->bfs_mask << bfs_shift);
 
 	switch (bfs) {
 	case 48:
@@ -408,7 +409,7 @@ static void i2s_txctrl(struct i2s_dai *i2s, int on)
 {
 	struct samsung_i2s_priv *priv = i2s->priv;
 	void __iomem *addr = priv->addr;
-	int txr_off = i2s->variant_regs->txr_off;
+	int txr_off = priv->variant_regs->txr_off;
 	u32 con = readl(addr + I2SCON);
 	u32 mod = readl(addr + I2SMOD) & ~(3 << txr_off);
 
@@ -459,7 +460,7 @@ static void i2s_rxctrl(struct i2s_dai *i2s, int on)
 {
 	struct samsung_i2s_priv *priv = i2s->priv;
 	void __iomem *addr = priv->addr;
-	int txr_off = i2s->variant_regs->txr_off;
+	int txr_off = priv->variant_regs->txr_off;
 	u32 con = readl(addr + I2SCON);
 	u32 mod = readl(addr + I2SMOD) & ~(3 << txr_off);
 
@@ -516,7 +517,7 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id, unsigned int rfs,
 	struct samsung_i2s_priv *priv = snd_soc_dai_get_drvdata(dai);
 	struct i2s_dai *i2s = to_info(dai);
 	struct i2s_dai *other = get_other_dai(i2s);
-	const struct samsung_i2s_variant_regs *i2s_regs = i2s->variant_regs;
+	const struct samsung_i2s_variant_regs *i2s_regs = priv->variant_regs;
 	unsigned int cdcon_mask = 1 << i2s_regs->cdclkcon_off;
 	unsigned int rsrc_mask = 1 << i2s_regs->rclksrc_off;
 	u32 mod, mask, val = 0;
@@ -644,9 +645,9 @@ static int i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	u32 mod, tmp = 0;
 	unsigned long flags;
 
-	lrp_shift = i2s->variant_regs->lrp_off;
-	sdf_shift = i2s->variant_regs->sdf_off;
-	mod_slave = 1 << i2s->variant_regs->mss_off;
+	lrp_shift = priv->variant_regs->lrp_off;
+	sdf_shift = priv->variant_regs->sdf_off;
+	mod_slave = 1 << priv->variant_regs->mss_off;
 
 	sdf_mask = MOD_SDF_MASK << sdf_shift;
 	lrp_rlow = MOD_LR_RLOW << lrp_shift;
@@ -1023,7 +1024,6 @@ i2s_delay(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 	struct i2s_dai *i2s = to_info(dai);
 	u32 reg = readl(priv->addr + I2SFIC);
 	snd_pcm_sframes_t delay;
-	const struct samsung_i2s_variant_regs *i2s_regs = i2s->variant_regs;
 
 	WARN_ON(!pm_runtime_active(dai->dev));
 
@@ -1032,7 +1032,7 @@ i2s_delay(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 	else if (is_secondary(i2s))
 		delay = FICS_TXCOUNT(readl(priv->addr + I2SFICS));
 	else
-		delay = (reg >> i2s_regs->ftx0cnt_off) & 0x7f;
+		delay = (reg >> priv->variant_regs->ftx0cnt_off) & 0x7f;
 
 	return delay;
 }
@@ -1280,7 +1280,7 @@ static int i2s_register_clock_provider(struct samsung_i2s_priv *priv)
 	const char *p_names[2] = { NULL };
 	struct device *dev = &priv->pdev->dev;
 	struct i2s_dai *i2s = samsung_i2s_get_pri_dai(dev);
-	const struct samsung_i2s_variant_regs *reg_info = i2s->variant_regs;
+	const struct samsung_i2s_variant_regs *reg_info = priv->variant_regs;
 	const char *i2s_clk_name[ARRAY_SIZE(i2s_clk_desc)];
 	struct clk *rclksrc;
 	int ret, i;
@@ -1399,6 +1399,8 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->variant_regs = i2s_dai_data->i2s_variant_regs;
+
 	quirks = np ? i2s_dai_data->quirks : i2s_pdata->type.quirks;
 	num_dais = (quirks & QUIRK_SEC_DAI) ? 2 : 1;
 	priv->pdev = pdev;
@@ -1457,7 +1459,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	pri_dai->dma_playback.addr_width = 4;
 	pri_dai->dma_capture.addr_width = 4;
 	pri_dai->quirks = quirks;
-	pri_dai->variant_regs = i2s_dai_data->i2s_variant_regs;
 	pri_dai->priv = priv;
 
 	if (quirks & QUIRK_PRI_6CHAN)
@@ -1471,7 +1472,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	if (quirks & QUIRK_SEC_DAI) {
 		sec_dai = &priv->dai[SAMSUNG_I2S_ID_SECONDARY - 1];
 
-		sec_dai->variant_regs = pri_dai->variant_regs;
 		sec_dai->dma_playback.addr = regs_base + I2STXDS;
 		sec_dai->dma_playback.chan_name = "tx-sec";
 
-- 
2.20.1

