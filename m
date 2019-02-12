Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94D0C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9634F2229F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Gdl0nkFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbfBLSF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:05:28 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:22580 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731750AbfBLSF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:05:26 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190212180523epoutp02f276963bc4b63488d43a2ed37bd3d352~Cr-0X8PUp3105631056epoutp02E;
        Tue, 12 Feb 2019 18:05:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190212180523epoutp02f276963bc4b63488d43a2ed37bd3d352~Cr-0X8PUp3105631056epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549994723;
        bh=pAuxs1+EkB2/mHJcleCycRr4HTG+NJd9biU+Idi/yPw=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=Gdl0nkFtDzL6CVclNSNNRcw7d2auKjQldrqYZPUdtpCpAGtHsrcUn1Gt2Z8AX7CGT
         wsy7jrusdjyAUBJY7/s8c5TlshelPTFlgFdqAM0Lk3/EuiomC8RiPjikPdHfdUwqvk
         K9nQ1wjckX+F9J5gDop71O4w7GKnjYwCXn22F65U=
Received: from epsmges2p4.samsung.com (unknown [182.195.42.72]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20190212180522epcas2p43831895b90c6314cca08a73ba1d406b8~Cr-zkkmjR2309023090epcas2p4A;
        Tue, 12 Feb 2019 18:05:22 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.1D.04093.2EA036C5; Wed, 13 Feb 2019 03:05:22 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190212180521epcas2p3d3a637804b82c8d537be98a399e1ba7b~Cr-yTfXwI0149801498epcas2p3Y;
        Tue, 12 Feb 2019 18:05:21 +0000 (GMT)
X-AuditID: b6c32a48-18bff70000000ffd-fd-5c630ae23112
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 8A.30.03689.0EA036C5; Wed, 13 Feb
        2019 03:05:21 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMT0024XRJ2FB10@mmp2.samsung.com>; Wed, 13 Feb 2019
        03:05:20 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 12/21] ASoC: samsung: odroid: Add support for secondary
 CPU DAI
Date:   Tue, 12 Feb 2019 19:03:33 +0100
Message-id: <20190212180342.32040-13-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190212180342.32040-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsWy7bCmhe4jruQYg6s7xC2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZu38eZCr4ZlYxryG5gbFbt4uRk0NC
        wETiXs82pi5GLg4hgR2MEtNOb2aDcL4zSjxfvpANpqrx3FcWiMQGRolXj74yQzi/GCX+zlnD
        BFLFJmAo0Xu0jxHEFhEQk7g9pxOsiFmghUliztylzCAJYYEQiQvtL1hBbBYBVYmrCx6zgNi8
        AjYSz9/3MEOsk5c437uOHcTmBIo/W/gNqkZQ4sfke2A2M1DNwSvPwU6SEDjAJrHp22dGiGYX
        ieaO6+wQtrTEs1UboeLVEru2dzNDNHQwSrRc2A61zVri8PGLrBBT+SQ6Dv8FauYAivNKdLQJ
        QZR4SOw68goaSv2MErfmrGSewCg1C8lRs5ActYCRaRWjWGpBcW56arFRgYlecWJucWleul5y
        fu4mRnCca3nsYDxwzucQowAHoxIP74qjSTFCrIllxZW5hxglOJiVRHjTmJNjhHhTEiurUovy
        44tKc1KLDzFKc7AoifM+lJ4bLSSQnliSmp2aWpBaBJNl4uCUamAMuXgjKzYqyDbs4Iyamgt2
        S+wbPmYo/t/qu0m2f3mk8xU7k5jSgJ6dFieZJvNY+fut9Nv9N9lzzVONmbPPHFt+rWLNtjoO
        dcVZbU8d192Y3ra6cmU+z/dKrfj+5/LVumeviDG5vZz54/d0b6lLP8SFvnRpX+d5/MSVQVTe
        d86eT3su3bmWveuFEktxRqKhFnNRcSIAUo4m1e8CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t9jQd2HXMkxBj/bGC2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZu38eZCr4ZlYxryG5gbFbt4uRk0NC
        wESi8dxXli5GLg4hgXWMEvfnPYNyfjFKvNwxgwWkik3AUKL3aB8jiC0iICZxe04nM0gRs0AT
        k8Su2xfZQRLCAiESN9/dYAOxWQRUJa4ueAzWzCtgI/H8fQ8zxDp5ifO968DqOYHizxZ+A6rh
        ANpmLXFlky1EuaDEj8n3wFqZgcoPXnnOMoGRbxaS1CwkqQWMTKsYJVMLinPTc4uNCozyUsv1
        ihNzi0vz0vWS83M3MQJDeNthrf4djI+XxB9iFOBgVOLhXXE0KUaINbGsuDL3EKMEB7OSCG8a
        c3KMEG9KYmVValF+fFFpTmrxIUZpDhYlcV7+/GORQgLpiSWp2ampBalFMFkmDk6pBkaJ5JY3
        97UeX9i2NKn5FAdDwYvw8w83LnE+MWGFctfy9tsz7051cAicnLbb3aFh1tPvQcxFgoIan7iE
        FOdN2LhVbU3UxkPHphTZnUtfOtvPVudZqOIHySUxu/zaFl5hS/3OG/3u8eKMK/tzjZ0XzPrZ
        tsku4+u1M4zPA7arVq/49EXuknX/C6UIJZbijERDLeai4kQA8eBnxV0CAAA=
X-CMS-MailID: 20190212180521epcas2p3d3a637804b82c8d537be98a399e1ba7b
CMS-TYPE: 102P
X-CMS-RootMailID: 20190212180521epcas2p3d3a637804b82c8d537be98a399e1ba7b
References: <20190212180342.32040-1-s.nawrocki@samsung.com>
        <CGME20190212180521epcas2p3d3a637804b82c8d537be98a399e1ba7b@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DPCM links in order to support the secondary I2S interface.
For the secondary PCM interface to be actually available one more entry
should be added to the sound-dai property in sound/cpu node in DT.
The changes in driver are done in a way so we are backwards compatible with
existing DTS/DTB, i.e. if the cpu sound-dai property contains only one entry
only one PCM will be registered.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/odroid.c | 131 +++++++++++++++++++++++++++----------
 1 file changed, 95 insertions(+), 36 deletions(-)

diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
index e7b371b07230..18bb3bfe0300 100644
--- a/sound/soc/samsung/odroid.c
+++ b/sound/soc/samsung/odroid.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/module.h>
@@ -17,21 +18,24 @@
 
 struct odroid_priv {
 	struct snd_soc_card card;
-	struct snd_soc_dai_link dai_link;
-
 	struct clk *clk_i2s_bus;
 	struct clk *sclk_i2s;
 };
 
-static int odroid_card_startup(struct snd_pcm_substream *substream)
+static int odroid_card_fe_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	snd_pcm_hw_constraint_single(runtime, SNDRV_PCM_HW_PARAM_CHANNELS, 2);
+
 	return 0;
 }
 
-static int odroid_card_hw_params(struct snd_pcm_substream *substream,
+static const struct snd_soc_ops odroid_card_fe_ops = {
+	.startup = odroid_card_fe_startup,
+};
+
+static int odroid_card_be_hw_params(struct snd_pcm_substream *substream,
 				      struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -86,19 +90,55 @@ static int odroid_card_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static const struct snd_soc_ops odroid_card_ops = {
-	.startup = odroid_card_startup,
-	.hw_params = odroid_card_hw_params,
+static const struct snd_soc_ops odroid_card_be_ops = {
+	.hw_params = odroid_card_be_hw_params,
+};
+
+static struct snd_soc_dai_link odroid_card_dais[] = {
+	{
+		/* Primary FE <-> BE link */
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.ops = &odroid_card_fe_ops,
+		.name = "Primary",
+		.stream_name = "Primary",
+		.platform_name = "3830000.i2s",
+		.dynamic = 1,
+		.dpcm_playback = 1,
+	}, {
+		/* BE <-> CODECs link */
+		.name = "I2S Mixer",
+		.cpu_name = "snd-soc-dummy",
+		.cpu_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "snd-soc-dummy",
+		.ops = &odroid_card_be_ops,
+		.no_pcm = 1,
+		.dpcm_playback = 1,
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+				SND_SOC_DAIFMT_CBS_CFS,
+	}, {
+		/* Secondary FE <-> BE link */
+		.playback_only = 1,
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.ops = &odroid_card_fe_ops,
+		.name = "Secondary",
+		.stream_name = "Secondary",
+		.platform_name = "samsung-i2s-sec",
+		.dynamic = 1,
+		.dpcm_playback = 1,
+	}
 };
 
 static int odroid_audio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *cpu, *codec;
+	struct device_node *cpu, *cpu_dai, *codec;
 	struct odroid_priv *priv;
-	struct snd_soc_dai_link *link;
 	struct snd_soc_card *card;
-	int ret;
+	struct snd_soc_dai_link *link, *codec_link;
+	int num_pcms, ret, i;
+	struct of_phandle_args args = {};
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -130,45 +170,67 @@ static int odroid_audio_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	link = &priv->dai_link;
-
-	link->ops = &odroid_card_ops;
-	link->dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-			SND_SOC_DAIFMT_CBS_CFS;
-
-	card->dai_link = &priv->dai_link;
-	card->num_links = 1;
+	card->dai_link = odroid_card_dais;
+	card->num_links = ARRAY_SIZE(odroid_card_dais);
 
 	cpu = of_get_child_by_name(dev->of_node, "cpu");
 	codec = of_get_child_by_name(dev->of_node, "codec");
+	link = card->dai_link;
+	codec_link = &card->dai_link[1];
 
-	link->cpu_of_node = of_parse_phandle(cpu, "sound-dai", 0);
-	if (!link->cpu_of_node) {
-		dev_err(dev, "Failed parsing cpu/sound-dai property\n");
-		return -EINVAL;
+	/*
+	 * For backwards compatibility create the secondary CPU DAI link only
+	 * if there are 2 CPU DAI entries in the cpu sound-dai property in DT.
+	 */
+	num_pcms = of_count_phandle_with_args(cpu, "sound-dai",
+					      "#sound-dai-cells");
+	if (num_pcms == 1)
+		card->num_links--;
+
+	for (i = 0; i < num_pcms; i++, link += 2) {
+		ret = of_parse_phandle_with_args(cpu, "sound-dai",
+						 "#sound-dai-cells", i, &args);
+		if (ret < 0)
+			return ret;
+
+		if (!args.np) {
+			dev_err(dev, "sound-dai property parse error: %d\n", ret);
+			return -EINVAL;
+		}
+
+		ret = snd_soc_get_dai_name(&args, &link->cpu_dai_name);
+		of_node_put(args.np);
+
+		if (ret < 0)
+			return ret;
 	}
 
-	ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
+	cpu_dai = of_parse_phandle(cpu, "sound-dai", 0);
+	of_node_put(cpu);
+	of_node_put(codec);
+
+	ret = snd_soc_of_get_dai_link_codecs(dev, codec, codec_link);
 	if (ret < 0)
 		goto err_put_codec_n;
 
-	link->platform_of_node = link->cpu_of_node;
-
-	link->name = "Primary";
-	link->stream_name = link->name;
-
+	/* Set capture capability only for boards with the MAX98090 CODEC */
+	if (codec_link->num_codecs > 1) {
+		card->dai_link[0].dpcm_capture = 1;
+		card->dai_link[1].dpcm_capture = 1;
+	}
 
-	priv->sclk_i2s = of_clk_get_by_name(link->cpu_of_node, "i2s_opclk1");
+	priv->sclk_i2s = of_clk_get_by_name(cpu_dai, "i2s_opclk1");
 	if (IS_ERR(priv->sclk_i2s)) {
 		ret = PTR_ERR(priv->sclk_i2s);
-		goto err_put_i2s_n;
+		goto err_put_codec_n;
 	}
 
-	priv->clk_i2s_bus = of_clk_get_by_name(link->cpu_of_node, "iis");
+	priv->clk_i2s_bus = of_clk_get_by_name(cpu_dai, "iis");
 	if (IS_ERR(priv->clk_i2s_bus)) {
 		ret = PTR_ERR(priv->clk_i2s_bus);
 		goto err_put_sclk;
 	}
+	of_node_put(cpu_dai);
 
 	ret = devm_snd_soc_register_card(dev, card);
 	if (ret < 0) {
@@ -182,10 +244,8 @@ static int odroid_audio_probe(struct platform_device *pdev)
 	clk_put(priv->clk_i2s_bus);
 err_put_sclk:
 	clk_put(priv->sclk_i2s);
-err_put_i2s_n:
-	of_node_put(link->cpu_of_node);
 err_put_codec_n:
-	snd_soc_of_put_dai_link_codecs(link);
+	snd_soc_of_put_dai_link_codecs(codec_link);
 	return ret;
 }
 
@@ -193,8 +253,7 @@ static int odroid_audio_remove(struct platform_device *pdev)
 {
 	struct odroid_priv *priv = platform_get_drvdata(pdev);
 
-	of_node_put(priv->dai_link.cpu_of_node);
-	snd_soc_of_put_dai_link_codecs(&priv->dai_link);
+	snd_soc_of_put_dai_link_codecs(&priv->card.dai_link[1]);
 	clk_put(priv->sclk_i2s);
 	clk_put(priv->clk_i2s_bus);
 
-- 
2.20.1

