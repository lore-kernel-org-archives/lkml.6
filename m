Return-Path: <poza@qualcomm.com>
X-Google-Smtp-Source: AIpwx4+x6KK/en5Cy99x+5Qg3WVGxHngjzouQZmhxbPRNAWT1xWpJmnyRyJFTxJmFMtjpBT88FWK
ARC-Seal: i=1; a=rsa-sha256; t=1524496998; cv=none;
        d=google.com; s=arc-20160816;
        b=LVkLVxch8NGIoAK5U3jhnvPK1ZYYOlY9Px1Ff8u8nO/kCVQ82rBhG8vel1vvJvmY/+
         mEHdjGmCl5b8IPuZMZ21cEkuuvFGL3QFV9R7y/Bz3VCC1849aY8Gq8fkF0CJE9qHJ99l
         1B6i/s/6IZnRvjS3CLvX5UjS+fzBybgpB8xJQ/E4HbGtaz4i08f243OQal1w01x3U452
         JhkEXBbs6UJtoRAOQI/Safl7feqHg+mE46T7XBmwLeEQlrEPJ0LOyax6H3NVdKuPRKub
         yWD75GHndp0XCaZf26sDigA+nOv75SDTkr5hDKXFP9p4FWs7L0UbptWTt1QQ/pasPC4Y
         V7yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=OvkEQNX205JhPq6FDbC6ZuWiDN96z+fZ4aDp1J3GQpw=;
        b=U3hfLexnn8lsm0N0AknlEmMchFmMeLVGwHm5XXgV72yX0v+aYV40IBrQg7/PCJSxG6
         6YxjKvRTksYOqhWaKay720c/N5ABOIss/kxV5SUJFyg/VeFmqcDJ0///FlQBIv1hxNig
         YhayvH3D754WFlSYIOuv+yX/AWY47MZJiL6s51KWiMOWlVAsXnO1tufrShYh3zE8G3K8
         Ee/51mu0cZoIxZezbJOZ+jbWq5g5AiHDiOwxYGL6nHt/IdLeF/fANCNn+Z01TcVAt21/
         +YeSXVS9/nt8D6ovF9/uwAbjEwQzI7I6lz+UsUrM09ShKNgGpYe1Bx7tlk1X3PfLQXs2
         2JnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 129.46.98.28 as permitted sender) smtp.mailfrom=poza@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 129.46.98.28 as permitted sender) smtp.mailfrom=poza@qualcomm.com
X-IronPort-AV: E=Sophos;i="5.49,318,1520924400";
   d="scan'208";a="16839222"
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
Subject: [PATCH v14 8/9] PCI/AER/DPC: Align FATAL error handling for AER and DPC
Date: Mon, 23 Apr 2018 11:23:12 -0400
Message-Id: <1524496993-29799-9-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524496993-29799-1-git-send-email-poza@codeaurora.org>
References: <1524496993-29799-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598550965105099560?=
X-GMAIL-MSGID: =?utf-8?q?1598550965105099560?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If there is a DPC support in the switch then ERR_FATAL and ERR_NONFATAL
should be handled in a same way with respect to DPC.

This patch alters the behavior of handling of ERR_FATAL, where removal
of devices is initiated, followed by reset link, followed by
re-enumeration, and it is applicable to both AER and DPC, so that we have
unified error handling from error agents (SW) point of view.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index da8331f..b2eaa3f 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -334,6 +334,8 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
 	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
 
+	aer_error_resume(dev);
+
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index d02e029..99d52a0 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -273,6 +273,44 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 	return result_data.result;
 }
 
+pci_ers_result_t pcie_do_fatal_recovery(struct pci_dev *dev, int severity)
+{
+	struct pci_dev *udev;
+	struct pci_bus *parent;
+	struct pci_dev *pdev, *temp;
+	pci_ers_result_t result = PCI_ERS_RESULT_RECOVERED;
+
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
+		udev = dev;
+	else
+		udev = dev->bus->self;
+
+	if (severity == AER_FATAL)
+		pci_cleanup_aer_uncorrect_error_status(dev);
+
+	parent = udev->subordinate;
+	pci_lock_rescan_remove();
+	list_for_each_entry_safe_reverse(pdev, temp, &parent->devices,
+				 bus_list) {
+		pci_dev_get(pdev);
+		pci_dev_set_disconnected(pdev, NULL);
+		if (pci_has_subordinate(pdev))
+			pci_walk_bus(pdev->subordinate,
+				     pci_dev_set_disconnected, NULL);
+		pci_stop_and_remove_bus_device(pdev);
+		pci_dev_put(pdev);
+	}
+
+	result = reset_link(udev, severity);
+
+	if (pcie_wait_for_link(udev, true))
+		pci_rescan_bus(udev->bus);
+
+	pci_unlock_rescan_remove();
+
+	return result;
+}
+
 /**
  * pcie_do_recovery - handle nonfatal/fatal error recovery process
  * @dev: pointer to a pci_dev data structure of agent detecting an error
@@ -284,12 +322,16 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
  */
 void pcie_do_recovery(struct pci_dev *dev, int severity)
 {
-	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
+	pci_ers_result_t status;
 	enum pci_channel_state state;
 
 	if ((severity == AER_FATAL) ||
-	    (severity == DPC_FATAL))
-		state = pci_channel_io_frozen;
+	    (severity == DPC_FATAL)) {
+		status = pcie_do_fatal_recovery(dev, severity);
+		if (status != PCI_ERS_RESULT_RECOVERED)
+			goto failed;
+		return;
+	}
 	else
 		state = pci_channel_io_normal;
 
@@ -298,13 +340,6 @@ void pcie_do_recovery(struct pci_dev *dev, int severity)
 			"error_detected",
 			report_error_detected);
 
-	if ((severity == AER_FATAL) ||
-	    (severity == DPC_FATAL)) {
-		result = reset_link(dev, severity);
-		if (result != PCI_ERS_RESULT_RECOVERED)
-			goto failed;
-	}
-
 	if (status == PCI_ERS_RESULT_CAN_RECOVER)
 		status = broadcast_error_message(dev,
 				state,
diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index cd15862..a3e9b25 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -81,8 +81,6 @@ static void dpc_wait_link_inactive(struct dpc_dev *dpc)
  */
 static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 {
-	struct pci_bus *parent = pdev->subordinate;
-	struct pci_dev *dev, *temp;
 	struct dpc_dev *dpc;
 	struct pcie_device *pciedev;
 	struct device *devdpc;
@@ -93,19 +91,6 @@ static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 	dpc = get_service_data(pciedev);
 	cap = dpc->cap_pos;
 
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
 	dpc_wait_link_inactive(dpc);
 	if (dpc->rp_extensions && dpc_wait_rp_inactive(dpc))
 		return PCI_ERS_RESULT_DISCONNECT;
-- 
2.7.4
