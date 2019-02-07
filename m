Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A8EC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C8A21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XvmaT/V+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfBGRCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:02:09 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:63740 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfBGRBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:01:53 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190207170150epoutp012c1493ee35803f5b6ca2c94785c3a3e4~BI56Ts6Ql1148911489epoutp01V;
        Thu,  7 Feb 2019 17:01:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190207170150epoutp012c1493ee35803f5b6ca2c94785c3a3e4~BI56Ts6Ql1148911489epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549558910;
        bh=pL58VYA2iP//lSOa90ooRRRRaI6aFNhaYrJ2L7mJ+Io=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=XvmaT/V+LZ4HUbYIwWpYZb2webzuTAfkqDZdDcwlg6ouxy8Mq2TgB8SWucIeYTMsT
         ujY+UVi/aCI5q+oPNmwc4c99UELDm/i7jAk/0cnzauTI4gDUyOt6jv0p178RMsy61j
         Y+ixZ4nAoQyr8Rm5tXcIV5P0hQ51fBZ7Eoim80Vs=
Received: from epsmges2p3.samsung.com (unknown [182.195.42.71]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190207170149epcas2p2cfebd1f93f524fc5714d7f52832fb0a5~BI55RRRBi1763917639epcas2p2h;
        Thu,  7 Feb 2019 17:01:49 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.07.04134.D746C5C5; Fri,  8 Feb 2019 02:01:49 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190207170148epcas2p2e0f4a1e154cb8cd52d257978a669e84c~BI54jZ-J11763317633epcas2p2u;
        Thu,  7 Feb 2019 17:01:48 +0000 (GMT)
X-AuditID: b6c32a47-8abff70000001026-89-5c5c647d8705
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.C8.03689.C746C5C5; Fri,  8 Feb 2019 02:01:48 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMK00MP9F8VXL10@mmp1.samsung.com>; Fri, 08 Feb 2019
        02:01:48 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 18/22] ASoC: samsung: Specify DMA channel names through
 custom DMA config
Date:   Thu, 07 Feb 2019 18:00:26 +0100
Message-id: <20190207170028.720-19-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190207170028.720-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7bCmuW5tSkyMwcJedYsrFw8xWWycsZ7V
        YurDJ2wW589vYLf4dqWDyeLyrjlsFjPO72OyWHvkLrvF4TftrBYXV3xhcuDy2PC5ic1j56y7
        7B6bVnWyefRtWcXo8XmTXABrFJdNSmpOZllqkb5dAlfG7WsdTAVXpCuOTO5iaWCcJN7FyMkh
        IWAicf35R5YuRi4OIYEdjBIbZu6Ccr4zSlxbPpcdpur9z8fsEIndjBKH//RBVf1ilOhufMsM
        UsUmYCjRe7SPEcQWERCTuD2nkxmkiFmghUliztylQA4Hh7BAtMTVq1EgNSwCqhLf375hAbF5
        BawkGu4tY4TYJi9xvncd2GZOoPit/TugagQlfky+B2YzA9UcvPIc7AgJgQNsEudufWSGaHaR
        2LBtPxuELS3xbNVGqKHVEru2dzNDNHQwSrRc2A7VYC1x+PhFVoipfBIdh/+ygxwqIcAr0dEm
        BFHiIbFz1TmwciGBXkaJV7v0JzBKzUJy0ywkNy1gZFrFKJZaUJybnlpsVGCsV5yYW1yal66X
        nJ+7iREc5VruOxi3nfM5xCjAwajEw3tBOyZGiDWxrLgy9xCjBAezkgivbAJQiDclsbIqtSg/
        vqg0J7X4EKM0B4uSOO9D6bnRQgLpiSWp2ampBalFMFkmDk6pBka+jYIJ4kvapht/26DvvSyG
        XWhNG5/nV4XXt3eppcW/FpysJNjYXy3E9L/l5trokksf2nf4uv3f9uTCjUc8vOw7k94e81O7
        YLKbg+u0uHxpvAhHkd+dKrFtvTdEHbgeuG58m/ozsN638I6OZ0MPK1f8zm21q/rkeXMzue33
        W6Q3r92iZLjytRJLcUaioRZzUXEiAAUCI7HuAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsVy+t9jAd2alJgYg0Wb9S2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZt691MBVcka44MrmLpYFxkngXIyeH
        hICJxPufj9m7GLk4hAR2MkqcmnOcDcL5xShx8vJPZpAqNgFDid6jfYwgtoiAmMTtOZ3MIEXM
        Ak1MErtuX2QHSQgLREu87JwMVsQioCrx/e0bFhCbV8BKouHeMkaIdfIS53vXgdVzAsVv7d8B
        ViMkYCnxYUITK0S9oMSPyffA4sxA9QevPGeZwMg3C0lqFpLUAkamVYySqQXFuem5xUYFRnmp
        5XrFibnFpXnpesn5uZsYgWG87bBW/w7Gx0viDzEKcDAq8fBe0I6JEWJNLCuuzD3EKMHBrCTC
        K5sAFOJNSaysSi3Kjy8qzUktPsQozcGiJM7Ln38sUkggPbEkNTs1tSC1CCbLxMEp1cAYr3mL
        zdVOLUTb4sCxzAXJOyepuSaJrVQRtn4Te/D+xsxrmQlB91dzhgcK6nStKfpx01tn5dv8jB82
        KeF1bs8iCtvf9s5Zesq2J8WR892fJafSK0W5tR+niezV53s7rUj+0tY5D5TCFi3jktPez8i4
        dFN4q+DT8+YcO/62+le+SJhi2FjyYYoSS3FGoqEWc1FxIgBIKSDZXwIAAA==
X-CMS-MailID: 20190207170148epcas2p2e0f4a1e154cb8cd52d257978a669e84c
CMS-TYPE: 102P
X-CMS-RootMailID: 20190207170148epcas2p2e0f4a1e154cb8cd52d257978a669e84c
References: <20190207170028.720-1-s.nawrocki@samsung.com>
        <CGME20190207170148epcas2p2e0f4a1e154cb8cd52d257978a669e84c@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a part of conversion of Samsung platforms to use the custom DMA
config for specifying DMA channel names, in addition to passing custom
DMA device for the secondary CPU DAI's "PCM" component for some variants
of the I2S controller.

We also don't set the SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME any more
as setting it wouldn't allow to specify DMA channels through the custom
DMA config.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/dmaengine.c   | 12 ++++--------
 sound/soc/samsung/i2s.c         |  2 +-
 sound/soc/samsung/s3c2412-i2s.c |  2 +-
 sound/soc/samsung/s3c24xx-i2s.c |  2 +-
 4 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/soc/samsung/dmaengine.c b/sound/soc/samsung/dmaengine.c
index 84601fa9aa46..302871974cb3 100644
--- a/sound/soc/samsung/dmaengine.c
+++ b/sound/soc/samsung/dmaengine.c
@@ -28,7 +28,6 @@ int samsung_asoc_dma_platform_register(struct device *dev, dma_filter_fn filter,
 				       const char *tx, const char *rx,
 				       struct device *dma_dev)
 {
-	unsigned int flags = SND_DMAENGINE_PCM_FLAG_COMPAT;
 	struct snd_dmaengine_pcm_config *pcm_conf;
 
 	pcm_conf = devm_kzalloc(dev, sizeof(*pcm_conf), GFP_KERNEL);
@@ -39,14 +38,11 @@ int samsung_asoc_dma_platform_register(struct device *dev, dma_filter_fn filter,
 	pcm_conf->compat_filter_fn = filter;
 	pcm_conf->dma_dev = dma_dev;
 
-	if (dev->of_node) {
-		pcm_conf->chan_names[SNDRV_PCM_STREAM_PLAYBACK] = tx;
-		pcm_conf->chan_names[SNDRV_PCM_STREAM_CAPTURE] = rx;
-	} else {
-		flags |= SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME;
-	}
+	pcm_conf->chan_names[SNDRV_PCM_STREAM_PLAYBACK] = tx;
+	pcm_conf->chan_names[SNDRV_PCM_STREAM_CAPTURE] = rx;
 
-	return devm_snd_dmaengine_pcm_register(dev, pcm_conf, flags);
+	return devm_snd_dmaengine_pcm_register(dev, pcm_conf,
+				SND_DMAENGINE_PCM_FLAG_COMPAT);
 }
 EXPORT_SYMBOL_GPL(samsung_asoc_dma_platform_register);
 
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 9931d007bc13..2e91d183dd41 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1460,7 +1460,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		pri_dai->drv->playback.channels_max = 6;
 
 	ret = samsung_asoc_dma_platform_register(&pdev->dev, pri_dai->filter,
-						 NULL, NULL, NULL);
+						 "tx", "rx", NULL);
 	if (ret < 0)
 		goto err_disable_clk;
 
diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
index 67dfa27ae321..c08638b0e458 100644
--- a/sound/soc/samsung/s3c2412-i2s.c
+++ b/sound/soc/samsung/s3c2412-i2s.c
@@ -177,7 +177,7 @@ static int s3c2412_iis_dev_probe(struct platform_device *pdev)
 
 	ret = samsung_asoc_dma_platform_register(&pdev->dev,
 						 pdata->dma_filter,
-						 NULL, NULL, NULL);
+						 "tx", "rx", NULL);
 	if (ret) {
 		pr_err("failed to register the DMA: %d\n", ret);
 		return ret;
diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
index ba0f2b94f8d4..a8026b640c95 100644
--- a/sound/soc/samsung/s3c24xx-i2s.c
+++ b/sound/soc/samsung/s3c24xx-i2s.c
@@ -446,7 +446,7 @@ static int s3c24xx_iis_dev_probe(struct platform_device *pdev)
 	s3c24xx_i2s_pcm_stereo_in.addr = res->start + S3C2410_IISFIFO;
 
 	ret = samsung_asoc_dma_platform_register(&pdev->dev, NULL,
-						 NULL, NULL, NULL);
+						 "tx", "rx", NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register the DMA: %d\n", ret);
 		return ret;
-- 
2.20.1

