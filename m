Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD36C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC89C2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="eV2Kt+jA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfARJHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:07:15 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:33876 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbfARJHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:07:01 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 057B15C2728;
        Fri, 18 Jan 2019 10:07:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1547802420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PWO+y2NvmzDII8V5/g3zFJFn40YzrEFkPqtfEP5PK+o=;
        b=eV2Kt+jArqwUBZ/NcPHweYVDbnwMcckTc4FRNaLU0ecIYUI8Wz0Kv/j04ScMQ2G1uCaNjO
        sWyjbRZj+MuA9zIl7dFrFGAiA+LWrmS2/P3D/S3u3NAcVHu5Udk60syWZcb/N90RJpTeUw
        ME/CRj+7RaCbo60qVUPYreTjyCbYdjw=
From:   Stefan Agner <stefan@agner.ch>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com
Cc:     fabio.estevam@nxp.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 5/5] ASoC: imx-spdif: don't print EPROBE_DEFER as error
Date:   Fri, 18 Jan 2019 10:06:56 +0100
Message-Id: <20190118090656.14201-5-stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118090656.14201-1-stefan@agner.ch>
References: <20190118090656.14201-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probe deferral is to be expected during normal operation, so avoid
printing an error when it is encountered.

Removing the goto would not be strictly necessary. However, if
code gets added later, the cleanup in the EPROBE_DEFER case likely
would get missed.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/imx-spdif.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/fsl/imx-spdif.c b/sound/soc/fsl/imx-spdif.c
index fb896b2c9ba3..797d66e43d49 100644
--- a/sound/soc/fsl/imx-spdif.c
+++ b/sound/soc/fsl/imx-spdif.c
@@ -67,10 +67,8 @@ static int imx_spdif_audio_probe(struct platform_device *pdev)
 		goto end;
 
 	ret = devm_snd_soc_register_card(&pdev->dev, &data->card);
-	if (ret) {
+	if (ret && ret != -EPROBE_DEFER)
 		dev_err(&pdev->dev, "snd_soc_register_card failed: %d\n", ret);
-		goto end;
-	}
 
 end:
 	of_node_put(spdif_np);
-- 
2.20.1

