Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2937C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35642186A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390375AbeLUAVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 19:21:22 -0500
Received: from mga03.intel.com ([134.134.136.65]:39339 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733019AbeLUAVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 19:21:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2018 16:21:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,379,1539673200"; 
   d="scan'208";a="112251076"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga003.jf.intel.com with ESMTP; 20 Dec 2018 16:21:19 -0800
From:   thor.thayer@linux.intel.com
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dinguyen@kernel.org, arnd@arndb.de, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com,
        peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com
Cc:     davem@davemloft.net, mcoquelin.stm32@gmail.com,
        mchehab+samsung@kernel.org, bjorn.andersson@linaro.org,
        olof@lixom.net, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCHv2 1/6] mfd: altera-sysmgr: Add SOCFPGA System Manager
Date:   Thu, 20 Dec 2018 18:23:17 -0600
Message-Id: <1545351802-4354-2-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545351802-4354-1-git-send-email-thor.thayer@linux.intel.com>
References: <1545351802-4354-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

The SOCFPGA System Manager register block aggregates different
peripheral functions into one area.
On 32 bit ARM parts, handle in the same way as syscon.
On 64 bit ARM parts, the System Manager can only be accessed by
EL3 secure mode. Since a SMC call to EL3 is required, this new
driver uses regmaps similar to syscon to handle the SMC call.

Since regmaps abstract out the underlying register access, the
changes to drivers accessing the System Manager are minimal.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
v2 Implement Arnd's changes.
   1. Change socfpga_is_s10() to check compatible string.
      Add new compatible string for Stratix10 in bindings
      and add proper detection method.
   2. Replace base cast with resource_size_t member.
   3. Change s10_sysmgr_regmap_cfg to altr_sysmgr_regmap_cfg to
      be generic.
   4. Always use 4 byte width.
   5. Initialize the .reg_read and .reg_write in S10 case only.
   6. Remove call to syscon in 32bit ARM case and handle both
      ARM32 and ARM64 in of_sysmgr_register().
   7. Replace IS_ERR_OR_NULL() with IS_ERR().
   8. Remove compatible check functions except phandle function.
---
 MAINTAINERS                       |   6 +
 drivers/mfd/Kconfig               |  10 ++
 drivers/mfd/Makefile              |   1 +
 drivers/mfd/altera-sysmgr.c       | 263 ++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/altera-sysmgr.h | 113 ++++++++++++++++
 5 files changed, 393 insertions(+)
 create mode 100644 drivers/mfd/altera-sysmgr.c
 create mode 100644 include/linux/mfd/altera-sysmgr.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f4855974f325..a6e997f6ea9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -707,6 +707,12 @@ L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-altera.c
 
+ALTERA SYSTEM MANAGER DRIVER
+M:	Thor Thayer <thor.thayer@linux.intel.com>
+S:	Maintained
+F:	drivers/mfd/altera-sysmgr.c
+F:	include/linux/mfd/altera-sysgmr.h
+
 ALTERA SYSTEM RESOURCE DRIVER FOR ARRIA10 DEVKIT
 M:	Thor Thayer <thor.thayer@linux.intel.com>
 S:	Maintained
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index f461460a2aeb..8629cf13520e 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -29,6 +29,16 @@ config MFD_ALTERA_A10SR
 	  accessing the external gpio extender (LEDs & buttons) and
 	  power supply alarms (hwmon).
 
+config MFD_ALTERA_SYSMGR
+	bool "Altera SOCFPGA System Manager"
+	depends on (ARCH_SOCFPGA || ARCH_STRATIX10) && OF
+	select MFD_SYSCON
+	help
+	  Select this to get System Manager support for all Altera branded
+	  SOCFPGAs. The SOCFPGA System Manager handles all SOCFPGAs by
+	  using regmap_mmio accesses for ARM32 parts and SMC calls to
+	  EL3 for ARM64 parts.
+
 config MFD_ACT8945A
 	tristate "Active-semi ACT8945A"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 12980a4ad460..c649f6efed5f 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -233,6 +233,7 @@ obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)	+= intel_soc_pmic_chtdc_ti.o
 obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
 
 obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
+obj-$(CONFIG_MFD_ALTERA_SYSMGR) += altera-sysmgr.o
 obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o
 
 obj-$(CONFIG_MFD_STM32_LPTIMER)	+= stm32-lptimer.o
diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c
new file mode 100644
index 000000000000..2dce15e71935
--- /dev/null
+++ b/drivers/mfd/altera-sysmgr.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2017-2018, Intel Corporation.
+ *  Copyright (C) 2012 Freescale Semiconductor, Inc.
+ *  Copyright (C) 2012 Linaro Ltd.
+ *
+ *  Based on syscon driver.
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/mfd/altera-sysmgr.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+/**
+ * struct altr_sysmgr - Altera SOCFPGA System Manager
+ * @regmap: the regmap used for System Manager accesses.
+ * @base  : the base address for the System Manager
+ */
+struct altr_sysmgr {
+	struct regmap   *regmap;
+	resource_size_t *base;
+};
+
+/**
+ * Only 1 instance of System Manager is needed but many
+ * consumers will want to access it with the matching
+ * functions below.
+ */
+static struct altr_sysmgr *p_sysmgr;
+
+/**
+ * s10_protected_reg_write
+ * Write to a protected SMC register.
+ * @base: Base address of System Manager
+ * @reg:  Address offset of register
+ * @val:  Value to write
+ * Return: INTEL_SIP_SMC_STATUS_OK (0) on success
+ *	   INTEL_SIP_SMC_REG_ERROR on error
+ *	   INTEL_SIP_SMC_RETURN_UNKNOWN_FUNCTION if not supported
+ */
+static int s10_protected_reg_write(void *base,
+				   unsigned int reg, unsigned int val)
+{
+	struct arm_smccc_res result;
+	unsigned long sysmgr_base = (unsigned long)base;
+
+	arm_smccc_smc(INTEL_SIP_SMC_REG_WRITE, sysmgr_base + reg,
+		      val, 0, 0, 0, 0, 0, &result);
+
+	return (int)result.a0;
+}
+
+/**
+ * s10_protected_reg_read
+ * Read the status of a protected SMC register
+ * @base: Base address of System Manager.
+ * @reg:  Address of register
+ * @val:  Value read.
+ * Return: INTEL_SIP_SMC_STATUS_OK (0) on success
+ *	   INTEL_SIP_SMC_REG_ERROR on error
+ *	   INTEL_SIP_SMC_RETURN_UNKNOWN_FUNCTION if not supported
+ */
+static int s10_protected_reg_read(void *base,
+				  unsigned int reg, unsigned int *val)
+{
+	struct arm_smccc_res result;
+	unsigned long sysmgr_base = (unsigned long)base;
+
+	arm_smccc_smc(INTEL_SIP_SMC_REG_READ, sysmgr_base + reg,
+		      0, 0, 0, 0, 0, 0, &result);
+
+	*val = (unsigned int)result.a1;
+
+	return (int)result.a0;
+}
+
+static struct regmap_config altr_sysmgr_regmap_cfg = {
+	.name = "altr_sysmgr",
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.fast_io = true,
+	.use_single_read = true,
+	.use_single_write = true,
+};
+
+/**
+ * socfpga_is_s10
+ * Determine if running on Stratix10 platform.
+ * Return: True if running Stratix10, otherwise false.
+ */
+static int socfpga_is_s10(struct device_node *np)
+{
+	return of_device_is_compatible(np, "altr,sys-mgr-s10");
+}
+
+/**
+ * of_sysmgr_register
+ * Create and register the Altera System Manager regmap.
+ * ARM32 is a mmio regmap while ARM64 needs a physical address
+ * for the SMC call.
+ * Return: Pointer to new sysmgr on success.
+ *         Pointer error on failure.
+ */
+static struct altr_sysmgr *of_sysmgr_register(struct device_node *np)
+{
+	struct altr_sysmgr *sysmgr;
+	struct regmap *regmap;
+	int ret;
+	struct regmap_config sysmgr_config = altr_sysmgr_regmap_cfg;
+	struct resource res;
+
+	if (!of_device_is_compatible(np, "altr,sys-mgr") &&
+	    !of_device_is_compatible(np, "altr,sys-mgr-s10"))
+		return ERR_PTR(-EINVAL);
+
+	sysmgr = kzalloc(sizeof(*sysmgr), GFP_KERNEL);
+	if (!sysmgr)
+		return ERR_PTR(-ENOMEM);
+
+	if (of_address_to_resource(np, 0, &res)) {
+		ret = -ENOMEM;
+		goto err_map;
+	}
+
+	sysmgr_config.max_register = resource_size(&res) -
+				     sysmgr_config.reg_stride;
+
+	if (socfpga_is_s10(np)) {
+		/* Need physical address for SMCC call */
+		sysmgr->base = (resource_size_t *)res.start;
+		sysmgr_config.reg_read = s10_protected_reg_read;
+		sysmgr_config.reg_write = s10_protected_reg_write;
+
+		regmap = regmap_init(NULL, NULL, sysmgr->base, &sysmgr_config);
+	} else {
+		sysmgr->base = ioremap(res.start, resource_size(&res));
+
+		if (!sysmgr->base) {
+			ret = -ENOMEM;
+			goto err_map;
+		}
+
+		regmap = regmap_init_mmio(NULL, sysmgr->base, &sysmgr_config);
+		if (IS_ERR(regmap))
+			iounmap(sysmgr->base);
+	}
+	if (IS_ERR(regmap)) {
+		pr_err("regmap init failed\n");
+		ret = PTR_ERR(regmap);
+		goto err_map;
+	}
+
+	sysmgr->regmap = regmap;
+
+	p_sysmgr = sysmgr;
+
+	return sysmgr;
+
+err_map:
+	kfree(sysmgr);
+	return ERR_PTR(ret);
+}
+
+struct regmap *altr_sysmgr_node_to_regmap(struct device_node *np)
+{
+	struct altr_sysmgr *sysmgr = NULL;
+
+	if (!p_sysmgr)
+		sysmgr = of_sysmgr_register(np);
+	else
+		sysmgr = p_sysmgr;
+
+	if (IS_ERR(sysmgr))
+		return ERR_CAST(sysmgr);
+
+	return sysmgr->regmap;
+}
+EXPORT_SYMBOL_GPL(altr_sysmgr_node_to_regmap);
+
+struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
+						    const char *property)
+{
+	struct device_node *sysmgr_np;
+	struct regmap *regmap;
+
+	if (property)
+		sysmgr_np = of_parse_phandle(np, property, 0);
+	else
+		sysmgr_np = np;
+
+	if (!sysmgr_np)
+		return ERR_PTR(-ENODEV);
+
+	regmap = altr_sysmgr_node_to_regmap(sysmgr_np);
+	of_node_put(sysmgr_np);
+
+	return regmap;
+}
+EXPORT_SYMBOL_GPL(altr_sysmgr_regmap_lookup_by_phandle);
+
+static int sysmgr_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct altr_sysmgr *sysmgr;
+	struct resource *res;
+
+	/* Skip Initialization if already created */
+	if (p_sysmgr)
+		goto finish;
+
+	sysmgr = of_sysmgr_register(pdev->dev.of_node);
+	if (IS_ERR(sysmgr)) {
+		dev_err(dev, "regmap init failed\n");
+		return -ENODEV;
+	}
+
+finish:
+	platform_set_drvdata(pdev, p_sysmgr);
+
+	dev_dbg(dev, "regmap %pR registered\n", res);
+
+	return 0;
+}
+
+static const struct of_device_id altr_sysmgr_of_match[] = {
+	{ .compatible = "altr,sys-mgr" },
+	{ .compatible = "altr,sys-mgr-s10" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, altr_sysmgr_of_match);
+
+static struct platform_driver altr_sysmgr_driver = {
+	.probe =  sysmgr_probe,
+	.driver = {
+		.name = "altr,system_manager",
+		.of_match_table = altr_sysmgr_of_match,
+	},
+};
+
+static int __init altr_sysmgr_init(void)
+{
+	return platform_driver_register(&altr_sysmgr_driver);
+}
+core_initcall(altr_sysmgr_init);
+
+static void __exit altr_sysmgr_exit(void)
+{
+	platform_driver_unregister(&altr_sysmgr_driver);
+}
+module_exit(altr_sysmgr_exit);
+
+MODULE_AUTHOR("Thor Thayer <>");
+MODULE_DESCRIPTION("SOCFPGA System Manager driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/altera-sysmgr.h b/include/linux/mfd/altera-sysmgr.h
new file mode 100644
index 000000000000..b82116706319
--- /dev/null
+++ b/include/linux/mfd/altera-sysmgr.h
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2012 Freescale Semiconductor, Inc.
+ * Copyright (C) 2012 Linaro Ltd.
+ */
+
+#ifndef __LINUX_MFD_ALTERA_SYSMGR_H__
+#define __LINUX_MFD_ALTERA_SYSMGR_H__
+
+#include <linux/err.h>
+#include <linux/errno.h>
+
+struct device_node;
+
+#ifdef CONFIG_MFD_ALTERA_SYSMGR
+struct regmap *altr_sysmgr_node_to_regmap(struct device_node *np);
+struct regmap *altr_sysmgr_regmap_lookup_by_compatible(const char *s);
+struct regmap *altr_sysmgr_regmap_lookup_by_pdevname(const char *s);
+struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
+						    const char *property);
+
+/*
+ * Functions specified by ARM SMC Calling convention:
+ *
+ * FAST call executes atomic operations, returns when the requested operation
+ * has completed.
+ * STD call starts a operation which can be preempted by a non-secure
+ * interrupt.
+ *
+ * a0..a7 is used as register names in the descriptions below, on arm32
+ * that translates to r0..r7 and on arm64 to w0..w7.
+ */
+
+#define INTEL_SIP_SMC_STD_CALL_VAL(func_num) \
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_STD_CALL, ARM_SMCCC_SMC_64, \
+	ARM_SMCCC_OWNER_SIP, (func_num))
+
+#define INTEL_SIP_SMC_FAST_CALL_VAL(func_num) \
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_64, \
+	ARM_SMCCC_OWNER_SIP, (func_num))
+
+#define INTEL_SIP_SMC_RETURN_UNKNOWN_FUNCTION		0xFFFFFFFF
+#define INTEL_SIP_SMC_STATUS_OK				0x0
+#define INTEL_SIP_SMC_REG_ERROR				0x5
+
+/*
+ * Request INTEL_SIP_SMC_REG_READ
+ *
+ * Read a protected register using SMCCC
+ *
+ * Call register usage:
+ * a0: INTEL_SIP_SMC_REG_READ.
+ * a1: register address.
+ * a2-7: not used.
+ *
+ * Return status:
+ * a0: INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_REG_ERROR, or
+ *     INTEL_SIP_SMC_RETURN_UNKNOWN_FUNCTION
+ * a1: Value in the register
+ * a2-3: not used.
+ */
+#define INTEL_SIP_SMC_FUNCID_REG_READ 7
+#define INTEL_SIP_SMC_REG_READ \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_REG_READ)
+
+/*
+ * Request INTEL_SIP_SMC_REG_WRITE
+ *
+ * Write a protected register using SMCCC
+ *
+ * Call register usage:
+ * a0: INTEL_SIP_SMC_REG_WRITE.
+ * a1: register address
+ * a2: value to program into register.
+ * a3-7: not used.
+ *
+ * Return status:
+ * a0: INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_REG_ERROR, or
+ *     INTEL_SIP_SMC_RETURN_UNKNOWN_FUNCTION
+ * a1-3: not used.
+ */
+#define INTEL_SIP_SMC_FUNCID_REG_WRITE 8
+#define INTEL_SIP_SMC_REG_WRITE \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_REG_WRITE)
+
+#else
+static inline struct regmap *altr_sysmgr_node_to_regmap(struct device_node *np)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
+static inline struct regmap *
+altr_sysmgr_regmap_lookup_by_compatible(const char *s)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
+static inline struct regmap *
+altr_sysmgr_regmap_lookup_by_pdevname(const char *s)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
+static inline struct regmap *
+altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
+				     const char *property)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+#endif
+
+#endif /* __LINUX_MFD_ALTERA_SYSMGR_H__ */
-- 
2.7.4

