Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68861C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B2C2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LDAJlg3S";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LDAJlg3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbeLXJCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:02:41 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55528 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbeLXJCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:02:40 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CA96C60860; Mon, 24 Dec 2018 09:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545642159;
        bh=vtLZncxWXI2fpvOk6FjiVicLTSFJjDKstvFRM1s9lRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LDAJlg3S2cV7/hpXiqdXRd9D97wLMYXZRd7QkRJw0q9TgDk25NA7UDl8sZvzn2ltG
         kk7OBPdAPPxolZpo8FnE8DQW4jcT/fKYehhebob4Y2mB4psNtPJ9qElPlvzE5RVsUY
         zbJVjUZ7Q+YulHyb3XEhERVTQZl3nJkjc6GTPKNo=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 22CFF60929;
        Mon, 24 Dec 2018 09:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545642159;
        bh=vtLZncxWXI2fpvOk6FjiVicLTSFJjDKstvFRM1s9lRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LDAJlg3S2cV7/hpXiqdXRd9D97wLMYXZRd7QkRJw0q9TgDk25NA7UDl8sZvzn2ltG
         kk7OBPdAPPxolZpo8FnE8DQW4jcT/fKYehhebob4Y2mB4psNtPJ9qElPlvzE5RVsUY
         zbJVjUZ7Q+YulHyb3XEhERVTQZl3nJkjc6GTPKNo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 22CFF60929
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
Subject: [PATCH 2/2] ASoC: qcom: defer probe if platform dai is not registered
Date:   Mon, 24 Dec 2018 14:32:13 +0530
Message-Id: <1545642133-16120-3-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545642133-16120-1-git-send-email-rohitkr@codeaurora.org>
References: <1545642133-16120-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ajit Pandey <ajitp@codeaurora.org>

Platform DAI component probe is not called if it is not
present in component list during sound card registration.
Check if component is registered for platform dai before
soundcard registration.

Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/common.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index 4715527..9e98458 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -11,6 +11,7 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 	struct device_node *codec = NULL;
 	struct device_node *platform = NULL;
 	struct device_node *cpu = NULL;
+	struct snd_soc_component *component = NULL;
 	struct device *dev = card->dev;
 	struct snd_soc_dai_link *link;
 	struct of_phandle_args args;
@@ -75,6 +76,14 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 				goto err;
 			}
 
+			component = snd_soc_of_lookup_component
+						(link->platform_of_node);
+			if (!component) {
+				ret = -EPROBE_DEFER;
+				dev_err(card->dev, "platform DAI not registered\n");
+				goto err;
+			}
+
 			ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
 			if (ret < 0) {
 				dev_err(card->dev, "codec dai not found\n");
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

