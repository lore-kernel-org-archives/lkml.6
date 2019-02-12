Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E33C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100322229F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gayUpsTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbfBLSEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:04:47 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:40073 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbfBLSEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:04:46 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190212180442epoutp014b59f453913bcb32b06d5f37974de684~Cr-OrSlqI1899118991epoutp01p;
        Tue, 12 Feb 2019 18:04:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190212180442epoutp014b59f453913bcb32b06d5f37974de684~Cr-OrSlqI1899118991epoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549994682;
        bh=q9Hr6cqUHu60VZm6oGMQa2TMYD/ekH2g/Wu0LvH9nUg=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=gayUpsTpezkR/nxSWb6Lz2rAQrc/BJ68I9bPaiSQi9xuZaHHslxzEB6WI4ALl/C0L
         uq0aiasA6QMrJ660Iaq0toW93PUf4PEEkFmf8XvpRCF2y6lGUbOOb/LGX5JTkqX9PY
         mKtC+9F/zSHo+g86kOGP4ASUc3zGvN71FUbSic7c=
Received: from epsmges2p4.samsung.com (unknown [182.195.42.72]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20190212180442epcas2p484a1e7a6cee09337b09c27c5c95f04a8~Cr-OInO4N3062430624epcas2p4k;
        Tue, 12 Feb 2019 18:04:42 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.1D.04093.ABA036C5; Wed, 13 Feb 2019 03:04:42 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190212180441epcas2p120393a84b851b38023d197ba2b0af820~Cr-NsegJo0768707687epcas2p1n;
        Tue, 12 Feb 2019 18:04:41 +0000 (GMT)
X-AuditID: b6c32a48-173ff70000000ffd-b6-5c630aba8ff9
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id A6.30.03689.9BA036C5; Wed, 13 Feb
        2019 03:04:41 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMT0024XRJ2FB10@mmp2.samsung.com>; Wed, 13 Feb 2019
        03:04:41 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 01/21] ASoC: samsung: i2s: Restore support for the
 secondary PCM
Date:   Tue, 12 Feb 2019 19:03:22 +0100
Message-id: <20190212180342.32040-2-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190212180342.32040-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsWy7bCmhe4uruQYgwUnuS2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZO6/xFXTKV8zf0cPUwLhFsouRk0NC
        wETiz/VVLF2MXBxCAjsYJTavucQIkhAS+M4o8eAiL0zRz9Ov2SGKNjBKLDt/gQnC+cUoMX/a
        dRaQKjYBQ4neo31g3SICYhK353QygxQxC7QwScyZuxTI4eAQFgiVePE5FKSGRUBV4u6la+wg
        Nq+AtcT+mx/YILbJS5zvXQcW5xSwkXi28BsLRI2gxI/J98BsZqCag1ees0DUH2GTuHC2CsJ2
        kZj4/gsThC0t8WzVRkYIu1pi1/ZusHskBDoYJVoubGeGSFhLHD5+kRViKJ9Ex+G/7CB3Sgjw
        SnS0CUGUeEisXbQB6uF+RomPK6+wTGCUmoXkpllIblrAyLSKUSy1oDg3PbXYqMBErzgxt7g0
        L10vOT93EyM4wrU8djAeOOdziFGAg1GJh3fF0aQYIdbEsuLK3EOMEhzMSiK8aczJMUK8KYmV
        ValF+fFFpTmpxYcYpTlYlMR5H0rPjRYSSE8sSc1OTS1ILYLJMnFwSjUwuoh8vjCrY7XzqR3p
        waevPfrKWV69QFsqo2b9lzv8x9TYbzeoFm9rMPf3vXLg6bxozdx3DzXFfs0+dsFFeovgX81M
        u33Xb9RdXFb2s/buNBHxasUX9e982Xc6nFMSnMDUL5J2jEXd9lfXyuA/F87tDnUSPrf/ReWT
        2HVchx1O1JafsGeYzHz1ixJLcUaioRZzUXEiAPYPuGLsAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t9jQd2dXMkxBl9f61lcuXiIyWLjjPWs
        FlMfPmGzOH9+A7vFtysdTBaXd81hs5hxfh+Txdojd9ktDr9pZ7W4uOILkwOXx4bPTWweO2fd
        ZffYtKqTzaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgydl7jK+iUr5i/o4epgXGLZBcjJ4eE
        gInEz9Ov2bsYuTiEBNYxSjyd3s8G4fxilHh/Zg0bSBWbgKFE79E+RhBbREBM4vacTmaQImaB
        JiaJXbcvsoMkhAVCJY6fesEEYrMIqErcvXQNLM4rYC2x/+YHNoh18hLne9eBxTkFbCSeLfzG
        0sXIAbTNWuLKJluIckGJH5PvsYDYzEDlB688Z5nAyDcLSWoWktQCRqZVjJKpBcW56bnFRgVG
        eanlesWJucWleel6yfm5mxiBIbztsFb/DsbHS+IPMQpwMCrx8K44mhQjxJpYVlyZe4hRgoNZ
        SYQ3jTk5Rog3JbGyKrUoP76oNCe1+BCjNAeLkjgvf/6xSCGB9MSS1OzU1ILUIpgsEwenVAPj
        kmMnf52NifddveuVsbnib8H0pzeLE5xdJ21Kiz7wbeaus6nC/57uTv/YOu/CzmKXCXMUdQ+V
        9S9d4rp399zMTucy83fn2uptIya9K1U4dEuweb98TPa8A9rSIvwcJ2zWRIvzuczcfdtuHdOc
        Hy+rE7bJb92z8oHMdq6w1TYbpJm6gtZ6XAu8pMRSnJFoqMVcVJwIAAkf+mJdAgAA
X-CMS-MailID: 20190212180441epcas2p120393a84b851b38023d197ba2b0af820
CMS-TYPE: 102P
X-CMS-RootMailID: 20190212180441epcas2p120393a84b851b38023d197ba2b0af820
References: <20190212180342.32040-1-s.nawrocki@samsung.com>
        <CGME20190212180441epcas2p120393a84b851b38023d197ba2b0af820@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces again registration of additional platform device as
we still need it for registering the secondary dmaengine PCM component.

This patch in most part is a revert of changes done in commit
be2c92eb64023e ("ASoC: samsung: i2s: Remove virtual device for secondary DAI")

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/i2s.c | 52 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 4bc3b181f1c2..273620914471 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -109,6 +109,7 @@ static DEFINE_SPINLOCK(lock);
 
 struct samsung_i2s_priv {
 	struct platform_device *pdev;
+	struct platform_device *pdev_sec;
 
 	/* Spinlock protecting access to the device's registers */
 	spinlock_t spinlock;
@@ -1312,6 +1313,34 @@ static int i2s_register_clock_provider(struct platform_device *pdev)
 	return ret;
 }
 
+/* Create platform device for the secondary PCM */
+static int i2s_create_secondary_device(struct samsung_i2s_priv *priv)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	pdev = platform_device_register_simple("samsung-i2s-sec", -1, NULL, 0);
+	if (!pdev)
+		return -ENOMEM;
+
+	ret = device_attach(&pdev->dev);
+	if (ret < 0) {
+		dev_info(&pdev->dev, "device_attach() failed\n");
+		return ret;
+	}
+
+	priv->pdev_sec = pdev;
+
+	return 0;
+}
+
+static void i2s_delete_secondary_device(struct samsung_i2s_priv *priv)
+{
+	if (priv->pdev_sec) {
+		platform_device_del(priv->pdev_sec);
+		priv->pdev_sec = NULL;
+	}
+}
 static int samsung_i2s_probe(struct platform_device *pdev)
 {
 	struct i2s_dai *pri_dai, *sec_dai = NULL;
@@ -1329,13 +1358,15 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		i2s_dai_data = (struct samsung_i2s_dai_data *)
 				platform_get_device_id(pdev)->driver_data;
 
+	/* Nothing to do if it is the secondary device probe */
+	if (!i2s_dai_data)
+		return 0;
+
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	quirks = np ? i2s_dai_data->quirks : i2s_pdata->type.quirks;
-	quirks &= ~(QUIRK_SEC_DAI | QUIRK_SUPPORTS_IDMA);
-
 	num_dais = (quirks & QUIRK_SEC_DAI) ? 2 : 1;
 	priv->pdev = pdev;
 
@@ -1425,8 +1456,13 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		sec_dai->pri_dai = pri_dai;
 		pri_dai->sec_dai = sec_dai;
 
-		ret = samsung_asoc_dma_platform_register(&pdev->dev,
-					sec_dai->filter, "tx-sec", NULL, NULL);
+		ret = i2s_create_secondary_device(priv);
+		if (ret < 0)
+			goto err_disable_clk;
+
+		ret = samsung_asoc_dma_platform_register(&priv->pdev_sec->dev,
+						sec_dai->filter, "tx-sec", NULL,
+						&pdev->dev);
 		if (ret < 0)
 			goto err_disable_clk;
 
@@ -1461,6 +1497,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 err_disable_clk:
 	clk_disable_unprepare(pri_dai->clk);
+	i2s_delete_secondary_device(priv);
 	return ret;
 }
 
@@ -1469,12 +1506,17 @@ static int samsung_i2s_remove(struct platform_device *pdev)
 	struct samsung_i2s_priv *priv = dev_get_drvdata(&pdev->dev);
 	struct i2s_dai *pri_dai = samsung_i2s_get_pri_dai(&pdev->dev);
 
+	/* The secondary device has no driver data assigned */
+	if (!priv)
+		return 0;
+
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	i2s_unregister_clock_provider(pdev);
 	clk_disable_unprepare(pri_dai->clk);
 	pm_runtime_put_noidle(&pdev->dev);
+	i2s_delete_secondary_device(priv);
 
 	return 0;
 }
@@ -1572,6 +1614,8 @@ static const struct platform_device_id samsung_i2s_driver_ids[] = {
 	{
 		.name           = "samsung-i2s",
 		.driver_data	= (kernel_ulong_t)&i2sv3_dai_type,
+	}, {
+		.name           = "samsung-i2s-sec",
 	},
 	{},
 };
-- 
2.20.1

