Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x224Ua2MMekmFas9OM7tgzM/f4T4TockKm+l5/7g6BZmrDF7XjXQIjanLfF35vkI+Wb0VFMof
ARC-Seal: i=1; a=rsa-sha256; t=1519208848; cv=none;
        d=google.com; s=arc-20160816;
        b=SBYkCBPjZqMOdEZP09lkrCSzEYKZ69vKvu8wu05nOabEx++7tBab/fn6sRra5o4Cbm
         jovuo53bSYegvComON9kEv3z/QfSmLgMR5RE+LfxSPisHziOZSNes390dn+04i6by5na
         YmJK4v1xJwwCwIDFjTeoOn9voC48+wfqSXdsPgZQ6xVmxno1iJBpwnVb1RHqtCq0gjLr
         JSc7/o+Qwvy8tV+iOnXpGN+kPJM9VXoae6MmE21gI1QKDMI+sygxpTmTu0JfrlVMbSCN
         U+P8h7K0novwl6XpEJZDfD7HkSVKHnq4Gdf+fH5UYpwdPfjY94oT+eYC7MQN9oHjELQp
         8iUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=5xYb2opmFUSL84wZAwlg3k8XeYJ4xgXvKTHoMROLVsE=;
        b=ZMM0/MYI7iV4Pfd+7KqHBFv/MmTR2YO9FT2PcAFWiOr0TYVr8AOlW6TzJA7/dXxe7t
         xpTJUxlsnyYUAcXXpkCtiYFXI0EHKoDS6FZ+MFZHEqeNAZiRLc56puqvvpWLMp4UWcur
         WhHvQPqsPBr90emXcTTOvJC/yN46JaDD6/F8RLjFu9oicxMlD8+OFledy9vEmEomapdC
         JRjm2XD/rF2+0n4ydethDzs4uUEIIbwvA5f36+2n8nZtVGsCZ+oVoIxbrc+MuCTLP6rv
         kwOgg040ytrdx9Z1mu2Toj3xLxE6WYc/bv42U7IRexmPyb8mFu/3BTubA2l4PMGdorBX
         8BkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ICNioYZo;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=UZTIGABR;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ICNioYZo;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=UZTIGABR;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 090C2602BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=poza@codeaurora.org
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
Subject: [PATCH v8 7/7] PCI/DPC: Enumerate the devices after DPC trigger event
Date: Wed, 21 Feb 2018 15:56:44 +0530
Message-Id: <1519208804-24512-8-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519208804-24512-1-git-send-email-poza@codeaurora.org>
References: <1519208804-24512-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593005937706216448?=
X-GMAIL-MSGID: =?utf-8?q?1593005937706216448?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Implement error_resume callback in DPC so, after DPC trigger event
enumerates the devices beneath.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index fce4518..59c01c7 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -129,6 +129,23 @@ static void dpc_wait_link_inactive(struct dpc_dev *dpc)
 }
 
 /**
+ * dpc_error_resume - enumerate the devices beneath
+ * @dev: pointer to Root Port's pci_dev data structure
+ *
+ * Invoked by Port Bus driver during nonfatal recovery.
+ */
+static void dpc_error_resume(struct pci_dev *pdev)
+{
+	bool active = true;
+
+	if (pci_wait_for_link(pdev, active)) {
+		pci_lock_rescan_remove();
+		pci_rescan_bus(pdev->bus);
+		pci_unlock_rescan_remove();
+	}
+}
+
+/**
  * dpc_reset_link - reset link DPC  routine
  * @dev: pointer to Root Port's pci_dev data structure
  *
@@ -366,6 +383,7 @@ static void dpc_remove(struct pcie_device *dev)
 	.service	= PCIE_PORT_SERVICE_DPC,
 	.probe		= dpc_probe,
 	.remove		= dpc_remove,
+	.error_resume	= dpc_error_resume,
 	.reset_link     = dpc_reset_link,
 };
 
diff --git a/drivers/pci/pcie/pcie-err.c b/drivers/pci/pcie/pcie-err.c
index 6844347..4950f49 100644
--- a/drivers/pci/pcie/pcie-err.c
+++ b/drivers/pci/pcie/pcie-err.c
@@ -236,6 +236,7 @@ static pci_ers_result_t reset_link(struct pci_dev *dev, int severity)
  * @state: error state
  * @error_mesg: message to print
  * @cb: callback to be broadcasted
+ * @severity: error severity
  *
  * Invoked during error recovery process. Once being invoked, the content
  * of error severity will be broadcasted to all downstream drivers in a
@@ -244,7 +245,8 @@ static pci_ers_result_t reset_link(struct pci_dev *dev, int severity)
 static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 	enum pci_channel_state state,
 	char *error_mesg,
-	int (*cb)(struct pci_dev *, void *))
+	int (*cb)(struct pci_dev *, void *),
+	int severity)
 {
 	struct aer_broadcast_data result_data;
 
@@ -256,6 +258,15 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 		result_data.result = PCI_ERS_RESULT_RECOVERED;
 
 	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		/* If DPC is triggered, call resume error hanlder
+		 * because, at this point we can safely assume that
+		 * link recovery has happened.
+		 */
+		if ((severity == DPC_FATAL) &&
+			(cb == report_resume)) {
+			cb(dev, NULL);
+			return PCI_ERS_RESULT_RECOVERED;
+		}
 		/*
 		 * If the error is reported by a bridge, we think this error
 		 * is related to the downstream link of the bridge, so we
@@ -305,7 +316,8 @@ void pci_do_recovery(struct pci_dev *dev, int severity)
 	status = broadcast_error_message(dev,
 			state,
 			"error_detected",
-			report_error_detected);
+			report_error_detected,
+			severity);
 
 	if ((severity == AER_FATAL) ||
 	    (severity == DPC_FATAL)) {
@@ -321,7 +333,8 @@ void pci_do_recovery(struct pci_dev *dev, int severity)
 		status = broadcast_error_message(dev,
 				state,
 				"mmio_enabled",
-				report_mmio_enabled);
+				report_mmio_enabled,
+				severity);
 
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
 		/*
@@ -332,7 +345,8 @@ void pci_do_recovery(struct pci_dev *dev, int severity)
 		status = broadcast_error_message(dev,
 				state,
 				"slot_reset",
-				report_slot_reset);
+				report_slot_reset,
+				severity);
 	}
 
 	if (status != PCI_ERS_RESULT_RECOVERED)
@@ -342,7 +356,8 @@ void pci_do_recovery(struct pci_dev *dev, int severity)
 	broadcast_error_message(dev,
 				state,
 				"resume",
-				report_resume);
+				report_resume,
+				severity);
 
 	dev_info(&dev->dev, "Device recovery successful\n");
 	mutex_unlock(&pci_err_recovery_lock);
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
