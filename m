Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF9113F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CCE20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pKVq/CfG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AmcWhyfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3CCE20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeG3Lpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:45:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42610 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeG3Lpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:45:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 62FE4619B6; Mon, 30 Jul 2018 10:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532945489;
        bh=BbMgLHib2nnNi0oQ7ekegsVtAId0SsjXLAn5rbxrlYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pKVq/CfG6u9xO+jkKCgL3TqKCz9x48ZhdGtapK3yq4pOJmeUKDJBiyWrjrtULrcWc
         D1S+WsIRp0JuRhuZWqU0YvJGy3RhLNKHuvKfkKS/3jBgaGMfnFhqzm+K1MJPTgVIVJ
         uQJ/ACx5Z6+1DCp0vLk5vD5vJhpiXwaxAaikpBwY=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 640F1619BD;
        Mon, 30 Jul 2018 10:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532945487;
        bh=BbMgLHib2nnNi0oQ7ekegsVtAId0SsjXLAn5rbxrlYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AmcWhyfpOnx3+mwSSid9rajIUcpLrP4LfaUgOfV8GmjgHxPMRxzUBPTliHN5n595P
         SVCFKKS9XTqimpCgByr/J3t/TKR4vkLGEPduW487chVsengKujgwaf5EvjBpg931LY
         FsjYyl9BdX1sjlcyOPODb51C8zn3nA/QdewggNP0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 640F1619BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v4 3/4] ASoC: qcom: Add support to parse common audio device nodes
Date:   Mon, 30 Jul 2018 15:40:53 +0530
Message-Id: <1532945454-10437-4-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532945454-10437-1-git-send-email-rohitkr@codeaurora.org>
References: <1532945454-10437-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support to parse cpu, platform and codec
device nodes and add them in dai-links. Also, update
apq8096 machine driver to use the common API.

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/Makefile  |   2 +-
 sound/soc/qcom/apq8096.c | 111 +++++-----------------------------------------
 sound/soc/qcom/common.c  | 112 +++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/common.h  |  12 +++++
 4 files changed, 136 insertions(+), 101 deletions(-)
 create mode 100644 sound/soc/qcom/common.c
 create mode 100644 sound/soc/qcom/common.h

diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
index 206945b..fefecc0 100644
--- a/sound/soc/qcom/Makefile
+++ b/sound/soc/qcom/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_SND_SOC_LPASS_APQ8016) += snd-soc-lpass-apq8016.o
 # Machine
 snd-soc-storm-objs := storm.o
 snd-soc-apq8016-sbc-objs := apq8016_sbc.o
-snd-soc-apq8096-objs := apq8096.o
+snd-soc-apq8096-objs := apq8096.o common.o
 
 obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
 obj-$(CONFIG_SND_SOC_APQ8016_SBC) += snd-soc-apq8016-sbc.o
diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index a561562..1e4a90d 100644
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
-
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
+	struct snd_soc_dai_link *link = card->dai_link;
+	int i, num_links = card->num_links;
 
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
 
 static int apq8096_platform_probe(struct platform_device *pdev)
@@ -142,18 +50,21 @@ static int apq8096_platform_probe(struct platform_device *pdev)
 	card->dev = dev;
 	card->auto_bind = true;
 	dev_set_drvdata(dev, card);
-	ret = apq8096_sbc_parse_of(card);
+	ret = qcom_snd_parse_of(card);
 	if (ret) {
 		dev_err(dev, "Error parsing OF data\n");
 		goto err;
 	}
 
+	apq8096_add_be_ops(card);
 	ret = snd_soc_register_card(card);
 	if (ret)
-		goto err;
+		goto err_card_register;
 
 	return 0;
 
+err_card_register:
+	kfree(card->dai_link);
 err:
 	kfree(card);
 	return ret;
diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
new file mode 100644
index 0000000..eb1b9da
--- /dev/null
+++ b/sound/soc/qcom/common.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, Linaro Limited.
+// Copyright (c) 2018, The Linux Foundation. All rights reserved.
+
+#include <linux/module.h>
+#include "common.h"
+
+int qcom_snd_parse_of(struct snd_soc_card *card)
+{
+	struct device_node *np;
+	struct device_node *codec = NULL;
+	struct device_node *platform = NULL;
+	struct device_node *cpu = NULL;
+	struct device *dev = card->dev;
+	struct snd_soc_dai_link *link;
+	int ret, num_links;
+
+	ret = snd_soc_of_parse_card_name(card, "model");
+	if (ret) {
+		dev_err(dev, "Error parsing card name: %d\n", ret);
+		return ret;
+	}
+
+	/* DAPM routes */
+	if (of_property_read_bool(dev->of_node, "audio-routing")) {
+		ret = snd_soc_of_parse_audio_routing(card,
+				"audio-routing");
+		if (ret)
+			return ret;
+	}
+
+	/* Populate links */
+	num_links = of_get_child_count(dev->of_node);
+
+	/* Allocate the DAI link array */
+	card->dai_link = kcalloc(num_links, sizeof(*link), GFP_KERNEL);
+	if (!card->dai_link)
+		return -ENOMEM;
+
+	card->num_links = num_links;
+	link = card->dai_link;
+	for_each_child_of_node(dev->of_node, np) {
+		cpu = of_get_child_by_name(np, "cpu");
+		if (!cpu) {
+			dev_err(dev, "Can't find cpu DT node\n");
+			ret = -EINVAL;
+			goto err;
+		}
+
+		link->cpu_of_node = of_parse_phandle(cpu, "sound-dai", 0);
+		if (!link->cpu_of_node) {
+			dev_err(card->dev, "error getting cpu phandle\n");
+			ret = -EINVAL;
+			goto err;
+		}
+
+		ret = snd_soc_of_get_dai_name(cpu, &link->cpu_dai_name);
+		if (ret) {
+			dev_err(card->dev, "error getting cpu dai name\n");
+			goto err;
+		}
+
+		platform = of_get_child_by_name(np, "platform");
+		codec = of_get_child_by_name(np, "codec");
+		if (codec && platform) {
+			link->platform_of_node = of_parse_phandle(platform,
+					"sound-dai",
+					0);
+			if (!link->platform_of_node) {
+				dev_err(card->dev, "platform dai not found\n");
+				ret = -EINVAL;
+				goto err;
+			}
+
+			ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
+			if (ret < 0) {
+				dev_err(card->dev, "codec dai not found\n");
+				goto err;
+			}
+			link->no_pcm = 1;
+			link->ignore_pmdown_time = 1;
+		} else {
+			link->platform_of_node = link->cpu_of_node;
+			link->codec_dai_name = "snd-soc-dummy-dai";
+			link->codec_name = "snd-soc-dummy";
+			link->dynamic = 1;
+		}
+
+		link->ignore_suspend = 1;
+		ret = of_property_read_string(np, "link-name", &link->name);
+		if (ret) {
+			dev_err(card->dev, "error getting codec dai_link name\n");
+			goto err;
+		}
+
+		link->dpcm_playback = 1;
+		link->dpcm_capture = 1;
+		link->stream_name = link->name;
+		link++;
+	}
+
+	return 0;
+err:
+	of_node_put(cpu);
+	of_node_put(codec);
+	of_node_put(platform);
+	kfree(card->dai_link);
+	return ret;
+}
+EXPORT_SYMBOL(qcom_snd_parse_of);
+
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/qcom/common.h b/sound/soc/qcom/common.h
new file mode 100644
index 0000000..ad5d2cf
--- /dev/null
+++ b/sound/soc/qcom/common.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (c) 2018, The Linux Foundation. All rights reserved.
+
+#ifndef __QCOM_SND_COMMON_H__
+#define __QCOM_SND_COMMON_H__
+
+#include <linux/component.h>
+#include <sound/soc.h>
+
+int qcom_snd_parse_of(struct snd_soc_card *card);
+
+#endif
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

