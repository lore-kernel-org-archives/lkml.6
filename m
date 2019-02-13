Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6901C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B93720835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="be5bjhEj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388319AbfBMSwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:52:12 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:10387 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405851AbfBMSnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:43:21 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190213184319epoutp03e32581960008499db7d3156a3a43ccc1~DAKOngTjn1822418224epoutp031;
        Wed, 13 Feb 2019 18:43:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190213184319epoutp03e32581960008499db7d3156a3a43ccc1~DAKOngTjn1822418224epoutp031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550083399;
        bh=J6H+Vy/rMx02aXMq9DQh06tQn/cC6LHTpLKn919N9e0=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=be5bjhEjwiLLyKmxmbcQ+SPGrboJ9Nft/ilR7DLJmj0wJHvWpRukC7iEN8fku16Gv
         FlH/UhPmyMjm1/eaA3w6/D/SFIrLSOcGDOfVdL9jgYKBjFlQWYU/FpcWOQHo6/ue1/
         EiSX+O+nc7rboMlvDF85jAodxeOtoU4I4MaESDD8=
Received: from epsmges2p2.samsung.com (unknown [182.195.42.70]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190213184318epcas2p3dcd3e96f45bd21a9d1bb51b035d09ba9~DAKNl25KJ2560825608epcas2p3Y;
        Wed, 13 Feb 2019 18:43:18 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.6C.04136.645646C5; Thu, 14 Feb 2019 03:43:18 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190213184317epcas2p17fc18ee2ac4b92a7d1690c56e36739d6~DAKMlbSRR1584015840epcas2p1f;
        Wed, 13 Feb 2019 18:43:17 +0000 (GMT)
X-AuditID: b6c32a46-2a7ff70000001028-bd-5c646546a269
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 67.ED.03689.545646C5; Thu, 14 Feb
        2019 03:43:17 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMV00HOONZ3WX60@mmp2.samsung.com>; Thu, 14 Feb 2019
        03:43:17 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 07/13] ASoC: samsung: Specify DMA channel names through
 custom DMA config
Date:   Wed, 13 Feb 2019 19:42:06 +0100
Message-id: <20190213184212.5473-8-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190213184212.5473-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsWy7bCmqa5bakqMwYK9MhZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6MXcdmsRS0ylRcONrB2MC4T7yLkZND
        QsBEov/NBqYuRi4OIYEdjBI7Th5mhXC+M0qsW/eVGabq4qI2qMQGRom396awQDi/GCUeXuhk
        A6liEzCU6D3axwhiiwiISdye08kMUsQs0MIkMWfuUrBRwgJxEk8OvQKzWQRUJT4vuQpm8wpY
        SRzpfgW1Tl5i9YYDYDangLXEv7XP2UEGSQgsYJN4Mn8NG0SRi8Tm3bPZIWxpiWerNjJC2NUS
        u7Z3M0M0dDBKtFzYDjXVWuLw8YusIDazAJ9Ex+G/QM0cQHFeiY42IYgSD4n3h85C/dnHKNHd
        tJRxAqPEAkaGVYxiqQXFuempxUYFRnrFibnFpXnpesn5uZsYwZGo5baDcck5n0OMAhyMSjy8
        FUIpMUKsiWXFlbmHGCU4mJVEePWigEK8KYmVValF+fFFpTmpxYcYpTlYlMR5H0rPjRYSSE8s
        Sc1OTS1ILYLJMnFwSjUw9sUmN52qOchjGbFM3s1AV5O9y2cNn2hhlo50WcOFJTO4A///uLM1
        KfSvm5bRcmvRomtKR6fGmNasNbKaOstkdgrDCR8r/y3qK9zXJLy4teR18SL1tXGZTv4GX+ed
        u7Sj4Jdo+MR/1hZ3fQ+tCpip8qK/9XRjkFK9+V73o9d2MrPk6m4q/tekxFKckWioxVxUnAgA
        BPMis8ACAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDLMWRmVeSWpSXmKPExsVy+t9jQV3X1JQYg0nXxCyuXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZu47NYilolam4cLSDsYFxn3gXIyeH
        hICJxMVFbaxdjFwcQgLrGCUar19lg3B+MUpsv3SWBaSKTcBQovdoHyOILSIgJnF7TiczSBGz
        QBOTxK7bF9lBEsICcRJPDr1iBrFZBFQlPi+5CmbzClhJHOmGiEsIyEus3nAAzOYUsJb4t/Y5
        WK8QUM3ED5eYJzDyLGBkWMUomVpQnJueW2xUYJSXWq5XnJhbXJqXrpecn7uJERhm2w5r9e9g
        fLwk/hCjAAejEg9vhVBKjBBrYllxZe4hRgkOZiURXr0ooBBvSmJlVWpRfnxRaU5q8SFGaQ4W
        JXFe/vxjkUIC6YklqdmpqQWpRTBZJg5OqQbGI7xKvZEnjW6mSyRmi5yaJh31nMFWru+MOYN3
        NtsC/5fZzLcE6x9Pe5JlGf/01sW3e4X5BEUUEx1Fehi2TAvtjfPWb1r+nT/K8n2S2EqVI3xX
        xHiUgy/NlOLi7hL7lB1+d8+bI5s/XZe/qJoavII7Mdrh1dFLs1dOvnPKb1WPVBrPVdl5Sw2V
        WIozEg21mIuKEwGbUFgZLwIAAA==
X-CMS-MailID: 20190213184317epcas2p17fc18ee2ac4b92a7d1690c56e36739d6
CMS-TYPE: 102P
X-CMS-RootMailID: 20190213184317epcas2p17fc18ee2ac4b92a7d1690c56e36739d6
References: <20190213184212.5473-1-s.nawrocki@samsung.com>
        <CGME20190213184317epcas2p17fc18ee2ac4b92a7d1690c56e36739d6@epcas2p1.samsung.com>
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
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
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
index 692a752b194c..6ab99e38e6dd 100644
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
2.17.1

