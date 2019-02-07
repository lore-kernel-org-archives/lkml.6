Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6D0C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C4621872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="h3vduXgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfBGRBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:01:01 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:31999 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfBGRA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:00:59 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190207170056epoutp03732bd1d199ed64a5ec7bbad0e56df276~BI5Hg-8Y02488224882epoutp03b;
        Thu,  7 Feb 2019 17:00:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190207170056epoutp03732bd1d199ed64a5ec7bbad0e56df276~BI5Hg-8Y02488224882epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549558856;
        bh=yeG7cOJqA6pJEeXmtWt2pGkVdYpGnpKyrGXLzbCrFHo=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=h3vduXgAlt6FRv9F9bm1QIZf5QAGyoXXV5YLci+WzCX4DOjSe3xD9xnoVddAxD2IP
         8SC3Hvp6qXFQovXg9lYIcDVa2Mdstv4aSJv/sVTFpxqj5Un51IDzDwqCi8dYpBHx11
         ko9Sm9DyvernAuVnjnu0qnddnxuiRfggyyveZQ04=
Received: from epsmges1p5.samsung.com (unknown [182.195.42.57]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190207170055epcas1p249079fa391524301607d84460c0b775e~BI5GsfDvT2711827118epcas1p2A;
        Thu,  7 Feb 2019 17:00:55 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.AE.04206.7446C5C5; Fri,  8 Feb 2019 02:00:55 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190207170054epcas1p1e61320d308bc5be30187919f3360f501~BI5GVzO9y2372323723epcas1p1H;
        Thu,  7 Feb 2019 17:00:54 +0000 (GMT)
X-AuditID: b6c32a39-d65ff7000000106e-41-5c5c6447c294
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        49.C8.04015.6446C5C5; Fri,  8 Feb 2019 02:00:54 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMK00MP9F8VXL10@mmp1.samsung.com>; Fri, 08 Feb 2019
        02:00:54 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 03/22] ASoC: samsung: dmaengine: Allow to specify custom DMA
 device
Date:   Thu, 07 Feb 2019 18:00:11 +0100
Message-id: <20190207170028.720-4-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190207170028.720-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsWy7bCmrq57SkyMQf9vfosrFw8xWWycsZ7V
        YurDJ2wW589vYLf4dqWDyeLyrjlsFjPO72OyWHvkLrvF4TftrBYXV3xhcuDy2PC5ic1j56y7
        7B6bVnWyefRtWcXo8XmTXABrFJdNSmpOZllqkb5dAlfGvauvmQtOq1bsaZnJ1MD4Qq6LkZND
        QsBEYueERvYuRi4OIYEdjBK7d85kg3C+M0o8mH+DDabq4bsLTBCJ3YwSy5/fY4FwfjFK/Prx
        mh2kik3AUKL3aB8jiC0iICZxe04nM0gRs0ALk8ScuUuZQRLCAqES6z9/ZwGxWQRUJT6+6AaL
        8wpYSiw9tBpqnbzE+d51YEM5Bawkbu3fwQJRIyjxY/I9MJsZqObglecsEPUH2CS+nMmCsF0k
        5vxfDNTLAWRLS1w6agsRrpbYtb0b7B4JgQ5GiZYL25khEtYSh49fZIWYySfx7msPK0Qvr0RH
        mxCE6SFx6qkIxL+9jBLvzh1jm8AoNQvJRbOQXLSAkWkVo1hqQXFuemqxYYGpXnFibnFpXrpe
        cn7uJkZwjGtZ7mA8ds7nEKMAB6MSD+8F7ZgYIdbEsuLK3EOMEhzMSiK8sglAId6UxMqq1KL8
        +KLSnNTiQ4zSHCxK4rzrHZxjhATSE0tSs1NTC1KLYLJMHJxSDYzFgvuWsi8XeLh1y1nrsjtl
        PNHr7urH/53DVSH6evoF2dkztzgKT+Nd6bsjQD3+4IfMG2k/E93WPBHdX1C9wKyCtZmdSWup
        mMS23y0Gs9hrUv9uDA1KkylcdKX5W4SNkca1+pQVX+ddKW/hOpg2ef7vQ5J3Z2yUtZnBNl8+
        LsRdYu3n3Qv75FSUWIozEg21mIuKEwEWkB0D7QIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsVy+t9jAV23lJgYg8sHTC2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZ966+Zi44rVqxp2UmUwPjC7kuRk4O
        CQETiYfvLjB1MXJxCAnsZJRo7djNDOH8YpTY+v8VG0gVm4ChRO/RPkYQW0RATOL2nE6wImaB
        JiaJXbcvsoMkhAVCJdZ//s4CYrMIqEp8fNHNDGLzClhKLD20mg1inbzE+d51YPWcAlYSt/bv
        AKsXAqr5MKGJFaJeUOLH5HtgcWag+oNXnrNMYOSbhSQ1C0lqASPTKkbJ1ILi3PTcYqMCw7zU
        cr3ixNzi0rx0veT83E2MwDDedlirbwfj/SXxhxgFOBiVeHgvaMfECLEmlhVX5h5ilOBgVhLh
        lU0ACvGmJFZWpRblxxeV5qQWH2KU5mBREue9nXcsUkggPbEkNTs1tSC1CCbLxMEp1cDoNlex
        9/p5JoWkUJHNXFunJ+2IyXasXeVyW+ldYW01T+6/Y053k14q/X8hbOp30Y7NaiHL2UXLFn9f
        YtcfwM+6V0zRZy13XVH++5/TXtpO5P9lHrinteKQQa9gxuSMJdO6Fno1x7TnWvYnF+js1r2u
        rrtI6cTPLQ4h369PP3n0tOq+q2rFyx4rsRRnJBpqMRcVJwIA0kVbU18CAAA=
X-CMS-MailID: 20190207170054epcas1p1e61320d308bc5be30187919f3360f501
CMS-TYPE: 101P
X-CMS-RootMailID: 20190207170054epcas1p1e61320d308bc5be30187919f3360f501
References: <20190207170028.720-1-s.nawrocki@samsung.com>
        <CGME20190207170054epcas1p1e61320d308bc5be30187919f3360f501@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The additional function argument will allow to select proper DMA device
for requesting DMA channel for the secondary CPU DAI.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/dma.h         | 3 ++-
 sound/soc/samsung/dmaengine.c   | 4 +++-
 sound/soc/samsung/i2s.c         | 4 ++--
 sound/soc/samsung/pcm.c         | 2 +-
 sound/soc/samsung/s3c2412-i2s.c | 2 +-
 sound/soc/samsung/s3c24xx-i2s.c | 2 +-
 sound/soc/samsung/spdif.c       | 2 +-
 7 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/sound/soc/samsung/dma.h b/sound/soc/samsung/dma.h
index 7ae580d677c8..0ae15d01a3f6 100644
--- a/sound/soc/samsung/dma.h
+++ b/sound/soc/samsung/dma.h
@@ -17,5 +17,6 @@
  * otherwise actual DMA channel names must be passed to this function.
  */
 int samsung_asoc_dma_platform_register(struct device *dev, dma_filter_fn filter,
-				       const char *tx, const char *rx);
+				       const char *tx, const char *rx,
+				       struct device *dma_dev);
 #endif /* _SAMSUNG_DMA_H */
diff --git a/sound/soc/samsung/dmaengine.c b/sound/soc/samsung/dmaengine.c
index 9104c98deeb7..84601fa9aa46 100644
--- a/sound/soc/samsung/dmaengine.c
+++ b/sound/soc/samsung/dmaengine.c
@@ -25,7 +25,8 @@
 #include "dma.h"
 
 int samsung_asoc_dma_platform_register(struct device *dev, dma_filter_fn filter,
-				       const char *tx, const char *rx)
+				       const char *tx, const char *rx,
+				       struct device *dma_dev)
 {
 	unsigned int flags = SND_DMAENGINE_PCM_FLAG_COMPAT;
 	struct snd_dmaengine_pcm_config *pcm_conf;
@@ -36,6 +37,7 @@ int samsung_asoc_dma_platform_register(struct device *dev, dma_filter_fn filter,
 
 	pcm_conf->prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config;
 	pcm_conf->compat_filter_fn = filter;
+	pcm_conf->dma_dev = dma_dev;
 
 	if (dev->of_node) {
 		pcm_conf->chan_names[SNDRV_PCM_STREAM_PLAYBACK] = tx;
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index ce00fe2f6aae..9d3dcb2204fe 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1345,7 +1345,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		pri_dai->i2s_dai_drv.playback.channels_max = 6;
 
 	ret = samsung_asoc_dma_platform_register(&pdev->dev, pri_dai->filter,
-						 NULL, NULL);
+						 NULL, NULL, NULL);
 	if (ret < 0)
 		goto err_disable_clk;
 
@@ -1382,7 +1382,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		pri_dai->sec_dai = sec_dai;
 
 		ret = samsung_asoc_dma_platform_register(&pdev->dev,
-					sec_dai->filter, "tx-sec", NULL);
+					sec_dai->filter, "tx-sec", NULL, NULL);
 		if (ret < 0)
 			goto err_disable_clk;
 
diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
index 37f95eee1558..3c7baa561084 100644
--- a/sound/soc/samsung/pcm.c
+++ b/sound/soc/samsung/pcm.c
@@ -553,7 +553,7 @@ static int s3c_pcm_dev_probe(struct platform_device *pdev)
 	pcm->dma_playback = &s3c_pcm_stereo_out[pdev->id];
 
 	ret = samsung_asoc_dma_platform_register(&pdev->dev, filter,
-						 NULL, NULL);
+						 NULL, NULL, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to get register DMA: %d\n", ret);
 		goto err_dis_pclk;
diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
index cc0840fff5aa..67dfa27ae321 100644
--- a/sound/soc/samsung/s3c2412-i2s.c
+++ b/sound/soc/samsung/s3c2412-i2s.c
@@ -177,7 +177,7 @@ static int s3c2412_iis_dev_probe(struct platform_device *pdev)
 
 	ret = samsung_asoc_dma_platform_register(&pdev->dev,
 						 pdata->dma_filter,
-						 NULL, NULL);
+						 NULL, NULL, NULL);
 	if (ret) {
 		pr_err("failed to register the DMA: %d\n", ret);
 		return ret;
diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
index 8d58d02183bf..ba0f2b94f8d4 100644
--- a/sound/soc/samsung/s3c24xx-i2s.c
+++ b/sound/soc/samsung/s3c24xx-i2s.c
@@ -446,7 +446,7 @@ static int s3c24xx_iis_dev_probe(struct platform_device *pdev)
 	s3c24xx_i2s_pcm_stereo_in.addr = res->start + S3C2410_IISFIFO;
 
 	ret = samsung_asoc_dma_platform_register(&pdev->dev, NULL,
-						 NULL, NULL);
+						 NULL, NULL, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register the DMA: %d\n", ret);
 		return ret;
diff --git a/sound/soc/samsung/spdif.c b/sound/soc/samsung/spdif.c
index cb59911e65c0..5e4afb330416 100644
--- a/sound/soc/samsung/spdif.c
+++ b/sound/soc/samsung/spdif.c
@@ -430,7 +430,7 @@ static int spdif_probe(struct platform_device *pdev)
 	spdif->dma_playback = &spdif_stereo_out;
 
 	ret = samsung_asoc_dma_platform_register(&pdev->dev, filter,
-						 NULL, NULL);
+						 NULL, NULL, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register DMA: %d\n", ret);
 		goto err4;
-- 
2.20.1

