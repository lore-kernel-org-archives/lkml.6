Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF6AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB9B222DE
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="emK6wskJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502456AbfBNP66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:58:58 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:12320 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502420AbfBNP65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:58:57 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190214155853epoutp0461245df6397e8643e94cbcd59e9496a4~DRj8UjTYo2061620616epoutp04w;
        Thu, 14 Feb 2019 15:58:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190214155853epoutp0461245df6397e8643e94cbcd59e9496a4~DRj8UjTYo2061620616epoutp04w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550159933;
        bh=D/6KtpQJbwwepYVgXFPeDNMDDTG3w5VKj5hee7lC7y4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=emK6wskJqjwfY8RM9iNSfGfXV7tsSA6WNZQGizq/guvnI8eS6WaaOivjMZPt92oAw
         IKG0m9P4uvWDNbzD0pw2xmxKbDp8/JO0IOgUyNlFfCCnuFb4QBdX6jj6I3ULrRMB/q
         cx/ymjK536qi8VTjQfzfUvzppxmDoFEgRaeERzSw=
Received: from epsmges1p2.samsung.com (unknown [182.195.42.54]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190214155852epcas1p20118efd76b335aa6f802d506dd3156f4~DRj7zL31j0470004700epcas1p2Z;
        Thu, 14 Feb 2019 15:58:52 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CF.0B.04173.C30956C5; Fri, 15 Feb 2019 00:58:52 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190214155852epcas1p30dd461a0c14cadd70b487e908978ce3a~DRj7PStMr0453804538epcas1p30;
        Thu, 14 Feb 2019 15:58:52 +0000 (GMT)
X-AuditID: b6c32a36-5d9ff7000000104d-1d-5c65903ca72e
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 00.D8.04015.C30956C5; Fri, 15 Feb
        2019 00:58:52 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMX0014OB1VOP10@mmp2.samsung.com>; Fri, 15 Feb 2019
        00:58:52 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] ASoC: samsung: i2s: Prevent potential NULL platform data
 dereference
Date:   Thu, 14 Feb 2019 16:58:40 +0100
Message-id: <20190214155840.3764-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhTX9dmQmqMwc0nphZXLh5ispj68Amb
        xfnzG9gtvl3pYLK4vGsOm8XhN+2sFhdXfGFyYPfY8LmJzWPnrLvsHptWdbJ59G1ZxejxeZNc
        AGsUl01Kak5mWWqRvl0CV8bye9OYCvZIVKz58ZaxgbFdpIuRk0NCwESi5VovWxcjF4eQwA5G
        ic6tK5ghnO+MEl9vH2XqYuQAq3rwzxwivoFRYvWzZywg3UICvxgldm9zALHZBAwleo/2MYLY
        IgJiErfndIINYhZYySixZd8mNpCEsEC4xN+zC5hBbBYBVYmJ7cvABvEKWEn8nX+LBeIkeYnV
        Gw6ANUsIfGWVONv6ng0i4SJxtfUSC8RF0hKXjtpChKsldm3vhqrvYJRoubCdGSJhLXH4+EVW
        EJtZgE/i3dceVoheXomONiGIEg+JTVO3MEI8EyvR/qmNfQKj+AJGhlWMYqkFxbnpqcWGBUZ6
        xYm5xaV56XrJ+bmbGMGxpGW2g3HROZ9DjAIcjEo8vCsyUmOEWBPLiitzDzFKcDArifC+6QEK
        8aYkVlalFuXHF5XmpBYfYpTmYFES513v4BwjJJCeWJKanZpakFoEk2Xi4JRqYNzR01VsprBi
        yZojmdsfHvgrt6jJoXtT9a3O48/eHIz8cev07b0b3HYrPnK7s+WkmEWS/vllL1h++14JWLbT
        sPO4k4C7/FT2HDOJfQoGWTne5a8r0gw45/Vlf43IuVJ3ZprNz7Il04+LnqmtZNlr2Xwh472W
        ko1bh7h0aqE178tZ1mtUfOvn31JiKc5INNRiLipOBAD7ERuFoQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCJMWRmVeSWpSXmKPExsVy+t9jQV2bCakxBq3zBS2uXDzEZDH14RM2
        i/PnN7BbfLvSwWRxedccNovDb9pZLS6u+MLkwO6x4XMTm8fOWXfZPTat6mTz6NuyitHj8ya5
        ANYoLpuU1JzMstQifbsErozl96YxFeyRqFjz4y1jA2O7SBcjB4eEgInEg3/mXYxcHEIC6xgl
        FrftY4RwfjFKrFrXy9bFyMnBJmAo0Xu0jxHEFhEQk7g9p5MZpIhZYCWjxJHvq8ASwgLhEn/P
        LmAGsVkEVCUmti9jAbF5Bawk/s6/BWZLCMhLrN5wgHkCI9cCRoZVjJKpBcW56bnFRgWGeanl
        esWJucWleel6yfm5mxiBYbHtsFbfDsb7S+IPMQpwMCrx8AakpcYIsSaWFVfmHmKU4GBWEuF9
        0wMU4k1JrKxKLcqPLyrNSS0+xCjNwaIkzns771ikkEB6YklqdmpqQWoRTJaJg1MK6P+ZdyMF
        Nv15+O7Y/28bjNfdv8wov3XOviC+EMa1E42m+n99+UfQ7U/6WZE9QX/qnGrWuOfPXX3VKs1r
        ZdcSE/a1jH+fvVN+vGP2kU+Tvzf+P9Of3plzYWXF3ai+V+WVu6du2XPITZuHc8PC3Uafyg95
        37TSaJWbfUdPRjVv24c8W6VJcwXWrq5WYinOSDTUYi4qTgQAdFcMuAcCAAA=
X-CMS-MailID: 20190214155852epcas1p30dd461a0c14cadd70b487e908978ce3a
CMS-TYPE: 101P
X-CMS-RootMailID: 20190214155852epcas1p30dd461a0c14cadd70b487e908978ce3a
References: <CGME20190214155852epcas1p30dd461a0c14cadd70b487e908978ce3a@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When np is NULL i2s_pdata could also be NULL but i2s_pdata is now being
dereferenced without proper check. Fix this and shorten the error message
so we don't exceed 80 characters limit.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 03fff1c657be..02472f576e17 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1369,7 +1369,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	struct i2s_dai *pri_dai, *sec_dai = NULL;
 	struct s3c_audio_pdata *i2s_pdata = pdev->dev.platform_data;
 	struct resource *res;
-	u32 regs_base, quirks = 0, idma_addr = 0;
+	u32 regs_base, idma_addr = 0;
 	struct device_node *np = pdev->dev.of_node;
 	const struct samsung_i2s_dai_data *i2s_dai_data;
 	int num_dais, ret;
@@ -1389,11 +1389,19 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	quirks = np ? i2s_dai_data->quirks : i2s_pdata->type.quirks;
-	num_dais = (quirks & QUIRK_SEC_DAI) ? 2 : 1;
+	if (np) {
+		priv->quirks = i2s_dai_data->quirks;
+	} else {
+		if (!i2s_pdata) {
+			dev_err(&pdev->dev, "Missing platform data\n");
+			return -EINVAL;
+		}
+		priv->quirks = i2s_pdata->type.quirks;
+	}
+
+	num_dais = (priv->quirks & QUIRK_SEC_DAI) ? 2 : 1;
 	priv->pdev = pdev;
 	priv->variant_regs = i2s_dai_data->i2s_variant_regs;
-	priv->quirks = quirks;
 
 	ret = i2s_alloc_dais(priv, i2s_dai_data, num_dais);
 	if (ret < 0)
@@ -1405,11 +1413,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	spin_lock_init(&priv->pcm_lock);
 
 	if (!np) {
-		if (i2s_pdata == NULL) {
-			dev_err(&pdev->dev, "Can't work without s3c_audio_pdata\n");
-			return -EINVAL;
-		}
-
 		pri_dai->dma_playback.filter_data = i2s_pdata->dma_playback;
 		pri_dai->dma_capture.filter_data = i2s_pdata->dma_capture;
 		pri_dai->filter = i2s_pdata->dma_filter;
@@ -1418,7 +1421,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	} else {
 		if (of_property_read_u32(np, "samsung,idma-addr",
 					 &idma_addr)) {
-			if (quirks & QUIRK_SUPPORTS_IDMA) {
+			if (priv->quirks & QUIRK_SUPPORTS_IDMA) {
 				dev_info(&pdev->dev, "idma address is not"\
 						"specified");
 			}
@@ -1451,7 +1454,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	pri_dai->dma_capture.addr_width = 4;
 	pri_dai->priv = priv;
 
-	if (quirks & QUIRK_PRI_6CHAN)
+	if (priv->quirks & QUIRK_PRI_6CHAN)
 		pri_dai->drv->playback.channels_max = 6;
 
 	ret = samsung_asoc_dma_platform_register(&pdev->dev, pri_dai->filter,
@@ -1459,7 +1462,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_disable_clk;
 
-	if (quirks & QUIRK_SEC_DAI) {
+	if (priv->quirks & QUIRK_SEC_DAI) {
 		sec_dai = &priv->dai[SAMSUNG_I2S_ID_SECONDARY - 1];
 
 		sec_dai->dma_playback.addr = regs_base + I2STXDS;
-- 
2.17.1

