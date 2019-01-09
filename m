Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00E3C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2242075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Pahit59c";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ogR4syil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbfAIIsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 03:48:02 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36926 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfAIIsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 03:48:02 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1B8EC608C6; Wed,  9 Jan 2019 08:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547023681;
        bh=49ZmOkJlqAD88GfcBWboINxEulavztigu4Y+9LtQoHQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Pahit59cEC8Yqmt6HQq4f35qkfgwxdS+MBVma124tkCno8qsKF5cu+7kPA7KUCXPj
         ZB1LSITgmb/6GkVj7jdADz50ydC19CGahPH1p87uF+eP67HXHQ9dMZYQ5cim82GmiH
         AsvHSjUYF8Rq87H8U9vJAJ+x+oM2oyDZlAt09V8g=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0233060132;
        Wed,  9 Jan 2019 08:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547023680;
        bh=49ZmOkJlqAD88GfcBWboINxEulavztigu4Y+9LtQoHQ=;
        h=From:To:Cc:Subject:Date:From;
        b=ogR4syilfBlUchHqJ6xT+2p3EuEwK8pz6FZShgPiw8uXYjN4ScMmcGMQNqRLcdyie
         zKiRwJyJPx45auqngMrZPVHP2aD9cjCIZyZqI0Qxb2DeYIqCIVjya/dMJK5Q2AgYyB
         6J9BJd12sgyqwD1Fcbet0IYtOrLm83bBZBd5Sa8M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0233060132
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     plai@codeaurora.org, bgoswami@codeaurora.org,
        asishb@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com,
        srinivas.kandagatla@linaro.org, vinod.koul@linaro.org
Cc:     Ajit Pandey <ajitp@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v2] ASoC: soc-core: defer card probe until all component is added to list
Date:   Wed,  9 Jan 2019 14:17:07 +0530
Message-Id: <1547023627-30312-1-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ajit Pandey <ajitp@codeaurora.org>

DAI component probe is not called if it is not present
in component list during sound card registration.
Check if component is available in component list for
platform and cpu dai before soundcard registration.

Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
Changes since v1:
Moved component find logic to soc-core instead of machine driver
as suggested by Mark.

 sound/soc/soc-core.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0462b3e..eec92f1 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1027,7 +1027,6 @@ static int snd_soc_init_platform(struct snd_soc_card *card,
 				 struct snd_soc_dai_link *dai_link)
 {
 	struct snd_soc_dai_link_component *platform = dai_link->platform;
-
 	/*
 	 * FIXME
 	 *
@@ -1129,6 +1128,14 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 			link->name);
 		return -EINVAL;
 	}
+
+	/*
+	 * Defer card registartion if platform dai component is not added to
+	 * component list.
+	 */
+	if (!soc_find_component(link->platform->of_node, link->platform->name))
+		return -EPROBE_DEFER;
+
 	/*
 	 * CPU device may be specified by either name or OF node, but
 	 * can be left unspecified, and will be matched based on DAI
@@ -1140,6 +1147,14 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 			link->name);
 		return -EINVAL;
 	}
+
+	/*
+	 * Defer card registartion if cpu dai component is not added to
+	 * component list.
+	 */
+	if (!soc_find_component(link->cpu_of_node, link->cpu_name))
+		return -EPROBE_DEFER;
+
 	/*
 	 * At least one of CPU DAI name or CPU device name/node must be
 	 * specified
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

