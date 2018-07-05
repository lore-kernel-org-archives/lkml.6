Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C84C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2C5240CE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="h4NSo7X/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fSMq7Vnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2C5240CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753895AbeGEVrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:47:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60540 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753776AbeGEVq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:46:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 54E3A60B25; Thu,  5 Jul 2018 21:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530827215;
        bh=mTFdeOEhORUjj2jO7LzqZb4ITtVUfQJC2OLEBFAq9PE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h4NSo7X/mg0gFJLsjYiL0vMrCZbG6YhqTi3XGzJFQR28URWWJo0kR8+yPztY3FIQT
         xWSwd7RxK3v8MMG2EWBQp19YjNQ4ytZ69nH5l296cHEFqWjvM6Q+m5AskLdt3t1B8S
         CK001fzi0Bw4JGInaARsBMbnkRwP9UE6NDd6yc1U=
Received: from girishm-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: girishm@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6405F60251;
        Thu,  5 Jul 2018 21:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530827213;
        bh=mTFdeOEhORUjj2jO7LzqZb4ITtVUfQJC2OLEBFAq9PE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fSMq7VnmJVqjsHPHq2ZjA3ZwSUR5miE2iNY0AMdFhW32aAUfm/f18okupc9xEpMDN
         matQZIuwBcSrrPbAfDzhtA+91f7JCPooDVW8R9XArr9UZTF4oOYZv3mUjcnIsWfePX
         GVBaIbATWFW/4iiRuMpX5cmBxpampd2/CVJnv8Mo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6405F60251
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=girishm@codeaurora.org
From:   Girish Mahadevan <girishm@codeaurora.org>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Girish Mahadevan <girishm@codeaurora.org>, dianders@chromium.org,
        swboyd@chromium.org, linux-arm-msm@vger.kernel.org,
        sdharia@codeaurora.org, kramasub@codeaurora.org,
        boris.brezillon@bootlin.com
Subject: [PATCH 2/2] spi: Introduce new driver for Qualcomm QuadSPI controller
Date:   Thu,  5 Jul 2018 15:46:42 -0600
Message-Id: <1530827202-9997-2-git-send-email-girishm@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530827202-9997-1-git-send-email-girishm@codeaurora.org>
References: <1530827202-9997-1-git-send-email-girishm@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New driver for Qualcomm QuadSPI(QSPI) controller that is used to
communicate with slaves such flash memory devices. The QSPI controller
can operate in 2 or 4 wire mode but only supports SPI Mode 0 and SPI
Mode 3. The controller can also operate in Single or Dual data rate modes.

Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
---
 drivers/spi/Kconfig         |   7 +
 drivers/spi/Makefile        |   1 +
 drivers/spi/spi-qcom-qspi.c | 728 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 736 insertions(+)
 create mode 100644 drivers/spi/spi-qcom-qspi.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 97e1fa9..bc71cd3 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -571,6 +571,13 @@ config SPI_QCOM_GENI
 	  This driver can also be built as a module.  If so, the module
 	  will be called spi-geni-qcom.
 
+config SPI_QCOM_QSPI
+	tristate "QTI QPSPI controller"
+	depends on ARCH_QCOM
+	help
+	  QSPI(Quad SPI) driver for Qualcomm QSPI controller.
+
 config SPI_QUP
 	tristate "Qualcomm SPI controller with QUP interface"
 	depends on ARCH_QCOM || (ARM && COMPILE_TEST)
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 5a0ce66..93cea68 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -113,3 +113,4 @@ obj-$(CONFIG_SPI_ZYNQMP_GQSPI)		+= spi-zynqmp-gqspi.o
 # SPI slave protocol handlers
 obj-$(CONFIG_SPI_SLAVE_TIME)		+= spi-slave-time.o
 obj-$(CONFIG_SPI_SLAVE_SYSTEM_CONTROL)	+= spi-slave-system-control.o
+obj-$(CONFIG_SPI_QCOM_QSPI)		+= spi-qcom-qspi.o
diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
new file mode 100644
index 0000000..6a86605
--- /dev/null
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -0,0 +1,728 @@
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
+#define RD_FIFOk		0x0050
+#define SAMPLING_CLK_CFG	0x0090
+#define SAMPLING_CLK_STATUS	0x0094
+
+/* Macros to help set/get fields in MSTR_CONFIG register */
+#define	FULL_CYCLE_MODE	BIT(3)
+#define	FB_CLK_EN	BIT(4)
+#define	PIN_HOLDN	BIT(6)
+#define	PIN_WPN		(BIT(7))
+#define	DMA_ENABLE		(BIT(8))
+#define	BIG_ENDIAN_MODE		(BIT(9))
+#define	SPI_MODE_MSK		(0xc00)
+#define	SPI_MODE_SHFT		(10)
+#define	CHIP_SELECT_NUM		BIT(12)
+#define	SBL_EN			BIT(13)
+#define	LPA_BASE_MSK		(0x3c000)
+#define	LPA_BASE_SHFT		(14)
+#define	TX_DATA_DELAY_MSK	(0xc0000)
+#define	TX_DATA_DELAY_SHFT	(18)
+#define	TX_CLK_DELAY_MSK	(0x300000)
+#define	TX_CLK_DELAY_SHFT	(20)
+#define	TX_CS_N_DELAY_MSK	(0xc00000)
+#define	TX_CS_N_DELAY_SHFT	(22)
+#define	TX_DATA_OE_DELAY_MSK	(0x3000000)
+#define	TX_DATA_OE_DELAY_SHFT	(24)
+
+/* Macros to help set/get fields in AHB_MSTR_CFG register */
+#define	HMEM_TYPE_START_MID_TRANS_MSK	(0x7)
+#define	HMEM_TYPE_START_MID_TRANS_SHFT	(0)
+#define	HMEM_TYPE_LAST_TRANS_MSK	(0x38)
+#define	HMEM_TYPE_LAST_TRANS_SHFT	(3)
+#define	USE_HMEMTYPE_LAST_ON_DESC_OR_CHAIN_MSK	(0xc0)
+#define	USE_HMEMTYPE_LAST_ON_DESC_OR_CHAIN_SHFT	(6)
+#define	HMEMTYPE_READ_TRANS_MSK		(0x700)
+#define	HMEMTYPE_READ_TRANS_SHFT	(8)
+#define	HSHARED		(BIT(11))
+#define	HINNERSHARED	(BIT(12))
+
+/* Macros to help set/get fields in MSTR_INT_EN/MSTR_INT_STATUS registers */
+#define	RESP_FIFO_UNDERRUN	(BIT(0))
+#define	RESP_FIFO_NOT_EMPTY	(BIT(1))
+#define	RESP_FIFO_RDY	(BIT(2))
+#define	HRESP_FROM_NOC_ERR	(BIT(3))
+#define	WR_FIFO_EMPTY	(BIT(9))
+#define	WR_FIFO_FULL	(BIT(10))
+#define	WR_FIFO_OVERRUN	(BIT(11))
+#define	TRANSACTION_DONE	(BIT(16))
+#define	ENABLE_ALL_IRQ	(RESP_FIFO_UNDERRUN | RESP_FIFO_RDY | \
+		HRESP_FROM_NOC_ERR | WR_FIFO_EMPTY | WR_FIFO_FULL |\
+		WR_FIFO_OVERRUN | TRANSACTION_DONE)
+
+/* Macros to help set/get fields in RD_FIFO_CONFIG register */
+#define	CONTINUOUS_MODE	(BIT(0))
+
+/* Macros to help set/get fields in RD_FIFO_RESET register */
+#define	RESET_FIFO	(BIT(0))
+
+/* Macros to help set/get fields in PIO_TRANSFER_CONFIG register */
+#define	TRANSFER_DIRECTION	(BIT(0))
+#define	MULTI_IO_MODE_MSK	(0xe)
+#define	MULTI_IO_MODE_SHFT	(1)
+#define	TRANSFER_FRAGMENT	(BIT(8))
+
+/* Macros to help set/get fields in PIO_TRANSFER_CONTROL register */
+#define	REQUEST_COUNT_MSK	(0xffff)
+
+/* Macros to help set/get fields in PIO_TRANSFER_STATUS register */
+#define	WR_FIFO_BYTES_MSK	(0xffff0000)
+#define	WR_FIFO_BYTES_SHFT	(16)
+
+/* Macros to help set/get fields in RD_FIFO_STATUS register */
+#define	FIFO_EMPTY	(BIT(11))
+#define	WR_CNTS_MSK	(0x7f0)
+#define	WR_CNTS_SHFT	(4)
+#define	RDY_64BYTE	(BIT(3))
+#define	RDY_32BYTE	(BIT(2))
+#define	RDY_16BYTE	(BIT(1))
+#define	FIFO_RDY	(BIT(0))
+
+/*
+ * The Mode transfer macros, the values are programmed to the HW registers
+ * when doing PIO mode of transfers.
+ */
+#define	SDR_1BIT	(1)
+#define	SDR_2BIT	(2)
+#define	SDR_4BIT	(3)
+#define	DDR_1BIT	(5)
+#define	DDR_2BIT	(6)
+#define	DDR_4BIT	(7)
+
+/* The Mode transfer macros when setting up DMA descriptors */
+#define	DMA_DESC_SINGLE_SPI	(1)
+#define	DMA_DESC_DUAL_SPI	(2)
+#define	DMA_DESC_QUAD_SPI	(3)
+
+enum qspi_dir {
+	QSPI_READ,
+	QSPI_WRITE,
+};
+
+struct qspi_xfer {
+	struct spi_transfer *xfer;
+	const void *tx_buf;
+	void *rx_buf;
+	u32 rem_bytes;
+	int mode;
+	enum qspi_dir dir;
+	bool is_last;
+};
+
+struct qcom_qspi {
+	void __iomem *base;
+	struct device *dev;
+	struct clk *core_clk;
+	struct clk *iface_clk;
+	int irq;
+	struct qspi_xfer xfer;
+	struct completion transfer_complete;
+};
+
+static void qcom_qspi_unset_clks(struct qcom_qspi *ctrl)
+{
+
+	if (!ctrl)
+		return;
+
+	clk_disable_unprepare(ctrl->core_clk);
+	clk_disable_unprepare(ctrl->iface_clk);
+
+}
+
+static int qcom_qspi_set_clks(struct qcom_qspi *ctrl, u32 core_speed)
+{
+	int ret;
+
+	ret = clk_set_rate(ctrl->core_clk, core_speed);
+	if (ret) {
+		dev_err(ctrl->dev, "%s: Failed to set core clk %d\n",
+							 __func__, ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(ctrl->core_clk);
+	if (ret) {
+		dev_err(ctrl->dev, "%s: Failed to prepare core clk %d\n",
+							 __func__, ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(ctrl->iface_clk);
+	if (ret) {
+		dev_err(ctrl->dev, "%s: Failed to prepare iface clk %d\n",
+							 __func__, ret);
+		goto exit_set_core_clk;
+	}
+
+	return ret;
+exit_set_core_clk:
+	clk_disable_unprepare(ctrl->iface_clk);
+	return ret;
+}
+
+static int qcom_qspi_pio_xfer_cfg(struct qcom_qspi *ctrl)
+{
+	u32 pio_xfer_cfg = 0;
+	struct qspi_xfer *xfer;
+
+	if (!ctrl)
+		return -ENODEV;
+
+	xfer = &ctrl->xfer;
+	pio_xfer_cfg = readl_relaxed((ctrl->base + PIO_XFER_CFG));
+	pio_xfer_cfg &= ~TRANSFER_DIRECTION;
+	pio_xfer_cfg |= xfer->dir;
+	if (xfer->is_last)
+		pio_xfer_cfg &= ~TRANSFER_FRAGMENT;
+	else
+		pio_xfer_cfg |= TRANSFER_FRAGMENT;
+	pio_xfer_cfg &= ~MULTI_IO_MODE_MSK;
+	pio_xfer_cfg |= (xfer->mode << MULTI_IO_MODE_SHFT);
+
+	writel_relaxed(pio_xfer_cfg, (ctrl->base + PIO_XFER_CFG));
+	return 0;
+}
+
+static int qcom_qspi_pio_xfer_ctrl(struct qcom_qspi *ctrl)
+{
+	u32 pio_xfer_ctrl;
+
+	if (!ctrl)
+		return -ENODEV;
+
+	pio_xfer_ctrl = readl_relaxed(ctrl->base + PIO_XFER_CTRL);
+	pio_xfer_ctrl &= ~REQUEST_COUNT_MSK;
+	pio_xfer_ctrl |= ctrl->xfer.rem_bytes;
+	writel_relaxed(pio_xfer_ctrl, ctrl->base + PIO_XFER_CTRL);
+	return 0;
+}
+
+static int qcom_qspi_pio_xfer(struct qcom_qspi *ctrl)
+{
+	int ret;
+	u32 mstr_cfg;
+	int int_status = ENABLE_ALL_IRQ;
+
+	mstr_cfg = readl_relaxed(ctrl->base + MSTR_CONFIG);
+	mstr_cfg &= ~DMA_ENABLE;
+	writel_relaxed(mstr_cfg, ctrl->base + MSTR_CONFIG);
+
+	ret = qcom_qspi_pio_xfer_cfg(ctrl);
+	if  (ret) {
+		dev_err(ctrl->dev, "%s: Failed pio_xfer_cfg %d\n",
+				__func__, ret);
+		return ret;
+	}
+
+	ret = qcom_qspi_pio_xfer_ctrl(ctrl);
+	if  (ret) {
+		dev_err(ctrl->dev, "%s: Failed pio_xfer_ctl %d\n",
+				__func__, ret);
+		return ret;
+	}
+	writel_relaxed(int_status, ctrl->base + MSTR_INT_EN);
+	writel_relaxed(int_status, ctrl->base + MSTR_INT_STATUS);
+	return 0;
+}
+
+static int wait_for_xfer(struct qcom_qspi *ctrl)
+{
+	if (!wait_for_completion_timeout(&ctrl->transfer_complete, HZ))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int process_opcode(const struct spi_mem_op *op, struct qcom_qspi *ctrl)
+{
+	int ret;
+
+	ctrl->xfer.dir = QSPI_WRITE;
+	ctrl->xfer.mode = op->cmd.buswidth;
+	if (op->addr.nbytes || op->data.nbytes)
+		ctrl->xfer.is_last = false;
+	else
+		ctrl->xfer.is_last = true;
+	ctrl->xfer.rem_bytes = 1;
+	ctrl->xfer.tx_buf = &op->cmd.opcode;
+	ret = qcom_qspi_pio_xfer(ctrl);
+	if (ret)
+		return ret;
+	ret = wait_for_xfer(ctrl);
+	return ret;
+}
+
+static int process_addr(const struct spi_mem_op *op, struct qcom_qspi *ctrl)
+{
+	int ret;
+
+	ctrl->xfer.dir = QSPI_WRITE;
+	ctrl->xfer.mode = op->addr.buswidth;
+	if (op->data.nbytes)
+		ctrl->xfer.is_last = false;
+	else
+		ctrl->xfer.is_last = true;
+	ctrl->xfer.rem_bytes = op->addr.nbytes;
+	ctrl->xfer.tx_buf = &op->addr.val;
+	ret = qcom_qspi_pio_xfer(ctrl);
+	if (ret)
+		return ret;
+	ret = wait_for_xfer(ctrl);
+	return ret;
+}
+
+static int process_dummy(const struct spi_mem_op *op, struct qcom_qspi *ctrl)
+{
+	int ret = 0;
+	unsigned char *buf;
+
+	ctrl->xfer.dir = QSPI_WRITE;
+	ctrl->xfer.mode = DDR_4BIT;
+	ctrl->xfer.is_last = false;
+	ctrl->xfer.rem_bytes = op->dummy.nbytes;
+	buf = (unsigned char *)kmalloc_array(op->dummy.nbytes,
+				sizeof(unsigned char), GFP_KERNEL);
+	memset(buf, 0xff, op->dummy.nbytes);
+	ctrl->xfer.tx_buf = buf;
+	ret = qcom_qspi_pio_xfer(ctrl);
+	if (ret)
+		goto exit_process_dummy;
+	ret = wait_for_xfer(ctrl);
+exit_process_dummy:
+	kfree(buf);
+	return ret;
+}
+
+static int process_data(const struct spi_mem_op *op, struct qcom_qspi *ctrl)
+{
+	int ret;
+
+	ctrl->xfer.dir = (op->data.dir == SPI_MEM_DATA_IN) ?
+					QSPI_READ : QSPI_WRITE;
+	ctrl->xfer.mode = op->data.buswidth;
+	ctrl->xfer.is_last = true;
+	ctrl->xfer.rem_bytes = op->data.nbytes;
+
+	if (ctrl->xfer.dir == QSPI_WRITE)
+		ctrl->xfer.tx_buf = op->data.buf.out;
+	else
+		ctrl->xfer.rx_buf = op->data.buf.in;
+	ret = qcom_qspi_pio_xfer(ctrl);
+	if (ret)
+		return ret;
+	ret = wait_for_xfer(ctrl);
+	return ret;
+}
+
+static int qcom_qspi_exec_mem_op(struct spi_mem *mem,
+				const struct spi_mem_op *op)
+{
+	struct qcom_qspi *ctrl = spi_master_get_devdata(mem->spi->master);
+	struct spi_device *dev = mem->spi;
+	int ret;
+
+	if (!ctrl)
+		return -ENODEV;
+
+	if (dev->max_speed_hz) {
+		ret = qcom_qspi_set_clks(ctrl, dev->max_speed_hz);
+		if (ret)
+			return ret;
+	}
+
+	ret = process_opcode(op, ctrl);
+	if (ret)
+		return ret;
+
+	if (op->addr.nbytes) {
+		ret = process_addr(op, ctrl);
+		if (ret)
+			return ret;
+	}
+
+	if (op->dummy.nbytes) {
+		ret = process_dummy(op, ctrl);
+		if (ret)
+			return ret;
+	}
+
+	if (op->data.nbytes) {
+		ret = process_data(op, ctrl);
+		if (ret)
+			return ret;
+	}
+	return ret;
+}
+
+static int qcom_qspi_setup(struct spi_device *spi)
+{
+	int ret;
+	u32 mstr_cfg = 0;
+	struct qcom_qspi *ctrl;
+	int tx_data_oe_delay = 1;
+	int tx_data_delay = 1;
+
+	ctrl = spi_master_get_devdata(spi->master);
+
+	ret = pm_runtime_get_sync(ctrl->dev);
+	if (ret < 0) {
+		dev_err(ctrl->dev, "%s: RPM resume failed %d",
+						__func__, ret);
+		return ret;
+	}
+
+	mstr_cfg = readl_relaxed(ctrl->base + MSTR_CONFIG);
+	mstr_cfg &= ~CHIP_SELECT_NUM;
+	if (spi->chip_select)
+		mstr_cfg |= CHIP_SELECT_NUM;
+
+	mstr_cfg = (mstr_cfg & ~SPI_MODE_MSK) | (spi->mode << SPI_MODE_SHFT);
+	mstr_cfg |= FB_CLK_EN | PIN_WPN | PIN_HOLDN | SBL_EN |
+				FULL_CYCLE_MODE | DMA_ENABLE;
+	mstr_cfg |= (mstr_cfg & ~TX_DATA_OE_DELAY_MSK) |
+				(tx_data_oe_delay << TX_DATA_OE_DELAY_SHFT);
+	mstr_cfg |= (mstr_cfg & ~TX_DATA_DELAY_MSK) |
+				(tx_data_delay << TX_DATA_DELAY_SHFT);
+
+	writel_relaxed(mstr_cfg, (ctrl->base + MSTR_CONFIG));
+	/*
+	 * Ensure that the configuration goes through by reading back
+	 * a register from the IO space.
+	 */
+	mb();
+	mstr_cfg = readl_relaxed((ctrl->base + MSTR_CONFIG));
+	pm_runtime_put_sync(ctrl->dev);
+	return ret;
+}
+
+static irqreturn_t pio_read(struct qcom_qspi *ctrl)
+{
+	u32 rd_fifo_status;
+	u32 wr_cnts;
+	bool fifo_rdy;
+	u32 rd_fifo;
+	int bytes_to_read;
+	int words_to_read;
+	int i;
+
+	if (!ctrl)
+		return IRQ_NONE;
+	rd_fifo_status = readl_relaxed(ctrl->base + RD_FIFO_STATUS);
+	wr_cnts = (rd_fifo_status & WR_CNTS_MSK) >> WR_CNTS_SHFT;
+	fifo_rdy = (rd_fifo_status & FIFO_RDY) ? true : false;
+
+	if (!fifo_rdy) {
+		dev_dbg(ctrl->dev, "%s: Spurious IRQ 0x%x",
+			__func__, rd_fifo_status);
+		return IRQ_NONE;
+	}
+
+	words_to_read = wr_cnts / QSPI_BYTES_PER_WORD;
+	bytes_to_read = wr_cnts % QSPI_BYTES_PER_WORD;
+	if (!ctrl->xfer.rx_buf)
+		return IRQ_NONE;
+
+	if (words_to_read) {
+		u32 *w_buf = ctrl->xfer.rx_buf;
+
+		ctrl->xfer.rem_bytes -=
+				(words_to_read * QSPI_BYTES_PER_WORD);
+		for (i = 0; i < words_to_read; i++) {
+			rd_fifo = readl_relaxed(ctrl->base + RD_FIFOk);
+			*w_buf++ = rd_fifo;
+		}
+		ctrl->xfer.rx_buf = w_buf;
+	}
+
+	if (bytes_to_read) {
+		u8 *byte_buf = ctrl->xfer.xfer->rx_buf;
+
+		rd_fifo = readl_relaxed(ctrl->base + RD_FIFOk);
+		ctrl->xfer.rem_bytes -= bytes_to_read;
+		for (i = 0; i < bytes_to_read; i++)
+			*byte_buf++ = (rd_fifo >> (i * BITS_PER_BYTE));
+		ctrl->xfer.xfer->rx_buf = byte_buf;
+
+	}
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t pio_write(struct qcom_qspi *ctrl)
+{
+	const int *word_buf;
+	const char *byte_buf;
+	const void *xfer_buf;
+	u32 wr_fifo_bytes;
+	int wr_size;
+
+	if (!ctrl)
+		return IRQ_NONE;
+	wr_fifo_bytes =
+	readl_relaxed(ctrl->base + PIO_XFER_STATUS) >> WR_FIFO_BYTES_SHFT;
+
+	xfer_buf = ctrl->xfer.tx_buf;
+
+	if (!wr_fifo_bytes || !xfer_buf) {
+		dev_err(ctrl->dev, "%s wr %d xfer_buf %p", __func__,
+						wr_fifo_bytes, xfer_buf);
+		return IRQ_NONE;
+
+	}
+	if (ctrl->xfer.rem_bytes < QSPI_BYTES_PER_WORD) {
+		byte_buf = xfer_buf;
+		wr_size = min(wr_fifo_bytes, ctrl->xfer.rem_bytes);
+		ctrl->xfer.rem_bytes -= wr_size;
+		while (wr_size--)
+			writel_relaxed(*byte_buf++,
+				(ctrl->base + PIO_DATAOUT_1B));
+		ctrl->xfer.tx_buf = byte_buf;
+	} else {
+		int rem_words =
+		ctrl->xfer.rem_bytes / QSPI_BYTES_PER_WORD;
+		int wr_fifo_words = wr_fifo_bytes / QSPI_BYTES_PER_WORD;
+
+		wr_size = min(rem_words, wr_fifo_words);
+		ctrl->xfer.rem_bytes -=
+				(wr_size * QSPI_BYTES_PER_WORD);
+		word_buf = xfer_buf;
+
+		while (wr_size--)
+			writel_relaxed(*word_buf++,
+				(ctrl->base + PIO_DATAOUT_4B));
+		ctrl->xfer.tx_buf = word_buf;
+
+	}
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t qcom_qspi_irq(int irq, void *dev_id)
+{
+	u32 int_status;
+	struct qcom_qspi *ctrl = dev_id;
+	irqreturn_t ret = IRQ_HANDLED;
+
+	int_status = readl_relaxed(ctrl->base + MSTR_INT_STATUS);
+	writel_relaxed(int_status, ctrl->base + MSTR_INT_STATUS);
+
+	if (int_status & WR_FIFO_EMPTY)
+		ret = pio_write(ctrl);
+
+	if (int_status & RESP_FIFO_RDY)
+		ret = pio_read(ctrl);
+
+	if (!ctrl->xfer.rem_bytes)
+		complete(&ctrl->transfer_complete);
+
+	return ret;
+}
+
+static bool qcom_qspi_supports_op(struct spi_mem *mem,
+				const struct spi_mem_op *op)
+{
+	return true;
+}
+
+static int qcom_qspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
+{
+	return 0;
+}
+
+static const struct spi_controller_mem_ops qcom_qspi_mem_ops = {
+	.exec_op = qcom_qspi_exec_mem_op,
+	.supports_op = qcom_qspi_supports_op,
+	.adjust_op_size = qcom_qspi_adjust_op_size,
+};
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
+		dev_err(dev, "%s: Failed to alloc spi master", __func__);
+		return -ENOMEM;
+	}
+
+	ctrl = spi_master_get_devdata(master);
+
+	ctrl->dev = dev;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ctrl->base = devm_ioremap(dev, res->start, resource_size(res));
+	if (IS_ERR(ctrl->base)) {
+		ret = PTR_ERR(ctrl->base);
+		dev_err(dev, "%s: Failed to get base addr %d", __func__, ret);
+		goto exit_probe_master_put;
+	}
+
+	ctrl->irq = platform_get_irq(pdev, 0);
+	if (ctrl->irq < 0) {
+		ret = PTR_ERR(ctrl->base);
+		dev_err(dev, "%s: Failed to get irq %d", __func__, ret);
+		goto exit_probe_master_put;
+	}
+
+	ret = devm_request_irq(dev, ctrl->irq, qcom_qspi_irq,
+			IRQF_TRIGGER_HIGH, dev_name(dev), ctrl);
+	if (ret) {
+		dev_err(dev, "%s: Failed to request irq %d", __func__, ret);
+		goto exit_probe_master_put;
+	}
+
+	ctrl->core_clk = devm_clk_get(dev, "core");
+	if (IS_ERR(ctrl->core_clk)) {
+		ret = PTR_ERR(ctrl->core_clk);
+		dev_err(dev, "%s: Failed to get core clk %d", __func__, ret);
+		goto exit_probe_master_put;
+	}
+
+	ctrl->iface_clk = devm_clk_get(dev, "iface");
+	if (IS_ERR(ctrl->iface_clk)) {
+		ret = PTR_ERR(ctrl->iface_clk);
+		dev_err(dev, "%s: Failed to get iface clk %d", __func__, ret);
+		goto exit_probe_master_put;
+	}
+
+	master->max_speed_hz = 300000000;
+	master->num_chipselect = QSPI_NUM_CS;
+	master->bus_num = pdev->id;
+	master->dev.of_node = pdev->dev.of_node;
+	master->mode_bits = SPI_MODE_0|SPI_MODE_3|SPI_TX_QUAD|SPI_RX_QUAD;
+	master->auto_runtime_pm = true;
+	master->setup = qcom_qspi_setup;
+	master->mem_ops = &qcom_qspi_mem_ops;
+
+	pm_runtime_enable(dev);
+	init_completion(&ctrl->transfer_complete);
+	platform_set_drvdata(pdev, master);
+	ret = devm_spi_register_master(dev, master);
+	if (!ret)
+		return 0;
+	pm_runtime_disable(&pdev->dev);
+exit_probe_master_put:
+	spi_master_put(master);
+	return ret;
+}
+
+static int qcom_qspi_remove(struct platform_device *pdev)
+{
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct qcom_qspi *qspi = spi_master_get_devdata(master);
+
+	spi_unregister_master(master);
+	qcom_qspi_unset_clks(qspi);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	return 0;
+}
+
+static int qcom_qspi_resume_runtime(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct spi_master *mas = platform_get_drvdata(pdev);
+	struct qcom_qspi *ctrl;
+	int ret;
+
+	ctrl = spi_master_get_devdata(mas);
+	ret = qcom_qspi_set_clks(ctrl, mas->max_speed_hz);
+	if (ret)
+		dev_err(dev, "%s: Err failed to set clks %d", __func__, ret);
+	return ret;
+}
+
+static int qcom_qspi_suspend_runtime(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct spi_master *mas = platform_get_drvdata(pdev);
+	struct qcom_qspi *ctrl;
+
+	ctrl = spi_master_get_devdata(mas);
+	qcom_qspi_unset_clks(ctrl);
+	return 0;
+}
+
+static int qcom_qspi_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct spi_master *mas = platform_get_drvdata(pdev);
+
+	return spi_master_resume(mas);
+}
+
+static int qcom_qspi_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct spi_master *mas = platform_get_drvdata(pdev);
+	int ret;
+
+	if (pm_runtime_enabled(dev))
+		return -EBUSY;
+
+	ret = spi_master_suspend(mas);
+	if (ret)
+		return ret;
+	return 0;
+}
+
+static const struct dev_pm_ops qcom_qspi_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(qcom_qspi_suspend, qcom_qspi_resume)
+	SET_RUNTIME_PM_OPS(qcom_qspi_suspend_runtime,
+			   qcom_qspi_resume_runtime,
+			   NULL)
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
+		.owner		= THIS_MODULE,
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
1.9.1

