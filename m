Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20105C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5762229F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BvOcpNFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730944AbfBLSGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:06:47 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:59155 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731336AbfBLSE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:04:56 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190212180453epoutp0329e053f933681489a382eb301d098490~Cr-Yhs3Fu2783327833epoutp03b;
        Tue, 12 Feb 2019 18:04:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190212180453epoutp0329e053f933681489a382eb301d098490~Cr-Yhs3Fu2783327833epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549994693;
        bh=TtQx0G720ISMtzrhrffDlH6r+gc+72B0lf9feRyYaAs=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=BvOcpNFDVnOmvbBY7RTDQqZ824Svh3JrXr86sEH1Uw4IwCZO76Uz+sgweEhEf+MyA
         zZM43uKg0syIj/mE1m/QO7lAPJm0VLll35rQMwUFn98pRqrmhUuETqXp/Tdgip9yaU
         w/Gn35tUYwrY0KvpECHagbILxapnEqnZQ3cofPKo=
Received: from epsmges2p3.samsung.com (unknown [182.195.42.71]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190212180452epcas2p205583b1d6554d72f891e3bf7e512ac73~Cr-YA-_6T2848628486epcas2p2J;
        Tue, 12 Feb 2019 18:04:52 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.29.04134.4CA036C5; Wed, 13 Feb 2019 03:04:52 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190212180452epcas2p2f162435a99743c654320219dd25f880b~Cr-XqWIZo1862418624epcas2p2E;
        Tue, 12 Feb 2019 18:04:52 +0000 (GMT)
X-AuditID: b6c32a47-8abff70000001026-46-5c630ac4d149
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 87.30.03689.4CA036C5; Wed, 13 Feb
        2019 03:04:52 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMT0024XRJ2FB10@mmp2.samsung.com>; Wed, 13 Feb 2019
        03:04:52 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 04/21] ASoC: samsung: i2s: Move core clk to the driver
 common data structure
Date:   Tue, 12 Feb 2019 19:03:25 +0100
Message-id: <20190212180342.32040-5-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190212180342.32040-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7bCmue4RruQYg0cHjSyuXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZWxbMYynolq9Y/vUQUwPjBckuRg4O
        CQETiaYbWV2MXBxCAjsYJTa9+cIC4XxnlLgw5xZjFyMnWFHrsnlsEIkNjBKz/vxhh3B+MUoc
        WvWVGaSKTcBQovdoH1iHiICYxO05ncwgRcwCLUwSc+YuBSsSFkiU+Lb6DiPIbhYBVYnGOW4g
        YV4Ba4k1ve+htslLnO9dxw5icwrYSDxb+I0FokZQ4sfke2A2M1DNwSvPwU6VEDjCJtE37ygL
        RLOLxNamx0wQtrTEs1UboYZWS+za3s0M0dDBKNFyYTszRMJa4vDxi6wQU/kkOg7/ZYcEDK9E
        R5sQRImHxL5FX6De72eU+HH/KssERqlZSI6aheSoBYxMqxjFUguKc9NTi40KjPWKE3OLS/PS
        9ZLzczcxgqNcy30H47ZzPocYBTgYlXh4VxxNihFiTSwrrsw9xCjBwawkwpvGnBwjxJuSWFmV
        WpQfX1Sak1p8iFGag0VJnPeh9NxoIYH0xJLU7NTUgtQimCwTB6dUA+O0F84MjK7dtyvTtScW
        Ol2Z/ENoeebMDfkxnPwpcZ6hKheMtz+8vXrrlRUrghLyG1SWrbd+9rdlnvfe+D5HJn6ttZeV
        txTMyMu/5r3m1V4LsQfhgt+KajiOL5x5jMen7aXV4pIjywqUp/dGVimtWnLgeuIBO6N2tU1N
        x0NjAh8Zvyv8t2m1/y4lluKMREMt5qLiRAD1UHxZ7gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsVy+t9jQd0jXMkxBvu7ZC2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZWxbMYynolq9Y/vUQUwPjBckuRk4O
        CQETidZl89hAbCGBdYwSzYuTuhi5gOxfjBILPs9mBkmwCRhK9B7tYwSxRQTEJG7P6WQGKWIW
        aGKS2HX7IjtIQlggUeLb6jtARRwcLAKqEo1z3EDCvALWEmt63zNCLJOXON+7DqycU8BG4tnC
        bywg5UJANVc22UKUC0r8mHyPBcRmBio/eOU5ywRGvllIUrOQpBYwMq1ilEwtKM5Nzy02KjDK
        Sy3XK07MLS7NS9dLzs/dxAgM4G2Htfp3MD5eEn+IUYCDUYmHd8XRpBgh1sSy4srcQ4wSHMxK
        IrxpzMkxQrwpiZVVqUX58UWlOanFhxilOViUxHn5849FCgmkJ5akZqemFqQWwWSZODilGhiz
        szI75rXYfn8nvV99YyyDltyGw9OXuj9/2ly9w+3Yv4Cjx8Wu3u+8W+mwrNk4Qqj5te6XsHVT
        a459lc9NXbosjW2tvvWfXu15jdpRz+aYfVjmeGtn16SGmy3TghafmniEp63Y7YRS/nzfSgMN
        uQWz/DflefYpuW9s52+YVRfuollacnOzXKoSS3FGoqEWc1FxIgCvNKfIXAIAAA==
X-CMS-MailID: 20190212180452epcas2p2f162435a99743c654320219dd25f880b
CMS-TYPE: 102P
X-CMS-RootMailID: 20190212180452epcas2p2f162435a99743c654320219dd25f880b
References: <20190212180342.32040-1-s.nawrocki@samsung.com>
        <CGME20190212180452epcas2p2f162435a99743c654320219dd25f880b@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core clock is also common for both CPU DAIs so move it to
the driver's private data structure.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/i2s.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 29bcfca20572..159c19fdb662 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -71,8 +71,6 @@ struct i2s_dai {
 	 * 0 indicates CPU driver is free to choose any value.
 	 */
 	unsigned rfs, bfs;
-	/* I2S Controller's core clock */
-	struct clk *clk;
 	/* Clock for generating I2S signals */
 	struct clk *op_clk;
 	/* Pointer to the Primary_Fifo if this is Sec_Fifo, NULL otherwise */
@@ -117,6 +115,9 @@ struct samsung_i2s_priv {
 	struct snd_soc_dai_driver *dai_drv;
 	int num_dais;
 
+	/* The I2S controller's core clock */
+	struct clk *clk;
+
 	/* The clock provider's data */
 	struct clk *clk_table[3];
 	struct clk_onecell_data clk_data;
@@ -1205,6 +1206,7 @@ static int i2s_alloc_dais(struct samsung_i2s_priv *priv,
 #ifdef CONFIG_PM
 static int i2s_runtime_suspend(struct device *dev)
 {
+	struct samsung_i2s_priv *priv = dev_get_drvdata(dev);
 	struct i2s_dai *i2s = samsung_i2s_get_pri_dai(dev);
 
 	i2s->suspend_i2smod = readl(i2s->addr + I2SMOD);
@@ -1213,24 +1215,25 @@ static int i2s_runtime_suspend(struct device *dev)
 
 	if (i2s->op_clk)
 		clk_disable_unprepare(i2s->op_clk);
-	clk_disable_unprepare(i2s->clk);
+	clk_disable_unprepare(priv->clk);
 
 	return 0;
 }
 
 static int i2s_runtime_resume(struct device *dev)
 {
+	struct samsung_i2s_priv *priv = dev_get_drvdata(dev);
 	struct i2s_dai *i2s = samsung_i2s_get_pri_dai(dev);
 	int ret;
 
-	ret = clk_prepare_enable(i2s->clk);
+	ret = clk_prepare_enable(priv->clk);
 	if (ret)
 		return ret;
 
 	if (i2s->op_clk) {
 		ret = clk_prepare_enable(i2s->op_clk);
 		if (ret) {
-			clk_disable_unprepare(i2s->clk);
+			clk_disable_unprepare(priv->clk);
 			return ret;
 		}
 	}
@@ -1428,13 +1431,13 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 
 	regs_base = res->start;
 
-	pri_dai->clk = devm_clk_get(&pdev->dev, "iis");
-	if (IS_ERR(pri_dai->clk)) {
+	priv->clk = devm_clk_get(&pdev->dev, "iis");
+	if (IS_ERR(priv->clk)) {
 		dev_err(&pdev->dev, "Failed to get iis clock\n");
-		return PTR_ERR(pri_dai->clk);
+		return PTR_ERR(priv->clk);
 	}
 
-	ret = clk_prepare_enable(pri_dai->clk);
+	ret = clk_prepare_enable(priv->clk);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "failed to enable clock: %d\n", ret);
 		return ret;
@@ -1472,7 +1475,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 
 		sec_dai->dma_playback.addr_width = 4;
 		sec_dai->addr = pri_dai->addr;
-		sec_dai->clk = pri_dai->clk;
 		sec_dai->quirks = quirks;
 		sec_dai->idma_playback.addr = idma_addr;
 		sec_dai->pri_dai = pri_dai;
@@ -1519,7 +1521,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 err_disable_pm:
 	pm_runtime_disable(&pdev->dev);
 err_disable_clk:
-	clk_disable_unprepare(pri_dai->clk);
+	clk_disable_unprepare(priv->clk);
 	i2s_delete_secondary_device(priv);
 	return ret;
 }
@@ -1527,7 +1529,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 static int samsung_i2s_remove(struct platform_device *pdev)
 {
 	struct samsung_i2s_priv *priv = dev_get_drvdata(&pdev->dev);
-	struct i2s_dai *pri_dai = samsung_i2s_get_pri_dai(&pdev->dev);
 
 	/* The secondary device has no driver data assigned */
 	if (!priv)
@@ -1537,7 +1538,7 @@ static int samsung_i2s_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 
 	i2s_unregister_clock_provider(priv);
-	clk_disable_unprepare(pri_dai->clk);
+	clk_disable_unprepare(priv->clk);
 	pm_runtime_put_noidle(&pdev->dev);
 	i2s_delete_secondary_device(priv);
 
-- 
2.20.1

