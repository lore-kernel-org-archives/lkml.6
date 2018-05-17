Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752671AbeEQHqO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 03:46:14 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:57577 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752415AbeEQHnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 03:43:16 -0400
X-IronPort-AV: E=Sophos;i="5.49,409,1520924400";
   d="scan'208";a="17447181"
X-IronPort-AV: E=McAfee;i="5900,7806,8895"; a="163842601"
From: Oza Pawandeep <poza@codeaurora.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>
Cc: Oza Pawandeep <poza@codeaurora.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v17 3/9] PCI/AER: Rename error recovery interfaces to generic PCI naming
Date: Thu, 17 May 2018 03:43:05 -0400
Message-Id: <1526542991-5291-4-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526542991-5291-1-git-send-email-poza@codeaurora.org>
References: <1526542991-5291-1-git-send-email-poza@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename error recovery interfaces with "pcie_" prefix so they can be made
non-static.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
[bhelgaas: move declaration to later patch, leave functions static]
Signed-off-by: Bjorn Helgaas <helgaas@kernel.org>
Reviewed-by: Keith Busch <keith.busch@intel.com>

diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index b56f9c1..a2d7cc7 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -476,14 +476,14 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
 }
 
 /**
- * do_fatal_recovery - handle fatal error recovery process
+ * pcie_do_fatal_recovery - handle fatal error recovery process
  * @dev: pointer to a pci_dev data structure of agent detecting an error
  *
  * Invoked when an error is fatal. Once being invoked, removes the devices
  * beneath this AER agent, followed by reset link e.g. secondary bus reset
  * followed by re-enumeration of devices.
  */
-static void do_fatal_recovery(struct pci_dev *dev)
+static void pcie_do_fatal_recovery(struct pci_dev *dev)
 {
 	struct pci_dev *udev;
 	struct pci_bus *parent;
@@ -533,14 +533,14 @@ static void do_fatal_recovery(struct pci_dev *dev)
 }
 
 /**
- * do_nonfatal_recovery - handle nonfatal error recovery process
+ * pcie_do_nonfatal_recovery - handle nonfatal error recovery process
  * @dev: pointer to a pci_dev data structure of agent detecting an error
  *
  * Invoked when an error is nonfatal. Once being invoked, broadcast
  * error detected message to all downstream drivers within a hierarchy in
  * question and return the returned code.
  */
-static void do_nonfatal_recovery(struct pci_dev *dev)
+static void pcie_do_nonfatal_recovery(struct pci_dev *dev)
 {
 	pci_ers_result_t status;
 	enum pci_channel_state state;
@@ -611,9 +611,9 @@ static void handle_error_source(struct pcie_device *aerdev,
 			pci_write_config_dword(dev, pos + PCI_ERR_COR_STATUS,
 					info->status);
 	} else if (info->severity == AER_NONFATAL)
-		do_nonfatal_recovery(dev);
+		pcie_do_nonfatal_recovery(dev);
 	else if (info->severity == AER_FATAL)
-		do_fatal_recovery(dev);
+		pcie_do_fatal_recovery(dev);
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
@@ -678,9 +678,9 @@ static void aer_recover_work_func(struct work_struct *work)
 		}
 		cper_print_aer(pdev, entry.severity, entry.regs);
 		if (entry.severity == AER_NONFATAL)
-			do_nonfatal_recovery(pdev);
+			pcie_do_nonfatal_recovery(pdev);
 		else if (entry.severity == AER_FATAL)
-			do_fatal_recovery(pdev);
+			pcie_do_fatal_recovery(pdev);
 		pci_dev_put(pdev);
 	}
 }
-- 
2.7.4
