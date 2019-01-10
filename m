Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CC6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600F1214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="giryIPP2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KJppmrMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfAJJCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:02:55 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:42570 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbfAJJCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 04:02:54 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5E3C5608CD; Thu, 10 Jan 2019 09:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547110974;
        bh=B40pLJEFi33B2dRTxWBa3gDmBvRpqCUr3ITuOr6EK9A=;
        h=From:To:Cc:Subject:Date:From;
        b=giryIPP2yFpuKeql6SC7M/QS5egIRjRfVvDzvNSM0SkctdveWBxGacs5pfBNcuY0l
         8LKv3WJy3OyOKGXjJgGGA0cuHgVQK6yZTrRPluxoHuC9qJQloPZWx7AlDAmcZml5+q
         VguEjzJImNyphlbmGMPbTVkC4IlF3d3fm+YRDc44=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 80BF06038E;
        Thu, 10 Jan 2019 09:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547110973;
        bh=B40pLJEFi33B2dRTxWBa3gDmBvRpqCUr3ITuOr6EK9A=;
        h=From:To:Cc:Subject:Date:From;
        b=KJppmrMHC9s6zuiSd7zgE06B/Tj8SBkYlWMwtiTo2ea1rzxGJmBSExXIjPCM8nE3s
         K7XkP0jw1bUgU2j7VizlOXydPVnXh11ibIXn8EVWFCYHe0jUg6SyWd87Zc6RY52TrN
         5YTluEDqUb5UFrpvpIQAOGLRIFgvshL7ZeBFsAtY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 80BF06038E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     plai@codeaurora.org, bgoswami@codeaurora.org,
        asishb@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com,
        srinivas.kandagatla@linaro.org, vinod.koul@linaro.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>,
        Ajit Pandey <ajitp@codeaurora.org>
Subject: [PATCH] ASoC: soc-core: Hold client_mutex around soc_init_dai_link()
Date:   Thu, 10 Jan 2019 14:32:41 +0530
Message-Id: <1547110961-23670-1-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

soc_init_dai_link() calls soc_find_component() which needs
to be within client_mutex lock. Add client_mutex lock around
soc_init_dai_link() in snd_soc_register_card() to avoid
lockdep warning.

Fixes: 8780cf1142a5 ("ASoC: soc-core: defer card probe until all component is added to list")
Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
---
 sound/soc/soc-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index eec92f1..0934b36 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1027,6 +1027,7 @@ static int snd_soc_init_platform(struct snd_soc_card *card,
 				 struct snd_soc_dai_link *dai_link)
 {
 	struct snd_soc_dai_link_component *platform = dai_link->platform;
+
 	/*
 	 * FIXME
 	 *
@@ -2754,15 +2755,18 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	if (!card->name || !card->dev)
 		return -EINVAL;
 
+	mutex_lock(&client_mutex);
 	for_each_card_prelinks(card, i, link) {
 
 		ret = soc_init_dai_link(card, link);
 		if (ret) {
 			dev_err(card->dev, "ASoC: failed to init link %s\n",
 				link->name);
+			mutex_unlock(&client_mutex);
 			return ret;
 		}
 	}
+	mutex_unlock(&client_mutex);
 
 	dev_set_drvdata(card->dev, card);
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

