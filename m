Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932671AbeDWXLf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 19:11:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44446 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932609AbeDWXLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 19:11:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7598F60807
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From: Rishabh Bhatnagar <rishabhb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: linux-arm@lists.infradead.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, kyan@codeaurora.org, ckadabi@codeaurora.org,
        evgreen@chromium.org, robh@kernel.org,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v5 2/2] drivers: soc: Add LLCC driver
Date: Mon, 23 Apr 2018 16:09:32 -0700
Message-Id: <1524524972-12014-3-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524524972-12014-1-git-send-email-rishabhb@codeaurora.org>
References: <1524524972-12014-1-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LLCC (Last Level Cache Controller) provides additional cache memory
in the system. LLCC is partitioned into multiple slices and each
slice gets its own priority, size, ID and other config parameters.
LLCC driver programs these parameters for each slice. Clients that
are assigned to use LLCC need to get information such size & ID of the
slice they get and activate or deactivate the slice as needed. LLCC driver
provides API for the clients to perform these operations.

Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 drivers/soc/qcom/Kconfig           |  17 ++
 drivers/soc/qcom/Makefile          |   2 +
 drivers/soc/qcom/llcc-sdm845.c     | 108 +++++++++++
 drivers/soc/qcom/llcc-slice.c      | 380 +++++++++++++++++++++++++++++++++++++
 include/linux/soc/qcom/llcc-qcom.h | 167 ++++++++++++++++
 5 files changed, 674 insertions(+)
 create mode 100644 drivers/soc/qcom/llcc-sdm845.c
 create mode 100644 drivers/soc/qcom/llcc-slice.c
 create mode 100644 include/linux/soc/qcom/llcc-qcom.h

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index e050eb8..2b09321 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -21,6 +21,23 @@ config QCOM_GSBI
           functions for connecting the underlying serial UART, SPI, and I2C
           devices to the output pins.

+config QCOM_LLCC
+	tristate "Qualcomm Technologies, Inc. LLCC driver"
+	depends on ARCH_QCOM
+	help
+	  Qualcomm Technologies, Inc. platform specific
+	  Last Level Cache Controller(LLCC) driver. This provides interfaces
+	  to client's that use the LLCC. Say yes here to enable LLCC slice
+	  driver.
+
+config QCOM_SDM845_LLCC
+	tristate "Qualcomm Technologies, Inc. SDM845 LLCC driver"
+	depends on QCOM_LLCC
+	help
+	  Say yes here to enable the LLCC driver for SDM845. This provides
+	  data required to configure LLCC so that clients can start using the
+	  LLCC slices.
+
 config QCOM_MDT_LOADER
 	tristate
 	select QCOM_SCM
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index dcebf28..e16d6a2 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -12,3 +12,5 @@ obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
 obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
 obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
 obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
+obj-$(CONFIG_QCOM_LLCC) += llcc-slice.o
+obj-$(CONFIG_QCOM_SDM845_LLCC) += llcc-sdm845.o
diff --git a/drivers/soc/qcom/llcc-sdm845.c b/drivers/soc/qcom/llcc-sdm845.c
new file mode 100644
index 0000000..c234a29
--- /dev/null
+++ b/drivers/soc/qcom/llcc-sdm845.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/soc/qcom/llcc-qcom.h>
+
+/*
+ * SCT(System Cache Table) entry contains of the following members:
+ * name: Name of the client's use case for which the llcc slice is used
+ * usecase_id: Unique id for the client's use case
+ * slice_id: llcc slice id for each client
+ * max_cap: The maximum capacity of the cache slice provided in KB
+ * priority: Priority of the client used to select victim line for replacement
+ * fixed_size: Boolean indicating if the slice has a fixed capacity
+ * bonus_ways: Bonus ways are additional ways to be used for any slice,
+ *		if client ends up using more than reserved cache ways. Bonus
+ *		ways are allocated only if they are not reserved for some
+ *		other client.
+ * res_ways: Reserved ways for the cache slice, the reserved ways cannot
+ *		be used by any other client than the one its assigned to.
+ * cache_mode: Each slice operates as a cache, this controls the mode of the
+ *             slice: normal or TCM(Tightly Coupled Memory)
+ * probe_target_ways: Determines what ways to probe for access hit. When
+ *                    configured to 1 only bonus and reserved ways are probed.
+ *                    When configured to 0 all ways in llcc are probed.
+ * dis_cap_alloc: Disable capacity based allocation for a client
+ * retain_on_pc: If this bit is set and client has maintained active vote
+ *               then the ways assigned to this client are not flushed on power
+ *               collapse.
+ * activate_on_init: Activate the slice immediately after the SCT is programmed
+ */
+#define SCT_ENTRY(n, uid, sid, mc, p, fs, bway, rway, cmod, ptw, dca, rp, a) \
+	{					\
+		.name = n,			\
+		.usecase_id = uid,		\
+		.slice_id = sid,		\
+		.max_cap = mc,			\
+		.priority = p,			\
+		.fixed_size = fs,		\
+		.bonus_ways = bway,		\
+		.res_ways = rway,		\
+		.cache_mode = cmod,		\
+		.probe_target_ways = ptw,	\
+		.dis_cap_alloc = dca,		\
+		.retain_on_pc = rp,		\
+		.activate_on_init = a,		\
+	}
+
+static struct llcc_slice_config sdm845_data[] =  {
+	SCT_ENTRY("cpuss",   1,  1,  2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 1),
+	SCT_ENTRY("vidsc0",  2,  2,  512,  2, 1, 0x0,   0x0f0, 0, 0, 1, 1, 0),
+	SCT_ENTRY("vidsc1",  3,  3,  512,  2, 1, 0x0,   0x0f0, 0, 0, 1, 1, 0),
+	SCT_ENTRY("rotator", 4,  4,  563,  2, 1, 0x0,   0x00e, 2, 0, 1, 1, 0),
+	SCT_ENTRY("voice",   5,  5,  2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0),
+	SCT_ENTRY("audio",   6,  6,  2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0),
+	SCT_ENTRY("mdmhpgr", 7,  7,  1024, 2, 0, 0xfc,  0xf00, 0, 0, 1, 1, 0),
+	SCT_ENTRY("modem",   8,  8,  2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0),
+	SCT_ENTRY("compute", 10, 10, 2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0),
+	SCT_ENTRY("gpuhtw",  11, 11, 512,  1, 1, 0xc,   0x0,   0, 0, 1, 1, 0),
+	SCT_ENTRY("gpu",     12, 12, 2304, 1, 0, 0xff0, 0x2,   0, 0, 1, 1, 0),
+	SCT_ENTRY("mmuhwt",  13, 13, 256,  2, 0, 0x0,   0x1,   0, 0, 1, 0, 1),
+	SCT_ENTRY("cmptdma", 15, 15, 2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0),
+	SCT_ENTRY("display", 16, 16, 2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0),
+	SCT_ENTRY("videofw", 17, 17, 2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 0),
+	SCT_ENTRY("mdmhpfx", 20, 20, 1024, 2, 1, 0x0,   0xf00, 0, 0, 1, 1, 0),
+	SCT_ENTRY("mdmpgng", 21, 21, 1024, 0, 1, 0x1e,  0x0,   0, 0, 1, 1, 0),
+	SCT_ENTRY("audiohw", 22, 22, 1024, 1, 1, 0xffc, 0x2,   0, 0, 1, 1, 0),
+};
+
+static int sdm845_qcom_llcc_probe(struct platform_device *pdev)
+{
+	return qcom_llcc_probe(pdev, sdm845_data, ARRAY_SIZE(sdm845_data));
+}
+
+static const struct of_device_id sdm845_qcom_llcc_of_match[] = {
+	{ .compatible = "qcom,sdm845-llcc", },
+	{ },
+};
+
+static struct platform_driver sdm845_qcom_llcc_driver = {
+	.driver = {
+		.name = "sdm845-llcc",
+		.owner = THIS_MODULE,
+		.of_match_table = sdm845_qcom_llcc_of_match,
+	},
+	.probe = sdm845_qcom_llcc_probe,
+};
+
+static int __init sdm845_init_qcom_llcc_init(void)
+{
+	return platform_driver_register(&sdm845_qcom_llcc_driver);
+}
+module_init(sdm845_init_qcom_llcc_init);
+
+static void __exit sdm845_exit_qcom_llcc_exit(void)
+{
+	platform_driver_unregister(&sdm845_qcom_llcc_driver);
+}
+module_exit(sdm845_exit_qcom_llcc_exit);
+
+MODULE_DESCRIPTION("QCOM sdm845 LLCC driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/soc/qcom/llcc-slice.c b/drivers/soc/qcom/llcc-slice.c
new file mode 100644
index 0000000..fd2b607
--- /dev/null
+++ b/drivers/soc/qcom/llcc-slice.c
@@ -0,0 +1,380 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/soc/qcom/llcc-qcom.h>
+
+#define ACTIVATE                      0x1
+#define DEACTIVATE                    0x2
+#define ACT_CTRL_OPCODE_ACTIVATE      0x1
+#define ACT_CTRL_OPCODE_DEACTIVATE    0x2
+#define ACT_CTRL_ACT_TRIG             0x1
+#define ACT_CTRL_OPCODE_SHIFT         0x1
+#define ATTR1_PROBE_TARGET_WAYS_SHIFT 0x2
+#define ATTR1_FIXED_SIZE_SHIFT        0x3
+#define ATTR1_PRIORITY_SHIFT          0x4
+#define ATTR1_MAX_CAP_SHIFT           0x10
+#define ATTR0_RES_WAYS_MASK           0x00000fff
+#define ATR0_BONUS_WAYS_MASK          0x0fff0000
+#define ATTR0_BONUS_WAYS_SHIFT        0x10
+#define LLCC_STATUS_READ_DELAY 100
+
+#define CACHE_LINE_SIZE_SHIFT 6
+
+#define LLCC_COMMON_STATUS0		0x0003000c
+#define LLCC_LB_CNT_MASK		0xf0000000
+#define LLCC_LB_CNT_SHIFT		28
+
+#define MAX_CAP_TO_BYTES(n) (n * 1024)
+#define LLCC_TRP_ACT_CTRLn(n) (n * 0x1000)
+#define LLCC_TRP_STATUSn(n)   (4 + n * 0x1000)
+#define LLCC_TRP_ATTR0_CFGn(n) (0x21000 + 0x8 * n)
+#define LLCC_TRP_ATTR1_CFGn(n) (0x21004 + 0x8 * n)
+
+#define BANK_OFFSET_STRIDE	0x80000
+
+static const struct regmap_config llcc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.fast_io = true,
+};
+
+/* Get the slice entry by index */
+static struct llcc_slice_desc *llcc_slice_get_entry(struct device *dev, int n)
+{
+	struct of_phandle_args phargs;
+	struct llcc_drv_data *drv;
+	const struct llcc_slice_config *llcc_data_ptr;
+	struct llcc_slice_desc *desc;
+	struct platform_device *pdev;
+	u32 sz, count;
+
+	if (of_parse_phandle_with_args(dev->of_node, "cache-slices",
+				       "#cache-cells", n, &phargs))
+		return ERR_PTR(-ENODEV);
+
+	pdev = of_find_device_by_node(phargs.np);
+	if (!pdev)
+		return ERR_PTR(-ENODEV);
+
+	drv = platform_get_drvdata(pdev);
+	if (!drv)
+		return ERR_PTR(-EFAULT);
+
+	llcc_data_ptr = drv->cfg;
+	sz = drv->cfg_size;
+	count = 0;
+
+	while (llcc_data_ptr && count < sz) {
+		if (llcc_data_ptr->usecase_id == phargs.args[0])
+			break;
+		llcc_data_ptr++;
+		count++;
+	}
+
+	if (llcc_data_ptr == NULL || count == sz)
+		return ERR_PTR(-ENODEV);
+
+	desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
+	if (!desc)
+		return ERR_PTR(-ENOMEM);
+
+	desc->slice_id = llcc_data_ptr->slice_id;
+	desc->slice_size = llcc_data_ptr->max_cap;
+	desc->dev = &pdev->dev;
+
+	return desc;
+}
+
+/**
+ * llcc_slice_getd - get llcc slice descriptor
+ * @dev: Device pointer of the client
+ * @name: Name of the use case
+ *
+ * A pointer to llcc slice descriptor will be returned on success and
+ * and error pointer is returned on failure
+ */
+struct llcc_slice_desc *llcc_slice_getd(struct device *dev, const char *name)
+{
+	struct device_node *np = dev->of_node;
+	int index = 0;
+	const char *slice_name;
+	struct property *prop;
+
+	if (!of_get_property(np, "cache-slice-names", NULL))
+		return ERR_PTR(-ENOENT);
+
+	of_property_for_each_string(np, "cache-slice-names", prop, slice_name) {
+		if (!strcmp(name, slice_name))
+			break;
+		index++;
+	}
+	return llcc_slice_get_entry(dev, index);
+}
+EXPORT_SYMBOL_GPL(llcc_slice_getd);
+
+/**
+ * llcc_slice_putd - llcc slice descritpor
+ * @desc: Pointer to llcc slice descriptor
+ */
+void llcc_slice_putd(struct llcc_slice_desc *desc)
+{
+	devm_kfree(desc->dev, desc);
+}
+EXPORT_SYMBOL_GPL(llcc_slice_putd);
+
+static int llcc_update_act_ctrl(struct llcc_drv_data *drv, u32 sid,
+				u32 act_ctrl_reg_val, u32 status)
+{
+	u32 act_ctrl_reg;
+	u32 status_reg;
+	u32 slice_status;
+	int ret = 0;
+
+	act_ctrl_reg = drv->bcast_off + LLCC_TRP_ACT_CTRLn(sid);
+	status_reg = drv->bcast_off + LLCC_TRP_STATUSn(sid);
+
+	/* Set the ACTIVE trigger */
+	act_ctrl_reg_val |= ACT_CTRL_ACT_TRIG;
+	ret = regmap_write(drv->regmap, act_ctrl_reg, act_ctrl_reg_val);
+	if (ret)
+		return ret;
+
+	/* Clear the ACTIVE trigger */
+	act_ctrl_reg_val &= ~ACT_CTRL_ACT_TRIG;
+	ret = regmap_write(drv->regmap, act_ctrl_reg, act_ctrl_reg_val);
+	if (ret)
+		return ret;
+
+	ret = regmap_read_poll_timeout(drv->regmap, status_reg, slice_status,
+			!(slice_status & status), 0, LLCC_STATUS_READ_DELAY);
+	return ret;
+}
+
+/**
+ * llcc_slice_activate - Activate the llcc slice
+ * @desc: Pointer to llcc slice descriptor
+ *
+ * A value of zero will be returned on success and a negative errno will
+ * be returned in error cases
+ */
+int llcc_slice_activate(struct llcc_slice_desc *desc)
+{
+	int ret;
+	u32 act_ctrl_val;
+	struct llcc_drv_data *drv;
+
+	drv = dev_get_drvdata(desc->dev);
+	if (!drv)
+		return -EINVAL;
+
+	mutex_lock(&drv->lock);
+	if (test_bit(desc->slice_id, drv->bitmap)) {
+		mutex_unlock(&drv->lock);
+		return 0;
+	}
+
+	act_ctrl_val = ACT_CTRL_OPCODE_ACTIVATE << ACT_CTRL_OPCODE_SHIFT;
+
+	ret = llcc_update_act_ctrl(drv, desc->slice_id, act_ctrl_val,
+				  DEACTIVATE);
+
+	__set_bit(desc->slice_id, drv->bitmap);
+	mutex_unlock(&drv->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(llcc_slice_activate);
+
+/**
+ * llcc_slice_deactivate - Deactivate the llcc slice
+ * @desc: Pointer to llcc slice descriptor
+ *
+ * A value of zero will be returned on success and a negative errno will
+ * be returned in error cases
+ */
+int llcc_slice_deactivate(struct llcc_slice_desc *desc)
+{
+	u32 act_ctrl_val;
+	int ret;
+	struct llcc_drv_data *drv;
+
+	drv = dev_get_drvdata(desc->dev);
+	if (!drv)
+		return -EINVAL;
+
+	mutex_lock(&drv->lock);
+	if (!test_bit(desc->slice_id, drv->bitmap)) {
+		mutex_unlock(&drv->lock);
+		return 0;
+	}
+	act_ctrl_val = ACT_CTRL_OPCODE_DEACTIVATE << ACT_CTRL_OPCODE_SHIFT;
+
+	ret = llcc_update_act_ctrl(drv, desc->slice_id, act_ctrl_val,
+				  ACTIVATE);
+
+	__clear_bit(desc->slice_id, drv->bitmap);
+	mutex_unlock(&drv->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(llcc_slice_deactivate);
+
+/**
+ * llcc_get_slice_id - return the slice id
+ * @desc: Pointer to llcc slice descriptor
+ */
+int llcc_get_slice_id(struct llcc_slice_desc *desc)
+{
+	return desc->slice_id;
+}
+EXPORT_SYMBOL_GPL(llcc_get_slice_id);
+
+/**
+ * llcc_get_slice_size - return the slice id
+ * @desc: Pointer to llcc slice descriptor
+ */
+size_t llcc_get_slice_size(struct llcc_slice_desc *desc)
+{
+	return desc->slice_size;
+}
+EXPORT_SYMBOL_GPL(llcc_get_slice_size);
+
+static int qcom_llcc_cfg_program(struct platform_device *pdev)
+{
+	int i;
+	u32 attr1_cfg;
+	u32 attr0_cfg;
+	u32 attr1_val;
+	u32 attr0_val;
+	u32 max_cap_cacheline;
+	u32 sz;
+	int ret = 0;
+	const struct llcc_slice_config *llcc_table;
+	struct llcc_slice_desc desc;
+	struct llcc_drv_data *drv = platform_get_drvdata(pdev);
+	u32 bcast_off = drv->bcast_off;
+
+	sz = drv->cfg_size;
+	llcc_table = drv->cfg;
+
+	for (i = 0; i < sz; i++) {
+		attr1_cfg = bcast_off +
+				LLCC_TRP_ATTR1_CFGn(llcc_table[i].slice_id);
+		attr0_cfg = bcast_off +
+				LLCC_TRP_ATTR0_CFGn(llcc_table[i].slice_id);
+
+		attr1_val = llcc_table[i].cache_mode;
+		attr1_val |= llcc_table[i].probe_target_ways <<
+				ATTR1_PROBE_TARGET_WAYS_SHIFT;
+		attr1_val |= llcc_table[i].fixed_size <<
+				ATTR1_FIXED_SIZE_SHIFT;
+		attr1_val |= llcc_table[i].priority << ATTR1_PRIORITY_SHIFT;
+
+		max_cap_cacheline = MAX_CAP_TO_BYTES(llcc_table[i].max_cap);
+
+		/* LLCC instances can vary for each target.
+		 * The SW writes to broadcast register which gets propagated
+		 * to each llcc instace (llcc0,.. llccN).
+		 * Since the size of the memory is divided equally amongst the
+		 * llcc instances, we need to configure the max cap accordingly.
+		 */
+		max_cap_cacheline = max_cap_cacheline / drv->num_banks;
+		max_cap_cacheline >>= CACHE_LINE_SIZE_SHIFT;
+		attr1_val |= max_cap_cacheline << ATTR1_MAX_CAP_SHIFT;
+
+		attr0_val = llcc_table[i].res_ways & ATTR0_RES_WAYS_MASK;
+		attr0_val |= llcc_table[i].bonus_ways << ATTR0_BONUS_WAYS_SHIFT;
+
+		ret = regmap_write(drv->regmap, attr1_cfg, attr1_val);
+		if (ret)
+			return ret;
+		ret = regmap_write(drv->regmap, attr0_cfg, attr0_val);
+		if (ret)
+			return ret;
+		if (llcc_table[i].activate_on_init) {
+			desc.slice_id = llcc_table[i].slice_id;
+			desc.dev = &pdev->dev;
+			ret = llcc_slice_activate(&desc);
+		}
+	}
+	return ret;
+}
+
+int qcom_llcc_probe(struct platform_device *pdev,
+		      const struct llcc_slice_config *llcc_cfg, u32 sz)
+{
+
+	u32 num_banks = 0;
+	struct device *dev = &pdev->dev;
+	struct llcc_drv_data *drv_data;
+	struct resource *res;
+	void __iomem *base;
+	int ret = 0;
+	int i;
+
+	drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
+	if (!drv_data)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	drv_data->regmap = devm_regmap_init_mmio(dev, base,
+					&llcc_regmap_config);
+	if (IS_ERR(drv_data->regmap))
+		return PTR_ERR(drv_data->regmap);
+
+	ret = regmap_read(drv_data->regmap, LLCC_COMMON_STATUS0,
+						&num_banks);
+	if (ret)
+		return ret;
+
+	num_banks &= LLCC_LB_CNT_MASK;
+	num_banks >>= LLCC_LB_CNT_SHIFT;
+	drv_data->num_banks = num_banks;
+
+	ret = of_property_read_u32(pdev->dev.of_node, "max-slices",
+				  &drv_data->max_slices);
+	if (ret)
+		return ret;
+
+	drv_data->offsets = devm_kzalloc(dev, num_banks * sizeof(u32),
+							GFP_KERNEL);
+	if (!drv_data->offsets)
+		return -ENOMEM;
+
+	for (i = 0; i < num_banks; i++)
+		drv_data->offsets[i] = (i * BANK_OFFSET_STRIDE);
+
+	drv_data->bcast_off = num_banks * BANK_OFFSET_STRIDE;
+
+	drv_data->bitmap = devm_kcalloc(dev,
+	BITS_TO_LONGS(drv_data->max_slices), sizeof(unsigned long),
+						GFP_KERNEL);
+	if (!drv_data->bitmap)
+		return -ENOMEM;
+
+	bitmap_zero(drv_data->bitmap, drv_data->max_slices);
+	drv_data->cfg = llcc_cfg;
+	drv_data->cfg_size = sz;
+	mutex_init(&drv_data->lock);
+	platform_set_drvdata(pdev, drv_data);
+
+	return qcom_llcc_cfg_program(pdev);
+}
+EXPORT_SYMBOL_GPL(qcom_llcc_probe);
diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
new file mode 100644
index 0000000..934e3db
--- /dev/null
+++ b/include/linux/soc/qcom/llcc-qcom.h
@@ -0,0 +1,167 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#include <linux/platform_device.h>
+#ifndef __LLCC_QCOM__
+#define __LLCC_QCOM__
+/**
+ * llcc_slice_desc - Cache slice descriptor
+ * @slice_id: llcc slice id
+ * @slice_size: Size allocated for the llcc slice
+ * @dev: pointer to llcc device
+ */
+struct llcc_slice_desc {
+	u32 slice_id;
+	size_t slice_size;
+	struct device *dev;
+};
+
+/**
+ * llcc_slice_config - Data associated with the llcc slice
+ * @name: name of the use case associated with the llcc slice
+ * @usecase_id: usecase id for which the llcc slice is used
+ * @slice_id: llcc slice id assigned to each slice
+ * @max_cap: maximum capacity of the llcc slice
+ * @priority: priority of the llcc slice
+ * @fixed_size: whether the llcc slice can grow beyond its size
+ * @bonus_ways: bonus ways associated with llcc slice
+ * @res_ways: reserved ways associated with llcc slice
+ * @cache_mode: mode of the llcc slice
+ * @probe_target_ways: Probe only reserved and bonus ways on a cache miss
+ * @dis_cap_alloc: Disable capacity based allocation
+ * @retain_on_pc: Retain through power collapse
+ * @activate_on_init: activate the slice on init
+ */
+struct llcc_slice_config {
+	const char *name;
+	u32 usecase_id;
+	u32 slice_id;
+	u32 max_cap;
+	u32 priority;
+	bool fixed_size;
+	u32 bonus_ways;
+	u32 res_ways;
+	u32 cache_mode;
+	u32 probe_target_ways;
+	bool dis_cap_alloc;
+	bool retain_on_pc;
+	bool activate_on_init;
+};
+
+/**
+ * llcc_drv_data - Data associated with the llcc driver
+ * @regmap: regmap associated with the llcc device
+ * @cfg: pointer to the data structure for slice configuration
+ * @lock: mutex associated with each slice
+ * @cfg_size: size of the config data table
+ * @max_slices: max slices as read from device tree
+ * @bcast_off: Offset of the broadcast bank
+ * @num_banks: Number of llcc banks
+ * @bitmap: Bit map to track the active slice ids
+ * @offsets: Pointer to the bank offsets array
+ */
+
+struct llcc_drv_data {
+	struct regmap *regmap;
+	const struct llcc_slice_config *cfg;
+	struct mutex lock;
+	u32 cfg_size;
+	u32 max_slices;
+	u32 bcast_off;
+	u32 num_banks;
+	unsigned long *bitmap;
+	u32 *offsets;
+};
+
+#if IS_ENABLED(CONFIG_QCOM_LLCC)
+/**
+ * llcc_slice_getd - get llcc slice descriptor
+ * @dev: Device pointer of the client
+ * @name: Name of the use case
+ */
+struct llcc_slice_desc *llcc_slice_getd(struct device *dev, const char *name);
+
+/**
+ * llcc_slice_putd - llcc slice descritpor
+ * @desc: Pointer to llcc slice descriptor
+ */
+void llcc_slice_putd(struct llcc_slice_desc *desc);
+
+/**
+ * llcc_get_slice_id - get slice id
+ * @desc: Pointer to llcc slice descriptor
+ */
+int llcc_get_slice_id(struct llcc_slice_desc *desc);
+
+/**
+ * llcc_get_slice_size - llcc slice size
+ * @desc: Pointer to llcc slice descriptor
+ */
+size_t llcc_get_slice_size(struct llcc_slice_desc *desc);
+
+/**
+ * llcc_slice_activate - Activate the llcc slice
+ * @desc: Pointer to llcc slice descriptor
+ */
+int llcc_slice_activate(struct llcc_slice_desc *desc);
+
+/**
+ * llcc_slice_deactivate - Deactivate the llcc slice
+ * @desc: Pointer to llcc slice descriptor
+ */
+int llcc_slice_deactivate(struct llcc_slice_desc *desc);
+
+/**
+ * qcom_llcc_probe - program the sct table
+ * @pdev: platform device pointer
+ * @table: soc sct table
+ * @sz: Size of the config table
+ */
+int qcom_llcc_probe(struct platform_device *pdev,
+		      const struct llcc_slice_config *table, u32 sz);
+#else
+static inline struct llcc_slice_desc *llcc_slice_getd(struct device *dev,
+			const char *name)
+{
+	return NULL;
+}
+
+static inline void llcc_slice_putd(struct llcc_slice_desc *desc)
+{
+
+};
+
+static inline int llcc_get_slice_id(struct llcc_slice_desc *desc)
+{
+	return -EINVAL;
+}
+
+static inline size_t llcc_get_slice_size(struct llcc_slice_desc *desc)
+{
+	return 0;
+}
+static inline int llcc_slice_activate(struct llcc_slice_desc *desc)
+{
+	return -EINVAL;
+}
+
+static inline int llcc_slice_deactivate(struct llcc_slice_desc *desc)
+{
+	return -EINVAL;
+}
+static inline int qcom_llcc_probe(struct platform_device *pdev,
+		      const struct llcc_slice_config *table, u32 sz)
+{
+	return -ENODEV;
+}
+
+static inline int qcom_llcc_remove(struct platform_device *pdev)
+{
+	return -ENODEV;
+}
+#endif
+
+#endif
--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
