Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B916C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542F1214C1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwycYfHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 542F1214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbeLEJt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:49:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:55466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729079AbeLEJtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:49:22 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2594B213A2;
        Wed,  5 Dec 2018 09:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003360;
        bh=QY8VT7vqMLpyrIVw5GhULXe3VsvNgJmmbBdDz0br5XM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hwycYfHZGk/TlE/X6ndoNnINoEMu2U5kvF/JMSAVwUAPAfXme/N2cCEV8VtQhvN2X
         3iJqFiY5pcluTgazTb2kCBuLtoKneZiz5621VHp+6LF2sTFf5LhwssUs9xlu+eORcw
         7sz2skFqEUFcA6FLCHeQTLkrnk/ec5Dmowg+C5oc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 09/45] ASoC: omap-abe-twl6040: Fix missing audio card caused by deferred probing
Date:   Wed,  5 Dec 2018 04:46:30 -0500
Message-Id: <20181205094706.7225-9-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205094706.7225-1-sashal@kernel.org>
References: <20181205094706.7225-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

[ Upstream commit 76836fd354922ebe4798a64fda01f8dc6a8b0984 ]

The machine driver fails to probe in next-20181113 with:

[    2.539093] omap-abe-twl6040 sound: ASoC: CODEC DAI twl6040-legacy not registered
[    2.546630] omap-abe-twl6040 sound: devm_snd_soc_register_card() failed: -517
...
[    3.693206] omap-abe-twl6040 sound: ASoC: Both platform name/of_node are set for TWL6040
[    3.701446] omap-abe-twl6040 sound: ASoC: failed to init link TWL6040
[    3.708007] omap-abe-twl6040 sound: devm_snd_soc_register_card() failed: -22
[    3.715148] omap-abe-twl6040: probe of sound failed with error -22

Bisect pointed to a merge commit:
first bad commit: [0f688ab20a540aafa984c5dbd68a71debebf4d7f] Merge remote-tracking branch 'net-next/master'

and a diff between a working kernel does not reveal anything which would
explain the change in behavior.

Further investigation showed that on the second try of loading fails
because the dai_link->platform is no longer NULL and it might be pointing
to uninitialized memory.

The fix is to move the snd_soc_dai_link and snd_soc_card inside of the
abe_twl6040 struct, which is dynamically allocated every time the driver
probes.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/omap/omap-abe-twl6040.c | 67 +++++++++++++------------------
 1 file changed, 29 insertions(+), 38 deletions(-)

diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index 89fe95e877db..07af30017b48 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -36,6 +36,8 @@
 #include "../codecs/twl6040.h"
 
 struct abe_twl6040 {
+	struct snd_soc_card card;
+	struct snd_soc_dai_link dai_links[2];
 	int	jack_detection;	/* board can detect jack events */
 	int	mclk_freq;	/* MCLK frequency speed for twl6040 */
 };
@@ -208,40 +210,10 @@ static int omap_abe_dmic_init(struct snd_soc_pcm_runtime *rtd)
 				ARRAY_SIZE(dmic_audio_map));
 }
 
-/* Digital audio interface glue - connects codec <--> CPU */
-static struct snd_soc_dai_link abe_twl6040_dai_links[] = {
-	{
-		.name = "TWL6040",
-		.stream_name = "TWL6040",
-		.codec_dai_name = "twl6040-legacy",
-		.codec_name = "twl6040-codec",
-		.init = omap_abe_twl6040_init,
-		.ops = &omap_abe_ops,
-	},
-	{
-		.name = "DMIC",
-		.stream_name = "DMIC Capture",
-		.codec_dai_name = "dmic-hifi",
-		.codec_name = "dmic-codec",
-		.init = omap_abe_dmic_init,
-		.ops = &omap_abe_dmic_ops,
-	},
-};
-
-/* Audio machine driver */
-static struct snd_soc_card omap_abe_card = {
-	.owner = THIS_MODULE,
-
-	.dapm_widgets = twl6040_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(twl6040_dapm_widgets),
-	.dapm_routes = audio_map,
-	.num_dapm_routes = ARRAY_SIZE(audio_map),
-};
-
 static int omap_abe_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	struct snd_soc_card *card = &omap_abe_card;
+	struct snd_soc_card *card;
 	struct device_node *dai_node;
 	struct abe_twl6040 *priv;
 	int num_links = 0;
@@ -252,12 +224,18 @@ static int omap_abe_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	card->dev = &pdev->dev;
-
 	priv = devm_kzalloc(&pdev->dev, sizeof(struct abe_twl6040), GFP_KERNEL);
 	if (priv == NULL)
 		return -ENOMEM;
 
+	card = &priv->card;
+	card->dev = &pdev->dev;
+	card->owner = THIS_MODULE;
+	card->dapm_widgets = twl6040_dapm_widgets;
+	card->num_dapm_widgets = ARRAY_SIZE(twl6040_dapm_widgets);
+	card->dapm_routes = audio_map;
+	card->num_dapm_routes = ARRAY_SIZE(audio_map);
+
 	if (snd_soc_of_parse_card_name(card, "ti,model")) {
 		dev_err(&pdev->dev, "Card name is not provided\n");
 		return -ENODEV;
@@ -274,14 +252,27 @@ static int omap_abe_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "McPDM node is not provided\n");
 		return -EINVAL;
 	}
-	abe_twl6040_dai_links[0].cpu_of_node = dai_node;
-	abe_twl6040_dai_links[0].platform_of_node = dai_node;
+
+	priv->dai_links[0].name = "DMIC";
+	priv->dai_links[0].stream_name = "TWL6040";
+	priv->dai_links[0].cpu_of_node = dai_node;
+	priv->dai_links[0].platform_of_node = dai_node;
+	priv->dai_links[0].codec_dai_name = "twl6040-legacy";
+	priv->dai_links[0].codec_name = "twl6040-codec";
+	priv->dai_links[0].init = omap_abe_twl6040_init;
+	priv->dai_links[0].ops = &omap_abe_ops;
 
 	dai_node = of_parse_phandle(node, "ti,dmic", 0);
 	if (dai_node) {
 		num_links = 2;
-		abe_twl6040_dai_links[1].cpu_of_node = dai_node;
-		abe_twl6040_dai_links[1].platform_of_node = dai_node;
+		priv->dai_links[1].name = "TWL6040";
+		priv->dai_links[1].stream_name = "DMIC Capture";
+		priv->dai_links[1].cpu_of_node = dai_node;
+		priv->dai_links[1].platform_of_node = dai_node;
+		priv->dai_links[1].codec_dai_name = "dmic-hifi";
+		priv->dai_links[1].codec_name = "dmic-codec";
+		priv->dai_links[1].init = omap_abe_dmic_init;
+		priv->dai_links[1].ops = &omap_abe_dmic_ops;
 	} else {
 		num_links = 1;
 	}
@@ -300,7 +291,7 @@ static int omap_abe_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	card->dai_link = abe_twl6040_dai_links;
+	card->dai_link = priv->dai_links;
 	card->num_links = num_links;
 
 	snd_soc_card_set_drvdata(card, priv);
-- 
2.17.1

