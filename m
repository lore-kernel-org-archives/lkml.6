Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0FDC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DAA62145B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Z/d2ZlIb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i439Yfg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DAA62145B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754114AbeGFJoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:44:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51856 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753457AbeGFJoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:44:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 91F5660B3C; Fri,  6 Jul 2018 09:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530870244;
        bh=4Bqyi48A71jaCwwsyCuVx6t7+s4g6cWVoi01BPrfe7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z/d2ZlIb7b59NcxpYUCm39FVXLMe5P6StkMOawS4YsxHaCPJIFVGUxNRB39TnXwqb
         /htCy41uMRiYVpGZqQ/Zwe55ENhZ6PN9Vqx9djOJJnD0XP2JFkF6wTSFanUaEFurR8
         gQTzpRIMOgQDc82eNrSOAIukPok2TA1cYa3xr04o=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8C32060B27;
        Fri,  6 Jul 2018 09:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530870243;
        bh=4Bqyi48A71jaCwwsyCuVx6t7+s4g6cWVoi01BPrfe7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i439Yfg3WIFi83E8vciuKu+rFNX8dtgOtYLNbwc5UhhFayzNqvpLXPboBDAL4kh2E
         21xnAo//RqgJnFxu7W2ji91avhtg4UohwPx+4KoPFLICLaP7TLChb2/bP04wKKuGdK
         6hw+a2PAvRio/KzjgwtrX66cjrdXLgN8cxkjGKpI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8C32060B27
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v3 5/5] ASoC: qcom: apq8096: Use common APIs to parse device nodes
Date:   Fri,  6 Jul 2018 15:13:15 +0530
Message-Id: <1530870195-13576-6-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use generic APIs exposed by common.c for parsing
dai link device tree nodes and adding slave components.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/Kconfig   |   1 +
 sound/soc/qcom/apq8096.c | 151 ++++-------------------------------------------
 2 files changed, 11 insertions(+), 141 deletions(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index cf55f0a..2be9cee 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -86,6 +86,7 @@ config SND_SOC_MSM8996
 	tristate "SoC Machine driver for MSM8996 and APQ8096 boards"
 	depends on QCOM_APR
 	select SND_SOC_QDSP6
+	select SND_SOC_QCOM_COMMON
 	help
           Support for Qualcomm Technologies LPASS audio block in
           APQ8096 SoC-based systems.
diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index cab8c4f..726fb73 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -9,6 +9,7 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include <sound/pcm.h>
+#include "common.h"
 
 static int apq8096_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 				      struct snd_pcm_hw_params *params)
@@ -24,109 +25,16 @@ static int apq8096_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-static int apq8096_sbc_parse_of(struct snd_soc_card *card)
+static void apq8096_add_be_ops(struct snd_soc_card *card)
 {
-	struct device_node *np;
-	struct device_node *codec = NULL;
-	struct device_node *platform = NULL;
-	struct device_node *cpu = NULL;
-	struct device *dev = card->dev;
-	struct snd_soc_dai_link *link;
-	int ret, num_links;
-
-	ret = snd_soc_of_parse_card_name(card, "qcom,model");
-	if (ret) {
-		dev_err(dev, "Error parsing card name: %d\n", ret);
-		return ret;
-	}
+	struct snd_soc_dai_link *link = card->dai_link;
+	int i, num_links = card->num_links;
 
-	/* DAPM routes */
-	if (of_property_read_bool(dev->of_node, "qcom,audio-routing")) {
-		ret = snd_soc_of_parse_audio_routing(card,
-					"qcom,audio-routing");
-		if (ret)
-			return ret;
-	}
-
-	/* Populate links */
-	num_links = of_get_child_count(dev->of_node);
-
-	/* Allocate the DAI link array */
-	card->dai_link = kcalloc(num_links, sizeof(*link), GFP_KERNEL);
-	if (!card->dai_link)
-		return -ENOMEM;
-
-	card->num_links	= num_links;
-	link = card->dai_link;
-
-	for_each_child_of_node(dev->of_node, np) {
-		cpu = of_get_child_by_name(np, "cpu");
-		if (!cpu) {
-			dev_err(dev, "Can't find cpu DT node\n");
-			ret = -EINVAL;
-			goto err;
-		}
-
-		link->cpu_of_node = of_parse_phandle(cpu, "sound-dai", 0);
-		if (!link->cpu_of_node) {
-			dev_err(card->dev, "error getting cpu phandle\n");
-			ret = -EINVAL;
-			goto err;
-		}
-
-		ret = snd_soc_of_get_dai_name(cpu, &link->cpu_dai_name);
-		if (ret) {
-			dev_err(card->dev, "error getting cpu dai name\n");
-			goto err;
-		}
-
-		platform = of_get_child_by_name(np, "platform");
-		codec = of_get_child_by_name(np, "codec");
-		if (codec && platform) {
-			link->platform_of_node = of_parse_phandle(platform,
-								  "sound-dai",
-								   0);
-			if (!link->platform_of_node) {
-				dev_err(card->dev, "platform dai not found\n");
-				ret = -EINVAL;
-				goto err;
-			}
-
-			ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
-			if (ret < 0) {
-				dev_err(card->dev, "codec dai not found\n");
-				goto err;
-			}
-			link->no_pcm = 1;
-			link->ignore_pmdown_time = 1;
+	for (i = 0; i < num_links; i++) {
+		if (link->no_pcm == 1)
 			link->be_hw_params_fixup = apq8096_be_hw_params_fixup;
-		} else {
-			link->platform_of_node = link->cpu_of_node;
-			link->codec_dai_name = "snd-soc-dummy-dai";
-			link->codec_name = "snd-soc-dummy";
-			link->dynamic = 1;
-		}
-
-		link->ignore_suspend = 1;
-		ret = of_property_read_string(np, "link-name", &link->name);
-		if (ret) {
-			dev_err(card->dev, "error getting codec dai_link name\n");
-			goto err;
-		}
-
-		link->dpcm_playback = 1;
-		link->dpcm_capture = 1;
-		link->stream_name = link->name;
 		link++;
 	}
-
-	return 0;
-err:
-	of_node_put(cpu);
-	of_node_put(codec);
-	of_node_put(platform);
-	kfree(card->dai_link);
-	return ret;
 }
 
 static int apq8096_bind(struct device *dev)
@@ -141,12 +49,14 @@ static int apq8096_bind(struct device *dev)
 	component_bind_all(dev, card);
 	card->dev = dev;
 	dev_set_drvdata(dev, card);
-	ret = apq8096_sbc_parse_of(card);
+	ret = qcom_snd_parse_of(card);
 	if (ret) {
 		dev_err(dev, "Error parsing OF data\n");
 		goto err;
 	}
 
+	apq8096_add_be_ops(card);
+
 	ret = snd_soc_register_card(card);
 	if (ret)
 		goto err;
@@ -174,53 +84,12 @@ static void apq8096_unbind(struct device *dev)
 	.unbind = apq8096_unbind,
 };
 
-static int apq8016_compare_of(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
-static void apq8016_release_of(struct device *dev, void *data)
-{
-	of_node_put(data);
-}
-
-static int add_audio_components(struct device *dev,
-				struct component_match **matchptr)
-{
-	struct device_node *np, *platform, *cpu, *node, *dai_node;
-
-	node = dev->of_node;
-
-	for_each_child_of_node(node, np) {
-		cpu = of_get_child_by_name(np, "cpu");
-		if (cpu) {
-			dai_node = of_parse_phandle(cpu, "sound-dai", 0);
-			of_node_get(dai_node);
-			component_match_add_release(dev, matchptr,
-						    apq8016_release_of,
-						    apq8016_compare_of,
-						    dai_node);
-		}
-
-		platform = of_get_child_by_name(np, "platform");
-		if (platform) {
-			dai_node = of_parse_phandle(platform, "sound-dai", 0);
-			component_match_add_release(dev, matchptr,
-						    apq8016_release_of,
-						    apq8016_compare_of,
-						    dai_node);
-		}
-	}
-
-	return 0;
-}
-
 static int apq8096_platform_probe(struct platform_device *pdev)
 {
 	struct component_match *match = NULL;
 	int ret;
 
-	ret = add_audio_components(&pdev->dev, &match);
+	ret = qcom_snd_add_components(&pdev->dev, &match);
 	if (ret)
 		return ret;
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

