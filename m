Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22FFECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8003120825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DZKJQxFy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SSjtN0wB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8003120825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbeKHXRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:17:24 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38740 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeKHXRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:17:24 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3D7266085F; Thu,  8 Nov 2018 13:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541684512;
        bh=4oiIGpiJtpEwziwSD/eEgiV3Q9ELAM3npTOPrHigjDQ=;
        h=From:To:Cc:Subject:Date:From;
        b=DZKJQxFyafFUdwO8fIzK/rE1wosT1qNYZxdzOWvvZPQ/grjEs7F5Pei2KZHvfUeDi
         kb2DXygTT8+vjt3TVJ0ad525Lwm+U4rGpxF1GhUPeBqG3MS2set+NxJmj8o5+YB+dI
         pHV+jXUMONq8RMxSNScJJuxOrQ8lDhRmyUa23AI0=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AE392601D7;
        Thu,  8 Nov 2018 13:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541684510;
        bh=4oiIGpiJtpEwziwSD/eEgiV3Q9ELAM3npTOPrHigjDQ=;
        h=From:To:Cc:Subject:Date:From;
        b=SSjtN0wB089Slwx+syysgF2eF36l7VO/oLEvwuSCPx5aDMSx64BmIh8s66FWXJSh5
         saDYOy4JezbTOcHujFbaSdjXnu4MSGOOKcyVH3Bb2Wc9gNt/MWvwDAFTFD1/uyBhuk
         n01xNnuXbnoKE7RGqI33egTd7UzP7a8zrO8fQNww=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AE392601D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH] ASoC: qcom: Set dai_link id to each dai_link
Date:   Thu,  8 Nov 2018 19:11:40 +0530
Message-Id: <1541684500-32728-1-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frontend dai_link id is used for closing ADM sessions.
During concurrent usecase when one session is closed,
it closes other ADM session associated with other usecase
too. Dai_link->id should always point to Frontend dai id.
Set cpu_dai id as dai_link id to fix the issue.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/common.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index eb1b9da..4715527 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -13,6 +13,7 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 	struct device_node *cpu = NULL;
 	struct device *dev = card->dev;
 	struct snd_soc_dai_link *link;
+	struct of_phandle_args args;
 	int ret, num_links;
 
 	ret = snd_soc_of_parse_card_name(card, "model");
@@ -47,12 +48,14 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 			goto err;
 		}
 
-		link->cpu_of_node = of_parse_phandle(cpu, "sound-dai", 0);
-		if (!link->cpu_of_node) {
+		ret = of_parse_phandle_with_args(cpu, "sound-dai",
+					"#sound-dai-cells", 0, &args);
+		if (ret) {
 			dev_err(card->dev, "error getting cpu phandle\n");
-			ret = -EINVAL;
 			goto err;
 		}
+		link->cpu_of_node = args.np;
+		link->id = args.args[0];
 
 		ret = snd_soc_of_get_dai_name(cpu, &link->cpu_dai_name);
 		if (ret) {
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

