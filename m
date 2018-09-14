Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CA5FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBFB020853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBFB020853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeINWVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:21:41 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56793 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbeINWVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:21:40 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7] helo=dude.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1g0rXr-0000yl-Hl; Fri, 14 Sep 2018 19:06:15 +0200
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robin Gong <yibin.gong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: [PATCH v2 2/4] Revert "dmaengine: imx-sdma: alloclate bd memory from dma pool"
Date:   Fri, 14 Sep 2018 19:06:13 +0200
Message-Id: <20180914170615.12659-2-l.stach@pengutronix.de>
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

This reverts commit fe5b85c656bc. The SDMA engine needs the descriptors to
be contiguous in memory. As the dma pool API is only able to provide a
single descriptor per alloc invocation there is no guarantee that multiple
descriptors satisfy this requirement. Also the code in question is broken
as it only allocates memory for a single descriptor, without looking at the
number of descriptors required for the transfer, leading to out-of-bounds
accesses when the descriptors are written.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/dma/imx-sdma.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 3bca5e0c715f..8d2fec8b16cc 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -24,7 +24,6 @@
 #include <linux/spinlock.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
-#include <linux/dmapool.h>
 #include <linux/firmware.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
@@ -376,7 +375,6 @@ struct sdma_channel {
 	u32				shp_addr, per_addr;
 	enum dma_status			status;
 	struct imx_dma_data		data;
-	struct dma_pool			*bd_pool;
 };
 
 #define IMX_DMA_SG_LOOP		BIT(0)
@@ -1192,10 +1190,11 @@ static int sdma_request_channel0(struct sdma_engine *sdma)
 
 static int sdma_alloc_bd(struct sdma_desc *desc)
 {
+	u32 bd_size = desc->num_bd * sizeof(struct sdma_buffer_descriptor);
 	int ret = 0;
 
-	desc->bd = dma_pool_alloc(desc->sdmac->bd_pool, GFP_ATOMIC,
-					&desc->bd_phys);
+	desc->bd = dma_zalloc_coherent(NULL, bd_size, &desc->bd_phys,
+					GFP_ATOMIC);
 	if (!desc->bd) {
 		ret = -ENOMEM;
 		goto out;
@@ -1206,7 +1205,9 @@ static int sdma_alloc_bd(struct sdma_desc *desc)
 
 static void sdma_free_bd(struct sdma_desc *desc)
 {
-	dma_pool_free(desc->sdmac->bd_pool, desc->bd, desc->bd_phys);
+	u32 bd_size = desc->num_bd * sizeof(struct sdma_buffer_descriptor);
+
+	dma_free_coherent(NULL, bd_size, desc->bd, desc->bd_phys);
 }
 
 static void sdma_desc_free(struct virt_dma_desc *vd)
@@ -1272,10 +1273,6 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
 	if (ret)
 		goto disable_clk_ahb;
 
-	sdmac->bd_pool = dma_pool_create("bd_pool", chan->device->dev,
-				sizeof(struct sdma_buffer_descriptor),
-				32, 0);
-
 	return 0;
 
 disable_clk_ahb:
@@ -1304,9 +1301,6 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 
 	clk_disable(sdma->clk_ipg);
 	clk_disable(sdma->clk_ahb);
-
-	dma_pool_destroy(sdmac->bd_pool);
-	sdmac->bd_pool = NULL;
 }
 
 static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
-- 
2.19.0

