Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbeEMHCL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 03:02:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39490 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbeEMHCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 03:02:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A554602BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From: Rohit kumar <rohitkr@codeaurora.org>
To: ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bgoswami@codeaurora.org, sbpata@codeaurora.org, asishb@codeaurora.org,
        rkarra@codeaurora.org
Cc: Rohit kumar <rohitkr@codeaurora.org>,
        RajendraBabu Medisetti <rajendrabm@codeaurora.org>,
        Krishnamurthy Renu <krishnamurthy.renu@codeaurora.org>
Subject: [PATCH] remoteproc:  Add APSS based Qualcomm ADSP PIL driver for SDM845
Date: Sun, 13 May 2018 12:31:48 +0530
Message-Id: <1526194908-19027-1-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds Qualcomm ADSP PIL driver support for SDM845 with ADSP bootup
and shutdown operation handled from Application Processor SubSystem(APSS).

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: RajendraBabu Medisetti <rajendrabm@codeaurora.org>
Signed-off-by: Krishnamurthy Renu <krishnamurthy.renu@codeaurora.org>
---
 .../devicetree/bindings/remoteproc/qcom,adsp.txt   |   1 +
 drivers/remoteproc/Makefile                        |   3 +-
 drivers/remoteproc/qcom_adsp_pil.c                 | 122 ++++-----
 drivers/remoteproc/qcom_adsp_pil.h                 |  86 ++++++
 drivers/remoteproc/qcom_adsp_pil_sdm845.c          | 304 +++++++++++++++++++++
 5 files changed, 454 insertions(+), 62 deletions(-)
 create mode 100644 drivers/remoteproc/qcom_adsp_pil.h
 create mode 100644 drivers/remoteproc/qcom_adsp_pil_sdm845.c

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
index 728e419..a9fe033 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
@@ -10,6 +10,7 @@ on the Qualcomm ADSP Hexagon core.
 		    "qcom,msm8974-adsp-pil"
 		    "qcom,msm8996-adsp-pil"
 		    "qcom,msm8996-slpi-pil"
+		    "qcom,sdm845-apss-adsp-pil"
 
 - interrupts-extended:
 	Usage: required
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 02627ed..759831b 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -14,7 +14,8 @@ obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
 obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
 obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
 obj-$(CONFIG_KEYSTONE_REMOTEPROC)	+= keystone_remoteproc.o
-obj-$(CONFIG_QCOM_ADSP_PIL)		+= qcom_adsp_pil.o
+obj-$(CONFIG_QCOM_ADSP_PIL)		+= qcom_adsp.o
+qcom_adsp-objs				+= qcom_adsp_pil.o qcom_adsp_pil_sdm845.o
 obj-$(CONFIG_QCOM_RPROC_COMMON)		+= qcom_common.o
 obj-$(CONFIG_QCOM_Q6V5_PIL)		+= qcom_q6v5_pil.o
 obj-$(CONFIG_QCOM_SYSMON)		+= qcom_sysmon.o
diff --git a/drivers/remoteproc/qcom_adsp_pil.c b/drivers/remoteproc/qcom_adsp_pil.c
index 89a86ce..9ab3698 100644
--- a/drivers/remoteproc/qcom_adsp_pil.c
+++ b/drivers/remoteproc/qcom_adsp_pil.c
@@ -1,5 +1,5 @@
 /*
- * Qualcomm ADSP/SLPI Peripheral Image Loader for MSM8974 and MSM8996
+ * Qualcomm ADSP/SLPI Peripheral Image Loader for MSM8974, MSM8996 and SDM845.
  *
  * Copyright (C) 2016 Linaro Ltd
  * Copyright (C) 2014 Sony Mobile Communications AB
@@ -22,7 +22,6 @@
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
-#include <linux/platform_device.h>
 #include <linux/qcom_scm.h>
 #include <linux/regulator/consumer.h>
 #include <linux/remoteproc.h>
@@ -30,56 +29,8 @@
 #include <linux/soc/qcom/smem.h>
 #include <linux/soc/qcom/smem_state.h>
 
-#include "qcom_common.h"
 #include "remoteproc_internal.h"
-
-struct adsp_data {
-	int crash_reason_smem;
-	const char *firmware_name;
-	int pas_id;
-	bool has_aggre2_clk;
-
-	const char *ssr_name;
-	const char *sysmon_name;
-	int ssctl_id;
-};
-
-struct qcom_adsp {
-	struct device *dev;
-	struct rproc *rproc;
-
-	int wdog_irq;
-	int fatal_irq;
-	int ready_irq;
-	int handover_irq;
-	int stop_ack_irq;
-
-	struct qcom_smem_state *state;
-	unsigned stop_bit;
-
-	struct clk *xo;
-	struct clk *aggre2_clk;
-
-	struct regulator *cx_supply;
-	struct regulator *px_supply;
-
-	int pas_id;
-	int crash_reason_smem;
-	bool has_aggre2_clk;
-
-	struct completion start_done;
-	struct completion stop_done;
-
-	phys_addr_t mem_phys;
-	phys_addr_t mem_reloc;
-	void *mem_region;
-	size_t mem_size;
-
-	struct qcom_rproc_glink glink_subdev;
-	struct qcom_rproc_subdev smd_subdev;
-	struct qcom_rproc_ssr ssr_subdev;
-	struct qcom_sysmon *sysmon;
-};
+#include "qcom_adsp_pil.h"
 
 static int adsp_load(struct rproc *rproc, const struct firmware *fw)
 {
@@ -112,18 +63,32 @@ static int adsp_start(struct rproc *rproc)
 	if (ret)
 		goto disable_cx_supply;
 
-	ret = qcom_scm_pas_auth_and_reset(adsp->pas_id);
-	if (ret) {
-		dev_err(adsp->dev,
-			"failed to authenticate image and release reset\n");
-		goto disable_px_supply;
+	if (adsp->is_apss_controlled) {
+		ret = adsp->ops->bringup(adsp);
+		if (ret) {
+			dev_err(adsp->dev, "adsp bringup failed\n");
+			adsp->ops->bringdown(adsp);
+			goto disable_px_supply;
+		}
+	} else {
+		ret = qcom_scm_pas_auth_and_reset(adsp->pas_id);
+		if (ret) {
+			dev_err(adsp->dev,
+				"failed to authenticate image and release reset\n");
+			goto disable_px_supply;
+		}
 	}
 
 	ret = wait_for_completion_timeout(&adsp->start_done,
 					  msecs_to_jiffies(5000));
 	if (!ret) {
 		dev_err(adsp->dev, "start timed out\n");
-		qcom_scm_pas_shutdown(adsp->pas_id);
+
+		if (adsp->is_apss_controlled)
+			adsp->ops->bringdown(adsp);
+		else
+			qcom_scm_pas_shutdown(adsp->pas_id);
+
 		ret = -ETIMEDOUT;
 		goto disable_px_supply;
 	}
@@ -160,7 +125,11 @@ static int adsp_stop(struct rproc *rproc)
 				    BIT(adsp->stop_bit),
 				    0);
 
-	ret = qcom_scm_pas_shutdown(adsp->pas_id);
+	if (adsp->is_apss_controlled)
+		ret = adsp->ops->bringdown(adsp);
+	else
+		ret = qcom_scm_pas_shutdown(adsp->pas_id);
+
 	if (ret)
 		dev_err(adsp->dev, "failed to shutdown: %d\n", ret);
 
@@ -334,8 +303,9 @@ static int adsp_probe(struct platform_device *pdev)
 	if (!desc)
 		return -EINVAL;
 
-	if (!qcom_scm_is_available())
-		return -EPROBE_DEFER;
+	if (!desc->is_apss_controlled)
+		if (!qcom_scm_is_available())
+			return -EPROBE_DEFER;
 
 	rproc = rproc_alloc(&pdev->dev, pdev->name, &adsp_ops,
 			    desc->firmware_name, sizeof(*adsp));
@@ -350,6 +320,7 @@ static int adsp_probe(struct platform_device *pdev)
 	adsp->pas_id = desc->pas_id;
 	adsp->crash_reason_smem = desc->crash_reason_smem;
 	adsp->has_aggre2_clk = desc->has_aggre2_clk;
+	adsp->is_apss_controlled = desc->is_apss_controlled;
 	platform_set_drvdata(pdev, adsp);
 
 	init_completion(&adsp->start_done);
@@ -399,6 +370,19 @@ static int adsp_probe(struct platform_device *pdev)
 		goto free_rproc;
 	}
 
+	if (adsp->is_apss_controlled) {
+		if (!desc->ops || !desc->ops->bringup ||
+		    !desc->ops->bringdown || !desc->ops->map_regs) {
+			dev_err(&pdev->dev, "SoC ops not defined\n");
+			ret = -EINVAL;
+			goto free_rproc;
+		}
+		adsp->ops = desc->ops;
+		ret = adsp->ops->map_regs(adsp, pdev);
+		if (ret)
+			goto free_rproc;
+	}
+
 	qcom_add_glink_subdev(rproc, &adsp->glink_subdev);
 	qcom_add_smd_subdev(rproc, &adsp->smd_subdev);
 	qcom_add_ssr_subdev(rproc, &adsp->ssr_subdev, desc->ssr_name);
@@ -434,11 +418,24 @@ static int adsp_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct adsp_data sdm845_apss_adsp_resource_init = {
+		.crash_reason_smem = 423,
+		.firmware_name = "adsp.mdt",
+		.pas_id = 1,
+		.has_aggre2_clk = false,
+		.is_apss_controlled = true,
+		.ssr_name = "lpass",
+		.sysmon_name = "adsp",
+		.ssctl_id = 0x14,
+		.ops = &sdm845_soc_ops,
+};
+
 static const struct adsp_data adsp_resource_init = {
 		.crash_reason_smem = 423,
 		.firmware_name = "adsp.mdt",
 		.pas_id = 1,
 		.has_aggre2_clk = false,
+		.is_apss_controlled = false,
 		.ssr_name = "lpass",
 		.sysmon_name = "adsp",
 		.ssctl_id = 0x14,
@@ -449,6 +446,7 @@ static int adsp_remove(struct platform_device *pdev)
 		.firmware_name = "slpi.mdt",
 		.pas_id = 12,
 		.has_aggre2_clk = true,
+		.is_apss_controlled = false,
 		.ssr_name = "dsps",
 		.sysmon_name = "slpi",
 		.ssctl_id = 0x16,
@@ -458,6 +456,8 @@ static int adsp_remove(struct platform_device *pdev)
 	{ .compatible = "qcom,msm8974-adsp-pil", .data = &adsp_resource_init},
 	{ .compatible = "qcom,msm8996-adsp-pil", .data = &adsp_resource_init},
 	{ .compatible = "qcom,msm8996-slpi-pil", .data = &slpi_resource_init},
+	{ .compatible = "qcom,sdm845-apss-adsp-pil",
+	  .data = &sdm845_apss_adsp_resource_init},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, adsp_of_match);
@@ -472,5 +472,5 @@ static int adsp_remove(struct platform_device *pdev)
 };
 
 module_platform_driver(adsp_driver);
-MODULE_DESCRIPTION("Qualcomm MSM8974/MSM8996 ADSP Peripherial Image Loader");
+MODULE_DESCRIPTION("Qualcomm MSM8974/MSM8996/SDM845 ADSP Peripherial Image Loader");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/remoteproc/qcom_adsp_pil.h b/drivers/remoteproc/qcom_adsp_pil.h
new file mode 100644
index 0000000..29fd086
--- /dev/null
+++ b/drivers/remoteproc/qcom_adsp_pil.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (c) 2018, The Linux Foundation. All rights reserved
+
+#ifndef __QCOM_ADSP_PIL_H__
+#define __QCOM_ADSP_PIL_H__
+
+#include <linux/platform_device.h>
+#include "qcom_common.h"
+
+struct qcom_adsp;
+
+struct soc_ops {
+	int (*bringup)(struct qcom_adsp *adsp);
+	int (*bringdown)(struct qcom_adsp *adsp);
+	int (*map_regs)(struct qcom_adsp *adsp, struct platform_device *pdev);
+};
+
+struct adsp_data {
+	int crash_reason_smem;
+	const char *firmware_name;
+	int pas_id;
+	bool has_aggre2_clk;
+	bool is_apss_controlled;
+	const char *ssr_name;
+	const char *sysmon_name;
+	int ssctl_id;
+	struct soc_ops *ops;
+};
+
+struct qcom_adsp {
+	struct device *dev;
+	struct rproc *rproc;
+
+	int wdog_irq;
+	int fatal_irq;
+	int ready_irq;
+	int handover_irq;
+	int stop_ack_irq;
+
+	struct qcom_smem_state *state;
+	unsigned int stop_bit;
+
+	struct clk *xo;
+	struct clk *aggre2_clk;
+
+	struct regulator *cx_supply;
+	struct regulator *px_supply;
+
+	int pas_id;
+	int crash_reason_smem;
+	bool has_aggre2_clk;
+	bool is_apss_controlled;
+
+	struct completion start_done;
+	struct completion stop_done;
+
+	phys_addr_t mem_phys;
+	phys_addr_t mem_reloc;
+	void *mem_region;
+	size_t mem_size;
+
+	struct soc_ops *ops;
+	void *priv_reg;
+
+	struct qcom_rproc_glink glink_subdev;
+	struct qcom_rproc_subdev smd_subdev;
+	struct qcom_rproc_ssr ssr_subdev;
+	struct qcom_sysmon *sysmon;
+};
+
+extern struct soc_ops sdm845_soc_ops;
+
+static inline void update_bits(void *reg, u32 mask_val, u32 set_val, u32 shift)
+{
+	u32 reg_val = 0;
+
+	reg_val = ((readl(reg)) & ~mask_val) | ((set_val << shift) & mask_val);
+	writel(reg_val, reg);
+}
+
+static inline unsigned int read_bit(void *reg, u32 mask, int shift)
+{
+	return ((readl(reg) & mask) >> shift);
+}
+
+#endif
diff --git a/drivers/remoteproc/qcom_adsp_pil_sdm845.c b/drivers/remoteproc/qcom_adsp_pil_sdm845.c
new file mode 100644
index 0000000..7518385
--- /dev/null
+++ b/drivers/remoteproc/qcom_adsp_pil_sdm845.c
@@ -0,0 +1,304 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Qualcomm APSS Based ADSP bootup/shutdown ops for SDM845.
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+
+#include "qcom_adsp_pil.h"
+
+/* set values */
+#define CLK_ENABLE				0x1
+#define CLK_DISABLE				0x0
+/* time out value */
+#define ACK_TIMEOUT				200000
+/* mask values */
+#define CLK_MASK				GENMASK(4, 0)
+#define EVB_MASK				GENMASK(27, 4)
+#define SPIN_CLKOFF_MASK			BIT(31)
+#define AUDIO_SYNC_RESET_MASK			BIT(2)
+#define CLK_ENABLE_MASK				BIT(0)
+#define HAL_CLK_MASK				BIT(1)
+/* GCC register offsets */
+#define GCC_BASE				0x00147000
+#define SWAY_CBCR_OFFSET			0x00000008
+/*LPASS register base address and offsets*/
+#define LPASS_BASE				0x17000000
+#define AON_CBCR_OFFSET				0x00014098
+#define CMD_RCGR_OFFSET				0x00014000
+#define CFG_RCGR_OFFSET				0x00014004
+#define AHBS_AON_CBCR_OFFSET			0x00033000
+#define AHBM_AON_CBCR_OFFSET			0x00026000
+/*QDSP6SS register base address and offsets*/
+#define QDSP6SS_BASE				0x17300000
+#define RST_EVB_OFFSET				0x00000010
+#define SLEEP_CBCR_OFFSET			0x0000003C
+#define XO_CBCR_OFFSET				0x00000038
+#define CORE_CBCR_OFFSET			0x00000020
+#define CORE_START_OFFSET			0x00000400
+#define BOOT_CMD_OFFSET				0x00000404
+#define BOOT_STATUS_OFFSET			0x00000408
+#define RET_CFG_OFFSET				0x0000001C
+/*TCSR register base address and offsets*/
+#define TCSR_BASE				0x01F62000
+#define TCSR_LPASS_MASTER_IDLE_OFFSET		0x00000008
+#define TCSR_LPASS_HALTACK_OFFSET		0x00000004
+#define TCSR_LPASS_PWR_ON_OFFSET		0x00000010
+#define TCSR_LPASS_HALTREQ_OFFSET		0X00000000
+
+#define RPMH_PDC_SYNC_RESET_ADDR		0x0B2E0100
+#define AOSS_CC_LPASS_RESTART_ADDR		0x0C2D0000
+
+struct sdm845_reg {
+	void __iomem *gcc_base;
+	void __iomem *lpass_base;
+	void __iomem *qdsp6ss_base;
+	void __iomem *tcsr_base;
+	void __iomem *pdc_sync;
+	void __iomem *cc_lpass;
+};
+
+static int sdm845_map_registers(struct qcom_adsp *adsp,
+				struct platform_device *pdev)
+{
+	struct sdm845_reg *reg;
+
+	adsp->priv_reg = devm_kzalloc(&pdev->dev, sizeof(struct sdm845_reg),
+			GFP_KERNEL);
+	if (!adsp->priv_reg)
+		return -ENOMEM;
+
+	reg = adsp->priv_reg;
+
+	reg->gcc_base = devm_ioremap(adsp->dev, GCC_BASE, 0xc);
+	if (!reg->gcc_base) {
+		dev_err(adsp->dev, "%s: failed to map GCC base registers\n",
+				__func__);
+		return -ENOMEM;
+	}
+
+	reg->lpass_base = devm_ioremap(adsp->dev, LPASS_BASE, 0x8E004);
+	if (!reg->lpass_base) {
+		dev_err(adsp->dev, "%s: failed to map LPASS base registers\n",
+				__func__);
+		return -ENOMEM;
+	}
+	reg->qdsp6ss_base =  devm_ioremap(adsp->dev, QDSP6SS_BASE, 0x40c);
+	if (!reg->qdsp6ss_base) {
+		dev_err(adsp->dev, "%s: failed to map QDSP6SS base registers\n",
+				__func__);
+		return -ENOMEM;
+	}
+	reg->tcsr_base = devm_ioremap(adsp->dev, TCSR_BASE, 0x14);
+	if (!reg->tcsr_base) {
+		dev_err(adsp->dev, "%s: failed to map TCSR base registers\n",
+				__func__);
+		return -ENOMEM;
+	}
+	reg->pdc_sync = devm_ioremap(adsp->dev, RPMH_PDC_SYNC_RESET_ADDR, 0x4);
+	if (!reg->pdc_sync) {
+		dev_err(adsp->dev, "%s: failed to map RPMH_PDC_SYNC_RESET register\n",
+				__func__);
+		return -ENOMEM;
+	}
+	reg->cc_lpass = devm_ioremap(adsp->dev, AOSS_CC_LPASS_RESTART_ADDR,
+			0x4);
+	if (!reg->cc_lpass) {
+		dev_err(adsp->dev, "%s:failed to map AOSS_CC_LPASS_RESTART register\n",
+				__func__);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int clk_enable_spin(void *reg, int read_shift, int write_shift)
+{
+	u32 maxDelay = 500;
+	u32 val;
+
+	update_bits(reg, CLK_ENABLE_MASK, CLK_ENABLE, write_shift);
+	val = readl(reg);
+	if (!(readl(reg) & HAL_CLK_MASK)) {
+		/*
+		 * wait for disabling of HW signal CLK_OFF to confirm that
+		 * clock is actually ON.
+		 */
+		while (maxDelay-- && read_bit(reg, SPIN_CLKOFF_MASK,
+							read_shift))
+			udelay(1);
+	}
+	if (!maxDelay) {
+		pr_err("%s: fail to update register = %p\n", __func__, reg);
+		return -ETIMEDOUT;
+	}
+	return 0;
+}
+
+static int sdm845_adsp_clk_enable(struct qcom_adsp *adsp)
+{
+	u32 ret;
+	u32 maxDelay = 100;
+	struct sdm845_reg *reg = adsp->priv_reg;
+
+	/* Enable SWAY clock */
+	ret = clk_enable_spin(reg->gcc_base + SWAY_CBCR_OFFSET, CLK_MASK, 0x0);
+	if (ret)
+		return ret;
+
+	/* Enable LPASS AHB AON Bus */
+	ret = clk_enable_spin(reg->lpass_base + AON_CBCR_OFFSET, CLK_MASK, 0x0);
+	if (ret)
+		return ret;
+
+	/* Set the AON clock root to be sourced by XO */
+	writel(CLK_DISABLE, reg->lpass_base + CFG_RCGR_OFFSET);
+	writel(CLK_ENABLE, reg->lpass_base + CMD_RCGR_OFFSET);
+
+	while (read_bit((reg->lpass_base + CMD_RCGR_OFFSET), CLK_ENABLE, 0)
+						&& maxDelay--)
+		udelay(2);
+
+	if (!maxDelay) {
+		pr_err("%s: fail to enable CMD_RCGR clock\n", __func__);
+		return -ETIMEDOUT;
+	}
+
+	/* Enable the QDSP6SS AHBM and AHBS clocks */
+	ret = clk_enable_spin(reg->lpass_base + AHBS_AON_CBCR_OFFSET,
+				CLK_MASK, 0x0);
+	if (ret)
+		return ret;
+	ret = clk_enable_spin(reg->lpass_base + AHBM_AON_CBCR_OFFSET,
+				CLK_MASK, 0x0);
+	if (ret)
+		return ret;
+
+	/* Turn on the XO clock, required to boot FSM */
+	update_bits(reg->qdsp6ss_base + XO_CBCR_OFFSET, CLK_ENABLE_MASK,
+							CLK_ENABLE, 0x0);
+
+	/* Enable the QDSP6SS sleep clock for the QDSP6 watchdog enablement */
+	update_bits(reg->qdsp6ss_base + SLEEP_CBCR_OFFSET,
+					CLK_ENABLE_MASK, CLK_ENABLE, 0x0);
+
+	/* Configure QDSP6 core CBC to enable clock */
+	update_bits(reg->qdsp6ss_base + CORE_CBCR_OFFSET, CLK_ENABLE_MASK,
+					CLK_ENABLE, 0x0);
+	return 0;
+}
+
+static int sdm845_adsp_reset(struct qcom_adsp *adsp)
+{
+	u32 timeout = ACK_TIMEOUT;
+	struct sdm845_reg *reg = adsp->priv_reg;
+
+	/* De-assert QDSP6 stop core. QDSP6 will execute after out of reset */
+	update_bits(reg->qdsp6ss_base + CORE_START_OFFSET,
+					CLK_ENABLE_MASK, CLK_ENABLE, 0x0);
+	/* Trigger boot FSM to start QDSP6 */
+	writel(CLK_ENABLE, reg->qdsp6ss_base + BOOT_CMD_OFFSET);
+
+	/* Wait for core to come out of reset */
+	while ((!(readl(reg->qdsp6ss_base +
+			BOOT_STATUS_OFFSET))) && (timeout-- > 0))
+		udelay(5);
+
+	if (!timeout)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int sdm845_bringup(struct qcom_adsp *adsp)
+{
+	u32 ret;
+	struct sdm845_reg *reg = adsp->priv_reg;
+
+	ret = sdm845_adsp_clk_enable(adsp);
+	if (ret) {
+		dev_err(adsp->dev, "%s: sdm845_adsp_clk_enable failed\n",
+				__func__);
+		return ret;
+	}
+	/* Program boot address */
+	update_bits(reg->qdsp6ss_base + RST_EVB_OFFSET,
+				EVB_MASK, (adsp->mem_phys) >> 8, 0x4);
+
+	/* Wait for addresses to be programmed before starting adsp */
+	mb();
+	ret = sdm845_adsp_reset(adsp);
+	if (ret)
+		dev_err(adsp->dev, "%s: De-assert QDSP6 out of reset failed\n",
+					__func__);
+	return ret;
+}
+
+static int sdm845_bringdown(struct qcom_adsp *adsp)
+{
+	u32 acktimeout = ACK_TIMEOUT;
+	u32 temp;
+	struct sdm845_reg *reg = adsp->priv_reg;
+
+	/* Reset the retention logic */
+	update_bits(reg->qdsp6ss_base + RET_CFG_OFFSET,
+			CLK_ENABLE_MASK, CLK_ENABLE, 0x0);
+	/* Disable the slave way clock to LPASS */
+	update_bits(reg->gcc_base + SWAY_CBCR_OFFSET,
+			CLK_ENABLE_MASK, CLK_DISABLE, 0x0);
+
+	/* QDSP6 master port needs to be explicitly halted */
+	temp = read_bit(reg->tcsr_base + TCSR_LPASS_PWR_ON_OFFSET,
+			CLK_ENABLE, 0x0);
+	temp = temp && !read_bit(reg->tcsr_base + TCSR_LPASS_MASTER_IDLE_OFFSET,
+			CLK_ENABLE, 0x0);
+	if (temp) {
+		writel(CLK_ENABLE, reg->tcsr_base + TCSR_LPASS_HALTREQ_OFFSET);
+		/*  Wait for halt ACK from QDSP6 */
+		while ((read_bit(reg->tcsr_base + TCSR_LPASS_HALTACK_OFFSET,
+				CLK_DISABLE, 0x0) == 0) && (acktimeout-- > 0))
+			udelay(5);
+
+		if (acktimeout) {
+			if (read_bit(reg->tcsr_base +
+					TCSR_LPASS_MASTER_IDLE_OFFSET,
+						CLK_ENABLE, 0x0) != 1)
+				dev_warn(adsp->dev,
+						"%s: failed to receive %s\n",
+						__func__, "TCSR MASTER ACK");
+		} else {
+			dev_err(adsp->dev, "%s: failed to receive halt ack\n",
+					__func__);
+			return -ETIMEDOUT;
+		}
+	}
+
+	/* Assert the LPASS PDC Reset */
+	update_bits(reg->pdc_sync,  AUDIO_SYNC_RESET_MASK,
+			CLK_ENABLE, 0x2);
+	/* Place the LPASS processor into reset */
+	writel(CLK_ENABLE, reg->cc_lpass);
+	/* wait after asserting subsystem restart from AOSS */
+	udelay(200);
+
+	/* Clear the halt request for the AXIM and AHBM for Q6 */
+	writel(CLK_DISABLE, reg->tcsr_base + TCSR_LPASS_HALTREQ_OFFSET);
+
+	/* De-assert the LPASS PDC Reset */
+	update_bits(reg->pdc_sync, AUDIO_SYNC_RESET_MASK,
+			CLK_DISABLE, 0x2);
+	/* Remove the LPASS reset */
+	writel(CLK_DISABLE, reg->cc_lpass);
+	/* wait after de-asserting subsystem restart from AOSS */
+	udelay(200);
+
+	return 0;
+}
+
+struct soc_ops sdm845_soc_ops = {
+	.bringup = sdm845_bringup,
+	.bringdown = sdm845_bringdown,
+	.map_regs = sdm845_map_registers,
+};
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
