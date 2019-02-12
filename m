Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C63C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C825222C5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fTf66zHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731811AbfBLSFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:05:30 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:59219 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731753AbfBLSF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:05:27 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190212180525epoutp0312de0c37c1959091b76d646051217826~Cr-2O5XiZ2786327863epoutp03b;
        Tue, 12 Feb 2019 18:05:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190212180525epoutp0312de0c37c1959091b76d646051217826~Cr-2O5XiZ2786327863epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549994725;
        bh=h/BRQ5rh3TIQbUVJZGgDFpZLAJ0tKI4OPOpcXUe9s5Y=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=fTf66zHsj/ohwZrWmVtcA+jzGAABNJNvrMS77r01V2kwXnYisNuqrLM4V1zuMA+DA
         J8/Tq2dNlOzxOrHyB2J8dAMpEXptHBN10n7fMlK9eFqpzrAX58sCUCr5EIXUGvCnID
         7AolTRyvpz/XvIJjYSj1pPIHW5wK4NpXllG6uaEQ=
Received: from epsmges1p3.samsung.com (unknown [182.195.42.55]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190212180525epcas1p323c55828e1cbecd645ce687f2e23e09b~Cr-1-GITh3011530115epcas1p3V;
        Tue, 12 Feb 2019 18:05:25 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        45.28.04069.4EA036C5; Wed, 13 Feb 2019 03:05:25 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190212180524epcas1p41b5845cef4c81798f4a07fe8c53f1288~Cr-1p8RMh3232832328epcas1p4W;
        Tue, 12 Feb 2019 18:05:24 +0000 (GMT)
X-AuditID: b6c32a37-971ff70000000fe5-e1-5c630ae46ae0
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id E4.11.04015.4EA036C5; Wed, 13 Feb
        2019 03:05:24 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMT0024XRJ2FB10@mmp2.samsung.com>; Wed, 13 Feb 2019
        03:05:24 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 13/21] ASoC: samsung: Specify DMA channel names through
 custom DMA config
Date:   Tue, 12 Feb 2019 19:03:34 +0100
Message-id: <20190212180342.32040-14-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190212180342.32040-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsWy7bCmge5TruQYgzupFlcuHmKy2DhjPavF
        1IdP2CzOn9/AbvHtSgeTxeVdc9gsZpzfx2Sx9shddovDb9pZLS6u+MLkwOWx4XMTm8fOWXfZ
        PTat6mTz6NuyitHj8ya5ANYoLpuU1JzMstQifbsEroxLLbNYC1plKm60P2RtYNwn3sXIySEh
        YCIxffZuli5GLg4hgR2MEh23/rBBON8ZJSbc/M4IU3Xzwxmoqg2MEtM/PmSHcH4xSnzb84gN
        pIpNwFCi92gfWIeIgJjE7TmdzCBFzAItTBJz5i5lBkkIC8RJ3P65EKyBRUBVYsfpTnYQm1fA
        RmLNvttQ6+QlzveuA4tzAsWfLfzGAlEjKPFj8j0wmxmo5uCV5ywQ9UfYJGa1G3cxcgDZLhI3
        +hMhTGmJS0dtISqqJXZt7wY7R0Kgg1Gi5cJ2ZoiEtcTh4xdZIUbySbz72sMK0csr0dEmBFHi
        IXFs5luo5/sZJbZtP8o6gVFqFpKLZiG5aAEj0ypGsdSC4tz01GLDAmO94sTc4tK8dL3k/NxN
        jOAI1zLfwbjhnM8hRgEORiUe3hVHk2KEWBPLiitzDzFKcDArifCmMSfHCPGmJFZWpRblxxeV
        5qQWH2KU5mBREudd7+AcIySQnliSmp2aWpBaBJNl4uCUamDMXiBRxKxepL7+jPVizcUKDEVf
        5I8Z/tT/Ns/mw7HqOt2IIwoTdx8qMeA2mr/GPt3665KK6qeCxc1ut9vZxN/aLEipPbJkxf4a
        Wxe3VXclGb5KbZxo19QTVKliI2m5JTviP2Owz9YdawPff3wSqnr5guVbA6HlEdsCZ91UvP+8
        YatVdIiQmL4SS3FGoqEWc1FxIgDPSQQI7AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsVy+t9jQd0nXMkxBk+fKFtcuXiIyWLjjPWs
        FlMfPmGzOH9+A7vFtysdTBaXd81hs5hxfh+Txdojd9ktDr9pZ7W4uOILkwOXx4bPTWweO2fd
        ZffYtKqTzaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyLrXMYi1olam40f6QtYFxn3gXIyeH
        hICJxM0PZ1i6GLk4hATWMUocnjKbHcL5xSjRsOMCK0gVm4ChRO/RPkYQW0RATOL2nE5mkCJm
        gSYmiV23L7KDJIQF4iRu/1zIBmKzCKhK7DjdCRbnFbCRWLPvNiPEOnmJ873rwOKcQPFnC78B
        reYA2mYtcWWTLUS5oMSPyfdYQGxmoPKDV56zTGDkm4UkNQtJagEj0ypGydSC4tz03GKjAsO8
        1HK94sTc4tK8dL3k/NxNjMAg3nZYq28H4/0l8YcYBTgYlXh4VxxNihFiTSwrrsw9xCjBwawk
        wpvGnBwjxJuSWFmVWpQfX1Sak1p8iFGag0VJnPd23rFIIYH0xJLU7NTUgtQimCwTB6dUA2O4
        xsyfP/UY39/l/RvWnnRBKUleZfmX1tMXtpiGBz9k/Wo1X0P9CRvLU/ftqXoKH7k+x/sL8Z0N
        WrXogl5JX9HJgOMlk9hO/to769231l867336JRlnzSh1ftvE9PhRXz1Xn/fvwKv/JZeWGYl1
        X1w879yjk2JbN5VeqNsVuso6otpeS3F/ipsSS3FGoqEWc1FxIgATjxU2XgIAAA==
X-CMS-MailID: 20190212180524epcas1p41b5845cef4c81798f4a07fe8c53f1288
CMS-TYPE: 101P
X-CMS-RootMailID: 20190212180524epcas1p41b5845cef4c81798f4a07fe8c53f1288
References: <20190212180342.32040-1-s.nawrocki@samsung.com>
        <CGME20190212180524epcas1p41b5845cef4c81798f4a07fe8c53f1288@epcas1p4.samsung.com>
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
index 1156d63ce923..72282d08d2c1 100644
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

