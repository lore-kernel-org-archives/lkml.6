Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DEFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1392B2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ci/FtmsF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HjDzA/E0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfAKIOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:14:16 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33386 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbfAKIOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:14:15 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 02344608FC; Fri, 11 Jan 2019 08:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547194455;
        bh=/OPO2bL+6AsE5UNjnVY8VVBD/ui7edB4j6fJJK8wipc=;
        h=From:To:Cc:Subject:Date:From;
        b=ci/FtmsFuKLnf0XNcdl83hKhdLcbFVD8RZvh3RuXlITUNRwkdR3TGifFyZtZG7pev
         MgeiU1bi+83Acogc/DYFIuC2kKCqcHKhnb2ABN+nfbD0la+XHRGNh34KRKf59BgS10
         qcR59r7E9y7fFb4NQ+FhF/cEZJTfQyJacabntLl8=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B466D601B4;
        Fri, 11 Jan 2019 08:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547194454;
        bh=/OPO2bL+6AsE5UNjnVY8VVBD/ui7edB4j6fJJK8wipc=;
        h=From:To:Cc:Subject:Date:From;
        b=HjDzA/E0aXPyL6r9sctAnZQHTE/w1cwqxyIvZhjuW0uma/LjJV+QbV1o+zkOkDlUl
         eLliDFsAwL3nv1Ug5PXw+g3PGisRm+UY7wg6Xu6gRx58BiomWDuiJnR1D3Y4LEXj5f
         dTHWPDwbS/kCweGM1kkerIhYIWktAmskwTKtBFb4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B466D601B4
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
Subject: [PATCH] ASoC: soc-core: Fix null pointer dereference in soc_find_component
Date:   Fri, 11 Jan 2019 13:44:02 +0530
Message-Id: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ajit Pandey <ajitp@codeaurora.org>

soc_find_component() may lead to null pointer exception if both
arguments i.e of_node and name is NULL. Add NULL check before
calling soc_find_component(). Also fix some typos.

Fixes: 8780cf1142a5 ("ASoC: soc-core: defer card probe until all component is added to list")
Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/soc-core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0934b36..df05fb8 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1131,11 +1131,13 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 	}
 
 	/*
-	 * Defer card registartion if platform dai component is not added to
+	 * Defer card registration if platform dai component is not added to
 	 * component list.
 	 */
-	if (!soc_find_component(link->platform->of_node, link->platform->name))
-		return -EPROBE_DEFER;
+	if (link->platform->of_node || link->platform->name)
+		if (!soc_find_component(link->platform->of_node,
+					link->platform->name))
+			return -EPROBE_DEFER;
 
 	/*
 	 * CPU device may be specified by either name or OF node, but
@@ -1150,11 +1152,12 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 	}
 
 	/*
-	 * Defer card registartion if cpu dai component is not added to
+	 * Defer card registration if cpu dai component is not added to
 	 * component list.
 	 */
-	if (!soc_find_component(link->cpu_of_node, link->cpu_name))
-		return -EPROBE_DEFER;
+	if (link->cpu_of_node || link->cpu_name)
+		if (!soc_find_component(link->cpu_of_node, link->cpu_name))
+			return -EPROBE_DEFER;
 
 	/*
 	 * At least one of CPU DAI name or CPU device name/node must be
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

