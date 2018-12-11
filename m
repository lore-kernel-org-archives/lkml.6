Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F8EC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD882086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543843;
	bh=o1B4JZvu3F0P3i/OzYIOTH2Bj56qHkAiFI4w9LLgEzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nTdZdZj83uoZ1MRp1sNU63yPF2so2BkJSGCNu6aMJkYLa5UJtQG2FjqVRu20QDtUm
	 CyMErCsKApdfRnzJNBxVZ5iCRfh4Chn7JEde2DJR67x88O5kWBeE/cunAMt5nCh7c7
	 HLEVbRM9C7OKFfdu9yDKqIKTQW9+QjL9VACSBUC0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD882086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbeLKP5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:57:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:46276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730784AbeLKP5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:57:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BC302146E;
        Tue, 11 Dec 2018 15:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543837;
        bh=o1B4JZvu3F0P3i/OzYIOTH2Bj56qHkAiFI4w9LLgEzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FD2ZOt7I/Bue2HnJjdg/oCYeeLQEsbnSem9Gj/1aODKjBNM0MCljF6Ch3H1X1YqWm
         5iOJMBNOzAgv4g/EXlM60iRiyhK1ydvOQevEo2A+OccSGUPTuxuFup2XNeue+yuV2F
         s7MsaZk9neW4i16Z5yV1mbAXNF7u9IGegenaqt20=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Robin Gong <yibin.gong@nxp.com>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 4.19 084/118] Revert "dmaengine: imx-sdma: alloclate bd memory from dma pool"
Date:   Tue, 11 Dec 2018 16:41:43 +0100
Message-Id: <20181211151647.662325438@linuxfoundation.org>
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

commit ebb853b1bd5f659b92c71dc6a9de44cfc37c78c0 upstream.

This reverts commit fe5b85c656bc. The SDMA engine needs the descriptors to
be contiguous in memory. As the dma pool API is only able to provide a
single descriptor per alloc invocation there is no guarantee that multiple
descriptors satisfy this requirement. Also the code in question is broken
as it only allocates memory for a single descriptor, without looking at the
number of descriptors required for the transfer, leading to out-of-bounds
accesses when the descriptors are written.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/imx-sdma.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

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
@@ -1192,10 +1190,11 @@ out:
 
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
@@ -1206,7 +1205,9 @@ out:
 
 static void sdma_free_bd(struct sdma_desc *desc)
 {
-	dma_pool_free(desc->sdmac->bd_pool, desc->bd, desc->bd_phys);
+	u32 bd_size = desc->num_bd * sizeof(struct sdma_buffer_descriptor);
+
+	dma_free_coherent(NULL, bd_size, desc->bd, desc->bd_phys);
 }
 
 static void sdma_desc_free(struct virt_dma_desc *vd)
@@ -1272,10 +1273,6 @@ static int sdma_alloc_chan_resources(str
 	if (ret)
 		goto disable_clk_ahb;
 
-	sdmac->bd_pool = dma_pool_create("bd_pool", chan->device->dev,
-				sizeof(struct sdma_buffer_descriptor),
-				32, 0);
-
 	return 0;
 
 disable_clk_ahb:
@@ -1304,9 +1301,6 @@ static void sdma_free_chan_resources(str
 
 	clk_disable(sdma->clk_ipg);
 	clk_disable(sdma->clk_ahb);
-
-	dma_pool_destroy(sdmac->bd_pool);
-	sdmac->bd_pool = NULL;
 }
 
 static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,


