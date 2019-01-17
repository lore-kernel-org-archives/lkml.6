Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58C1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729E220855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="hbYMQBdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfAQJHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:07:17 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:48926 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfAQJGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:06:54 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 535FD5C1E57;
        Thu, 17 Jan 2019 10:06:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1547716012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LEoCFXoca1HDWOVmFMHoFLVKT5GDMunvfNZ6l5UPaD8=;
        b=hbYMQBdHH8PgcnKlpzCj49xOttR8+MxYgHzysOfqqjmilYxiTCjBdiIRBKZmtthBeSaC3Q
        2wmmi8AgShJWUNmS6Tx/GiVbBqLQmOJe7hxthqnReWudXdvoh6W3V3h4+sBB+Mhk9frKFa
        dtCpaoV6DXWhCBx64/v2cYAGiqj1x9w=
From:   Stefan Agner <stefan@agner.ch>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com
Cc:     fabio.estevam@nxp.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH 3/5] ASoC: imx-sgtl5000: don't print EPROBE_DEFER as error
Date:   Thu, 17 Jan 2019 10:06:38 +0100
Message-Id: <20190117090640.12972-3-stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190117090640.12972-1-stefan@agner.ch>
References: <20190117090640.12972-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probe deferral is to be expected during normal operation, so avoid
printing an error when it is encountered.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 sound/soc/fsl/imx-sgtl5000.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index c29200cf755a..e1e20499b2f1 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -156,7 +156,9 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 
 	ret = devm_snd_soc_register_card(&pdev->dev, &data->card);
 	if (ret) {
-		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
+				ret);
 		goto fail;
 	}
 
-- 
2.20.1

