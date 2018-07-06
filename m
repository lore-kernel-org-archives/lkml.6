Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5A8C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1331220CAA
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NBn2/X/M";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EqkTTGSC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1331220CAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754049AbeGFJnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:43:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51346 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753612AbeGFJnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:43:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 10C3060B3C; Fri,  6 Jul 2018 09:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530870227;
        bh=+rDT/bNDWRqrbb6JlDfdcESomgdmiMHN1bTaa+rTn/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NBn2/X/MdocgfWOnZkNWKcoQLd+DeK8klZS2c15hVtxd/68Ci3Zq1ZTt1AUzAaeCP
         PtlL/s48F8S3U7ey6cNqhPDZADpPOLS+Poh6AMUeOcb/nE9kT3oVu0vK5S4Rw7NJnp
         iPJeoVBtOx3g95OW6fcvTdghgiUJCThFSHQxYd8I=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8473560251;
        Fri,  6 Jul 2018 09:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530870226;
        bh=+rDT/bNDWRqrbb6JlDfdcESomgdmiMHN1bTaa+rTn/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EqkTTGSCHrxF2jLqj48d9uJt9kdaan5p4Tsqsm7dWQlWtBhagNHn1WYcLHuQm69ZG
         3Vk2jhFwVYwWokapAMnLHKYFJjmANY1yNsZtbrb6KIL1wIPaCoaiWPvhP9MPcnGjrF
         rTZtILMpx+V41j2xPuniI2cBJPDRSuK5wCdW6uOM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8473560251
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v3 2/5] ASoC: qcom: Add support to parse common audio device nodes
Date:   Fri,  6 Jul 2018 15:13:12 +0530
Message-Id: <1530870195-13576-3-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support to parse cpu, platform and codec
device nodes and add them in dai-links. Also, add
API to add slave components associated with machine
driver.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/Kconfig  |   3 +
 sound/soc/qcom/Makefile |   1 +
 sound/soc/qcom/common.c | 150 ++++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/common.h |  14 +++++
 4 files changed, 168 insertions(+)
 create mode 100644 sound/soc/qcom/common.c
 create mode 100644 sound/soc/qcom/common.h

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 87838fa..0e364b4 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -90,3 +90,6 @@ config SND_SOC_MSM8996
           Support for Qualcomm Technologies LPASS audio block in
           APQ8096 SoC-based systems.
           Say Y if you want to use audio device on this SoCs
+
+config SND_SOC_QCOM_COMMON
+	tristate
diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
index 206945b..1bcdbee 100644
--- a/sound/soc/qcom/Makefile
+++ b/sound/soc/qcom/Makefile
@@ -19,5 +19,6 @@ obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
 obj-$(CONFIG_SND_SOC_APQ8016_SBC) += snd-soc-apq8016-sbc.o
 obj-$(CONFIG_SND_SOC_MSM8996) += snd-soc-apq8096.o
 
+obj-$(CONFIG_SND_SOC_QCOM_COMMON) += common.o
 #DSP lib
 obj-$(CONFIG_SND_SOC_QDSP6) += qdsp6/
diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
new file mode 100644
index 0000000..be62fca
--- /dev/null
+++ b/sound/soc/qcom/common.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, Linaro Limited.
+// Copyright (c) 2018, The Linux Foundation. All rights reserved.
+
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
+static int qcom_snd_compare_of(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+static void qcom_snd_release_of(struct device *dev, void *data)
+{
+	of_node_put(data);
+}
+
+int qcom_snd_add_components(struct device *dev, struct component_match **mptr)
+{
+	struct device_node *np, *platform, *cpu, *node, *dai_node;
+
+	node = dev->of_node;
+
+	for_each_child_of_node(node, np) {
+		cpu = of_get_child_by_name(np, "cpu");
+		if (cpu) {
+			dai_node = of_parse_phandle(cpu, "sound-dai", 0);
+			of_node_get(dai_node);
+			component_match_add_release(dev, mptr,
+					qcom_snd_release_of,
+					qcom_snd_compare_of,
+					dai_node);
+		}
+
+		platform = of_get_child_by_name(np, "platform");
+		if (platform) {
+			dai_node = of_parse_phandle(platform, "sound-dai", 0);
+			component_match_add_release(dev, mptr,
+					qcom_snd_release_of,
+					qcom_snd_compare_of,
+					dai_node);
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(qcom_snd_add_components);
diff --git a/sound/soc/qcom/common.h b/sound/soc/qcom/common.h
new file mode 100644
index 0000000..860c235
--- /dev/null
+++ b/sound/soc/qcom/common.h
@@ -0,0 +1,14 @@
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
+int qcom_snd_add_components(struct device *dev,
+			    struct component_match **matchptr);
+
+#endif
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

