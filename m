Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56568C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12DF42082D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Tp5QD9Hq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12DF42082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbeLET3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:29:11 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60202 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbeLET2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:28:42 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB5JSXop100809;
        Wed, 5 Dec 2018 13:28:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544038113;
        bh=I/s90mL01aYnuWIGpBKciyr5pXoaM7YviM39doBo7xw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Tp5QD9HqsZfV6PEzSaSsSsyLpdPYzh56Y8Pa+srQywJMGW1byoQlw6iyvzqP44XYZ
         aJRRmWBQe6T8Aw+tjFLGCzbkQy0R0LdyXL0qAKVzM9DwvWFuqXGMvTOjXnFW/D/qvT
         1ZGu8FVHz/h1elLfut23xl9wTs8Vp5T5UgyXAPeA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB5JSXvK086486
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Dec 2018 13:28:33 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 5
 Dec 2018 13:28:33 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 5 Dec 2018 13:28:33 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB5JSXal022250;
        Wed, 5 Dec 2018 13:28:33 -0600
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.72.36])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id wB5JSWU29752;
        Wed, 5 Dec 2018 13:28:32 -0600 (CST)
From:   Dan Murphy <dmurphy@ti.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [[RFC] PATCH v2 1/4] can: m_can: Create a m_can platform framework
Date:   Wed, 5 Dec 2018 13:28:22 -0600
Message-ID: <20181205192825.11555-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20181205192825.11555-1-dmurphy@ti.com>
References: <20181205192825.11555-1-dmurphy@ti.com>
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
 drivers/net/can/m_can/m_can_platform.c | 168 +++++++++++++++++++++++++
 drivers/net/can/m_can/m_can_platform.h | 100 +++++++++++++++
 2 files changed, 268 insertions(+)
 create mode 100644 drivers/net/can/m_can/m_can_platform.c
 create mode 100644 drivers/net/can/m_can/m_can_platform.h

diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
new file mode 100644
index 000000000000..261846f9c4e8
--- /dev/null
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -0,0 +1,168 @@
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
+static int m_can_plat_probe(struct platform_device *pdev)
+{
+	struct m_can_classdev *mcan_class;
+	struct net_device *dev;
+	struct m_can_priv *priv;
+	struct resource *res;
+	void __iomem *addr;
+	void __iomem *mram_addr;
+	int irq, ret = 0;
+
+	mcan_class = m_can_core_allocate_dev(&pdev->dev);
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
+	mcan_class->net->irq = irq;
+	mcan_class->pm_clock_support = 1;
+	mcan_class->mram_base = mram_addr;
+	mcan_class->can.clock.freq = clk_get_rate(mcan_class->cclk);
+	mcan_class->dev = &pdev->dev;
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
+static void unregister_m_can_dev(struct net_device *dev)
+{
+	unregister_candev(dev);
+}
+
+static int m_can_plat_remove(struct platform_device *pdev)
+{
+	struct net_device *dev = platform_get_drvdata(pdev);
+
+	unregister_m_can_dev(dev);
+
+	pm_runtime_disable(&pdev->dev);
+
+	platform_set_drvdata(pdev, NULL);
+
+	free_candev(dev);
+
+	return 0;
+}
+
+static int __maybe_unused m_can_runtime_suspend(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct m_can_classdev *priv = netdev_priv(ndev);
+
+	clk_disable_unprepare(priv->cclk);
+	clk_disable_unprepare(priv->hclk);
+
+	return 0;
+}
+
+static int __maybe_unused m_can_runtime_resume(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct m_can_classdev *priv = netdev_priv(ndev);
+	int err;
+
+	err = clk_prepare_enable(priv->hclk);
+	if (err)
+		return err;
+
+	err = clk_prepare_enable(priv->cclk);
+	if (err)
+		clk_disable_unprepare(priv->hclk);
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
index 000000000000..2a83aff323e9
--- /dev/null
+++ b/drivers/net/can/m_can/m_can_platform.h
@@ -0,0 +1,100 @@
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
+/* address offset and element number for each FIFO/Buffer in the Message RAM */
+struct mram_cfg {
+	u16 off;
+	u8  num;
+};
+
+struct m_can_classdev {
+	struct can_priv can;
+	struct napi_struct napi;
+	struct net_device *net;
+	struct device *dev;
+	struct clk *hclk;
+	struct clk *cclk;
+
+	void *device_data;
+
+	int version;
+	int freq;
+	u32 irqstatus;
+
+	u32 (*m_can_read) (const struct m_can_classdev *m_can_class, int reg);
+	int (*m_can_write) (const struct m_can_classdev *m_can_class, int reg, int val);
+	u32 (*m_can_fifo_read) (const struct m_can_classdev *m_can_class, int reg);
+	int (*m_can_fifo_write) (const struct m_can_classdev *m_can_class, int reg, int val);
+	u32 (*m_can_txe_fifo_read) (const struct m_can_classdev *m_can_class);
+
+	/* Memory mapped ip */
+	void __iomem *base;
+	void __iomem *mram_addr;
+	void __iomem *mram_base;
+
+	/* Register based ip */
+	int reg_offset;
+	int mram_start;
+	int pm_clock_support;
+
+	struct mram_cfg mcfg[MRAM_CFG_NUM];
+};
+
+struct m_can_classdev *m_can_core_allocate_dev(struct device *dev);
+int m_can_core_register(struct m_can_classdev *m_can_dev);
+int m_can_core_get_clocks(struct m_can_classdev *m_can_dev);
+void m_can_init_ram(struct m_can_classdev *priv);
+void m_can_config_endisable(const struct m_can_classdev *priv, bool enable);
+
+int m_can_core_suspend(struct device *dev);
+int m_can_core_resume(struct device *dev);
+
+#endif	/* _CAN_M_CAN_CORE_H_ */
-- 
2.20.0.rc2.7.g965798d1f2

