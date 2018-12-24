Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CEAC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF712171F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="htnFEDbj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NNqUO6r+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbeLXJCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:02:35 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55408 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbeLXJCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:02:34 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CF74160928; Mon, 24 Dec 2018 09:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545642153;
        bh=sqv/7b07JMffuJ9eCQnJP3l5cw7GMu9D8JvslewsM3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=htnFEDbjaLhGh7wgqUuMzjbYkf12npMTTlYvmsWBC7jDAMXYvzI0yHNH+KrXTHTTw
         Fk70QnXd3HCEr6UHt04W7Fx89jJhDjeWIYcXZiXVgxii29RFUKaCS6ccMxp+gA+USL
         Y9hwZWv5dLul3Rkh5Q3Hfm9I9czajVGYD2bomLWs=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 01E95608D4;
        Mon, 24 Dec 2018 09:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545642152;
        bh=sqv/7b07JMffuJ9eCQnJP3l5cw7GMu9D8JvslewsM3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NNqUO6r+O6jJKsPbw1FBb95GeOv6KKjfZcYTzrkRiNOyX0Pa1nDuWLWChz4xUiwQa
         qCRzS6jR3AqmP54VkHFAoDKGM2yKDu+O6vEz+VUdJt4tA58vg3zPFh5b3Fuj2qc9hf
         4IZtxdWU9wwd3LHg98cyqhOfosoz91g07VqhQyqo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01E95608D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     plai@codeaurora.org, bgoswami@codeaurora.org,
        asishb@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com,
        srinivas.kandagatla@linaro.org
Cc:     Ajit Pandey <ajitp@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH 1/2] ASoC: soc-core: add snd_soc_of_lookup_component()
Date:   Mon, 24 Dec 2018 14:32:12 +0530
Message-Id: <1545642133-16120-2-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545642133-16120-1-git-send-email-rohitkr@codeaurora.org>
References: <1545642133-16120-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ajit Pandey <ajitp@codeaurora.org>

Soundcard should be registered after all components are registered.
Add snd_soc_of_lookup_component() to get component info from
device_node. This can be used by machine driver to make sure that
card components are registered before calling snd_soc_register_card().

Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 include/sound/soc.h  |  1 +
 sound/soc/soc-core.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 8ec1de8..dc251fc 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1502,6 +1502,7 @@ int snd_soc_get_dai_name(struct of_phandle_args *args,
 			 const char **dai_name);
 int snd_soc_of_get_dai_name(struct device_node *of_node,
 			    const char **dai_name);
+struct snd_soc_component *snd_soc_of_lookup_component(struct device_node *np);
 int snd_soc_of_get_dai_link_codecs(struct device *dev,
 				   struct device_node *of_node,
 				   struct snd_soc_dai_link *dai_link);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0462b3e..ab27bc5 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3797,6 +3797,34 @@ int snd_soc_of_get_dai_name(struct device_node *of_node,
 EXPORT_SYMBOL_GPL(snd_soc_of_get_dai_name);
 
 /*
+ * snd_soc_of_lookup_component - Lookup component with device node
+ * @np: device node pointer
+ *
+ * This function looks up component based on given of_node
+ *
+ * Returns valid component pointer on success and NULL on failure to find one.
+ */
+struct snd_soc_component *snd_soc_of_lookup_component(struct device_node *np)
+{
+	struct snd_soc_component *component = NULL;
+	bool found = false;
+
+	if (!np)
+		return NULL;
+
+	mutex_lock(&client_mutex);
+	for_each_component(component)
+		if (component->dev->of_node == np) {
+			found = true;
+			break;
+		}
+	mutex_unlock(&client_mutex);
+
+	return found ? component : NULL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_of_lookup_component);
+
+/*
  * snd_soc_of_put_dai_link_codecs - Dereference device nodes in the codecs array
  * @dai_link: DAI link
  *
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

