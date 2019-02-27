Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1466CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB70213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbfB0UWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:22:39 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:46331 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727240AbfB0UWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 15:22:39 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from junhan@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 27 Feb 2019 22:22:31 +0200
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id x1RKMSAG013308;
        Wed, 27 Feb 2019 15:22:28 -0500
Received: (from junhan@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id x1RKMQDO005022;
        Wed, 27 Feb 2019 15:22:26 -0500
From:   Junhan Zhou <Junhan@mellanox.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Junhan Zhou <Junhan@mellanox.com>, Liming Sun <lsun@mellanox.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] EDAC, mellanox: Add ECC support for BlueField DDR4
Date:   Wed, 27 Feb 2019 15:21:56 -0500
Message-Id: <1551298916-4981-1-git-send-email-Junhan@mellanox.com>
X-Mailer: git-send-email 2.1.2
In-Reply-To: <e59276b6f3dc165703ddcb47a8a006d8a62d9c95.1551216637.git.Junhan@mellanox.com>
References: <e59276b6f3dc165703ddcb47a8a006d8a62d9c95.1551216637.git.Junhan@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ECC support for Mellanox BlueField SoC DDR controller.
This requires SMC to the running Arm Trusted Firmware to report
what is the current memory configuration.

Signed-off-by: Junhan Zhou <Junhan@mellanox.com>
---
 drivers/edac/Kconfig          |   7 +
 drivers/edac/Makefile         |   1 +
 drivers/edac/bluefield_edac.c | 425 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 433 insertions(+)
 create mode 100644 drivers/edac/bluefield_edac.c

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index e286b5b..3bcb8fe 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -475,4 +475,11 @@ config EDAC_QCOM
 	  For debugging issues having to do with stability and overall system
 	  health, you should probably say 'Y' here.
 
+config EDAC_BLUEFIELD
+	tristate "Mellanox BlueField Memory ECC"
+	depends on (MELLANOX_PLATFORM && ARM64 && ACPI) || COMPILE_TEST
+	help
+	  Support for error detection and correction on the
+	  Mellanox BlueField SoCs.
+
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 716096d..6dd5e67 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -78,3 +78,4 @@ obj-$(CONFIG_EDAC_SYNOPSYS)		+= synopsys_edac.o
 obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
 obj-$(CONFIG_EDAC_TI)			+= ti_edac.o
 obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
+obj-$(CONFIG_EDAC_BLUEFIELD)		+= bluefield_edac.o
diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.c
new file mode 100644
index 0000000..bdcf0cc
--- /dev/null
+++ b/drivers/edac/bluefield_edac.c
@@ -0,0 +1,425 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Bluefield-specific EDAC driver.
+ *
+ * Copyright (c) 2019 Mellanox Technologies.
+ */
+
+#include <linux/acpi.h>
+#include <linux/arm-smccc.h>
+#include <linux/edac.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "edac_module.h"
+
+#define DRIVER_NAME		"bluefield-edac"
+
+/*
+ * Mellanox BlueField EMI (External Memory Interface) register definitions.
+ * Registers which have individual bitfields have a union defining the
+ * bitfields following the address define.
+ */
+
+#define MLXBF_EMI_DRAM_ECC_COUNT 0x340
+
+union MLXBF_EMI_DRAM_ECC_COUNT_u {
+	struct {
+		/* ECC single errors counter */
+		u32 single_error_count : 16;
+		/* ECC double errors counter */
+		u32 double_error_count : 16;
+	};
+
+	u32 word;
+};
+
+#define MLXBF_EMI_DRAM_ECC_ERROR 0x348
+
+union MLXBF_EMI_DRAM_ECC_ERROR_u {
+	struct {
+		/* 1 - ECC single error from DRAM wrapper x. */
+		u32 dram_ecc_single : 1;
+		/* Reserved. */
+		u32 __reserved_0    : 15;
+		/* 1 - ECC double error from DRAM wrapper x. */
+		u32 dram_ecc_double : 1;
+		/* Reserved. */
+		u32 __reserved_1    : 15;
+	};
+
+	u32 word;
+};
+
+#define MLXBF_EMI_DRAM_ECC_LATCH_SELECT 0x354
+
+union MLXBF_EMI_DRAM_ECC_LATCH_SELECT_u {
+	struct {
+		/*
+		 * For DRAM wrapper x.
+		 *
+		 * 0 - Last ECC error will be stored.
+		 *
+		 * 1 - First ECC error will be stored.
+		 */
+		u32 dram_ecc_first : 1;
+		/* Reserved. */
+		u32 __reserved_0   : 15;
+		/* Selects to Edge (one of 8) to get the ECC info. */
+		u32 edge_sel       : 4;
+		/* Reserved. */
+		u32 __reserved_1   : 4;
+		/* 1 - Start select DRAM_INFO */
+		u32 start          : 1;
+		/* Reserved. */
+		u32 __reserved_2   : 7;
+	};
+
+	u32 word;
+};
+
+#define MLXBF_EMI_DRAM_ERR_ADDR_0 0x358
+
+#define MLXBF_EMI_DRAM_ERR_ADDR_1 0x37c
+
+#define MLXBF_EMI_DRAM_SYNDROM 0x35c
+
+union MLXBF_EMI_DRAM_SYNDROM_u {
+	struct {
+		/* 1 - Double error. */
+		u32 derr         : 1;
+		/* 1 - Single error. */
+		u32 serr         : 1;
+		/* Reserved. */
+		u32 __reserved_0 : 14;
+		/* ECC syndrome (error bit according to the Hamming code). */
+		u32 syndrom      : 10;
+		/* Reserved. */
+		u32 __reserved_1 : 6;
+	};
+
+	u32 word;
+};
+
+#define MLXBF_EMI_DRAM_ADDITIONAL_INFO_0 0x364
+
+union MLXBF_EMI_DRAM_ADDITIONAL_INFO_0_u {
+	struct {
+		/* Physical Error Bank. */
+		u32 err_bank     : 4;
+		/* Physical Error Logical Rank. */
+		u32 err_lrank    : 2;
+		/* Reserved. */
+		u32 __reserved_0 : 2;
+		/* Physical Error Physical Rank. */
+		u32 err_prank    : 2;
+		/* Reserved. */
+		u32 __reserved_1 : 6;
+		/* Error Edge Bitmap. */
+		u32 err_edge     : 8;
+		/* Reserved. */
+		u32 __reserved_2 : 8;
+	};
+
+	u32 word;
+};
+
+#define MLXBF_EDAC_DIMM_PER_MC		2
+#define MLXBF_EDAC_ERROR_GRAIN		8
+
+/*
+ * Request MLNX_SIP_GET_DIMM_INFO
+ *
+ * Retrieve information about DIMM on a certaion slot.
+ *
+ * Call register usage:
+ * a0: MLNX_SIP_GET_DIMM_INFO
+ * a1: (Memory controller index) << 16 | (Dimm index in memory controller)
+ * a2-7: not used.
+ *
+ * Return status:
+ * a0: dimm_info_smc union defined below describing the DIMM.
+ * a1-3: not used.
+ */
+#define MLNX_SIP_GET_DIMM_INFO		0x82000008
+
+/* Format for the SMC response about the memory information */
+union dimm_info_smc {
+	struct {
+		unsigned long size_GB : 16;	/* Dimm size in GB */
+		unsigned long is_rdimm : 1;	/* If is RDIMM/LRDIMM */
+		unsigned long is_lrdimm : 1;	/* If is LRDIMM */
+		unsigned long is_nvdimm : 1;	/* If is NVDIMM */
+		unsigned long __reserved0 : 2;
+		unsigned long ranks : 3;	/* Rank num of DIMM */
+		unsigned long package_X : 8;	/* Bits per memory package */
+		unsigned long __reserved1 : 32;
+	};
+	unsigned long val;
+};
+
+struct bluefield_edac_priv {
+	int dimm_ranks[MLXBF_EDAC_DIMM_PER_MC]; /* How many ranks in dimm */
+	void __iomem *emi_base;
+};
+
+static unsigned long smc_call1(unsigned long smc_op, unsigned long smc_arg)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(smc_op, smc_arg, 0, 0, 0, 0, 0, 0, &res);
+
+	return res.a0;
+}
+
+/*
+ * Gather the ECC information from the External Memory Interface registers
+ * and report it to the edac handler.
+ */
+static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
+					int error_cnt,
+					int is_single_ecc)
+{
+	struct bluefield_edac_priv *priv = mci->pvt_info;
+	union MLXBF_EMI_DRAM_ADDITIONAL_INFO_0_u edai0;
+	union MLXBF_EMI_DRAM_ECC_LATCH_SELECT_u edels;
+	union MLXBF_EMI_DRAM_SYNDROM_u eds;
+	enum hw_event_mc_err_type ecc_type;
+	unsigned long ecc_dimm_addr;
+	int ecc_dimm;
+	u32 edea0;
+	u32 edea1;
+
+	ecc_type = is_single_ecc ? HW_EVENT_ERR_CORRECTED :
+				   HW_EVENT_ERR_UNCORRECTED;
+
+	/*
+	 * Tell the External Memory Interface to populate the relavent
+	 * registers with information about the last ECC error occurrence.
+	 */
+	edels.word = 0;
+	edels.start = 1;
+	writel(edels.word, priv->emi_base + MLXBF_EMI_DRAM_ECC_LATCH_SELECT);
+
+	/*
+	 * Verify that the ECC reported info in the registers is of the
+	 * same type as the one asked to report. If not, just report the
+	 * error without the detailed information.
+	 */
+	eds.word = readl(priv->emi_base + MLXBF_EMI_DRAM_SYNDROM);
+
+	if ((is_single_ecc && !eds.serr) || (!is_single_ecc && !eds.derr)) {
+		edac_mc_handle_error(ecc_type, mci, error_cnt, 0, 0, 0,
+				     0, 0, -1, mci->ctl_name, "");
+		return;
+	}
+
+	edai0.word = readl(priv->emi_base + MLXBF_EMI_DRAM_ADDITIONAL_INFO_0);
+
+	ecc_dimm = edai0.err_prank >= 2 && priv->dimm_ranks[0] <= 2;
+
+	edea0 = readl(priv->emi_base + MLXBF_EMI_DRAM_ERR_ADDR_0);
+	edea1 = readl(priv->emi_base + MLXBF_EMI_DRAM_ERR_ADDR_1);
+
+	ecc_dimm_addr = ((unsigned long)edea1 << 32) | edea0;
+
+	edac_mc_handle_error(ecc_type, mci, error_cnt,
+			     ecc_dimm_addr / 0x1000, ecc_dimm_addr & 0xfff,
+			     eds.syndrom, ecc_dimm, 0, 0, mci->ctl_name, "");
+}
+
+static void bluefield_edac_check(struct mem_ctl_info *mci)
+{
+	union MLXBF_EMI_DRAM_ECC_ERROR_u edee = { .word = 0 };
+	struct bluefield_edac_priv *priv = mci->pvt_info;
+	union MLXBF_EMI_DRAM_ECC_COUNT_u edec;
+
+	/*
+	 * The memory controller might not be initialized by the firmware
+	 * when there isn't memory, which may lead to bad register readings.
+	 */
+	if (mci->edac_cap == EDAC_FLAG_NONE)
+		return;
+
+	edec.word = readl(priv->emi_base + MLXBF_EMI_DRAM_ECC_COUNT);
+
+	if (edec.single_error_count != 0) {
+		edee.dram_ecc_single = 1;
+
+		bluefield_gather_report_ecc(mci, edec.single_error_count, 1);
+	}
+
+	if (edec.double_error_count != 0) {
+		edee.dram_ecc_double = 1;
+
+		bluefield_gather_report_ecc(mci, edec.double_error_count, 0);
+	}
+
+	/* Write to clear reported errors. */
+	if (edec.word != 0)
+		writel(edee.word, priv->emi_base + MLXBF_EMI_DRAM_ECC_ERROR);
+}
+
+/* Initialize the DIMMs information for the given memory controller. */
+static void bluefield_edac_init_dimms(struct mem_ctl_info *mci)
+{
+	struct bluefield_edac_priv *priv = mci->pvt_info;
+	int mem_ctrl_idx = mci->mc_idx;
+	union dimm_info_smc smc_info;
+	struct dimm_info *dimm;
+	unsigned long smc_arg;
+	int is_empty = 1;
+	int i;
+
+	for (i = 0; i < MLXBF_EDAC_DIMM_PER_MC; i++) {
+		dimm = mci->dimms[i];
+
+		smc_arg = mem_ctrl_idx << 16 | i;
+		smc_info = (union dimm_info_smc) {
+			.val = smc_call1(MLNX_SIP_GET_DIMM_INFO, smc_arg),
+		};
+
+		if (smc_info.size_GB == 0) {
+			dimm->mtype = MEM_EMPTY;
+			continue;
+		}
+
+		is_empty = 0;
+
+		dimm->edac_mode = EDAC_SECDED;
+
+		if (smc_info.is_nvdimm)
+			dimm->mtype = MEM_NVDIMM;
+		else if (smc_info.is_lrdimm)
+			dimm->mtype = MEM_LRDDR4;
+		else if (smc_info.is_rdimm)
+			dimm->mtype = MEM_RDDR4;
+		else
+			dimm->mtype = MEM_DDR4;
+
+		dimm->nr_pages = smc_info.size_GB * 256 * 1024;
+		dimm->grain = MLXBF_EDAC_ERROR_GRAIN;
+
+		/* Mem controller for BlueField only supports x4, x8 and x16 */
+		if (smc_info.package_X == 4)
+			dimm->dtype = DEV_X4;
+		else if (smc_info.package_X == 8)
+			dimm->dtype = DEV_X8;
+		else if (smc_info.package_X == 16)
+			dimm->dtype = DEV_X16;
+		else
+			dimm->dtype = DEV_UNKNOWN;
+
+		priv->dimm_ranks[i] = smc_info.ranks;
+	}
+
+	if (is_empty)
+		mci->edac_cap = EDAC_FLAG_NONE;
+	else
+		mci->edac_cap = EDAC_FLAG_SECDED;
+}
+
+static int bluefield_edac_mc_probe(struct platform_device *pdev)
+{
+	struct bluefield_edac_priv *priv;
+	struct device *dev = &pdev->dev;
+	struct edac_mc_layer layers[1];
+	struct mem_ctl_info *mci;
+	struct resource *emi_res;
+	unsigned int mc_idx;
+	int rc, ret;
+
+	/* Only POLL mode supported so far. */
+	edac_op_state = EDAC_OPSTATE_POLL;
+
+	/* Read the MSS (Memory SubSystem) index from ACPI table. */
+	if (device_property_read_u32(dev, "mss_number", &mc_idx)) {
+		dev_warn(dev, "bf_edac: MSS number unknown\n");
+		return -EINVAL;
+	}
+
+	emi_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!emi_res)
+		return -EINVAL;
+
+	layers[0].type = EDAC_MC_LAYER_SLOT;
+	layers[0].size = MLXBF_EDAC_DIMM_PER_MC;
+	layers[0].is_virt_csrow = true;
+
+	mci = edac_mc_alloc(mc_idx, ARRAY_SIZE(layers), layers, sizeof(*priv));
+	if (mci == NULL)
+		return -ENOMEM;
+
+	priv = mci->pvt_info;
+
+	priv->emi_base = devm_ioremap_resource(dev, emi_res);
+	if (IS_ERR(priv->emi_base)) {
+		dev_err(dev, "failed to map EMI IO resource\n");
+		ret = PTR_ERR(priv->emi_base);
+		goto err;
+	}
+
+	mci->pdev = dev;
+	mci->mtype_cap = MEM_FLAG_DDR4 | MEM_FLAG_RDDR4 |
+			 MEM_FLAG_LRDDR4 | MEM_FLAG_NVDIMM;
+	mci->edac_ctl_cap = EDAC_FLAG_SECDED;
+
+	mci->mod_name = DRIVER_NAME;
+	mci->ctl_name = "BlueField_Memory_Controller";
+	mci->dev_name = dev_name(dev);
+	mci->edac_check = bluefield_edac_check;
+
+	/* Initialize mci with the actual populated DIMM information. */
+	bluefield_edac_init_dimms(mci);
+
+	platform_set_drvdata(pdev, mci);
+
+	/* Register with EDAC core */
+	rc = edac_mc_add_mc(mci);
+	if (rc) {
+		dev_err(dev, "failed to register with EDAC core\n");
+		ret = rc;
+		goto err;
+	}
+
+	return 0;
+
+err:
+	edac_mc_free(mci);
+
+	return ret;
+
+}
+
+static int bluefield_edac_mc_remove(struct platform_device *pdev)
+{
+	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
+
+	edac_mc_del_mc(&pdev->dev);
+	edac_mc_free(mci);
+
+	return 0;
+}
+
+static const struct acpi_device_id bluefield_mc_acpi_ids[] = {
+	{"MLNXBF08", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(acpi, bluefield_mc_acpi_ids);
+
+static struct platform_driver bluefield_edac_mc_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.acpi_match_table = bluefield_mc_acpi_ids,
+	},
+	.probe = bluefield_edac_mc_probe,
+	.remove = bluefield_edac_mc_remove,
+};
+
+module_platform_driver(bluefield_edac_mc_driver);
+
+MODULE_DESCRIPTION("Mellanox BlueField memory edac driver");
+MODULE_AUTHOR("Mellanox Technologies");
+MODULE_LICENSE("GPL v2");
-- 
2.1.2

