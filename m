Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF71C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4F32084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544104;
	bh=y/HJGTuixO+JIzNrrdOCh4Lq1h509JXMCqZlZ6bV12Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0PESHR22yZM8xsNZidwFSKfDOXlA2BNNwhxx/fzApIbbUNPTCpaPwoCV54kvSHA6K
	 DFTISLh0r61A9VJ7RSUtHSk5KfGxDjg58sAAwvfz5O7MmyI1dPIMNRaO+RE0NjWKOa
	 9lOVpjALnS77eLESEYp4MSiESua1xsuVciVpsVDk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4F32084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbeLKQBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:01:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:46332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730787AbeLKP5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:57:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2071B2086D;
        Tue, 11 Dec 2018 15:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543839;
        bh=y/HJGTuixO+JIzNrrdOCh4Lq1h509JXMCqZlZ6bV12Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lnz4IA49AtrqWDkPea7MrL8S8lh1sfEq+NPhRnAe0lqxb+8jgqhHlrR1SI9dcZYoG
         kaYtoez4EUQOU/reJRof0i5LlfWSEMeuJu9NaIrOyguasuyLiibohPBlzjs62/ljMY
         Tq3eUtCk5ZjqapWEXQAd68WHGU8QC8G0m9u0s+no=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Robin Gong <yibin.gong@nxp.com>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 4.19 085/118] dmaengine: imx-sdma: implement channel termination via worker
Date:   Tue, 11 Dec 2018 16:41:44 +0100
Message-Id: <20181211151647.700970690@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lucas Stach <l.stach@pengutronix.de>

commit b8603d2a5795c42f78998e70dc792336e0dc20c9 upstream.

The dmaengine documentation states that device_terminate_all may be
asynchronous and need not wait for the active transfers to stop.

This allows us to move most of the functionality currently implemented
in the sdma channel termination function to run in a worker, outside
of any atomic context. Moving this out of atomic context has two
benefits: we can now sleep while waiting for the channel to terminate,
instead of busy waiting and the freeing of the dma descriptors happens
with IRQs enabled, getting rid of a warning in the dma mapping code.

As the termination is now async, we need to implement the
device_synchronize dma engine function which simply waits for the
worker to finish its execution.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/imx-sdma.c |   51 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 13 deletions(-)

--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -32,6 +32,7 @@
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
+#include <linux/workqueue.h>
 
 #include <asm/irq.h>
 #include <linux/platform_data/dma-imx-sdma.h>
@@ -375,6 +376,7 @@ struct sdma_channel {
 	u32				shp_addr, per_addr;
 	enum dma_status			status;
 	struct imx_dma_data		data;
+	struct work_struct		terminate_worker;
 };
 
 #define IMX_DMA_SG_LOOP		BIT(0)
@@ -1025,31 +1027,49 @@ static int sdma_disable_channel(struct d
 
 	return 0;
 }
-
-static int sdma_disable_channel_with_delay(struct dma_chan *chan)
+static void sdma_channel_terminate_work(struct work_struct *work)
 {
-	struct sdma_channel *sdmac = to_sdma_chan(chan);
+	struct sdma_channel *sdmac = container_of(work, struct sdma_channel,
+						  terminate_worker);
 	unsigned long flags;
 	LIST_HEAD(head);
 
-	sdma_disable_channel(chan);
-	spin_lock_irqsave(&sdmac->vc.lock, flags);
-	vchan_get_all_descriptors(&sdmac->vc, &head);
-	sdmac->desc = NULL;
-	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
-	vchan_dma_desc_free_list(&sdmac->vc, &head);
-
 	/*
 	 * According to NXP R&D team a delay of one BD SDMA cost time
 	 * (maximum is 1ms) should be added after disable of the channel
 	 * bit, to ensure SDMA core has really been stopped after SDMA
 	 * clients call .device_terminate_all.
 	 */
-	mdelay(1);
+	usleep_range(1000, 2000);
+
+	spin_lock_irqsave(&sdmac->vc.lock, flags);
+	vchan_get_all_descriptors(&sdmac->vc, &head);
+	sdmac->desc = NULL;
+	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
+	vchan_dma_desc_free_list(&sdmac->vc, &head);
+}
+
+static int sdma_disable_channel_async(struct dma_chan *chan)
+{
+	struct sdma_channel *sdmac = to_sdma_chan(chan);
+
+	sdma_disable_channel(chan);
+
+	if (sdmac->desc)
+		schedule_work(&sdmac->terminate_worker);
 
 	return 0;
 }
 
+static void sdma_channel_synchronize(struct dma_chan *chan)
+{
+	struct sdma_channel *sdmac = to_sdma_chan(chan);
+
+	vchan_synchronize(&sdmac->vc);
+
+	flush_work(&sdmac->terminate_worker);
+}
+
 static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
 {
 	struct sdma_engine *sdma = sdmac->sdma;
@@ -1287,7 +1307,9 @@ static void sdma_free_chan_resources(str
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	struct sdma_engine *sdma = sdmac->sdma;
 
-	sdma_disable_channel_with_delay(chan);
+	sdma_disable_channel_async(chan);
+
+	sdma_channel_synchronize(chan);
 
 	if (sdmac->event_id0)
 		sdma_event_disable(sdmac, sdmac->event_id0);
@@ -1993,6 +2015,8 @@ static int sdma_probe(struct platform_de
 
 		sdmac->channel = i;
 		sdmac->vc.desc_free = sdma_desc_free;
+		INIT_WORK(&sdmac->terminate_worker,
+				sdma_channel_terminate_work);
 		/*
 		 * Add the channel to the DMAC list. Do not add channel 0 though
 		 * because we need it internally in the SDMA driver. This also means
@@ -2044,7 +2068,8 @@ static int sdma_probe(struct platform_de
 	sdma->dma_device.device_prep_slave_sg = sdma_prep_slave_sg;
 	sdma->dma_device.device_prep_dma_cyclic = sdma_prep_dma_cyclic;
 	sdma->dma_device.device_config = sdma_config;
-	sdma->dma_device.device_terminate_all = sdma_disable_channel_with_delay;
+	sdma->dma_device.device_terminate_all = sdma_disable_channel_async;
+	sdma->dma_device.device_synchronize = sdma_channel_synchronize;
 	sdma->dma_device.src_addr_widths = SDMA_DMA_BUSWIDTHS;
 	sdma->dma_device.dst_addr_widths = SDMA_DMA_BUSWIDTHS;
 	sdma->dma_device.directions = SDMA_DMA_DIRECTIONS;


