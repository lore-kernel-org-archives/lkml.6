Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA73C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A6120837
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AYUzrqBo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="F1yDsw59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A6120837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbeH2Egu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 00:36:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48958 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbeH2Egt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 00:36:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4717A607C3; Wed, 29 Aug 2018 00:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535503356;
        bh=Nd26+VIB5qdcei5Sw3s3aPVAVXGw8L12ZM+igjKh5vM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AYUzrqBoXnB1WHvxynahqJnKTUNh9SLe9euM2yN+RQMFVkV/ZGaOzwHLnG1N5dxWp
         3fIlgxoEQmVJMUlbdygtVZhcPprg/QiVGLFmsSYNSjZo99gaqholp6778bkJpB8rKo
         8COhSdiqpHP/Eadq9a/FxCoSyREFGHLkKLHwxqrc=
Received: from vgutta-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vnkgutta@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BAA8160242;
        Wed, 29 Aug 2018 00:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535503353;
        bh=Nd26+VIB5qdcei5Sw3s3aPVAVXGw8L12ZM+igjKh5vM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F1yDsw59A+ZdOwgWSoIXnj5lG4R+fjY7kCgPw6w9KIwIyRe4nMahpswmJfCTOaeru
         lALpDjEUXxYpLMtBKxGHXpM6/trUL3DbJsxrQA9c1162ocm2Mg3/lffsBtOKBjDnPn
         a7xqyBttWShpnj2Oqmv8DGIdG9a9EBHVAISDUAXg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BAA8160242
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vnkgutta@codeaurora.org
From:   Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
To:     evgreen@chromium.org, robh@kernel.org, mchehab@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org, bp@alien8.de,
        swboyd@chromium.org
Cc:     Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Subject: [PATCH v3 3/4] drivers: edac: Add EDAC driver support for QCOM SoCs
Date:   Tue, 28 Aug 2018 17:42:26 -0700
Message-Id: <1535503347-20507-4-git-send-email-vnkgutta@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535503347-20507-1-git-send-email-vnkgutta@codeaurora.org>
References: <1535503347-20507-1-git-send-email-vnkgutta@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Channagoud Kadabi <ckadabi@codeaurora.org>

Add error reporting driver for Single Bit Errors (SBEs) and Double Bit
Errors (DBEs). As of now, this driver supports error reporting for
Last Level Cache Controller (LLCC) of Tag RAM and Data RAM. Interrupts
are triggered when the errors happen in the cache, the driver handles
those interrupts and dumps the syndrome registers.

Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Co-developed-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
---
 MAINTAINERS                        |   8 +
 drivers/edac/Kconfig               |  22 ++
 drivers/edac/Makefile              |   1 +
 drivers/edac/qcom_edac.c           | 421 +++++++++++++++++++++++++++++++++++++
 include/linux/soc/qcom/llcc-qcom.h |  24 +++
 5 files changed, 476 insertions(+)
 create mode 100644 drivers/edac/qcom_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a23427..0bff713 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5227,6 +5227,14 @@ L:	linux-edac@vger.kernel.org
 S:	Maintained
 F:	drivers/edac/ti_edac.c
 
+EDAC-QUALCOMM
+M:	Channagoud Kadabi <ckadabi@codeaurora.org>
+M:	Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
+L:	linux-arm-msm@vger.kernel.org
+L:	linux-edac@vger.kernel.org
+S:	Maintained
+F:	drivers/edac/qcom_edac.c
+
 EDIROL UA-101/UA-1000 DRIVER
 M:	Clemens Ladisch <clemens@ladisch.de>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 57304b2..df58957 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -460,4 +460,26 @@ config EDAC_TI
 	  Support for error detection and correction on the
           TI SoCs.
 
+config EDAC_QCOM
+	tristate "QCOM EDAC Controller"
+	depends on EDAC
+	help
+	  Support for error detection and correction on the
+	  QCOM SoCs.
+
+	  This driver reports Single Bit Errors (SBEs) and Double Bit Errors (DBEs).
+	  As of now, it supports error reporting for Last Level Cache Controller (LLCC)
+	  of Tag RAM and Data RAM.
+
+config EDAC_QCOM_LLCC
+	tristate "QCOM EDAC Controller for LLCC Cache"
+	depends on EDAC_QCOM && QCOM_LLCC
+	help
+	  Support for error detection and correction on the
+	  QCOM LLCC cache. Report errors caught by LLCC ECC
+	  mechanism.
+
+	  For debugging issues having to do with stability and overall system
+	  health, you should probably say 'Y' here.
+
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 02b43a7..716096d 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -77,3 +77,4 @@ obj-$(CONFIG_EDAC_ALTERA)		+= altera_edac.o
 obj-$(CONFIG_EDAC_SYNOPSYS)		+= synopsys_edac.o
 obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
 obj-$(CONFIG_EDAC_TI)			+= ti_edac.o
+obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
new file mode 100644
index 0000000..871ed07
--- /dev/null
+++ b/drivers/edac/qcom_edac.c
@@ -0,0 +1,421 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/edac.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/soc/qcom/llcc-qcom.h>
+
+#include "edac_mc.h"
+#include "edac_device.h"
+
+#define EDAC_LLCC                       "qcom_llcc"
+
+#define LLCC_ERP_PANIC_ON_UE            1
+
+#define TRP_SYN_REG_CNT                 6
+#define DRP_SYN_REG_CNT                 8
+
+#define LLCC_COMMON_STATUS0             0x0003000c
+#define LLCC_LB_CNT_MASK                GENMASK(31, 28)
+#define LLCC_LB_CNT_SHIFT               28
+
+/* Single & double bit syndrome register offsets */
+#define TRP_ECC_SB_ERR_SYN0             0x0002304c
+#define TRP_ECC_DB_ERR_SYN0             0x00020370
+#define DRP_ECC_SB_ERR_SYN0             0x0004204c
+#define DRP_ECC_DB_ERR_SYN0             0x00042070
+
+/* Error register offsets */
+#define TRP_ECC_ERROR_STATUS1           0x00020348
+#define TRP_ECC_ERROR_STATUS0           0x00020344
+#define DRP_ECC_ERROR_STATUS1           0x00042048
+#define DRP_ECC_ERROR_STATUS0           0x00042044
+
+/* TRP, DRP interrupt register offsets */
+#define DRP_INTERRUPT_STATUS            0x00041000
+#define TRP_INTERRUPT_0_STATUS          0x00020480
+#define DRP_INTERRUPT_CLEAR             0x00041008
+#define DRP_ECC_ERROR_CNTR_CLEAR        0x00040004
+#define TRP_INTERRUPT_0_CLEAR           0x00020484
+#define TRP_ECC_ERROR_CNTR_CLEAR        0x00020440
+
+/* Mask and shift macros */
+#define ECC_DB_ERR_COUNT_MASK           GENMASK(4, 0)
+#define ECC_DB_ERR_WAYS_MASK            GENMASK(31, 16)
+#define ECC_DB_ERR_WAYS_SHIFT           BIT(4)
+
+#define ECC_SB_ERR_COUNT_MASK           GENMASK(23, 16)
+#define ECC_SB_ERR_COUNT_SHIFT          BIT(4)
+#define ECC_SB_ERR_WAYS_MASK            GENMASK(15, 0)
+
+#define SB_ECC_ERROR                    BIT(0)
+#define DB_ECC_ERROR                    BIT(1)
+
+#define DRP_TRP_INT_CLEAR               GENMASK(1, 0)
+#define DRP_TRP_CNT_CLEAR               GENMASK(1, 0)
+
+/* Config registers offsets*/
+#define DRP_ECC_ERROR_CFG               0x00040000
+
+/* Tag RAM, Data RAM interrupt register offsets */
+#define CMN_INTERRUPT_0_ENABLE          0x0003001c
+#define CMN_INTERRUPT_2_ENABLE          0x0003003c
+#define TRP_INTERRUPT_0_ENABLE          0x00020488
+#define DRP_INTERRUPT_ENABLE            0x0004100c
+
+#define SB_ERROR_THRESHOLD              0x1
+#define SB_ERROR_THRESHOLD_SHIFT        24
+#define SB_DB_TRP_INTERRUPT_ENABLE      0x3
+#define TRP0_INTERRUPT_ENABLE           0x1
+#define DRP0_INTERRUPT_ENABLE           BIT(6)
+#define SB_DB_DRP_INTERRUPT_ENABLE      0x3
+
+enum {
+	LLCC_DRAM_CE = 0,
+	LLCC_DRAM_UE,
+	LLCC_TRAM_CE,
+	LLCC_TRAM_UE,
+};
+
+const struct llcc_edac_reg_data edac_reg_data[] = {
+	[LLCC_DRAM_CE] = {
+		.name = "DRAM Single-bit",
+		.synd_reg = DRP_ECC_SB_ERR_SYN0,
+		.count_status_reg = DRP_ECC_ERROR_STATUS1,
+		.ways_status_reg = DRP_ECC_ERROR_STATUS0,
+		.reg_cnt = DRP_SYN_REG_CNT,
+		.count_mask = ECC_SB_ERR_COUNT_MASK,
+		.ways_mask = ECC_SB_ERR_WAYS_MASK,
+		.count_shift = ECC_SB_ERR_COUNT_SHIFT,
+	},
+	[LLCC_DRAM_UE] = {
+		.name = "DRAM Double-bit",
+		.synd_reg = DRP_ECC_DB_ERR_SYN0,
+		.count_status_reg = DRP_ECC_ERROR_STATUS1,
+		.ways_status_reg = DRP_ECC_ERROR_STATUS0,
+		.reg_cnt = DRP_SYN_REG_CNT,
+		.count_mask = ECC_DB_ERR_COUNT_MASK,
+		.ways_mask = ECC_DB_ERR_WAYS_MASK,
+		.ways_shift = ECC_DB_ERR_WAYS_SHIFT,
+	},
+	[LLCC_TRAM_CE] = {
+		.name = "TRAM Single-bit",
+		.synd_reg = TRP_ECC_SB_ERR_SYN0,
+		.count_status_reg = TRP_ECC_ERROR_STATUS1,
+		.ways_status_reg = TRP_ECC_ERROR_STATUS0,
+		.reg_cnt = TRP_SYN_REG_CNT,
+		.count_mask = ECC_SB_ERR_COUNT_MASK,
+		.ways_mask = ECC_SB_ERR_WAYS_MASK,
+		.count_shift = ECC_SB_ERR_COUNT_SHIFT,
+	},
+	[LLCC_TRAM_UE] = {
+		.name = "TRAM Double-bit",
+		.synd_reg = TRP_ECC_DB_ERR_SYN0,
+		.count_status_reg = TRP_ECC_ERROR_STATUS1,
+		.ways_status_reg = TRP_ECC_ERROR_STATUS0,
+		.reg_cnt = TRP_SYN_REG_CNT,
+		.count_mask = ECC_DB_ERR_COUNT_MASK,
+		.ways_mask = ECC_DB_ERR_WAYS_MASK,
+		.ways_shift = ECC_DB_ERR_WAYS_SHIFT,
+	},
+};
+
+static int qcom_llcc_core_setup(struct regmap *llcc_bcast_regmap)
+{
+	u32 sb_err_threshold;
+	int ret;
+
+	/*
+	 * Configure interrupt enable registers such that Tag, Data RAM related
+	 * interrupts are propagated to interrupt controller for servicing
+	 */
+	ret = regmap_update_bits(llcc_bcast_regmap, CMN_INTERRUPT_2_ENABLE,
+				 TRP0_INTERRUPT_ENABLE,
+				 TRP0_INTERRUPT_ENABLE);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(llcc_bcast_regmap, TRP_INTERRUPT_0_ENABLE,
+				 SB_DB_TRP_INTERRUPT_ENABLE,
+				 SB_DB_TRP_INTERRUPT_ENABLE);
+	if (ret)
+		return ret;
+
+	sb_err_threshold = (SB_ERROR_THRESHOLD << SB_ERROR_THRESHOLD_SHIFT);
+	ret = regmap_write(llcc_bcast_regmap, DRP_ECC_ERROR_CFG,
+			   sb_err_threshold);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(llcc_bcast_regmap, CMN_INTERRUPT_2_ENABLE,
+				 DRP0_INTERRUPT_ENABLE,
+				 DRP0_INTERRUPT_ENABLE);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(llcc_bcast_regmap, DRP_INTERRUPT_ENABLE,
+			   SB_DB_DRP_INTERRUPT_ENABLE);
+	return ret;
+}
+
+/* Clear the error interrupt and counter registers */
+static int
+qcom_llcc_clear_error_status(int err_type, struct llcc_drv_data *drv)
+{
+	int ret = 0;
+
+	switch (err_type) {
+	case LLCC_DRAM_CE:
+	case LLCC_DRAM_UE:
+		ret = regmap_write(drv->bcast_regmap, DRP_INTERRUPT_CLEAR,
+				   DRP_TRP_INT_CLEAR);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(drv->bcast_regmap, DRP_ECC_ERROR_CNTR_CLEAR,
+				   DRP_TRP_CNT_CLEAR);
+		if (ret)
+			return ret;
+		break;
+	case LLCC_TRAM_CE:
+	case LLCC_TRAM_UE:
+		ret = regmap_write(drv->bcast_regmap, TRP_INTERRUPT_0_CLEAR,
+				   DRP_TRP_INT_CLEAR);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(drv->bcast_regmap, TRP_ECC_ERROR_CNTR_CLEAR,
+				   DRP_TRP_CNT_CLEAR);
+		if (ret)
+			return ret;
+		break;
+	default:
+		ret = -EINVAL;
+		edac_printk(KERN_CRIT, EDAC_LLCC, "Unexpected error type: %d\n",
+			    err_type);
+	}
+	return ret;
+}
+
+/* Dump Syndrome registers data for Tag RAM, Data RAM bit errors*/
+static int
+dump_syn_reg_values(struct llcc_drv_data *drv, u32 bank, int err_type)
+{
+	struct llcc_edac_reg_data reg_data = edac_reg_data[err_type];
+	int err_cnt, err_ways, ret, i;
+	u32 synd_reg, synd_val;
+
+	for (i = 0; i < reg_data.reg_cnt; i++) {
+		synd_reg = reg_data.synd_reg + (i * 4);
+		ret = regmap_read(drv->regmap, drv->offsets[bank] + synd_reg,
+				  &synd_val);
+		if (ret)
+			goto clear;
+		edac_printk(KERN_CRIT, EDAC_LLCC, "%s: ECC_SYN%d: 0x%8x\n",
+			    reg_data.name, i, synd_val);
+	}
+
+	ret = regmap_read(drv->regmap,
+			  drv->offsets[bank] + reg_data.count_status_reg,
+			  &err_cnt);
+	if (ret)
+		goto clear;
+
+	err_cnt &= reg_data.count_mask;
+	err_cnt >>= reg_data.count_shift;
+	edac_printk(KERN_CRIT, EDAC_LLCC, "%s: error count: 0x%4x\n",
+		    reg_data.name, err_cnt);
+
+	ret = regmap_read(drv->regmap,
+			  drv->offsets[bank] + reg_data.ways_status_reg,
+			  &err_ways);
+	if (ret)
+		goto clear;
+
+	err_ways &= reg_data.ways_mask;
+	err_ways >>= reg_data.ways_shift;
+
+	edac_printk(KERN_CRIT, EDAC_LLCC, "%s: error ways: 0x%4x\n",
+		    reg_data.name, err_ways);
+
+clear:
+	return qcom_llcc_clear_error_status(err_type, drv);
+}
+
+static int
+dump_syn_reg(struct edac_device_ctl_info *edev_ctl, int err_type, u32 bank)
+{
+	struct llcc_drv_data *drv = edev_ctl->pvt_info;
+	int ret;
+
+	ret = dump_syn_reg_values(drv, bank, err_type);
+	if (ret)
+		return ret;
+
+	switch (err_type) {
+	case LLCC_DRAM_CE:
+		edac_device_handle_ce(edev_ctl, 0, bank,
+				      "LLCC Data RAM correctable Error");
+		break;
+	case LLCC_DRAM_UE:
+		edac_device_handle_ue(edev_ctl, 0, bank,
+				      "LLCC Data RAM uncorrectable Error");
+		break;
+	case LLCC_TRAM_CE:
+		edac_device_handle_ce(edev_ctl, 0, bank,
+				      "LLCC Tag RAM correctable Error");
+		break;
+	case LLCC_TRAM_UE:
+		edac_device_handle_ue(edev_ctl, 0, bank,
+				      "LLCC Tag RAM uncorrectable Error");
+		break;
+	default:
+		ret = -EINVAL;
+		edac_printk(KERN_CRIT, EDAC_LLCC, "Unexpected error type: %d\n",
+			    err_type);
+	}
+
+	return ret;
+}
+
+static irqreturn_t
+llcc_ecc_irq_handler(int irq, void *edev_ctl)
+{
+	struct edac_device_ctl_info *edac_dev_ctl = edev_ctl;
+	struct llcc_drv_data *drv = edac_dev_ctl->pvt_info;
+	irqreturn_t irq_rc = IRQ_NONE;
+	u32 drp_error, trp_error, i;
+	bool irq_handled;
+	int ret;
+
+	/* Iterate over the banks and look for Tag RAM or Data RAM errors */
+	for (i = 0; i < drv->num_banks; i++) {
+		ret = regmap_read(drv->regmap,
+				  drv->offsets[i] + DRP_INTERRUPT_STATUS,
+				  &drp_error);
+
+		if (!ret && (drp_error & SB_ECC_ERROR)) {
+			edac_printk(KERN_CRIT, EDAC_LLCC,
+				    "Single Bit Error detected in Data Ram\n");
+			ret = dump_syn_reg(edev_ctl, LLCC_DRAM_CE, i);
+		} else if (!ret && (drp_error & DB_ECC_ERROR)) {
+			edac_printk(KERN_CRIT, EDAC_LLCC,
+				    "Double Bit Error detected in Data Ram\n");
+			ret = dump_syn_reg(edev_ctl, LLCC_DRAM_UE, i);
+		}
+		if (!ret)
+			irq_handled = true;
+
+		ret = regmap_read(drv->regmap,
+				  drv->offsets[i] + TRP_INTERRUPT_0_STATUS,
+				  &trp_error);
+
+		if (!ret && (trp_error & SB_ECC_ERROR)) {
+			edac_printk(KERN_CRIT, EDAC_LLCC,
+				    "Single Bit Error detected in Tag Ram\n");
+			ret = dump_syn_reg(edev_ctl, LLCC_TRAM_CE, i);
+		} else if (!ret && (trp_error & DB_ECC_ERROR)) {
+			edac_printk(KERN_CRIT, EDAC_LLCC,
+				    "Double Bit Error detected in Tag Ram\n");
+			ret = dump_syn_reg(edev_ctl, LLCC_TRAM_UE, i);
+		}
+		if (!ret)
+			irq_handled = true;
+	}
+
+	if (irq_handled)
+		irq_rc = IRQ_HANDLED;
+
+	return irq_rc;
+}
+
+static int qcom_llcc_edac_probe(struct platform_device *pdev)
+{
+	struct llcc_drv_data *llcc_driv_data = pdev->dev.platform_data;
+	struct edac_device_ctl_info *edev_ctl;
+	struct device *dev = &pdev->dev;
+	int ecc_irq;
+	int rc;
+
+	rc = qcom_llcc_core_setup(llcc_driv_data->bcast_regmap);
+	if (rc)
+		return rc;
+
+	/* Allocate edac control info */
+	edev_ctl = edac_device_alloc_ctl_info(0, "qcom-llcc", 1, "bank",
+					      llcc_driv_data->num_banks, 1,
+					      NULL, 0,
+					      edac_device_alloc_index());
+
+	if (!edev_ctl)
+		return -ENOMEM;
+
+	edev_ctl->dev = dev;
+	edev_ctl->mod_name = dev_name(dev);
+	edev_ctl->dev_name = dev_name(dev);
+	edev_ctl->ctl_name = "llcc";
+	edev_ctl->panic_on_ue = LLCC_ERP_PANIC_ON_UE;
+	edev_ctl->pvt_info = llcc_driv_data;
+
+	rc = edac_device_add_device(edev_ctl);
+	if (rc)
+		goto out_mem;
+
+	platform_set_drvdata(pdev, edev_ctl);
+
+	/* Request for ecc irq */
+	ecc_irq = llcc_driv_data->ecc_irq;
+	if (ecc_irq < 0) {
+		rc = -ENODEV;
+		goto out_dev;
+	}
+	rc = devm_request_irq(dev, ecc_irq, llcc_ecc_irq_handler,
+			      IRQF_TRIGGER_HIGH, "llcc_ecc", edev_ctl);
+	if (rc)
+		goto out_dev;
+
+	return rc;
+
+out_dev:
+	edac_device_del_device(edev_ctl->dev);
+out_mem:
+	edac_device_free_ctl_info(edev_ctl);
+
+	return rc;
+}
+
+static int qcom_llcc_edac_remove(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *edev_ctl = dev_get_drvdata(&pdev->dev);
+
+	edac_device_del_device(edev_ctl->dev);
+	edac_device_free_ctl_info(edev_ctl);
+
+	return 0;
+}
+
+static const struct of_device_id qcom_llcc_edac_match_table[] = {
+#ifdef EDAC_QCOM_LLCC
+	{ .compatible = "qcom,llcc-edac" },
+#endif
+	{ },
+};
+
+static struct platform_driver qcom_llcc_edac_driver = {
+	.probe = qcom_llcc_edac_probe,
+	.remove = qcom_llcc_edac_remove,
+	.driver = {
+		.name = "qcom_llcc_edac",
+		.of_match_table = qcom_llcc_edac_match_table,
+	},
+};
+module_platform_driver(qcom_llcc_edac_driver);
+
+MODULE_DESCRIPTION("QCOM EDAC driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
index 2e4b34d..69c285b 100644
--- a/include/linux/soc/qcom/llcc-qcom.h
+++ b/include/linux/soc/qcom/llcc-qcom.h
@@ -93,6 +93,30 @@ struct llcc_drv_data {
 	int ecc_irq;
 };
 
+/**
+ * llcc_edac_reg_data - llcc edac registers data for each error type
+ * @name: Name of the error
+ * @synd_reg: Syndrome register address
+ * @count_status_reg: Status register address to read the error count
+ * @ways_status_reg: Status register address to read the error ways
+ * @reg_cnt: Number of registers
+ * @count_mask: Mask value to get the error count
+ * @ways_mask: Mask value to get the error ways
+ * @count_shift: Shift value to get the error count
+ * @ways_shift: Shift value to get the error ways
+ */
+struct llcc_edac_reg_data {
+	char *name;
+	u64 synd_reg;
+	u64 count_status_reg;
+	u64 ways_status_reg;
+	u32 reg_cnt;
+	u32 count_mask;
+	u32 ways_mask;
+	u8  count_shift;
+	u8  ways_shift;
+};
+
 #if IS_ENABLED(CONFIG_QCOM_LLCC)
 /**
  * llcc_slice_getd - get llcc slice descriptor
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

