Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1829DC6369F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 02:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D064F20896
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 02:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="eTcdP01v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="eTcdP01v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbfATCcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 21:32:15 -0500
Received: from node.akkea.ca ([192.155.83.177]:36318 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729969AbfATCcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 21:32:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id BDFFD4E2056;
        Sun, 20 Jan 2019 02:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1547951522; bh=wJTH5J5ZdC/httLfL/yGxcEH/k8brU43a6mHXekHaCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=eTcdP01vj7Q/aTKxgz3QAI+HvniW9wnqkiinqLeV4Q57h+v+GnyVURJqyoEFJ25RJ
         VBRVQ3JVtWYGttL7cFLcqUjoFC9QysEoXl0CREHXLflKh0mp4crr051LPrfjEqTBU2
         E0CQM/S6whPEs10W1FFaBDF7KpHIo/RWEf+dVe2k=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TueyfDttQM3c; Sun, 20 Jan 2019 02:32:02 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca [198.48.167.13])
        by node.akkea.ca (Postfix) with ESMTPSA id DB3BD4E204B;
        Sun, 20 Jan 2019 02:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1547951522; bh=wJTH5J5ZdC/httLfL/yGxcEH/k8brU43a6mHXekHaCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=eTcdP01vj7Q/aTKxgz3QAI+HvniW9wnqkiinqLeV4Q57h+v+GnyVURJqyoEFJ25RJ
         VBRVQ3JVtWYGttL7cFLcqUjoFC9QysEoXl0CREHXLflKh0mp4crr051LPrfjEqTBU2
         E0CQM/S6whPEs10W1FFaBDF7KpHIo/RWEf+dVe2k=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v2 2/3] dma: imx-sdma: add clock ratio 1:1 check
Date:   Sat, 19 Jan 2019 19:31:49 -0700
Message-Id: <20190120023150.17138-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190120023150.17138-1-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.mx8 mscale B0 chip, AHB/SDMA clock ratio 2:1 can't be supportted,
since SDMA clock ratio has to be increased to 250Mhz, AHB can't reach
to 500Mhz, so use 1:1 instead.

based on NXP commit MLK-16841-1

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 .../devicetree/bindings/dma/fsl-imx-sdma.txt  |  1 +
 drivers/dma/imx-sdma.c                        | 20 +++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
index 3c9a57a8443b..17544c1820b7 100644
--- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
+++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
@@ -67,6 +67,7 @@ Optional properties:
     reg is the GPR register offset.
     shift is the bit position inside the GPR register.
     val is the value of the bit (0 or 1).
+- fsl,ratio-1-1: AHB/SDMA core clock ration 1:1, 2:1 without this.
 
 Examples:
 
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 0b3a67ff8e82..65dada21d3c1 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -440,6 +440,8 @@ struct sdma_engine {
 	unsigned int			irq;
 	dma_addr_t			bd0_phys;
 	struct sdma_buffer_descriptor	*bd0;
+	/* clock ratio for AHB:SDMA core. 1:1 is 1, 2:1 is 0*/
+	bool				clk_ratio;
 };
 
 static int sdma_config_write(struct dma_chan *chan,
@@ -662,8 +664,14 @@ static int sdma_run_channel0(struct sdma_engine *sdma)
 		dev_err(sdma->dev, "Timeout waiting for CH0 ready\n");
 
 	/* Set bits of CONFIG register with dynamic context switching */
-	if (readl(sdma->regs + SDMA_H_CONFIG) == 0)
-		writel_relaxed(SDMA_H_CONFIG_CSM, sdma->regs + SDMA_H_CONFIG);
+	if (readl(sdma->regs + SDMA_H_CONFIG) == 0) {
+		if (sdma->clk_ratio)
+			reg = SDMA_H_CONFIG_CSM | SDMA_H_CONFIG_ACR;
+		else
+			reg = SDMA_H_CONFIG_CSM;
+
+		writel_relaxed(reg, sdma->regs + SDMA_H_CONFIG);
+	}
 
 	return ret;
 }
@@ -1880,8 +1888,10 @@ static int sdma_init(struct sdma_engine *sdma)
 	writel_relaxed(0x4050, sdma->regs + SDMA_CHN0ADDR);
 
 	/* Set bits of CONFIG register but with static context switching */
-	/* FIXME: Check whether to set ACR bit depending on clock ratios */
-	writel_relaxed(0, sdma->regs + SDMA_H_CONFIG);
+	if (sdma->clk_ratio)
+		writel_relaxed(SDMA_H_CONFIG_ACR, sdma->regs + SDMA_H_CONFIG);
+	else
+		writel_relaxed(0, sdma->regs + SDMA_H_CONFIG);
 
 	writel_relaxed(ccb_phys, sdma->regs + SDMA_H_C0PTR);
 
@@ -1975,6 +1985,8 @@ static int sdma_probe(struct platform_device *pdev)
 	if (!sdma)
 		return -ENOMEM;
 
+	sdma->clk_ratio = of_property_read_bool(np, "fsl,ratio-1-1");
+
 	spin_lock_init(&sdma->channel_0_lock);
 
 	sdma->dev = &pdev->dev;
-- 
2.17.1

