Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59E1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F32920855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="SwtMegUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfAQJHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:07:08 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:48938 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbfAQJGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:06:54 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 9256B5C1E78;
        Thu, 17 Jan 2019 10:06:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1547716012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fBPaG8x3udk+G/2xYvR2q6rlGVrnyup1hxsA4F87nZo=;
        b=SwtMegUrfjenwLy2K+vnuukw+ss3EmoBPhtECCVzp4WrQO58KISzGubjTDVdaU007SQyUY
        TVXNR+el0MHHdf7nirnjqphJ2SPmq2nchDzIDciTJHnH0lEiRImh0SqZ0vGixtD+B3ZRXe
        vQ9KE8XFyRYacWjOobMspZi9arVFQ6M=
From:   Stefan Agner <stefan@agner.ch>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com
Cc:     fabio.estevam@nxp.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH 4/5] ASoC: imx-sgtl5000: put of nodes if finding codec fails
Date:   Thu, 17 Jan 2019 10:06:39 +0100
Message-Id: <20190117090640.12972-4-stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190117090640.12972-1-stefan@agner.ch>
References: <20190117090640.12972-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to properly put the of node in case finding the codec
fails.

Fixes: 81e8e4926167 ("ASoC: fsl: add sgtl5000 clock support for imx-sgtl5000")
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 sound/soc/fsl/imx-sgtl5000.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index e1e20499b2f1..45969e6dfad7 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -111,7 +111,8 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 	codec_dev = of_find_i2c_device_by_node(codec_np);
 	if (!codec_dev) {
 		dev_err(&pdev->dev, "failed to find codec platform device\n");
-		return -EPROBE_DEFER;
+		ret = -EPROBE_DEFER;
+		goto fail;
 	}
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
-- 
2.20.1

