Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49E9C282CC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F90A21904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rggbw4qQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfBGRBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:01:31 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:32062 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfBGRBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:01:25 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190207170122epoutp032a275b698f5659fd34cfd70816516f68~BI5fjFAy32488224882epoutp03i;
        Thu,  7 Feb 2019 17:01:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190207170122epoutp032a275b698f5659fd34cfd70816516f68~BI5fjFAy32488224882epoutp03i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549558882;
        bh=KLf79dZGUrO4MgsvODSE+uPK6XDnEMuXGHQ2YhzjbMw=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=rggbw4qQK5u9Qw+hzcifsulfot0ArWzezx78pSZnXJxOxV8rRnfu383hloIc/bT26
         pfi8yK7j574LUHkkj7Wc3La1zOsdik7LG1FweSKP5LnJRK8ltKFfKT7J36Ou1KWomh
         465U6mNrlU3Atc5BF7vDDpF5EHTuU/wa5w1eFb/c=
Received: from epsmges1p3.samsung.com (unknown [182.195.42.55]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190207170120epcas1p2831e8888b5c6fcc3f7a110f8b330cb2e~BI5ebKfRm3249332493epcas1p2G;
        Thu,  7 Feb 2019 17:01:20 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.D7.04069.0646C5C5; Fri,  8 Feb 2019 02:01:20 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190207170120epcas1p211e1582a6124d6b7d0e33db6c0017480~BI5d5-49B1779017790epcas1p2i;
        Thu,  7 Feb 2019 17:01:20 +0000 (GMT)
X-AuditID: b6c32a37-971ff70000000fe5-40-5c5c6460a331
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.C8.04015.0646C5C5; Fri,  8 Feb 2019 02:01:20 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMK00MP9F8VXL10@mmp1.samsung.com>; Fri, 08 Feb 2019
        02:01:20 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 10/22] ASoC: samsung: i2s: Move opclk data to common driver
 data structure
Date:   Thu, 07 Feb 2019 18:00:18 +0100
Message-id: <20190207170028.720-11-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190207170028.720-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsWy7bCmrm5CSkyMwa77+hZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6MnR++sRe8MK54cPM6cwPjLY0uRk4O
        CQETidsPpzF1MXJxCAnsYJS4vGkGO4TznVFiyfd37DBV2zdegkrsZpRo+bOYBcL5xShx99Iq
        NpAqNgFDid6jfYwgtoiAmMTtOZ3MIEXMAi1MEnPmLmUGSQgLxEjMW36DCcRmEVCVaL+wmxXE
        5hWwkjiwcBUTxDp5ifO968BWcwLFb+3fwQJRIyjxY/I9MJsZqObgledgV0gIHGCT+ND1hxGi
        2UXi45bXQMs4gGxpiUtHbSHC1RK7tnczQ9R3AL1wYTszRMJa4vDxi6wQQ/kk3n3tYYXo5ZXo
        aBOCKPGQmHq2HerjXkaJTV8+skxglJqF5KZZSG5awMi0ilEstaA4Nz212LDAWK84Mbe4NC9d
        Lzk/dxMjOM61zHcwbjjnc4hRgINRiYdXQy8mRog1say4MvcQowQHs5IIr2wCUIg3JbGyKrUo
        P76oNCe1+BCjNAeLkjjvegfnGCGB9MSS1OzU1ILUIpgsEwenVANjZvuKvv91PsXO3tserVFQ
        4Zmt7Dn/J59q5O/+rh0fTOIfShq+nxgT2p/ttd92SvPVW0/W5hz1sGe77xTP6S+ZJ7/L/q+r
        fVNi0bO6C2fjV7dN9dbgndQ7/+6lOwdvvlDz2f3H+YfStZUHGZ+zyU2WUgwuzpwt8TXcb9G+
        kAlevPxZ11KWrk1QYinOSDTUYi4qTgQA0EclnO8CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsVy+t9jAd2ElJgYgz23+C2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZOz98Yy94YVzx4OZ15gbGWxpdjJwc
        EgImEts3XmLvYuTiEBLYySgx8+V/RpCEkMAvRomj2+pBbDYBQ4neo31gcREBMYnbczqZQRqY
        BZqYJHbdvsgOkhAWiJGYt/wGE4jNIqAq0X5hNyuIzStgJXFg4SomiG3yEud714HVcwLFb+3f
        wQKxzFLiw4QmqHpBiR+T74HFmYHqD155zjKBkW8WktQsJKkFjEyrGCVTC4pz03OLjQoM81LL
        9YoTc4tL89L1kvNzNzECg3jbYa2+HYz3l8QfYhTgYFTi4b2gHRMjxJpYVlyZe4hRgoNZSYRX
        NgEoxJuSWFmVWpQfX1Sak1p8iFGag0VJnPd23rFIIYH0xJLU7NTUgtQimCwTB6dUA+NGs7vb
        dp5Uiz8mLnJASbeX01+f3edmd/czLeU1F5sKHB4duryw6/1ML7c4TeX+HfrTFq/tUE7zmn/7
        dXvr3YkhSYbss7Xf3TX6G/rkyMniK0GTpjO9ct4Xv1l3/qrQ/Za6M/rfvumTDY92jOpM2OVu
        6cB6bp5Lza7ilQ763DemHS18/Ljtt4YSS3FGoqEWc1FxIgAli4MWXgIAAA==
X-CMS-MailID: 20190207170120epcas1p211e1582a6124d6b7d0e33db6c0017480
CMS-TYPE: 101P
X-CMS-RootMailID: 20190207170120epcas1p211e1582a6124d6b7d0e33db6c0017480
References: <20190207170028.720-1-s.nawrocki@samsung.com>
        <CGME20190207170120epcas1p211e1582a6124d6b7d0e33db6c0017480@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock for generating I2S signals is also common for both CPU DAIs
so move it to the driver's common data structure.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c | 70 +++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 37 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index c2c3a3286c63..b7b28813645a 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -62,8 +62,6 @@ struct i2s_dai {
 	struct platform_device *pdev;
 	/* Memory mapped SFR region */
 	void __iomem	*addr;
-	/* Rate of RCLK source clock */
-	unsigned long rclk_srcrate;
 	/* Frame Clock */
 	unsigned frmclk;
 	/*
@@ -71,8 +69,6 @@ struct i2s_dai {
 	 * 0 indicates CPU driver is free to choose any value.
 	 */
 	unsigned rfs, bfs;
-	/* Clock for generating I2S signals */
-	struct clk *op_clk;
 	/* Pointer to the Primary_Fifo if this is Sec_Fifo, NULL otherwise */
 	struct i2s_dai *pri_dai;
 	/* Pointer to the Secondary_Fifo if it has one, NULL otherwise */
@@ -118,6 +114,12 @@ struct samsung_i2s_priv {
 	/* The I2S controller's core clock */
 	struct clk *clk;
 
+	/* Clock for generating I2S signals */
+	struct clk *op_clk;
+
+	/* Rate of RCLK source clock */
+	unsigned long rclk_srcrate;
+
 	/* The clock provider's data */
 	struct clk *clk_table[3];
 	struct clk_onecell_data clk_data;
@@ -496,9 +498,10 @@ static inline void i2s_fifo(struct i2s_dai *i2s, u32 flush)
 	writel(readl(fic) & ~flush, fic);
 }
 
-static int i2s_set_sysclk(struct snd_soc_dai *dai,
-	  int clk_id, unsigned int rfs, int dir)
+static int i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id, unsigned int rfs,
+			  int dir)
 {
+	struct samsung_i2s_priv *priv = snd_soc_dai_get_drvdata(dai);
 	struct i2s_dai *i2s = to_info(dai);
 	struct i2s_dai *other = get_other_dai(i2s);
 	const struct samsung_i2s_variant_regs *i2s_regs = i2s->variant_regs;
@@ -554,44 +557,39 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
 			clk_id = 1;
 
 		if (!any_active(i2s)) {
-			if (i2s->op_clk && !IS_ERR(i2s->op_clk)) {
+			if (priv->op_clk && !IS_ERR(priv->op_clk)) {
 				if ((clk_id && !(mod & rsrc_mask)) ||
 					(!clk_id && (mod & rsrc_mask))) {
-					clk_disable_unprepare(i2s->op_clk);
-					clk_put(i2s->op_clk);
+					clk_disable_unprepare(priv->op_clk);
+					clk_put(priv->op_clk);
 				} else {
-					i2s->rclk_srcrate =
-						clk_get_rate(i2s->op_clk);
+					priv->rclk_srcrate =
+						clk_get_rate(priv->op_clk);
 					goto done;
 				}
 			}
 
 			if (clk_id)
-				i2s->op_clk = clk_get(&i2s->pdev->dev,
+				priv->op_clk = clk_get(&i2s->pdev->dev,
 						"i2s_opclk1");
 			else
-				i2s->op_clk = clk_get(&i2s->pdev->dev,
+				priv->op_clk = clk_get(&i2s->pdev->dev,
 						"i2s_opclk0");
 
-			if (WARN_ON(IS_ERR(i2s->op_clk))) {
-				ret = PTR_ERR(i2s->op_clk);
-				i2s->op_clk = NULL;
+			if (WARN_ON(IS_ERR(priv->op_clk))) {
+				ret = PTR_ERR(priv->op_clk);
+				priv->op_clk = NULL;
 				goto err;
 			}
 
-			ret = clk_prepare_enable(i2s->op_clk);
+			ret = clk_prepare_enable(priv->op_clk);
 			if (ret) {
-				clk_put(i2s->op_clk);
-				i2s->op_clk = NULL;
+				clk_put(priv->op_clk);
+				priv->op_clk = NULL;
 				goto err;
 			}
-			i2s->rclk_srcrate = clk_get_rate(i2s->op_clk);
+			priv->rclk_srcrate = clk_get_rate(priv->op_clk);
 
-			/* Over-ride the other's */
-			if (other) {
-				other->op_clk = i2s->op_clk;
-				other->rclk_srcrate = i2s->rclk_srcrate;
-			}
 		} else if ((!clk_id && (mod & rsrc_mask))
 				|| (clk_id && !(mod & rsrc_mask))) {
 			dev_err(&i2s->pdev->dev,
@@ -600,8 +598,6 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
 			goto err;
 		} else {
 			/* Call can't be on the active DAI */
-			i2s->op_clk = other->op_clk;
-			i2s->rclk_srcrate = other->rclk_srcrate;
 			goto done;
 		}
 
@@ -689,7 +685,7 @@ static int i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		 * CLK_I2S_RCLK_SRC clock is not exposed so we ensure any
 		 * clock configuration assigned in DT is not overwritten.
 		 */
-		if (i2s->rclk_srcrate == 0 && priv->clk_data.clks == NULL)
+		if (priv->rclk_srcrate == 0 && priv->clk_data.clks == NULL)
 			i2s_set_sysclk(dai, SAMSUNG_I2S_RCLKSRC_0,
 							0, SND_SOC_CLOCK_IN);
 		break;
@@ -814,7 +810,7 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 
 	rclksrc = priv->clk_table[CLK_I2S_RCLK_SRC];
 	if (rclksrc && !IS_ERR(rclksrc))
-		i2s->rclk_srcrate = clk_get_rate(rclksrc);
+		priv->rclk_srcrate = clk_get_rate(rclksrc);
 
 	return 0;
 }
@@ -872,6 +868,7 @@ static void i2s_shutdown(struct snd_pcm_substream *substream,
 
 static int config_setup(struct i2s_dai *i2s)
 {
+	struct samsung_i2s_priv *priv = i2s->priv;
 	struct i2s_dai *other = get_other_dai(i2s);
 	unsigned rfs, bfs, blc;
 	u32 psr;
@@ -920,11 +917,11 @@ static int config_setup(struct i2s_dai *i2s)
 		return 0;
 
 	if (!(i2s->quirks & QUIRK_NO_MUXPSR)) {
-		psr = i2s->rclk_srcrate / i2s->frmclk / rfs;
+		psr = priv->rclk_srcrate / i2s->frmclk / rfs;
 		writel(((psr - 1) << 8) | PSR_PSREN, i2s->addr + I2SPSR);
 		dev_dbg(&i2s->pdev->dev,
 			"RCLK_SRC=%luHz PSR=%u, RCLK=%dfs, BCLK=%dfs\n",
-				i2s->rclk_srcrate, psr, rfs, bfs);
+				priv->rclk_srcrate, psr, rfs, bfs);
 	}
 
 	return 0;
@@ -1067,7 +1064,6 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 	/* Reset any constraint on RFS and BFS */
 	i2s->rfs = 0;
 	i2s->bfs = 0;
-	i2s->rclk_srcrate = 0;
 
 	spin_lock_irqsave(i2s->lock, flags);
 	i2s_txctrl(i2s, 0);
@@ -1213,8 +1209,8 @@ static int i2s_runtime_suspend(struct device *dev)
 	i2s->suspend_i2scon = readl(i2s->addr + I2SCON);
 	i2s->suspend_i2spsr = readl(i2s->addr + I2SPSR);
 
-	if (i2s->op_clk)
-		clk_disable_unprepare(i2s->op_clk);
+	if (priv->op_clk)
+		clk_disable_unprepare(priv->op_clk);
 	clk_disable_unprepare(priv->clk);
 
 	return 0;
@@ -1230,8 +1226,8 @@ static int i2s_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (i2s->op_clk) {
-		ret = clk_prepare_enable(i2s->op_clk);
+	if (priv->op_clk) {
+		ret = clk_prepare_enable(priv->op_clk);
 		if (ret) {
 			clk_disable_unprepare(priv->clk);
 			return ret;
@@ -1514,7 +1510,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_disable_pm;
 
-	pri_dai->op_clk = clk_get_parent(priv->clk_table[CLK_I2S_RCLK_SRC]);
+	priv->op_clk = clk_get_parent(priv->clk_table[CLK_I2S_RCLK_SRC]);
 
 	return 0;
 
-- 
2.20.1

