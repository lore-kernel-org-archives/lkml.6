Return-Path: <poza@qualcomm.com>
X-Google-Smtp-Source: AIpwx48jlbFC2xTaRbNXzNiEOh+TLsW2QjKiarOy2prwh5oikbM8cXthasY8YMnXhTYBk7smJbOV
ARC-Seal: i=1; a=rsa-sha256; t=1524496999; cv=none;
        d=google.com; s=arc-20160816;
        b=YTvf+W/Gz4PukipbNLoaXRd8RAMKCoiYYqFirWAWDaVRwXBVR21+lgPl1a8a25rGL0
         ZtBbS7uBSAHwTQVu0f7q2SjOnPAoXONphVm6ts8IIX5cx+vz/lpUG4cbpFArWN4+M6y0
         Ns9n1Wh1KxUZxrG1F75n7X3Ehdkz/GbDjk6pUXzNtSBftVqH6G7V17YNqdScglLZIQBz
         m+31sW6n7W4DEMiroO8o6mS67mteWo3bVyphbxwQniOt030okZ1DSsTR41pqW53MrUSB
         UGseauAW3vE+otD0/tNwHaPrBPqhB9oNQDTKP3K4oXoMh6MZvT4JBOV/5GPa3m8tJ/xu
         IWVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=KRxmlQRT30HPVMuCPfmIzVmqgFf/9h6fBD118VI06dA=;
        b=YMTfAecUNdP1JKoljKRRonSLWaFt18kv22L2RDILZa4bWFcFE1jk8WFUBaJ5EA668J
         /ST6an201h11m9bjh8Py6t38L0PxdJYdJDXTycauPYDFLQiJjve3fbsscPC5HA6qMBs3
         qAd6DKKwMBpzenym532Y2x5GqE+VOO4CnuYNdCulQlaUM8zEBZ4XdlvXdwBffDnhzXRz
         dgxX9akdW6hGrFio8doSn7yIuAIgfPrBOfk798Uyjio4DrQaM+sIdtusuCetP0+kVh4g
         U3OtqzOA+Ct8/+SIlbMzXuvfOqbEO1TPPif94YS3i7qKIkgxdDZW6BVQesAK9C13XUeH
         Xp0g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 129.46.98.28 as permitted sender) smtp.mailfrom=poza@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 129.46.98.28 as permitted sender) smtp.mailfrom=poza@qualcomm.com
X-IronPort-AV: E=Sophos;i="5.49,318,1520924400";
   d="scan'208";a="16839228"
X-IronPort-AV: E=McAfee;i="5900,7806,8871"; a="68706657"
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
Subject: [PATCH v14 5/9] PCI/DPC: Unify and plumb error handling into DPC
Date: Mon, 23 Apr 2018 11:23:09 -0400
Message-Id: <1524496993-29799-6-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524496993-29799-1-git-send-email-poza@codeaurora.org>
References: <1524496993-29799-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598550965516521618?=
X-GMAIL-MSGID: =?utf-8?q?1598550965516521618?=
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
index 38e40c6..ad02298 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -13,6 +13,7 @@
 #include <linux/pcieport_if.h>
 #include "../pci.h"
 #include "aer/aerdrv.h"
+#include "portdrv.h"
 
 struct dpc_dev {
 	struct pcie_device	*dev;
@@ -82,12 +83,25 @@ static void dpc_wait_link_inactive(struct dpc_dev *dpc)
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
+	devdpc = pcie_port_find_device(pdev, PCIE_PORT_SERVICE_DPC);
+	pciedev = to_pcie_device(devdpc);
+	dpc = get_service_data(pciedev);
+	cap = dpc->cap_pos;
 
 	pci_lock_rescan_remove();
 	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
@@ -104,7 +118,7 @@ static void dpc_work(struct work_struct *work)
 
 	dpc_wait_link_inactive(dpc);
 	if (dpc->rp_extensions && dpc_wait_rp_inactive(dpc))
-		return;
+		return PCI_ERS_RESULT_DISCONNECT;
 	if (dpc->rp_extensions && dpc->rp_pio_status) {
 		pci_write_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS,
 				       dpc->rp_pio_status);
@@ -117,8 +131,18 @@ static void dpc_work(struct work_struct *work)
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
@@ -297,6 +321,7 @@ static struct pcie_port_service_driver dpcdriver = {
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
