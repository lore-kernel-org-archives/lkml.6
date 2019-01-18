Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE230C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862C02086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="p1o1phgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfARJHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:07:04 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:33862 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfARJHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:07:01 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id C673C5C2724;
        Fri, 18 Jan 2019 10:06:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1547802419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Um8AGbM9+pP4QidLOOHMBFnuiPi+r0i4oYGsKdpib94=;
        b=p1o1phgWiEFq4A+wl9CshidaKHEIj/CGQSEasGvTz86Vj36ex+ZluYloQAiaz6y+E47yNn
        uM2GEmShmeacuIMqUmkbCgFlsd9iN6sK2EsySVbErhxYZ5dgXx7nCA7Pu8BvAL8kGiG00/
        +e9o3QiNFTStISZWzSkU2Ok+RhQ3nvk=
From:   Stefan Agner <stefan@agner.ch>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com
Cc:     fabio.estevam@nxp.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 4/5] ASoC: fsl_spdif: don't print EPROBE_DEFER as error
Date:   Fri, 18 Jan 2019 10:06:55 +0100
Message-Id: <20190118090656.14201-4-stefan@agner.ch>
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

Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_spdif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 740b90df44bb..a26686e7281c 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1320,7 +1320,7 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 	}
 
 	ret = imx_pcm_dma_init(pdev, IMX_SPDIF_DMABUF_SIZE);
-	if (ret)
+	if (ret && ret != -EPROBE_DEFER)
 		dev_err(&pdev->dev, "imx_pcm_dma_init failed: %d\n", ret);
 
 	return ret;
-- 
2.20.1

