Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62889ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140B2214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wv1qwSHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140B2214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbeIQUSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:18:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbeIQUSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:18:16 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED46320685;
        Mon, 17 Sep 2018 14:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537195836;
        bh=jUvDLLpo6Q2mVbm9iL0cEuigOyXfqebKw0iZ32LvzXY=;
        h=From:To:Cc:Subject:Date:From;
        b=Wv1qwSHC6yGhnrADT/jCiLy/TdYk14xJYIqcdxRawHLhtVj/6J8r89QMkt3LHh+hF
         4admxhzOFxFa0iOOjlVhOSxqvbJu4A8SM0eSFB0Rq95zdSaRryv5Nazqu/29nnS5Kf
         LPRQzW8unGNK0U7+MjZyBLB6rXGvU4gLDnLfws5k=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     p.zabel@pengutronix.de
Cc:     dinguyen@kernel.org, marex@denx.de, linux-kernel@vger.kernel.org
Subject: [PATCH] reset: socfpga: add an early reset driver for SoCFPGA
Date:   Mon, 17 Sep 2018 09:50:30 -0500
Message-Id: <1537195830-25759-1-git-send-email-dinguyen@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a separate reset driver that uses the reset operations in reset-simple.
The reset driver for the SoCFPGA platform needs to register early in order to
be able bring online timers that needed early in the kernel bootup.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm/mach-socfpga/socfpga.c |  4 ++
 drivers/reset/Kconfig           |  7 ++++
 drivers/reset/Makefile          |  1 +
 drivers/reset/reset-simple.c    | 17 ---------
 drivers/reset/reset-socfpga.c   | 85 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 97 insertions(+), 17 deletions(-)
 create mode 100644 drivers/reset/reset-socfpga.c

diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index dde14f7..cc64576 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -32,6 +32,8 @@ void __iomem *rst_manager_base_addr;
 void __iomem *sdr_ctl_base_addr;
 unsigned long socfpga_cpu1start_addr;
 
+extern void __init socfpga_reset_init(void);
+
 void __init socfpga_sysmgr_init(void)
 {
 	struct device_node *np;
@@ -64,6 +66,7 @@ static void __init socfpga_init_irq(void)
 
 	if (IS_ENABLED(CONFIG_EDAC_ALTERA_OCRAM))
 		socfpga_init_ocram_ecc();
+	socfpga_reset_init();
 }
 
 static void __init socfpga_arria10_init_irq(void)
@@ -74,6 +77,7 @@ static void __init socfpga_arria10_init_irq(void)
 		socfpga_init_arria10_l2_ecc();
 	if (IS_ENABLED(CONFIG_EDAC_ALTERA_OCRAM))
 		socfpga_init_arria10_ocram_ecc();
+	socfpga_reset_init();
 }
 
 static void socfpga_cyclone5_restart(enum reboot_mode mode, const char *cmd)
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 13d28fd..dcc5f1d 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -119,6 +119,13 @@ config RESET_STM32MP157
 	help
 	  This enables the RCC reset controller driver for STM32 MPUs.
 
+config RESET_SOCFPGA
+	bool "SoCFPGA Reset Driver" if COMPILE_TEST && !ARCH_SOCFPGA
+	default ARCH_SOCFPGA
+	select RESET_SIMPLE
+	help
+	  This enables the reset driver for SoCFPGA.
+
 config RESET_SUNXI
 	bool "Allwinner SoCs Reset Driver" if COMPILE_TEST && !ARCH_SUNXI
 	default ARCH_SUNXI
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 4243c38..d09bb41 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
 obj-$(CONFIG_RESET_QCOM_AOSS) += reset-qcom-aoss.o
 obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
 obj-$(CONFIG_RESET_STM32MP157) += reset-stm32mp1.o
+obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
 obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index a91107f..483824f 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -106,21 +106,12 @@ struct reset_simple_devdata {
 	bool status_active_low;
 };
 
-#define SOCFPGA_NR_BANKS	8
-
-static const struct reset_simple_devdata reset_simple_socfpga = {
-	.reg_offset = 0x10,
-	.nr_resets = SOCFPGA_NR_BANKS * 32,
-	.status_active_low = true,
-};
-
 static const struct reset_simple_devdata reset_simple_active_low = {
 	.active_low = true,
 	.status_active_low = true,
 };
 
 static const struct of_device_id reset_simple_dt_ids[] = {
-	{ .compatible = "altr,rst-mgr", .data = &reset_simple_socfpga },
 	{ .compatible = "st,stm32-rcc", },
 	{ .compatible = "allwinner,sun6i-a31-clock-reset",
 		.data = &reset_simple_active_low },
@@ -166,14 +157,6 @@ static int reset_simple_probe(struct platform_device *pdev)
 		data->status_active_low = devdata->status_active_low;
 	}
 
-	if (of_device_is_compatible(dev->of_node, "altr,rst-mgr") &&
-	    of_property_read_u32(dev->of_node, "altr,modrst-offset",
-				 &reg_offset)) {
-		dev_warn(dev,
-			 "missing altr,modrst-offset property, assuming 0x%x!\n",
-			 reg_offset);
-	}
-
 	data->membase += reg_offset;
 
 	return devm_reset_controller_register(dev, &data->rcdev);
diff --git a/drivers/reset/reset-socfpga.c b/drivers/reset/reset-socfpga.c
new file mode 100644
index 0000000..b6e8fe8
--- /dev/null
+++ b/drivers/reset/reset-socfpga.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier:	GPL-2.0
+/*
+ * Copyright (C) 2018, Intel Corporation
+ * Copied from reset-sunxi.c
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include "reset-simple.h"
+
+static int a10_reset_init(struct device_node *np)
+{
+	struct reset_simple_data *data;
+	struct resource res;
+	resource_size_t size;
+	int ret;
+	u32 reg_offset = 0;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret)
+		goto err_alloc;
+
+	size = resource_size(&res);
+	if (!request_mem_region(res.start, size, np->name)) {
+		ret = -EBUSY;
+		goto err_alloc;
+	}
+
+	data->membase = ioremap(res.start, size);
+	if (!data->membase) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
+
+	if (of_property_read_u32(np, "altr,modrst-offset", &reg_offset))
+		pr_warn("missing altr,modrst-offset property, assuming 0x0\n");
+	data->membase += reg_offset;
+
+	spin_lock_init(&data->lock);
+
+	data->rcdev.owner = THIS_MODULE;
+	data->rcdev.nr_resets = 32 * 8;
+	data->rcdev.ops = &reset_simple_ops;
+	data->rcdev.of_node = np;
+	data->status_active_low = true;
+
+	return reset_controller_register(&data->rcdev);
+
+err_alloc:
+	kfree(data);
+	return ret;
+};
+
+/*
+ * These are the reset controller we need to initialize early on in
+ * our system, before we can even think of using a regular device
+ * driver for it.
+ * The controllers that we can register through the regular device
+ * model are handled by the simple reset driver directly.
+ */
+static const struct of_device_id socfpga_early_reset_dt_ids[] __initconst = {
+	{ .compatible = "altr,rst-mgr", },
+	{ /* sentinel */ },
+};
+
+void __init socfpga_reset_init(void)
+{
+	struct device_node *np;
+
+	for_each_matching_node(np, socfpga_early_reset_dt_ids)
+		a10_reset_init(np);
+}
-- 
2.7.4

