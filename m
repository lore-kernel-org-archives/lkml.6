Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D99C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A97222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Xd7o8C0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbfBOOsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:48:33 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:15465 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfBOOsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:48:32 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190215144830epoutp0339442acc7a0b7860fc45261af8e0bff7~DkPx4OKqb2379923799epoutp03m;
        Fri, 15 Feb 2019 14:48:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190215144830epoutp0339442acc7a0b7860fc45261af8e0bff7~DkPx4OKqb2379923799epoutp03m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550242110;
        bh=a6Qe3Y5AeNH3YUJnwCvGWbAsf4Socke64a6evpoi/a8=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=Xd7o8C0MrrkPvfugWRgx9tAGRHkODkBoLOLp1CymGWqL5D3Z+Bwu1E44lpCpmz0Qr
         XVjHrV/+ZYGazLghiKcm7jP9mlgWnERbm5IHwivwSS5KK6XCFvRVuDGs4onKX27mfE
         O+y5V79G7XhzXh+cp4B52oDKcUpzHJBN2eh9FRCQ=
Received: from epsmges2p1.samsung.com (unknown [182.195.42.69]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20190215144829epcas2p4402bcf72236af636b346f1bb0675f4d2~DkPwtcb8H1019610196epcas2p4Z;
        Fri, 15 Feb 2019 14:48:29 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.55.04138.D31D66C5; Fri, 15 Feb 2019 23:48:29 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190215144828epcas2p267aae592d0ebaaaa297ba1543463c204~DkPvjBE9A1617816178epcas2p24;
        Fri, 15 Feb 2019 14:48:28 +0000 (GMT)
X-AuditID: b6c32a45-60bff7000000102a-86-5c66d13d34c9
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.D3.03689.C31D66C5; Fri, 15 Feb 2019 23:48:28 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMZ00AU92GC5G00@mmp1.samsung.com>; Fri, 15 Feb 2019
        23:48:28 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 2/2] ASoC: samsung: i2s: Fix multiple "IIS multi" devices
 initialization
Date:   Fri, 15 Feb 2019 15:48:09 +0100
Message-id: <20190215144809.28007-2-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190215144809.28007-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsWy7bCmma7txbQYg9eXxCyuXDzEZDH14RM2
        i/PnN7BbfLvSwWRxedccNou1R+6yWxx+085qcXHFFyYHDo8Nn5vYPHbOusvusWlVJ5tH35ZV
        jB6fN8kFsEZx2aSk5mSWpRbp2yVwZbS9OsFW0KtQsXjPVZYGxnVSXYycHBICJhIPzr5m6WLk
        4hAS2MEoceDVRSYI5zujxP3dS9lhqtYd2cUMkdjNKHHk03NGCOcXo8Sjf7/YQKrYBAwleo/2
        MYLYIgJiErfndIJ1MAscZpQ4eKcFbJSwQJTE4VNfwBpYBFQlbv86ywJi8wpYS8x/dp0RYp28
        xOoNB5hBbE4BG4mLHa/AbpIQmMAm8XbDOaAiDiDHRWLaZwWIemmJZ6s2QvVWS+za3s0MUd/B
        KNFyYTszRMJa4vDxi6wgNrMAn0TH4b/sEHN4JTrahCBKPCR6W9axQ3zWzyixf/Vz9gmMEgsY
        GVYxiqUWFOempxYbFRjqFSfmFpfmpesl5+duYgTHnJbrDsYZ53wOMQpwMCrx8N7YlxYjxJpY
        VlyZe4hRgoNZSYSX8yxQiDclsbIqtSg/vqg0J7X4EKM0B4uSOO8j6bnRQgLpiSWp2ampBalF
        MFkmDk6pBkYmnVurAhaceej8KeSwfO2yNW9Oymy+rPC2vueOQrTkm7VfLk7e/XFOU/i1mP+M
        FyskRUwPHRRqWnaZYXNcL+sVJuGccF9P7vbYtVE1nNF3LF+ksm4xd/juZrLwo+7a5y+y3qS4
        l4UFK3fv8+SRv1F4oes826y0n3XOqaXLX3869bOF8eTSQzpKLMUZiYZazEXFiQCMS49otQIA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprILMWRmVeSWpSXmKPExsVy+t9jAV2bi2kxBq+X81lcuXiIyWLqwyds
        FufPb2C3+Halg8ni8q45bBZrj9xltzj8pp3V4uKKL0wOHB4bPjexeeycdZfdY9OqTjaPvi2r
        GD0+b5ILYI3isklJzcksSy3St0vgymh7dYKtoFehYvGeqywNjOukuhg5OSQETCTWHdnF3MXI
        xSEksJNRYvuuKYwQzi9GiVeNN9hAqtgEDCV6j/YxgtgiAmISt+d0MoPYzAKHGSUurggCsYUF
        oiQOn/oCVs8ioCpx+9dZFhCbV8BaYv6z64wQ2+QlVm84ANbLKWAjcbHjFROILQRUs23uCdYJ
        jDwLGBlWMUqmFhTnpucWGxUY5aWW6xUn5haX5qXrJefnbmIEBtS2w1r9OxgfL4k/xCjAwajE
        w3tjX1qMEGtiWXFl7iFGCQ5mJRFezrNAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rz8+ccihQTS
        E0tSs1NTC1KLYLJMHJxSDYycK4w4hd1SzLOvB29aqML89mHAjj8WVo+esBiYVLNFJrk/+X/g
        +Rv95R5ivXcDrToexpeqcrYtPqfkvpWtdO907lsvTRQyzx+8MKv93lUV90xRq7p/TO3NQgm9
        cmY8D1iSWHoZ9r9jWcJrON3l1BmODY3H5p/Zpj81NdzEs2TO4p6DZSF9bEosxRmJhlrMRcWJ
        AFep0uokAgAA
X-CMS-MailID: 20190215144828epcas2p267aae592d0ebaaaa297ba1543463c204
CMS-TYPE: 102P
X-CMS-RootMailID: 20190215144828epcas2p267aae592d0ebaaaa297ba1543463c204
References: <20190215144809.28007-1-s.nawrocki@samsung.com>
        <CGME20190215144828epcas2p267aae592d0ebaaaa297ba1543463c204@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some SoCs (e.g. Exynos5433) there are multiple "IIS multi audio
interfaces" and the driver will try to register there multiple times
same platform device for the secondary FIFO, which of course fails
miserably.  To fix this we derive the secondary platform device name
from the primary device name. The secondary device name will now
be <primary_dev_name>-sec instead of fixed "samsung-i2s-sec".

The fixed platform_device_id table entry is removed as the secondary
device name is now dynamic and device/driver matching is done through
driver_override.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c    | 49 +++++++++++++++++++++++++-------------
 sound/soc/samsung/odroid.c |  2 +-
 2 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index e36c44e2f1bb..4a6dd86459bc 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1339,20 +1339,34 @@ static int i2s_register_clock_provider(struct samsung_i2s_priv *priv)
 /* Create platform device for the secondary PCM */
 static int i2s_create_secondary_device(struct samsung_i2s_priv *priv)
 {
-	struct platform_device *pdev;
+	struct platform_device *pdev_sec;
+	const char *devname;
 	int ret;
 
-	pdev = platform_device_register_simple("samsung-i2s-sec", -1, NULL, 0);
-	if (!pdev)
+	devname = devm_kasprintf(&priv->pdev->dev, GFP_KERNEL, "%s-sec",
+				 dev_name(&priv->pdev->dev));
+	if (!devname)
 		return -ENOMEM;
 
-	ret = device_attach(&pdev->dev);
+	pdev_sec = platform_device_alloc(devname, -1);
+	if (!pdev_sec)
+		return -ENOMEM;
+
+	pdev_sec->driver_override = "samsung-i2s";
+
+	ret = platform_device_add(pdev_sec);
 	if (ret < 0) {
-		dev_info(&pdev->dev, "device_attach() failed\n");
+		platform_device_put(pdev_sec);
 		return ret;
 	}
 
-	priv->pdev_sec = pdev;
+	priv->pdev_sec = pdev_sec;
+
+	ret = device_attach(&pdev_sec->dev);
+	if (ret < 0) {
+		dev_info(&pdev_sec->dev, "device_attach() failed\n");
+		return ret;
+	}
 
 	return 0;
 }
@@ -1367,22 +1381,25 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 {
 	struct i2s_dai *pri_dai, *sec_dai = NULL;
 	struct s3c_audio_pdata *i2s_pdata = pdev->dev.platform_data;
-	struct resource *res;
 	u32 regs_base, idma_addr = 0;
 	struct device_node *np = pdev->dev.of_node;
 	const struct samsung_i2s_dai_data *i2s_dai_data;
-	int num_dais, ret;
+	const struct platform_device_id *id;
 	struct samsung_i2s_priv *priv;
+	struct resource *res;
+	int num_dais, ret;
 
-	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node)
+	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
 		i2s_dai_data = of_device_get_match_data(&pdev->dev);
-	else
-		i2s_dai_data = (struct samsung_i2s_dai_data *)
-				platform_get_device_id(pdev)->driver_data;
+	} else {
+		id = platform_get_device_id(pdev);
 
-	/* Nothing to do if it is the secondary device probe */
-	if (!i2s_dai_data)
-		return 0;
+		/* Nothing to do if it is the secondary device probe */
+		if (!id)
+			return 0;
+
+		i2s_dai_data = (struct samsung_i2s_dai_data *)id->driver_data;
+	}
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -1635,8 +1652,6 @@ static const struct platform_device_id samsung_i2s_driver_ids[] = {
 	{
 		.name           = "samsung-i2s",
 		.driver_data	= (kernel_ulong_t)&i2sv3_dai_type,
-	}, {
-		.name           = "samsung-i2s-sec",
 	},
 	{},
 };
diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
index 5b2bcd1d3450..bd2c5163dc7f 100644
--- a/sound/soc/samsung/odroid.c
+++ b/sound/soc/samsung/odroid.c
@@ -185,7 +185,7 @@ static struct snd_soc_dai_link odroid_card_dais[] = {
 		.ops = &odroid_card_fe_ops,
 		.name = "Secondary",
 		.stream_name = "Secondary",
-		.platform_name = "samsung-i2s-sec",
+		.platform_name = "3830000.i2s-sec",
 		.dynamic = 1,
 		.dpcm_playback = 1,
 	}
-- 
2.17.1

