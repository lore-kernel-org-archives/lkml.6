Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251F9C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6172206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gSadSVsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6172206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeI0DJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:09:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36889 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeI0DJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:09:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id x26-v6so215542pfn.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 13:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Vmvogg65EXZVKEC8NSunl8+jHH3wFsJU/+3tgXXAmk=;
        b=gSadSVsZMqiT/ZcDED9juQp8v1QUaj59il7/w3jFK0PtTx8llBujAOONtMHBU4HjAk
         xBvKQ5ZFaSO67DTCubGyyFrofzMVQzkT6wVjRiy7XUU/jecD3djw/sEHefOJT7Obgymz
         3nnY1M9l1UiiyBQkd3zw+3JWm5bmTgzMsqxNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Vmvogg65EXZVKEC8NSunl8+jHH3wFsJU/+3tgXXAmk=;
        b=lYVKH8szSCADPw351kxqulhHRaW+CBLwkb3aY28CtaeGiCE1YZlglJDILZ6XpzRiUV
         SsCg1UoSFP7c9apGDhJh0pqEpz3G/yAVrQS20uWZ4w183G9+erZy/5xB82eV4snvrJsR
         7s9X9ZsxicW4ejzPpGrMFULAh6nMCOVXJjM3XJQtJq56tmy4xHIp4OLWHDWt/KbkSty7
         dtbtivSVA4VUB23ma+e4J0h5HWaDyGCLLzQvBs9ro/rCQFZmjbsZu/uZ27FIcygENSvK
         BdWhEO7liv4xECYUGSflSHEgZW9wHc6AF0I9pQ/i58BxPKmBmOgaJBYTFqhrnEcDFTHQ
         v+7w==
X-Gm-Message-State: ABuFfohugy5Vb6YsiAVPjPeHBfIuuD0oP/4ro3Q2UdhfkXdVMnLtegjx
        lw0rHWiNvIowbO+U1MZlFg6VSXnjtm0=
X-Google-Smtp-Source: ACcGV62wHAluXM+r0xkc6FLyTeh0DKE7ppgEj+wibPayemE14LyPN3OKRfabbb2Hz6YLs6RZPsylrg==
X-Received: by 2002:a63:4425:: with SMTP id r37-v6mr7136454pga.391.1537995286783;
        Wed, 26 Sep 2018 13:54:46 -0700 (PDT)
Received: from ryandcase.mtv.corp.google.com ([2620:15c:202:201:ed1c:3d1c:9d92:99cb])
        by smtp.gmail.com with ESMTPSA id s23-v6sm22091pgg.67.2018.09.26.13.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 13:54:46 -0700 (PDT)
From:   Ryan Case <ryandcase@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Trent Piepho <tpiepho@impinj.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Ryan Case <ryandcase@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v3 2/2] spi: Introduce new driver for Qualcomm QuadSPI controller
Date:   Wed, 26 Sep 2018 13:52:04 -0700
Message-Id: <20180926205204.184898-2-ryandcase@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20180926205204.184898-1-ryandcase@chromium.org>
References: <20180926205204.184898-1-ryandcase@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Girish Mahadevan <girishm@codeaurora.org>

New driver for Qualcomm QuadSPI(QSPI) controller that is used to
communicate with slaves such flash memory devices. The QSPI controller
can operate in 2 or 4 wire mode but only supports SPI Mode 0. The
controller can also operate in Single or Dual data rate modes.

Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
Signed-off-by: Ryan Case <ryandcase@chromium.org>
---

Changes in v3:
- Corrected QPSPI typo
- Removed setup function and moved configurations to prepare_message
- Added __maybe_unused to suspend and resume functions

Changes in v2:
- Addressed formatting feedback
- Squashed bug fixes and features from Doug
- Now uses transfer_one_message instead of mem_ops
- Fixed suspend/resume
- Added spinlocks

 drivers/spi/Kconfig         |   6 +
 drivers/spi/Makefile        |   1 +
 drivers/spi/spi-qcom-qspi.c | 598 ++++++++++++++++++++++++++++++++++++
 3 files changed, 605 insertions(+)
 create mode 100644 drivers/spi/spi-qcom-qspi.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index de03d67bcd2b..723d47bf281f 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -549,6 +549,12 @@ config SPI_RSPI
 	help
 	  SPI driver for Renesas RSPI and QSPI blocks.
 
+config SPI_QCOM_QSPI
+	tristate "QTI QSPI controller"
+	depends on ARCH_QCOM
+	help
+	  QSPI(Quad SPI) driver for Qualcomm QSPI controller.
+
 config SPI_QUP
 	tristate "Qualcomm SPI controller with QUP interface"
 	depends on ARCH_QCOM || (ARM && COMPILE_TEST)
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 876f8690fc47..f997c49255a6 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -112,3 +112,4 @@ obj-$(CONFIG_SPI_ZYNQMP_GQSPI)		+= spi-zynqmp-gqspi.o
 # SPI slave protocol handlers
 obj-$(CONFIG_SPI_SLAVE_TIME)		+= spi-slave-time.o
 obj-$(CONFIG_SPI_SLAVE_SYSTEM_CONTROL)	+= spi-slave-system-control.o
+obj-$(CONFIG_SPI_QCOM_QSPI)		+= spi-qcom-qspi.o
diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
new file mode 100644
index 000000000000..0ad2ef003068
--- /dev/null
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -0,0 +1,598 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
+
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+
+#include <asm/unaligned.h>
+
+#define AHB_MIN_HZ		9600000UL
+#define QSPI_NUM_CS		2
+#define QSPI_BYTES_PER_WORD	4
+#define MSTR_CONFIG		0x0000
+#define AHB_MASTER_CFG		0x0004
+#define MSTR_INT_EN		0x000C
+#define MSTR_INT_STATUS		0x0010
+#define PIO_XFER_CTRL		0x0014
+#define PIO_XFER_CFG		0x0018
+#define PIO_XFER_STATUS		0x001c
+#define PIO_DATAOUT_1B		0x0020
+#define PIO_DATAOUT_4B		0x0024
+#define RD_FIFO_CFG		0x0028
+#define RD_FIFO_STATUS		0x002c
+#define RD_FIFO_RESET		0x0030
+#define CUR_MEM_ADDR		0x0048
+#define HW_VERSION		0x004c
+#define RD_FIFO			0x0050
+#define SAMPLING_CLK_CFG	0x0090
+#define SAMPLING_CLK_STATUS	0x0094
+
+/* Macros to help set/get fields in MSTR_CONFIG register */
+#define	FULL_CYCLE_MODE		BIT(3)
+#define	FB_CLK_EN		BIT(4)
+#define	PIN_HOLDN		BIT(6)
+#define	PIN_WPN			BIT(7)
+#define	DMA_ENABLE		BIT(8)
+#define	BIG_ENDIAN_MODE		BIT(9)
+#define	SPI_MODE_MSK		0xc00
+#define	SPI_MODE_SHFT		10
+#define	CHIP_SELECT_NUM		BIT(12)
+#define	SBL_EN			BIT(13)
+#define	LPA_BASE_MSK		0x3c000
+#define	LPA_BASE_SHFT		14
+#define	TX_DATA_DELAY_MSK	0xc0000
+#define	TX_DATA_DELAY_SHFT	18
+#define	TX_CLK_DELAY_MSK	0x300000
+#define	TX_CLK_DELAY_SHFT	20
+#define	TX_CS_N_DELAY_MSK	0xc00000
+#define	TX_CS_N_DELAY_SHFT	22
+#define	TX_DATA_OE_DELAY_MSK	0x3000000
+#define	TX_DATA_OE_DELAY_SHFT	24
+
+/* Macros to help set/get fields in AHB_MSTR_CFG register */
+#define	HMEM_TYPE_START_MID_TRANS_MSK		0x7
+#define	HMEM_TYPE_START_MID_TRANS_SHFT		0
+#define	HMEM_TYPE_LAST_TRANS_MSK		0x38
+#define	HMEM_TYPE_LAST_TRANS_SHFT		3
+#define	USE_HMEMTYPE_LAST_ON_DESC_OR_CHAIN_MSK	0xc0
+#define	USE_HMEMTYPE_LAST_ON_DESC_OR_CHAIN_SHFT	6
+#define	HMEMTYPE_READ_TRANS_MSK			0x700
+#define	HMEMTYPE_READ_TRANS_SHFT		8
+#define	HSHARED					BIT(11)
+#define	HINNERSHARED				BIT(12)
+
+/* Macros to help set/get fields in MSTR_INT_EN/MSTR_INT_STATUS registers */
+#define	RESP_FIFO_UNDERRUN	BIT(0)
+#define	RESP_FIFO_NOT_EMPTY	BIT(1)
+#define	RESP_FIFO_RDY		BIT(2)
+#define	HRESP_FROM_NOC_ERR	BIT(3)
+#define	WR_FIFO_EMPTY		BIT(9)
+#define	WR_FIFO_FULL		BIT(10)
+#define	WR_FIFO_OVERRUN		BIT(11)
+#define	TRANSACTION_DONE	BIT(16)
+#define QSPI_ERR_IRQS		(RESP_FIFO_UNDERRUN | HRESP_FROM_NOC_ERR | \
+				 WR_FIFO_OVERRUN)
+#define	QSPI_ALL_IRQS		(QSPI_ERR_IRQS | RESP_FIFO_RDY | \
+				 WR_FIFO_EMPTY | WR_FIFO_FULL | \
+				 TRANSACTION_DONE)
+
+/* Macros to help set/get fields in RD_FIFO_CONFIG register */
+#define	CONTINUOUS_MODE		BIT(0)
+
+/* Macros to help set/get fields in RD_FIFO_RESET register */
+#define	RESET_FIFO		BIT(0)
+
+/* Macros to help set/get fields in PIO_TRANSFER_CONFIG register */
+#define	TRANSFER_DIRECTION	BIT(0)
+#define	MULTI_IO_MODE_MSK	0xe
+#define	MULTI_IO_MODE_SHFT	1
+#define	TRANSFER_FRAGMENT	BIT(8)
+
+/* Macros to help set/get fields in PIO_TRANSFER_CONTROL register */
+#define	REQUEST_COUNT_MSK	0xffff
+
+/* Macros to help set/get fields in PIO_TRANSFER_STATUS register */
+#define	WR_FIFO_BYTES_MSK	0xffff0000
+#define	WR_FIFO_BYTES_SHFT	16
+
+/* Macros to help set/get fields in RD_FIFO_STATUS register */
+#define	FIFO_EMPTY	BIT(11)
+#define	WR_CNTS_MSK	0x7f0
+#define	WR_CNTS_SHFT	4
+#define	RDY_64BYTE	BIT(3)
+#define	RDY_32BYTE	BIT(2)
+#define	RDY_16BYTE	BIT(1)
+#define	FIFO_RDY	BIT(0)
+
+/*
+ * The Mode transfer macros, the values are programmed to the HW registers
+ * when doing PIO mode of transfers.
+ */
+#define	SDR_1BIT	1
+#define	SDR_2BIT	2
+#define	SDR_4BIT	3
+#define	DDR_1BIT	5
+#define	DDR_2BIT	6
+#define	DDR_4BIT	7
+
+/* The Mode transfer macros when setting up DMA descriptors */
+#define	DMA_DESC_SINGLE_SPI	1
+#define	DMA_DESC_DUAL_SPI	2
+#define	DMA_DESC_QUAD_SPI	3
+
+enum qspi_dir {
+	QSPI_READ,
+	QSPI_WRITE,
+};
+
+struct qspi_xfer {
+	union {
+		const void *tx_buf;
+		void *rx_buf;
+	};
+	unsigned int rem_bytes;
+	int buswidth;
+	enum qspi_dir dir;
+	bool is_last;
+};
+
+enum qspi_clocks {
+	QSPI_CLK_CORE,
+	QSPI_CLK_IFACE,
+	QSPI_NUM_CLKS
+};
+
+struct qcom_qspi {
+	void __iomem *base;
+	struct device *dev;
+	struct clk_bulk_data clks[QSPI_NUM_CLKS];
+	struct qspi_xfer xfer;
+	spinlock_t lock;
+};
+
+static int qspi_buswidth_to_iomode(struct qcom_qspi *ctrl, int buswidth)
+{
+	switch (buswidth) {
+	case 1:
+		return SDR_1BIT;
+	case 2:
+		return SDR_2BIT;
+	case 4:
+		return SDR_4BIT;
+	default:
+		dev_warn_once(ctrl->dev,
+				"Unexpected bus width: %d\n", buswidth);
+		return SDR_1BIT;
+	}
+}
+
+static void qcom_qspi_pio_xfer_cfg(struct qcom_qspi *ctrl)
+{
+	u32 pio_xfer_cfg = 0;
+	struct qspi_xfer *xfer;
+
+	xfer = &ctrl->xfer;
+	pio_xfer_cfg = readl(ctrl->base + PIO_XFER_CFG);
+	pio_xfer_cfg &= ~TRANSFER_DIRECTION;
+	pio_xfer_cfg |= xfer->dir;
+	if (xfer->is_last)
+		pio_xfer_cfg &= ~TRANSFER_FRAGMENT;
+	else
+		pio_xfer_cfg |= TRANSFER_FRAGMENT;
+	pio_xfer_cfg &= ~MULTI_IO_MODE_MSK;
+	pio_xfer_cfg |= qspi_buswidth_to_iomode(ctrl, xfer->buswidth) <<
+			MULTI_IO_MODE_SHFT;
+
+	writel(pio_xfer_cfg, ctrl->base + PIO_XFER_CFG);
+}
+
+static void qcom_qspi_pio_xfer_ctrl(struct qcom_qspi *ctrl)
+{
+	u32 pio_xfer_ctrl;
+
+	pio_xfer_ctrl = readl(ctrl->base + PIO_XFER_CTRL);
+	pio_xfer_ctrl &= ~REQUEST_COUNT_MSK;
+	pio_xfer_ctrl |= ctrl->xfer.rem_bytes;
+	writel(pio_xfer_ctrl, ctrl->base + PIO_XFER_CTRL);
+}
+
+static void qcom_qspi_pio_xfer(struct qcom_qspi *ctrl)
+{
+	u32 ints;
+
+	qcom_qspi_pio_xfer_cfg(ctrl);
+
+	/* Ack any previous interrupts that might be hanging around */
+	writel(QSPI_ALL_IRQS, ctrl->base + MSTR_INT_STATUS);
+
+	/* Setup new interrupts */
+	if (ctrl->xfer.dir == QSPI_WRITE)
+		ints = QSPI_ERR_IRQS | WR_FIFO_EMPTY;
+	else
+		ints = QSPI_ERR_IRQS | RESP_FIFO_RDY;
+	writel(ints, ctrl->base + MSTR_INT_EN);
+
+	/* Kick off the transfer */
+	qcom_qspi_pio_xfer_ctrl(ctrl);
+}
+
+static void qcom_qspi_handle_err(struct spi_master *master,
+				 struct spi_message *msg)
+{
+	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
+	unsigned long flags;
+
+	spin_lock_irqsave(&ctrl->lock, flags);
+	writel(0, ctrl->base + MSTR_INT_EN);
+	ctrl->xfer.rem_bytes = 0;
+	spin_unlock_irqrestore(&ctrl->lock, flags);
+}
+
+static int qcom_qspi_transfer_one(struct spi_master *master,
+				  struct spi_device *slv,
+				  struct spi_transfer *xfer)
+{
+	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
+	int ret;
+	unsigned long speed_hz;
+	unsigned long flags;
+
+	speed_hz = slv->max_speed_hz;
+	if (xfer->speed_hz)
+		speed_hz = xfer->speed_hz;
+
+	ret = clk_set_rate(ctrl->clks[QSPI_CLK_CORE].clk, speed_hz * 4);
+	if (ret) {
+		dev_err(ctrl->dev, "Failed to set core clk %d\n", ret);
+		return ret;
+	}
+
+	spin_lock_irqsave(&ctrl->lock, flags);
+
+	/* We are half duplex, so either rx or tx will be set */
+	if (xfer->rx_buf) {
+		ctrl->xfer.dir = QSPI_READ;
+		ctrl->xfer.buswidth = xfer->rx_nbits;
+		ctrl->xfer.rx_buf = xfer->rx_buf;
+	} else {
+		ctrl->xfer.dir = QSPI_WRITE;
+		ctrl->xfer.buswidth = xfer->tx_nbits;
+		ctrl->xfer.tx_buf = xfer->tx_buf;
+	}
+	ctrl->xfer.is_last = list_is_last(&xfer->transfer_list,
+					  &master->cur_msg->transfers);
+	ctrl->xfer.rem_bytes = xfer->len;
+	qcom_qspi_pio_xfer(ctrl);
+
+	spin_unlock_irqrestore(&ctrl->lock, flags);
+
+	/* We'll call spi_finalize_current_transfer() when done */
+	return 1;
+}
+
+static int qcom_qspi_prepare_message(struct spi_master *master,
+				     struct spi_message *message)
+{
+	u32 mstr_cfg;
+	struct qcom_qspi *ctrl;
+	int tx_data_oe_delay = 1;
+	int tx_data_delay = 1;
+	unsigned long flags;
+
+	ctrl = spi_master_get_devdata(master);
+	spin_lock_irqsave(&ctrl->lock, flags);
+
+	mstr_cfg = readl(ctrl->base + MSTR_CONFIG);
+	mstr_cfg &= ~CHIP_SELECT_NUM;
+	if (message->spi->chip_select)
+		mstr_cfg |= CHIP_SELECT_NUM;
+
+	mstr_cfg = (mstr_cfg & ~SPI_MODE_MSK) |
+				(message->spi->mode << SPI_MODE_SHFT);
+	mstr_cfg |= FB_CLK_EN | PIN_WPN | PIN_HOLDN | SBL_EN | FULL_CYCLE_MODE;
+	mstr_cfg |= (mstr_cfg & ~TX_DATA_OE_DELAY_MSK) |
+				(tx_data_oe_delay << TX_DATA_OE_DELAY_SHFT);
+	mstr_cfg |= (mstr_cfg & ~TX_DATA_DELAY_MSK) |
+				(tx_data_delay << TX_DATA_DELAY_SHFT);
+	mstr_cfg &= ~DMA_ENABLE;
+
+	writel(mstr_cfg, ctrl->base + MSTR_CONFIG);
+	spin_unlock_irqrestore(&ctrl->lock, flags);
+
+	return 0;
+}
+
+static irqreturn_t pio_read(struct qcom_qspi *ctrl)
+{
+	u32 rd_fifo_status;
+	u32 rd_fifo;
+	unsigned int wr_cnts;
+	unsigned int bytes_to_read;
+	unsigned int words_to_read;
+	u32 *word_buf;
+	u8 *byte_buf;
+	int i;
+
+	rd_fifo_status = readl(ctrl->base + RD_FIFO_STATUS);
+
+	if (!(rd_fifo_status & FIFO_RDY)) {
+		dev_dbg(ctrl->dev, "Spurious IRQ %#x\n", rd_fifo_status);
+		return IRQ_NONE;
+	}
+
+	wr_cnts = (rd_fifo_status & WR_CNTS_MSK) >> WR_CNTS_SHFT;
+
+	if (wr_cnts > ctrl->xfer.rem_bytes)
+		wr_cnts = ctrl->xfer.rem_bytes;
+
+	words_to_read = wr_cnts / QSPI_BYTES_PER_WORD;
+	bytes_to_read = wr_cnts % QSPI_BYTES_PER_WORD;
+
+	if (words_to_read) {
+		word_buf = ctrl->xfer.rx_buf;
+		ctrl->xfer.rem_bytes -= words_to_read * QSPI_BYTES_PER_WORD;
+		for (i = 0; i < words_to_read; i++) {
+			rd_fifo = readl(ctrl->base + RD_FIFO);
+			put_unaligned(rd_fifo, word_buf++);
+		}
+		ctrl->xfer.rx_buf = word_buf;
+	}
+
+	if (bytes_to_read) {
+		byte_buf = ctrl->xfer.rx_buf;
+		rd_fifo = readl(ctrl->base + RD_FIFO);
+		ctrl->xfer.rem_bytes -= bytes_to_read;
+		for (i = 0; i < bytes_to_read; i++)
+			*byte_buf++ = rd_fifo >> (i * BITS_PER_BYTE);
+		ctrl->xfer.rx_buf = byte_buf;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t pio_write(struct qcom_qspi *ctrl)
+{
+	const void *xfer_buf = ctrl->xfer.tx_buf;
+	const int *word_buf;
+	const char *byte_buf;
+	unsigned int wr_fifo_bytes;
+	unsigned int wr_fifo_words;
+	unsigned int wr_size;
+	unsigned int rem_words;
+
+	wr_fifo_bytes = readl(ctrl->base + PIO_XFER_STATUS)
+				>> WR_FIFO_BYTES_SHFT;
+
+	if (ctrl->xfer.rem_bytes < QSPI_BYTES_PER_WORD) {
+		/* Process the last 1-3 bytes */
+		wr_size = min(wr_fifo_bytes, ctrl->xfer.rem_bytes);
+		ctrl->xfer.rem_bytes -= wr_size;
+
+		byte_buf = xfer_buf;
+		while (wr_size--)
+			writel(*byte_buf++,
+			       ctrl->base + PIO_DATAOUT_1B);
+		ctrl->xfer.tx_buf = byte_buf;
+	} else {
+		/*
+		 * Process all the whole words; to keep things simple we'll
+		 * just wait for the next interrupt to handle the last 1-3
+		 * bytes if we don't have an even number of words.
+		 */
+		rem_words = ctrl->xfer.rem_bytes / QSPI_BYTES_PER_WORD;
+		wr_fifo_words = wr_fifo_bytes / QSPI_BYTES_PER_WORD;
+
+		wr_size = min(rem_words, wr_fifo_words);
+		ctrl->xfer.rem_bytes -= wr_size * QSPI_BYTES_PER_WORD;
+
+		word_buf = xfer_buf;
+		while (wr_size--)
+			writel(get_unaligned(word_buf++),
+			       ctrl->base + PIO_DATAOUT_4B);
+		ctrl->xfer.tx_buf = word_buf;
+
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t qcom_qspi_irq(int irq, void *dev_id)
+{
+	u32 int_status;
+	struct qcom_qspi *ctrl = dev_id;
+	irqreturn_t ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ctrl->lock, flags);
+
+	int_status = readl(ctrl->base + MSTR_INT_STATUS);
+	writel(int_status, ctrl->base + MSTR_INT_STATUS);
+
+	if (ctrl->xfer.dir == QSPI_WRITE) {
+		if (int_status & WR_FIFO_EMPTY)
+			ret = pio_write(ctrl);
+	} else {
+		if (int_status & RESP_FIFO_RDY)
+			ret = pio_read(ctrl);
+	}
+
+	if (!ctrl->xfer.rem_bytes) {
+		writel(0, ctrl->base + MSTR_INT_EN);
+		spi_finalize_current_transfer(dev_get_drvdata(ctrl->dev));
+	}
+
+	spin_unlock_irqrestore(&ctrl->lock, flags);
+	return ret;
+}
+
+static int qcom_qspi_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct device *dev;
+	struct resource *res;
+	struct spi_master *master;
+	struct qcom_qspi *ctrl;
+
+	dev = &pdev->dev;
+
+	master = spi_alloc_master(dev, sizeof(struct qcom_qspi));
+	if (!master) {
+		dev_err(dev, "Failed to alloc spi master\n");
+		return -ENOMEM;
+	}
+	platform_set_drvdata(pdev, master);
+
+	ctrl = spi_master_get_devdata(master);
+
+	spin_lock_init(&ctrl->lock);
+	ctrl->dev = dev;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ctrl->base = devm_ioremap(dev, res->start, resource_size(res));
+	if (IS_ERR(ctrl->base)) {
+		ret = PTR_ERR(ctrl->base);
+		dev_err(dev, "Failed to get base addr %d\n", ret);
+		goto exit_probe_master_put;
+	}
+
+	ctrl->clks[QSPI_CLK_CORE].id = "core";
+	ctrl->clks[QSPI_CLK_IFACE].id = "iface";
+	ret = devm_clk_bulk_get(dev, QSPI_NUM_CLKS, ctrl->clks);
+	if (ret)
+		goto exit_probe_master_put;
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(dev, "Failed to get irq %d\n", ret);
+		goto exit_probe_master_put;
+	}
+	ret = devm_request_irq(dev, ret, qcom_qspi_irq,
+			IRQF_TRIGGER_HIGH, dev_name(dev), ctrl);
+	if (ret) {
+		dev_err(dev, "Failed to request irq %d\n", ret);
+		goto exit_probe_master_put;
+	}
+
+	master->max_speed_hz = 300000000;
+	master->num_chipselect = QSPI_NUM_CS;
+	master->bus_num = pdev->id;
+	master->dev.of_node = pdev->dev.of_node;
+	master->mode_bits = SPI_MODE_0 |
+			    SPI_TX_DUAL | SPI_RX_DUAL |
+			    SPI_TX_QUAD | SPI_RX_QUAD;
+	master->flags = SPI_MASTER_HALF_DUPLEX;
+	master->prepare_message = qcom_qspi_prepare_message;
+	master->transfer_one = qcom_qspi_transfer_one;
+	master->handle_err = qcom_qspi_handle_err;
+	master->auto_runtime_pm = true;
+
+	pm_runtime_enable(dev);
+
+	ret = spi_register_master(master);
+	if (ret)
+		goto exit_probe_runtime_disable;
+
+	return 0;
+
+exit_probe_runtime_disable:
+	pm_runtime_disable(dev);
+
+exit_probe_master_put:
+	spi_master_put(master);
+
+	return ret;
+}
+
+static int qcom_qspi_remove(struct platform_device *pdev)
+{
+	struct spi_master *master = platform_get_drvdata(pdev);
+
+	/* Unregister _before_ disabling pm_runtime() so we stop transfers */
+	spi_unregister_master(master);
+
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static int __maybe_unused qcom_qspi_runtime_suspend(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
+
+	clk_bulk_disable_unprepare(QSPI_NUM_CLKS, ctrl->clks);
+
+	return 0;
+}
+
+static int __maybe_unused qcom_qspi_runtime_resume(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
+
+	return clk_bulk_prepare_enable(QSPI_NUM_CLKS, ctrl->clks);
+}
+
+static int __maybe_unused qcom_qspi_suspend(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	int ret;
+
+	ret = spi_master_suspend(master);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret)
+		spi_master_resume(master);
+
+	return ret;
+}
+
+static int __maybe_unused qcom_qspi_resume(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		return ret;
+
+	ret = spi_master_resume(master);
+	if (ret)
+		pm_runtime_force_suspend(dev);
+
+	return ret;
+}
+
+static const struct dev_pm_ops qcom_qspi_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(qcom_qspi_runtime_suspend,
+			   qcom_qspi_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(qcom_qspi_suspend, qcom_qspi_resume)
+};
+
+static const struct of_device_id qcom_qspi_dt_match[] = {
+	{ .compatible = "qcom,qspi-v1", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qcom_qspi_dt_match);
+
+static struct platform_driver qcom_qspi_driver = {
+	.driver = {
+		.name		= "qcom_qspi",
+		.pm		= &qcom_qspi_dev_pm_ops,
+		.of_match_table = qcom_qspi_dt_match,
+	},
+	.probe = qcom_qspi_probe,
+	.remove = qcom_qspi_remove,
+};
+module_platform_driver(qcom_qspi_driver);
+
+MODULE_DESCRIPTION("SPI driver for QSPI cores");
+MODULE_LICENSE("GPL v2");
-- 
2.19.0.605.g01d371f741-goog

