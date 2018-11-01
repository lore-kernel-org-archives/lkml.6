Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C910C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FFE2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="S4YJ/rA6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="S4YJ/rA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FFE2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbeKAVlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 17:41:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51112 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbeKAVlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 17:41:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DF90C6085C; Thu,  1 Nov 2018 12:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541075944;
        bh=R3bHSdhkPAirrQJ44AWDG6tJeDJqJ2j5HNKjMFw2bUQ=;
        h=From:To:Cc:Subject:Date:From;
        b=S4YJ/rA6853fR34PPl7aLUmkeOA7Sm0bUOk/fKLlwvmGSok2shXewDFRxSjPUy3tw
         1fCdCDXrVNRUx+/elkTgxUBjgR118WNDSux5/Pl6Hua3GxuE6tLcFCW87+G/+GBkUD
         bH+umS0I4nNGCiUaXwsCox++1Ddc41slo0V5Vjqo=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 807536021C;
        Thu,  1 Nov 2018 12:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541075944;
        bh=R3bHSdhkPAirrQJ44AWDG6tJeDJqJ2j5HNKjMFw2bUQ=;
        h=From:To:Cc:Subject:Date:From;
        b=S4YJ/rA6853fR34PPl7aLUmkeOA7Sm0bUOk/fKLlwvmGSok2shXewDFRxSjPUy3tw
         1fCdCDXrVNRUx+/elkTgxUBjgR118WNDSux5/Pl6Hua3GxuE6tLcFCW87+G/+GBkUD
         bH+umS0I4nNGCiUaXwsCox++1Ddc41slo0V5Vjqo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 807536021C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH] ASoC: core: Invoke pcm_new() for all DAI-link
Date:   Thu,  1 Nov 2018 18:08:49 +0530
Message-Id: <1541075929-29323-1-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove no_pcm check to invoke pcm_new() for backend dai-links
too. This fixes crash in hdmi codec driver during hdmi_codec_startup()
while accessing chmap_info struct. chmap_info struct memory is
allocated in pcm_new() of hdmi codec driver which is not invoked
in case of DPCM when hdmi codec driver is part of backend dai-link.

Below is the crash stack:

[   61.635493] Unable to handle kernel NULL pointer dereference at virtual address 00000018
..
[   61.666696]   CM = 0, WnR = 1
[   61.669778] user pgtable: 4k pages, 39-bit VAs, pgd = ffffffc0d6633000
[   61.676526] [0000000000000018] *pgd=0000000153fc8003, *pud=0000000153fc8003, *pmd=0000000000000000
[   61.685793] Internal error: Oops: 96000046 [#1] PREEMPT SMP
[   61.722955] CPU: 7 PID: 2238 Comm: aplay Not tainted 4.14.72 #21
..
[   61.740269] PC is at hdmi_codec_startup+0x124/0x164
[   61.745308] LR is at hdmi_codec_startup+0xe4/0x164

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6ddcf12..abdc460 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1467,7 +1467,7 @@ static int soc_link_dai_pcm_new(struct snd_soc_dai **dais, int num_dais,
 	for (i = 0; i < num_dais; ++i) {
 		struct snd_soc_dai_driver *drv = dais[i]->driver;
 
-		if (!rtd->dai_link->no_pcm && drv->pcm_new)
+		if (drv->pcm_new)
 			ret = drv->pcm_new(rtd, dais[i]);
 		if (ret < 0) {
 			dev_err(dais[i]->dev,
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

