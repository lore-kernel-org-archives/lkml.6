Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9D9C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5B820811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NPj0M9VB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394190AbfBMSwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:52:47 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:52037 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405791AbfBMSnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:43:07 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190213184304epoutp048cf42929d68b2eab6115060a77513c5a~DAKAerebh2865528655epoutp04k;
        Wed, 13 Feb 2019 18:43:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190213184304epoutp048cf42929d68b2eab6115060a77513c5a~DAKAerebh2865528655epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550083384;
        bh=ksBuew1Xn57azxYCc3VjsmJS9DByah38YvNWRM7BLGs=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=NPj0M9VBEzJghpQhQQe2FhyikutSg/sbzC2g9cJSp+veRHJG+WpPNYA2fNMU4Lwms
         GsNPWjB3kgp/e6VGofTuaSisk7OhIb5SRld/+cRBmTNHOqa2K1+0QekeW4fvC+VGky
         rJDfv/wIEsuCSISQLb5qK0H3szfMbFQtMzUFGEhk=
Received: from epsmges2p1.samsung.com (unknown [182.195.42.69]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20190213184303epcas2p41ae12fc436d481c58bef136f68cce2cc~DAJ-zpBMM1561415614epcas2p4f;
        Wed, 13 Feb 2019 18:43:03 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.52.04138.735646C5; Thu, 14 Feb 2019 03:43:03 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190213184303epcas2p2d72076c025cac4b25bd7b4e77a71595c~DAJ-a_fo51965019650epcas2p2U;
        Wed, 13 Feb 2019 18:43:03 +0000 (GMT)
X-AuditID: b6c32a45-5f3ff7000000102a-a8-5c6465371b4f
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 25.ED.03689.735646C5; Thu, 14 Feb
        2019 03:43:03 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMV00HOONZ3WX60@mmp2.samsung.com>; Thu, 14 Feb 2019
        03:43:03 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 03/13] ASoC: samsung: i2s: Move IP variant data to common
 driver data structure
Date:   Wed, 13 Feb 2019 19:42:02 +0100
Message-id: <20190213184212.5473-4-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190213184212.5473-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWy7bCmqa55akqMwdp56hZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6MDx/WshS8NKtYuvgeewPjJN0uRk4O
        CQETiVWz57F2MXJxCAnsYJTY1LsUyvnOKPFi4VS2LkYOsKp509Qh4hsYJY6/OsAE4fxilPjY
        8J8RZBSbgKFE79E+MFtEQEzi9pxOZpAiZoEWJok5c5cygySEBVIkJk84wAZiswioSnyd9gXM
        5hWwkrh3dAcbxE3yEqs3HACr5xSwlvi39jk7yCAJgSVsEtM+32KEKHKRWDTpIlSDtMSzVRuh
        4tUSu7Z3M0M0dDBKtFzYzgyRsJY4fPwiK4jNLMAn0XH4LzvEb7wSHW1CEKaHxLdDoRCf9TFK
        HJ3TxzaBUWIBI8MqRrHUguLc9NRiowJDveLE3OLSvHS95PzcTYzgKNRy3cE445zPIUYBDkYl
        Ht4KoZQYIdbEsuLK3EOMEhzMSiK8elFAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryPpOdGCwmk
        J5akZqemFqQWwWSZODilGhhnFVsYGb3rlZhx7LmBm05hzKkZKxK23ii/9Ne465mK3MlN0+Rj
        D503nFTxlOu9r6y6vl96l3KMRkeJi02CmbVNQVE0n/eB+vuP+LdfmK4md3u2kGGXrUNbiZQJ
        a8iKg5PfbV7fvL1d7ozXxx2Jve2btzD/LSl7dsfwyjl/1d+vGp5uZje48E2JpTgj0VCLuag4
        EQBqhugAvgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsVy+t9jQV3z1JQYg19HeS2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZHz6sZSl4aVaxdPE99gbGSbpdjBwc
        EgImEvOmqXcxcnEICaxjlPhx7isjhPOLUeJMQxt7FyMnB5uAoUTv0T5GEFtEQEzi9pxOZpAi
        ZoEmJoldty+CFQkLpEhMnnCADcRmEVCV+DrtC5jNK2Alce/oDjBbQkBeYvWGA8wgNqeAtcS/
        tc/BeoWAaiZ+uMQ8gZFnASPDKkbJ1ILi3PTcYqMCo7zUcr3ixNzi0rx0veT83E2MwCDbdlir
        fwfj4yXxhxgFOBiVeHgrhFJihFgTy4orcw8xSnAwK4nw6kUBhXhTEiurUovy44tKc1KLDzFK
        c7AoifPy5x+LFBJITyxJzU5NLUgtgskycXBKNTBKJk+5qbgrg8nHc1EE66zb/6/2hvapsX6X
        UFi5U+nkmoprxzLfyYsJvFgguPyvTPF2M59pvy9p7WZvmCbu/qeh8Nh2tqlHudt2rNBTqcwp
        P9QcfTrKalacln6ufe+WRO0cz1+8qk5Cj3+lvjU7trHm6gHH6Y6hL06bSvvY655Lk/S4eWvL
        tFdKLMUZiYZazEXFiQAPkpnHLgIAAA==
X-CMS-MailID: 20190213184303epcas2p2d72076c025cac4b25bd7b4e77a71595c
CMS-TYPE: 102P
X-CMS-RootMailID: 20190213184303epcas2p2d72076c025cac4b25bd7b4e77a71595c
References: <20190213184212.5473-1-s.nawrocki@samsung.com>
        <CGME20190213184303epcas2p2d72076c025cac4b25bd7b4e77a71595c@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IP variant data is another thing common for both DAIs, move it
to the driver's common data structure.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/i2s.c | 42 ++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index cf8615e23879..0c4c4de8c7e9 100644
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
@@ -1281,7 +1281,7 @@ static int i2s_register_clock_provider(struct samsung_i2s_priv *priv)
 	const char *p_names[2] = { NULL };
 	struct device *dev = &priv->pdev->dev;
 	struct i2s_dai *i2s = samsung_i2s_get_pri_dai(dev);
-	const struct samsung_i2s_variant_regs *reg_info = i2s->variant_regs;
+	const struct samsung_i2s_variant_regs *reg_info = priv->variant_regs;
 	const char *i2s_clk_name[ARRAY_SIZE(i2s_clk_desc)];
 	struct clk *rclksrc;
 	int ret, i;
@@ -1400,6 +1400,8 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->variant_regs = i2s_dai_data->i2s_variant_regs;
+
 	quirks = np ? i2s_dai_data->quirks : i2s_pdata->type.quirks;
 	num_dais = (quirks & QUIRK_SEC_DAI) ? 2 : 1;
 	priv->pdev = pdev;
@@ -1458,7 +1460,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	pri_dai->dma_playback.addr_width = 4;
 	pri_dai->dma_capture.addr_width = 4;
 	pri_dai->quirks = quirks;
-	pri_dai->variant_regs = i2s_dai_data->i2s_variant_regs;
 	pri_dai->priv = priv;
 
 	if (quirks & QUIRK_PRI_6CHAN)
@@ -1472,7 +1473,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	if (quirks & QUIRK_SEC_DAI) {
 		sec_dai = &priv->dai[SAMSUNG_I2S_ID_SECONDARY - 1];
 
-		sec_dai->variant_regs = pri_dai->variant_regs;
 		sec_dai->dma_playback.addr = regs_base + I2STXDS;
 		sec_dai->dma_playback.chan_name = "tx-sec";
 
-- 
2.17.1

