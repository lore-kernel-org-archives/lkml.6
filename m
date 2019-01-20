Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9377C61CE8
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 02:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786A020896
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 02:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="Yvw6jjEV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="cEBqiWlm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbfATCcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 21:32:03 -0500
Received: from node.akkea.ca ([192.155.83.177]:36298 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729995AbfATCcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 21:32:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 30F4E4E2051;
        Sun, 20 Jan 2019 02:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1547951522; bh=WUXWccT5PmV9S0juFUFU4MxzFbKyfQ6fspVdbDlV0c4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Yvw6jjEVw9CKGorYpikfdV+i+9mxGmaZySVufNzzx7KlW/2dW7EImaEkGGGayaWHh
         LT6ZYPumGZl8iwZ+F8XrPiZaAgZX//rhvtYzOQe4g3f/h/5Sj7Ihy/oFQ/RDm+Cf1N
         gY7mi+1EzFxNNOsjzMzXYwJ9sbgj8rSJXFaAo9SA=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OD7boVEN262S; Sun, 20 Jan 2019 02:32:01 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca [198.48.167.13])
        by node.akkea.ca (Postfix) with ESMTPSA id 4A3134E204D;
        Sun, 20 Jan 2019 02:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1547951521; bh=WUXWccT5PmV9S0juFUFU4MxzFbKyfQ6fspVdbDlV0c4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=cEBqiWlmJ6ijJB8m6s6k62zxrQ12X6viLCx94RtTPlPWTw8J/7jCjlPrH7FFK/vpM
         sL3AcBVrQLZAN2oH+ZA7pkNRrBiD580CLjSxa6gpQfdsC1A2g0wOC9VJPYs06Ck02i
         cXrw4qXAgTscnxS2DeZK0o8LAtki2QpZOFcfkpOI=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v2 1/3] dma: imx-sdma: fix NULL pointer de-reference
Date:   Sat, 19 Jan 2019 19:31:48 -0700
Message-Id: <20190120023150.17138-2-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190120023150.17138-1-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the imx8mq I get NULL pointer de-deference errors if the device
isn't passed in during allocation.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/dma/imx-sdma.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 86708fb9bda1..0b3a67ff8e82 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -677,7 +677,7 @@ static int sdma_load_script(struct sdma_engine *sdma, void *buf, int size,
 	int ret;
 	unsigned long flags;
 
-	buf_virt = dma_alloc_coherent(NULL, size, &buf_phys, GFP_KERNEL);
+	buf_virt = dma_alloc_coherent(sdma->dev, size, &buf_phys, GFP_KERNEL);
 	if (!buf_virt) {
 		return -ENOMEM;
 	}
@@ -696,7 +696,7 @@ static int sdma_load_script(struct sdma_engine *sdma, void *buf, int size,
 
 	spin_unlock_irqrestore(&sdma->channel_0_lock, flags);
 
-	dma_free_coherent(NULL, size, buf_virt, buf_phys);
+	dma_free_coherent(sdma->dev, size, buf_virt, buf_phys);
 
 	return ret;
 }
@@ -1182,8 +1182,8 @@ static int sdma_request_channel0(struct sdma_engine *sdma)
 {
 	int ret = -EBUSY;
 
-	sdma->bd0 = dma_alloc_coherent(NULL, PAGE_SIZE, &sdma->bd0_phys,
-				       GFP_NOWAIT);
+	sdma->bd0 = dma_alloc_coherent(sdma->dev, PAGE_SIZE, &sdma->bd0_phys,
+					GFP_NOWAIT);
 	if (!sdma->bd0) {
 		ret = -ENOMEM;
 		goto out;
@@ -1205,8 +1205,8 @@ static int sdma_alloc_bd(struct sdma_desc *desc)
 	u32 bd_size = desc->num_bd * sizeof(struct sdma_buffer_descriptor);
 	int ret = 0;
 
-	desc->bd = dma_alloc_coherent(NULL, bd_size, &desc->bd_phys,
-				      GFP_NOWAIT);
+	desc->bd = dma_alloc_coherent(desc->sdmac->sdma->dev, bd_size,
+			&desc->bd_phys,	GFP_NOWAIT);
 	if (!desc->bd) {
 		ret = -ENOMEM;
 		goto out;
@@ -1219,7 +1219,8 @@ static void sdma_free_bd(struct sdma_desc *desc)
 {
 	u32 bd_size = desc->num_bd * sizeof(struct sdma_buffer_descriptor);
 
-	dma_free_coherent(NULL, bd_size, desc->bd, desc->bd_phys);
+	dma_free_coherent(desc->sdmac->sdma->dev, bd_size, desc->bd,
+			desc->bd_phys);
 }
 
 static void sdma_desc_free(struct virt_dma_desc *vd)
@@ -1842,7 +1843,7 @@ static int sdma_init(struct sdma_engine *sdma)
 	/* Be sure SDMA has not started yet */
 	writel_relaxed(0, sdma->regs + SDMA_H_C0PTR);
 
-	sdma->channel_control = dma_alloc_coherent(NULL,
+	sdma->channel_control = dma_alloc_coherent(sdma->dev,
 			MAX_DMA_CHANNELS * sizeof (struct sdma_channel_control) +
 			sizeof(struct sdma_context_data),
 			&ccb_phys, GFP_KERNEL);
-- 
2.17.1

