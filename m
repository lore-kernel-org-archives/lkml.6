Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB12C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E9C2229F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pyVNB9z7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbfBLSFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:05:02 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:59163 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731359AbfBLSE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:04:59 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190212180456epoutp03b9c2b536d9694dab472d8e15174be555~Cr-by3lnn0209402094epoutp03w;
        Tue, 12 Feb 2019 18:04:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190212180456epoutp03b9c2b536d9694dab472d8e15174be555~Cr-by3lnn0209402094epoutp03w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549994696;
        bh=d+DjveLKWf8YjBTzYoyAj2aNg7G8jSisA+BE3p8Kh5E=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=pyVNB9z7MGBc0i8NzbOPt004YZCBzZYtx/n69EZ1CH7G+UicgnEibQ0qj/gF7ZTsu
         jjEb/3WOenSg3R5GuMKjdR4RsFV5piKjhdLCq0OAcF+rlDBaMFfDnWzL9s8Uo64vcX
         sRibATWvZZFf1TkcKIWvh0v7G4RK2dK028sZJZnQ=
Received: from epsmges1p4.samsung.com (unknown [182.195.42.56]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190212180456epcas1p2a45b4cc02a887cc6250a7c6a0437368e~Cr-bjn7Qt1433014330epcas1p2I;
        Tue, 12 Feb 2019 18:04:56 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.89.04288.8CA036C5; Wed, 13 Feb 2019 03:04:56 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190212180456epcas1p1fd8b2fb8101d4848e56911f16fa4ffef~Cr-bBEuil1881518815epcas1p1u;
        Tue, 12 Feb 2019 18:04:56 +0000 (GMT)
X-AuditID: b6c32a38-bf7ff700000010c0-fe-5c630ac85820
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id D1.11.04015.7CA036C5; Wed, 13 Feb
        2019 03:04:56 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMT0024XRJ2FB10@mmp2.samsung.com>; Wed, 13 Feb 2019
        03:04:55 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 05/21] ASoC: samsung: i2s: Move opclk data to common
 driver data structure
Date:   Tue, 12 Feb 2019 19:03:26 +0100
Message-id: <20190212180342.32040-6-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190212180342.32040-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsWy7bCmge4JruQYg4VTVCyuXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZU9ZIFsw0qdg/YylbA2ObZhcjJ4eE
        gInEz5OXmbsYuTiEBHYwSsxsn88O4XxnlGhY+4IVpurblwNQVRsYJQ6vPcMC4fxilNixdBE7
        SBWbgKFE79E+RhBbREBM4vacTrAOZoEWJok5c5cygySEBeIl5t1cDjSWg4NFQFWif60RSJhX
        wFpiwrm3UNvkJc73rgObySlgI/Fs4TcWiBpBiR+T74HZzEA1B688BztCQuAIm0Tnm4lQzS4S
        126+B5svISAtcemoLUS4WmLX9m5miPoORomWC9uZIRLWEoePX2SFGMon8e5rD1Qvr0RHmxBE
        iYfE8nkLoL7vZ5RY/eoD2wRGqVlIbpqF5KYFjEyrGMVSC4pz01OLDQtM9IoTc4tL89L1kvNz
        NzGCY1zLYgfjnnM+hxgFOBiVeHhXHE2KEWJNLCuuzD3EKMHBrCTCm8acHCPEm5JYWZValB9f
        VJqTWnyIUZqDRUmcd72Dc4yQQHpiSWp2ampBahFMlomDU6qBMehXnWhcwOVL9uy6C5olfjQb
        5k2ta/5TLH70bYjAEc2aT7dDf5p9V3qzc4L2w+Ctl4Lkl9qzPOW6on/5A5ftrZWNZverPgU8
        2R6641XcqfSfrvNO6HRxc9pPvJ0XI7nycZK/hMSvc+yibtbfr8QbrFgsNd8i3EZ1mvoLQVkd
        xQa98pQfs1amK7EUZyQaajEXFScCAEBGFZjtAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsVy+t9jQd0TXMkxBks/MVlcuXiIyWLjjPWs
        FlMfPmGzOH9+A7vFtysdTBaXd81hs5hxfh+Txdojd9ktDr9pZ7W4uOILkwOXx4bPTWweO2fd
        ZffYtKqTzaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgypqyRLJhpUrF/xlK2BsY2zS5GTg4J
        AROJb18OMHcxcnEICaxjlNh45TMbhPOLUeLCg/msIFVsAoYSvUf7GEFsEQExidtzOsE6mAWa
        mCR23b7IDpIQFoiXWHXiOVA3BweLgKpE/1ojkDCvgLXEhHNvWSG2yUuc710HVs4pYCPxbOE3
        FpByIaCaK5tsIcoFJX5MvscCYjMDlR+88pxlAiPfLCSpWUhSCxiZVjFKphYU56bnFhsVGOal
        lusVJ+YWl+al6yXn525iBAbwtsNafTsY7y+JP8QowMGoxMO74mhSjBBrYllxZe4hRgkOZiUR
        3jTm5Bgh3pTEyqrUovz4otKc1OJDjNIcLErivLfzjkUKCaQnlqRmp6YWpBbBZJk4OKUaGJP+
        r1x/I7fJb9KN3k9R+4xMuueWn5WYNsu8rvjhJb6ERRyLLvh/K35gt/SBrvzl7enp2tU/p920
        ODbtS/MvBoay/siv1yeU6GYxnHwYyP13wt2la9ZGL/3xTyRCTfjL0uRL5hU7WBTMe80bgh12
        XZzb43ukQfb08eVbFOYn/E2fpmk74yLTXk8lluKMREMt5qLiRAAJf8CaXAIAAA==
X-CMS-MailID: 20190212180456epcas1p1fd8b2fb8101d4848e56911f16fa4ffef
CMS-TYPE: 101P
X-CMS-RootMailID: 20190212180456epcas1p1fd8b2fb8101d4848e56911f16fa4ffef
References: <20190212180342.32040-1-s.nawrocki@samsung.com>
        <CGME20190212180456epcas1p1fd8b2fb8101d4848e56911f16fa4ffef@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock for generating I2S signals is also common for both CPU DAIs
so move it to the driver's common data structure.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/i2s.c | 70 +++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 37 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 159c19fdb662..d8414d781f83 100644
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

