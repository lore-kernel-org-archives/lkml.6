Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E769C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26072089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26072089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933589AbeGIUPG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 16:15:06 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:41151 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933247AbeGIUOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 16:14:35 -0400
X-IronPort-AV: E=Sophos;i="5.51,330,1526367600"; 
   d="scan'208";a="39007203"
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by labrats.qualcomm.com with ESMTP; 09 Jul 2018 13:08:25 -0700
X-IronPort-AV: E=McAfee;i="5900,7806,8949"; a="115965964"
Received: from sdias-linux.qualcomm.com (HELO sdias-linux1.qualcomm.com) ([192.168.140.71])
  by ironmsg04-sd.qualcomm.com with ESMTP; 09 Jul 2018 13:08:24 -0700
Received: by sdias-linux1.qualcomm.com (Postfix, from userid 84243)
        id 90076150B; Mon,  9 Jul 2018 13:08:24 -0700 (PDT)
From:   Sujeev Dias <sdias@codeaurora.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Sujeev Dias <sdias@codeaurora.org>,
        Tony Truong <truong@codeaurora.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Subject: [PATCH v2 6/7] mhi_bus: controller: MHI support for QCOM modems
Date:   Mon,  9 Jul 2018 13:08:13 -0700
Message-Id: <1531166894-30984-7-git-send-email-sdias@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531166894-30984-1-git-send-email-sdias@codeaurora.org>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
 <1531166894-30984-1-git-send-email-sdias@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCOM PCIe based modems uses MHI as the communication protocol.
MHI control driver is the bus master for such modems. As the bus
master driver, it oversees power management operations
such as suspend, resume, powering on and off the device.

Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
Reviewed-by: Tony Truong <truong@codeaurora.org>
Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
---
 Documentation/devicetree/bindings/bus/mhi_qcom.txt |  58 +++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/bus/Kconfig                                |   1 +
 drivers/bus/mhi/Makefile                           |   1 +
 drivers/bus/mhi/controllers/Kconfig                |  13 +
 drivers/bus/mhi/controllers/Makefile               |   1 +
 drivers/bus/mhi/controllers/mhi_qcom.c             | 461 +++++++++++++++++++++
 drivers/bus/mhi/controllers/mhi_qcom.h             |  67 +++
 8 files changed, 603 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/mhi_qcom.txt
 create mode 100644 drivers/bus/mhi/controllers/Kconfig
 create mode 100644 drivers/bus/mhi/controllers/Makefile
 create mode 100644 drivers/bus/mhi/controllers/mhi_qcom.c
 create mode 100644 drivers/bus/mhi/controllers/mhi_qcom.h

diff --git a/Documentation/devicetree/bindings/bus/mhi_qcom.txt b/Documentation/devicetree/bindings/bus/mhi_qcom.txt
new file mode 100644
index 0000000..0a48a50
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/mhi_qcom.txt
@@ -0,0 +1,58 @@
+Qualcomm Technologies Inc MHI Bus controller
+
+MHI control driver enables clients to communicate with external mode
+using MHI protocol.
+
+==============
+Node Structure
+==============
+
+Main node properties:
+
+- reg
+  Usage: required
+  Value type: Array (5-cell PCI resource) of <u32>
+  Definition: First cell is devfn, which is determined by pci bus topology.
+	Assign the other cells 0 since they are not used.
+
+- qcom,smmu-cfg
+  Usage: required
+  Value type: <u32>
+  Definition: Required SMMU configuration bitmask for PCIe bus.
+	BIT mask:
+	BIT(0) : Attach address mapping to endpoint device
+	BIT(1) : Set attribute S1_BYPASS
+	BIT(2) : Set attribute FAST
+	BIT(3) : Set attribute ATOMIC
+	BIT(4) : Set attribute FORCE_COHERENT
+
+- qcom,addr-win
+  Usage: required if SMMU S1 translation is enabled
+  Value type: Array of <u64>
+  Definition: Pair of values describing iova start and stop address
+
+- MHI bus settings
+  Usage: required
+  Values: as defined by mhi.txt
+  Definition: Per definition of devicetree/bindings/bus/mhi.txt, define device
+	specific MHI configuration parameters.
+
+========
+Example:
+========
+
+/* pcie domain (root complex) modem connected to */
+&pcie1 {
+	/* pcie bus modem connected to */
+	pci,bus@1 {
+		reg = <0 0 0 0 0>;
+
+		qcom,mhi {
+			reg = <0 0 0 0 0>;
+			qcom,smmu-cfg = <0x3d>;
+			qcom,addr-win = <0x0 0x20000000 0x0 0x3fffffff>;
+
+			<mhi bus configurations>
+		};
+	};
+};
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3562026..fd36426 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -168,6 +168,7 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DMA_CMA=y
 CONFIG_MHI_BUS=y
+CONFIG_MHI_QCOM=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 080d3c2..8c6827a 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -180,5 +180,6 @@ config MHI_BUS
 	  devices that support MHI protocol.
 
 source "drivers/bus/fsl-mc/Kconfig"
+source drivers/bus/mhi/controllers/Kconfig
 
 endmenu
diff --git a/drivers/bus/mhi/Makefile b/drivers/bus/mhi/Makefile
index f8f14f7..3458ba3 100644
--- a/drivers/bus/mhi/Makefile
+++ b/drivers/bus/mhi/Makefile
@@ -4,3 +4,4 @@
 
 # core layer
 obj-y += core/
+obj-y += controllers/
\ No newline at end of file
diff --git a/drivers/bus/mhi/controllers/Kconfig b/drivers/bus/mhi/controllers/Kconfig
new file mode 100644
index 0000000..2586cc4
--- /dev/null
+++ b/drivers/bus/mhi/controllers/Kconfig
@@ -0,0 +1,13 @@
+menu "MHI controllers"
+
+config MHI_QCOM
+       tristate "MHI QCOM"
+       depends on MHI_BUS
+       help
+	  If you say yes to this option, MHI bus support for QCOM modem chipsets
+	  will be enabled. QCOM PCIe based modems uses MHI as the communication
+	  protocol. MHI control driver is the bus master for such modems. As the
+	  bus master driver, it oversees power management operations such as
+	  suspend, resume, powering on and off the device.
+
+endmenu
diff --git a/drivers/bus/mhi/controllers/Makefile b/drivers/bus/mhi/controllers/Makefile
new file mode 100644
index 0000000..292f696
--- /dev/null
+++ b/drivers/bus/mhi/controllers/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_MHI_QCOM) += mhi_qcom.o
diff --git a/drivers/bus/mhi/controllers/mhi_qcom.c b/drivers/bus/mhi/controllers/mhi_qcom.c
new file mode 100644
index 0000000..62620d1
--- /dev/null
+++ b/drivers/bus/mhi/controllers/mhi_qcom.c
@@ -0,0 +1,461 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/list.h>
+#include <linux/of.h>
+#include <linux/memblock.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/mhi.h>
+#include "mhi_qcom.h"
+
+struct firmware_info {
+	u32 dev_id;
+	const char *fw_image;
+	const char *edl_image;
+};
+
+static const struct firmware_info firmware_table[] = {
+	{.dev_id = 0x305, .fw_image = "sdx50m/sbl1.mbn"},
+	{.dev_id = 0x304, .fw_image = "sbl.mbn", .edl_image = "edl.mbn"},
+	/* default, set to debug.mbn */
+	{.fw_image = "debug.mbn"},
+};
+
+void mhi_deinit_pci_dev(struct mhi_controller *mhi_cntrl)
+{
+	struct mhi_dev *mhi_dev = mhi_controller_get_devdata(mhi_cntrl);
+	struct pci_dev *pci_dev = mhi_dev->pci_dev;
+
+	pci_free_irq_vectors(pci_dev);
+	kfree(mhi_cntrl->irq);
+	mhi_cntrl->irq = NULL;
+	iounmap(mhi_cntrl->regs);
+	mhi_cntrl->regs = NULL;
+	pci_clear_master(pci_dev);
+	pci_release_region(pci_dev, mhi_dev->resn);
+	pci_disable_device(pci_dev);
+}
+
+static int mhi_init_pci_dev(struct mhi_controller *mhi_cntrl)
+{
+	struct mhi_dev *mhi_dev = mhi_controller_get_devdata(mhi_cntrl);
+	struct pci_dev *pci_dev = mhi_dev->pci_dev;
+	int ret;
+	resource_size_t start, len;
+	int i;
+
+	mhi_dev->resn = MHI_PCI_BAR_NUM;
+	ret = pci_assign_resource(pci_dev, mhi_dev->resn);
+	if (ret)
+		return ret;
+
+	ret = pci_enable_device(pci_dev);
+	if (ret)
+		goto error_enable_device;
+
+	ret = pci_request_region(pci_dev, mhi_dev->resn, "mhi");
+	if (ret)
+		goto error_request_region;
+
+	pci_set_master(pci_dev);
+
+	start = pci_resource_start(pci_dev, mhi_dev->resn);
+	len = pci_resource_len(pci_dev, mhi_dev->resn);
+	mhi_cntrl->regs = ioremap_nocache(start, len);
+	if (!mhi_cntrl->regs)
+		goto error_ioremap;
+
+	ret = pci_alloc_irq_vectors(pci_dev, mhi_cntrl->msi_required,
+				    mhi_cntrl->msi_required, PCI_IRQ_MSI);
+	if (IS_ERR_VALUE((ulong)ret) || ret < mhi_cntrl->msi_required)
+		goto error_req_msi;
+
+	mhi_cntrl->msi_allocated = ret;
+	mhi_cntrl->irq = kmalloc_array(mhi_cntrl->msi_allocated,
+				       sizeof(*mhi_cntrl->irq), GFP_KERNEL);
+	if (!mhi_cntrl->irq) {
+		ret = -ENOMEM;
+		goto error_alloc_msi_vec;
+	}
+
+	for (i = 0; i < mhi_cntrl->msi_allocated; i++) {
+		mhi_cntrl->irq[i] = pci_irq_vector(pci_dev, i);
+		if (mhi_cntrl->irq[i] < 0) {
+			ret = mhi_cntrl->irq[i];
+			goto error_get_irq_vec;
+		}
+	}
+
+	dev_set_drvdata(&pci_dev->dev, mhi_cntrl);
+
+	/* configure runtime pm */
+	pm_runtime_set_autosuspend_delay(&pci_dev->dev, MHI_RPM_SUSPEND_TMR_MS);
+	pm_runtime_use_autosuspend(&pci_dev->dev);
+	pm_suspend_ignore_children(&pci_dev->dev, true);
+
+	/*
+	 * pci framework will increment usage count (twice) before
+	 * calling local device driver probe function.
+	 * 1st pci.c pci_pm_init() calls pm_runtime_forbid
+	 * 2nd pci-driver.c local_pci_probe calls pm_runtime_get_sync
+	 * Framework expect pci device driver to call
+	 * pm_runtime_put_noidle to decrement usage count after
+	 * successful probe and and call pm_runtime_allow to enable
+	 * runtime suspend.
+	 */
+	pm_runtime_mark_last_busy(&pci_dev->dev);
+	pm_runtime_put_noidle(&pci_dev->dev);
+
+	return 0;
+
+error_get_irq_vec:
+	kfree(mhi_cntrl->irq);
+	mhi_cntrl->irq = NULL;
+
+error_alloc_msi_vec:
+	pci_free_irq_vectors(pci_dev);
+
+error_req_msi:
+	iounmap(mhi_cntrl->regs);
+
+error_ioremap:
+	pci_clear_master(pci_dev);
+
+error_request_region:
+	pci_disable_device(pci_dev);
+
+error_enable_device:
+	pci_release_region(pci_dev, mhi_dev->resn);
+
+	return ret;
+}
+
+static int mhi_runtime_suspend(struct device *dev)
+{
+	int ret = 0;
+	struct mhi_controller *mhi_cntrl = dev_get_drvdata(dev);
+
+	dev_info(mhi_cntrl->dev, "Enter\n");
+
+	mutex_lock(&mhi_cntrl->pm_mutex);
+
+	ret = mhi_pm_suspend(mhi_cntrl);
+	if (ret)
+		goto exit_runtime_suspend;
+
+	ret = mhi_arch_link_off(mhi_cntrl, true);
+
+exit_runtime_suspend:
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+
+	return ret;
+}
+
+static int mhi_runtime_idle(struct device *dev)
+{
+	/*
+	 * RPM framework during runtime resume always calls
+	 * rpm_idle to see if device ready to suspend.
+	 * If dev.power usage_count count is 0, rpm fw will call
+	 * rpm_idle cb to see if device is ready to suspend.
+	 * if cb return 0, or cb not defined the framework will
+	 * assume device driver is ready to suspend;
+	 * therefore, fw will schedule runtime suspend.
+	 * In MHI power management, MHI host shall go to
+	 * runtime suspend only after entering MHI State M2, even if
+	 * usage count is 0.  Return -EBUSY to disable automatic suspend.
+	 */
+	return -EBUSY;
+}
+
+static int mhi_runtime_resume(struct device *dev)
+{
+	int ret = 0;
+	struct mhi_controller *mhi_cntrl = dev_get_drvdata(dev);
+	struct mhi_dev *mhi_dev = mhi_controller_get_devdata(mhi_cntrl);
+
+	dev_info(mhi_cntrl->dev, "Enter\n");
+
+	mutex_lock(&mhi_cntrl->pm_mutex);
+
+	if (!mhi_dev->powered_on) {
+		mutex_unlock(&mhi_cntrl->pm_mutex);
+		return 0;
+	}
+
+	/* turn on link */
+	ret = mhi_arch_link_on(mhi_cntrl);
+	if (ret)
+		goto rpm_resume_exit;
+
+	/* enter M0 state */
+	ret = mhi_pm_resume(mhi_cntrl);
+
+rpm_resume_exit:
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+
+	return ret;
+}
+
+static int mhi_system_resume(struct device *dev)
+{
+	int ret = 0;
+	struct mhi_controller *mhi_cntrl = dev_get_drvdata(dev);
+
+	ret = mhi_runtime_resume(dev);
+	if (ret) {
+		dev_err(mhi_cntrl->dev, "Failed to resume link\n");
+	} else {
+		pm_runtime_set_active(dev);
+		pm_runtime_enable(dev);
+	}
+
+	return ret;
+}
+
+int mhi_system_suspend(struct device *dev)
+{
+	/* if rpm status still active then force suspend */
+	if (!pm_runtime_status_suspended(dev))
+		return mhi_runtime_suspend(dev);
+
+	pm_runtime_set_suspended(dev);
+	pm_runtime_disable(dev);
+
+	return 0;
+}
+
+/* checks if link is down */
+static int mhi_link_status(struct mhi_controller *mhi_cntrl, void *priv)
+{
+	struct mhi_dev *mhi_dev = priv;
+	u16 dev_id;
+	int ret;
+
+	/* try reading device id, if dev id don't match, link is down */
+	ret = pci_read_config_word(mhi_dev->pci_dev, PCI_DEVICE_ID, &dev_id);
+
+	return (ret || dev_id != mhi_cntrl->dev_id) ? -EIO : 0;
+}
+
+static int mhi_runtime_get(struct mhi_controller *mhi_cntrl, void *priv)
+{
+	struct mhi_dev *mhi_dev = priv;
+	struct device *dev = &mhi_dev->pci_dev->dev;
+
+	return pm_runtime_get(dev);
+}
+
+static void mhi_runtime_put(struct mhi_controller *mhi_cntrl, void *priv)
+{
+	struct mhi_dev *mhi_dev = priv;
+	struct device *dev = &mhi_dev->pci_dev->dev;
+
+	pm_runtime_put_noidle(dev);
+}
+
+static void mhi_status_cb(struct mhi_controller *mhi_cntrl,
+			  void *priv,
+			  enum MHI_CB reason)
+{
+	struct mhi_dev *mhi_dev = priv;
+	struct device *dev = &mhi_dev->pci_dev->dev;
+
+	if (reason == MHI_CB_IDLE) {
+		pm_runtime_mark_last_busy(dev);
+		pm_request_autosuspend(dev);
+	}
+}
+
+static struct mhi_controller *mhi_register_controller(struct pci_dev *pci_dev)
+{
+	struct mhi_controller *mhi_cntrl;
+	struct mhi_dev *mhi_dev;
+	struct device_node *of_node = pci_dev->dev.of_node;
+	const struct firmware_info *firmware_info;
+	bool use_bb;
+	u64 addr_win[2];
+	int ret, i;
+
+	if (!of_node)
+		return ERR_PTR(-ENODEV);
+
+	mhi_cntrl = mhi_alloc_controller(sizeof(*mhi_dev));
+	if (!mhi_cntrl)
+		return ERR_PTR(-ENOMEM);
+
+	mhi_dev = mhi_controller_get_devdata(mhi_cntrl);
+
+	mhi_cntrl->domain = pci_domain_nr(pci_dev->bus);
+	mhi_cntrl->dev_id = pci_dev->device;
+	mhi_cntrl->bus = pci_dev->bus->number;
+	mhi_cntrl->slot = PCI_SLOT(pci_dev->devfn);
+
+	ret = of_property_read_u32(of_node, "qcom,smmu-cfg",
+				   &mhi_dev->smmu_cfg);
+	if (ret)
+		goto error_register;
+
+	use_bb = of_property_read_bool(of_node, "mhi,use-bb");
+
+	/*
+	 * if s1 translation enabled or using bounce buffer pull iova addr
+	 * from dt
+	 */
+	if (use_bb || (mhi_dev->smmu_cfg & MHI_SMMU_ATTACH &&
+		       !(mhi_dev->smmu_cfg & MHI_SMMU_S1_BYPASS))) {
+		ret = of_property_count_elems_of_size(of_node, "qcom,addr-win",
+						      sizeof(addr_win));
+		if (ret != 1)
+			goto error_register;
+		ret = of_property_read_u64_array(of_node, "qcom,addr-win",
+						 addr_win, 2);
+		if (ret)
+			goto error_register;
+	} else {
+		addr_win[0] = memblock_start_of_DRAM();
+		addr_win[1] = memblock_end_of_DRAM();
+	}
+
+	mhi_dev->iova_start = addr_win[0];
+	mhi_dev->iova_stop = addr_win[1];
+
+	/*
+	 * If S1 is enabled, set MHI_CTRL start address to 0 so we can use low
+	 * level mapping api to map buffers outside of smmu domain
+	 */
+	if (mhi_dev->smmu_cfg & MHI_SMMU_ATTACH &&
+	    !(mhi_dev->smmu_cfg & MHI_SMMU_S1_BYPASS))
+		mhi_cntrl->iova_start = 0;
+	else
+		mhi_cntrl->iova_start = addr_win[0];
+
+	mhi_cntrl->iova_stop = mhi_dev->iova_stop;
+	mhi_cntrl->of_node = of_node;
+
+	mhi_dev->pci_dev = pci_dev;
+
+	/* setup power management apis */
+	mhi_cntrl->status_cb = mhi_status_cb;
+	mhi_cntrl->runtime_get = mhi_runtime_get;
+	mhi_cntrl->runtime_put = mhi_runtime_put;
+	mhi_cntrl->link_status = mhi_link_status;
+
+	ret = of_register_mhi_controller(mhi_cntrl);
+	if (ret)
+		goto error_register;
+
+	for (i = 0; i < ARRAY_SIZE(firmware_table); i++) {
+		firmware_info = firmware_table + i;
+		if (mhi_cntrl->dev_id == firmware_info->dev_id)
+			break;
+	}
+
+	mhi_cntrl->fw_image = firmware_info->fw_image;
+	mhi_cntrl->edl_image = firmware_info->edl_image;
+
+	return mhi_cntrl;
+
+error_register:
+	mhi_free_controller(mhi_cntrl);
+
+	return ERR_PTR(-EINVAL);
+}
+
+int mhi_pci_probe(struct pci_dev *pci_dev,
+		  const struct pci_device_id *device_id)
+{
+	struct mhi_controller *mhi_cntrl;
+	u32 domain = pci_domain_nr(pci_dev->bus);
+	u32 bus = pci_dev->bus->number;
+	u32 dev_id = pci_dev->device;
+	u32 slot = PCI_SLOT(pci_dev->devfn);
+	struct mhi_dev *mhi_dev;
+	int ret;
+
+	/* see if we already registered */
+	mhi_cntrl = mhi_bdf_to_controller(domain, bus, slot, dev_id);
+	if (!mhi_cntrl)
+		mhi_cntrl = mhi_register_controller(pci_dev);
+
+	if (IS_ERR(mhi_cntrl))
+		return PTR_ERR(mhi_cntrl);
+
+	mhi_dev = mhi_controller_get_devdata(mhi_cntrl);
+	mhi_dev->powered_on = true;
+
+	ret = mhi_arch_pcie_init(mhi_cntrl);
+	if (ret)
+		return ret;
+
+	ret = mhi_arch_iommu_init(mhi_cntrl);
+	if (ret)
+		goto error_iommu_init;
+
+	ret = mhi_init_pci_dev(mhi_cntrl);
+	if (ret)
+		goto error_init_pci;
+
+	/* start power up sequence */
+	ret = mhi_async_power_up(mhi_cntrl);
+	if (ret)
+		goto error_power_up;
+
+	pm_runtime_mark_last_busy(&pci_dev->dev);
+	pm_runtime_allow(&pci_dev->dev);
+
+	return 0;
+
+error_power_up:
+	mhi_deinit_pci_dev(mhi_cntrl);
+
+error_init_pci:
+	mhi_arch_iommu_deinit(mhi_cntrl);
+
+error_iommu_init:
+	mhi_arch_pcie_deinit(mhi_cntrl);
+
+	return ret;
+}
+
+static const struct dev_pm_ops pm_ops = {
+	SET_RUNTIME_PM_OPS(mhi_runtime_suspend,
+			   mhi_runtime_resume,
+			   mhi_runtime_idle)
+	SET_SYSTEM_SLEEP_PM_OPS(mhi_system_suspend, mhi_system_resume)
+};
+
+static struct pci_device_id mhi_pcie_device_id[] = {
+	{PCI_DEVICE(MHI_PCIE_VENDOR_ID, 0x0300)},
+	{PCI_DEVICE(MHI_PCIE_VENDOR_ID, 0x0301)},
+	{PCI_DEVICE(MHI_PCIE_VENDOR_ID, 0x0302)},
+	{PCI_DEVICE(MHI_PCIE_VENDOR_ID, 0x0303)},
+	{PCI_DEVICE(MHI_PCIE_VENDOR_ID, 0x0304)},
+	{PCI_DEVICE(MHI_PCIE_VENDOR_ID, 0x0305)},
+	{0},
+};
+
+static struct pci_driver mhi_pcie_driver = {
+	.name = "mhi",
+	.id_table = mhi_pcie_device_id,
+	.probe = mhi_pci_probe,
+	.driver = {
+		.pm = &pm_ops
+	}
+};
+
+module_pci_driver(mhi_pcie_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("MHI_CORE");
+MODULE_DESCRIPTION("MHI Host Driver");
diff --git a/drivers/bus/mhi/controllers/mhi_qcom.h b/drivers/bus/mhi/controllers/mhi_qcom.h
new file mode 100644
index 0000000..41acd20
--- /dev/null
+++ b/drivers/bus/mhi/controllers/mhi_qcom.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ */
+#ifndef _MHI_QCOM_
+#define _MHI_QCOM_
+
+/* iova cfg bitmask */
+#define MHI_SMMU_ATTACH BIT(0)
+#define MHI_SMMU_S1_BYPASS BIT(1)
+#define MHI_SMMU_FAST BIT(2)
+#define MHI_SMMU_ATOMIC BIT(3)
+#define MHI_SMMU_FORCE_COHERENT BIT(4)
+
+#define MHI_PCIE_VENDOR_ID (0x17cb)
+#define MHI_RPM_SUSPEND_TMR_MS (1000)
+#define MHI_PCI_BAR_NUM (0)
+
+struct mhi_dev {
+	struct pci_dev *pci_dev;
+	u32 smmu_cfg;
+	int resn;
+	void *arch_info;
+	bool powered_on;
+	dma_addr_t iova_start;
+	dma_addr_t iova_stop;
+};
+
+void mhi_deinit_pci_dev(struct mhi_controller *mhi_cntrl);
+int mhi_pci_probe(struct pci_dev *pci_dev,
+		  const struct pci_device_id *device_id);
+
+static inline int mhi_arch_iommu_init(struct mhi_controller *mhi_cntrl)
+{
+	struct mhi_dev *mhi_dev = mhi_controller_get_devdata(mhi_cntrl);
+
+	mhi_cntrl->dev = &mhi_dev->pci_dev->dev;
+
+	return dma_set_mask_and_coherent(mhi_cntrl->dev, DMA_BIT_MASK(64));
+}
+
+static inline void mhi_arch_iommu_deinit(struct mhi_controller *mhi_cntrl)
+{
+}
+
+static inline int mhi_arch_pcie_init(struct mhi_controller *mhi_cntrl)
+{
+	return 0;
+}
+
+static inline void mhi_arch_pcie_deinit(struct mhi_controller *mhi_cntrl)
+{
+}
+
+static inline int mhi_arch_link_off(struct mhi_controller *mhi_cntrl,
+				    bool graceful)
+{
+	return 0;
+}
+
+static inline int mhi_arch_link_on(struct mhi_controller *mhi_cntrl)
+{
+	return 0;
+}
+
+#endif /* _MHI_QCOM_ */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

