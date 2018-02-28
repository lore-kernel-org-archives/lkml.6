Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AG47ELsiU0bIawxtymAEY4A+py5wZfwQTp3158OL2SrXbHn/9V599m6nMX0VO8OVtNUiPyu99uet
ARC-Seal: i=1; a=rsa-sha256; t=1519837500; cv=none;
        d=google.com; s=arc-20160816;
        b=pWv/KfDe4FoEGLj0SXwtORKiIiuWrRMqVY8D3u7AXL+KKOKXMLy7O22HRoo5T6JoFW
         KKUXJSW4HmxZBrXhFZ3wGrQ6+lEPGLAPJG53NzH/of7d0L1UbVINZ+vRQ7Df+Oc6uLLh
         wukCqvZ16l0KCarmqb5y+WafRxxo4X/trdAobeZrNZ3bygNbGNcjpy6aDFruCGyJlILA
         /Y0/Z99eDvui5ZIEleVfIdj0BKrDUSxnt3egqO0hWx9ylUyhnJykT+zcoghToapH+gx5
         pwDSXc/qEpRaALAzVHnA+Rvg/YprHQgqV64UFwVDT7nMWAb3Nc3Qyv19gXLSFHouxdYd
         qAXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=ixDaG35QzZ00T7iGqHadiZIYRBmR84Z/5et5n0u1NAs=;
        b=wSQprwwbD5AnI7NATVgxw/t+tWCIQ0CpgNp4unmIR8cEoyteU0cWkqQy0YBrNvoVg2
         7f9FhajuA0qMqllP79kvz4+ozlhGg7/+I6EWlpelh5z5n0hFykzo8SWv0EtSGrhG4u6O
         bhQP1Ev18UrHhu5sD6K8YkMgOwCmIZR6+kyLnq3d/ZfziSIRUNCG65v6LLT5aCkK+Thb
         a8prCpjNiFdyaWk9jhbbpcU6Gnpl5lJL70jkKRSwJqm3cuyATnUpvN9cFl/HMXXsXTnW
         lSMvgjD1V8dIr3o/KyWrzqSMbc3jjgVKsYPLmlqqc+r6Brd/CSG90HRT5TXNmWOUUj00
         98oA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Vxo//1gW;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Dmb/snwQ;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Vxo//1gW;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Dmb/snwQ;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 292D2601CF
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
Subject: [PATCH v12 6/6] PCI/DPC: Enumerate the devices after DPC trigger event
Date: Wed, 28 Feb 2018 22:34:17 +0530
Message-Id: <1519837457-3596-7-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593665127333650681?=
X-GMAIL-MSGID: =?utf-8?q?1593665127333650681?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Implement error_resume callback in DPC so, after DPC trigger event
enumerates the devices beneath.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 9f1c983..d439bfd 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -237,7 +237,8 @@ static pci_ers_result_t reset_link(struct pci_dev *dev, int severity)
 static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 	enum pci_channel_state state,
 	char *error_mesg,
-	int (*cb)(struct pci_dev *, void *))
+	int (*cb)(struct pci_dev *, void *),
+	int severity)
 {
 	struct aer_broadcast_data result_data;
 
@@ -249,6 +250,17 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 		result_data.result = PCI_ERS_RESULT_RECOVERED;
 
 	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		/* If DPC is triggered, call resume error handler
+		 * because, at this point we can safely assume that
+		 * link recovery has happened, this is only handled if
+		 * callback is resume, as this function can be called
+		 * with multiple callbacks.
+		 */
+		if ((severity == DPC_FATAL) &&
+			(cb == report_resume)) {
+			cb(dev, NULL);
+			return PCI_ERS_RESULT_RECOVERED;
+		}
 		/*
 		 * If the error is reported by a bridge, we think this error
 		 * is related to the downstream link of the bridge, so we
@@ -296,7 +308,8 @@ void pcie_do_recovery(struct pci_dev *dev, int severity)
 	status = broadcast_error_message(dev,
 			state,
 			"error_detected",
-			report_error_detected);
+			report_error_detected,
+			severity);
 
 	if ((severity == AER_FATAL) ||
 	    (severity == DPC_FATAL)) {
@@ -311,7 +324,8 @@ void pcie_do_recovery(struct pci_dev *dev, int severity)
 		status = broadcast_error_message(dev,
 				state,
 				"mmio_enabled",
-				report_mmio_enabled);
+				report_mmio_enabled,
+				severity);
 
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
 		/*
@@ -322,7 +336,8 @@ void pcie_do_recovery(struct pci_dev *dev, int severity)
 		status = broadcast_error_message(dev,
 				state,
 				"slot_reset",
-				report_slot_reset);
+				report_slot_reset,
+				severity);
 	}
 
 	if (status != PCI_ERS_RESULT_RECOVERED)
@@ -332,7 +347,8 @@ void pcie_do_recovery(struct pci_dev *dev, int severity)
 	broadcast_error_message(dev,
 				state,
 				"resume",
-				report_resume);
+				report_resume,
+				severity);
 
 	dev_info(&dev->dev, "Device recovery successful\n");
 	return;
diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 8e1553b..fb6bbd3 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -101,9 +101,24 @@ static void dpc_wait_link_inactive(struct dpc_dev *dpc)
 }
 
 /**
- * dpc_reset_link - reset link DPC routine
+ * dpc_error_resume - enumerate the devices beneath
  * @pdev: pointer to Root Port's pci_dev data structure
  *
+ * Invoked by Port Bus driver during fatal recovery.
+ */
+static void dpc_error_resume(struct pci_dev *pdev)
+{
+	if (pcie_wait_for_link(pdev, true)) {
+		pci_lock_rescan_remove();
+		pci_rescan_bus(pdev->bus);
+		pci_unlock_rescan_remove();
+	}
+}
+
+/**
+ * dpc_reset_link - reset link DPC routine
+ * @dev: pointer to Root Port's pci_dev data structure
+ *
  * Invoked by Port Bus driver when performing link reset at Root Port.
  */
 static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
@@ -338,6 +353,7 @@ static void dpc_remove(struct pcie_device *dev)
 	.service	= PCIE_PORT_SERVICE_DPC,
 	.probe		= dpc_probe,
 	.remove		= dpc_remove,
+	.error_resume	= dpc_error_resume,
 	.reset_link     = dpc_reset_link,
 };
 
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
