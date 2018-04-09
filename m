Return-Path: <poza@qualcomm.com>
X-Google-Smtp-Source: AIpwx4+fqorGxJwSWEJnJ4zaUJitq5vdn1iWo+oytrXVrAaQMMrToBIJeOhbZcWbjyLftq4X8s7+
ARC-Seal: i=1; a=rsa-sha256; t=1523284938; cv=none;
        d=google.com; s=arc-20160816;
        b=RcBmtQQtTXL/E/0YRzT04Sbo7NcVkuxBSep25uFu4QS7X5JmCejpCzHoWGyN7TdZST
         iQiuFgGo1sSPJA62pzT/vOCku7nJniW5/CyqUkPI6uG+syRbhtmb5zsDVg3WTiR58b9B
         laHnO1DrAaggSUIVFTibOgDyKc9JwOUmY5i2zmBWSxpSQi/vg9aMMkqvb0hrf/Kt6e/L
         P8KVf38rnqdwY6uIP2BZ8tfza7OSNv7LRZB/MgZbAScVbzfjfIN/KIwb50XJcXRxsEVJ
         SkJgjEqmeHMTD1vf7aHk6rnltSYkv3hU70sqcZiRGTMHcpUBglJifACGeoWMyLkNfr5x
         gjMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=p8QF9Y0K6AdH1Msvn4491tEsPrPK2ZUGf40r+KB5NJs=;
        b=eSlKNcpb2NZRmnaGLJAx3tvW04RBuX2c1XTiu6M5U7PPbqFMc5xY39Jszca/YV9JqS
         ifIZrTuMW+ytOlULt2Cn2/FaTfCwij7wYfeHcFMwnScNWCX3BUP8xleNcH37EHFxoFqv
         YIz/91Lvbv23WnBU5LfVEke/IdofqPhabIbp1hf7hN2Vxm0kvw6jF8f7xRSF/wjeaM5e
         coVUuwvhuraAPS44IxceytHyONnJwjTkO0hwv8/rYLeGRVrkc5y9v0nFmS+2f57Gm2dv
         QtuoBQ7DFNBDcYGTR3jsE9ZhWENXrZJdIiabnZ84oL03y7p60xSnaFx3Nbp6hI1EPpEG
         5CeA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 199.106.114.38 as permitted sender) smtp.mailfrom=poza@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 199.106.114.38 as permitted sender) smtp.mailfrom=poza@qualcomm.com
From: Oza Pawandeep <poza@codeaurora.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>,
	Keith Busch <keith.busch@intel.com>,
	Wei Zhang <wzhang@fb.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>
Cc: Oza Pawandeep <poza@codeaurora.org>
Subject: [PATCH v13 4/6] PCI/DPC: Unify and plumb error handling into DPC
Date: Mon,  9 Apr 2018 10:41:52 -0400
Message-Id: <1523284914-2037-5-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280027376446464?=
X-GMAIL-MSGID: =?utf-8?q?1597280027376446464?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Current DPC driver does not do recovery, e.g. calling end-point's driver's
callbacks, which sanitize the sw.

DPC driver implements link_reset callback, and calls pci_do_recovery().

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 98aeec4..d02e029 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -19,6 +19,7 @@
 #include <linux/aer.h>
 #include <linux/pcieport_if.h>
 #include "portdrv.h"
+#include "./../pci.h"
 
 struct aer_broadcast_data {
 	enum pci_channel_state state;
@@ -179,11 +180,12 @@ static pci_ers_result_t default_reset_link(struct pci_dev *dev)
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
-static pci_ers_result_t reset_link(struct pci_dev *dev)
+static pci_ers_result_t reset_link(struct pci_dev *dev, int severity)
 {
 	struct pci_dev *udev;
 	pci_ers_result_t status;
 	struct pcie_port_service_driver *driver = NULL;
+	u32 service;
 
 	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
 		/* Reset this port for all subordinates */
@@ -193,8 +195,12 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
 		udev = dev->bus->self;
 	}
 
-	/* Use the aer driver of the component firstly */
-	driver = pcie_port_find_service(udev, PCIE_PORT_SERVICE_AER);
+	if (severity == DPC_FATAL)
+		service = PCIE_PORT_SERVICE_DPC;
+	else
+		service = PCIE_PORT_SERVICE_AER;
+
+	driver = pcie_port_find_service(udev, service);
 
 	if (driver && driver->reset_link) {
 		status = driver->reset_link(udev);
@@ -281,7 +287,8 @@ void pcie_do_recovery(struct pci_dev *dev, int severity)
 	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
 	enum pci_channel_state state;
 
-	if (severity == AER_FATAL)
+	if ((severity == AER_FATAL) ||
+	    (severity == DPC_FATAL))
 		state = pci_channel_io_frozen;
 	else
 		state = pci_channel_io_normal;
@@ -291,8 +298,9 @@ void pcie_do_recovery(struct pci_dev *dev, int severity)
 			"error_detected",
 			report_error_detected);
 
-	if (severity == AER_FATAL) {
-		result = reset_link(dev);
+	if ((severity == AER_FATAL) ||
+	    (severity == DPC_FATAL)) {
+		result = reset_link(dev, severity);
 		if (result != PCI_ERS_RESULT_RECOVERED)
 			goto failed;
 	}
diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 38e40c6..517c8b4 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -13,6 +13,7 @@
 #include <linux/pcieport_if.h>
 #include "../pci.h"
 #include "aer/aerdrv.h"
+#include "portdrv.h"
 
 struct dpc_dev {
 	struct pcie_device	*dev;
@@ -45,6 +46,33 @@ static const char * const rp_pio_error_string[] = {
 	"Memory Request Completion Timeout",		 /* Bit Position 18 */
 };
 
+static int find_dpc_dev_iter(struct device *device, void *data)
+{
+	struct pcie_port_service_driver *service_driver;
+	struct device **dev;
+
+	dev = (struct device **) data;
+
+	if (device->bus == &pcie_port_bus_type && device->driver) {
+		service_driver = to_service_driver(device->driver);
+		if (service_driver->service == PCIE_PORT_SERVICE_DPC) {
+			*dev = device;
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+static struct device *pci_find_dpc_dev(struct pci_dev *pdev)
+{
+	struct device *dev = NULL;
+
+	device_for_each_child(&pdev->dev, &dev, find_dpc_dev_iter);
+
+	return dev;
+}
+
 static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
 {
 	unsigned long timeout = jiffies + HZ;
@@ -82,12 +110,25 @@ static void dpc_wait_link_inactive(struct dpc_dev *dpc)
 		dev_warn(dev, "Link state not disabled for DPC event\n");
 }
 
-static void dpc_work(struct work_struct *work)
+/**
+ * dpc_reset_link - reset link DPC routine
+ * @pdev: pointer to Root Port's pci_dev data structure
+ *
+ * Invoked by Port Bus driver when performing link reset at Root Port.
+ */
+static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 {
-	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
-	struct pci_dev *dev, *temp, *pdev = dpc->dev->port;
 	struct pci_bus *parent = pdev->subordinate;
-	u16 cap = dpc->cap_pos, ctl;
+	struct pci_dev *dev, *temp;
+	struct dpc_dev *dpc;
+	struct pcie_device *pciedev;
+	struct device *devdpc;
+	u16 cap, ctl;
+
+	devdpc = pci_find_dpc_dev(pdev);
+	pciedev = to_pcie_device(devdpc);
+	dpc = get_service_data(pciedev);
+	cap = dpc->cap_pos;
 
 	pci_lock_rescan_remove();
 	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
@@ -104,21 +145,31 @@ static void dpc_work(struct work_struct *work)
 
 	dpc_wait_link_inactive(dpc);
 	if (dpc->rp_extensions && dpc_wait_rp_inactive(dpc))
-		return;
+		return PCI_ERS_RESULT_DISCONNECT;
 	if (dpc->rp_extensions && dpc->rp_pio_status) {
 		pci_write_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS,
 				       dpc->rp_pio_status);
 		dpc->rp_pio_status = 0;
 	}
 
-	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
+	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS,
 		PCI_EXP_DPC_STATUS_TRIGGER | PCI_EXP_DPC_STATUS_INTERRUPT);
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_CTL, &ctl);
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_CTL,
 			      ctl | PCI_EXP_DPC_CTL_INT_EN);
+
+	return PCI_ERS_RESULT_RECOVERED;
 }
 
+static void dpc_work(struct work_struct *work)
+{
+	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
+	struct pci_dev *pdev = dpc->dev->port;
+
+	/* From DPC point of view error is always FATAL. */
+	pcie_do_recovery(pdev, DPC_FATAL);
+}
 static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 {
 	struct device *dev = &dpc->dev->device;
@@ -297,6 +348,7 @@ static struct pcie_port_service_driver dpcdriver = {
 	.service	= PCIE_PORT_SERVICE_DPC,
 	.probe		= dpc_probe,
 	.remove		= dpc_remove,
+	.reset_link     = dpc_reset_link,
 };
 
 static int __init dpc_service_init(void)
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 8f87bbe..9cfd0b8 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -15,6 +15,8 @@
 #define AER_FATAL			1
 #define AER_CORRECTABLE			2
 
+#define DPC_FATAL			4
+
 struct pci_dev;
 
 struct aer_header_log_regs {
-- 
2.7.4
