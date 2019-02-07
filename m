Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D39C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC5C21908
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TMuQp7YL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfBGRBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:01:53 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:32125 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfBGRBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:01:49 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190207170146epoutp0321ba0c5a7aa5ffd07731aca3fadd2979~BI52mF0o60204102041epoutp03E;
        Thu,  7 Feb 2019 17:01:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190207170146epoutp0321ba0c5a7aa5ffd07731aca3fadd2979~BI52mF0o60204102041epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549558906;
        bh=17PT2mwYeZ1xIdmx14GcCgntVpOPFfO7GPS5kzEuzD8=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=TMuQp7YLgNeZqHLuFnhdhIDIYy1ocSAex9C1CaMPkELWW+/OPAMX8gHDuj+/VYPmz
         DNZL/6qzuhAOr/zljdYZdXchIBusFEl/nRIZzfcm2j+baxevmH0ep2kFUyCV8bodwn
         0EiPB6Ce44RBM8SmFZttnKnpAXxWhbR8rlqJUdys=
Received: from epsmges1p4.samsung.com (unknown [182.195.42.56]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190207170145epcas1p11ec47d3714aecb68f3213798f217a8b6~BI51qzojl2132521325epcas1p1d;
        Thu,  7 Feb 2019 17:01:45 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        6F.E9.04288.9746C5C5; Fri,  8 Feb 2019 02:01:45 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190207170145epcas1p465da0715aa629b525c17d263c1b49a68~BI51M1G2o1456614566epcas1p4V;
        Thu,  7 Feb 2019 17:01:45 +0000 (GMT)
X-AuditID: b6c32a38-c0fff700000010c0-a6-5c5c6479c123
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.D8.04015.9746C5C5; Fri,  8 Feb 2019 02:01:45 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMK00MP9F8VXL10@mmp1.samsung.com>; Fri, 08 Feb 2019
        02:01:45 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 17/22] ASoC: samsung: odroid: Add support for secondary CPU
 DAI
Date:   Thu, 07 Feb 2019 18:00:25 +0100
Message-id: <20190207170028.720-18-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190207170028.720-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7bCmvm5lSkyMwe8nmhZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6MHd/3shWcMKs4PK+DuYHxgU4XIyeH
        hICJxM3ZT5i6GLk4hAR2MEps67/CCuF8Z5RoWrKTCabqc9dydhBbSGA3o8S9AwoQRb8YJd7N
        X88IkmATMJToPdoHZosIiEncntPJDFLELNDCJDFn7lJmkISwQKDEhMudYFNZBFQljh2+BNbA
        K2AlcfPlPzaIbfIS53vXgW3jBIrf2r+DBaJGUOLH5HtgNjNQzcErz1lAFkgIHGCT2Nm8mxWi
        2UXi40mQUzmAbGmJS0dtIcLVEru2dzND1HcwSrRc2M4MkbCWOHz8IivEUD6Jd197WCF6eSU6
        2oQgSjwkbjStYIH4uJdRYsX7NywTGKVmIblpFpKbFjAyrWIUSy0ozk1PLTYsMNErTswtLs1L
        10vOz93ECI5yLYsdjHvO+RxiFOBgVOLhvaAdEyPEmlhWXJl7iFGCg1lJhFc2ASjEm5JYWZVa
        lB9fVJqTWnyIUZqDRUmcd72Dc4yQQHpiSWp2ampBahFMlomDU6qBMcf+2Ofalk/9bz+rv30v
        XXExvqqW/7afVJ9qYZijadypORb7j2b1ruds3MN82aaO9dtp9jzZNZGWznY37sWXFH3cwm86
        4dkW16dHDZfNt/crOLAj8pz/upf5bSGPlTXZ5k+8Ht3Mu//RFYm5/I0zIu1+7/m86nJYGI+7
        0O8Snrsdk69M1nsfp8RSnJFoqMVcVJwIABF75BHuAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsVy+t9jAd3KlJgYg1kXeSyuXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZO77vZSs4YVZxeF4HcwPjA50uRk4O
        CQETic9dy9m7GLk4hAR2Mkocvv6WESQhJPCLUWLTWjcQm03AUKL3aB9YXERATOL2nE5mkAZm
        gSYmiV23L7KDJIQF/CUuttxmArFZBFQljh2+BNbAK2AlcfPlPzaIbfIS53vXgdVzAsVv7d/B
        ArHMUuLDhCZWiHpBiR+T74HFmYHqD155zjKBkW8WktQsJKkFjEyrGCVTC4pz03OLjQoM81LL
        9YoTc4tL89L1kvNzNzECg3jbYa2+HYz3l8QfYhTgYFTi4b2gHRMjxJpYVlyZe4hRgoNZSYRX
        NgEoxJuSWFmVWpQfX1Sak1p8iFGag0VJnPd23rFIIYH0xJLU7NTUgtQimCwTB6dUA2P5uk8G
        +p9O8WllxnsqvxHW5t93hdXC5udkLQnG3S87Xq/aptAVkrOujOHTuoVLhW4euM176VKg08e0
        0+FLDV/2SZ3UTI3UrlbcF3J3wnqVGYzRpd9q/H8ejZ7ad37a8pyAHQkNa6948zsyTlVY2rRz
        86QVfJ9r7ZIzKpfPkr+vE99u8vZqtJgSS3FGoqEWc1FxIgDNrzu4XgIAAA==
X-CMS-MailID: 20190207170145epcas1p465da0715aa629b525c17d263c1b49a68
CMS-TYPE: 101P
X-CMS-RootMailID: 20190207170145epcas1p465da0715aa629b525c17d263c1b49a68
References: <20190207170028.720-1-s.nawrocki@samsung.com>
        <CGME20190207170145epcas1p465da0715aa629b525c17d263c1b49a68@epcas1p4.samsung.com>
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
---
 sound/soc/samsung/odroid.c | 132 +++++++++++++++++++++++++++----------
 1 file changed, 96 insertions(+), 36 deletions(-)

diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
index e7b371b07230..bab61e8278a0 100644
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
@@ -86,19 +90,56 @@ static int odroid_card_hw_params(struct snd_pcm_substream *substream,
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
 
+
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
@@ -130,45 +171,67 @@ static int odroid_audio_probe(struct platform_device *pdev)
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
@@ -182,10 +245,8 @@ static int odroid_audio_probe(struct platform_device *pdev)
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
 
@@ -193,8 +254,7 @@ static int odroid_audio_remove(struct platform_device *pdev)
 {
 	struct odroid_priv *priv = platform_get_drvdata(pdev);
 
-	of_node_put(priv->dai_link.cpu_of_node);
-	snd_soc_of_put_dai_link_codecs(&priv->dai_link);
+	snd_soc_of_put_dai_link_codecs(&priv->card.dai_link[1]);
 	clk_put(priv->sclk_i2s);
 	clk_put(priv->clk_i2s_bus);
 
-- 
2.20.1

