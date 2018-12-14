Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC9DC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3B42086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bwUa5lzR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Pq92H0Bf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A3B42086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbeLNKB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:01:59 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34244 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeLNKB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:01:58 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D752660908; Fri, 14 Dec 2018 10:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544781717;
        bh=MDdzNnCyavSco/A4gQtzIpTyw0zQ4CnT3d5VBHUA+Yc=;
        h=From:To:Cc:Subject:Date:From;
        b=bwUa5lzRaJNRB6xLyf2x5caNUju6q3Jgm8TW5egS7ZqB1dc2JFW2KlwuF+iKd6q+y
         0M7IflC1EpwDIAb85yE5sqYTkKWCYym9kX23UZJnWhSKzLutQZxnA79GKF+EtWXvSj
         mXwsaInqMzj+JFxx7ld3LfuynxRi37cVgBi8kAmA=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8189D60722;
        Fri, 14 Dec 2018 10:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544781716;
        bh=MDdzNnCyavSco/A4gQtzIpTyw0zQ4CnT3d5VBHUA+Yc=;
        h=From:To:Cc:Subject:Date:From;
        b=Pq92H0Bfy5tonGDXYgd+A+BzHshaJ/ea3elCs/X9QyGVo6xe/PC1PU/skOsVc0l/z
         GVOOFm9NTVksTN25kQRxZ1Ib79v5FC5SUyOnbRsRv5C6NShflMkRGC1xdvcickSkLo
         Bi2j1ADDEhtOwRybokrsXdR/SEOqWYofnxsAHTtc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8189D60722
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     plai@codeaurora.org, bgoswami@codeaurora.org,
        asishb@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com,
        srinivas.kandagatla@linaro.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH] ASoC: sdm845: set jack only for a specific backend
Date:   Fri, 14 Dec 2018 15:31:43 +0530
Message-Id: <1544781703-9585-1-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Headset codec is connected over PRIMARY_MI2S interface. Call
set_jack for codec associated with Primary Mi2s interface.
Also, set_jack to NULL when jack is freed.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/sdm845.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 1db8ef66..6f66a58 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -158,17 +158,24 @@ static int sdm845_snd_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
+static void sdm845_jack_free(struct snd_jack *jack)
+{
+	struct snd_soc_component *component = jack->private_data;
+
+	snd_soc_component_set_jack(component, NULL, NULL);
+}
+
 static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_component *component;
-	struct snd_soc_dai_link *dai_link = rtd->dai_link;
 	struct snd_soc_card *card = rtd->card;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct sdm845_snd_data *pdata = snd_soc_card_get_drvdata(card);
-	int i, rval;
+	struct snd_jack *jack;
+	int rval;
 
 	if (!pdata->jack_setup) {
-		struct snd_jack *jack;
-
 		rval = snd_soc_card_jack_new(card, "Headset Jack",
 				SND_JACK_HEADSET |
 				SND_JACK_HEADPHONE |
@@ -190,16 +197,22 @@ static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
 		pdata->jack_setup = true;
 	}
 
-	for (i = 0 ; i < dai_link->num_codecs; i++) {
-		struct snd_soc_dai *dai = rtd->codec_dais[i];
+	switch (cpu_dai->id) {
+	case PRIMARY_MI2S_RX:
+		jack  = pdata->jack.jack;
+		component = codec_dai->component;
 
-		component = dai->component;
-		rval = snd_soc_component_set_jack(
-				component, &pdata->jack, NULL);
+		jack->private_data = component;
+		jack->private_free = sdm845_jack_free;
+		rval = snd_soc_component_set_jack(component,
+						  &pdata->jack, NULL);
 		if (rval != 0 && rval != -ENOTSUPP) {
 			dev_warn(card->dev, "Failed to set jack: %d\n", rval);
 			return rval;
 		}
+		break;
+	default:
+		break;
 	}
 
 	return 0;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

