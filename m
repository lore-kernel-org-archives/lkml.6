Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CC5C282CC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669BA21904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CZTtDFon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfBGRBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:01:12 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:46768 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfBGRBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:01:09 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190207170107epoutp021c9e3af31c8d7c6a8df41154925058e9~BI5RsihWr0530705307epoutp02E;
        Thu,  7 Feb 2019 17:01:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190207170107epoutp021c9e3af31c8d7c6a8df41154925058e9~BI5RsihWr0530705307epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549558867;
        bh=dxEYTg5/K1AIH5X9l7D1G8z1EL6NomawTiUu7irpU2s=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=CZTtDFonMxLzhzXLAHxadr7GHAJL+QW0l9vjoif7xer/sNmaX2pK3vRUZLMXiEEv+
         G8Ve20iXIxWPja5tkTYIFOmNPZ5+CJ7mxYVa+vj9zLlz/VdXResVbAH/mRBUinS4Zv
         u9qE3iSQYMixzHlSjWpN/sWXKL0iJoA2J7lEIH7I=
Received: from epsmges1p2.samsung.com (unknown [182.195.42.54]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190207170106epcas1p1e5677be9a5c65b3a72ab3c040f4e567f~BI5Q6IboC2372323723epcas1p1m;
        Thu,  7 Feb 2019 17:01:06 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.C9.04173.2546C5C5; Fri,  8 Feb 2019 02:01:06 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190207170105epcas1p3d4a1da9ae268f8e95b32fb499e5a1dad~BI5QNv2ih0868808688epcas1p3D;
        Thu,  7 Feb 2019 17:01:05 +0000 (GMT)
X-AuditID: b6c32a36-5c1ff7000000104d-14-5c5c64526a93
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.C8.04015.1546C5C5; Fri,  8 Feb 2019 02:01:05 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMK00MP9F8VXL10@mmp1.samsung.com>; Fri, 08 Feb 2019
        02:01:05 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 06/22] ASoC: samsung: i2s: Restore support for the secondary
 PCM
Date:   Thu, 07 Feb 2019 18:00:14 +0100
Message-id: <20190207170028.720-7-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190207170028.720-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsWy7bCmrm5QSkyMwafFfBZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6MAytesRRcl6s4df4JYwPjRMkuRk4O
        CQETiTOnHzB1MXJxCAnsYJR4fWMnC4TznVHi7M5ZzDBVe5/vgUrsZpS43HSFESQhJPCLUeJp
        oz2IzSZgKNF7tA8sLiIgJnF7TiczSAOzQAuTxJy5S4EcDg5hgSCJN6cdQWpYBFQlln9bBFbP
        K2ApseF0KxvEMnmJ873r2EFsTgEriVv7d7BA1AhK/Jh8D8xmBqo5eOU52EESAgfYJKY+nsMI
        0ewi8ejAGSaQXRIC0hKXjtpChKsldm3vZoao72CUaLmwHeoza4nDxy+yQgzlk3j3tYcVopdX
        oqNNCKLEQ2L9zHmMEM/3MkpMOLuRcQKj1CwkN81CctMCRqZVjGKpBcW56anFhgVGesWJucWl
        eel6yfm5mxjBMa5ltoNx0TmfQ4wCHIxKPLwaejExQqyJZcWVuYcYJTiYlUR4ZROAQrwpiZVV
        qUX58UWlOanFhxilOViUxHnXOzjHCAmkJ5akZqemFqQWwWSZODilGhgXWK9cUbaq4V2GtFvE
        JsdPjRfP1X3J1ZiY9EiX9ZquZ+D12ncPbiR0yjMtnMxXlhyx8NOOt6/ndn0P/bXhAPeiy+n+
        3EomPk7WE48+P8CS9ndyrkmu1pLy5q9ZfAt0Lt19fSWtTn5d/ARtm93F/8oPRWS6MJRPbX3o
        GqCVxZs0VfxVlsiVmUVKLMUZiYZazEXFiQC8n8p57QIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsVy+t9jAd3AlJgYg4k/FC2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZB1a8Yim4Lldx6vwTxgbGiZJdjJwc
        EgImEnuf72HpYuTiEBLYySix4N1UZgjnF6PEyztvGEGq2AQMJXqP9oHZIgJiErfndIIVMQs0
        MUnsun2RHSQhLBAg0bX3MBuIzSKgKrH82yKwBl4BS4kNp1vZINbJS5zvXQdWzylgJXFr/w4W
        EFsIqObDhCZWiHpBiR+T74HFmYHqD155zjKBkW8WktQsJKkFjEyrGCVTC4pz03OLjQoM81LL
        9YoTc4tL89L1kvNzNzECw3jbYa2+HYz3l8QfYhTgYFTi4b2gHRMjxJpYVlyZe4hRgoNZSYRX
        NgEoxJuSWFmVWpQfX1Sak1p8iFGag0VJnPd23rFIIYH0xJLU7NTUgtQimCwTB6dUA+O82ews
        05J/SgmI7tn/67M0x+PFvjYOHF7TG++VCd9tni83m3vZrZiF3/wXLAuUlsrfUdB3d97sXx+W
        bA3bW7DS8+2OKyULRF7Zmun1X+B2z5jj9G1p/7LAs492NMq9OfhCg/tC05UPc1Rqhbm5LI+8
        Wxcd/rzfgu3Pwg7xHwmhyZbacuICjveVWIozEg21mIuKEwEKVPxAXwIAAA==
X-CMS-MailID: 20190207170105epcas1p3d4a1da9ae268f8e95b32fb499e5a1dad
CMS-TYPE: 101P
X-CMS-RootMailID: 20190207170105epcas1p3d4a1da9ae268f8e95b32fb499e5a1dad
References: <20190207170028.720-1-s.nawrocki@samsung.com>
        <CGME20190207170105epcas1p3d4a1da9ae268f8e95b32fb499e5a1dad@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces again registration of additional platform device as
we still need it for registering the secondary dmaengine PCM component.

This patch in most part is a revert of changes done in commit
be2c92eb64023e ("ASoC: samsung: i2s: Remove virtual device for secondary DAI")

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c | 52 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 4bc3b181f1c2..994dcd4b01fb 100644
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
 
+	/* Nothing to do if it is the secondary device probing */
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
 
@@ -1469,12 +1506,16 @@ static int samsung_i2s_remove(struct platform_device *pdev)
 	struct samsung_i2s_priv *priv = dev_get_drvdata(&pdev->dev);
 	struct i2s_dai *pri_dai = samsung_i2s_get_pri_dai(&pdev->dev);
 
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
@@ -1573,6 +1614,9 @@ static const struct platform_device_id samsung_i2s_driver_ids[] = {
 		.name           = "samsung-i2s",
 		.driver_data	= (kernel_ulong_t)&i2sv3_dai_type,
 	},
+	{
+		.name           = "samsung-i2s-sec",
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(platform, samsung_i2s_driver_ids);
-- 
2.20.1

