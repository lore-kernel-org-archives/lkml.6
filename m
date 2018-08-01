Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAB0C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FA220844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NH8vVJfM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N/mW42/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01FA220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733200AbeHAHXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 03:23:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51656 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733119AbeHAHXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 03:23:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A67E860B1A; Wed,  1 Aug 2018 05:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533101965;
        bh=TF5dndT3PY1fHw5x8wi/U2i0zqh+QGTF+PcvAjkzrzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NH8vVJfMIRYgQyeKHspHmLZ9h2Gb1Hhxt/QmNk3jjE1TkC16M8rdPN7v3xefcB1lS
         Lt+fZBwDew78PS+7A4ngRlhRLpIKsQ0TNwdlhnkYcjA9t1uN3T5+ymp0JPRJPqu/ua
         5JK56nfCgAfXcW+o9vVS19gZNb6YiFca2HD0dnuU=
Received: from corebsp04-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mshettel@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D781A60AFF;
        Wed,  1 Aug 2018 05:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533101961;
        bh=TF5dndT3PY1fHw5x8wi/U2i0zqh+QGTF+PcvAjkzrzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N/mW42/64Vf+1BGbAkBdm0oZW5T0Wmt915B2NQPYVNdCmlbaBwyO2/ou1VPaRzhi6
         l7nBcqOFhugo5RF2VCrB/zE9xLiIHE6I2KndheEie4Rk/RoJb7NgA+nh6zqHzpwTXq
         FuXFEfDGMupzNJMheVkmdR6lsC/jOLsXMABAJe6g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D781A60AFF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mshettel@codeaurora.org
From:   Mike Shettel <mshettel@codeaurora.org>
To:     gregkh@linuxfoundation.org, boris.brezillon@bootlin.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     Mike Shettel <mshettel@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        acourbot@chromium.org, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, bjorn.andersson@linaro.org
Subject: [PATCH v1 1/3] i3c: master: Add a driver for Qualcomm GENI I3C master IP
Date:   Tue, 31 Jul 2018 23:39:00 -0600
Message-Id: <1533101942-29442-2-git-send-email-mshettel@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533101942-29442-1-git-send-email-mshettel@codeaurora.org>
References: <1533101942-29442-1-git-send-email-mshettel@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mike Shettel <mshettel@codeaurora.org>
---
This patch is to be applied on top of the I3C subsystem patchset v6.
 drivers/i3c/master/Kconfig                |   13 +
 drivers/i3c/master/Makefile               |    1 +
 drivers/i3c/master/i3c-master-qcom-geni.c | 1243 +++++++++++++++++++++++++++++
 3 files changed, 1257 insertions(+)
 create mode 100644 drivers/i3c/master/i3c-master-qcom-geni.c

diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
index 56b9a18..18ca523 100644
--- a/drivers/i3c/master/Kconfig
+++ b/drivers/i3c/master/Kconfig
@@ -3,3 +3,16 @@ config CDNS_I3C_MASTER
 	depends on I3C
 	help
 	  Enable this driver if you want to support Cadence I3C master block.
+
+config I3C_MASTER_QCOM_GENI
+	tristate "Qualcomm Technologies Inc GENI based I3C master"
+	depends on ARCH_QCOM
+    depends on I3C
+	help
+	  If you say yes to this option, support will be included for the
+	  built-in I3C interface on the Qualcomm Technologies Inc SoCs.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i3c-master-qcom-geni
+
+
diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
index 4c4304a..5d084a9 100644
--- a/drivers/i3c/master/Makefile
+++ b/drivers/i3c/master/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_CDNS_I3C_MASTER)		+= i3c-master-cdns.o
+obj-$(CONFIG_I3C_MASTER_QCOM_GENI)	+= i3c-master-qcom-geni.o
diff --git a/drivers/i3c/master/i3c-master-qcom-geni.c b/drivers/i3c/master/i3c-master-qcom-geni.c
new file mode 100644
index 0000000..dfbc257
--- /dev/null
+++ b/drivers/i3c/master/i3c-master-qcom-geni.c
@@ -0,0 +1,1243 @@
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/i3c/master.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/pm_runtime.h>
+#include <linux/qcom-geni-se.h>
+
+#define SE_I3C_SCL_HIGH                 0x268
+#define SE_I3C_TX_TRANS_LEN             0x26C
+#define SE_I3C_RX_TRANS_LEN             0x270
+#define SE_I3C_DELAY_COUNTER            0x274
+#define SE_I2C_SCL_COUNTERS             0x278
+#define SE_I3C_SCL_CYCLE                0x27C
+#define SE_GENI_HW_IRQ_EN               0x920
+#define SE_GENI_HW_IRQ_IGNORE_ON_ACTIVE 0x924
+#define SE_GENI_HW_IRQ_CMD_PARAM_0      0x930
+
+/* SE_GENI_M_CLK_CFG field shifts */
+#define CLK_DEV_VALUE_SHFT 4
+#define SER_CLK_EN_SHFT 0
+
+/* SE_GENI_HW_IRQ_CMD_PARAM_0 field shifts */
+#define M_IBI_IRQ_PARAM_7E_SHFT 0
+#define M_IBI_IRQ_PARAM_STOP_STALL_SHFT 1
+
+/* SE_I2C_SCL_COUNTERS field shifts */
+#define I2C_SCL_HIGH_COUNTER_SHFT  20
+#define I2C_SCL_LOW_COUNTER_SHFT   10
+
+#define SE_I3C_ERR  (M_CMD_OVERRUN_EN | M_ILLEGAL_CMD_EN | M_CMD_FAILURE_EN |\
+	M_CMD_ABORT_EN | M_GP_IRQ_0_EN | M_GP_IRQ_1_EN | M_GP_IRQ_2_EN | \
+	M_GP_IRQ_3_EN | M_GP_IRQ_4_EN)
+
+/* M_CMD OP codes for I2C/I3C */
+#define I3C_READ_IBI_HW          0
+#define I2C_WRITE                1
+#define I2C_READ                 2
+#define I2C_WRITE_READ           3
+#define I2C_ADDR_ONLY            4
+#define I3C_INBAND_RESET         5
+#define I2C_BUS_CLEAR            6
+#define I2C_STOP_ON_BUS          7
+#define I3C_HDR_DDR_EXIT         8
+#define I3C_PRIVATE_WRITE        9
+#define I3C_PRIVATE_READ         10
+#define I3C_HDR_DDR_WRITE        11
+#define I3C_HDR_DDR_READ         12
+#define I3C_DIRECT_CCC_ADDR_ONLY 13
+#define I3C_BCAST_CCC_ADDR_ONLY  14
+#define I3C_READ_IBI             15
+#define I3C_BCAST_CCC_WRITE      16
+#define I3C_DIRECT_CCC_WRITE     17
+#define I3C_DIRECT_CCC_READ      18
+/* M_CMD params for I3C */
+#define PRE_CMD_DELAY          BIT(0)
+#define TIMESTAMP_BEFORE       BIT(1)
+#define STOP_STRETCH           BIT(2)
+#define TIMESTAMP_AFTER        BIT(3)
+#define POST_COMMAND_DELAY     BIT(4)
+#define IGNORE_ADD_NACK        BIT(6)
+#define READ_FINISHED_WITH_ACK BIT(7)
+#define CONTINUOUS_MODE_DAA    BIT(8)
+#define SLV_ADDR_MSK           GENMASK(15, 9)
+#define SLV_ADDR_SHFT          9
+#define CCC_HDR_CMD_MSK        GENMASK(23, 16)
+#define CCC_HDR_CMD_SHFT       16
+#define IBI_NACK_TBL_CTRL      BIT(24)
+#define USE_7E                 BIT(25)
+#define BYPASS_ADDR_PHASE      BIT(26)
+
+enum geni_i3c_err_code {
+	RD_TERM,
+	NACK,
+	CRC_ERR,
+	BUS_PROTO,
+	NACK_7E,
+	NACK_IBI,
+	GENI_OVERRUN,
+	GENI_ILLEGAL_CMD,
+	GENI_ABORT_DONE,
+	GENI_TIMEOUT,
+};
+
+#define DM_I3C_CB_ERR   ((BIT(NACK) | BIT(BUS_PROTO) | BIT(NACK_7E)) << 5)
+
+#define I3C_AUTO_SUSPEND_DELAY  250
+#define KHZ(freq)               (1000 * freq)
+#define PACKING_BYTES_PW        4
+#define XFER_TIMEOUT            HZ
+#define DFS_INDEX_MAX           7
+
+#define I3C_DDR_READ_CMD BIT(7)
+
+#define I3C_ADDR_MASK 0x7f
+
+enum i3c_trans_dir {
+	WRITE_TRANSACTION = 0,
+	READ_TRANSACTION = 1
+};
+
+struct geni_i3c_dev {
+	struct geni_se se;
+	unsigned int tx_wm;
+	int irq;
+	int err;
+	struct i3c_master_controller ctrlr;
+	struct completion done;
+	struct mutex lock;
+	spinlock_t spinlock;
+	u32 clk_src_freq;
+	u32 dfs_idx;
+	u8 *cur_buf;
+	enum i3c_trans_dir cur_rnw;
+	int cur_len;
+	int cur_idx;
+	unsigned long newaddrslots[(I3C_ADDR_MASK + 1) / BITS_PER_LONG];
+	const struct geni_i3c_clk_fld *clk_fld;
+};
+
+struct geni_i3c_i2c_dev_data {
+	u32 dummy;  /* placeholder for now, later will hold IBI information */
+};
+
+
+struct i3c_xfer_params {
+	enum geni_se_xfer_mode mode;
+	u32 m_cmd;
+	u32 m_param;
+};
+
+static inline struct geni_i3c_dev*
+to_geni_i3c_master(struct i3c_master_controller *master)
+{
+	return container_of(master, struct geni_i3c_dev, ctrlr);
+}
+
+struct geni_i3c_err_log {
+	int err;
+	const char *msg;
+};
+
+static struct geni_i3c_err_log gi3c_log[] = {
+	[RD_TERM] = { -EINVAL, "I3C slave early read termination" },
+	[NACK] = { -ENOTCONN, "NACK: slave unresponsive, check power/reset" },
+	[CRC_ERR] = { -EINVAL, "CRC or parity error" },
+	[BUS_PROTO] = { -EPROTO, "Bus proto err, noisy/unexpected start/stop" },
+	[NACK_7E] = { -EBUSY, "NACK on 7E, unexpected protocol error" },
+	[NACK_IBI] = { -EINVAL, "NACK on IBI" },
+	[GENI_OVERRUN] = { -EIO, "Cmd overrun, check GENI cmd-state machine" },
+	[GENI_ILLEGAL_CMD] = { -EILSEQ,
+				"Illegal cmd, check GENI cmd-state machine" },
+	[GENI_ABORT_DONE] = { -ETIMEDOUT, "Abort after timeout successful" },
+	[GENI_TIMEOUT] = { -ETIMEDOUT, "I3C transaction timed out" },
+};
+
+struct geni_i3c_clk_fld {
+	u32 clk_freq_out;
+	u32 clk_src_freq;
+	u8  clk_div;
+	u8  i2c_t_high_cnt;
+	u8  i2c_t_low_cnt;
+	u8  i2c_t_cycle_cnt;
+	u8  i3c_t_high_cnt;
+	u8  i3c_t_cycle_cnt;
+};
+
+/*
+ * Hardware uses the underlying formula to calculate time periods of
+ * SCL clock cycle. Firmware uses some additional cycles excluded from the
+ * below formula and it is confirmed that the time periods are within
+ * specification limits.
+ *
+ * time of high period of I2C SCL:
+ *         i2c_t_high = (i2c_t_high_cnt * clk_div) / source_clock
+ * time of low period of I2C SCL:
+ *         i2c_t_low = (i2c_t_low_cnt * clk_div) / source_clock
+ * time of full period of I2C SCL:
+ *         i2c_t_cycle = (i2c_t_cycle_cnt * clk_div) / source_clock
+ * time of high period of I3C SCL:
+ *         i3c_t_high = (i3c_t_high_cnt * clk_div) / source_clock
+ * time of full period of I3C SCL:
+ *         i3c_t_cycle = (i3c_t_cycle_cnt * clk_div) / source_clock
+ * clk_freq_out = t / t_cycle
+ */
+static const struct geni_i3c_clk_fld geni_i3c_clk_map[] = {
+	{ KHZ(100),    19200, 7, 10, 11, 26, 0, 0 },
+	{ KHZ(400),    19200, 2,  5, 12, 24, 0, 0 },
+	{ KHZ(1000),   19200, 1,  3,  9, 18, 0, 0 },
+	{ KHZ(12500), 100000, 1, 60, 140, 250, 8, 16 },
+};
+
+static int geni_i3c_clk_map_idx(struct geni_i3c_dev *gi3c)
+{
+	int i;
+	const struct geni_i3c_clk_fld *itr = geni_i3c_clk_map;
+
+	for (i = 0; i < ARRAY_SIZE(geni_i3c_clk_map); i++, itr++) {
+		if ((!gi3c->ctrlr.bus ||
+			 itr->clk_freq_out == gi3c->ctrlr.bus->scl_rate.i3c) &&
+			 KHZ(itr->clk_src_freq) == gi3c->clk_src_freq) {
+			gi3c->clk_fld = itr;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static void set_new_addr_slot(unsigned long *addrslot, u8 addr)
+{
+	unsigned long *ptr;
+
+	if (addr > I3C_ADDR_MASK)
+		return;
+
+	ptr = addrslot + (addr / BITS_PER_LONG);
+	*ptr |= 1 << (addr % BITS_PER_LONG);
+}
+
+static void clear_new_addr_slot(unsigned long *addrslot, u8 addr)
+{
+	unsigned long *ptr;
+
+	if (addr > I3C_ADDR_MASK)
+		return;
+
+	ptr = addrslot + (addr / BITS_PER_LONG);
+	*ptr &= ~(1 << (addr % BITS_PER_LONG));
+}
+
+static bool is_new_addr_slot_set(unsigned long *addrslot, u8 addr)
+{
+	unsigned long *ptr;
+
+	if (addr > I3C_ADDR_MASK)
+		return false;
+
+	ptr = addrslot + (addr / BITS_PER_LONG);
+	return ((*ptr & (1 << (addr % BITS_PER_LONG))) != 0);
+}
+
+static inline void qcom_geni_i3c_conf(struct geni_i3c_dev *gi3c)
+{
+	const struct geni_i3c_clk_fld *itr = gi3c->clk_fld;
+	u32 val;
+	unsigned long freq;
+	int ret = 0;
+
+	if (gi3c->dfs_idx > DFS_INDEX_MAX)
+		ret = geni_se_clk_freq_match(&gi3c->se, KHZ(itr->clk_src_freq),
+			&gi3c->dfs_idx, &freq, false);
+	if (ret)
+		gi3c->dfs_idx = 0;
+
+	writel_relaxed(gi3c->dfs_idx, gi3c->se.base + SE_GENI_CLK_SEL);
+
+	val = itr->clk_div << CLK_DEV_VALUE_SHFT;
+	val |= 1 << SER_CLK_EN_SHFT;
+	writel_relaxed(val, gi3c->se.base + GENI_SER_M_CLK_CFG);
+
+	val = itr->i2c_t_high_cnt << I2C_SCL_HIGH_COUNTER_SHFT;
+	val |= itr->i2c_t_low_cnt << I2C_SCL_LOW_COUNTER_SHFT;
+	val |= itr->i2c_t_cycle_cnt;
+	writel_relaxed(val, gi3c->se.base + SE_I2C_SCL_COUNTERS);
+
+	writel_relaxed(itr->i3c_t_cycle_cnt, gi3c->se.base + SE_I3C_SCL_CYCLE);
+	writel_relaxed(itr->i3c_t_high_cnt, gi3c->se.base + SE_I3C_SCL_HIGH);
+
+	writel_relaxed(1, gi3c->se.base + SE_GENI_HW_IRQ_IGNORE_ON_ACTIVE);
+
+	val = 1 << M_IBI_IRQ_PARAM_STOP_STALL_SHFT;
+	val |= 1 << M_IBI_IRQ_PARAM_7E_SHFT;
+	writel_relaxed(val, gi3c->se.base + SE_GENI_HW_IRQ_CMD_PARAM_0);
+
+	writel_relaxed(1, gi3c->se.base + SE_GENI_HW_IRQ_EN);
+}
+
+static void geni_i3c_err(struct geni_i3c_dev *gi3c, int err)
+{
+	if (gi3c->cur_rnw == WRITE_TRANSACTION)
+		dev_dbg(gi3c->se.dev, "len:%d, write\n", gi3c->cur_len);
+	else
+		dev_dbg(gi3c->se.dev, "len:%d, read\n", gi3c->cur_len);
+
+	dev_dbg(gi3c->se.dev, "%s\n", gi3c_log[err].msg);
+	gi3c->err = gi3c_log[err].err;
+}
+
+static irqreturn_t geni_i3c_irq(int irq, void *dev)
+{
+	struct geni_i3c_dev *gi3c = dev;
+	int j;
+	u32 m_stat;
+	u32 m_stat_mask;
+	u32 rx_st;
+	u32 dm_tx_st;
+	u32 dm_rx_st;
+	u32 dma;
+	unsigned long flags;
+
+	spin_lock_irqsave(&gi3c->spinlock, flags);
+
+	m_stat = readl_relaxed(gi3c->se.base + SE_GENI_M_IRQ_STATUS);
+	m_stat_mask = readl_relaxed(gi3c->se.base + SE_GENI_M_IRQ_EN);
+	rx_st = readl_relaxed(gi3c->se.base + SE_GENI_RX_FIFO_STATUS);
+	dm_tx_st = readl_relaxed(gi3c->se.base + SE_DMA_TX_IRQ_STAT);
+	dm_rx_st = readl_relaxed(gi3c->se.base + SE_DMA_RX_IRQ_STAT);
+	dma = readl_relaxed(gi3c->se.base + SE_GENI_DMA_MODE_EN);
+
+	if ((m_stat   & SE_I3C_ERR) ||
+		(dm_rx_st & DM_I3C_CB_ERR)) {
+		if (m_stat & M_GP_IRQ_0_EN)
+			geni_i3c_err(gi3c, RD_TERM);
+		if (m_stat & M_GP_IRQ_1_EN)
+			geni_i3c_err(gi3c, NACK);
+		if (m_stat & M_GP_IRQ_2_EN)
+			geni_i3c_err(gi3c, CRC_ERR);
+		if (m_stat & M_GP_IRQ_3_EN)
+			geni_i3c_err(gi3c, BUS_PROTO);
+		if (m_stat & M_GP_IRQ_4_EN)
+			geni_i3c_err(gi3c, NACK_7E);
+		if (m_stat & M_CMD_OVERRUN_EN)
+			geni_i3c_err(gi3c, GENI_OVERRUN);
+		if (m_stat & M_ILLEGAL_CMD_EN)
+			geni_i3c_err(gi3c, GENI_ILLEGAL_CMD);
+		if (m_stat & M_CMD_ABORT_EN)
+			geni_i3c_err(gi3c, GENI_ABORT_DONE);
+
+		/* Disable the TX Watermark interrupt to stop TX */
+		if (!dma)
+			writel_relaxed(0, gi3c->se.base +
+				SE_GENI_TX_WATERMARK_REG);
+		goto irqret;
+	}
+
+	if (dma) {
+		dev_dbg(gi3c->se.dev, "i3c dma tx:0x%x, dma rx:0x%x\n",
+			dm_tx_st, dm_rx_st);
+		goto irqret;
+	}
+
+	if ((m_stat & (M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN)) &&
+		(gi3c->cur_rnw == READ_TRANSACTION) &&
+		gi3c->cur_buf) {
+		u32 rxcnt = rx_st & RX_FIFO_WC_MSK;
+
+		for (j = 0; j < rxcnt; j++) {
+			u32 val;
+			int p = 0;
+
+			val = readl_relaxed(gi3c->se.base + SE_GENI_RX_FIFOn);
+			while (gi3c->cur_idx < gi3c->cur_len &&
+				 p < sizeof(val)) {
+				gi3c->cur_buf[gi3c->cur_idx++] = val & 0xff;
+				val >>= 8;
+				p++;
+			}
+			if (gi3c->cur_idx == gi3c->cur_len)
+				break;
+		}
+	} else if ((m_stat & M_TX_FIFO_WATERMARK_EN) &&
+		(gi3c->cur_rnw == WRITE_TRANSACTION) &&
+		(gi3c->cur_buf)) {
+		for (j = 0; j < gi3c->tx_wm; j++) {
+			u32 temp;
+			u32 val = 0;
+			int p = 0;
+
+			while (gi3c->cur_idx < gi3c->cur_len &&
+					p < sizeof(val)) {
+				temp = gi3c->cur_buf[gi3c->cur_idx++];
+				val |= temp << (p * 8);
+				p++;
+			}
+			writel_relaxed(val, gi3c->se.base + SE_GENI_TX_FIFOn);
+			if (gi3c->cur_idx == gi3c->cur_len) {
+				writel_relaxed(0, gi3c->se.base +
+					SE_GENI_TX_WATERMARK_REG);
+				break;
+			}
+		}
+	}
+irqret:
+	if (m_stat)
+		writel_relaxed(m_stat, gi3c->se.base + SE_GENI_M_IRQ_CLEAR);
+
+	if (dma) {
+		if (dm_tx_st)
+			writel_relaxed(dm_tx_st,
+				gi3c->se.base + SE_DMA_TX_IRQ_CLR);
+		if (dm_rx_st)
+			writel_relaxed(dm_rx_st,
+				gi3c->se.base + SE_DMA_RX_IRQ_CLR);
+	}
+	/* if this is err with done-bit not set, handle that through timeout. */
+	if (m_stat & M_CMD_DONE_EN || m_stat & M_CMD_ABORT_EN) {
+		writel_relaxed(0, gi3c->se.base + SE_GENI_TX_WATERMARK_REG);
+		complete(&gi3c->done);
+	} else if ((dm_tx_st & TX_DMA_DONE) ||
+		(dm_rx_st & RX_DMA_DONE) ||
+		(dm_rx_st & RX_RESET_DONE))
+		complete(&gi3c->done);
+
+	spin_unlock_irqrestore(&gi3c->spinlock, flags);
+	return IRQ_HANDLED;
+}
+
+static int i3c_geni_runtime_get_mutex_lock(struct geni_i3c_dev *gi3c)
+{
+	int ret;
+
+	mutex_lock(&gi3c->lock);
+
+	reinit_completion(&gi3c->done);
+	ret = pm_runtime_get_sync(gi3c->se.dev);
+	if (ret < 0) {
+		dev_err(gi3c->se.dev,
+			"error turning on SE resources:%d\n", ret);
+		pm_runtime_put_noidle(gi3c->se.dev);
+		/* Set device in suspended since resume failed */
+		pm_runtime_set_suspended(gi3c->se.dev);
+
+		mutex_unlock(&gi3c->lock);
+
+		return ret;
+	}
+
+	qcom_geni_i3c_conf(gi3c);
+
+	return 0; /* return 0 to indicate SUCCESS */
+}
+
+static void i3c_geni_runtime_put_mutex_unlock(struct geni_i3c_dev *gi3c)
+{
+	pm_runtime_mark_last_busy(gi3c->se.dev);
+	pm_runtime_put_autosuspend(gi3c->se.dev);
+	mutex_unlock(&gi3c->lock);
+}
+
+static int _i3c_geni_execute_command
+(
+	struct geni_i3c_dev *gi3c,
+	struct i3c_xfer_params *xfer
+)
+{
+	dma_addr_t tx_dma = 0;
+	dma_addr_t rx_dma = 0;
+	int ret, time_remaining = 0;
+	enum i3c_trans_dir rnw = gi3c->cur_rnw;
+	u32 len = gi3c->cur_len;
+
+	geni_se_select_mode(&gi3c->se, xfer->mode);
+
+	gi3c->err = 0;
+	gi3c->cur_idx = 0;
+
+	if (rnw == READ_TRANSACTION) {
+		dev_dbg(gi3c->se.dev, "I3C cmd:0x%x param:0x%x READ len:%d\n",
+			xfer->m_cmd, xfer->m_param, len);
+		writel_relaxed(len, gi3c->se.base + SE_I3C_RX_TRANS_LEN);
+		geni_se_setup_m_cmd(&gi3c->se, xfer->m_cmd, xfer->m_param);
+		if (xfer->mode == GENI_SE_DMA) {
+			ret = geni_se_rx_dma_prep(&gi3c->se, gi3c->cur_buf,
+				len, &rx_dma);
+			if (ret) {
+				xfer->mode = GENI_SE_FIFO;
+				geni_se_select_mode(&gi3c->se, xfer->mode);
+			}
+		}
+	} else {
+		dev_dbg(gi3c->se.dev, "I3C cmd:0x%x param:0x%x WRITE len:%d\n",
+			xfer->m_cmd, xfer->m_param, len);
+		writel_relaxed(len, gi3c->se.base + SE_I3C_TX_TRANS_LEN);
+		geni_se_setup_m_cmd(&gi3c->se, xfer->m_cmd, xfer->m_param);
+		if (xfer->mode == GENI_SE_DMA) {
+			ret = geni_se_tx_dma_prep(&gi3c->se, gi3c->cur_buf,
+				len, &tx_dma);
+			if (ret) {
+				xfer->mode = GENI_SE_FIFO;
+				geni_se_select_mode(&gi3c->se, xfer->mode);
+			}
+		}
+		if (xfer->mode == GENI_SE_FIFO && len > 0) /* Get FIFO IRQ */
+			writel_relaxed(1, gi3c->se.base +
+				SE_GENI_TX_WATERMARK_REG);
+	}
+	time_remaining = wait_for_completion_timeout(&gi3c->done,
+						XFER_TIMEOUT);
+	if (!time_remaining) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&gi3c->spinlock, flags);
+		geni_i3c_err(gi3c, GENI_TIMEOUT);
+		gi3c->cur_buf = NULL;
+		gi3c->cur_len = gi3c->cur_idx = 0;
+		gi3c->cur_rnw = 0;
+		geni_se_abort_m_cmd(&gi3c->se);
+		spin_unlock_irqrestore(&gi3c->spinlock, flags);
+		time_remaining = wait_for_completion_timeout(&gi3c->done,
+							XFER_TIMEOUT);
+	}
+	if (xfer->mode == GENI_SE_DMA) {
+		if (gi3c->err) {
+			if (rnw == READ_TRANSACTION)
+				writel_relaxed(1, gi3c->se.base +
+					SE_DMA_TX_FSM_RST);
+			else
+				writel_relaxed(1, gi3c->se.base +
+					SE_DMA_RX_FSM_RST);
+			wait_for_completion_timeout(&gi3c->done, XFER_TIMEOUT);
+		}
+		geni_se_rx_dma_unprep(&gi3c->se, rx_dma, len);
+		geni_se_tx_dma_unprep(&gi3c->se, tx_dma, len);
+	}
+	ret = gi3c->err;
+	if (gi3c->err)
+		dev_err(gi3c->se.dev, "I3C transaction error :%d\n", gi3c->err);
+
+	gi3c->cur_buf = NULL;
+	gi3c->cur_len = gi3c->cur_idx = 0;
+	gi3c->cur_rnw = 0;
+	gi3c->err = 0;
+
+	return ret;
+}
+
+static int i3c_geni_execute_read_command
+(
+	struct geni_i3c_dev *gi3c,
+	struct i3c_xfer_params *xfer,
+	u8 *buf,
+	u32 len
+)
+{
+	gi3c->cur_rnw = READ_TRANSACTION;
+	gi3c->cur_buf = buf;
+	gi3c->cur_len = len;
+	return _i3c_geni_execute_command(gi3c, xfer);
+}
+
+static int i3c_geni_execute_write_command
+(
+	struct geni_i3c_dev *gi3c,
+	struct i3c_xfer_params *xfer,
+	u8 *buf,
+	u32 len
+)
+{
+	gi3c->cur_rnw = WRITE_TRANSACTION;
+	gi3c->cur_buf = buf;
+	gi3c->cur_len = len;
+	return _i3c_geni_execute_command(gi3c, xfer);
+}
+
+static void geni_i3c_perform_daa(struct geni_i3c_dev *gi3c)
+{
+	u8 last_dyn_addr = 0;
+	int ret;
+
+	while (1) {
+		u8 rx_buf[8], tx_buf[8];
+		struct i3c_xfer_params xfer = { GENI_SE_FIFO };
+		struct i3c_device_info info = { 0 };
+		struct i3c_dev_desc *i3cdev;
+		bool new_device = true;
+		u64 pid;
+		u8 bcr, dcr, addr;
+
+		dev_dbg(gi3c->se.dev, "i3c entdaa read\n");
+
+		xfer.m_cmd = I2C_READ;
+		xfer.m_param = STOP_STRETCH | CONTINUOUS_MODE_DAA | USE_7E;
+
+		ret = i3c_geni_execute_read_command(gi3c, &xfer, rx_buf, 8);
+		if (ret)
+			break;
+
+		dcr = rx_buf[7];
+		bcr = rx_buf[6];
+		pid = ((u64)rx_buf[0] << 40) |
+			((u64)rx_buf[1] << 32) |
+			((u64)rx_buf[2] << 24) |
+			((u64)rx_buf[3] << 16) |
+			((u64)rx_buf[4] <<  8) |
+			((u64)rx_buf[5]);
+
+		i3c_bus_for_each_i3cdev(gi3c->ctrlr.bus, i3cdev) {
+			i3c_device_get_info(i3cdev->dev, &info);
+			if (pid == info.pid &&
+				dcr == info.dcr &&
+				bcr == info.bcr) {
+				new_device = false;
+				addr = (info.dyn_addr) ? info.dyn_addr :
+					info.static_addr;
+				break;
+			}
+		}
+
+		if (new_device) {
+			ret = i3c_master_get_free_addr(&gi3c->ctrlr,
+						last_dyn_addr + 1);
+			if (ret < 0)
+				goto daa_err;
+			addr = last_dyn_addr = (u8)ret;
+			set_new_addr_slot(gi3c->newaddrslots, addr);
+		}
+
+		tx_buf[0] = (addr & I3C_ADDR_MASK) << 1;
+		tx_buf[0] |= ~(hweight8(addr & I3C_ADDR_MASK) & 1);
+
+		dev_dbg(gi3c->se.dev, "i3c entdaa write\n");
+
+		xfer.m_cmd = I2C_WRITE;
+		xfer.m_param = STOP_STRETCH | BYPASS_ADDR_PHASE | USE_7E;
+
+		ret = i3c_geni_execute_write_command(gi3c, &xfer, tx_buf, 1);
+		if (ret)
+			break;
+	}
+daa_err:
+	return;
+}
+
+static int geni_i3c_master_send_ccc_cmd
+(
+	struct i3c_master_controller *m,
+	struct i3c_ccc_cmd *cmd
+)
+{
+	struct geni_i3c_dev *gi3c = to_geni_i3c_master(m);
+	int i, ret;
+
+	if (!(cmd->id & I3C_CCC_DIRECT) && (cmd->ndests != 1))
+		return -1;
+
+	ret = i3c_geni_runtime_get_mutex_lock(gi3c);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < cmd->ndests; i++) {
+		int stall = (i < (cmd->ndests - 1)) ||
+			(cmd->id == I3C_CCC_ENTDAA);
+		struct i3c_xfer_params xfer = { GENI_SE_FIFO };
+
+		xfer.m_param  = (stall ? STOP_STRETCH : 0);
+		xfer.m_param |= (cmd->id << CCC_HDR_CMD_SHFT);
+		xfer.m_param |= IBI_NACK_TBL_CTRL;
+		if (cmd->id & I3C_CCC_DIRECT) {
+			xfer.m_param |= ((cmd->dests[i].addr & I3C_ADDR_MASK)
+					<< SLV_ADDR_SHFT);
+			if (cmd->rnw) {
+				if (i == 0)
+					xfer.m_cmd = I3C_DIRECT_CCC_READ;
+				else
+					xfer.m_cmd = I3C_PRIVATE_READ;
+			} else {
+				if (i == 0)
+					xfer.m_cmd =
+					   (cmd->dests[i].payload.len > 0) ?
+						I3C_DIRECT_CCC_WRITE :
+						I3C_DIRECT_CCC_ADDR_ONLY;
+				else
+					xfer.m_cmd = I3C_PRIVATE_WRITE;
+			}
+		} else {
+			if (cmd->dests[i].payload.len > 0)
+				xfer.m_cmd = I3C_BCAST_CCC_WRITE;
+			else
+				xfer.m_cmd = I3C_BCAST_CCC_ADDR_ONLY;
+		}
+
+		if (i == 0)
+			xfer.m_param |= USE_7E;
+
+		if (cmd->rnw)
+			ret = i3c_geni_execute_read_command(gi3c, &xfer,
+				cmd->dests[i].payload.data,
+				cmd->dests[i].payload.len);
+		else
+			ret = i3c_geni_execute_write_command(gi3c, &xfer,
+				cmd->dests[i].payload.data,
+				cmd->dests[i].payload.len);
+		if (ret)
+			break;
+
+		if (cmd->id == I3C_CCC_ENTDAA)
+			geni_i3c_perform_daa(gi3c);
+	}
+
+	dev_dbg(gi3c->se.dev, "i3c ccc: txn ret:%d\n", ret);
+
+	i3c_geni_runtime_put_mutex_unlock(gi3c);
+
+	return ret;
+}
+
+static int geni_i3c_master_priv_xfers
+(
+	struct i3c_dev_desc *dev,
+	struct i3c_priv_xfer *xfers,
+	int nxfers
+)
+{
+	struct i3c_master_controller *m = i3c_dev_get_master(dev);
+	struct geni_i3c_dev *gi3c = to_geni_i3c_master(m);
+	int i, ret;
+	bool use_7e = true;
+
+	if (nxfers <= 0)
+		return 0;
+
+	ret = i3c_geni_runtime_get_mutex_lock(gi3c);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nxfers; i++) {
+		bool stall = (i < (nxfers - 1));
+		struct i3c_xfer_params xfer = { GENI_SE_FIFO };
+
+		xfer.m_param  = (stall ? STOP_STRETCH : 0);
+		xfer.m_param |= ((dev->info.dyn_addr & I3C_ADDR_MASK)
+				<< SLV_ADDR_SHFT);
+		xfer.m_param |= (use_7e) ? USE_7E : 0;
+
+		/* Update use_7e status for next loop iteration */
+		use_7e = !stall;
+
+		if (xfers[i].rnw) {
+			xfer.m_cmd = I3C_PRIVATE_READ;
+			ret = i3c_geni_execute_read_command(gi3c, &xfer,
+				(u8 *)xfers[i].data.in,
+				xfers[i].len);
+		} else {
+			xfer.m_cmd = I3C_PRIVATE_WRITE;
+			ret = i3c_geni_execute_write_command(gi3c, &xfer,
+				(u8 *)xfers[i].data.out,
+				xfers[i].len);
+		}
+
+		if (ret)
+			break;
+	}
+
+	dev_dbg(gi3c->se.dev, "i3c priv: txn ret:%d\n", ret);
+
+	i3c_geni_runtime_put_mutex_unlock(gi3c);
+
+	return ret;
+}
+
+static int geni_i3c_master_i2c_xfers
+(
+	struct i2c_dev_desc *dev,
+	const struct i2c_msg *msgs,
+	int num
+)
+{
+	struct i3c_master_controller *m = i2c_dev_get_master(dev);
+	struct geni_i3c_dev *gi3c = to_geni_i3c_master(m);
+	int i, ret;
+
+	ret = i3c_geni_runtime_get_mutex_lock(gi3c);
+	if (ret)
+		return ret;
+
+	dev_dbg(gi3c->se.dev, "i2c xfer:num:%d, msgs:len:%d,flg:%d\n",
+		num, msgs[0].len, msgs[0].flags);
+	for (i = 0; i < num; i++) {
+		struct i3c_xfer_params xfer;
+
+		xfer.m_cmd    = (msgs[i].flags & I2C_M_RD) ? I2C_READ :
+							I2C_WRITE;
+		xfer.m_param  = (i < (num - 1)) ? STOP_STRETCH : 0;
+		xfer.m_param |= ((msgs[i].addr & I3C_ADDR_MASK)
+				<< SLV_ADDR_SHFT);
+		xfer.mode     = msgs[i].len > 32 ? GENI_SE_DMA : GENI_SE_FIFO;
+		if (msgs[i].flags & I2C_M_RD)
+			ret = i3c_geni_execute_read_command(gi3c, &xfer,
+						msgs[i].buf, msgs[i].len);
+		else
+			ret = i3c_geni_execute_write_command(gi3c, &xfer,
+						msgs[i].buf, msgs[i].len);
+		if (ret)
+			break;
+	}
+
+	dev_dbg(gi3c->se.dev, "i2c: txn ret:%d\n", ret);
+
+	i3c_geni_runtime_put_mutex_unlock(gi3c);
+
+	return ret;
+}
+
+static u32 geni_i3c_master_i2c_funcs(struct i3c_master_controller *m)
+{
+	return I2C_FUNC_I2C;
+}
+
+static int geni_i3c_master_attach_i2c_dev(struct i2c_dev_desc *dev)
+{
+	struct i3c_master_controller *m = i2c_dev_get_master(dev);
+	struct geni_i3c_dev *gi3c = to_geni_i3c_master(m);
+	struct geni_i3c_i2c_dev_data *data;
+
+	data = devm_kzalloc(gi3c->se.dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	memset(data, 0, sizeof(*data));
+
+	i2c_dev_set_master_data(dev, data);
+
+	return 0;
+}
+
+
+static void geni_i3c_master_detach_i2c_dev(struct i2c_dev_desc *dev)
+{
+	struct geni_i3c_i2c_dev_data *data = i2c_dev_get_master_data(dev);
+
+	i2c_dev_set_master_data(dev, NULL);
+	kfree(data);
+}
+
+
+static int geni_i3c_master_attach_i3c_dev(struct i3c_dev_desc *dev)
+{
+	struct i3c_master_controller *m = i3c_dev_get_master(dev);
+	struct geni_i3c_dev *gi3c = to_geni_i3c_master(m);
+	struct geni_i3c_i2c_dev_data *data;
+
+	data = devm_kzalloc(gi3c->se.dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	i3c_dev_set_master_data(dev, data);
+
+	// Todo: update max FSCL
+
+	return 0;
+}
+
+static int geni_i3c_master_reattach_i3c_dev
+(
+	struct i3c_dev_desc *dev,
+	u8 old_dyn_addr
+)
+{
+	return 0;
+}
+
+static void geni_i3c_master_detach_i3c_dev(struct i3c_dev_desc *dev)
+{
+	struct geni_i3c_i2c_dev_data *data = i3c_dev_get_master_data(dev);
+
+	i3c_dev_set_master_data(dev, NULL);
+	kfree(data);
+}
+
+static int geni_i3c_master_entdaa_locked(struct geni_i3c_dev *gi3c)
+{
+	u8 addr;
+	int ret;
+
+	ret = i3c_master_entdaa_locked(&gi3c->ctrlr);
+	if (ret && ret != I3C_ERROR_M2)
+		return ret;
+
+	for (addr = 0; addr <= I3C_ADDR_MASK; addr++) {
+		if (is_new_addr_slot_set(gi3c->newaddrslots, addr)) {
+			clear_new_addr_slot(gi3c->newaddrslots, addr);
+			i3c_master_add_i3c_dev_locked(&gi3c->ctrlr, addr);
+		}
+	}
+
+	return 0;
+}
+
+static int geni_i3c_master_do_daa(struct i3c_master_controller *m)
+{
+	struct geni_i3c_dev *gi3c = to_geni_i3c_master(m);
+
+	return geni_i3c_master_entdaa_locked(gi3c);
+}
+
+static int geni_i3c_master_bus_init(struct i3c_master_controller *m)
+{
+	struct geni_i3c_dev *gi3c = to_geni_i3c_master(m);
+	struct i3c_device_info info = { };
+	int ret;
+
+	ret = pm_runtime_get_sync(gi3c->se.dev);
+	if (ret < 0) {
+		dev_err(gi3c->se.dev, "%s: error turning SE resources:%d\n",
+			__func__, ret);
+		pm_runtime_put_noidle(gi3c->se.dev);
+		/* Set device in suspended since resume failed */
+		pm_runtime_set_suspended(gi3c->se.dev);
+		return ret;
+	}
+
+	ret = geni_i3c_clk_map_idx(gi3c);
+	if (ret) {
+		dev_err(gi3c->se.dev,
+			"Invalid clk frequency %d Hz src or %ld Hz bus: %d\n",
+			gi3c->clk_src_freq, gi3c->ctrlr.bus->scl_rate.i3c,
+			ret);
+		goto err_cleanup;
+	}
+
+	qcom_geni_i3c_conf(gi3c);
+
+	/* Get an address for the master. */
+	ret = i3c_master_get_free_addr(m, 0);
+	if (ret < 0)
+		goto err_cleanup;
+
+	info.dyn_addr = ret;
+	info.dcr = I3C_DCR_GENERIC_DEVICE;
+	info.bcr = I3C_BCR_I3C_MASTER | I3C_BCR_HDR_CAP;
+	info.pid = 0;
+
+	ret = i3c_master_set_info(&gi3c->ctrlr, &info);
+
+err_cleanup:
+	pm_runtime_mark_last_busy(gi3c->se.dev);
+	pm_runtime_put_autosuspend(gi3c->se.dev);
+
+	return ret;
+}
+static void geni_i3c_master_bus_cleanup(struct i3c_master_controller *m)
+{
+}
+
+static bool geni_i3c_master_supports_ccc_cmd
+(
+	struct i3c_master_controller *m,
+	const struct i3c_ccc_cmd *cmd
+)
+{
+	switch (cmd->id) {
+	case I3C_CCC_ENEC(true):
+	/* fallthrough */
+	case I3C_CCC_ENEC(false):
+	/* fallthrough */
+	case I3C_CCC_DISEC(true):
+	/* fallthrough */
+	case I3C_CCC_DISEC(false):
+	/* fallthrough */
+	case I3C_CCC_ENTAS(0, true):
+	/* fallthrough */
+	case I3C_CCC_ENTAS(0, false):
+	/* fallthrough */
+	case I3C_CCC_RSTDAA(true):
+	/* fallthrough */
+	case I3C_CCC_RSTDAA(false):
+	/* fallthrough */
+	case I3C_CCC_ENTDAA:
+	/* fallthrough */
+	case I3C_CCC_SETMWL(true):
+	/* fallthrough */
+	case I3C_CCC_SETMWL(false):
+	/* fallthrough */
+	case I3C_CCC_SETMRL(true):
+	/* fallthrough */
+	case I3C_CCC_SETMRL(false):
+	/* fallthrough */
+	case I3C_CCC_DEFSLVS:
+	/* fallthrough */
+	case I3C_CCC_ENTHDR(0):
+	/* fallthrough */
+	case I3C_CCC_SETDASA:
+	/* fallthrough */
+	case I3C_CCC_SETNEWDA:
+	/* fallthrough */
+	case I3C_CCC_GETMWL:
+	/* fallthrough */
+	case I3C_CCC_GETMRL:
+	/* fallthrough */
+	case I3C_CCC_GETPID:
+	/* fallthrough */
+	case I3C_CCC_GETBCR:
+	/* fallthrough */
+	case I3C_CCC_GETDCR:
+	/* fallthrough */
+	case I3C_CCC_GETSTATUS:
+	/* fallthrough */
+	case I3C_CCC_GETACCMST:
+	/* fallthrough */
+	case I3C_CCC_GETMXDS:
+	/* fallthrough */
+	case I3C_CCC_GETHDRCAP:
+		return true;
+	default:
+		break;
+	}
+
+	return false;
+}
+
+int geni_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
+{
+	return -ENOTSUPP;
+}
+
+int geni_i3c_master_disable_ibi(struct i3c_dev_desc *dev)
+{
+	return -ENOTSUPP;
+}
+
+int geni_i3c_master_request_ibi(struct i3c_dev_desc *dev,
+	const struct i3c_ibi_setup *req)
+{
+	return -ENOTSUPP;
+}
+
+static void geni_i3c_master_free_ibi(struct i3c_dev_desc *dev)
+{
+}
+
+static void geni_i3c_master_recycle_ibi_slot
+(
+	struct i3c_dev_desc *dev,
+	struct i3c_ibi_slot *slot
+)
+{
+}
+
+static const struct i3c_master_controller_ops geni_i3c_master_ops = {
+	.bus_init = geni_i3c_master_bus_init,
+	.bus_cleanup = geni_i3c_master_bus_cleanup,
+	.do_daa = geni_i3c_master_do_daa,
+	.attach_i3c_dev = geni_i3c_master_attach_i3c_dev,
+	.reattach_i3c_dev = geni_i3c_master_reattach_i3c_dev,
+	.detach_i3c_dev = geni_i3c_master_detach_i3c_dev,
+	.attach_i2c_dev = geni_i3c_master_attach_i2c_dev,
+	.detach_i2c_dev = geni_i3c_master_detach_i2c_dev,
+	.supports_ccc_cmd = geni_i3c_master_supports_ccc_cmd,
+	.send_ccc_cmd = geni_i3c_master_send_ccc_cmd,
+	.priv_xfers = geni_i3c_master_priv_xfers,
+	.i2c_xfers = geni_i3c_master_i2c_xfers,
+	.i2c_funcs = geni_i3c_master_i2c_funcs,
+	.enable_ibi = geni_i3c_master_enable_ibi,
+	.disable_ibi = geni_i3c_master_disable_ibi,
+	.request_ibi = geni_i3c_master_request_ibi,
+	.free_ibi = geni_i3c_master_free_ibi,
+	.recycle_ibi_slot = geni_i3c_master_recycle_ibi_slot,
+};
+
+static int geni_i3c_probe(struct platform_device *pdev)
+{
+	struct geni_i3c_dev *gi3c;
+	struct resource *res;
+	u32 proto, tx_depth;
+	int ret;
+
+	gi3c = devm_kzalloc(&pdev->dev, sizeof(*gi3c), GFP_KERNEL);
+	if (!gi3c)
+		return -ENOMEM;
+
+	gi3c->se.dev = &pdev->dev;
+	gi3c->se.wrapper = dev_get_drvdata(pdev->dev.parent);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	gi3c->se.base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(gi3c->se.base))
+		return PTR_ERR(gi3c->se.base);
+
+	gi3c->se.clk = devm_clk_get(&pdev->dev, "se");
+	if (IS_ERR(gi3c->se.clk)) {
+		ret = PTR_ERR(gi3c->se.clk);
+		dev_err(&pdev->dev, "Err getting SE Core clk %d\n", ret);
+		return ret;
+	}
+
+	ret = device_property_read_u32(&pdev->dev, "se-clock-frequency",
+		&gi3c->clk_src_freq);
+	if (ret) {
+		dev_info(&pdev->dev,
+			"SE clk freq not specified, default to 100 MHz.\n");
+		gi3c->clk_src_freq = 100000000;
+	}
+
+
+	ret = device_property_read_u32(&pdev->dev, "dfs-index",
+		&gi3c->dfs_idx);
+	if (ret)
+		gi3c->dfs_idx = 0xf;
+
+	gi3c->irq = platform_get_irq(pdev, 0);
+	if (gi3c->irq < 0) {
+		dev_err(&pdev->dev, "IRQ error for i3c-master-geni\n");
+		return gi3c->irq;
+	}
+
+	ret = geni_i3c_clk_map_idx(gi3c);
+	if (ret) {
+		dev_err(&pdev->dev, "Invalid source clk frequency %d Hz: %d\n",
+			gi3c->clk_src_freq, ret);
+		return ret;
+	}
+
+	init_completion(&gi3c->done);
+	mutex_init(&gi3c->lock);
+	spin_lock_init(&gi3c->spinlock);
+	platform_set_drvdata(pdev, gi3c);
+	ret = devm_request_irq(&pdev->dev, gi3c->irq, geni_i3c_irq,
+		IRQF_TRIGGER_HIGH, dev_name(&pdev->dev), gi3c);
+	if (ret) {
+		dev_err(&pdev->dev, "Request_irq failed:%d: err:%d\n",
+			gi3c->irq, ret);
+		return ret;
+	}
+	/* Disable the interrupt so that the system can enter low-power mode */
+	disable_irq(gi3c->irq);
+
+	ret = geni_se_resources_on(&gi3c->se);
+	if (ret) {
+		dev_err(&pdev->dev, "Error turning on resources %d\n", ret);
+		return ret;
+	}
+
+	proto = geni_se_read_proto(&gi3c->se);
+	if (proto != GENI_SE_I3C) {
+		dev_err(&pdev->dev, "Invalid proto %d\n", proto);
+		geni_se_resources_off(&gi3c->se);
+		return -ENXIO;
+	}
+
+	tx_depth = geni_se_get_tx_fifo_depth(&gi3c->se);
+	gi3c->tx_wm = tx_depth - 1;
+	geni_se_init(&gi3c->se, gi3c->tx_wm, tx_depth);
+	geni_se_config_packing(&gi3c->se, BITS_PER_BYTE, PACKING_BYTES_PW,
+		true, true, true);
+	geni_se_resources_off(&gi3c->se);
+	dev_dbg(&pdev->dev, "i3c fifo/se-dma mode. fifo depth:%d\n", tx_depth);
+
+	pm_runtime_set_suspended(gi3c->se.dev);
+	pm_runtime_set_autosuspend_delay(gi3c->se.dev, I3C_AUTO_SUSPEND_DELAY);
+	pm_runtime_use_autosuspend(gi3c->se.dev);
+	pm_runtime_enable(gi3c->se.dev);
+
+	ret = i3c_master_register(&gi3c->ctrlr, &pdev->dev,
+		&geni_i3c_master_ops, false);
+
+	if (ret)
+		return ret;
+
+	dev_err(&pdev->dev, "I3C probed\n");
+	return ret;
+}
+
+static int geni_i3c_remove(struct platform_device *pdev)
+{
+	struct geni_i3c_dev *gi3c = platform_get_drvdata(pdev);
+	int ret = 0;
+
+	pm_runtime_disable(gi3c->se.dev);
+	ret = i3c_master_unregister(&gi3c->ctrlr);
+	return ret;
+}
+
+#ifdef CONFIG_PM
+static int geni_i3c_runtime_suspend(struct device *dev)
+{
+	struct geni_i3c_dev *gi3c = dev_get_drvdata(dev);
+
+	disable_irq(gi3c->irq);
+	geni_se_resources_off(&gi3c->se);
+	return 0;
+}
+
+static int geni_i3c_runtime_resume(struct device *dev)
+{
+	int ret;
+	struct geni_i3c_dev *gi3c = dev_get_drvdata(dev);
+
+	ret = geni_se_resources_on(&gi3c->se);
+	if (ret)
+		return ret;
+
+	enable_irq(gi3c->irq);
+
+	return 0;
+}
+#else
+static int geni_i3c_runtime_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int geni_i3c_runtime_resume(struct device *dev)
+{
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops geni_i3c_pm_ops = {
+	.runtime_suspend = geni_i3c_runtime_suspend,
+	.runtime_resume  = geni_i3c_runtime_resume,
+};
+
+static const struct of_device_id geni_i3c_dt_match[] = {
+	{ .compatible = "qcom,geni-i3c" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, geni_i3c_dt_match);
+
+static struct platform_driver geni_i3c_master = {
+	.probe  = geni_i3c_probe,
+	.remove = geni_i3c_remove,
+	.driver = {
+		.name = "geni_i3c_master",
+		.pm = &geni_i3c_pm_ops,
+		.of_match_table = geni_i3c_dt_match,
+	},
+};
+
+module_platform_driver(geni_i3c_master);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:geni_i3c_master");
+
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

