Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbeBVTq2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 14:46:28 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34073 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbeBVTq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 14:46:26 -0500
X-Google-Smtp-Source: AH8x226ioEF7hD/k3fSyep9Hr47hA/M71fZACf77KO3OlGAMR//JZR7zPWKN6RS5gab+bEUo04CitQ==
From: Alexey Roslyakov <alexey.roslyakov@gmail.com>
Cc: alexey.roslyakov@gmail.com, Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: dw_mmc: update kernel-doc comments for dw_mci
Date: Fri, 23 Feb 2018 02:45:25 +0700
Message-Id: <20180222194525.28947-1-alexey.roslyakov@gmail.com>
X-Mailer: git-send-email 2.16.1
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cur_slot and num_slots has been removed from struct dw_mci in 42f989c002f2.
Unfortunately, inline documentation was not updated so far.

Fix @lock field documentation in Locking section.
Move @mrq field of struct dw_mci_slot mention closer to it
description, so no one could miss this slightest detail.

Couple of code style fixes as a bonus.

Signed-off-by: Alexey Roslyakov <alexey.roslyakov@gmail.com>
---
 drivers/mmc/host/dw_mmc.h | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index e3124f06a47e..451bc0862493 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -65,8 +65,7 @@ struct dw_mci_dma_slave {
  * @fifo_reg: Pointer to MMIO registers for data FIFO
  * @sg: Scatterlist entry currently being processed by PIO code, if any.
  * @sg_miter: PIO mapping scatterlist iterator.
- * @cur_slot: The slot which is currently using the controller.
- * @mrq: The request currently being processed on @cur_slot,
+ * @mrq: The request currently being processed on @slot,
  *	or NULL if the controller is idle.
  * @cmd: The command currently being sent to the card, or NULL.
  * @data: The data currently being transferred, or NULL if no data
@@ -102,7 +101,6 @@ struct dw_mci_dma_slave {
  * @bus_hz: The rate of @mck in Hz. This forms the basis for MMC bus
  *	rate and timeout calculations.
  * @current_speed: Configured rate of the controller.
- * @num_slots: Number of slots available.
  * @fifoth_val: The value of FIFOTH register.
  * @verid: Denote Version ID.
  * @dev: Device associated with the MMC controller.
@@ -134,17 +132,17 @@ struct dw_mci_dma_slave {
  * =======
  *
  * @lock is a softirq-safe spinlock protecting @queue as well as
+ * @slot, @mrq and @state. These must always be updated
  * at the same time while holding @lock.
+ * The @mrq field of struct dw_mci_slot is also protected by @lock,
+ * and must always be written at the same time as the slot is added to
+ * @queue.
  *
  * @irq_lock is an irq-safe spinlock protecting the INTMASK register
  * to allow the interrupt handler to modify it directly.  Held for only long
  * enough to read-modify-write INTMASK and no other locks are grabbed when
  * holding this one.
  *
- * The @mrq field of struct dw_mci_slot is also protected by @lock,
- * and must always be written at the same time as the slot is added to
- * @queue.
- *
  * @pending_events and @completed_events are accessed using atomic bit
  * operations, so they don't need any locking.
  *
@@ -321,8 +319,8 @@ struct dw_mci_board {
 #define SDMMC_ENABLE_SHIFT	0x110
 #define SDMMC_DATA(x)		(x)
 /*
-* Registers to support idmac 64-bit address mode
-*/
+ * Registers to support idmac 64-bit address mode
+ */
 #define SDMMC_DBADDRL		0x088
 #define SDMMC_DBADDRU		0x08c
 #define SDMMC_IDSTS64		0x090
@@ -449,7 +447,8 @@ struct dw_mci_board {
 	(SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET | SDMMC_CTRL_DMA_RESET)
 
 /* FIFO register access macros. These should not change the data endian-ness
- * as they are written to memory to be dealt with by the upper layers */
+ * as they are written to memory to be dealt with by the upper layers
+ */
 #define mci_fifo_readw(__reg)	__raw_readw(__reg)
 #define mci_fifo_readl(__reg)	__raw_readl(__reg)
 #define mci_fifo_readq(__reg)	__raw_readq(__reg)
-- 
2.16.1
