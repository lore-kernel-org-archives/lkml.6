Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BFCECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6CD2150B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FooPXWEX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HxTLT+dh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6CD2150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbeIRXmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 19:42:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:32780 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729689AbeIRXmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 19:42:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 544A9607F7; Tue, 18 Sep 2018 18:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537294141;
        bh=fHU5juQlEv/OUgPO4TKJTEtUtC7EWk0R//EIBe+Dxe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FooPXWEXKtlerEQ2h296lSp5gMUOmHjEMmxyb+2uq1rbC5WeZmi6JxM8VwCFUs/jW
         Z8wGUxVSGFHT9y7iYvJ8m1YE86GOnO+Et38mZqhVAsSd13grLW8jtQo6ie7cwuhsn5
         JKl8q7I7vhaCxpRVYyz7auc6MurTL5bWxwLbO0AI=
Received: from dkota-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dkota@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 53F98607DD;
        Tue, 18 Sep 2018 18:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537294138;
        bh=fHU5juQlEv/OUgPO4TKJTEtUtC7EWk0R//EIBe+Dxe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HxTLT+dhC2Adudt1DYeTEamxPgBKuCb3+rbrsfOrJ2xi/7IjpeKrPI5LNI+XzqAWJ
         g9iO2n6On2zNHlpDeuTx8QUTcUlNqs9HXLylp2gOcE1P6bWsgoQdWCSgffoYglIV1X
         W8DB4NaNILe9r5/lcYM4XGNeAdEvYz3zKghqYYr0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 53F98607DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=dkota@codeaurora.org
From:   Dilip Kota <dkota@codeaurora.org>
To:     swboyd@chromium.org, dianders@chromium.org, broonie@kernel.org,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>
Subject: [PATCH V4 3/4] spi: spi-geni-qcom: Add SPI driver support for GENI based QUP
Date:   Tue, 18 Sep 2018 23:37:25 +0530
Message-Id: <1537294047-12093-4-git-send-email-dkota@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537294047-12093-1-git-send-email-dkota@codeaurora.org>
References: <1537294047-12093-1-git-send-email-dkota@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Girish Mahadevan <girishm@codeaurora.org>

This driver supports GENI based SPI Controller in the Qualcomm SOCs. The
Qualcomm Generic Interface (GENI) is a programmable module supporting a
wide range of serial interfaces including SPI. This driver supports SPI
operations using FIFO mode of transfer.

Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
Signed-off-by: Dilip Kota <dkota@codeaurora.org>
---
Addressing all the reviewer commets given in Patchset1.
Summerizing the chages below:

	Move prepare_transfer_hardware to probe
	Fix the unbind failure
	Add Spinlock
	Use readl/writel() instead of _relaxed()
	Remove __func__ in dev_err
	Declare register variables as u32
	Don't initialize variables and then overwrite them
	Remove unused step
	Remove IRQ entry in geni struct
	Remove extra paranthesis
	Reframe probe errors
	Change the tx_fifo_width naming in handle_rx and handle_tx
	Declare spi_geni_master as 'mas' in complete driver.
	Correcting the punctuation in the comments.
	Adding comments in the code while setting Tx WaterMark Register.
	get_spi_clk_cfg() fixes
	Rewrite the geni_spi_handle_tx() and geni_spi_handle_rx()

Regarding the suspend/resume and loopback failures, i am working to update in next patch series
drivers/spi/Kconfig               |  12 +
 drivers/spi/Makefile              |   1 +
 drivers/spi/spi-geni-qcom.c       | 653 ++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi-geni-qcom.h |  14 +
 4 files changed, 680 insertions(+)
 create mode 100644 drivers/spi/spi-geni-qcom.c
 create mode 100644 include/linux/spi/spi-geni-qcom.h

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ad5d68e..8934df8 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -533,6 +533,18 @@ config SPI_QUP
 	  This driver can also be built as a module.  If so, the module
 	  will be called spi_qup.
 
+config SPI_QCOM_GENI
+	tristate "Qualcomm GENI based SPI controller"
+	depends on QCOM_GENI_SE
+	help
+	  This driver supports GENI serial engine based SPI controller in
+	  master mode on the Qualcomm Technologies Inc.'s SoCs. If you say
+	  yes to this option, support will be included for the built-in SPI
+	  interface on the Qualcomm Technologies Inc.'s SoCs.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called spi-geni-qcom.
+
 config SPI_S3C24XX
 	tristate "Samsung S3C24XX series SPI"
 	depends on ARCH_S3C24XX
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index cb1f437..98337cf 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -74,6 +74,7 @@ obj-$(CONFIG_SPI_PPC4xx)		+= spi-ppc4xx.o
 spi-pxa2xx-platform-objs		:= spi-pxa2xx.o spi-pxa2xx-dma.o
 obj-$(CONFIG_SPI_PXA2XX)		+= spi-pxa2xx-platform.o
 obj-$(CONFIG_SPI_PXA2XX_PCI)		+= spi-pxa2xx-pci.o
+obj-$(CONFIG_SPI_QCOM_GENI)		+= spi-geni-qcom.o
 obj-$(CONFIG_SPI_QUP)			+= spi-qup.o
 obj-$(CONFIG_SPI_ROCKCHIP)		+= spi-rockchip.o
 obj-$(CONFIG_SPI_RB4XX)			+= spi-rb4xx.o
diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
new file mode 100644
index 0000000..949b853
--- /dev/null
+++ b/drivers/spi/spi-geni-qcom.c
@@ -0,0 +1,653 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
+
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/log2.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/qcom-geni-se.h>
+#include <linux/spi/spi.h>
+#include <linux/spinlock.h>
+
+/* SPI SE specific registers and respective register fields */
+#define SE_SPI_CPHA		0x224
+#define CPHA			BIT(0)
+
+#define SE_SPI_LOOPBACK		0x22c
+#define LOOPBACK_ENABLE		0x1
+#define NORMAL_MODE		0x0
+#define LOOPBACK_MSK		GENMASK(1, 0)
+
+#define SE_SPI_CPOL		0x230
+#define CPOL			BIT(2)
+
+#define SE_SPI_DEMUX_OUTPUT_INV	0x24c
+#define CS_DEMUX_OUTPUT_INV_MSK	GENMASK(3, 0)
+
+#define SE_SPI_DEMUX_SEL	0x250
+#define CS_DEMUX_OUTPUT_SEL	GENMASK(3, 0)
+
+#define SE_SPI_TRANS_CFG	0x25c
+#define CS_TOGGLE		BIT(0)
+
+#define SE_SPI_WORD_LEN		0x268
+#define WORD_LEN_MSK		GENMASK(9, 0)
+#define MIN_WORD_LEN		4
+
+#define SE_SPI_TX_TRANS_LEN	0x26c
+#define SE_SPI_RX_TRANS_LEN	0x270
+#define TRANS_LEN_MSK		GENMASK(23, 0)
+
+#define SE_SPI_PRE_POST_CMD_DLY	0x274
+
+#define SE_SPI_DELAY_COUNTERS	0x278
+#define SPI_INTER_WORDS_DELAY_MSK	GENMASK(9, 0)
+#define SPI_CS_CLK_DELAY_MSK		GENMASK(19, 10)
+#define SPI_CS_CLK_DELAY_SHFT		10
+
+/* M_CMD OP codes for SPI */
+#define SPI_TX_ONLY		1
+#define SPI_RX_ONLY		2
+#define SPI_FULL_DUPLEX		3
+#define SPI_TX_RX		7
+#define SPI_CS_ASSERT		8
+#define SPI_CS_DEASSERT		9
+#define SPI_SCK_ONLY		10
+/* M_CMD params for SPI */
+#define SPI_PRE_CMD_DELAY	BIT(0)
+#define TIMESTAMP_BEFORE	BIT(1)
+#define FRAGMENTATION		BIT(2)
+#define TIMESTAMP_AFTER		BIT(3)
+#define POST_CMD_DELAY		BIT(4)
+
+static irqreturn_t geni_spi_isr(int irq, void *data);
+
+struct spi_geni_master {
+	struct geni_se se;
+	struct device *dev;
+	u32 rx_fifo_depth;
+	u32 tx_fifo_depth;
+	u32 fifo_width_bits;
+	u32 tx_wm;
+	unsigned int cur_speed_hz;
+	unsigned int cur_bits_per_word;
+	unsigned int tx_rem_bytes;
+	unsigned int rx_rem_bytes;
+	struct spi_transfer *cur_xfer;
+	struct completion xfer_done;
+	unsigned int oversampling;
+	spinlock_t lock;
+};
+
+static int get_spi_clk_cfg(unsigned int speed_hz,
+			struct spi_geni_master *mas,
+			unsigned int *clk_idx,
+			unsigned int *clk_div)
+{
+	unsigned long sclk_freq;
+	unsigned int actual_hz;
+	struct geni_se *se = &mas->se;
+	int ret;
+
+	ret = geni_se_clk_freq_match(&mas->se,
+				speed_hz * mas->oversampling,
+				clk_idx, &sclk_freq, false);
+	if (ret) {
+		dev_err(mas->dev, "Failed(%d) to find src clk for %dHz\n",
+							ret, speed_hz);
+		return ret;
+	}
+
+	*clk_div = DIV_ROUND_UP(sclk_freq, mas->oversampling * speed_hz);
+	actual_hz = sclk_freq / (mas->oversampling * *clk_div);
+
+	dev_dbg(mas->dev, "req %u=>%u sclk %lu, idx %d, div %d\n", speed_hz,
+				actual_hz, sclk_freq, *clk_idx, *clk_div);
+	ret = clk_set_rate(se->clk, sclk_freq);
+	if (ret)
+		dev_err(mas->dev, "clk_set_rate failed %d\n", ret);
+	return ret;
+}
+
+static void spi_setup_word_len(struct spi_geni_master *mas, u16 mode,
+					unsigned int bits_per_word)
+{
+	unsigned int pack_words;
+	bool msb_first = (mode & SPI_LSB_FIRST) ? false : true;
+	struct geni_se *se = &mas->se;
+	u32 word_len;
+
+	word_len = readl(se->base + SE_SPI_WORD_LEN);
+
+	/*
+	 * If bits_per_word isn't a byte aligned value, set the packing to be
+	 * 1 SPI word per FIFO word.
+	 */
+	if (!(mas->fifo_width_bits % bits_per_word))
+		pack_words = mas->fifo_width_bits / bits_per_word;
+	else
+		pack_words = 1;
+	word_len &= ~WORD_LEN_MSK;
+	word_len |= ((bits_per_word - MIN_WORD_LEN) & WORD_LEN_MSK);
+	geni_se_config_packing(&mas->se, bits_per_word, pack_words, msb_first,
+								true, true);
+	writel(word_len, se->base + SE_SPI_WORD_LEN);
+}
+
+static int setup_fifo_params(struct spi_device *spi_slv,
+					struct spi_master *spi)
+{
+	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+	struct geni_se *se = &mas->se;
+	u32 loopback_cfg, cpol, cpha, demux_output_inv;
+	u32 demux_sel, clk_sel, m_clk_cfg, idx, div;
+	int ret;
+
+	loopback_cfg = readl(se->base + SE_SPI_LOOPBACK);
+	cpol = readl(se->base + SE_SPI_CPOL);
+	cpha = readl(se->base + SE_SPI_CPHA);
+	demux_output_inv = 0;
+	loopback_cfg &= ~LOOPBACK_MSK;
+	cpol &= ~CPOL;
+	cpha &= ~CPHA;
+
+	if (spi_slv->mode & SPI_LOOP)
+		loopback_cfg |= LOOPBACK_ENABLE;
+
+	if (spi_slv->mode & SPI_CPOL)
+		cpol |= CPOL;
+
+	if (spi_slv->mode & SPI_CPHA)
+		cpha |= CPHA;
+
+	if (spi_slv->mode & SPI_CS_HIGH)
+		demux_output_inv = BIT(spi_slv->chip_select);
+
+	demux_sel = spi_slv->chip_select;
+	mas->cur_speed_hz = spi_slv->max_speed_hz;
+	mas->cur_bits_per_word = spi_slv->bits_per_word;
+
+	ret = get_spi_clk_cfg(mas->cur_speed_hz, mas, &idx, &div);
+	if (ret) {
+		dev_err(mas->dev, "Err setting clks ret(%d) for %d\n",
+							ret, mas->cur_speed_hz);
+		return ret;
+	}
+
+	clk_sel = idx & CLK_SEL_MSK;
+	m_clk_cfg = (div << CLK_DIV_SHFT) | SER_CLK_EN;
+	spi_setup_word_len(mas, spi_slv->mode, spi_slv->bits_per_word);
+	writel(loopback_cfg, se->base + SE_SPI_LOOPBACK);
+	writel(demux_sel, se->base + SE_SPI_DEMUX_SEL);
+	writel(cpha, se->base + SE_SPI_CPHA);
+	writel(cpol, se->base + SE_SPI_CPOL);
+	writel(demux_output_inv, se->base + SE_SPI_DEMUX_OUTPUT_INV);
+	writel(clk_sel, se->base + SE_GENI_CLK_SEL);
+	writel(m_clk_cfg, se->base + GENI_SER_M_CLK_CFG);
+	return 0;
+}
+
+static int spi_geni_prepare_message(struct spi_master *spi,
+					struct spi_message *spi_msg)
+{
+	int ret;
+	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+	struct geni_se *se = &mas->se;
+
+	geni_se_select_mode(se, GENI_SE_FIFO);
+	reinit_completion(&mas->xfer_done);
+	ret = setup_fifo_params(spi_msg->spi, spi);
+	if (ret)
+		dev_err(mas->dev, "Couldn't select mode %d", ret);
+	return ret;
+}
+
+static int spi_geni_init(struct spi_geni_master *mas)
+{
+	struct geni_se *se = &mas->se;
+	unsigned int proto, major, minor, ver;
+
+	pm_runtime_get_sync(mas->dev);
+
+	proto = geni_se_read_proto(se);
+	if (proto != GENI_SE_SPI) {
+		dev_err(mas->dev, "Invalid proto %d\n", proto);
+		pm_runtime_put(mas->dev);
+		return -ENXIO;
+	}
+	mas->tx_fifo_depth = geni_se_get_tx_fifo_depth(se);
+	mas->rx_fifo_depth = geni_se_get_rx_fifo_depth(se);
+
+	/* Width of Tx and Rx FIFO is same */
+	mas->fifo_width_bits = geni_se_get_tx_fifo_width(se);
+
+	/*
+	 * Hardware programming guide suggests to configure
+	 * RX FIFO RFR level to fifo_depth-2.
+	 */
+	geni_se_init(se, 0x0, mas->tx_fifo_depth - 2);
+	/* Transmit an entire FIFO worth of data per IRQ */
+	mas->tx_wm = 1;
+	ver = geni_se_get_qup_hw_version(se);
+	major = GENI_SE_VERSION_MAJOR(ver);
+	minor = GENI_SE_VERSION_MINOR(ver);
+
+	if (major == 1 && minor == 0)
+		mas->oversampling = 2;
+	else
+		mas->oversampling = 1;
+
+	pm_runtime_put(mas->dev);
+	return 0;
+}
+
+static void setup_fifo_xfer(struct spi_transfer *xfer,
+				struct spi_geni_master *mas,
+				u16 mode, struct spi_master *spi)
+{
+	u32 m_cmd = 0, m_param = 0;
+	u32 spi_tx_cfg, trans_len;
+	struct geni_se *se = &mas->se;
+
+	spi_tx_cfg = readl(se->base + SE_SPI_TRANS_CFG);
+	if (xfer->bits_per_word != mas->cur_bits_per_word) {
+		spi_setup_word_len(mas, mode, xfer->bits_per_word);
+		mas->cur_bits_per_word = xfer->bits_per_word;
+	}
+
+	/* Speed and bits per word can be overridden per transfer */
+	if (xfer->speed_hz != mas->cur_speed_hz) {
+		int ret;
+		u32 clk_sel, m_clk_cfg;
+		unsigned int idx, div;
+
+		ret = get_spi_clk_cfg(xfer->speed_hz, mas, &idx, &div);
+		if (ret) {
+			dev_err(mas->dev, "Err setting clks:%d\n", ret);
+			return;
+		}
+		/*
+		 * SPI core clock gets configured with the requested frequency
+		 * or the frequency closer to the requested frequency.
+		 * For that reason requested frequency is stored in the
+		 * cur_speed_hz and referred in the consicutive transfer instead
+		 * of calling clk_get_rate() API.
+		 */
+		mas->cur_speed_hz = xfer->speed_hz;
+		clk_sel = idx & CLK_SEL_MSK;
+		m_clk_cfg = (div << CLK_DIV_SHFT) | SER_CLK_EN;
+		writel(clk_sel, se->base + SE_GENI_CLK_SEL);
+		writel(m_clk_cfg, se->base + GENI_SER_M_CLK_CFG);
+	}
+
+	mas->tx_rem_bytes = 0;
+	mas->rx_rem_bytes = 0;
+	if (xfer->tx_buf && xfer->rx_buf)
+		m_cmd = SPI_FULL_DUPLEX;
+	else if (xfer->tx_buf)
+		m_cmd = SPI_TX_ONLY;
+	else if (xfer->rx_buf)
+		m_cmd = SPI_RX_ONLY;
+
+	spi_tx_cfg &= ~CS_TOGGLE;
+	if (!(mas->cur_bits_per_word % MIN_WORD_LEN)) {
+		trans_len =
+			(xfer->len * BITS_PER_BYTE /
+					mas->cur_bits_per_word) & TRANS_LEN_MSK;
+	} else {
+		unsigned int bytes_per_word =
+			mas->cur_bits_per_word / BITS_PER_BYTE + 1;
+
+		trans_len = (xfer->len / bytes_per_word) & TRANS_LEN_MSK;
+	}
+
+	/*
+	 * If CS change flag is set, then toggle the CS line in between
+	 * transfers and keep CS asserted after the last transfer.
+	 * Else if keep CS flag asserted in between transfers and de-assert
+	 * CS after the last message.
+	 */
+	if (xfer->cs_change) {
+		if (list_is_last(&xfer->transfer_list,
+				&spi->cur_msg->transfers))
+			m_param = FRAGMENTATION;
+	} else {
+		if (!list_is_last(&xfer->transfer_list,
+				&spi->cur_msg->transfers))
+			m_param = FRAGMENTATION;
+	}
+
+	mas->cur_xfer = xfer;
+	if (m_cmd & SPI_TX_ONLY) {
+		mas->tx_rem_bytes = xfer->len;
+		writel(trans_len, se->base + SE_SPI_TX_TRANS_LEN);
+	}
+
+	if (m_cmd & SPI_RX_ONLY) {
+		writel(trans_len, se->base + SE_SPI_RX_TRANS_LEN);
+		mas->rx_rem_bytes = xfer->len;
+	}
+	writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
+	geni_se_setup_m_cmd(se, m_cmd, m_param);
+
+	/*
+	 * TX_WATERMARK_REG should be set after SPI configuration and
+	 * setting up GENI SE engine, as driver starts data transfer
+	 * for the watermark interrupt.
+	 */
+	if (m_cmd & SPI_TX_ONLY)
+		writel(mas->tx_wm, se->base + SE_GENI_TX_WATERMARK_REG);
+}
+
+static void handle_fifo_timeout(struct spi_master *spi,
+				struct spi_message *msg)
+{
+	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+	unsigned long timeout, flags;
+	struct geni_se *se = &mas->se;
+
+	spin_lock_irqsave(&mas->lock, flags);
+	reinit_completion(&mas->xfer_done);
+	geni_se_cancel_m_cmd(se);
+	writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
+	spin_unlock_irqrestore(&mas->lock, flags);
+	timeout = wait_for_completion_timeout(&mas->xfer_done, HZ);
+	if (!timeout) {
+		spin_lock_irqsave(&mas->lock, flags);
+		reinit_completion(&mas->xfer_done);
+		geni_se_abort_m_cmd(se);
+		spin_unlock_irqrestore(&mas->lock, flags);
+		timeout = wait_for_completion_timeout(&mas->xfer_done,
+								HZ);
+		if (!timeout)
+			dev_err(mas->dev,
+				"Failed to cancel/abort m_cmd\n");
+	}
+}
+
+static int spi_geni_transfer_one(struct spi_master *spi,
+				struct spi_device *slv,
+				struct spi_transfer *xfer)
+{
+	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+
+	setup_fifo_xfer(xfer, mas, slv->mode, spi);
+	return 1;
+}
+
+static unsigned int geni_byte_per_fifo_word(struct spi_geni_master *mas)
+{
+	/*
+	 * Calculate how many bytes we'll put in each FIFO word.  If the
+	 * transfer words don't pack cleanly into a FIFO word we'll just put
+	 * one transfer word in each FIFO word.  If they do pack we'll pack 'em.
+	 */
+	if (mas->fifo_width_bits % mas->cur_bits_per_word)
+		return roundup_pow_of_two(DIV_ROUND_UP(mas->cur_bits_per_word,
+						       BITS_PER_BYTE));
+	else
+		return mas->fifo_width_bits / BITS_PER_BYTE;
+}
+
+static irqreturn_t geni_spi_handle_tx(struct spi_geni_master *mas)
+{
+	struct geni_se *se = &mas->se;
+	unsigned int max_bytes;
+	const u8 *tx_buf;
+	unsigned int bytes_per_fifo_word = geni_byte_per_fifo_word(mas);
+	unsigned int i = 0;
+
+	if (!mas->cur_xfer)
+		return IRQ_NONE;
+
+	max_bytes = (mas->tx_fifo_depth - mas->tx_wm) * bytes_per_fifo_word;
+	if (mas->tx_rem_bytes < max_bytes)
+		max_bytes = mas->tx_rem_bytes;
+
+	tx_buf = mas->cur_xfer->tx_buf + mas->cur_xfer->len - mas->tx_rem_bytes;
+	while (i < max_bytes) {
+		unsigned int j;
+		unsigned int bytes_to_write;
+		u32 fifo_word = 0;
+		u8 *fifo_byte = (u8 *)&fifo_word;
+
+		bytes_to_write = min(bytes_per_fifo_word, max_bytes - i);
+		for (j = 0; j < bytes_to_write; j++)
+			fifo_byte[j] = tx_buf[i++];
+		iowrite32_rep(se->base + SE_GENI_TX_FIFOn, &fifo_word, 1);
+	}
+	mas->tx_rem_bytes -= max_bytes;
+	if (!mas->tx_rem_bytes)
+		writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t geni_spi_handle_rx(struct spi_geni_master *mas)
+{
+	struct geni_se *se = &mas->se;
+	u32 rx_fifo_status;
+	unsigned int rx_bytes;
+	u8 *rx_buf;
+	unsigned int bytes_per_fifo_word = geni_byte_per_fifo_word(mas);
+	unsigned int i = 0;
+
+	if (!mas->cur_xfer)
+		return IRQ_NONE;
+
+	rx_fifo_status = readl(se->base + SE_GENI_RX_FIFO_STATUS);
+	rx_bytes = (rx_fifo_status & RX_FIFO_WC_MSK) * bytes_per_fifo_word;
+	if (rx_fifo_status & RX_LAST) {
+		unsigned int rx_last_byte_valid =
+			(rx_fifo_status & RX_LAST_BYTE_VALID_MSK)
+				>> RX_LAST_BYTE_VALID_SHFT;
+		if (rx_last_byte_valid && (rx_last_byte_valid < 4))
+			rx_bytes -= bytes_per_fifo_word - rx_last_byte_valid;
+	}
+	if (mas->rx_rem_bytes < rx_bytes)
+		rx_bytes = mas->rx_rem_bytes;
+
+	rx_buf = mas->cur_xfer->rx_buf + mas->cur_xfer->len - mas->rx_rem_bytes;
+	while (i < rx_bytes) {
+		u32 fifo_word = 0;
+		u8 *fifo_byte = (u8 *)&fifo_word;
+		unsigned int bytes_to_read;
+		unsigned int j;
+
+		bytes_to_read = min(bytes_per_fifo_word, rx_bytes - i);
+		ioread32_rep(se->base + SE_GENI_RX_FIFOn, &fifo_word, 1);
+		for (j = 0; j < bytes_to_read; j++)
+			rx_buf[i++] = fifo_byte[j];
+	}
+	mas->rx_rem_bytes -= rx_bytes;
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t geni_spi_isr(int irq, void *data)
+{
+	struct spi_master *spi = data;
+	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+	struct geni_se *se = &mas->se;
+	u32 m_irq;
+	unsigned long flags;
+	irqreturn_t ret = IRQ_HANDLED;
+
+	if (pm_runtime_status_suspended(mas->dev))
+		return IRQ_NONE;
+
+	spin_lock_irqsave(&mas->lock, flags);
+	m_irq = readl(se->base + SE_GENI_M_IRQ_STATUS);
+	if ((m_irq & M_RX_FIFO_WATERMARK_EN) || (m_irq & M_RX_FIFO_LAST_EN))
+		ret = geni_spi_handle_rx(mas);
+
+	if (m_irq & M_TX_FIFO_WATERMARK_EN)
+		ret = geni_spi_handle_tx(mas);
+
+	if (m_irq & M_CMD_DONE_EN) {
+		spi_finalize_current_transfer(spi);
+		/*
+		 * If this happens, then a CMD_DONE came before all the Tx
+		 * buffer bytes were sent out. This is unusual, log this
+		 * condition and disable the WM interrupt to prevent the
+		 * system from stalling due an interrupt storm.
+		 * If this happens when all Rx bytes haven't been received, log
+		 * the condition.
+		 * The only known time this can happen is if bits_per_word != 8
+		 * and some registers that expect xfer lengths in num spi_words
+		 * weren't written correctly.
+		 */
+		if (mas->tx_rem_bytes) {
+			writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
+			dev_err(mas->dev, "Premature Done.tx_rem%d bpw%d\n",
+				mas->tx_rem_bytes, mas->cur_bits_per_word);
+		}
+		if (mas->rx_rem_bytes)
+			dev_err(mas->dev, "Premature Done.rx_rem%d bpw%d\n",
+				mas->rx_rem_bytes, mas->cur_bits_per_word);
+	}
+
+	if ((m_irq & M_CMD_CANCEL_EN) || (m_irq & M_CMD_ABORT_EN))
+		complete(&mas->xfer_done);
+
+	writel(m_irq, se->base + SE_GENI_M_IRQ_CLEAR);
+	spin_unlock_irqrestore(&mas->lock, flags);
+	return ret;
+}
+
+static int spi_geni_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct spi_master *spi;
+	struct spi_geni_master *mas;
+	struct resource *res;
+	struct geni_se *se;
+
+	spi = spi_alloc_master(&pdev->dev, sizeof(struct spi_geni_master));
+	if (!spi)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, spi);
+	mas = spi_master_get_devdata(spi);
+	mas->dev = &pdev->dev;
+	mas->se.dev = &pdev->dev;
+	mas->se.wrapper = dev_get_drvdata(pdev->dev.parent);
+	se = &mas->se;
+
+	spi->bus_num = -1;
+	spi->dev.of_node = pdev->dev.of_node;
+	mas->se.clk = devm_clk_get(&pdev->dev, "se");
+	if (IS_ERR(mas->se.clk)) {
+		ret = PTR_ERR(mas->se.clk);
+		dev_err(&pdev->dev, "Err getting SE Core clk %d\n", ret);
+		goto spi_geni_probe_err;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	se->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(se->base)) {
+		ret = -ENOMEM;
+		goto spi_geni_probe_err;
+	}
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Err getting IRQ %d\n", ret);
+		goto spi_geni_probe_err;
+	}
+	ret = devm_request_irq(&pdev->dev, ret, geni_spi_isr,
+				IRQF_TRIGGER_HIGH, "spi_geni", spi);
+	if (ret)
+		goto spi_geni_probe_err;
+
+	spi->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP | SPI_CS_HIGH;
+	spi->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
+	spi->num_chipselect = 4;
+	spi->max_speed_hz = 50000000;
+	spi->prepare_message = spi_geni_prepare_message;
+	spi->transfer_one = spi_geni_transfer_one;
+	spi->auto_runtime_pm = true;
+	spi->handle_err = handle_fifo_timeout;
+
+	init_completion(&mas->xfer_done);
+	spin_lock_init(&mas->lock);
+	pm_runtime_enable(&pdev->dev);
+
+	ret = spi_geni_init(mas);
+	if (ret)
+		goto spi_geni_probe_runtime_disable;
+
+	ret = spi_register_master(spi);
+	if (ret)
+		goto spi_geni_probe_runtime_disable;
+
+	return 0;
+spi_geni_probe_runtime_disable:
+	pm_runtime_disable(&pdev->dev);
+spi_geni_probe_err:
+	spi_master_put(spi);
+	return ret;
+}
+
+static int spi_geni_remove(struct platform_device *pdev)
+{
+	struct spi_master *spi = platform_get_drvdata(pdev);
+
+	/* Unregister _before_ disabling pm_runtime() so we stop transfers */
+	spi_unregister_master(spi);
+
+	pm_runtime_disable(&pdev->dev);
+	return 0;
+}
+
+static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
+{
+	struct spi_master *spi = dev_get_drvdata(dev);
+	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+
+	return geni_se_resources_off(&mas->se);
+}
+
+static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
+{
+	struct spi_master *spi = dev_get_drvdata(dev);
+	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+
+	return geni_se_resources_on(&mas->se);
+}
+
+static int __maybe_unused spi_geni_suspend(struct device *dev)
+{
+	if (!pm_runtime_status_suspended(dev))
+		return -EBUSY;
+	return 0;
+}
+
+static const struct dev_pm_ops spi_geni_pm_ops = {
+	SET_RUNTIME_PM_OPS(spi_geni_runtime_suspend,
+					spi_geni_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(spi_geni_suspend, NULL)
+};
+
+static const struct of_device_id spi_geni_dt_match[] = {
+	{ .compatible = "qcom,geni-spi" },
+	{}
+};
+
+static struct platform_driver spi_geni_driver = {
+	.probe  = spi_geni_probe,
+	.remove = spi_geni_remove,
+	.driver = {
+		.name = "geni_spi",
+		.pm = &spi_geni_pm_ops,
+		.of_match_table = spi_geni_dt_match,
+	},
+};
+module_platform_driver(spi_geni_driver);
+
+MODULE_DESCRIPTION("SPI driver for GENI based QUP cores");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/spi/spi-geni-qcom.h b/include/linux/spi/spi-geni-qcom.h
new file mode 100644
index 0000000..dc95764
--- /dev/null
+++ b/include/linux/spi/spi-geni-qcom.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __SPI_GENI_QCOM_HEADER___
+#define __SPI_GENI_QCOM_HEADER___
+
+struct spi_geni_qcom_ctrl_data {
+	u32 spi_cs_clk_delay;
+	u32 spi_inter_words_delay;
+};
+
+#endif /*__SPI_GENI_QCOM_HEADER___*/
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

