Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x224lyf7/ne8Oy3KfR0lmYGuZJHEbSpmv5uWQUxQGCfj7zly+2b+e4FU+W7iuux64uhcrmXk7
ARC-Seal: i=1; a=rsa-sha256; t=1519315379; cv=none;
        d=google.com; s=arc-20160816;
        b=f4vIVRoUgIrh1L3lLESiRlpLhMd91A3INd1Ki2lfUUmR5uBtWx4SmbrirZej63y8zt
         8FHSTD8cSXH/knYD55r/01VScaC8FEfLkAlj7NjoWFZ+UsExxL/dnU2vnIet4SkynTH+
         /7bdkmbsNrTZg6bz1BWt+MJ/3HYpELPGUow0ZbFGWwYghoiiDL4uifqRYX4HG7SVS9cP
         o+ht6L9z0n/AN/MuSQpvxc7n7O03djQWDl4QejPOyX3APFieRya1MFnEXcy+t6VfH1gO
         StiWKECWtRXDnISA73e3f/YEUWwHXMBzvnHzeKcwwbGY/HXkoHPVv7Kkk5WA3P/JVdwY
         0DoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=pp1rYEA6EnFLa/eUlIULtk0cO28B4955RxEy5ReaI4o=;
        b=X24Q395vIEbGQgPGLjSg4cQ84Z8b0hUNjq+2hdHRXyXNJSrJl/uFCiWxMnVen5p9Zt
         Awsj9EDGXOLgCqJWLNB+F71ORb6lZmdmIPt5QVDNpAXZ46BiFSreqIeUhQt5odO92wGv
         oc936LmfSc2EyH5IsHCYX2Yu8HRGfPg6zU39p1WLppMx6F+uTuQ6ffxOhLCN5rS7N+GY
         Rs4NISfKfhJYLeGpFvWh+77Ovaen0qQ9cbCPa8Tn/kXTRM391vD15zG8sZuwduXsu9X2
         05cPn1dwOQRelHpgtS4fcYWP6SZxyOO+VNqZa4Me/7ib8buPbi09NGtAPG0PQ64/G0ZS
         i7jg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=PApFSkSH;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=JbbyhajF;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=PApFSkSH;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=JbbyhajF;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DECF760FA8
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
Subject: [PATCH v10 7/7] PCI/DPC: Enumerate the devices after DPC trigger event
Date: Thu, 22 Feb 2018 21:32:12 +0530
Message-Id: <1519315332-26852-8-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519315332-26852-1-git-send-email-poza@codeaurora.org>
References: <1519315332-26852-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086428728217914?=
X-GMAIL-MSGID: =?utf-8?q?1593117643449695576?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Implement error_resume callback in DPC so, after DPC trigger event
enumerates the devices beneath.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 0524bd3..382d5c5 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -128,6 +128,23 @@ static void dpc_wait_link_inactive(struct dpc_dev *dpc)
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
@@ -365,6 +382,7 @@ static void dpc_remove(struct pcie_device *dev)
 	.service	= PCIE_PORT_SERVICE_DPC,
 	.probe		= dpc_probe,
 	.remove		= dpc_remove,
+	.error_resume	= dpc_error_resume,
 	.reset_link     = dpc_reset_link,
 };
 
diff --git a/drivers/pci/pcie/pcie-err.c b/drivers/pci/pcie/pcie-err.c
index 6844347..d7e2377 100644
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
 
@@ -256,6 +258,17 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
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
@@ -305,7 +318,8 @@ void pci_do_recovery(struct pci_dev *dev, int severity)
 	status = broadcast_error_message(dev,
 			state,
 			"error_detected",
-			report_error_detected);
+			report_error_detected,
+			severity);
 
 	if ((severity == AER_FATAL) ||
 	    (severity == DPC_FATAL)) {
@@ -321,7 +335,8 @@ void pci_do_recovery(struct pci_dev *dev, int severity)
 		status = broadcast_error_message(dev,
 				state,
 				"mmio_enabled",
-				report_mmio_enabled);
+				report_mmio_enabled,
+				severity);
 
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
 		/*
@@ -332,7 +347,8 @@ void pci_do_recovery(struct pci_dev *dev, int severity)
 		status = broadcast_error_message(dev,
 				state,
 				"slot_reset",
-				report_slot_reset);
+				report_slot_reset,
+				severity);
 	}
 
 	if (status != PCI_ERS_RESULT_RECOVERED)
@@ -342,7 +358,8 @@ void pci_do_recovery(struct pci_dev *dev, int severity)
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
