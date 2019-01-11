Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F77EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8EB20870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SYNnmP2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387651AbfAKRdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:33:01 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39046 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfAKRdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:33:00 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0BHWoDD058990;
        Fri, 11 Jan 2019 11:32:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547227970;
        bh=35zNAGmNCNYEddiuGTAFxArY2Vw3CIk+zxN2uV+5F0U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SYNnmP2Ii4ALcVifTWHF3+BRtv/dfOfo99dFtAXrckrn0R+uqviikOWgQ4+zzsNku
         F6zacOH+cLi7v7qQUDQtY5ebX3Q4OwsxID0Mbn/a5gpwbFpbAF+TLzrttUQ4pjA9ag
         vRif/r80o9mAZPsxoD4dZWKAvpQrd7FDYnpyMA2E=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0BHWoIn117196
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 11:32:50 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 11
 Jan 2019 11:32:50 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 11 Jan 2019 11:32:50 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0BHWoVf019861;
        Fri, 11 Jan 2019 11:32:50 -0600
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.88.224])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x0BHWnU03636;
        Fri, 11 Jan 2019 11:32:49 -0600 (CST)
From:   Dan Murphy <dmurphy@ti.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <b29396@freescale.com>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v3 1/4] can: m_can: Create a m_can platform framework
Date:   Fri, 11 Jan 2019 11:32:33 -0600
Message-ID: <20190111173236.14329-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20190111173236.14329-1-dmurphy@ti.com>
References: <20190111173236.14329-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a m_can platform framework that peripherial
devices can register to and use common code and register sets.
The peripherial devices may provide read/write and configuration
support of the IP.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/net/can/m_can/m_can.c          |   6 +
 drivers/net/can/m_can/m_can_platform.c | 212 +++++++++++++++++++++++++
 drivers/net/can/m_can/m_can_platform.h | 163 +++++++++++++++++++
 3 files changed, 381 insertions(+)
 create mode 100644 drivers/net/can/m_can/m_can_platform.c
 create mode 100644 drivers/net/can/m_can/m_can_platform.h

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 9b449400376b..f817b28582e9 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -414,6 +414,9 @@ static inline void m_can_config_endisable(const struct m_can_priv *priv,
 	u32 timeout = 10;
 	u32 val = 0;
 
+	if (cccr & CCCR_CSR)
+		cccr &= ~CCCR_CSR;
+
 	if (enable) {
 		/* enable m_can configuration */
 		m_can_write(priv, M_CAN_CCCR, cccr | CCCR_INIT);
@@ -1155,6 +1158,9 @@ static void m_can_chip_config(struct net_device *dev)
 	m_can_set_bittiming(dev);
 
 	m_can_config_endisable(priv, false);
+
+	if (priv->device_init)
+		priv->device_init(priv);
 }
 
 static void m_can_start(struct net_device *dev)
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
new file mode 100644
index 000000000000..7b9dc147da9f
--- /dev/null
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -0,0 +1,212 @@
+/*
+ * CAN bus driver for Bosch M_CAN controller
+ *
+ * Copyright (C) 2014 Freescale Semiconductor, Inc.
+ *	Dong Aisheng <b29396@freescale.com>
+ *
+ * Bosch M_CAN user manual can be obtained from:
+ * http://www.bosch-semiconductors.de/media/pdf_1/ipmodules_1/m_can/
+ * mcan_users_manual_v302.pdf
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/can/dev.h>
+#include <linux/pinctrl/consumer.h>
+
+#include "m_can_platform.h"
+
+struct m_can_plat_priv {
+	void __iomem *base;
+	void __iomem *mram_base;
+};
+
+static u32 iomap_read_reg(struct m_can_classdev *m_can_class, int reg)
+{
+	struct m_can_plat_priv *priv = (struct m_can_plat_priv *)m_can_class->device_data;
+
+	return readl(priv->base + reg);
+}
+
+static u32 iomap_read_fifo(struct m_can_classdev *m_can_class, int addr_offset)
+{
+	struct m_can_plat_priv *priv = (struct m_can_plat_priv *)m_can_class->device_data;
+
+	return readl(priv->mram_base + addr_offset);
+}
+
+static int iomap_write_reg(struct m_can_classdev *m_can_class, int reg, int val)
+{
+	struct m_can_plat_priv *priv = (struct m_can_plat_priv *)m_can_class->device_data;
+
+	writel(val, priv->base + reg);
+
+	return 0;
+}
+
+static int iomap_write_fifo(struct m_can_classdev *m_can_class, int addr_offset, int val)
+{
+	struct m_can_plat_priv *priv = (struct m_can_plat_priv *)m_can_class->device_data;
+
+	writel(val, priv->base + addr_offset);
+
+	return 0;
+}
+
+static int m_can_plat_probe(struct platform_device *pdev)
+{
+	struct m_can_classdev *mcan_class;
+	struct m_can_plat_priv *priv;
+	struct resource *res;
+	void __iomem *addr;
+	void __iomem *mram_addr;
+	int irq, ret = 0;
+
+	mcan_class = m_can_core_allocate_dev(&pdev->dev);
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	m_can_core_get_clocks(mcan_class);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "m_can");
+	addr = devm_ioremap_resource(&pdev->dev, res);
+	irq = platform_get_irq_byname(pdev, "int0");
+	if (IS_ERR(addr) || irq < 0) {
+		ret = -EINVAL;
+		goto failed_ret;
+	}
+
+	/* message ram could be shared */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "message_ram");
+	if (!res) {
+		ret = -ENODEV;
+		goto failed_ret;
+	}
+
+	mram_addr = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!mram_addr) {
+		ret = -ENOMEM;
+		goto failed_ret;
+	}
+
+	priv->base = addr;
+	priv->mram_base = mram_addr;
+
+	mcan_class->net->irq = irq;
+	mcan_class->pm_clock_support = 1;
+	mcan_class->can.clock.freq = clk_get_rate(mcan_class->cclk);
+	mcan_class->dev = &pdev->dev;
+
+	mcan_class->read_reg = &iomap_read_reg;
+	mcan_class->write_reg = &iomap_write_reg;
+	mcan_class->write_fifo = &iomap_write_fifo;
+	mcan_class->read_fifo = &iomap_read_fifo;
+	mcan_class->is_peripherial = false;
+
+	platform_set_drvdata(pdev, mcan_class->dev);
+
+	m_can_init_ram(mcan_class);
+
+	m_can_core_register(mcan_class);
+
+failed_ret:
+/*	m_can_clk_stop(mcan_class);*/
+	if (ret) {
+		pm_runtime_disable(&pdev->dev);
+		free_candev(mcan_class->net);
+	}
+	return ret;
+}
+
+static __maybe_unused int m_can_suspend(struct device *dev)
+{
+	return m_can_core_suspend(dev);
+}
+
+static __maybe_unused int m_can_resume(struct device *dev)
+{
+	return m_can_core_resume(dev);
+}
+
+static int m_can_plat_remove(struct platform_device *pdev)
+{
+	struct net_device *dev = platform_get_drvdata(pdev);
+	struct m_can_classdev *mcan_class = netdev_priv(dev);
+
+	m_can_core_unregister(mcan_class);
+
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static int __maybe_unused m_can_runtime_suspend(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct m_can_classdev *mcan_class = netdev_priv(ndev);
+
+	m_can_core_suspend(dev);
+
+	clk_disable_unprepare(mcan_class->cclk);
+	clk_disable_unprepare(mcan_class->hclk);
+
+	return 0;
+}
+
+static int __maybe_unused m_can_runtime_resume(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct m_can_classdev *mcan_class = netdev_priv(ndev);
+	int err;
+
+	err = clk_prepare_enable(mcan_class->hclk);
+	if (err)
+		return err;
+
+	err = clk_prepare_enable(mcan_class->cclk);
+	if (err)
+		clk_disable_unprepare(mcan_class->hclk);
+
+	m_can_core_resume(dev);
+
+	return err;
+}
+
+static const struct dev_pm_ops m_can_pmops = {
+	SET_RUNTIME_PM_OPS(m_can_runtime_suspend,
+			   m_can_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(m_can_suspend, m_can_resume)
+};
+
+static const struct of_device_id m_can_of_table[] = {
+	{ .compatible = "bosch,m_can", .data = NULL },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, m_can_of_table);
+
+static struct platform_driver m_can_plat_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = m_can_of_table,
+		.pm     = &m_can_pmops,
+	},
+	.probe = m_can_plat_probe,
+	.remove = m_can_plat_remove,
+};
+
+module_platform_driver(m_can_plat_driver);
+
+MODULE_AUTHOR("Dong Aisheng <b29396@freescale.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("CAN bus driver for Bosch M_CAN controller");
diff --git a/drivers/net/can/m_can/m_can_platform.h b/drivers/net/can/m_can/m_can_platform.h
new file mode 100644
index 000000000000..97e90dd79613
--- /dev/null
+++ b/drivers/net/can/m_can/m_can_platform.h
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+
+#ifndef _CAN_M_CAN_CORE_H_
+#define _CAN_M_CAN_CORE_H_
+
+#include <linux/can/core.h>
+#include <linux/can/led.h>
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/freezer.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/iopoll.h>
+#include <linux/can/dev.h>
+#include <linux/pinctrl/consumer.h>
+
+/* m_can lec values */
+enum m_can_lec_type {
+	LEC_NO_ERROR = 0,
+	LEC_STUFF_ERROR,
+	LEC_FORM_ERROR,
+	LEC_ACK_ERROR,
+	LEC_BIT1_ERROR,
+	LEC_BIT0_ERROR,
+	LEC_CRC_ERROR,
+	LEC_UNUSED,
+};
+
+enum m_can_mram_cfg {
+	MRAM_SIDF = 0,
+	MRAM_XIDF,
+	MRAM_RXF0,
+	MRAM_RXF1,
+	MRAM_RXB,
+	MRAM_TXE,
+	MRAM_TXB,
+	MRAM_CFG_NUM,
+};
+
+/* registers definition */
+enum m_can_reg {
+	M_CAN_CREL	= 0x0,
+	M_CAN_ENDN	= 0x4,
+	M_CAN_CUST	= 0x8,
+	M_CAN_DBTP	= 0xc,
+	M_CAN_TEST	= 0x10,
+	M_CAN_RWD	= 0x14,
+	M_CAN_CCCR	= 0x18,
+	M_CAN_NBTP	= 0x1c,
+	M_CAN_TSCC	= 0x20,
+	M_CAN_TSCV	= 0x24,
+	M_CAN_TOCC	= 0x28,
+	M_CAN_TOCV	= 0x2c,
+	M_CAN_ECR	= 0x40,
+	M_CAN_PSR	= 0x44,
+/* TDCR Register only available for version >=3.1.x */
+	M_CAN_TDCR	= 0x48,
+	M_CAN_IR	= 0x50,
+	M_CAN_IE	= 0x54,
+	M_CAN_ILS	= 0x58,
+	M_CAN_ILE	= 0x5c,
+	M_CAN_GFC	= 0x80,
+	M_CAN_SIDFC	= 0x84,
+	M_CAN_XIDFC	= 0x88,
+	M_CAN_XIDAM	= 0x90,
+	M_CAN_HPMS	= 0x94,
+	M_CAN_NDAT1	= 0x98,
+	M_CAN_NDAT2	= 0x9c,
+	M_CAN_RXF0C	= 0xa0,
+	M_CAN_RXF0S	= 0xa4,
+	M_CAN_RXF0A	= 0xa8,
+	M_CAN_RXBC	= 0xac,
+	M_CAN_RXF1C	= 0xb0,
+	M_CAN_RXF1S	= 0xb4,
+	M_CAN_RXF1A	= 0xb8,
+	M_CAN_RXESC	= 0xbc,
+	M_CAN_TXBC	= 0xc0,
+	M_CAN_TXFQS	= 0xc4,
+	M_CAN_TXESC	= 0xc8,
+	M_CAN_TXBRP	= 0xcc,
+	M_CAN_TXBAR	= 0xd0,
+	M_CAN_TXBCR	= 0xd4,
+	M_CAN_TXBTO	= 0xd8,
+	M_CAN_TXBCF	= 0xdc,
+	M_CAN_TXBTIE	= 0xe0,
+	M_CAN_TXBCIE	= 0xe4,
+	M_CAN_TXEFC	= 0xf0,
+	M_CAN_TXEFS	= 0xf4,
+	M_CAN_TXEFA	= 0xf8,
+};
+
+/* address offset and element number for each FIFO/Buffer in the Message RAM */
+struct mram_cfg {
+	u16 off;
+	u8  num;
+};
+
+struct m_can_classdev;
+
+typedef	int (*can_dev_init) (struct m_can_classdev *m_can_class);
+typedef	int (*can_clr_dev_interrupts) (struct m_can_classdev *m_can_class);
+typedef	u32 (*can_reg_read) (struct m_can_classdev *m_can_class, int reg);
+typedef	int (*can_reg_write) (struct m_can_classdev *m_can_class, int reg, int val);
+typedef	u32 (*can_fifo_read) (struct m_can_classdev *m_can_class, int addr_offset);
+typedef	int (*can_fifo_write) (struct m_can_classdev *m_can_class, int addr_offset, int val);
+
+struct m_can_classdev {
+	struct can_priv can;
+	struct napi_struct napi;
+	struct net_device *net;
+	struct device *dev;
+	struct clk *hclk;
+	struct clk *cclk;
+
+	struct workqueue_struct *wq;
+	struct work_struct tx_work;
+	struct sk_buff *skb;
+
+	struct can_bittiming_const *bit_timing;
+	struct can_bittiming_const *data_timing;
+
+	void *device_data;
+
+	/* Device specific call backs */
+	can_dev_init device_init;
+	can_clr_dev_interrupts clr_dev_interrupts;
+	can_reg_read read_reg;
+	can_reg_write write_reg;
+	can_fifo_read read_fifo;
+	can_fifo_write write_fifo;
+
+	int version;
+	int freq;
+	u32 irqstatus;
+
+	int pm_clock_support;
+	bool is_peripherial;
+
+	struct mram_cfg mcfg[MRAM_CFG_NUM];
+};
+
+struct m_can_classdev *m_can_core_allocate_dev(struct device *dev);
+int m_can_core_register(struct m_can_classdev *m_can_dev);
+void m_can_core_unregister(struct m_can_classdev *m_can_dev);
+int m_can_core_get_clocks(struct m_can_classdev *m_can_dev);
+void m_can_init_ram(struct m_can_classdev *priv);
+void m_can_config_endisable(const struct m_can_classdev *priv, bool enable);
+
+int m_can_core_suspend(struct device *dev);
+int m_can_core_resume(struct device *dev);
+#endif	/* _CAN_M_CAN_CORE_H_ */
-- 
2.20.1.98.gecbdaf0899

