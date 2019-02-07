Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E145C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE09721872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uFN+Gtr3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfBGRBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:01:09 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:10795 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfBGRBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:01:06 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190207170102epoutp04dc5ee21ded3c40792725ab5a0ceb766a~BI5NeNO_Z2868228682epoutp04O;
        Thu,  7 Feb 2019 17:01:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190207170102epoutp04dc5ee21ded3c40792725ab5a0ceb766a~BI5NeNO_Z2868228682epoutp04O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549558862;
        bh=qVz4QuhurXb56dPzooLLoVuLMR5l8arJ+uVcU3lmGlU=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=uFN+Gtr3925ZyYXPDtIM0VLhFfJO8WYMU7V+I4V6YDR380zUH6pulbes+NeOa/eTg
         GXiEGWXMJlz+S2FPeyJJvIi8QNHhGvsEWPEu0Ls/Z2ZNE/Ly9fdODuGlL56ZPcgJrm
         MKlvR2OlzqYsBpMJ176FzYkqPr8m+p/Qk+HI4aYQ=
Received: from epsmges1p2.samsung.com (unknown [182.195.42.54]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190207170102epcas1p14210d05d81bf4614ed62779d6c7819fb~BI5NPmZl11636416364epcas1p1o;
        Thu,  7 Feb 2019 17:01:02 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.C9.04173.E446C5C5; Fri,  8 Feb 2019 02:01:02 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190207170102epcas1p445f2a5d8e70bc3a6e42424034c2eb34a~BI5NC_7C31053310533epcas1p47;
        Thu,  7 Feb 2019 17:01:02 +0000 (GMT)
X-AuditID: b6c32a36-5d9ff7000000104d-0b-5c5c644ea85e
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.C8.04015.D446C5C5; Fri,  8 Feb 2019 02:01:02 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMK00MP9F8VXL10@mmp1.samsung.com>; Fri, 08 Feb 2019
        02:01:01 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 05/22] ASoC: samsung: i2s: Convert to single component with
 multiple DAIs
Date:   Thu, 07 Feb 2019 18:00:13 +0100
Message-id: <20190207170028.720-6-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190207170028.720-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsWy7bCmrq5fSkyMQXuzqMWVi4eYLDbOWM9q
        MfXhEzaL8+c3sFt8u9LBZHF51xw2ixnn9zFZrD1yl93i8Jt2VouLK74wOXB5bPjcxOaxc9Zd
        do9NqzrZPPq2rGL0+LxJLoA1issmJTUnsyy1SN8ugStjwvUp7AX/4yr2L9nM3sC4x6+LkZND
        QsBEYsH/0yxdjFwcQgI7GCVWbDnHBJIQEvjOKNG5yQimaN2MOUwQRbsZJVZvncsM4fxilLi6
        ppkFpIpNwFCi92gfI4gtIiAmcXtOJ1gRs0ALk8ScuUuBHA4OYYFoiQnN+SA1LAKqEpsnfmAD
        sXkFLCUef5rDCLFNXuJ87zp2EJtTwEri1v4dLBA1ghI/Jt8Ds5mBag5eeQ52toTAETaJHUt/
        MEM0u0gsOniZDWSXhIC0xKWjthDhaold27uZIeo7GCVaLmyHqreWOHz8IivEUD6Jd197WCF6
        eSU62oQgSjwknl1fzgjxcC+jxNcNrewTGKVmIblpFpKbFjAyrWIUSy0ozk1PLTYsMNIrTswt
        Ls1L10vOz93ECI5xLbMdjIvO+RxiFOBgVOLh1dCLiRFiTSwrrsw9xCjBwawkwiubABTiTUms
        rEotyo8vKs1JLT7EKM3BoiTOu97BOUZIID2xJDU7NbUgtQgmy8TBKdXAyMj4u/2V4fbFP+OU
        hVZMk4rZafCN89ede7OcBN6GJ3Veuirdp/2+u6T13d9JvHURM6dUM8gv1/kZOFP8io9+UGra
        s4evVD2cWN5f07J38rB9mPu4QsFQZOYHlfM/6yedOTbVs+vqG4me71t+Na1Y/U/O6Nvk3ys+
        cFSW6hXUaFwKl9g+8b3YGSWW4oxEQy3mouJEAAeHLX7tAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsVy+t9jAV2/lJgYg7ZDbBZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6MCdensBf8j6vYv2QzewPjHr8uRk4O
        CQETiXUz5jB1MXJxCAnsZJS4d+c1K4Tzi1Hi/pZP7CBVbAKGEr1H+xhBbBEBMYnbczqZQYqY
        BZqYJHbdvghUxMEhLBAtMaE5H6SGRUBVYvPED2wgNq+ApcTjT3MYIbbJS5zvXQc2k1PASuLW
        /h0sILYQUM2HCU2sEPWCEj8m3wOLMwPVH7zynGUCI98sJKlZSFILGJlWMUqmFhTnpucWGxUY
        5qWW6xUn5haX5qXrJefnbmIEBvG2w1p9OxjvL4k/xCjAwajEw3tBOyZGiDWxrLgy9xCjBAez
        kgivbAJQiDclsbIqtSg/vqg0J7X4EKM0B4uSOO/tvGORQgLpiSWp2ampBalFMFkmDk6pBsaQ
        n9v9BasKNnmd4Mwz8VURy/jyLbfo3MxqdY33wden3Mz2D+u86JB/eVH3rx/qIdozNq0XC1/j
        stGLyS1sbtvP5ZtStO0eC8dc/7HkMPv/8imTbBTeXjJVTD/SH/RGZ9GTYPVqgYaunxfK7vCU
        qvy7+sjhy4slO5vPMk7W229vebGxyvaWubsSS3FGoqEWc1FxIgASE9yuXgIAAA==
X-CMS-MailID: 20190207170102epcas1p445f2a5d8e70bc3a6e42424034c2eb34a
CMS-TYPE: 101P
X-CMS-RootMailID: 20190207170102epcas1p445f2a5d8e70bc3a6e42424034c2eb34a
References: <20190207170028.720-1-s.nawrocki@samsung.com>
        <CGME20190207170102epcas1p445f2a5d8e70bc3a6e42424034c2eb34a@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes minimal changes as a prerequisite for adding support
for the Exynos secondary I2S interface as second DAI of the I2S component.
Doing it that way allows to avoid problems as indicated in commmit
6b01e0365b1689 ("ASoC: samsung: i2s: disable secondary DAI until it gets fixed")

The samsung_i2s_get_pri_dai() helper added in this patch is temporary and
will be removed in one of subsequent patches.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c | 192 ++++++++++++++++++++++++----------------
 1 file changed, 115 insertions(+), 77 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index d5ddad23d5e5..4bc3b181f1c2 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -34,6 +34,9 @@
 
 #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
 
+#define SAMSUNG_I2S_ID_PRIMARY		1
+#define SAMSUNG_I2S_ID_SECONDARY	2
+
 struct samsung_i2s_variant_regs {
 	unsigned int	bfs_off;
 	unsigned int	rfs_off;
@@ -79,8 +82,10 @@ struct i2s_dai {
 #define DAI_OPENED	(1 << 0) /* Dai is opened */
 #define DAI_MANAGER	(1 << 1) /* Dai is the manager */
 	unsigned mode;
+
 	/* Driver for this DAI */
-	struct snd_soc_dai_driver i2s_dai_drv;
+	struct snd_soc_dai_driver *drv;
+
 	/* DMA parameters */
 	struct snd_dmaengine_dai_dma_data dma_playback;
 	struct snd_dmaengine_dai_dma_data dma_capture;
@@ -92,8 +97,6 @@ struct i2s_dai {
 	u32	suspend_i2spsr;
 	const struct samsung_i2s_variant_regs *variant_regs;
 
-	/* Spinlock protecting access to the device's registers */
-	spinlock_t spinlock;
 	spinlock_t *lock;
 
 	/* Below fields are only valid if this is the primary FIFO */
@@ -104,10 +107,29 @@ struct i2s_dai {
 /* Lock for cross i/f checks */
 static DEFINE_SPINLOCK(lock);
 
-/* If this is the 'overlay' stereo DAI */
+struct samsung_i2s_priv {
+	struct platform_device *pdev;
+
+	/* Spinlock protecting access to the device's registers */
+	spinlock_t spinlock;
+
+	/* CPU DAIs and their corresponding drivers */
+	struct i2s_dai *dai;
+	struct snd_soc_dai_driver *dai_drv;
+	int num_dais;
+};
+
+struct i2s_dai *samsung_i2s_get_pri_dai(struct device *dev)
+{
+	struct samsung_i2s_priv *priv = dev_get_drvdata(dev);
+
+	return &priv->dai[SAMSUNG_I2S_ID_PRIMARY - 1];
+}
+
+/* Returns true if this is the 'overlay' stereo DAI */
 static inline bool is_secondary(struct i2s_dai *i2s)
 {
-	return i2s->pri_dai ? true : false;
+	return i2s->drv->id == SAMSUNG_I2S_ID_SECONDARY;
 }
 
 /* If operating in SoC-Slave mode */
@@ -202,7 +224,9 @@ static inline bool any_active(struct i2s_dai *i2s)
 
 static inline struct i2s_dai *to_info(struct snd_soc_dai *dai)
 {
-	return snd_soc_dai_get_drvdata(dai);
+	struct samsung_i2s_priv *priv = snd_soc_dai_get_drvdata(dai);
+
+	return &priv->dai[dai->id - 1];
 }
 
 static inline bool is_opened(struct i2s_dai *i2s)
@@ -1065,7 +1089,7 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 
 static int samsung_i2s_dai_remove(struct snd_soc_dai *dai)
 {
-	struct i2s_dai *i2s = snd_soc_dai_get_drvdata(dai);
+	struct i2s_dai *i2s = to_info(dai);
 	unsigned long flags;
 
 	pm_runtime_get_sync(dai->dev);
@@ -1102,47 +1126,63 @@ static const struct snd_soc_component_driver samsung_i2s_component = {
 					SNDRV_PCM_FMTBIT_S16_LE | \
 					SNDRV_PCM_FMTBIT_S24_LE)
 
-static struct i2s_dai *i2s_alloc_dai(struct platform_device *pdev,
-				const struct samsung_i2s_dai_data *i2s_dai_data,
-				bool sec)
+static int i2s_alloc_dais(struct samsung_i2s_priv *priv,
+			  const struct samsung_i2s_dai_data *i2s_dai_data,
+			  int num_dais)
 {
-	struct i2s_dai *i2s;
-
-	i2s = devm_kzalloc(&pdev->dev, sizeof(struct i2s_dai), GFP_KERNEL);
-	if (i2s == NULL)
-		return NULL;
-
-	i2s->pdev = pdev;
-	i2s->pri_dai = NULL;
-	i2s->sec_dai = NULL;
-	i2s->i2s_dai_drv.id = 1;
-	i2s->i2s_dai_drv.symmetric_rates = 1;
-	i2s->i2s_dai_drv.probe = samsung_i2s_dai_probe;
-	i2s->i2s_dai_drv.remove = samsung_i2s_dai_remove;
-	i2s->i2s_dai_drv.ops = &samsung_i2s_dai_ops;
-	i2s->i2s_dai_drv.suspend = i2s_suspend;
-	i2s->i2s_dai_drv.resume = i2s_resume;
-	i2s->i2s_dai_drv.playback.channels_min = 1;
-	i2s->i2s_dai_drv.playback.channels_max = 2;
-	i2s->i2s_dai_drv.playback.rates = i2s_dai_data->pcm_rates;
-	i2s->i2s_dai_drv.playback.formats = SAMSUNG_I2S_FMTS;
-
-	if (!sec) {
-		i2s->i2s_dai_drv.name = SAMSUNG_I2S_DAI;
-		i2s->i2s_dai_drv.capture.channels_min = 1;
-		i2s->i2s_dai_drv.capture.channels_max = 2;
-		i2s->i2s_dai_drv.capture.rates = i2s_dai_data->pcm_rates;
-		i2s->i2s_dai_drv.capture.formats = SAMSUNG_I2S_FMTS;
-	} else {
-		i2s->i2s_dai_drv.name = SAMSUNG_I2S_DAI_SEC;
+	static const char *dai_names[] = { "samsung-i2s", "samsung-i2s-sec" };
+	struct snd_soc_dai_driver *dai_drv;
+	struct i2s_dai *dai;
+	int i;
+
+	priv->dai = devm_kcalloc(&priv->pdev->dev, num_dais,
+				     sizeof(*dai), GFP_KERNEL);
+	if (!priv->dai)
+		return -ENOMEM;
+
+	priv->dai_drv = devm_kcalloc(&priv->pdev->dev, num_dais,
+				     sizeof(*dai_drv), GFP_KERNEL);
+	if (!priv->dai_drv)
+		return -ENOMEM;
+
+	for (i = 0; i < num_dais; i++) {
+		dai_drv = &priv->dai_drv[i];
+
+		dai_drv->probe = samsung_i2s_dai_probe;
+		dai_drv->remove = samsung_i2s_dai_remove;
+		dai_drv->suspend = i2s_suspend;
+		dai_drv->resume = i2s_resume;
+
+		dai_drv->symmetric_rates = 1;
+		dai_drv->ops = &samsung_i2s_dai_ops;
+
+		dai_drv->playback.channels_min = 1;
+		dai_drv->playback.channels_max = 2;
+		dai_drv->playback.rates = i2s_dai_data->pcm_rates;
+		dai_drv->playback.formats = SAMSUNG_I2S_FMTS;
+
+		dai_drv->id = i + 1;
+		dai_drv->name = dai_names[i];
+
+		priv->dai[i].drv = &priv->dai_drv[i];
+		priv->dai[i].pdev = priv->pdev;
 	}
-	return i2s;
+
+	/* Initialize capture only for the primary DAI */
+	dai_drv = &priv->dai_drv[SAMSUNG_I2S_ID_PRIMARY - 1];
+
+	dai_drv->capture.channels_min = 1;
+	dai_drv->capture.channels_max = 2;
+	dai_drv->capture.rates = i2s_dai_data->pcm_rates;
+	dai_drv->capture.formats = SAMSUNG_I2S_FMTS;
+
+	return 0;
 }
 
 #ifdef CONFIG_PM
 static int i2s_runtime_suspend(struct device *dev)
 {
-	struct i2s_dai *i2s = dev_get_drvdata(dev);
+	struct i2s_dai *i2s = samsung_i2s_get_pri_dai(dev);
 
 	i2s->suspend_i2smod = readl(i2s->addr + I2SMOD);
 	i2s->suspend_i2scon = readl(i2s->addr + I2SCON);
@@ -1157,7 +1197,7 @@ static int i2s_runtime_suspend(struct device *dev)
 
 static int i2s_runtime_resume(struct device *dev)
 {
-	struct i2s_dai *i2s = dev_get_drvdata(dev);
+	struct i2s_dai *i2s = samsung_i2s_get_pri_dai(dev);
 	int ret;
 
 	ret = clk_prepare_enable(i2s->clk);
@@ -1192,7 +1232,7 @@ static void i2s_unregister_clocks(struct i2s_dai *i2s)
 
 static void i2s_unregister_clock_provider(struct platform_device *pdev)
 {
-	struct i2s_dai *i2s = dev_get_drvdata(&pdev->dev);
+	struct i2s_dai *i2s = samsung_i2s_get_pri_dai(&pdev->dev);
 
 	of_clk_del_provider(pdev->dev.of_node);
 	i2s_unregister_clocks(i2s);
@@ -1200,11 +1240,12 @@ static void i2s_unregister_clock_provider(struct platform_device *pdev)
 
 static int i2s_register_clock_provider(struct platform_device *pdev)
 {
+
 	const char * const i2s_clk_desc[] = { "cdclk", "rclk_src", "prescaler" };
 	const char *clk_name[2] = { "i2s_opclk0", "i2s_opclk1" };
 	const char *p_names[2] = { NULL };
 	struct device *dev = &pdev->dev;
-	struct i2s_dai *i2s = dev_get_drvdata(dev);
+	struct i2s_dai *i2s = samsung_i2s_get_pri_dai(dev);
 	const struct samsung_i2s_variant_regs *reg_info = i2s->variant_regs;
 	const char *i2s_clk_name[ARRAY_SIZE(i2s_clk_desc)];
 	struct clk *rclksrc;
@@ -1279,7 +1320,8 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	u32 regs_base, quirks = 0, idma_addr = 0;
 	struct device_node *np = pdev->dev.of_node;
 	const struct samsung_i2s_dai_data *i2s_dai_data;
-	int ret;
+	int num_dais, ret;
+	struct samsung_i2s_priv *priv;
 
 	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node)
 		i2s_dai_data = of_device_get_match_data(&pdev->dev);
@@ -1287,14 +1329,24 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		i2s_dai_data = (struct samsung_i2s_dai_data *)
 				platform_get_device_id(pdev)->driver_data;
 
-	pri_dai = i2s_alloc_dai(pdev, i2s_dai_data, false);
-	if (!pri_dai) {
-		dev_err(&pdev->dev, "Unable to alloc I2S_pri\n");
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
 		return -ENOMEM;
-	}
 
-	spin_lock_init(&pri_dai->spinlock);
-	pri_dai->lock = &pri_dai->spinlock;
+	quirks = np ? i2s_dai_data->quirks : i2s_pdata->type.quirks;
+	quirks &= ~(QUIRK_SEC_DAI | QUIRK_SUPPORTS_IDMA);
+
+	num_dais = (quirks & QUIRK_SEC_DAI) ? 2 : 1;
+	priv->pdev = pdev;
+
+	ret = i2s_alloc_dais(priv, i2s_dai_data, num_dais);
+	if (ret < 0)
+		return ret;
+
+	pri_dai = &priv->dai[SAMSUNG_I2S_ID_PRIMARY - 1];
+
+	spin_lock_init(&priv->spinlock);
+	pri_dai->lock = &priv->spinlock;
 
 	if (!np) {
 		if (i2s_pdata == NULL) {
@@ -1306,10 +1358,8 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		pri_dai->dma_capture.filter_data = i2s_pdata->dma_capture;
 		pri_dai->filter = i2s_pdata->dma_filter;
 
-		quirks = i2s_pdata->type.quirks;
 		idma_addr = i2s_pdata->type.idma_addr;
 	} else {
-		quirks = i2s_dai_data->quirks;
 		if (of_property_read_u32(np, "samsung,idma-addr",
 					 &idma_addr)) {
 			if (quirks & QUIRK_SUPPORTS_IDMA) {
@@ -1318,7 +1368,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 			}
 		}
 	}
-	quirks &= ~(QUIRK_SEC_DAI | QUIRK_SUPPORTS_IDMA);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pri_dai->addr = devm_ioremap_resource(&pdev->dev, res);
@@ -1348,28 +1397,17 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	pri_dai->variant_regs = i2s_dai_data->i2s_variant_regs;
 
 	if (quirks & QUIRK_PRI_6CHAN)
-		pri_dai->i2s_dai_drv.playback.channels_max = 6;
+		pri_dai->drv->playback.channels_max = 6;
 
 	ret = samsung_asoc_dma_platform_register(&pdev->dev, pri_dai->filter,
 						 NULL, NULL, NULL);
 	if (ret < 0)
 		goto err_disable_clk;
 
-	ret = devm_snd_soc_register_component(&pdev->dev,
-					&samsung_i2s_component,
-					&pri_dai->i2s_dai_drv, 1);
-	if (ret < 0)
-		goto err_disable_clk;
-
 	if (quirks & QUIRK_SEC_DAI) {
-		sec_dai = i2s_alloc_dai(pdev, i2s_dai_data, true);
-		if (!sec_dai) {
-			dev_err(&pdev->dev, "Unable to alloc I2S_sec\n");
-			ret = -ENOMEM;
-			goto err_disable_clk;
-		}
+		sec_dai = &priv->dai[SAMSUNG_I2S_ID_SECONDARY - 1];
 
-		sec_dai->lock = &pri_dai->spinlock;
+		sec_dai->lock = &priv->spinlock;
 		sec_dai->variant_regs = pri_dai->variant_regs;
 		sec_dai->dma_playback.addr = regs_base + I2STXDS;
 		sec_dai->dma_playback.chan_name = "tx-sec";
@@ -1392,11 +1430,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		if (ret < 0)
 			goto err_disable_clk;
 
-		ret = devm_snd_soc_register_component(&pdev->dev,
-						&samsung_i2s_component,
-						&sec_dai->i2s_dai_drv, 1);
-		if (ret < 0)
-			goto err_disable_clk;
 	}
 
 	if (i2s_pdata && i2s_pdata->cfg_gpio && i2s_pdata->cfg_gpio(pdev)) {
@@ -1405,7 +1438,13 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 	}
 
-	dev_set_drvdata(&pdev->dev, pri_dai);
+	dev_set_drvdata(&pdev->dev, priv);
+
+	ret = devm_snd_soc_register_component(&pdev->dev,
+					&samsung_i2s_component,
+					priv->dai_drv, num_dais);
+	if (ret < 0)
+		goto err_disable_clk;
 
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
@@ -1427,9 +1466,8 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 
 static int samsung_i2s_remove(struct platform_device *pdev)
 {
-	struct i2s_dai *pri_dai;
-
-	pri_dai = dev_get_drvdata(&pdev->dev);
+	struct samsung_i2s_priv *priv = dev_get_drvdata(&pdev->dev);
+	struct i2s_dai *pri_dai = samsung_i2s_get_pri_dai(&pdev->dev);
 
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.20.1

