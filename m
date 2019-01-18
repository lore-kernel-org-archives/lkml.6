Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C760CC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9716620896
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Wzx6kKBF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfARJHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:07:02 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:33834 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfARJHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:07:01 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 662F75C2718;
        Fri, 18 Jan 2019 10:06:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1547802419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gd/hCGOakbk8VwgWfWHDTa07ipa+TanZN8pSUZmNCng=;
        b=Wzx6kKBF65l6quVxMSOvJ3oyy5Azgodtm90I/LXBkKmTG9682cORva4rCPtLdtBc0wLX9Y
        HRk77tOAWFmqXNEHaS2m7SdkW6tnHHBpdzxfRn1dXzBd8K+8b7OJ1x8SnjkvSoIM90MYe9
        VBNNvqpCGVEBVWNkASM0ue9EoUIL4LA=
From:   Stefan Agner <stefan@agner.ch>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com
Cc:     fabio.estevam@nxp.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 2/5] ASoC: imx-sgtl5000: lower log level for potential probe deferral cases
Date:   Fri, 18 Jan 2019 10:06:53 +0100
Message-Id: <20190118090656.14201-2-stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118090656.14201-1-stefan@agner.ch>
References: <20190118090656.14201-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not finding the codec/SSI instance can be due to probe deferral.
Do not print error messages in those cases.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/imx-sgtl5000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index 594bde3b0ded..9790a2a8ec2d 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -104,13 +104,13 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 
 	ssi_pdev = of_find_device_by_node(ssi_np);
 	if (!ssi_pdev) {
-		dev_err(&pdev->dev, "failed to find SSI platform device\n");
+		dev_dbg(&pdev->dev, "failed to find SSI platform device\n");
 		ret = -EPROBE_DEFER;
 		goto fail;
 	}
 	codec_dev = of_find_i2c_device_by_node(codec_np);
 	if (!codec_dev) {
-		dev_err(&pdev->dev, "failed to find codec platform device\n");
+		dev_dbg(&pdev->dev, "failed to find codec platform device\n");
 		ret = -EPROBE_DEFER;
 		goto fail;
 	}
-- 
2.20.1

