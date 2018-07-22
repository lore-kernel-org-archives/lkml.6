Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A19ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2614A20850
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2614A20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387883AbeGVWS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 18:18:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:38774 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387731AbeGVWS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 18:18:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5F820AFD0;
        Sun, 22 Jul 2018 21:20:22 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Ionela Voinescu <ionela.voinescu@imgtec.com>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH 10/15] spi: img-spfi: Implement dual and quad mode
Date:   Sun, 22 Jul 2018 23:20:05 +0200
Message-Id: <20180722212010.3979-11-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180722212010.3979-1-afaerber@suse.de>
References: <20180722212010.3979-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ionela Voinescu <ionela.voinescu@imgtec.com>

For dual and quad modes to work, the SPFI controller needs
to have information about command/address/dummy bytes in the
transaction register. This information is not relevant for
single mode, and therefore it can have any value in the
allowed range. Therefore, for any read or write transfers of less
than 8 bytes (cmd = 1 byte, addr up to 7 bytes), SPFI will be
configured, but not enabled (unless it is the last transfer in
the queue). The transfer will be enabled by the subsequent transfer.
A pending transfer is determined by the content of the transaction
register: if command part is set and tsize is not.

This way we ensure that for dual and quad transactions
the command request size will appear in the command/address part
of the transaction register, while the data size will be in
tsize, all data being sent/received in the same transaction (as
set up in the transaction register).

Signed-off-by: Ionela Voinescu <ionela.voinescu@imgtec.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/spi/spi-img-spfi.c | 96 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 85 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index 7a37090dabbe..c845a505bae6 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -40,7 +40,8 @@
 #define SPFI_CONTROL_SOFT_RESET			BIT(11)
 #define SPFI_CONTROL_SEND_DMA			BIT(10)
 #define SPFI_CONTROL_GET_DMA			BIT(9)
-#define SPFI_CONTROL_SE			BIT(8)
+#define SPFI_CONTROL_SE				BIT(8)
+#define SPFI_CONTROL_TX_RX			BIT(1)
 #define SPFI_CONTROL_TMODE_SHIFT		5
 #define SPFI_CONTROL_TMODE_MASK			0x7
 #define SPFI_CONTROL_TMODE_SINGLE		0
@@ -51,6 +52,10 @@
 #define SPFI_TRANSACTION			0x18
 #define SPFI_TRANSACTION_TSIZE_SHIFT		16
 #define SPFI_TRANSACTION_TSIZE_MASK		0xffff
+#define SPFI_TRANSACTION_CMD_SHIFT		13
+#define SPFI_TRANSACTION_CMD_MASK		0x7
+#define SPFI_TRANSACTION_ADDR_SHIFT		10
+#define SPFI_TRANSACTION_ADDR_MASK		0x7
 
 #define SPFI_PORT_STATE				0x1c
 #define SPFI_PORT_STATE_DEV_SEL_SHIFT		20
@@ -87,6 +92,7 @@
  */
 #define SPFI_32BIT_FIFO_SIZE			64
 #define SPFI_8BIT_FIFO_SIZE			16
+#define SPFI_DATA_REQUEST_MAX_SIZE		8
 
 struct img_spfi {
 	struct device *dev;
@@ -103,6 +109,8 @@ struct img_spfi {
 	struct dma_chan *tx_ch;
 	bool tx_dma_busy;
 	bool rx_dma_busy;
+
+	bool complete;
 };
 
 struct img_spfi_device_data {
@@ -123,9 +131,11 @@ static inline void spfi_start(struct img_spfi *spfi)
 {
 	u32 val;
 
-	val = spfi_readl(spfi, SPFI_CONTROL);
-	val |= SPFI_CONTROL_SPFI_EN;
-	spfi_writel(spfi, val, SPFI_CONTROL);
+	if (spfi->complete) {
+		val = spfi_readl(spfi, SPFI_CONTROL);
+		val |= SPFI_CONTROL_SPFI_EN;
+		spfi_writel(spfi, val, SPFI_CONTROL);
+	}
 }
 
 static inline void spfi_reset(struct img_spfi *spfi)
@@ -138,12 +148,21 @@ static int spfi_wait_all_done(struct img_spfi *spfi)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(50);
 
+	if (!(spfi->complete))
+		return 0;
+
 	while (time_before(jiffies, timeout)) {
 		u32 status = spfi_readl(spfi, SPFI_INTERRUPT_STATUS);
 
 		if (status & SPFI_INTERRUPT_ALLDONETRIG) {
 			spfi_writel(spfi, SPFI_INTERRUPT_ALLDONETRIG,
 				    SPFI_INTERRUPT_CLEAR);
+			/*
+			 * Disable SPFI for it not to interfere with
+			 * pending transactions
+			 */
+			spfi_writel(spfi, spfi_readl(spfi, SPFI_CONTROL)
+			& ~SPFI_CONTROL_SPFI_EN, SPFI_CONTROL);
 			return 0;
 		}
 		cpu_relax();
@@ -494,9 +513,32 @@ static void img_spfi_config(struct spi_master *master, struct spi_device *spi,
 			    struct spi_transfer *xfer)
 {
 	struct img_spfi *spfi = spi_master_get_devdata(spi->master);
-	u32 val, div;
+	u32 val, div, transact;
+	bool is_pending;
 
 	/*
+	 * For read or write transfers of less than 8 bytes (cmd = 1 byte,
+	 * addr up to 7 bytes), SPFI will be configured, but not enabled
+	 * (unless it is the last transfer in the queue).The transfer will
+	 * be enabled by the subsequent transfer.
+	 * A pending transfer is determined by the content of the
+	 * transaction register: if command part is set and tsize
+	 * is not
+	 */
+	transact = spfi_readl(spfi, SPFI_TRANSACTION);
+	is_pending = ((transact >> SPFI_TRANSACTION_CMD_SHIFT) &
+			SPFI_TRANSACTION_CMD_MASK) &&
+			(!((transact >> SPFI_TRANSACTION_TSIZE_SHIFT) &
+			SPFI_TRANSACTION_TSIZE_MASK));
+
+	/* If there are no pending transactions it's OK to soft reset */
+	if (!is_pending) {
+		/* Start the transaction from a known (reset) state */
+		spfi_reset(spfi);
+	}
+
+	/*
+	 * Before anything else, set up parameters.
 	 * output = spfi_clk * (BITCLK / 512), where BITCLK must be a
 	 * power of 2 up to 128
 	 */
@@ -509,20 +551,52 @@ static void img_spfi_config(struct spi_master *master, struct spi_device *spi,
 	val |= div << SPFI_DEVICE_PARAMETER_BITCLK_SHIFT;
 	spfi_writel(spfi, val, SPFI_DEVICE_PARAMETER(spi->chip_select));
 
-	spfi_writel(spfi, xfer->len << SPFI_TRANSACTION_TSIZE_SHIFT,
-		    SPFI_TRANSACTION);
+	if (!list_is_last(&xfer->transfer_list, &master->cur_msg->transfers) &&
+		/*
+		 * For duplex mode (both the tx and rx buffers are !NULL) the
+		 * CMD, ADDR, and DUMMY byte parts of the transaction register
+		 * should always be 0 and therefore the pending transfer
+		 * technique cannot be used.
+		 */
+		(xfer->tx_buf) && (!xfer->rx_buf) &&
+		(xfer->len <= SPFI_DATA_REQUEST_MAX_SIZE) && !is_pending) {
+		transact = (1 & SPFI_TRANSACTION_CMD_MASK) <<
+			SPFI_TRANSACTION_CMD_SHIFT;
+		transact |= ((xfer->len - 1) & SPFI_TRANSACTION_ADDR_MASK) <<
+			SPFI_TRANSACTION_ADDR_SHIFT;
+		spfi->complete = false;
+	} else {
+		spfi->complete = true;
+		if (is_pending) {
+			/* Keep setup from pending transfer */
+			transact |= ((xfer->len & SPFI_TRANSACTION_TSIZE_MASK) <<
+				SPFI_TRANSACTION_TSIZE_SHIFT);
+		} else {
+			transact = ((xfer->len & SPFI_TRANSACTION_TSIZE_MASK) <<
+				SPFI_TRANSACTION_TSIZE_SHIFT);
+		}
+	}
+	spfi_writel(spfi, transact, SPFI_TRANSACTION);
 
 	val = spfi_readl(spfi, SPFI_CONTROL);
 	val &= ~(SPFI_CONTROL_SEND_DMA | SPFI_CONTROL_GET_DMA);
-	if (xfer->tx_buf)
+	/*
+	 * We set up send DMA for pending transfers also, as
+	 * those are always send transfers
+	 */
+	if ((xfer->tx_buf) || is_pending)
 		val |= SPFI_CONTROL_SEND_DMA;
-	if (xfer->rx_buf)
+	if (xfer->tx_buf)
+		val |= SPFI_CONTROL_TX_RX;
+	if (xfer->rx_buf) {
 		val |= SPFI_CONTROL_GET_DMA;
+		val &= ~SPFI_CONTROL_TX_RX;
+	}
 	val &= ~(SPFI_CONTROL_TMODE_MASK << SPFI_CONTROL_TMODE_SHIFT);
-	if (xfer->tx_nbits == SPI_NBITS_DUAL &&
+	if (xfer->tx_nbits == SPI_NBITS_DUAL ||
 	    xfer->rx_nbits == SPI_NBITS_DUAL)
 		val |= SPFI_CONTROL_TMODE_DUAL << SPFI_CONTROL_TMODE_SHIFT;
-	else if (xfer->tx_nbits == SPI_NBITS_QUAD &&
+	else if (xfer->tx_nbits == SPI_NBITS_QUAD ||
 		 xfer->rx_nbits == SPI_NBITS_QUAD)
 		val |= SPFI_CONTROL_TMODE_QUAD << SPFI_CONTROL_TMODE_SHIFT;
 	val |= SPFI_CONTROL_SE;
-- 
2.16.4

