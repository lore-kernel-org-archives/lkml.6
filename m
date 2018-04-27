Return-Path: <sdias@qualcomm.com>
X-Google-Smtp-Source: AB8JxZrQ0txtH73h1rMR7zCmAajD79oX6nk58g6z5hLNM51duzpCAiML4Z7VSMssFhkHn9dLMsHY
ARC-Seal: i=1; a=rsa-sha256; t=1524795825; cv=none;
        d=google.com; s=arc-20160816;
        b=cgsJyKo+X1sxFectXYSNmNnccUaRQXkLdFNjcUEZxDOnKVOHlnxqYLDywMK9V2n+2V
         FxzMCI4ItsdXhRJqPCrmOivURWKxtAibnfvkPFrAoQCqYT9lhCo9Ir2wE1nCYXsD+PrV
         r0fx35PZ7ihuoatc50ti5zz7Z3RXshKgrWXCondJL9UtWQLFPk+11e4VBAVRvhy2ewD0
         2acDiUt2IIdwzvVkj/2TZ4lwY4ORhmceNp0561JKGWTAhEFhgX/zNjUAT+mX+IDLqHg6
         0pj3XbGN1MSKbjtetTeqQxmMmSTAthGU5yebVpKlGLVpeuoCOdvYefBklWI3K4FLDJkF
         mXOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=7QkeYF5n9E+5d7dBXcX9C/vMCoUigSS0m7iYUAKo2cs=;
        b=LWe55+DBwa6vMgAyFibUDBetXFEYU6xmIP7CdFrliooo8blCUdkdSrECiBuzu0vGh3
         TVCNQ7AqFbMA37DdwT9QFre03ExYgHOnrDC49ZYRmmQRfqwbo85OD5G8nEaqHLGimhR6
         kVFsGUpxK+KeiYS76LdfcO4Z4QblqWpJayX+athK3ocLqtmnAhFBhxEJcOpKv5by3eKI
         GVwgN/j8/qiSFpsYVngs5PWSnhGjS2YfmQ3clxcr254WjkgNKLP2bEZRxflGlvyfcolE
         QWocGVvobC69yFQiWbUpkUgJUrsCOZm5Vgbw/MqDSBBpUV3c9kVzrm57tQwTAFM4Go6L
         4gFg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sdias@qualcomm.com designates 65.197.215.72 as permitted sender) smtp.mailfrom=sdias@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sdias@qualcomm.com designates 65.197.215.72 as permitted sender) smtp.mailfrom=sdias@qualcomm.com
X-IronPort-AV: E=Sophos;i="5.49,333,1520924400";
   d="scan'208";a="126208373"
X-IronPort-AV: E=McAfee;i="5900,7806,8875"; a="71568970"
From: Sujeev Dias <sdias@codeaurora.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Sujeev Dias <sdias@codeaurora.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Tony Truong <truong@codeaurora.org>
Subject: [PATCH v1 2/4] mhi_bus: controller: MHI support for QCOM modems
Date: Thu, 26 Apr 2018 19:23:29 -0700
Message-Id: <1524795811-21399-3-git-send-email-sdias@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598864307361957466?=
X-GMAIL-MSGID: =?utf-8?q?1598864307361957466?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

QCOM PCIe based modems uses MHI as the communication protocol.
MHI control driver is the bus master for such modems. As the bus
master driver, it oversees power management operations
such as suspend, resume, powering on and off the device.

Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
---
 Documentation/devicetree/bindings/bus/mhi_qcom.txt | 110 ++++
 drivers/bus/Kconfig                                |   1 +
 drivers/bus/mhi/Makefile                           |   2 +-
 drivers/bus/mhi/controllers/Kconfig                |  10 +
 drivers/bus/mhi/controllers/Makefile               |   1 +
 drivers/bus/mhi/controllers/mhi_qcom.c             | 686 +++++++++++++++++++++
 drivers/bus/mhi/controllers/mhi_qcom.h             |  85 +++
 7 files changed, 894 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/bus/mhi_qcom.txt
 create mode 100644 drivers/bus/mhi/controllers/Kconfig
 create mode 100644 drivers/bus/mhi/controllers/Makefile
 create mode 100644 drivers/bus/mhi/controllers/mhi_qcom.c
 create mode 100644 drivers/bus/mhi/controllers/mhi_qcom.h

diff --git a/Documentation/devicetree/bindings/bus/mhi_qcom.txt b/Documentation/devicetree/bindings/bus/mhi_qcom.txt
new file mode 100644
index 0000000..c0f8d86
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/mhi_qcom.txt
@@ -0,0 +1,110 @@
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
+- compatible
+  Usage: required
+  Value type: <string>
+  Definition: "qcom,mhi"
+
+- qcom,pci-dev-id
+  Usage: optional
+  Value type: <u32>
+  Definition: PCIe device id of external modem to bind. If not set, any
+	device is compatible with this node.
+
+- qcom,pci-domain
+  Usage: required
+  Value type: <u32>
+  Definition: PCIe root complex external modem connected to
+
+- qcom,pci-bus
+  Usage: required
+  Value type: <u32>
+  Definition: PCIe bus external modem connected to
+
+- qcom,pci-slot
+  Usage: required
+  Value type: <u32>
+  Definition: PCIe slot as assigned by pci framework to external modem
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
+- qcom,msm-bus,name
+  Usage: required
+  Value type: <string>
+  Definition: string representing the bus scale client name to register
+
+- qcom,msm-bus,num-cases
+  Usage: required
+  Value type: <u32>
+  Definition: Must be set to two, MHI support two scales
+
+- qcom,msm-bus,num-paths
+  Usage: required
+  Value type: <u32>
+  Definition: Total number of master-slave pairs MHI host will vote. Must be set
+	to one.
+
+- qcom,msm-bus,vectors-KBps
+  Usage: required
+  Value type: Array of <u32>
+  Definition: Array of tuples which define the bus bandwidth requirements.
+	Each tuple is of length 4, values are master-id, slave-id,
+	arbitrated bandwidth in KBps, and instantaneous bandwidth in
+	KBps.
+
+- esoc-names
+  Usage: optional
+  Value type: <string>
+  Definition: if external modem managed by esoc framework, set string to "mdm"
+
+- esoc-0
+  Usage: required if device is managed by esoc framework
+  Value type: phandle
+  Definition: A esoc phandle pointing to external modem
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
+qcom,mhi {
+	compatible = "qcom,mhi";
+	qcom,pci-domain = <0>;
+	qcom,pci-bus = <1>;
+	qcom,pci-slot = <0>;
+	qcom,smmu-cfg = <0x3d>;
+	qcom,addr-win = <0x0 0x20000000 0x0 0x3fffffff>;
+	qcom,msm-bus,name = "mhi";
+	qcom,msm-bus,num-cases = <2>;
+	qcom,msm-bus,num-paths = <1>;
+	qcom,msm-bus,vectors-KBps = <45 512 0 0>,
+				    <45 512 1200000000 650000000>;
+	<mhi bus configurations>
+};
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index e15d56d..fb28002 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -189,5 +189,6 @@ config MHI_DEBUG
 	   will be logged.
 
 source "drivers/bus/fsl-mc/Kconfig"
+source drivers/bus/mhi/controllers/Kconfig
 
 endmenu
diff --git a/drivers/bus/mhi/Makefile b/drivers/bus/mhi/Makefile
index 9f8f3ac..c6a2a91 100644
--- a/drivers/bus/mhi/Makefile
+++ b/drivers/bus/mhi/Makefile
@@ -4,5 +4,5 @@
 
 # core layer
 obj-y += core/
-#obj-y += controllers/
+obj-y += controllers/
 #obj-y += devices/
diff --git a/drivers/bus/mhi/controllers/Kconfig b/drivers/bus/mhi/controllers/Kconfig
new file mode 100644
index 0000000..e8a90b6
--- /dev/null
+++ b/drivers/bus/mhi/controllers/Kconfig
@@ -0,0 +1,10 @@
+menu "MHI controllers"
+
+config MHI_QCOM
+       tristate "MHI QCOM"
+       depends on MHI_BUS
+       help
+	  If you say yes to this option, MHI bus support for QCOM modem chipsets
+	  will be enabled.
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
index 0000000..642981a
--- /dev/null
+++ b/drivers/bus/mhi/controllers/mhi_qcom.c
@@ -0,0 +1,686 @@
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
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
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/mhi.h>
+#include "mhi_qcom.h"
+
+static struct pci_device_id mhi_pcie_device_id[] = {
+	{PCI_DEVICE(MHI_PCIE_VENDOR_ID, 0x0300)},
+	{PCI_DEVICE(MHI_PCIE_VENDOR_ID, 0x0301)},
+	{PCI_DEVICE(MHI_PCIE_VENDOR_ID, 0x0302)},
+	{PCI_DEVICE(MHI_PCIE_VENDOR_ID, 0x0303)},
+	{PCI_DEVICE(MHI_PCIE_VENDOR_ID, 0x0304)},
+	{PCI_DEVICE(MHI_PCIE_VENDOR_ID, 0x0305)},
+	{PCI_DEVICE(MHI_PCIE_VENDOR_ID, MHI_PCIE_DEBUG_ID)},
+	{0},
+};
+
+static struct pci_driver mhi_pcie_driver;
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
+	if (ret) {
+		MHI_ERR("Error assign pci resources, ret:%d\n", ret);
+		return ret;
+	}
+
+	ret = pci_enable_device(pci_dev);
+	if (ret) {
+		MHI_ERR("Error enabling device, ret:%d\n", ret);
+		goto error_enable_device;
+	}
+
+	ret = pci_request_region(pci_dev, mhi_dev->resn, "mhi");
+	if (ret) {
+		MHI_ERR("Error pci_request_region, ret:%d\n", ret);
+		goto error_request_region;
+	}
+
+	pci_set_master(pci_dev);
+
+	start = pci_resource_start(pci_dev, mhi_dev->resn);
+	len = pci_resource_len(pci_dev, mhi_dev->resn);
+	mhi_cntrl->regs = ioremap_nocache(start, len);
+	if (!mhi_cntrl->regs) {
+		MHI_ERR("Error ioremap region\n");
+		goto error_ioremap;
+	}
+
+	ret = pci_alloc_irq_vectors(pci_dev, mhi_cntrl->msi_required,
+				    mhi_cntrl->msi_required, PCI_IRQ_MSI);
+	if (IS_ERR_VALUE((ulong)ret) || ret < mhi_cntrl->msi_required) {
+		MHI_ERR("Failed to enable MSI, ret:%d\n", ret);
+		goto error_req_msi;
+	}
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
+	MHI_LOG("Enter\n");
+
+	mutex_lock(&mhi_cntrl->pm_mutex);
+
+	ret = mhi_pm_suspend(mhi_cntrl);
+	if (ret) {
+		MHI_LOG("Abort due to ret:%d\n", ret);
+		goto exit_runtime_suspend;
+	}
+
+	ret = mhi_arch_link_off(mhi_cntrl, true);
+	if (ret)
+		MHI_ERR("Failed to Turn off link ret:%d\n", ret);
+
+exit_runtime_suspend:
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+	MHI_LOG("Exited with ret:%d\n", ret);
+
+	return ret;
+}
+
+static int mhi_runtime_idle(struct device *dev)
+{
+	struct mhi_controller *mhi_cntrl = dev_get_drvdata(dev);
+
+	MHI_LOG("Entered returning -EBUSY\n");
+
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
+	MHI_LOG("Enter\n");
+
+	mutex_lock(&mhi_cntrl->pm_mutex);
+
+	if (!mhi_dev->powered_on) {
+		MHI_LOG("Not fully powered, return success\n");
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
+	MHI_LOG("Exited with :%d\n", ret);
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
+		MHI_ERR("Failed to resume link\n");
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
+	struct mhi_controller *mhi_cntrl = dev_get_drvdata(dev);
+
+	MHI_LOG("Entered\n");
+
+	/* if rpm status still active then force suspend */
+	if (!pm_runtime_status_suspended(dev))
+		return mhi_runtime_suspend(dev);
+
+	pm_runtime_set_suspended(dev);
+	pm_runtime_disable(dev);
+
+	MHI_LOG("Exit\n");
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
+		MHI_LOG("Schedule runtime suspend 1\n");
+		pm_runtime_mark_last_busy(dev);
+		pm_request_autosuspend(dev);
+	}
+}
+
+int mhi_debugfs_trigger_m0(void *data, u64 val)
+{
+	struct mhi_controller *mhi_cntrl = data;
+	struct mhi_dev *mhi_dev = mhi_controller_get_devdata(mhi_cntrl);
+
+	MHI_LOG("Trigger M3 Exit\n");
+	pm_runtime_get(&mhi_dev->pci_dev->dev);
+	pm_runtime_put(&mhi_dev->pci_dev->dev);
+
+	return 0;
+}
+
+int mhi_debugfs_trigger_m3(void *data, u64 val)
+{
+	struct mhi_controller *mhi_cntrl = data;
+	struct mhi_dev *mhi_dev = mhi_controller_get_devdata(mhi_cntrl);
+
+	MHI_LOG("Trigger M3 Entry\n");
+	pm_runtime_mark_last_busy(&mhi_dev->pci_dev->dev);
+	pm_request_autosuspend(&mhi_dev->pci_dev->dev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(debugfs_trigger_m0_fops, NULL,
+			mhi_debugfs_trigger_m0, "%llu\n");
+
+DEFINE_SIMPLE_ATTRIBUTE(debugfs_trigger_m3_fops, NULL,
+			mhi_debugfs_trigger_m3, "%llu\n");
+
+static int mhi_init_debugfs_trigger_go(void *data, u64 val)
+{
+	struct mhi_controller *mhi_cntrl = data;
+
+	MHI_LOG("Trigger power up sequence\n");
+
+	mhi_async_power_up(mhi_cntrl);
+
+	return 0;
+}
+DEFINE_SIMPLE_ATTRIBUTE(mhi_init_debugfs_trigger_go_fops, NULL,
+			mhi_init_debugfs_trigger_go, "%llu\n");
+
+
+int mhi_init_debugfs_debug_show(struct seq_file *m, void *d)
+{
+	seq_puts(m, "Enable debug mode to debug  external soc\n");
+	seq_puts(m,
+		 "Usage:  echo 'devid,timeout,domain,smmu_cfg' > debug_mode\n");
+	seq_puts(m, "No spaces between parameters\n");
+	seq_puts(m, "\t1.  devid : 0 or pci device id to register\n");
+	seq_puts(m, "\t2.  timeout: mhi cmd/state transition timeout\n");
+	seq_puts(m, "\t3.  domain: Rootcomplex\n");
+	seq_puts(m, "\t4.  smmu_cfg: smmu configuration mask:\n");
+	seq_puts(m, "\t\t- BIT0: ATTACH\n");
+	seq_puts(m, "\t\t- BIT1: S1 BYPASS\n");
+	seq_puts(m, "\t\t-BIT2: FAST_MAP\n");
+	seq_puts(m, "\t\t-BIT3: ATOMIC\n");
+	seq_puts(m, "\t\t-BIT4: FORCE_COHERENT\n");
+	seq_puts(m, "\t\t-BIT5: GEOMETRY\n");
+	seq_puts(m, "\tAll timeout are in ms, enter 0 to keep default\n");
+	seq_puts(m, "Examples inputs: '0x307,10000'\n");
+	seq_puts(m, "\techo '0,10000,1'\n");
+	seq_puts(m, "\techo '0x307,10000,0,0x3d'\n");
+	seq_puts(m, "firmware image name will be changed to debug.mbn\n");
+
+	return 0;
+}
+
+static int mhi_init_debugfs_debug_open(struct inode *node, struct file *file)
+{
+	return single_open(file, mhi_init_debugfs_debug_show, NULL);
+}
+
+static ssize_t mhi_init_debugfs_debug_write(struct file *fp,
+					    const char __user *ubuf,
+					    size_t count,
+					    loff_t *pos)
+{
+	char *buf = kmalloc(count + 1, GFP_KERNEL);
+	/* #,devid,timeout,domain,smmu-cfg */
+	int args[5] = {0};
+	static char const *dbg_fw = "debug.mbn";
+	int ret;
+	struct mhi_controller *mhi_cntrl = fp->f_inode->i_private;
+	struct mhi_dev *mhi_dev = mhi_controller_get_devdata(mhi_cntrl);
+	struct pci_device_id *id;
+
+	if (!buf)
+		return -ENOMEM;
+
+	ret = copy_from_user(buf, ubuf, count);
+	if (ret)
+		goto error_read;
+	buf[count] = 0;
+	get_options(buf, ARRAY_SIZE(args), args);
+	kfree(buf);
+
+	/* override default parameters */
+	mhi_cntrl->fw_image = dbg_fw;
+	mhi_cntrl->edl_image = dbg_fw;
+
+	if (args[0] >= 2 && args[2])
+		mhi_cntrl->timeout_ms = args[2];
+
+	if (args[0] >= 3 && args[3])
+		mhi_cntrl->domain = args[3];
+
+	if (args[0] >= 4 && args[4])
+		mhi_dev->smmu_cfg = args[4];
+
+	/* If it's a new device id register it */
+	if (args[0] && args[1]) {
+		/* find the debug_id  and overwrite it */
+		for (id = mhi_pcie_device_id; id->vendor; id++)
+			if (id->device == MHI_PCIE_DEBUG_ID) {
+				id->device = args[1];
+				pci_unregister_driver(&mhi_pcie_driver);
+				ret = pci_register_driver(&mhi_pcie_driver);
+			}
+	}
+
+	mhi_dev->debug_mode = true;
+	debugfs_create_file("go", 0444, mhi_cntrl->parent, mhi_cntrl,
+			    &mhi_init_debugfs_trigger_go_fops);
+	pr_info(
+		"%s: ret:%d pcidev:0x%x smm_cfg:%u timeout:%u\n",
+		__func__, ret, args[1], mhi_dev->smmu_cfg,
+		mhi_cntrl->timeout_ms);
+	return count;
+
+error_read:
+	kfree(buf);
+	return ret;
+}
+
+static const struct file_operations debugfs_debug_ops = {
+	.open = mhi_init_debugfs_debug_open,
+	.release = single_release,
+	.read = seq_read,
+	.write = mhi_init_debugfs_debug_write,
+};
+
+int mhi_pci_probe(struct pci_dev *pci_dev,
+		  const struct pci_device_id *device_id)
+{
+	struct mhi_controller *mhi_cntrl = NULL;
+	u32 domain = pci_domain_nr(pci_dev->bus);
+	u32 bus = pci_dev->bus->number;
+	/* first match to exact DT node, if not match to any free DT */
+	u32 dev_id[] = {pci_dev->device, PCI_ANY_ID};
+	u32 slot = PCI_SLOT(pci_dev->devfn);
+	struct mhi_dev *mhi_dev;
+	int i, ret;
+
+	/* find a matching controller */
+	for (i = 0; i < ARRAY_SIZE(dev_id); i++) {
+		mhi_cntrl = mhi_bdf_to_controller(domain, bus, slot, dev_id[i]);
+		if (mhi_cntrl)
+			break;
+	}
+
+	if (!mhi_cntrl)
+		return -EPROBE_DEFER;
+
+	mhi_cntrl->dev_id = pci_dev->device;
+	mhi_dev = mhi_controller_get_devdata(mhi_cntrl);
+	mhi_dev->pci_dev = pci_dev;
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
+	/* start power up sequence if not in debug mode */
+	if (!mhi_dev->debug_mode) {
+		ret = mhi_async_power_up(mhi_cntrl);
+		if (ret)
+			goto error_power_up;
+	}
+
+	pm_runtime_mark_last_busy(&pci_dev->dev);
+	pm_runtime_allow(&pci_dev->dev);
+
+	if (mhi_cntrl->dentry) {
+		debugfs_create_file("m0", 0444, mhi_cntrl->dentry, mhi_cntrl,
+				    &debugfs_trigger_m0_fops);
+		debugfs_create_file("m3", 0444, mhi_cntrl->dentry, mhi_cntrl,
+				    &debugfs_trigger_m3_fops);
+	}
+
+	MHI_LOG("Return successful\n");
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
+static const struct of_device_id mhi_plat_match[] = {
+	{ .compatible = "qcom,mhi" },
+	{},
+};
+
+static int mhi_platform_probe(struct platform_device *pdev)
+{
+	struct mhi_controller *mhi_cntrl;
+	struct mhi_dev *mhi_dev;
+	struct device_node *of_node = pdev->dev.of_node;
+	u64 addr_win[2];
+	int ret;
+
+	if (!of_node)
+		return -ENODEV;
+
+	mhi_cntrl = mhi_alloc_controller(sizeof(*mhi_dev));
+	if (!mhi_cntrl)
+		return -ENOMEM;
+
+	mhi_dev = mhi_controller_get_devdata(mhi_cntrl);
+
+	/* get pci bus topology for this node */
+	ret = of_property_read_u32(of_node, "qcom,pci-dev-id",
+				   &mhi_cntrl->dev_id);
+	if (ret)
+		mhi_cntrl->dev_id = PCI_ANY_ID;
+
+	ret = of_property_read_u32(of_node, "qcom,pci-domain",
+				   &mhi_cntrl->domain);
+	if (ret)
+		goto error_probe;
+
+	ret = of_property_read_u32(of_node, "qcom,pci-bus", &mhi_cntrl->bus);
+	if (ret)
+		goto error_probe;
+
+	ret = of_property_read_u32(of_node, "qcom,pci-slot", &mhi_cntrl->slot);
+	if (ret)
+		goto error_probe;
+
+	ret = of_property_read_u32(of_node, "qcom,smmu-cfg",
+				   &mhi_dev->smmu_cfg);
+	if (ret)
+		goto error_probe;
+
+	/* if s1 translation enabled pull iova addr from dt */
+	if (mhi_dev->smmu_cfg & MHI_SMMU_ATTACH &&
+	    !(mhi_dev->smmu_cfg & MHI_SMMU_S1_BYPASS)) {
+		ret = of_property_count_elems_of_size(of_node, "qcom,addr-win",
+						      sizeof(addr_win));
+		if (ret != 1)
+			goto error_probe;
+		ret = of_property_read_u64_array(of_node, "qcom,addr-win",
+						 addr_win, 2);
+		if (ret)
+			goto error_probe;
+	} else {
+		addr_win[0] = memblock_start_of_DRAM();
+		addr_win[1] = memblock_end_of_DRAM();
+	}
+
+	mhi_dev->iova_start = addr_win[0];
+	mhi_dev->iova_stop = addr_win[1];
+
+	/*
+	 * if S1 is enabled, set MHI_CTRL start address to 0 so we can use low
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
+	/* setup power management apis */
+	mhi_cntrl->status_cb = mhi_status_cb;
+	mhi_cntrl->runtime_get = mhi_runtime_get;
+	mhi_cntrl->runtime_put = mhi_runtime_put;
+	mhi_cntrl->link_status = mhi_link_status;
+
+	mhi_dev->pdev = pdev;
+
+	ret = mhi_arch_platform_init(mhi_dev);
+	if (ret)
+		goto error_probe;
+
+	ret = of_register_mhi_controller(mhi_cntrl);
+	if (ret)
+		goto error_register;
+
+	if (mhi_cntrl->parent)
+		debugfs_create_file("debug_mode", 0444, mhi_cntrl->parent,
+				    mhi_cntrl, &debugfs_debug_ops);
+
+	return 0;
+
+error_register:
+	mhi_arch_platform_deinit(mhi_dev);
+
+error_probe:
+	mhi_free_controller(mhi_cntrl);
+
+	return -EINVAL;
+};
+
+static struct platform_driver mhi_platform_driver = {
+	.probe = mhi_platform_probe,
+	.driver = {
+		.name = "mhi",
+		.owner = THIS_MODULE,
+		.of_match_table = mhi_plat_match,
+	},
+};
+
+static const struct dev_pm_ops pm_ops = {
+	SET_RUNTIME_PM_OPS(mhi_runtime_suspend,
+			   mhi_runtime_resume,
+			   mhi_runtime_idle)
+	SET_SYSTEM_SLEEP_PM_OPS(mhi_system_suspend, mhi_system_resume)
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
+static int __init mhi_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&mhi_platform_driver);
+	if (ret)
+		return ret;
+
+	ret = pci_register_driver(&mhi_pcie_driver);
+	if (ret)
+		goto pci_reg_error;
+
+	return ret;
+
+pci_reg_error:
+	platform_driver_unregister(&mhi_platform_driver);
+
+	return ret;
+};
+module_init(mhi_init);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("MHI_CORE");
+MODULE_DESCRIPTION("MHI Host Driver");
diff --git a/drivers/bus/mhi/controllers/mhi_qcom.h b/drivers/bus/mhi/controllers/mhi_qcom.h
new file mode 100644
index 0000000..4b90916
--- /dev/null
+++ b/drivers/bus/mhi/controllers/mhi_qcom.h
@@ -0,0 +1,85 @@
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
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
+#define MHI_PCIE_DEBUG_ID (0xffff)
+#define MHI_RPM_SUSPEND_TMR_MS (1000)
+#define MHI_PCI_BAR_NUM (0)
+
+struct mhi_dev {
+	struct platform_device *pdev;
+	struct pci_dev *pci_dev;
+	u32 smmu_cfg;
+	int resn;
+	void *arch_info;
+	bool powered_on;
+	bool debug_mode;
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
+static inline int mhi_arch_platform_init(struct mhi_dev *mhi_dev)
+{
+	return 0;
+}
+
+static inline void mhi_arch_platform_deinit(struct mhi_dev *mhi_dev)
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
