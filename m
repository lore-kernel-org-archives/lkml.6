Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46E4C65BAE
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BD821486
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2TILMS7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88BD821486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbeLBVXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:23:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45720 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbeLBVXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:23:38 -0500
Received: by mail-wr1-f68.google.com with SMTP id v6so10104438wrr.12;
        Sun, 02 Dec 2018 13:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+RIjtlpT3+92I1+2H0hsC2goUn5MUzztUllaWtnGW6g=;
        b=Z2TILMS7nhHpXjPG8qMmgoZGLsz5pbrkGf8QKsyQI8Jnpq6trsDTbAeryTZW8u7/Yo
         INyr1g774vsZ1aw7ePanyBUXyhxl2L+L3FkK2hIUIn3ZFrUaiAD6ngmyi102kkf5JusG
         fhSD91W3htOEdJUxzEE9dzjcvbBAtMmReA7w7bRVxTXh1rp53nyZQddv2h2ZtaPpMNbC
         /u9OvrKELsuTn2TsoPsRcqVtTNll9fZN8YfK3JutNMECv/TftHAXizspneGmd3uTv6Ay
         rWLk4SeRNsJQi021kXk25Adbnz2hv/K0UwAro88dNMacYks3OGAlf5J1clL+b6cnisJv
         ZiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+RIjtlpT3+92I1+2H0hsC2goUn5MUzztUllaWtnGW6g=;
        b=OqbejzQJJQhCGLN8gtH1Shj9RAnncr1ep0W7RrRVQEKBaky5MjPDimEHiIsbbRKe1u
         jrXj9a9SXTK5NVsomv2eq5JAEjxN0zSu4D3cL7R9LdfY3KPYcUv0F3jkd/ejR+x4Onet
         uSyUAP/dWpPpVK6CZm8e/C1CKWy6dHN2eVahgoxIRZfP6cip/ctMqs8pUTJ6bS22ZVUr
         SLURNLEO2cMt4YcnlzW/qagw+8zt11AcViO+2SAd3wXLimDfbpnxFBbsL+87fUX/HqZC
         Uycj04hK1dalXa/+TOlsFNvK/EQxr33HJ4fnJ0ZDJnF1iQ6/pAnmNA6nXmPUPCXSBxaD
         LQ4w==
X-Gm-Message-State: AA+aEWaK8OrEfQLF2bTwghG1WceXEBrBgXTwL7Jwk8EZI+TVhdn7PopO
        aqZhaw1snYcTRPSLVc6K1rvwMCkgm3E=
X-Google-Smtp-Source: AFSGD/WyrNYACQFMYw4QTsRc1ryyvozAVERA4/z47O05e3frHy1QokNLAuqaXCZZq7TImRSlUQiVFw==
X-Received: by 2002:adf:c108:: with SMTP id r8mr12313316wre.233.1543785813999;
        Sun, 02 Dec 2018 13:23:33 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
        by smtp.gmail.com with ESMTPSA id d2sm9551043wrs.97.2018.12.02.13.23.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Dec 2018 13:23:33 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [RFC PATCH 02/10] dma-engine: sun4i: Add has_reset option to quirk
Date:   Mon,  3 Dec 2018 00:23:09 +0300
Message-Id: <01acc2214bf4aa62bda1c6e2ecf04ad698f9866b.1543782328.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543782328.git.mesihkilinc@gmail.com>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner suniv F1C100s has a reset bit for DMA in CCU. Sun4i do not
has this bit but in order to support suniv we need to add it. So add
support for reset bit.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 drivers/dma/sun4i-dma.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index e86b424..d267ff9 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -18,6 +18,7 @@
 #include <linux/of_dma.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
@@ -153,6 +154,7 @@ struct sun4i_dma_config {
 	u8 ddma_drq_sdram;
 
 	u8 max_burst;
+	bool has_reset;
 };
 
 struct sun4i_dma_pchan {
@@ -201,6 +203,7 @@ struct sun4i_dma_dev {
 	int				irq;
 	spinlock_t			lock;
 	const struct sun4i_dma_config *cfg;
+	struct reset_control *rst;
 };
 
 static struct sun4i_dma_dev *to_sun4i_dma_dev(struct dma_device *dev)
@@ -1198,6 +1201,15 @@ static int sun4i_dma_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->clk);
 	}
 
+	if(priv->cfg->has_reset) {
+		priv->rst = devm_reset_control_get_exclusive(&pdev->dev,
+							       NULL);
+		if (IS_ERR(priv->rst)) {
+			dev_err(&pdev->dev, "Failed to get reset control\n");
+			return PTR_ERR(priv->rst);
+		}
+	}
+
 	platform_set_drvdata(pdev, priv);
 	spin_lock_init(&priv->lock);
 
@@ -1268,6 +1280,16 @@ static int sun4i_dma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* Deassert the reset control */
+	if (priv->rst) {
+		ret = reset_control_deassert(priv->rst);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to deassert the reset control\n");
+			goto err_clk_disable;
+		}
+	}
+
 	/*
 	 * Make sure the IRQs are all disabled and accounted for. The bootloader
 	 * likes to leave these dirty
@@ -1339,6 +1361,7 @@ static struct sun4i_dma_config sun4i_a10_dma_cfg = {
 	.ddma_drq_sdram		= SUN4I_DDMA_DRQ_TYPE_SDRAM,
 
 	.max_burst		= SUN4I_MAX_BURST,
+	.has_reset		= false,
 };
 
 static const struct of_device_id sun4i_dma_match[] = {
-- 
2.7.4

