Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E77C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270312086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="hoXQRDGQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfARJzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:55:08 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:34422 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfARJzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:55:07 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id D0BBD5C00F2;
        Fri, 18 Jan 2019 10:55:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1547805306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=SjFAMPHJCadPYga79E65L3P4K5CD6WMlh5Q7VTqjdt0=;
        b=hoXQRDGQnCc+yHhCM7pcdvYwUMVS0AeMEwJ6qLp6pI/yuN0pcFOd+x6QX8cNG6yC8Gm+/q
        5mKd6QSf7152DZbS6teHAsnyZ3MCOzFNtmUQgpoWX+sT6wPR3CiRC9GjYIjaZhmREWJwTF
        i1FoZUlPwdGzBdBC+Gsv9D4UBB7Q2vE=
From:   Stefan Agner <stefan@agner.ch>
To:     perex@perex.cz, lgirdwood@gmail.com, broonie@kernel.org
Cc:     tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH] ASoC: soc-core: remove error due to probe deferral
Date:   Fri, 18 Jan 2019 10:55:04 +0100
Message-Id: <20190118095504.22397-1-stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deferred probes shouldn't cause error messages in the boot log, so
change the dev_err() to the more harmless dev_info().

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 sound/soc/soc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b29d0f65611e..ba9b09517c5f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -903,8 +903,8 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	for (i = 0; i < rtd->num_codecs; i++) {
 		codec_dais[i] = snd_soc_find_dai(&codecs[i]);
 		if (!codec_dais[i]) {
-			dev_err(card->dev, "ASoC: CODEC DAI %s not registered\n",
-				codecs[i].dai_name);
+			dev_info(card->dev, "ASoC: CODEC DAI %s not registered\n",
+				 codecs[i].dai_name);
 			goto _err_defer;
 		}
 		snd_soc_rtdcom_add(rtd, codec_dais[i]->component);
-- 
2.20.1

