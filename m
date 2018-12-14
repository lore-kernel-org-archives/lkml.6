Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F479C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4FE20879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790294;
	bh=u92rlPul16IER3UlZBGxGOwdKR4ae+C96SjJp+UpjRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bc5MkNzuY09N8qix8Rmra7SRR1nx8FiSryHOOrss/n9NU5fyxxn5v5eQtx+8r9e82
	 jO1xRv+Ujo2ZOu22nf8+xbbSzfnygLkyC68b+5a+731jC3NYwC2ED/eWdRVvd/Eyi/
	 HBF+VxTZtQ/uMUv0RlD8PXyz5uTNg8yS9o+ooScw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4FE20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731787AbeLNMMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:12:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:59898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731731AbeLNMMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:12:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60813214D9;
        Fri, 14 Dec 2018 12:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789558;
        bh=u92rlPul16IER3UlZBGxGOwdKR4ae+C96SjJp+UpjRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TnoxKX+IROA7097Ocz2gfXdZ1+wkuFz5x5GI7YVKkKp6CDxcfFG3di8jky0Htguf5
         wNuZKVfkIquQhnqZtCl2/zJx4geqy8prbH3YM/jV11j22gzFSdMWKZfwPEfuXOg5MS
         hKZDXaLUOetrpOxW2ykqc+x+BEfpCSxOqtDG49eM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 18/51] ASoC: omap-abe-twl6040: Fix missing audio card caused by deferred probing
Date:   Fri, 14 Dec 2018 13:00:20 +0100
Message-Id: <20181214115715.060186373@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115713.244259772@linuxfoundation.org>
References: <20181214115713.244259772@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1



