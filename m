Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C110C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538BA20866
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eb5kffd4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 538BA20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbeKFF1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:27:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:43924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbeKFF1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:27:19 -0500
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1089620862;
        Mon,  5 Nov 2018 20:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541448358;
        bh=Y5JACExMv79VJVRCpXhi/r+MmJ+63RxSPrbO7UKYkXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eb5kffd4R7qJUQy0i0AqkOseh5Jh364g47nW0/hTX3X13KCZL2RKNYAPnU6wpSE45
         NPdaVKgDzJjshpj/IRtFfS8w6Z3THmBD2d6aRWUS6v4dQP1xSRKhjZcJrKKt724JH8
         DfKuJRhrMBAmOq8z6BiZxzC8ipZgGVhGdCwkTh4Y=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     p.zabel@pengutronix.de
Cc:     dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dinh Nguyen <dinh.nguyen@intel.com>
Subject: [PATCHv3 2/3] reset: socfpga: add an early reset driver for SoCFPGA
Date:   Mon,  5 Nov 2018 14:05:48 -0600
Message-Id: <20181105200549.17159-2-dinguyen@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181105200549.17159-1-dinguyen@kernel.org>
References: <20181105200549.17159-1-dinguyen@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinh Nguyen <dinh.nguyen@intel.com>

Create a separate reset driver that uses the reset operations in
reset-simple. The reset driver for the SoCFPGA platform needs to
register early in order to be able bring online timers that needed
early in the kernel bootup.

We do not need this early reset driver for Stratix10, because on
arm64, Linux does not need the timers are that in reset. Linux is
able to run just fine with the internal armv8 timer. Thus, we use
a new binding "altr,stratix10-rst-mgr" for the Stratix10 platform.
The Stratix10 platform will continue to use the reset-simple platform
driver, while the 32-bit platforms(Cyclone5/Arria5/Arria10) will use
the early reset driver.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v3: use "altr,stratix10-rst-mgr" for Stratix10
    remove "altr,modrst-offset" from reset-simple
v2: Do not build separate reset driver for STRATIX10
    fix warning: symbol 'socfpga_reset_init' was not declared. Should it be
    static?
---
 arch/arm/mach-socfpga/socfpga.c |  4 ++
 drivers/reset/Kconfig           |  9 +++-
 drivers/reset/Makefile          |  1 +
 drivers/reset/reset-simple.c    | 12 +----
 drivers/reset/reset-socfpga.c   | 88 +++++++++++++++++++++++++++++++++
 5 files changed, 103 insertions(+), 11 deletions(-)
 create mode 100644 drivers/reset/reset-socfpga.c

diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index dde14f7bf2c3..cc64576c102b 100644
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
index c21da9fe51ec..5d7a3ba445aa 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -109,7 +109,7 @@ config RESET_QCOM_PDC
 
 config RESET_SIMPLE
 	bool "Simple Reset Controller Driver" if COMPILE_TEST
-	default ARCH_SOCFPGA || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED
+	default ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED
 	help
 	  This enables a simple reset controller driver for reset lines that
 	  that can be asserted and deasserted by toggling bits in a contiguous,
@@ -128,6 +128,13 @@ config RESET_STM32MP157
 	help
 	  This enables the RCC reset controller driver for STM32 MPUs.
 
+config RESET_SOCFPGA
+	bool "SoCFPGA Reset Driver" if COMPILE_TEST && !ARCH_SOCFPGA
+	default ARCH_SOCFPGA && !ARCH_STRATIX10
+	select RESET_SIMPLE
+	help
+	  This enables the reset driver for SoCFPGA.
+
 config RESET_SUNXI
 	bool "Allwinner SoCs Reset Driver" if COMPILE_TEST && !ARCH_SUNXI
 	default ARCH_SUNXI
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index d08e8b90046a..b14de32eb610 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_RESET_QCOM_AOSS) += reset-qcom-aoss.o
 obj-$(CONFIG_RESET_QCOM_PDC) += reset-qcom-pdc.o
 obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
 obj-$(CONFIG_RESET_STM32MP157) += reset-stm32mp1.o
+obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
 obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index a91107fc9e27..f2e7a8c1be65 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -109,7 +109,7 @@ struct reset_simple_devdata {
 #define SOCFPGA_NR_BANKS	8
 
 static const struct reset_simple_devdata reset_simple_socfpga = {
-	.reg_offset = 0x10,
+	.reg_offset = 0x20,
 	.nr_resets = SOCFPGA_NR_BANKS * 32,
 	.status_active_low = true,
 };
@@ -120,7 +120,7 @@ static const struct reset_simple_devdata reset_simple_active_low = {
 };
 
 static const struct of_device_id reset_simple_dt_ids[] = {
-	{ .compatible = "altr,rst-mgr", .data = &reset_simple_socfpga },
+	{ .compatible = "altr,stratix10-rst-mgr","altr,rst-mgr", .data = &reset_simple_socfpga },
 	{ .compatible = "st,stm32-rcc", },
 	{ .compatible = "allwinner,sun6i-a31-clock-reset",
 		.data = &reset_simple_active_low },
@@ -166,14 +166,6 @@ static int reset_simple_probe(struct platform_device *pdev)
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
index 000000000000..b92769861d2b
--- /dev/null
+++ b/drivers/reset/reset-socfpga.c
@@ -0,0 +1,88 @@
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
+#define SOCFPGA_NR_BANKS	8
+void __init socfpga_reset_init(void);
+
+static int a10_reset_init(struct device_node *np)
+{
+	struct reset_simple_data *data;
+	struct resource res;
+	resource_size_t size;
+	int ret;
+	u32 reg_offset = 0x10;
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
+		pr_warn("missing altr,modrst-offset property, assuming 0x10\n");
+	data->membase += reg_offset;
+
+	spin_lock_init(&data->lock);
+
+	data->rcdev.owner = THIS_MODULE;
+	data->rcdev.nr_resets = SOCFPGA_NR_BANKS * 32;
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
2.17.1

