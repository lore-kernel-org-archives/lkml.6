Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6E8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0074320672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rZjWOviQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0074320672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405569AbeKVWSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:18:35 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50380 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405550AbeKVWSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:18:34 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAMBdUt3075756;
        Thu, 22 Nov 2018 05:39:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542886771;
        bh=l8EaJ/3pWE8PUD6eVg1qaCX+cy1kmh/AyeShSjrRSRw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rZjWOviQifrFquBfPuMHTnLu5pSAlZGv7xJrKwgJ6EZTTtXXCPafD3bVWMaczi7Bx
         U1+3bls6I7y4dFuh6G0i1dLb785Oa5pzTuPRb3MJnHylIw61Kij3EE9pAQz1Ml9H6k
         wDsWYxubSWLsGLduFI5zOQVKXb4dSlsV+drKg4NM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAMBdU0R029349
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Nov 2018 05:39:30 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 22
 Nov 2018 05:39:30 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 22 Nov 2018 05:39:30 -0600
Received: from dlelxv97.itg.ti.com (dlelxv97.itg.ti.com [172.17.2.193])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAMBdUmR027293;
        Thu, 22 Nov 2018 05:39:30 -0600
Received: from localhost.localdomain (vboxa0400828d.dhcp.ti.com [172.22.239.63])
        by dlelxv97.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAMBdDf2013203;
        Thu, 22 Nov 2018 05:39:26 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <tony@atomide.com>
CC:     <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <rogerq@ti.com>
Subject: [PATCH 03/17] soc: ti: pruss: Add pruss_soc_bus platform driver
Date:   Thu, 22 Nov 2018 13:38:59 +0200
Message-ID: <1542886753-17625-4-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542886753-17625-1-git-send-email-rogerq@ti.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The Programmable Real-Time Unit - Industrial Communication
Subsystem (PRU-ICSS) is present of various TI SoCs such as
AM335x or AM437x or the Keystone 66AK2G. Each SoC can have
one or more PRUSS instances that may or may not be identical.
For example, AM335x SoCs have a single PRUSS, while AM437x has
two PRUSS instances PRUSS1 and PRUSS0, with the PRUSS0 being
a cut-down version of the PRUSS1.

The PRUSS consists of dual 32-bit RISC cores called the
Programmable Real-Time Units (PRUs), some shared, data and
instruction memories, some internal peripheral modules, and
an interrupt controller. The programmable nature of the PRUs
provide flexibility to implement custom peripheral interfaces,
fast real-time responses, or specialized data handling.

The PRU-ICSS functionality is achieved through four different
modules, each implementing a platform driver addressing a
specific portion of the PRUSS. Some sub-modules of the PRU-ICSS
IP reuse some of the existing drivers (like davinci mdio driver
or the generic syscon driver). The pruss_soc_bus driver deals
with the SoC integration aspects of the PRUSS IP(s) and manages
the common clock, reset and interconnect configuration and
creates the child PRUSS devices. The second pruss driver is
responsible for the creation and deletion of various platform
devices for the child PRU device and other child devices. A third
driver manages the PRUSS interrupt controller and implements an
irqchip driver to provide a Linux standard way of interrupt
management to PRU clients. The fourth platform driver is a
remoteproc driver and performs the individual PRU RISC cores
management. This design provides flexibility in representing
the different modules of PRUSS accordingly.

This patch introduces the first part i.e. pruss_soc_bus driver.
The driver currently supports the AM335x SoC.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/soc/ti/Kconfig         |  11 ++++
 drivers/soc/ti/Makefile        |   1 +
 drivers/soc/ti/pruss_soc_bus.c | 142 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+)
 create mode 100644 drivers/soc/ti/pruss_soc_bus.c

diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
index be4570b..d1ea6da 100644
--- a/drivers/soc/ti/Kconfig
+++ b/drivers/soc/ti/Kconfig
@@ -73,4 +73,15 @@ config TI_SCI_PM_DOMAINS
 	  called ti_sci_pm_domains. Note this is needed early in boot before
 	  rootfs may be available.
 
+config TI_PRUSS
+	tristate "TI PRU-ICSS Subsystem Platform drivers"
+	depends on SOC_AM33XX
+	default n
+	help
+	  TI PRU-ICSS Subsystem platform specific support.
+
+	  Say Y or M here to support the Programmable Realtime Unit (PRU)
+	  processors on various TI SoCs. It's safe to say N here if you're
+	  not interested in the PRU or if you are unsure.
+
 endif # SOC_TI
diff --git a/drivers/soc/ti/Makefile b/drivers/soc/ti/Makefile
index a22edc0..ac6b695 100644
--- a/drivers/soc/ti/Makefile
+++ b/drivers/soc/ti/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_KEYSTONE_NAVIGATOR_DMA)	+= knav_dma.o
 obj-$(CONFIG_AMX3_PM)			+= pm33xx.o
 obj-$(CONFIG_WKUP_M3_IPC)		+= wkup_m3_ipc.o
 obj-$(CONFIG_TI_SCI_PM_DOMAINS)		+= ti_sci_pm_domains.o
+obj-$(CONFIG_TI_PRUSS)			+= pruss_soc_bus.o
diff --git a/drivers/soc/ti/pruss_soc_bus.c b/drivers/soc/ti/pruss_soc_bus.c
new file mode 100644
index 0000000..16b4802
--- /dev/null
+++ b/drivers/soc/ti/pruss_soc_bus.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PRU-ICSS SoC bus driver for various TI SoCs
+ *
+ * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
+ *	Suman Anna <s-anna@ti.com>
+ *	Keerthy <j-keerthy@ti.com>
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+
+#include <linux/platform_data/ti-pruss.h>
+
+/**
+ * struct pruss_soc_bus - PRUSS SoC bus structure
+ * @syscfg: kernel mapped address for SYSCFG register
+ * @has_reset: cached variable for storing global module reset flag
+ */
+struct pruss_soc_bus {
+	void __iomem *syscfg;
+	bool has_reset;
+};
+
+/**
+ * struct pruss_soc_bus_match_data - PRUSS SoC bus driver match data
+ * @has_reset: flag to indicate the presence of global module reset
+ */
+struct pruss_soc_bus_match_data {
+	bool has_reset;
+};
+
+static int pruss_soc_bus_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	struct pruss_platform_data *pdata = dev_get_platdata(dev);
+	struct pruss_soc_bus *psoc_bus;
+	const struct pruss_soc_bus_match_data *data;
+	int ret;
+
+	psoc_bus = devm_kzalloc(dev, sizeof(*psoc_bus), GFP_KERNEL);
+	if (!psoc_bus)
+		return -ENOMEM;
+
+	psoc_bus->syscfg = of_iomap(node, 0);
+	if (!psoc_bus->syscfg)
+		return -ENOMEM;
+
+	data = of_device_get_match_data(dev);
+	if (!data) {
+		dev_err(dev, "missing match data\n");
+		return -ENODEV;
+	}
+
+	if (data->has_reset && (!pdata || !pdata->deassert_reset ||
+				!pdata->assert_reset || !pdata->reset_name)) {
+		dev_err(dev, "platform data (reset configuration information) missing\n");
+		return -ENODEV;
+	}
+	psoc_bus->has_reset = data->has_reset;
+	platform_set_drvdata(pdev, psoc_bus);
+
+	if (psoc_bus->has_reset) {
+		ret = pdata->deassert_reset(pdev, pdata->reset_name);
+		if (ret) {
+			dev_err(dev, "deassert_reset failed: %d\n", ret);
+			goto fail_reset;
+		}
+	}
+
+	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
+		goto fail_clock;
+	}
+
+	ret = of_platform_populate(node, NULL, NULL, dev);
+	if (ret)
+		goto fail_of;
+
+	return 0;
+
+fail_of:
+	pm_runtime_put_sync(dev);
+fail_clock:
+	pm_runtime_disable(dev);
+	if (psoc_bus->has_reset)
+		pdata->assert_reset(pdev, pdata->reset_name);
+fail_reset:
+	iounmap(psoc_bus->syscfg);
+	return ret;
+}
+
+static int pruss_soc_bus_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pruss_platform_data *pdata = dev_get_platdata(dev);
+	struct pruss_soc_bus *psoc_bus = platform_get_drvdata(pdev);
+
+	of_platform_depopulate(dev);
+
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+
+	if (psoc_bus->has_reset)
+		pdata->assert_reset(pdev, pdata->reset_name);
+	iounmap(psoc_bus->syscfg);
+
+	return 0;
+}
+
+/* instance-specific driver private data */
+static const struct pruss_soc_bus_match_data am335x_data = {
+	.has_reset = true,
+};
+
+static const struct of_device_id pruss_soc_bus_of_match[] = {
+	{ .compatible = "ti,am3356-pruss-soc-bus", .data = &am335x_data, },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, pruss_soc_bus_of_match);
+
+static struct platform_driver pruss_soc_bus_driver = {
+	.driver	= {
+		.name = "pruss-soc-bus",
+		.of_match_table = pruss_soc_bus_of_match,
+	},
+	.probe	= pruss_soc_bus_probe,
+	.remove	= pruss_soc_bus_remove,
+};
+module_platform_driver(pruss_soc_bus_driver);
+
+MODULE_AUTHOR("Suman Anna <s-anna@ti.com>");
+MODULE_AUTHOR("Keerthy <j-keerthy@ti.com>");
+MODULE_DESCRIPTION("PRU-ICSS SoC Bus Driver for TI SoCs");
+MODULE_LICENSE("GPL v2");
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

