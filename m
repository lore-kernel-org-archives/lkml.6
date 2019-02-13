Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DA8C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3590D222D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="l2AIA5Rh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405869AbfBMSnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:43:22 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:46983 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405841AbfBMSnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:43:18 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190213184315epoutp01cc8b4fc074676b220b75700c19d56cf2~DAKKrUJ8a2255422554epoutp01h;
        Wed, 13 Feb 2019 18:43:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190213184315epoutp01cc8b4fc074676b220b75700c19d56cf2~DAKKrUJ8a2255422554epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550083395;
        bh=B1AtEhhTMy3xB0W+/1ELKHiXPJz4MxJed1jVqQtyFL0=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=l2AIA5RhVVft4CumFLt6KYcbBm8AeG69tZSNugAy+3rsQLzxNvHw7JRbft5xnr9vK
         103TnaA0q0heV44N+fULpQE+y9PjGHQC7Wqaq0ac35tTfgaXYmfmrXcTvr5BWnUQkV
         fo9qCGTMyAkzoG/z2kKPRuKbrg/o3LkLB9tqq3PE=
Received: from epsmges1p1.samsung.com (unknown [182.195.42.53]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190213184314epcas1p30f4d6a3119af32022f3868495c0a1afa~DAKJpglIh2300523005epcas1p3F;
        Wed, 13 Feb 2019 18:43:14 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        9F.10.04074.245646C5; Thu, 14 Feb 2019 03:43:14 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190213184313epcas1p4d40c267289cd3ff64879a224b91da6d0~DAKJVlakk0477004770epcas1p48;
        Wed, 13 Feb 2019 18:43:13 +0000 (GMT)
X-AuditID: b6c32a35-297ff70000000fea-f6-5c64654233e6
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id B7.CE.04015.145646C5; Thu, 14 Feb
        2019 03:43:13 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMV00HOONZ3WX60@mmp2.samsung.com>; Thu, 14 Feb 2019
        03:43:13 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 06/13] ASoC: samsung: odroid: Add support for secondary
 CPU DAI
Date:   Wed, 13 Feb 2019 19:42:05 +0100
Message-id: <20190213184212.5473-7-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190213184212.5473-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWy7bCmga5TakqMwaMT/BZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6MpR8a2Qq+mVUsnneKrYGxW7eLkZND
        QsBEYtLRdWwgtpDADkaJgweUuxi5gOzvQPbrc2wwRWc232OESGxglLj+fgcLhPOLUeL26+8s
        IFVsAoYSvUf7GEFsEQExidtzOplBipgFWpgk5sxdygySEBYIkeifvwOsgUVAVWLr6b1gcV4B
        K4lf+y8wQqyTl1i94QBYnFPAWuLf2ufsIIMkBBawSXSvv8EOUeQi8WXiUqAGDiBbWuLSUVuI
        cLXEru3dzBD1HYwSLRe2M0MkrCUOH7/ICmIzC/BJvPvawwrRyyvR0SYEUeIhMeP6CyaIz/oY
        JV58eMA6gVFiASPDKkax1ILi3PTUYsMCQ73ixNzi0rx0veT83E2M4CjUMt3BOOWczyFGAQ5G
        JR7eCqGUGCHWxLLiytxDjBIczEoivHpRQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK86x2cY4QE
        0hNLUrNTUwtSi2CyTBycUg2M7D8smo7Jb/d0mxn41OtQt66CS9UihR0OnTsvx213P8TnGMj7
        7/baRfJTQ3aUPpzQljg7esOu8Bydz6s+5d9U35BTnVN3zOTV9I6p5r+Yrx+xeNsgMefJuhqe
        d9H2cXcrju1v4WtM478e9sFON3mVjsg7360MG+SulvwTDRTcp9Y59TrDCsZ1SizFGYmGWsxF
        xYkAip1tEb4CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDLMWRmVeSWpSXmKPExsVy+t9jQV3H1JQYg6XNJhZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6MpR8a2Qq+mVUsnneKrYGxW7eLkZND
        QsBE4szme4xdjFwcQgLrGCW+fXzJBOH8YpR4uLiREaSKTcBQovdoH5gtIiAmcXtOJzNIEbNA
        E5PErtsX2UESwgIhElf2P2EDsVkEVCW2nt7LDGLzClhJ/Np/gRFinbzE6g0HwOKcAtYS/9Y+
        B+sVAqqZ+OES8wRGngWMDKsYJVMLinPTc4uNCgzzUsv1ihNzi0vz0vWS83M3MQLDbNthrb4d
        jPeXxB9iFOBgVOLhVRBIiRFiTSwrrsw9xCjBwawkwqsXBRTiTUmsrEotyo8vKs1JLT7EKM3B
        oiTOezvvWKSQQHpiSWp2ampBahFMlomDU6qBcbYak9u5TVGvAy/7Gx5ZV9s/45YV66ysXWcl
        nobsfXVIMrTg8PccBq61s1ZyPbRovFHQcqd737Gs/x7Mixa/qvq/8bml4lsWbqeb1+aqJe3k
        0Bc4Pzf3D+/r+udHGvgva0UwlQYovJNPfnBq0RePBLUZ/6r2hT9daCoWtOvry4TrUulRia6i
        YUosxRmJhlrMRcWJANqo454vAgAA
X-CMS-MailID: 20190213184313epcas1p4d40c267289cd3ff64879a224b91da6d0
CMS-TYPE: 101P
X-CMS-RootMailID: 20190213184313epcas1p4d40c267289cd3ff64879a224b91da6d0
References: <20190213184212.5473-1-s.nawrocki@samsung.com>
        <CGME20190213184313epcas1p4d40c267289cd3ff64879a224b91da6d0@epcas1p4.samsung.com>
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
2.17.1

