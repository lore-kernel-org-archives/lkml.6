Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3727BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24B82077B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ufwIbo90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbfBSPUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:20:21 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:11639 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfBSPUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:20:20 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190219152017epoutp037072fa4e75f50134b43b1c58b50e338c~EzQqsVf1t0490104901epoutp03m;
        Tue, 19 Feb 2019 15:20:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190219152017epoutp037072fa4e75f50134b43b1c58b50e338c~EzQqsVf1t0490104901epoutp03m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550589617;
        bh=xp9L3ufdnEowWluWcgkirs8ZO6OE8MU+m18qEBoChe8=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=ufwIbo90bf2D6JNOf7RhlkKi7D2wvFHntCP1WgZ4pilmMEgxAWsaDXa2ez9K4K/20
         k86B4Wj5AQdAr6Q49Ti/FozxLFuJykTy0fS5iHc0JPBjrsFHQcg9i2iHSAktOjd1TF
         dOHH3rXBYYXEzKz+AFXlPYQdHOIh0IA54sbzZaiI=
Received: from epsmges2p2.samsung.com (unknown [182.195.42.70]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190219152016epcas2p372b68d63fdffbc1ce2ddaa21c7c099f9~EzQpnu8El2750027500epcas2p3P;
        Tue, 19 Feb 2019 15:20:16 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.27.04136.0BE1C6C5; Wed, 20 Feb 2019 00:20:16 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20190219152015epcas2p455d8fc3fa012de0f1e857b0b2c88f773~EzQpPQsrw2564125641epcas2p45;
        Tue, 19 Feb 2019 15:20:15 +0000 (GMT)
X-AuditID: b6c32a46-2a7ff70000001028-ef-5c6c1eb05b66
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.71.03689.FAE1C6C5; Wed, 20 Feb 2019 00:20:15 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PN600EUVIL44F30@mmp1.samsung.com>; Wed, 20 Feb 2019
        00:20:15 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     sbkim73@samsung.com, krzk@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, alsa-devel@alsa-project.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 2/2] ASoC: samsung: i2s: Fix multiple "IIS multi" devices
 initialization
Date:   Tue, 19 Feb 2019 16:19:41 +0100
Message-id: <20190219151941.9795-2-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190219151941.9795-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsWy7bCmqe4GuZwYg3/ruC2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZfS2nmAqmKFW0bDvI2MA4RaaLkZND
        QsBEovnYTKYuRi4OIYEdjBK3r69mg3C+M0qs/faMBaaq6ddpRojEbkaJKRu6WCGcX4wSJ58+
        YwepYhMwlOg92scIYosIaEvMudkBNopZ4C2jxLxnu1hBEsICsRL9jy6ANbAIqEqs/zQBqIiD
        g1fASuLLKyuIbfISqzccYAaxOQWsJb5vaGEHmSMhsIRNYsXRiewQRS4S99Zsh7KlJZ6t2sgI
        YVdL7NrezQzR0MEo0XJhOzNEwlri8PGLYEcwC/BJdBz+yw6yWEKAV6KjTQiixEOic/JcaGD0
        MUo86PjDNIFRYgEjwypGsdSC4tz01GKjAiO94sTc4tK8dL3k/NxNjOA41HLbwbjknM8hRgEO
        RiUeXg2GnBgh1sSy4srcQ4wSHMxKIryGXEAh3pTEyqrUovz4otKc1OJDjNIcLErivA+l50YL
        CaQnlqRmp6YWpBbBZJk4OKUaGLnDczWuKkyoW1Nk+LgsZ9/2CxlyCWvStzsF9mvfeHu5Jzuy
        +0B+NkN1XHOla8/yNfeYjqjlMF5zKLxZp72zQmK6zIyJPefj97+8yaK1/5P+DJ390pPuLH3z
        tWHJVaHtETe8CpZL1052lK98fnpGoEvJ2u3mNx7NKLmSG1ZlsHBz36Vn9xed91ViKc5INNRi
        LipOBAAbL5mhvwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsVy+t9jAd31cjkxBh0zDCyuXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZfS2nmAqmKFW0bDvI2MA4RaaLkZND
        QsBEounXacYuRi4OIYGdjBJ/1n9nhXB+MUp87d3MClLFJmAo0Xu0jxHEFhHQlphzs4MNpIhZ
        4C2jRMOZNjaQhLBArET/owvsIDaLgKrE+k8TgOIcHLwCVhJfXllBbJOXWL3hADOIzSlgLfF9
        QwtYuRBQyd3TixgnMPIsYGRYxSiZWlCcm55bbFRglJdarlecmFtcmpeul5yfu4kRGGTbDmv1
        72B8vCT+EKMAB6MSD68GQ06MEGtiWXFl7iFGCQ5mJRFeQy6gEG9KYmVValF+fFFpTmrxIUZp
        DhYlcV7+/GORQgLpiSWp2ampBalFMFkmDk6pBsaJM+4cdtvy6hxz4MvouHOnZr1fWnHt3ItS
        04/nF7fefbqLLSyX47nw/rCHMzVPiYe53pzid8JY2n7Zq16Ogq0XZ3bO3L671N6ySGrGKb7W
        O6sK9L7qXHm5veVi74r1qRuqDx7pybh/JcKCzXnmh4RLZ1en39V7t4P1/vGqiZYZN8VdBFYt
        KuLSUGIpzkg01GIuKk4EAOmTowwuAgAA
X-CMS-MailID: 20190219152015epcas2p455d8fc3fa012de0f1e857b0b2c88f773
CMS-TYPE: 102P
X-CMS-RootMailID: 20190219152015epcas2p455d8fc3fa012de0f1e857b0b2c88f773
References: <20190219151941.9795-1-s.nawrocki@samsung.com>
        <CGME20190219152015epcas2p455d8fc3fa012de0f1e857b0b2c88f773@epcas2p4.samsung.com>
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
Changes since v1:
 - fixed pdev->driver_override assignment,
 - ensure there is no need to release any resources claimed
   in i2s_create_secondary_device() function when that function fails.
---
 sound/soc/samsung/i2s.c    | 50 +++++++++++++++++++++++++-------------
 sound/soc/samsung/odroid.c |  2 +-
 2 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index cd92bb6e1da1..4231001226f4 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1339,20 +1339,35 @@ static int i2s_register_clock_provider(struct samsung_i2s_priv *priv)
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
+	pdev_sec->driver_override = kstrdup("samsung-i2s", GFP_KERNEL);
+
+	ret = platform_device_add(pdev_sec);
 	if (ret < 0) {
-		dev_info(&pdev->dev, "device_attach() failed\n");
+		platform_device_put(pdev_sec);
 		return ret;
 	}

-	priv->pdev_sec = pdev;
+	ret = device_attach(&pdev_sec->dev);
+	if (ret <= 0) {
+		platform_device_unregister(priv->pdev_sec);
+		dev_info(&pdev_sec->dev, "device_attach() failed\n");
+		return ret;
+	}
+
+	priv->pdev_sec = pdev_sec;

 	return 0;
 }
@@ -1367,22 +1382,25 @@ static int samsung_i2s_probe(struct platform_device *pdev)
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
@@ -1637,8 +1655,6 @@ static const struct platform_device_id samsung_i2s_driver_ids[] = {
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

