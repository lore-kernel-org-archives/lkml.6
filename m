Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D662ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342C120853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342C120853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbeINWVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:21:40 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41773 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbeINWVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:21:40 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7] helo=dude.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1g0rXr-0000yl-Js; Fri, 14 Sep 2018 19:06:15 +0200
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robin Gong <yibin.gong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: [PATCH v2 3/4] dmaengine: imx-sdma: implement channel termination via worker
Date:   Fri, 14 Sep 2018 19:06:14 +0200
Message-Id: <20180914170615.12659-3-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180914170615.12659-1-l.stach@pengutronix.de>
References: <20180914170615.12659-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dmaengine documentation states that device_terminate_all may be
asynchronous and need not wait for the active transfers have stopped.

This allows us to move most of the functionality currently implemented
in the sdma channel termination function to run in a worker, outside
of any atomic context. Moving this out of atomic context has two
benefits: we can now sleep while waiting for the channel to terminate,
instead of busy waiting and the freeing of the dma descriptors happens
with IRQs enabled, getting rid of a warning in the dma mapping code.

As the termination is now asnc, we need to implement the
device_synchronize dma engine function, which simply waits for the
worker to finish its execution.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
v2: Keep vchan_get_all_descriptors in the terminate_all call, so the
    worker doesn't corrupt the next transfer if that's already in
    the setup process.
---
 drivers/dma/imx-sdma.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 8d2fec8b16cc..da41e8fbf151 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -32,6 +32,7 @@
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
+#include <linux/workqueue.h>
 
 #include <asm/irq.h>
 #include <linux/platform_data/dma-imx-sdma.h>
@@ -375,6 +376,8 @@ struct sdma_channel {
 	u32				shp_addr, per_addr;
 	enum dma_status			status;
 	struct imx_dma_data		data;
+	struct work_struct		terminate_worker;
+	struct list_head		deferred_desc_list;
 };
 
 #define IMX_DMA_SG_LOOP		BIT(0)
@@ -1025,31 +1028,47 @@ static int sdma_disable_channel(struct dma_chan *chan)
 
 	return 0;
 }
+static void sdma_channel_terminate(struct work_struct *work)
+{
+	struct sdma_channel *sdmac = container_of(work, struct sdma_channel,
+						  terminate_worker);
+
+	/*
+	 * According to NXP R&D team a delay of one BD SDMA cost time
+	 * (maximum is 1ms) should be added after disable of the channel
+	 * bit, to ensure SDMA core has really been stopped after SDMA
+	 * clients call .device_terminate_all.
+	 */
+	usleep_range(1000, 2000);
+
+	vchan_dma_desc_free_list(&sdmac->vc, &sdmac->deferred_desc_list);
+	INIT_LIST_HEAD(&sdmac->deferred_desc_list);
+}
 
 static int sdma_disable_channel_with_delay(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	unsigned long flags;
-	LIST_HEAD(head);
 
 	sdma_disable_channel(chan);
+
 	spin_lock_irqsave(&sdmac->vc.lock, flags);
-	vchan_get_all_descriptors(&sdmac->vc, &head);
+	vchan_get_all_descriptors(&sdmac->vc, &sdmac->deferred_desc_list);
 	sdmac->desc = NULL;
 	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
-	vchan_dma_desc_free_list(&sdmac->vc, &head);
 
-	/*
-	 * According to NXP R&D team a delay of one BD SDMA cost time
-	 * (maximum is 1ms) should be added after disable of the channel
-	 * bit, to ensure SDMA core has really been stopped after SDMA
-	 * clients call .device_terminate_all.
-	 */
-	mdelay(1);
+	schedule_work(&sdmac->terminate_worker);
 
 	return 0;
 }
 
+static void sdma_channel_synchronize(struct dma_chan *chan)
+{
+	struct sdma_channel *sdmac = to_sdma_chan(chan);
+
+	flush_work(&sdmac->terminate_worker);
+}
+
 static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
 {
 	struct sdma_engine *sdma = sdmac->sdma;
@@ -1993,6 +2012,8 @@ static int sdma_probe(struct platform_device *pdev)
 
 		sdmac->channel = i;
 		sdmac->vc.desc_free = sdma_desc_free;
+		INIT_WORK(&sdmac->terminate_worker, sdma_channel_terminate);
+		INIT_LIST_HEAD(&sdmac->deferred_desc_list);
 		/*
 		 * Add the channel to the DMAC list. Do not add channel 0 though
 		 * because we need it internally in the SDMA driver. This also means
@@ -2045,6 +2066,7 @@ static int sdma_probe(struct platform_device *pdev)
 	sdma->dma_device.device_prep_dma_cyclic = sdma_prep_dma_cyclic;
 	sdma->dma_device.device_config = sdma_config;
 	sdma->dma_device.device_terminate_all = sdma_disable_channel_with_delay;
+	sdma->dma_device.device_synchronize = sdma_channel_synchronize;
 	sdma->dma_device.src_addr_widths = SDMA_DMA_BUSWIDTHS;
 	sdma->dma_device.dst_addr_widths = SDMA_DMA_BUSWIDTHS;
 	sdma->dma_device.directions = SDMA_DMA_DIRECTIONS;
-- 
2.19.0

