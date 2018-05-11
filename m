Return-Path: <poza@qualcomm.com>
X-Google-Smtp-Source: AB8JxZr46r6GJuGNMisVDbAKBZUCAc0eHFoiLR46uS7AVoIZ9TnVtU2Vh2khDC1onkfyZIhxWTEf
ARC-Seal: i=1; a=rsa-sha256; t=1526035414; cv=none;
        d=google.com; s=arc-20160816;
        b=iapFhv9fkcAQUEdKruQgWVjsr7apnSB2ozmAWMKIybHYWCpvW+u51zxFbMlKxlgtjk
         yXEJVeKg0P3VtOMH4GTsP9eK/KmZKnun6+peUTDia0jMQ05JxLkE9zuyQkIWTOPPi7us
         ZxAR65MZEZ4gsYMu0Bxw1eRTrkiIbEetg1YG0ViV58QxUZ6ARsqSafeVzAFMq7yvUQnl
         SiE0oiRWCv7v75b/BSRGASf8cXPtrAB2gRhwhw3h2aKKVFZrRNL4rnyZim7gU3eBef7P
         dwdypRSsdES7bu+me3hYZaOKe1ScE0CEg4MBHyAeyFU7YqmQeu+NZzi7J2j3Ces5dvBP
         Wxug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=FMFHVObcqBAu/lD1DVVE4B6uEnH0fxERHd6wwtJ2XmI=;
        b=gYvMeUUcCnmRj0JA6hHGd+AC0C+MDBrTMvQ+HHSHLmkcMx/3kGN/4xRW5FB6ue1bR+
         tRlvIMLMvIVlH1Rb2jt7EljqrlhUR3ftzt0cu9PEVbH0Q4D54WCJDBswTJHQnM4liV8G
         eoX97/8S8ZKZpe+4Mu5jiW5+XWMN+h7ZPzVXjLnu+QsV/WiTCHqdo6Bzu4t7Nb6bEj9A
         Zlka0HwUreNlQKUzDvPwj/yLZzrzAZKcWU7yqwaNh8zvuGbQKIf29zRSXFuWT0Riz1wz
         Pjb5kueDFGYwTE0pXI86WwgzlSAHVS3djNy3QpiZsJ42XqvPqzD1N4qMFUYx4/LFr1Wc
         Pjxg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 129.46.98.28 as permitted sender) smtp.mailfrom=poza@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 129.46.98.28 as permitted sender) smtp.mailfrom=poza@qualcomm.com
X-IronPort-AV: E=Sophos;i="5.49,388,1520924400";
   d="scan'208";a="17306049"
X-IronPort-AV: E=McAfee;i="5900,7806,8889"; a="190604639"
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
Subject: [PATCH v16 8/9] PCI/DPC: Unify and plumb error handling into DPC
Date: Fri, 11 May 2018 06:43:27 -0400
Message-Id: <1526035408-31328-9-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526035408-31328-1-git-send-email-poza@codeaurora.org>
References: <1526035408-31328-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600164111312988494?=
X-GMAIL-MSGID: =?utf-8?q?1600164111312988494?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DPC driver implements link_reset callback, and calls
pci_do_fatal_recovery().

Which follows standard path of ERR_FATAL recovery.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5e8857a..6af7595 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -354,7 +354,7 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 void pci_enable_acs(struct pci_dev *dev);
 
 /* PCI error reporting and recovery */
-void pcie_do_fatal_recovery(struct pci_dev *dev);
+void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service);
 void pcie_do_nonfatal_recovery(struct pci_dev *dev);
 
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index fdfc474..36e622d 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -254,7 +254,7 @@ static void handle_error_source(struct pcie_device *aerdev,
 	} else if (info->severity == AER_NONFATAL)
 		pcie_do_nonfatal_recovery(dev);
 	else if (info->severity == AER_FATAL)
-		pcie_do_fatal_recovery(dev);
+		pcie_do_fatal_recovery(dev, PCIE_PORT_SERVICE_AER);
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
@@ -321,7 +321,7 @@ static void aer_recover_work_func(struct work_struct *work)
 		if (entry.severity == AER_NONFATAL)
 			pcie_do_nonfatal_recovery(pdev);
 		else if (entry.severity == AER_FATAL)
-			pcie_do_fatal_recovery(pdev);
+			pcie_do_fatal_recovery(pdev, PCIE_PORT_SERVICE_AER);
 		pci_dev_put(pdev);
 	}
 }
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 80ec384..5680c13 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -73,29 +73,31 @@ static void dpc_wait_link_inactive(struct dpc_dev *dpc)
 	pcie_wait_for_link(pdev, false);
 }
 
-static void dpc_work(struct work_struct *work)
+static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 {
-	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
-	struct pci_dev *dev, *temp, *pdev = dpc->dev->port;
-	struct pci_bus *parent = pdev->subordinate;
-	u16 cap = dpc->cap_pos, ctl;
-
-	pci_lock_rescan_remove();
-	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
-					 bus_list) {
-		pci_dev_get(dev);
-		pci_dev_set_disconnected(dev, NULL);
-		if (pci_has_subordinate(dev))
-			pci_walk_bus(dev->subordinate,
-				     pci_dev_set_disconnected, NULL);
-		pci_stop_and_remove_bus_device(dev);
-		pci_dev_put(dev);
-	}
-	pci_unlock_rescan_remove();
-
+	struct dpc_dev *dpc;
+	struct pcie_device *pciedev;
+	struct device *devdpc;
+	u16 cap, ctl;
+
+	/*
+	 * DPC disables the Link automatically in hardware, so it has
+	 * already been reset by the time we get here.
+	 */
+
+	devdpc = pcie_port_find_device(pdev, PCIE_PORT_SERVICE_DPC);
+	pciedev = to_pcie_device(devdpc);
+	dpc = get_service_data(pciedev);
+	cap = dpc->cap_pos;
+
+	/*
+	 * Waiting until the link is inactive, then clearing DPC
+	 * trigger status to allow the port to leave DPC.
+	 */
 	dpc_wait_link_inactive(dpc);
+
 	if (dpc->rp_extensions && dpc_wait_rp_inactive(dpc))
-		return;
+		return PCI_ERS_RESULT_DISCONNECT;
 	if (dpc->rp_extensions && dpc->rp_pio_status) {
 		pci_write_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS,
 				       dpc->rp_pio_status);
@@ -108,6 +110,17 @@ static void dpc_work(struct work_struct *work)
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_CTL, &ctl);
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_CTL,
 			      ctl | PCI_EXP_DPC_CTL_INT_EN);
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+static void dpc_work(struct work_struct *work)
+{
+	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
+	struct pci_dev *pdev = dpc->dev->port;
+
+	/* From DPC point of view error is always FATAL. */
+	pcie_do_fatal_recovery(pdev, PCIE_PORT_SERVICE_DPC);
 }
 
 static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
@@ -288,6 +301,7 @@ static struct pcie_port_service_driver dpcdriver = {
 	.service	= PCIE_PORT_SERVICE_DPC,
 	.probe		= dpc_probe,
 	.remove		= dpc_remove,
+	.reset_link	= dpc_reset_link,
 };
 
 static int __init dpc_service_init(void)
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 33a16b1..29ff148 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -185,7 +185,7 @@ static pci_ers_result_t default_reset_link(struct pci_dev *dev)
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
-static pci_ers_result_t reset_link(struct pci_dev *dev)
+static pci_ers_result_t reset_link(struct pci_dev *dev, u32 service)
 {
 	struct pci_dev *udev;
 	pci_ers_result_t status;
@@ -200,7 +200,7 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
 	}
 
 	/* Use the aer driver of the component firstly */
-	driver = pcie_port_find_service(udev, PCIE_PORT_SERVICE_AER);
+	driver = pcie_port_find_service(udev, service);
 
 	if (driver && driver->reset_link) {
 		status = driver->reset_link(udev);
@@ -287,7 +287,7 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
  * followed by re-enumeration of devices.
  */
 
-void pcie_do_fatal_recovery(struct pci_dev *dev)
+void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
 {
 	struct pci_dev *udev;
 	struct pci_bus *parent;
@@ -313,7 +313,7 @@ void pcie_do_fatal_recovery(struct pci_dev *dev)
 		pci_dev_put(pdev);
 	}
 
-	result = reset_link(udev);
+	result = reset_link(udev, service);
 
 	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
 		/*
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 8f87bbe..0c506fe 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -14,6 +14,7 @@
 #define AER_NONFATAL			0
 #define AER_FATAL			1
 #define AER_CORRECTABLE			2
+#define DPC_FATAL			4
 
 struct pci_dev;
 
-- 
2.7.4
