Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6108CC282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C36217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="coyFDyZ/";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="coyFDyZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbfAYCzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 21:55:53 -0500
Received: from node.akkea.ca ([192.155.83.177]:52108 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728694AbfAYCzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 21:55:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id C03E64E205C;
        Fri, 25 Jan 2019 02:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1548384939; bh=NtFtvKu7hgih6/01kJslPvJy0MSpNrvkPmrJHu9XxMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=coyFDyZ/SG5g1Ba9ugw1yk/Cnn0Wi0rML5tbTK26IGvGgF0vJ5l8oMylby4QANIZZ
         eX5yEZHB/OzAJ8wmeY9G4f9zJ/DiOg3jMZXahzqkobbieT0Kx+0AU1gY4vkUts17YG
         xD89XTwdFNasizYL+iyDgM2dGEeYDs6O7GygUUiU=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5E9mFXaPlrsN; Fri, 25 Jan 2019 02:55:39 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca [198.48.167.13])
        by node.akkea.ca (Postfix) with ESMTPSA id C3A8C4E204E;
        Fri, 25 Jan 2019 02:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1548384939; bh=NtFtvKu7hgih6/01kJslPvJy0MSpNrvkPmrJHu9XxMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=coyFDyZ/SG5g1Ba9ugw1yk/Cnn0Wi0rML5tbTK26IGvGgF0vJ5l8oMylby4QANIZZ
         eX5yEZHB/OzAJ8wmeY9G4f9zJ/DiOg3jMZXahzqkobbieT0Kx+0AU1gY4vkUts17YG
         xD89XTwdFNasizYL+iyDgM2dGEeYDs6O7GygUUiU=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus@akkea.ca
Cc:     angus.ainslie@puri.sm, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: [PATCH v4 4/5] dma: imx-sdma: add a test for imx8mq multi sdma devices
Date:   Thu, 24 Jan 2019 19:55:27 -0700
Message-Id: <20190125025528.15645-5-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190125025528.15645-1-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190125025528.15645-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.mx8mq, there are two sdma instances, and the common dma framework
will get a channel dynamically from any available sdma instance whether
it's the first sdma device or the second sdma device. Some IPs like
SAI only work with sdma2 not sdma1. To make sure the sdma channel is from
the correct sdma device, use the phandle to match.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/dma/imx-sdma.c                | 8 ++++++++
 include/linux/platform_data/dma-imx.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index ec6fb48f387a..88e112a4aabf 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1927,11 +1927,17 @@ static int sdma_init(struct sdma_engine *sdma)
 static bool sdma_filter_fn(struct dma_chan *chan, void *fn_param)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
+	struct sdma_engine *sdma = sdmac->sdma;
 	struct imx_dma_data *data = fn_param;
 
 	if (!imx_dma_is_general_purpose(chan))
 		return false;
 
+	/* return false if it's not the right device */
+	if ((sdmac->sdma->drvdata == &sdma_imx8mq)
+		&& (sdma->dev->of_node->phandle != data->phandle))
+		return false;
+
 	sdmac->data = *data;
 	chan->private = &sdmac->data;
 
@@ -1942,6 +1948,7 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
 				   struct of_dma *ofdma)
 {
 	struct sdma_engine *sdma = ofdma->of_dma_data;
+	struct device_node *np = ofdma->of_node;
 	dma_cap_mask_t mask = sdma->dma_device.cap_mask;
 	struct imx_dma_data data;
 
@@ -1959,6 +1966,7 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
 	 * be set to sdmac->event_id1.
 	 */
 	data.dma_request2 = 0;
+	data.phandle = np->phandle;
 
 	return dma_request_channel(mask, sdma_filter_fn, &data);
 }
diff --git a/include/linux/platform_data/dma-imx.h b/include/linux/platform_data/dma-imx.h
index 7d964e787299..eeb5b73ae542 100644
--- a/include/linux/platform_data/dma-imx.h
+++ b/include/linux/platform_data/dma-imx.h
@@ -55,6 +55,7 @@ struct imx_dma_data {
 	int dma_request2; /* secondary DMA request line */
 	enum sdma_peripheral_type peripheral_type;
 	int priority;
+	int phandle;
 };
 
 static inline int imx_dma_is_ipu(struct dma_chan *chan)
-- 
2.17.1

