Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB75C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085BC2229F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eNZ0A+/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbfBLSEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:04:50 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:22484 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbfBLSEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:04:48 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190212180446epoutp024a3e30da672a930af740052c1694967d~Cr-RxF-3d2786327863epoutp02y;
        Tue, 12 Feb 2019 18:04:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190212180446epoutp024a3e30da672a930af740052c1694967d~Cr-RxF-3d2786327863epoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549994686;
        bh=UQOGlCQYEWvdf5BnPLhNmIo2HtWFTdnXgP/0q22nlSc=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=eNZ0A+/t4z1xSGF/b++VECAXqv7BCzBxc8KwqmpZHWxYaaAzhGzfeDjW1CnG+nUDV
         89V2TYShs/hDPWCSC+ekoOSzEyKGdpnK62p/u4cq8pDLHu4plvnOhbsWW+89gZFVLg
         iSpEK0UW0TRGnmQkZywicDiTvfaQkcCENpdZGh5M=
Received: from epsmges1p5.samsung.com (unknown [182.195.42.57]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190212180445epcas1p42abef04ceac220271aa436a3ad64138c~Cr-RU8Lz-0414104141epcas1p4H;
        Tue, 12 Feb 2019 18:04:45 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        D6.7E.04206.DBA036C5; Wed, 13 Feb 2019 03:04:45 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190212180445epcas1p15aebbe7d7b11ce36f5d20c6534ba5903~Cr-RDOym11361213612epcas1p1t;
        Tue, 12 Feb 2019 18:04:45 +0000 (GMT)
X-AuditID: b6c32a39-d7dff7000000106e-b4-5c630abdf73a
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 70.11.04015.DBA036C5; Wed, 13 Feb
        2019 03:04:45 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMT0024XRJ2FB10@mmp2.samsung.com>; Wed, 13 Feb 2019
        03:04:45 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 02/21] ASoC: samsung: i2s: Move clk supplier data to
 common driver data structure
Date:   Tue, 12 Feb 2019 19:03:23 +0100
Message-id: <20190212180342.32040-3-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190212180342.32040-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsWy7bCmge5eruQYg7Xz1S2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZ/Q+nMxf8sqq43d3M1sD4w6CLkZND
        QsBE4srOyyxdjFwcQgI7GCU+7LvJBuF8Z5SY9PUGC0xV/9cN7BCJDSCJN8wQzi9GiYa7f5hA
        qtgEDCV6j/YxgtgiAmISt+d0ghUxC7QwScyZu5QZJCEskCZx8PhnVhCbRUBVYuK+i2AreAWs
        JTb+PwC1Tl7ifO86dhCbU8BG4tnCb1A1ghI/Jt8Ds5mBag5eeQ52uITAATaJpfs62SGaXST2
        HpkBtIADyJaWuHTUFiJcLbFrezczRH0Ho0TLhe3MEAlricPHL7JCDOWTePe1B6qXV6KjTQii
        xENi+evvUO/3M0r82rCCdQKj1CwkN81CctMCRqZVjGKpBcW56anFhgWmesWJucWleel6yfm5
        mxjBca5luYPx2DmfQ4wCHIxKPLwrjibFCLEmlhVX5h5ilOBgVhLhTWNOjhHiTUmsrEotyo8v
        Ks1JLT7EKM3BoiTOu97BOUZIID2xJDU7NbUgtQgmy8TBKdXAmHHgb1G4TP35amkW1r+cGVFH
        nxpPnm0VpcIoc7f6lvL+p5Z1yxgm5wcXdH/sWSDt9D3FaVbOpCKmLduuyNQwvUtntliRsjP5
        hsxprR/VUVKb+v/pfH6Uu1c98nfsU8F9Hc6W+pLXv2c+WRPTeIoh2zym0W+f06G9Z49fuPvb
        +abKV45nk3fHK7EUZyQaajEXFScCALPqkirvAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsVy+t9jQd29XMkxBtM/iVpcuXiIyWLjjPWs
        FlMfPmGzOH9+A7vFtysdTBaXd81hs5hxfh+Txdojd9ktDr9pZ7W4uOILkwOXx4bPTWweO2fd
        ZffYtKqTzaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgy+h9OZy74ZVVxu7uZrYHxh0EXIyeH
        hICJRP/XDexdjFwcQgLrGCVOT33HDOH8YpR42dzFBlLFJmAo0Xu0jxHEFhEQk7g9pxOsiFmg
        iUli1+2L7CAJYYE0iVeT1oM1sAioSkzcd5EFxOYVsJbY+P8AC8Q6eYnzvevA6jkFbCSeLfwG
        FOcA2mYtcWWTLUS5oMSPyffAypmByg9eec4ygZFvFpLULCSpBYxMqxglUwuKc9Nzi40KDPNS
        y/WKE3OLS/PS9ZLzczcxAoN422Gtvh2M95fEH2IU4GBU4uFdcTQpRog1say4MvcQowQHs5II
        bxpzcowQb0piZVVqUX58UWlOavEhRmkOFiVx3tt5xyKFBNITS1KzU1MLUotgskwcnFINjIqR
        RouF9KTL+KzkPgo+0dDbdUtx6T9uh6/sH9fN/nwq7zL35Gt+J09pMv1u6p6t8el4baKplJLF
        T7Yftb0GLKtKAmcGOywOrJn1NWLL72vJju2W79a9rTkrliq/19c+rDnsytbUy9IOxpG3t+2b
        7vM4lNWxY39F/twNtqtX173pr9Pu9/9wRYmlOCPRUIu5qDgRABrZfgZeAgAA
X-CMS-MailID: 20190212180445epcas1p15aebbe7d7b11ce36f5d20c6534ba5903
CMS-TYPE: 101P
X-CMS-RootMailID: 20190212180445epcas1p15aebbe7d7b11ce36f5d20c6534ba5903
References: <20190212180342.32040-1-s.nawrocki@samsung.com>
        <CGME20190212180445epcas1p15aebbe7d7b11ce36f5d20c6534ba5903@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having the clocks provider data in struct samsung_i2s_priv, i.e. per the I2S
controller instance, rather than per CPU DAI better models the hardware and
simplifies the code a little. The clock provider is common for both DAIs.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/i2s.c | 68 ++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 273620914471..fffc76ab60da 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -99,9 +99,7 @@ struct i2s_dai {
 
 	spinlock_t *lock;
 
-	/* Below fields are only valid if this is the primary FIFO */
-	struct clk *clk_table[3];
-	struct clk_onecell_data clk_data;
+	struct samsung_i2s_priv *priv;
 };
 
 /* Lock for cross i/f checks */
@@ -118,6 +116,10 @@ struct samsung_i2s_priv {
 	struct i2s_dai *dai;
 	struct snd_soc_dai_driver *dai_drv;
 	int num_dais;
+
+	/* The clock provider's data */
+	struct clk *clk_table[3];
+	struct clk_onecell_data clk_data;
 };
 
 struct i2s_dai *samsung_i2s_get_pri_dai(struct device *dev)
@@ -625,11 +627,10 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
 	return ret;
 }
 
-static int i2s_set_fmt(struct snd_soc_dai *dai,
-	unsigned int fmt)
+static int i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
+	struct samsung_i2s_priv *priv = snd_soc_dai_get_drvdata(dai);
 	struct i2s_dai *i2s = to_info(dai);
-	struct i2s_dai *other = get_other_dai(i2s);
 	int lrp_shift, sdf_shift, sdf_mask, lrp_rlow, mod_slave;
 	u32 mod, tmp = 0;
 	unsigned long flags;
@@ -687,8 +688,7 @@ static int i2s_set_fmt(struct snd_soc_dai *dai,
 		 * CLK_I2S_RCLK_SRC clock is not exposed so we ensure any
 		 * clock configuration assigned in DT is not overwritten.
 		 */
-		if (i2s->rclk_srcrate == 0 && i2s->clk_data.clks == NULL &&
-		    other->clk_data.clks == NULL)
+		if (i2s->rclk_srcrate == 0 && priv->clk_data.clks == NULL)
 			i2s_set_sysclk(dai, SAMSUNG_I2S_RCLKSRC_0,
 							0, SND_SOC_CLOCK_IN);
 		break;
@@ -725,8 +725,8 @@ static int i2s_set_fmt(struct snd_soc_dai *dai,
 static int i2s_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
+	struct samsung_i2s_priv *priv = snd_soc_dai_get_drvdata(dai);
 	struct i2s_dai *i2s = to_info(dai);
-	struct i2s_dai *other = get_other_dai(i2s);
 	u32 mod, mask = 0, val = 0;
 	struct clk *rclksrc;
 	unsigned long flags;
@@ -811,10 +811,7 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 
 	i2s->frmclk = params_rate(params);
 
-	rclksrc = i2s->clk_table[CLK_I2S_RCLK_SRC];
-	if (!rclksrc || IS_ERR(rclksrc))
-		rclksrc = other->clk_table[CLK_I2S_RCLK_SRC];
-
+	rclksrc = priv->clk_table[CLK_I2S_RCLK_SRC];
 	if (rclksrc && !IS_ERR(rclksrc))
 		i2s->rclk_srcrate = clk_get_rate(rclksrc);
 
@@ -1221,31 +1218,30 @@ static int i2s_runtime_resume(struct device *dev)
 }
 #endif /* CONFIG_PM */
 
-static void i2s_unregister_clocks(struct i2s_dai *i2s)
+static void i2s_unregister_clocks(struct samsung_i2s_priv *priv)
 {
 	int i;
 
-	for (i = 0; i < i2s->clk_data.clk_num; i++) {
-		if (!IS_ERR(i2s->clk_table[i]))
-			clk_unregister(i2s->clk_table[i]);
+	for (i = 0; i < priv->clk_data.clk_num; i++) {
+		if (!IS_ERR(priv->clk_table[i]))
+			clk_unregister(priv->clk_table[i]);
 	}
 }
 
-static void i2s_unregister_clock_provider(struct platform_device *pdev)
+static void i2s_unregister_clock_provider(struct samsung_i2s_priv *priv)
 {
-	struct i2s_dai *i2s = samsung_i2s_get_pri_dai(&pdev->dev);
-
-	of_clk_del_provider(pdev->dev.of_node);
-	i2s_unregister_clocks(i2s);
+	of_clk_del_provider(priv->pdev->dev.of_node);
+	i2s_unregister_clocks(priv);
 }
 
-static int i2s_register_clock_provider(struct platform_device *pdev)
+
+static int i2s_register_clock_provider(struct samsung_i2s_priv *priv)
 {
 
 	const char * const i2s_clk_desc[] = { "cdclk", "rclk_src", "prescaler" };
 	const char *clk_name[2] = { "i2s_opclk0", "i2s_opclk1" };
 	const char *p_names[2] = { NULL };
-	struct device *dev = &pdev->dev;
+	struct device *dev = &priv->pdev->dev;
 	struct i2s_dai *i2s = samsung_i2s_get_pri_dai(dev);
 	const struct samsung_i2s_variant_regs *reg_info = i2s->variant_regs;
 	const char *i2s_clk_name[ARRAY_SIZE(i2s_clk_desc)];
@@ -1277,37 +1273,37 @@ static int i2s_register_clock_provider(struct platform_device *pdev)
 		u32 val = readl(i2s->addr + I2SPSR);
 		writel(val | PSR_PSREN, i2s->addr + I2SPSR);
 
-		i2s->clk_table[CLK_I2S_RCLK_SRC] = clk_register_mux(dev,
+		priv->clk_table[CLK_I2S_RCLK_SRC] = clk_register_mux(dev,
 				i2s_clk_name[CLK_I2S_RCLK_SRC], p_names,
 				ARRAY_SIZE(p_names),
 				CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
 				i2s->addr + I2SMOD, reg_info->rclksrc_off,
 				1, 0, i2s->lock);
 
-		i2s->clk_table[CLK_I2S_RCLK_PSR] = clk_register_divider(dev,
+		priv->clk_table[CLK_I2S_RCLK_PSR] = clk_register_divider(dev,
 				i2s_clk_name[CLK_I2S_RCLK_PSR],
 				i2s_clk_name[CLK_I2S_RCLK_SRC],
 				CLK_SET_RATE_PARENT,
 				i2s->addr + I2SPSR, 8, 6, 0, i2s->lock);
 
 		p_names[0] = i2s_clk_name[CLK_I2S_RCLK_PSR];
-		i2s->clk_data.clk_num = 2;
+		priv->clk_data.clk_num = 2;
 	}
 
-	i2s->clk_table[CLK_I2S_CDCLK] = clk_register_gate(dev,
+	priv->clk_table[CLK_I2S_CDCLK] = clk_register_gate(dev,
 				i2s_clk_name[CLK_I2S_CDCLK], p_names[0],
 				CLK_SET_RATE_PARENT,
 				i2s->addr + I2SMOD, reg_info->cdclkcon_off,
 				CLK_GATE_SET_TO_DISABLE, i2s->lock);
 
-	i2s->clk_data.clk_num += 1;
-	i2s->clk_data.clks = i2s->clk_table;
+	priv->clk_data.clk_num += 1;
+	priv->clk_data.clks = priv->clk_table;
 
 	ret = of_clk_add_provider(dev->of_node, of_clk_src_onecell_get,
-				  &i2s->clk_data);
+				  &priv->clk_data);
 	if (ret < 0) {
 		dev_err(dev, "failed to add clock provider: %d\n", ret);
-		i2s_unregister_clocks(i2s);
+		i2s_unregister_clocks(priv);
 	}
 
 	return ret;
@@ -1426,6 +1422,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	pri_dai->dma_capture.addr_width = 4;
 	pri_dai->quirks = quirks;
 	pri_dai->variant_regs = i2s_dai_data->i2s_variant_regs;
+	pri_dai->priv = priv;
 
 	if (quirks & QUIRK_PRI_6CHAN)
 		pri_dai->drv->playback.channels_max = 6;
@@ -1454,6 +1451,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		sec_dai->quirks = quirks;
 		sec_dai->idma_playback.addr = idma_addr;
 		sec_dai->pri_dai = pri_dai;
+		sec_dai->priv = priv;
 		pri_dai->sec_dai = sec_dai;
 
 		ret = i2s_create_secondary_device(priv);
@@ -1485,11 +1483,11 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	ret = i2s_register_clock_provider(pdev);
+	ret = i2s_register_clock_provider(priv);
 	if (ret < 0)
 		goto err_disable_pm;
 
-	pri_dai->op_clk = clk_get_parent(pri_dai->clk_table[CLK_I2S_RCLK_SRC]);
+	pri_dai->op_clk = clk_get_parent(priv->clk_table[CLK_I2S_RCLK_SRC]);
 
 	return 0;
 
@@ -1513,7 +1511,7 @@ static int samsung_i2s_remove(struct platform_device *pdev)
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-	i2s_unregister_clock_provider(pdev);
+	i2s_unregister_clock_provider(priv);
 	clk_disable_unprepare(pri_dai->clk);
 	pm_runtime_put_noidle(&pdev->dev);
 	i2s_delete_secondary_device(priv);
-- 
2.20.1

