Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A1EECDFBD
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0D120661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Yii+b3Y+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0D120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbeGTVsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:48:53 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:41252 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbeGTVsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:48:53 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 06F5024E0E9C;
        Fri, 20 Jul 2018 13:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532120333; bh=ZBxkgTkhKEQezdVaWIDIi1WvGiEW5ET8dYHmSWuLotE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yii+b3Y+7yYGeAy/M61H+u6FTph8NjB0RdFve7Fz5escr1IdP+6gFZeb/E3i03f43
         50vSGIlsy0nCAaSI7ls4v3VI8QOtVxQbTVHYcB0enfNch5zyr9zQJbb6ZOqTIg20ah
         bIomM8FxE2uSKlBgT2rMc8fzVTHE/BWepUP5+8xNzIO9TjCpnngAcGyCXXeS5OsFEj
         YpF1PZx1PkBTCbanWU6Dt+vOd5IUsI/rm77qsqacgyqron1wjHCc68QT8MUTULchq/
         udRLPiXLOygU+Ks9vlPolmGML8ZTf8bo2R9f24ymEKdMd/QTm1mSfV4Q5PMe+/kF1/
         0awJSd0KEQDAA==
Received: from vitor-VirtualBox.internal.synopsys.com (soares-e7470.internal.synopsys.com [10.107.25.76])
        by mailhost.synopsys.com (Postfix) with ESMTP id C9C655BB7;
        Fri, 20 Jul 2018 13:58:44 -0700 (PDT)
From:   Vitor soares <Vitor.Soares@synopsys.com>
To:     boris.brezillon@bootlin.com, wsa@the-dreams.de,
        linux-i2c@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        arnd@arndb.de
Cc:     psroka@cadence.com, agolec@cadence.com, adouglas@cadence.com,
        bfolta@cadence.com, dkos@cadence.com, alicja@cadence.com,
        cwronka@cadence.com, sureshp@cadence.com, rafalc@cadence.com,
        thomas.petazzoni@bootlin.com, nm@ti.com, robh+dt@kernel.org,
        pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, linus.walleij@linaro.org,
        Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org,
        nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se,
        Joao.Pinto@synopsys.com, Vitor.Soares@synopsys.com
Subject: [PATCH 1/3] i3c: master: Add driver for Synopsys DesignWare IP
Date:   Fri, 20 Jul 2018 21:57:50 +0100
Message-Id: <1532120272-17157-2-git-send-email-soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532120272-17157-1-git-send-email-soares@synopsys.com>
References: <1532120272-17157-1-git-send-email-soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add driver for Synopsys DesignWare IP on top of
I3C subsystem patchset proposal V6

Signed-off-by: Vitor soares <soares@synopsys.com>
---
 drivers/i3c/master/Kconfig         |   10 +
 drivers/i3c/master/Makefile        |    1 +
 drivers/i3c/master/dw-i3c-master.c | 1255 ++++++++++++++++++++++++++++++++++++
 3 files changed, 1266 insertions(+)
 create mode 100644 drivers/i3c/master/dw-i3c-master.c

diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
index 56b9a18..87d6a8c 100644
--- a/drivers/i3c/master/Kconfig
+++ b/drivers/i3c/master/Kconfig
@@ -3,3 +3,13 @@ config CDNS_I3C_MASTER
 	depends on I3C
 	help
 	  Enable this driver if you want to support Cadence I3C master block.
+
+config DW_I3C_MASTER
+	tristate "Synospsys DesignWare I3C master driver"
+	depends on I3C
+	help
+	  If you say yes to this option, support will be included for the
+	  Synopsys DesignWare I3C controller. Only master mode is supported.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called dw-i3c-master.
diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
index 4c4304a..fc53939 100644
--- a/drivers/i3c/master/Makefile
+++ b/drivers/i3c/master/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_CDNS_I3C_MASTER)		+= i3c-master-cdns.o
+obj-$(CONFIG_DW_I3C_MASTER)		+= dw-i3c-master.o
diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
new file mode 100644
index 0000000..cb2a22b
--- /dev/null
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -0,0 +1,1255 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
+ *
+ * Author: Vitor Soares <soares@synopsys.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/i3c/master.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+#define DEVICE_CTRL			0x0
+#define DEV_CTRL_ENABLE			BIT(31)
+#define DEV_CTRL_RESUME			BIT(30)
+#define DEV_CTRL_HOT_JOIN		BIT(8)
+#define DEV_CTRL_I2C_SLAVE_PRESENT	BIT(7)
+
+#define DEVICE_ADDR			0x4
+#define DEV_ADDR_DYNAMIC_ADDR_VALID	BIT(31)
+#define DEV_ADDR_DYNAMIC(x)		(((x) << 16) & GENMASK(22, 16))
+
+#define HW_CAPABILITY			0x8
+#define COMMAND_QUEUE_PORT		0xc
+
+#define COMMAND_PORT_ARG_DATA_LEN(x)	(((x) << 16) & GENMASK(31, 16))
+#define COMMAND_PORT_ARG_DATA_LEN_MAX	65536
+
+#define COMMAND_PORT_TOC		BIT(30)
+#define COMMAND_PORT_READ_TRANSFER	BIT(28)
+#define COMMAND_PORT_SDAP		BIT(27)
+#define COMMAND_PORT_ROC		BIT(26)
+#define COMMAND_PORT_SPEED(x)		(((x) << 21) & GENMASK(23, 21))
+#define COMMAND_PORT_DEV_COUNT(x)	(((x) << 21) & GENMASK(25, 21))
+#define COMMAND_PORT_DEV_INDEX(x)	(((x) << 16) & GENMASK(20, 16))
+#define COMMAND_PORT_CP			BIT(15)
+#define COMMAND_PORT_CMD(x)		(((x) << 7) & GENMASK(14, 7))
+#define COMMAND_PORT_TID(x)		(((x) << 3) & GENMASK(6, 3))
+
+#define COMMAND_PORT_ADDR_ASSGN_CMD	0x03
+#define COMMAND_PORT_SHORT_DATA_ARG	0x02
+#define COMMAND_PORT_TRANSFER_ARG	0x01
+
+#define COMMAND_PORT_SDA_DATA_BYTE_3(x)	(((x) << 24) & GENMASK(31, 24))
+#define COMMAND_PORT_SDA_DATA_BYTE_2(x)	(((x) << 16) & GENMASK(23, 16))
+#define COMMAND_PORT_SDA_DATA_BYTE_1(x)	(((x) << 8) & GENMASK(15, 8))
+#define COMMAND_PORT_SDA_BYTE_STRB_3	BIT(5)
+#define COMMAND_PORT_SDA_BYTE_STRB_2	BIT(4)
+#define COMMAND_PORT_SDA_BYTE_STRB_1	BIT(3)
+
+#define RESPONSE_QUEUE_PORT		0x10
+#define RESPONSE_PORT_ERR_STATUS(x)	(((x) & GENMASK(31, 28)) >> 28)
+#define RESPONSE_NO_ERROR		0
+#define RESPONSE_ERROR_CRC		1
+#define RESPONSE_ERROR_PARITY		2
+#define RESPONSE_ERROR_FRAME		3
+#define RESPONSE_ERROR_IBA_NACK		4
+#define RESPONSE_ERROR_ADDRESS_NACK	5
+#define RESPONSE_ERROR_OVER_UNDER_FLOW	6
+#define RESPONSE_ERROR_TRANSF_ABORT	8
+#define RESPONSE_ERROR_I2C_W_NACK_ERR	9
+#define RESPONSE_PORT_TID(x)		(((x) & GENMASK(27, 24)) >> 24)
+#define RESPONSE_PORT_DATA_LEN(x)	((x) & GENMASK(15, 0))
+
+#define RX_TX_DATA_PORT			0x14
+#define IBI_QUEUE_DATA			0x18
+#define IBI_QUEUE_STATUS		0x18
+#define QUEUE_THLD_CTRL			0x1c
+#define QUEUE_THLD_CTRL_RESP_BUF(x)	((x) << 8)
+#define QUEUE_THLD_CTRL_RESP_BUF_MASK	GENMASK(15, 8)
+
+#define DATA_BUFFER_THLD_CTRL		0x20
+#define DATA_BUFFER_THLD_CTRL_RX_BUF	GENMASK(11, 8)
+
+#define IBI_QUEUE_CTRL			0x24
+#define IBI_SIR_REQ_REJECT		0x30
+#define RESET_CTRL			0x34
+#define RESET_CTRL_IBI_QUEUE		BIT(5)
+#define RESET_CTRL_RX_FIFO		BIT(4)
+#define RESET_CTRL_TX_FIFO		BIT(3)
+#define RESET_CTRL_RESP_QUEUE		BIT(2)
+#define RESET_CTRL_CMD_QUEUE		BIT(1)
+#define RESET_CTRL_SOFT			BIT(0)
+
+#define SLV_EVENT_CTRL			0x38
+
+#define INTR_STATUS			0x3c
+#define INTR_STATUS_EN			0x40
+#define INTR_SIGNAL_EN			0x44
+#define INTR_FORCE			0x48
+#define INTR_IBI_UPDATED_STAT		BIT(12)
+#define INTR_READ_REQ_RECV_STAT		BIT(11)
+#define INTR_TRANSFER_ERR_STAT		BIT(9)
+#define INTR_DYN_ADDR_ASSGN_STAT	BIT(8)
+#define INTR_CCC_UPDATED_STAT		BIT(6)
+#define INTR_TRANSFER_ABORT_STAT	BIT(5)
+#define INTR_RESP_READY_STAT		BIT(4)
+#define INTR_CMD_QUEUE_READY_STAT	BIT(3)
+#define INTR_IBI_THLD_STAT		BIT(2)
+#define INTR_RX_THLD_STAT		BIT(1)
+#define INTR_TX_THLD_STAT		BIT(0)
+#define INTR_ALL	(INTR_IBI_UPDATED_STAT |	\
+			 INTR_READ_REQ_RECV_STAT |	\
+			 INTR_TRANSFER_ERR_STAT |	\
+			 INTR_DYN_ADDR_ASSGN_STAT |	\
+			 INTR_CCC_UPDATED_STAT |	\
+			 INTR_TRANSFER_ABORT_STAT |	\
+			 INTR_RESP_READY_STAT |		\
+			 INTR_CMD_QUEUE_READY_STAT |	\
+			 INTR_IBI_THLD_STAT |		\
+			 INTR_TX_THLD_STAT |		\
+			 INTR_RX_THLD_STAT)
+
+#define QUEUE_STATUS_LEVEL		0x4c
+#define QUEUE_STATUS_LEVEL_RESP(x)	(((x) & GENMASK(15, 8)) >> 8)
+#define QUEUE_STATUS_LEVEL_CMD(x)	((x) & GENMASK(7, 0))
+
+#define DATA_BUFFER_STATUS_LEVEL	0x50
+#define DATA_BUFFER_STATUS_LEVEL_TX(x)	((x) & GENMASK(7, 0))
+
+#define PRESENT_STATE			0x54
+#define CCC_DEVICE_STATUS		0x58
+#define DEVICE_ADDR_TABLE_POINTER	0x5c
+#define DEVICE_ADDR_TABLE_DEPTH(x)	(((x) & GENMASK(31, 16)) >> 16)
+#define DEVICE_ADDR_TABLE_ADDR(x)	((x) & GENMASK(7, 0))
+
+
+#define DEV_CHAR_TABLE_POINTER		0x60
+#define VENDOR_SPECIFIC_REG_POINTER	0x6c
+#define SLV_PID_VALUE			0x74
+#define SLV_CHAR_CTRL			0x78
+#define SLV_MAX_LEN			0x7c
+#define MAX_READ_TURNAROUND		0x80
+#define MAX_DATA_SPEED			0x84
+#define SLV_DEBUG_STATUS		0x88
+#define SLV_INTR_REQ			0x8c
+#define DEVICE_CTRL_EXTENDED		0xb0
+#define SCL_I3C_OD_TIMING		0xb4
+#define SCL_I3C_PP_TIMING		0xb8
+#define SCL_I3C_TIMING_LCNT(x)		((x) & GENMASK(7, 0))
+#define SCL_I3C_TIMING_HCNT(x)		(((x) << 16) & GENMASK(23, 16))
+#define SCL_I3C_TIMING_CNT_MIN		5
+
+#define SCL_I2C_FM_TIMING		0xbc
+#define SCL_I2C_FM_TIMING_LCNT(x)	((x) & GENMASK(15, 0))
+#define SCL_I2C_FM_TIMING_HCNT(x)	(((x) << 16) & GENMASK(31, 16))
+
+#define SCL_I2C_FMP_TIMING		0xc0
+#define SCL_I2C_FMP_TIMING_LCNT(x)	((x) & GENMASK(15, 0))
+#define SCL_I2C_FMP_TIMING_HCNT(x)	(((x) << 16) & GENMASK(23, 16))
+
+#define SCL_EXT_LCNT_TIMING		0xc8
+#define SCL_EXT_LCNT_1(x)		((x) & GENMASK(7, 0))
+#define SCL_EXT_LCNT_2(x)		(((x) << 8) & GENMASK(15, 8))
+#define SCL_EXT_LCNT_3(x)		(((x) << 16) & GENMASK(23, 16))
+#define SCL_EXT_LCNT_4(x)		(((x) << 24) & GENMASK(31, 24))
+
+#define SCL_EXT_TERMN_LCNT_TIMING	0xcc
+#define BUS_FREE_TIMING			0xd4
+#define BUS_I3C_MST_FREE(x)		((x) & GENMASK(15, 0))
+
+#define BUS_IDLE_TIMING			0xd8
+#define I3C_VER_ID			0xe0
+#define I3C_VER_TYPE			0xe4
+#define EXTENDED_CAPABILITY		0xe8
+#define SLAVE_CONFIG			0xec
+
+#define MR_SEL_MASTER_REQUEST		BIT(1)
+#define IBI_SIR_REQ_REJECT_ALL		GENMASK(31, 0)
+#define MR_REQ_REJECT_NACK		BIT(1)
+
+#define DEV_ADDR_TABLE_LEGACY_I2C_DEV	BIT(31)
+#define DEV_ADDR_TABLE_STATIC_ADDR(x)	((x) & GENMASK(6, 0))
+#define DEV_ADDR_TABLE_DYNAMIC_ADDR(x)	(((x) << 16) & GENMASK(23, 16))
+#define DEV_ADDR_TABLE_LOC(start, idx)	((start) + ((idx) << 2))
+
+#define MAX_DEVS 32
+
+#define I3C_BUS_SDR1_SCL_RATE		8000000
+#define I3C_BUS_SDR2_SCL_RATE		6000000
+#define I3C_BUS_SDR3_SCL_RATE		4000000
+#define I3C_BUS_SDR4_SCL_RATE		2000000
+#define I3C_BUS_THIGH_MAX_NS		41
+#define I3C_BUS_I2C_FMP_TLOW_MIN_NS	500
+#define I3C_BUS_I2C_FM_TLOW_MIN_NS	1300
+
+#define XFER_TIMEOUT (msecs_to_jiffies(1000))
+
+struct dw_i3c_master_caps {
+	u8 cmdfifodepth;
+	u8 datafifodepth;
+};
+
+struct dw_i3c_cmd {
+	u32 cmd_lo;
+	u32 cmd_hi;
+	u16 tx_len;
+	const void *tx_buf;
+	u16 rx_len;
+	void *rx_buf;
+	u8 error;
+};
+
+struct dw_i3c_xfer {
+	struct list_head node;
+	struct completion comp;
+	int ret;
+	unsigned int ncmds;
+	struct dw_i3c_cmd cmds[0];
+};
+
+struct dw_i3c_master {
+	struct i3c_master_controller base;
+	u16 maxdevs;
+	u16 datstartaddr;
+	u32 free_pos;
+	struct {
+		struct list_head list;
+		struct dw_i3c_xfer *cur;
+		spinlock_t lock;
+	} xferqueue;
+	struct dw_i3c_master_caps caps;
+	void __iomem *regs;
+	struct reset_control *core_rst;
+	struct clk *core_clk;
+	char version[5];
+	char type[5];
+	u8 addrs[MAX_DEVS];
+};
+
+struct dw_i3c_i2c_dev_data {
+	u8 index;
+};
+
+static bool dw_i3c_master_supports_ccc_cmd(struct i3c_master_controller *m,
+					   const struct i3c_ccc_cmd *cmd)
+{
+	if (cmd->ndests > 1)
+		return false;
+
+	switch (cmd->id) {
+	case I3C_CCC_ENEC(true):
+	case I3C_CCC_ENEC(false):
+	case I3C_CCC_DISEC(true):
+	case I3C_CCC_DISEC(false):
+	case I3C_CCC_ENTAS(0, true):
+	case I3C_CCC_ENTAS(0, false):
+	case I3C_CCC_RSTDAA(true):
+	case I3C_CCC_RSTDAA(false):
+	case I3C_CCC_ENTDAA:
+	case I3C_CCC_SETMWL(true):
+	case I3C_CCC_SETMWL(false):
+	case I3C_CCC_SETMRL(true):
+	case I3C_CCC_SETMRL(false):
+	case I3C_CCC_DEFSLVS:
+	case I3C_CCC_ENTHDR(0):
+	case I3C_CCC_SETDASA:
+	case I3C_CCC_SETNEWDA:
+	case I3C_CCC_GETMWL:
+	case I3C_CCC_GETMRL:
+	case I3C_CCC_GETPID:
+	case I3C_CCC_GETBCR:
+	case I3C_CCC_GETDCR:
+	case I3C_CCC_GETSTATUS:
+	case I3C_CCC_GETMXDS:
+	case I3C_CCC_GETHDRCAP:
+		return true;
+	default:
+		break;
+	}
+
+	return false;
+}
+
+static inline struct dw_i3c_master *
+to_dw_i3c_master(struct i3c_master_controller *master)
+{
+	return container_of(master, struct dw_i3c_master, base);
+}
+
+static void dw_i3c_master_disable(struct dw_i3c_master *master)
+{
+	writel(readl(master->regs + DEVICE_CTRL) & DEV_CTRL_ENABLE,
+	       master->regs + DEVICE_CTRL);
+}
+
+static void dw_i3c_master_enable(struct dw_i3c_master *master)
+{
+	writel(readl(master->regs + DEVICE_CTRL) | DEV_CTRL_ENABLE,
+	       master->regs + DEVICE_CTRL);
+}
+
+static int dw_i3c_master_get_addr_pos(struct dw_i3c_master *master, u8 addr)
+{
+	int pos;
+
+	for (pos = 0; pos < master->maxdevs; pos++) {
+		if (addr == master->addrs[pos])
+			return pos;
+	}
+
+	return -EINVAL;
+}
+
+static int dw_i3c_master_get_free_pos(struct dw_i3c_master *master)
+{
+	if (!(master->free_pos & GENMASK(master->maxdevs - 1, 0)))
+		return -ENOSPC;
+
+	return ffs(master->free_pos) - 1;
+}
+
+static void dw_i3c_master_wr_tx_fifo(struct dw_i3c_master *master,
+				     const u8 *bytes, int nbytes)
+{
+	int i, j;
+
+	for (i = 0; i < nbytes; i += 4) {
+		u32 data = 0;
+
+		for (j = 0; j < 4 && (i + j) < nbytes; j++)
+			data |= (u32)bytes[i + j] << (j * 8);
+
+		writel(data, master->regs + RX_TX_DATA_PORT);
+	}
+}
+
+static void dw_i3c_master_read_rx_fifo(struct dw_i3c_master *master,
+				       u8 *bytes, int nbytes)
+{
+	int i, j;
+
+	for (i = 0; i < nbytes; i += 4) {
+		u32 data;
+
+		data = readl(master->regs + RX_TX_DATA_PORT);
+
+		for (j = 0; j < 4 && (i + j) < nbytes; j++)
+			bytes[i + j] = data >> (j * 8);
+	}
+}
+
+static struct dw_i3c_xfer *
+dw_i3c_master_alloc_xfer(struct dw_i3c_master *master, unsigned int ncmds)
+{
+	struct dw_i3c_xfer *xfer;
+
+	xfer = kzalloc(sizeof(*xfer) + (ncmds * sizeof(*xfer->cmds)),
+			     GFP_KERNEL);
+	if (!xfer)
+		return NULL;
+
+	INIT_LIST_HEAD(&xfer->node);
+	xfer->ncmds = ncmds;
+	xfer->ret = -ETIMEDOUT;
+
+	return xfer;
+}
+
+static void dw_i3c_master_free_xfer(struct dw_i3c_xfer *xfer)
+{
+	kfree(xfer);
+}
+
+static void dw_i3c_master_start_xfer_locked(struct dw_i3c_master *master)
+{
+	struct dw_i3c_xfer *xfer = master->xferqueue.cur;
+	unsigned int i;
+	u32 r;
+
+	if (!xfer)
+		return;
+
+	for (i = 0; i < xfer->ncmds; i++) {
+		struct dw_i3c_cmd *cmd = &xfer->cmds[i];
+
+		dw_i3c_master_wr_tx_fifo(master, cmd->tx_buf, cmd->tx_len);
+	}
+
+	r = readl(master->regs + QUEUE_THLD_CTRL);
+	r &= ~QUEUE_THLD_CTRL_RESP_BUF_MASK;
+	r |= QUEUE_THLD_CTRL_RESP_BUF(xfer->ncmds - 1);
+	writel(r, master->regs + QUEUE_THLD_CTRL);
+
+	for (i = 0; i < xfer->ncmds; i++) {
+		struct dw_i3c_cmd *cmd = &xfer->cmds[i];
+
+		writel(cmd->cmd_hi, master->regs + COMMAND_QUEUE_PORT);
+		writel(cmd->cmd_lo, master->regs + COMMAND_QUEUE_PORT);
+	}
+}
+
+static void dw_i3c_master_enqueue_xfer(struct dw_i3c_master *master,
+				       struct dw_i3c_xfer *xfer)
+{
+	unsigned long flags;
+
+	init_completion(&xfer->comp);
+	spin_lock_irqsave(&master->xferqueue.lock, flags);
+	if (master->xferqueue.cur) {
+		list_add_tail(&xfer->node, &master->xferqueue.list);
+	} else {
+		master->xferqueue.cur = xfer;
+		dw_i3c_master_start_xfer_locked(master);
+	}
+	spin_unlock_irqrestore(&master->xferqueue.lock, flags);
+}
+
+static void dw_i3c_master_dequeue_xfer(struct dw_i3c_master *master,
+				       struct dw_i3c_xfer *xfer)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&master->xferqueue.lock, flags);
+	if (master->xferqueue.cur == xfer) {
+		u32 status;
+
+		master->xferqueue.cur = NULL;
+
+		writel(RESET_CTRL_RX_FIFO | RESET_CTRL_TX_FIFO |
+		       RESET_CTRL_RESP_QUEUE | RESET_CTRL_CMD_QUEUE,
+		       master->regs + RESET_CTRL);
+
+		readl_poll_timeout_atomic(master->regs + RESET_CTRL, status,
+					  !status, 10, 1000000);
+	} else {
+		list_del_init(&xfer->node);
+	}
+	spin_unlock_irqrestore(&master->xferqueue.lock, flags);
+}
+
+static void dw_i3c_master_end_xfer_locked(struct dw_i3c_master *master, u32 isr)
+{
+	struct dw_i3c_xfer *xfer = master->xferqueue.cur;
+	int i, ret = 0;
+	u32 nresp;
+
+	if (!xfer)
+		return;
+
+	nresp = readl(master->regs + QUEUE_STATUS_LEVEL);
+	nresp = QUEUE_STATUS_LEVEL_RESP(nresp);
+
+	for (i = 0; i < nresp; i++) {
+		struct dw_i3c_cmd *cmd;
+		u32 resp;
+
+		resp = readl(master->regs + RESPONSE_QUEUE_PORT);
+
+		cmd = &xfer->cmds[RESPONSE_PORT_TID(resp)];
+		cmd->rx_len = RESPONSE_PORT_DATA_LEN(resp);
+		cmd->error = RESPONSE_PORT_ERR_STATUS(resp);
+		if (cmd->rx_len && !cmd->error)
+			dw_i3c_master_read_rx_fifo(master, cmd->rx_buf,
+						   cmd->rx_len);
+	}
+
+	for (i = 0; i < nresp; i++) {
+		switch (xfer->cmds[i].error) {
+		case RESPONSE_NO_ERROR:
+			break;
+		case RESPONSE_ERROR_PARITY:
+		case RESPONSE_ERROR_IBA_NACK:
+		case RESPONSE_ERROR_TRANSF_ABORT:
+		case RESPONSE_ERROR_CRC:
+		case RESPONSE_ERROR_FRAME:
+			ret = -EIO;
+			break;
+		case RESPONSE_ERROR_OVER_UNDER_FLOW:
+			ret = -ENOSPC;
+			break;
+		case RESPONSE_ERROR_I2C_W_NACK_ERR:
+		case RESPONSE_ERROR_ADDRESS_NACK:
+		default:
+			ret = -EINVAL;
+			break;
+		}
+	}
+
+	xfer->ret = ret;
+	complete(&xfer->comp);
+
+	if (ret < 0) {
+		dw_i3c_master_dequeue_xfer(master, xfer);
+		writel(readl(master->regs + DEVICE_CTRL) | DEV_CTRL_RESUME,
+		       master->regs + DEVICE_CTRL);
+	}
+
+	xfer = list_first_entry_or_null(&master->xferqueue.list,
+					      struct dw_i3c_xfer,
+					      node);
+	if (xfer)
+		list_del_init(&xfer->node);
+
+	master->xferqueue.cur = xfer;
+	dw_i3c_master_start_xfer_locked(master);
+}
+
+static void dw_i3c_master_dev_set_info(struct dw_i3c_master *master,
+				       struct i3c_device_info *info)
+{
+	u32 r;
+
+	memset(info, 0, sizeof(*info));
+
+	r = readl(master->regs + DEVICE_ADDR);
+	info->dyn_addr = (r >> 16) & I3C_MAX_ADDR;
+
+	r = readl(master->regs + SLV_CHAR_CTRL);
+	info->dcr = r;
+	info->bcr = r >> 8;
+	info->hdr_cap = r >> 16;
+	info->pid = (u64)readl(master->regs + SLV_PID_VALUE);
+}
+
+static int dw_i3c_clk_cfg(struct dw_i3c_master *master)
+{
+	unsigned long core_rate, core_period;
+	u8 hcnt, lcnt;
+	u32 r;
+
+
+	core_rate = clk_get_rate(master->core_clk);
+	if (!core_rate)
+		return -EINVAL;
+
+	core_period = DIV_ROUND_UP(1000000000, core_rate);
+
+	hcnt = DIV_ROUND_UP(I3C_BUS_THIGH_MAX_NS, core_period) - 1;
+	if (hcnt < SCL_I3C_TIMING_CNT_MIN)
+		hcnt = SCL_I3C_TIMING_CNT_MIN;
+
+	lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_TYP_I3C_SCL_RATE) - hcnt;
+	if (lcnt < SCL_I3C_TIMING_CNT_MIN)
+		lcnt = SCL_I3C_TIMING_CNT_MIN;
+
+	r = SCL_I3C_TIMING_HCNT(hcnt) | SCL_I3C_TIMING_LCNT(lcnt);
+	writel(r, master->regs + SCL_I3C_PP_TIMING);
+
+	if (!(readl(master->regs + DEVICE_CTRL) & DEV_CTRL_I2C_SLAVE_PRESENT))
+		writel(BUS_I3C_MST_FREE(lcnt), master->regs + BUS_FREE_TIMING);
+
+	lcnt = DIV_ROUND_UP(I3C_BUS_TLOW_OD_MIN_NS, core_period);
+	r = SCL_I3C_TIMING_HCNT(hcnt) | SCL_I3C_TIMING_LCNT(lcnt);
+	writel(r, master->regs + SCL_I3C_OD_TIMING);
+
+	lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_SDR1_SCL_RATE) - hcnt;
+	r = SCL_EXT_LCNT_1(lcnt);
+	lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_SDR2_SCL_RATE) - hcnt;
+	r |= SCL_EXT_LCNT_2(lcnt);
+	lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_SDR3_SCL_RATE) - hcnt;
+	r |= SCL_EXT_LCNT_3(lcnt);
+	lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_SDR4_SCL_RATE) - hcnt;
+	r |= SCL_EXT_LCNT_4(lcnt);
+	writel(r, master->regs + SCL_EXT_LCNT_TIMING);
+
+	return 0;
+}
+
+static int dw_i2c_clk_cfg(struct dw_i3c_master *master)
+{
+	unsigned long core_rate, core_period;
+	u16 hcnt, lcnt;
+	u32 r;
+
+	core_rate = clk_get_rate(master->core_clk);
+	if (!core_rate)
+		return -EINVAL;
+
+	core_period = DIV_ROUND_UP(1000000000, core_rate);
+
+	lcnt = DIV_ROUND_UP(I3C_BUS_I2C_FMP_TLOW_MIN_NS, core_period);
+	hcnt = DIV_ROUND_UP(core_rate, I3C_BUS_I2C_FM_PLUS_SCL_RATE) - lcnt;
+	r = SCL_I2C_FMP_TIMING_HCNT(hcnt) | SCL_I2C_FMP_TIMING_LCNT(lcnt);
+	writel(r, master->regs + SCL_I2C_FMP_TIMING);
+
+	lcnt = DIV_ROUND_UP(I3C_BUS_I2C_FM_TLOW_MIN_NS, core_period);
+	hcnt = DIV_ROUND_UP(core_rate, I3C_BUS_I2C_FM_SCL_RATE) - lcnt;
+	r = SCL_I2C_FM_TIMING_HCNT(hcnt) | SCL_I2C_FM_TIMING_LCNT(lcnt);
+	writel(r, master->regs + SCL_I2C_FM_TIMING);
+	writel(BUS_I3C_MST_FREE(lcnt), master->regs + BUS_FREE_TIMING);
+
+	return 0;
+}
+
+static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
+{
+	struct dw_i3c_master *master = to_dw_i3c_master(m);
+	struct i3c_device_info info = { };
+	u32 r;
+	int ret;
+
+	switch (m->bus->mode) {
+	case I3C_BUS_MODE_MIXED_FAST:
+		r = readl(master->regs + DEVICE_CTRL);
+		r |= DEV_CTRL_I2C_SLAVE_PRESENT;
+		writel(r, master->regs + DEVICE_CTRL);
+		ret = dw_i2c_clk_cfg(master);
+		if (ret)
+			return ret;
+	case I3C_BUS_MODE_PURE:
+		ret = dw_i3c_clk_cfg(master);
+		if (ret)
+			return ret;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = readl(master->regs + QUEUE_THLD_CTRL);
+	ret &= ~QUEUE_THLD_CTRL_RESP_BUF_MASK;
+	writel(ret, master->regs + QUEUE_THLD_CTRL);
+
+	ret = readl(master->regs + DATA_BUFFER_THLD_CTRL);
+	ret &= ~DATA_BUFFER_THLD_CTRL_RX_BUF;
+	writel(ret, master->regs + DATA_BUFFER_THLD_CTRL);
+
+	writel(INTR_ALL, master->regs + INTR_STATUS);
+	r = INTR_RESP_READY_STAT | INTR_TRANSFER_ERR_STAT;
+	writel(r, master->regs + INTR_STATUS_EN);
+	writel(r, master->regs + INTR_SIGNAL_EN);
+
+	r = i3c_master_get_free_addr(m, 0);
+	if (r < 0)
+		return r;
+
+	r = DEV_ADDR_DYNAMIC_ADDR_VALID | DEV_ADDR_DYNAMIC(r);
+	writel(r, master->regs + DEVICE_ADDR);
+
+	dw_i3c_master_dev_set_info(master, &info);
+
+	if (info.bcr & I3C_BCR_HDR_CAP)
+		info.hdr_cap = I3C_CCC_HDR_MODE(I3C_HDR_DDR);
+
+	ret = i3c_master_set_info(&master->base, &info);
+	if (ret)
+		return ret;
+
+	writel(IBI_SIR_REQ_REJECT_ALL, master->regs + IBI_SIR_REQ_REJECT);
+
+	r = readl(master->regs + DEVICE_CTRL);
+	r |= DEV_CTRL_HOT_JOIN;
+	writel(r, master->regs + DEVICE_CTRL);
+
+	dw_i3c_master_enable(master);
+
+	return 0;
+}
+
+static void dw_i3c_master_bus_cleanup(struct i3c_master_controller *m)
+{
+	struct dw_i3c_master *master = to_dw_i3c_master(m);
+
+	dw_i3c_master_disable(master);
+}
+
+
+static int dw_i3c_ccc_set(struct dw_i3c_master *master,
+			  struct i3c_ccc_cmd *ccc)
+{
+	struct dw_i3c_xfer *xfer;
+	struct dw_i3c_cmd *cmd;
+	int ret, pos = 0;
+
+	if (ccc->id & I3C_CCC_DIRECT) {
+		pos = dw_i3c_master_get_addr_pos(master, ccc->dests[0].addr);
+		if (pos < 0)
+			return pos;
+	}
+
+	xfer = dw_i3c_master_alloc_xfer(master, 1);
+	if (!xfer)
+		return -ENOMEM;
+
+	cmd = xfer->cmds;
+	cmd->tx_buf = ccc->dests[0].payload.data;
+	cmd->tx_len = ccc->dests[0].payload.len;
+
+	cmd->cmd_hi = COMMAND_PORT_ARG_DATA_LEN(ccc->dests[0].payload.len) |
+		      COMMAND_PORT_TRANSFER_ARG;
+
+	cmd->cmd_lo = COMMAND_PORT_CP |
+		      COMMAND_PORT_DEV_INDEX(pos) |
+		      COMMAND_PORT_CMD(ccc->id) |
+		      COMMAND_PORT_TOC |
+		      COMMAND_PORT_ROC;
+
+	dw_i3c_master_enqueue_xfer(master, xfer);
+	if (!wait_for_completion_timeout(&xfer->comp, XFER_TIMEOUT))
+		dw_i3c_master_dequeue_xfer(master, xfer);
+
+	ret = xfer->ret;
+	if (xfer->cmds[0].error == RESPONSE_ERROR_IBA_NACK)
+		ccc->err = I3C_ERROR_M2;
+
+	dw_i3c_master_free_xfer(xfer);
+
+	return ret;
+}
+
+static int dw_i3c_ccc_get(struct dw_i3c_master *master, struct i3c_ccc_cmd *ccc)
+{
+	struct dw_i3c_xfer *xfer;
+	struct dw_i3c_cmd *cmd;
+	int ret, pos;
+
+	pos = dw_i3c_master_get_addr_pos(master, ccc->dests[0].addr);
+	if (pos < 0)
+		return pos;
+
+	xfer = dw_i3c_master_alloc_xfer(master, 1);
+	if (!xfer)
+		return -ENOMEM;
+
+	cmd = xfer->cmds;
+	cmd->rx_buf = ccc->dests[0].payload.data;
+	cmd->rx_len = ccc->dests[0].payload.len;
+
+	cmd->cmd_hi = COMMAND_PORT_ARG_DATA_LEN(ccc->dests[0].payload.len) |
+		      COMMAND_PORT_TRANSFER_ARG;
+
+	cmd->cmd_lo = COMMAND_PORT_READ_TRANSFER |
+		      COMMAND_PORT_CP |
+		      COMMAND_PORT_DEV_INDEX(pos) |
+		      COMMAND_PORT_CMD(ccc->id) |
+		      COMMAND_PORT_TOC |
+		      COMMAND_PORT_ROC;
+
+	dw_i3c_master_enqueue_xfer(master, xfer);
+	if (!wait_for_completion_timeout(&xfer->comp, XFER_TIMEOUT))
+		dw_i3c_master_dequeue_xfer(master, xfer);
+
+	ret = xfer->ret;
+	if (xfer->cmds[0].error == RESPONSE_ERROR_IBA_NACK)
+		ccc->err = I3C_ERROR_M2;
+	dw_i3c_master_free_xfer(xfer);
+
+	return ret;
+}
+
+static int dw_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
+				      struct i3c_ccc_cmd *ccc)
+{
+	struct dw_i3c_master *master = to_dw_i3c_master(m);
+	int ret = 0;
+
+	if (ccc->id == I3C_CCC_ENTDAA)
+		return -EINVAL;
+
+	if (ccc->rnw)
+		ret = dw_i3c_ccc_get(master, ccc);
+	else
+		ret = dw_i3c_ccc_set(master, ccc);
+
+	return ret;
+}
+
+static int dw_i3c_master_daa(struct i3c_master_controller *m)
+{
+	struct dw_i3c_master *master = to_dw_i3c_master(m);
+	struct dw_i3c_xfer *xfer;
+	struct dw_i3c_cmd *cmd;
+	u32 olddevs, newdevs;
+	u8 p, last_addr = 0;
+	int ret, pos;
+
+	/* For now we don't support HJ */
+	if (m->init_done)
+		return -EPERM;
+
+	olddevs = ~(master->free_pos);
+
+	/* Prepare DAT before launching DAA. */
+	for (pos = 0; pos < master->maxdevs; pos++) {
+		if (olddevs & BIT(pos))
+			continue;
+
+		ret = i3c_master_get_free_addr(m, last_addr + 1);
+		if (ret < 0)
+			return -ENOSPC;
+		master->addrs[pos] = ret;
+		p = (ret >> 6) ^ (ret >> 5) ^ (ret >> 4) ^ (ret >> 3) ^
+		    (ret >> 2) ^ (ret >> 1) ^ ret ^ 1;
+		p = p & 1;
+		last_addr = ret;
+		ret |= (p << 7);
+
+		writel(DEV_ADDR_TABLE_DYNAMIC_ADDR(ret),
+		       master->regs +
+		       DEV_ADDR_TABLE_LOC(master->datstartaddr, pos));
+	}
+
+	xfer = dw_i3c_master_alloc_xfer(master, 1);
+	if (!xfer)
+		return -ENOMEM;
+
+	pos = dw_i3c_master_get_free_pos(master);
+	cmd = &xfer->cmds[0];
+	cmd->cmd_hi = 0x1;
+	cmd->cmd_lo = COMMAND_PORT_DEV_COUNT(master->maxdevs - pos) |
+		      COMMAND_PORT_DEV_INDEX(pos) |
+		      COMMAND_PORT_CMD(I3C_CCC_ENTDAA) |
+		      COMMAND_PORT_ADDR_ASSGN_CMD |
+		      COMMAND_PORT_TOC |
+		      COMMAND_PORT_ROC;
+
+	dw_i3c_master_enqueue_xfer(master, xfer);
+	if (!wait_for_completion_timeout(&xfer->comp, XFER_TIMEOUT))
+		dw_i3c_master_dequeue_xfer(master, xfer);
+
+	newdevs = GENMASK(master->maxdevs - cmd->rx_len - 1, 0);
+	newdevs &= ~olddevs;
+
+	for (pos = 0; pos < master->maxdevs; pos++) {
+		if (newdevs & BIT(pos))
+			i3c_master_add_i3c_dev_locked(m, master->addrs[pos]);
+	}
+
+	dw_i3c_master_free_xfer(xfer);
+
+	i3c_master_disec_locked(m, I3C_BROADCAST_ADDR,
+				I3C_CCC_EVENT_HJ |
+				I3C_CCC_EVENT_MR |
+				I3C_CCC_EVENT_SIR);
+
+	return 0;
+}
+
+static int dw_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
+				    struct i3c_priv_xfer *i3c_xfers,
+				    int i3c_nxfers)
+{
+	struct dw_i3c_i2c_dev_data *data = i3c_dev_get_master_data(dev);
+	struct i3c_master_controller *m = i3c_dev_get_master(dev);
+	struct dw_i3c_master *master = to_dw_i3c_master(m);
+	unsigned int nrxwords = 0, ntxwords = 0;
+	struct dw_i3c_xfer *xfer;
+	int i, ret = 0;
+
+	if (!i3c_nxfers)
+		return 0;
+
+	if (i3c_nxfers > master->caps.cmdfifodepth)
+		return -ENOTSUPP;
+
+	for (i = 0; i < i3c_nxfers; i++) {
+		if (i3c_xfers[i].len > COMMAND_PORT_ARG_DATA_LEN_MAX)
+			return -ENOTSUPP;
+	}
+
+	for (i = 0; i < i3c_nxfers; i++) {
+		if (i3c_xfers[i].rnw)
+			nrxwords += DIV_ROUND_UP(i3c_xfers[i].len, 4);
+		else
+			ntxwords += DIV_ROUND_UP(i3c_xfers[i].len, 4);
+	}
+
+	if (ntxwords > master->caps.datafifodepth ||
+	    nrxwords > master->caps.datafifodepth)
+		return -ENOTSUPP;
+
+	xfer = dw_i3c_master_alloc_xfer(master, i3c_nxfers);
+	if (!xfer)
+		return -ENOMEM;
+
+	for (i = 0; i < i3c_nxfers; i++) {
+		struct dw_i3c_cmd *cmd = &xfer->cmds[i];
+
+		cmd->cmd_hi = COMMAND_PORT_ARG_DATA_LEN(i3c_xfers[i].len) |
+			COMMAND_PORT_TRANSFER_ARG;
+
+		if (i3c_xfers[i].rnw) {
+			cmd->rx_buf = i3c_xfers[i].data.in;
+			cmd->rx_len = i3c_xfers[i].len;
+			cmd->cmd_lo = COMMAND_PORT_READ_TRANSFER |
+				      COMMAND_PORT_SPEED(dev->info.max_read_ds);
+
+		} else {
+			cmd->tx_buf = i3c_xfers[i].data.out;
+			cmd->tx_len = i3c_xfers[i].len;
+			cmd->cmd_lo =
+				COMMAND_PORT_SPEED(dev->info.max_write_ds);
+		}
+
+		cmd->cmd_lo |= COMMAND_PORT_TID(i) |
+			       COMMAND_PORT_DEV_INDEX(data->index) |
+			       COMMAND_PORT_ROC;
+
+		if (i == (i3c_nxfers - 1))
+			cmd->cmd_lo |= COMMAND_PORT_TOC;
+	}
+
+	dw_i3c_master_enqueue_xfer(master, xfer);
+	if (!wait_for_completion_timeout(&xfer->comp, XFER_TIMEOUT))
+		dw_i3c_master_dequeue_xfer(master, xfer);
+
+	ret = xfer->ret;
+	dw_i3c_master_free_xfer(xfer);
+
+	return ret;
+}
+
+static int dw_i3c_master_reattach_i3c_dev(struct i3c_dev_desc *dev,
+					  u8 old_dyn_addr)
+{
+	struct dw_i3c_i2c_dev_data *data = i3c_dev_get_master_data(dev);
+	struct i3c_master_controller *m = i3c_dev_get_master(dev);
+	struct dw_i3c_master *master = to_dw_i3c_master(m);
+
+	writel(DEV_ADDR_TABLE_DYNAMIC_ADDR(dev->info.dyn_addr),
+	       master->regs +
+	       DEV_ADDR_TABLE_LOC(master->datstartaddr, data->index));
+
+	if (!old_dyn_addr)
+		return 0;
+
+	master->addrs[data->index] = dev->info.dyn_addr;
+
+	return 0;
+}
+
+static int dw_i3c_master_attach_i3c_dev(struct i3c_dev_desc *dev)
+{
+	struct i3c_master_controller *m = i3c_dev_get_master(dev);
+	struct dw_i3c_master *master = to_dw_i3c_master(m);
+	struct dw_i3c_i2c_dev_data *data;
+	int pos;
+
+	pos = dw_i3c_master_get_free_pos(master);
+	if (pos < 0)
+		return pos;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->index = pos;
+	master->addrs[pos] = dev->info.dyn_addr;
+	master->free_pos &= ~BIT(pos);
+	i3c_dev_set_master_data(dev, data);
+
+	writel(DEV_ADDR_TABLE_DYNAMIC_ADDR(dev->info.dyn_addr),
+	       master->regs +
+	       DEV_ADDR_TABLE_LOC(master->datstartaddr, data->index));
+
+	return 0;
+}
+
+static void dw_i3c_master_detach_i3c_dev(struct i3c_dev_desc *dev)
+{
+	struct dw_i3c_i2c_dev_data *data = i3c_dev_get_master_data(dev);
+	struct i3c_master_controller *m = i3c_dev_get_master(dev);
+	struct dw_i3c_master *master = to_dw_i3c_master(m);
+
+	writel(NULL,
+	       master->regs +
+	       DEV_ADDR_TABLE_LOC(master->datstartaddr, data->index));
+
+	i3c_dev_set_master_data(dev, NULL);
+	master->addrs[data->index] = 0;
+	master->free_pos |= BIT(data->index);
+	kfree(data);
+}
+
+static int dw_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
+				   const struct i2c_msg *i2c_xfers,
+				   int i2c_nxfers)
+{
+	struct dw_i3c_i2c_dev_data *data = i2c_dev_get_master_data(dev);
+	struct i3c_master_controller *m = i2c_dev_get_master(dev);
+	struct dw_i3c_master *master = to_dw_i3c_master(m);
+	unsigned int nrxwords = 0, ntxwords = 0;
+	struct dw_i3c_xfer *xfer;
+	int i, ret = 0;
+
+	if (!i2c_nxfers)
+		return 0;
+
+	if (i2c_nxfers > master->caps.cmdfifodepth)
+		return -ENOTSUPP;
+
+	for (i = 0; i < i2c_nxfers; i++) {
+		if (i2c_xfers[i].len > COMMAND_PORT_ARG_DATA_LEN_MAX)
+			return -ENOTSUPP;
+	}
+
+	for (i = 0; i < i2c_nxfers; i++) {
+		if (i2c_xfers[i].flags & I2C_M_RD)
+			nrxwords += DIV_ROUND_UP(i2c_xfers[i].len, 4);
+		else
+			ntxwords += DIV_ROUND_UP(i2c_xfers[i].len, 4);
+	}
+
+	if (ntxwords > master->caps.datafifodepth ||
+	    nrxwords > master->caps.datafifodepth)
+		return -ENOTSUPP;
+
+	xfer = dw_i3c_master_alloc_xfer(master, i2c_nxfers);
+	if (!xfer)
+		return -ENOMEM;
+
+	for (i = 0; i < i2c_nxfers; i++) {
+		struct dw_i3c_cmd *cmd = &xfer->cmds[i];
+
+		cmd->cmd_hi = COMMAND_PORT_ARG_DATA_LEN(i2c_xfers[i].len) |
+			COMMAND_PORT_TRANSFER_ARG;
+
+		cmd->cmd_lo = COMMAND_PORT_TID(i) |
+			      COMMAND_PORT_DEV_INDEX(data->index) |
+			      COMMAND_PORT_ROC;
+
+		if (i2c_xfers[i].flags & I2C_M_RD) {
+			cmd->cmd_lo |= COMMAND_PORT_READ_TRANSFER;
+			cmd->rx_buf = i2c_xfers[i].buf;
+			cmd->rx_len = i2c_xfers[i].len;
+		} else {
+			cmd->tx_buf = i2c_xfers[i].buf;
+			cmd->tx_len = i2c_xfers[i].len;
+		}
+
+		if (i == (i2c_nxfers - 1))
+			cmd->cmd_lo |= COMMAND_PORT_TOC;
+	}
+
+	dw_i3c_master_enqueue_xfer(master, xfer);
+	if (!wait_for_completion_timeout(&xfer->comp, XFER_TIMEOUT))
+		dw_i3c_master_dequeue_xfer(master, xfer);
+
+	ret = xfer->ret;
+	dw_i3c_master_free_xfer(xfer);
+
+	return ret;
+}
+
+static int dw_i3c_master_attach_i2c_dev(struct i2c_dev_desc *dev)
+{
+	struct i3c_master_controller *m = i2c_dev_get_master(dev);
+	struct dw_i3c_master *master = to_dw_i3c_master(m);
+	struct dw_i3c_i2c_dev_data *data;
+	int pos;
+
+	pos = dw_i3c_master_get_free_pos(master);
+
+	if (pos < 0)
+		return pos;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	master->addrs[pos] = dev->boardinfo->base.addr;
+	data->index = pos;
+	master->free_pos &= ~BIT(pos);
+	i2c_dev_set_master_data(dev, data);
+
+	writel(DEV_ADDR_TABLE_LEGACY_I2C_DEV |
+	       DEV_ADDR_TABLE_STATIC_ADDR(dev->boardinfo->base.addr),
+	       master->regs +
+	       DEV_ADDR_TABLE_LOC(master->datstartaddr, data->index));
+
+	return 0;
+}
+
+static void dw_i3c_master_detach_i2c_dev(struct i2c_dev_desc *dev)
+{
+	struct dw_i3c_i2c_dev_data *data = i2c_dev_get_master_data(dev);
+	struct i3c_master_controller *m = i2c_dev_get_master(dev);
+	struct dw_i3c_master *master = to_dw_i3c_master(m);
+
+	writel(NULL,
+	       master->regs +
+	       DEV_ADDR_TABLE_LOC(master->datstartaddr, data->index));
+
+	i2c_dev_set_master_data(dev, NULL);
+	master->addrs[data->index] = 0;
+	master->free_pos |= BIT(data->index);
+	kfree(data);
+}
+
+static u32 dw_i3c_master_i2c_funcs(struct i3c_master_controller *m)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+static irqreturn_t dw_i3c_master_irq_handler(int irq, void *dev_id)
+{
+	struct dw_i3c_master *master = dev_id;
+	u32 status;
+
+	status = readl(master->regs + INTR_STATUS);
+
+	if (!(status & readl(master->regs + INTR_STATUS_EN))) {
+		writel(INTR_ALL, master->regs + INTR_STATUS);
+		return IRQ_NONE;
+	}
+
+	spin_lock(&master->xferqueue.lock);
+	dw_i3c_master_end_xfer_locked(master, status);
+	if (status | INTR_TRANSFER_ERR_STAT)
+		writel(INTR_TRANSFER_ERR_STAT, master->regs + INTR_STATUS);
+	spin_unlock(&master->xferqueue.lock);
+
+	return IRQ_HANDLED;
+}
+
+static const struct i3c_master_controller_ops dw_mipi_i3c_ops = {
+	.bus_init = dw_i3c_master_bus_init,
+	.bus_cleanup = dw_i3c_master_bus_cleanup,
+	.attach_i3c_dev = dw_i3c_master_attach_i3c_dev,
+	.reattach_i3c_dev = dw_i3c_master_reattach_i3c_dev,
+	.detach_i3c_dev = dw_i3c_master_detach_i3c_dev,
+	.do_daa = dw_i3c_master_daa,
+	.supports_ccc_cmd = dw_i3c_master_supports_ccc_cmd,
+	.send_ccc_cmd = dw_i3c_master_send_ccc_cmd,
+	.priv_xfers = dw_i3c_master_priv_xfers,
+	.attach_i2c_dev = dw_i3c_master_attach_i2c_dev,
+	.detach_i2c_dev = dw_i3c_master_detach_i2c_dev,
+	.i2c_xfers = dw_i3c_master_i2c_xfers,
+	.i2c_funcs = dw_i3c_master_i2c_funcs,
+};
+
+static int dw_i3c_probe(struct platform_device *pdev)
+{
+	struct dw_i3c_master *master;
+	struct resource *res;
+	int ret, irq;
+
+	master = devm_kzalloc(&pdev->dev, sizeof(*master), GFP_KERNEL);
+	if (!master)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	master->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(master->regs))
+		return PTR_ERR(master->regs);
+
+	master->core_clk = devm_clk_get(&pdev->dev, "core_clk");
+	if (IS_ERR(master->core_clk))
+		return PTR_ERR(master->core_clk);
+
+	master->core_rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
+								    "core_rst");
+	if (IS_ERR(master->core_rst))
+		return PTR_ERR(master->core_rst);
+
+	ret = clk_prepare_enable(master->core_clk);
+	if (ret)
+		goto err_disable_core_clk;
+
+	reset_control_deassert(master->core_rst);
+
+	spin_lock_init(&master->xferqueue.lock);
+	INIT_LIST_HEAD(&master->xferqueue.list);
+
+	writel(INTR_ALL, master->regs + INTR_STATUS);
+	irq = platform_get_irq(pdev, 0);
+	ret = devm_request_irq(&pdev->dev, irq,
+			       dw_i3c_master_irq_handler, 0,
+			       dev_name(&pdev->dev), master);
+	if (ret)
+		goto err_assert_rst;
+
+	platform_set_drvdata(pdev, master);
+
+	ret = readl(master->regs + QUEUE_STATUS_LEVEL);
+	master->caps.cmdfifodepth = QUEUE_STATUS_LEVEL_CMD(ret);
+
+	ret = readl(master->regs + DATA_BUFFER_STATUS_LEVEL);
+	master->caps.datafifodepth = DATA_BUFFER_STATUS_LEVEL_TX(ret);
+
+	ret = readl(master->regs + DEVICE_ADDR_TABLE_POINTER);
+	master->datstartaddr = ret;
+	master->maxdevs = ret >> 16;
+	master->free_pos = GENMASK(master->maxdevs - 1, 0);
+
+	/* read controller version */
+	ret = readl(master->regs + I3C_VER_ID);
+	master->version[0] = (char)(ret >> 24);
+	master->version[1] = '.';
+	master->version[2] = (char)(ret >> 16);
+	master->version[3] = (char)(ret >> 8);
+	master->version[4] = '\0';
+
+	/* read controller type */
+	ret = readl(master->regs + I3C_VER_TYPE);
+	master->type[0] = (char)(ret >> 24);
+	master->type[1] = (char)(ret >> 16);
+	master->type[2] = (char)(ret >> 8);
+	master->type[3] = (char) ret;
+	master->type[4] = '\0';
+
+	ret = i3c_master_register(&master->base, &pdev->dev,
+				  &dw_mipi_i3c_ops, false);
+	if (ret)
+		goto err_assert_rst;
+
+	dev_info(&pdev->dev, "Synopsys DW MIPI I3C Master: version %s-%s\n",
+		 master->version, master->type);
+
+	return 0;
+
+err_assert_rst:
+	reset_control_assert(master->core_rst);
+
+err_disable_core_clk:
+	clk_disable_unprepare(master->core_clk);
+
+	return ret;
+}
+
+static int dw_i3c_remove(struct platform_device *pdev)
+{
+	struct dw_i3c_master *master = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = i3c_master_unregister(&master->base);
+	if (ret)
+		return ret;
+
+	reset_control_assert(master->core_rst);
+
+	clk_disable_unprepare(master->core_clk);
+
+	return 0;
+}
+
+static const struct of_device_id dw_i3c_master_of_match[] = {
+	{ .compatible = "snps,dw-i3c-master", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, dw_i3c_master_of_match);
+
+static struct platform_driver dw_i3c_driver = {
+	.probe = dw_i3c_probe,
+	.remove = dw_i3c_remove,
+	.driver = {
+		.name = "dw-i3c-master",
+		.of_match_table = of_match_ptr(dw_i3c_master_of_match),
+	},
+};
+module_platform_driver(dw_i3c_driver);
+
+MODULE_AUTHOR("Vitor Soares <soares@synopsys.com>");
+MODULE_DESCRIPTION("DesignWare MIPI I3C driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4


