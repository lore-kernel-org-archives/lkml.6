Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96F5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA13D217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfBZISA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 03:18:00 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:29564 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbfBZIR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 03:17:59 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 397A341EC477004A65F2;
        Tue, 26 Feb 2019 16:17:56 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x1Q8HloN018834;
        Tue, 26 Feb 2019 16:17:47 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019022616180204-1860801 ;
          Tue, 26 Feb 2019 16:18:02 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, linuxppc-dev@lists.ozlabs.org,
        wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 1/3] ASoC: wcd9335: fix a leaked reference by adding missing of_node_put
Date:   Tue, 26 Feb 2019 16:17:49 +0800
Message-Id: <1551169071-11639-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-02-26 16:18:02,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-02-26 16:17:44,
        Serialize complete at 2019-02-26 16:17:44
X-MAIL: mse01.zte.com.cn x1Q8HloN018834
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_parse_phandle returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./sound/soc/codecs/wcd9335.c:5193:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 5183, but without a correspon    ding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com> (commit_signer:1/11=9%,authored:1/11=9%)
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/codecs/wcd9335.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 981f88a..a04a7ce 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -5188,6 +5188,7 @@ static int wcd9335_slim_status(struct slim_device *sdev,
 
 	wcd->slim = sdev;
 	wcd->slim_ifc_dev = of_slim_get_device(sdev->ctrl, ifc_dev_np);
+	of_node_put(ifc_dev_np);
 	if (!wcd->slim_ifc_dev) {
 		dev_err(dev, "Unable to get SLIM Interface device\n");
 		return -EINVAL;
-- 
2.9.5

