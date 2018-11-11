Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E2BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F0720871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2RutcHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F0720871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731894AbeKLKBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:01:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:60776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730749AbeKLIRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:24 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70D3421104;
        Sun, 11 Nov 2018 22:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975248;
        bh=TDguxrDq1BcsFHKxzLQa+nDxTCUgggoyGrP+zqwBr2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P2RutcHIVH//pe9/PYA+bDr/kArnw3hAkk+jFDF1U2Jv02/OQB51LKbmlVgnlSSDz
         f7Wrj7+YfdfYB/fO+lLBbQsOf1s1IX7G6CPHfY6Vnn04z3fTK+P9dO6FiqGOGzyrTQ
         udVezhqzVGL1e0W0QFK7uTHLfcTQhW/ql0mav6C4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 063/361] spi: spi-ep93xx: Use dma_data_direction for ep93xx_spi_dma_{finish,prepare}
Date:   Sun, 11 Nov 2018 14:16:50 -0800
Message-Id: <20181111221628.811340392@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit a1108c7b2efb892350ba6a0e932dfd45622f4e2b ]

Clang warns when one enumerated type is implicitly converted to another.

drivers/spi/spi-ep93xx.c:342:62: warning: implicit conversion from
enumeration type 'enum dma_transfer_direction' to different enumeration
type 'enum dma_data_direction' [-Wenum-conversion]
        nents = dma_map_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
./include/linux/dma-mapping.h:428:58: note: expanded from macro
'dma_map_sg'
#define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
                               ~~~~~~~~~~~~~~~~          ^
drivers/spi/spi-ep93xx.c:348:57: warning: implicit conversion from
enumeration type 'enum dma_transfer_direction' to different enumeration
type 'enum dma_data_direction' [-Wenum-conversion]
                dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
./include/linux/dma-mapping.h:429:62: note: expanded from macro
'dma_unmap_sg'
#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
                                 ~~~~~~~~~~~~~~~~~~          ^
drivers/spi/spi-ep93xx.c:377:56: warning: implicit conversion from
enumeration type 'enum dma_transfer_direction' to different enumeration
type 'enum dma_data_direction' [-Wenum-conversion]
        dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
./include/linux/dma-mapping.h:429:62: note: expanded from macro
'dma_unmap_sg'
#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
                                 ~~~~~~~~~~~~~~~~~~          ^
3 warnings generated.

dma_{,un}map_sg expect an enum of type dma_data_direction but this
driver uses dma_transfer_direction for everything. Convert the driver to
use dma_data_direction for these two functions.

There are two places that strictly require an enum of type
dma_transfer_direction: the direction member in struct dma_slave_config
and the direction parameter in dmaengine_prep_slave_sg. To avoid using
an explicit cast, add a simple function, ep93xx_dma_data_to_trans_dir,
to safely map between the two types because they are not 1 to 1 in
meaning.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-ep93xx.c |   36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -246,6 +246,19 @@ static int ep93xx_spi_read_write(struct
 	return -EINPROGRESS;
 }
 
+static enum dma_transfer_direction
+ep93xx_dma_data_to_trans_dir(enum dma_data_direction dir)
+{
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		return DMA_MEM_TO_DEV;
+	case DMA_FROM_DEVICE:
+		return DMA_DEV_TO_MEM;
+	default:
+		return DMA_TRANS_NONE;
+	}
+}
+
 /**
  * ep93xx_spi_dma_prepare() - prepares a DMA transfer
  * @master: SPI master
@@ -257,7 +270,7 @@ static int ep93xx_spi_read_write(struct
  */
 static struct dma_async_tx_descriptor *
 ep93xx_spi_dma_prepare(struct spi_master *master,
-		       enum dma_transfer_direction dir)
+		       enum dma_data_direction dir)
 {
 	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 	struct spi_transfer *xfer = master->cur_msg->state;
@@ -277,9 +290,9 @@ ep93xx_spi_dma_prepare(struct spi_master
 		buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
 
 	memset(&conf, 0, sizeof(conf));
-	conf.direction = dir;
+	conf.direction = ep93xx_dma_data_to_trans_dir(dir);
 
-	if (dir == DMA_DEV_TO_MEM) {
+	if (dir == DMA_FROM_DEVICE) {
 		chan = espi->dma_rx;
 		buf = xfer->rx_buf;
 		sgt = &espi->rx_sgt;
@@ -343,7 +356,8 @@ ep93xx_spi_dma_prepare(struct spi_master
 	if (!nents)
 		return ERR_PTR(-ENOMEM);
 
-	txd = dmaengine_prep_slave_sg(chan, sgt->sgl, nents, dir, DMA_CTRL_ACK);
+	txd = dmaengine_prep_slave_sg(chan, sgt->sgl, nents, conf.direction,
+				      DMA_CTRL_ACK);
 	if (!txd) {
 		dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
 		return ERR_PTR(-ENOMEM);
@@ -360,13 +374,13 @@ ep93xx_spi_dma_prepare(struct spi_master
  * unmapped.
  */
 static void ep93xx_spi_dma_finish(struct spi_master *master,
-				  enum dma_transfer_direction dir)
+				  enum dma_data_direction dir)
 {
 	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 	struct dma_chan *chan;
 	struct sg_table *sgt;
 
-	if (dir == DMA_DEV_TO_MEM) {
+	if (dir == DMA_FROM_DEVICE) {
 		chan = espi->dma_rx;
 		sgt = &espi->rx_sgt;
 	} else {
@@ -381,8 +395,8 @@ static void ep93xx_spi_dma_callback(void
 {
 	struct spi_master *master = callback_param;
 
-	ep93xx_spi_dma_finish(master, DMA_MEM_TO_DEV);
-	ep93xx_spi_dma_finish(master, DMA_DEV_TO_MEM);
+	ep93xx_spi_dma_finish(master, DMA_TO_DEVICE);
+	ep93xx_spi_dma_finish(master, DMA_FROM_DEVICE);
 
 	spi_finalize_current_transfer(master);
 }
@@ -392,15 +406,15 @@ static int ep93xx_spi_dma_transfer(struc
 	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 	struct dma_async_tx_descriptor *rxd, *txd;
 
-	rxd = ep93xx_spi_dma_prepare(master, DMA_DEV_TO_MEM);
+	rxd = ep93xx_spi_dma_prepare(master, DMA_FROM_DEVICE);
 	if (IS_ERR(rxd)) {
 		dev_err(&master->dev, "DMA RX failed: %ld\n", PTR_ERR(rxd));
 		return PTR_ERR(rxd);
 	}
 
-	txd = ep93xx_spi_dma_prepare(master, DMA_MEM_TO_DEV);
+	txd = ep93xx_spi_dma_prepare(master, DMA_TO_DEVICE);
 	if (IS_ERR(txd)) {
-		ep93xx_spi_dma_finish(master, DMA_DEV_TO_MEM);
+		ep93xx_spi_dma_finish(master, DMA_FROM_DEVICE);
 		dev_err(&master->dev, "DMA TX failed: %ld\n", PTR_ERR(txd));
 		return PTR_ERR(txd);
 	}


