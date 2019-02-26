Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23593C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BA6213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfBZISD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 03:18:03 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:29944 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfBZISC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 03:18:02 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id B8E379A6E35A0A4AF74A;
        Tue, 26 Feb 2019 16:17:59 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x1Q8Hr7G018952;
        Tue, 26 Feb 2019 16:17:53 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019022616180756-1860815 ;
          Tue, 26 Feb 2019 16:18:07 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, linuxppc-dev@lists.ozlabs.org,
        wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 3/3] ASoC: eukrea-tlv320: fix a leaked reference by adding missing of_node_put
Date:   Tue, 26 Feb 2019 16:17:51 +0800
Message-Id: <1551169071-11639-3-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551169071-11639-1-git-send-email-wen.yang99@zte.com.cn>
References: <1551169071-11639-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-02-26 16:18:07,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-02-26 16:17:49,
        Serialize complete at 2019-02-26 16:17:49
X-MAIL: mse01.zte.com.cn x1Q8Hr7G018952
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_parse_phandle returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./sound/soc/fsl/eukrea-tlv320.c:121:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 102, but without a correspo    nding object release within this function.
./sound/soc/fsl/eukrea-tlv320.c:127:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 102, but without a correspo    nding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/fsl/eukrea-tlv320.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
index 191426a..30a3d68 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -118,13 +118,13 @@ static int eukrea_tlv320_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev,
 				"fsl,mux-int-port node missing or invalid.\n");
-			return ret;
+			goto err;
 		}
 		ret = of_property_read_u32(np, "fsl,mux-ext-port", &ext_port);
 		if (ret) {
 			dev_err(&pdev->dev,
 				"fsl,mux-ext-port node missing or invalid.\n");
-			return ret;
+			goto err;
 		}
 
 		/*
-- 
2.9.5

