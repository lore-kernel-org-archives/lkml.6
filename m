Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964793AbeCTBGv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 21:06:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44092 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932939AbeCTBGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 21:06:47 -0400
From: Mark Brown <broonie@kernel.org>
To: Stefan Agner <stefan@agner.ch>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        geert+renesas@glider.be, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi: rspi: use correct enum for DMA transfer direction" to the spi tree
In-Reply-To: <20180319221622.16867-1-stefan@agner.ch>
Message-Id: <20180320010640.AD90A44007A@finisterre.ee.mobilebroadband>
Date: Tue, 20 Mar 2018 01:06:40 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: rspi: use correct enum for DMA transfer direction

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 768d59f5d0139a6ff09e4430ec29cdc8b436421a Mon Sep 17 00:00:00 2001
From: Stefan Agner <stefan@agner.ch>
Date: Mon, 19 Mar 2018 23:16:22 +0100
Subject: [PATCH] spi: rspi: use correct enum for DMA transfer direction

Use enum dma_transfer_direction as required by dmaengine_prep_slave_sg
instead of enum dma_data_direction. This won't change behavior in
practice as the enum values are equivalent.

This fixes two warnings when building with clang:
  drivers/spi/spi-rspi.c:538:26: warning: implicit conversion from enumeration
      type 'enum dma_data_direction' to different enumeration type
      'enum dma_transfer_direction' [-Wenum-conversion]
                                        rx->sgl, rx->nents, DMA_FROM_DEVICE,
                                                            ^~~~~~~~~~~~~~~
  drivers/spi/spi-rspi.c:558:26: warning: implicit conversion from enumeration
      type 'enum dma_data_direction' to different enumeration type
      'enum dma_transfer_direction' [-Wenum-conversion]
                                        tx->sgl, tx->nents, DMA_TO_DEVICE,
                                                            ^~~~~~~~~~~~~

Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 0835a8d88fb8..95dc4d78618d 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -535,7 +535,7 @@ static int rspi_dma_transfer(struct rspi_data *rspi, struct sg_table *tx,
 	/* First prepare and submit the DMA request(s), as this may fail */
 	if (rx) {
 		desc_rx = dmaengine_prep_slave_sg(rspi->master->dma_rx,
-					rx->sgl, rx->nents, DMA_FROM_DEVICE,
+					rx->sgl, rx->nents, DMA_DEV_TO_MEM,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!desc_rx) {
 			ret = -EAGAIN;
@@ -555,7 +555,7 @@ static int rspi_dma_transfer(struct rspi_data *rspi, struct sg_table *tx,
 
 	if (tx) {
 		desc_tx = dmaengine_prep_slave_sg(rspi->master->dma_tx,
-					tx->sgl, tx->nents, DMA_TO_DEVICE,
+					tx->sgl, tx->nents, DMA_MEM_TO_DEV,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!desc_tx) {
 			ret = -EAGAIN;
-- 
2.16.2
