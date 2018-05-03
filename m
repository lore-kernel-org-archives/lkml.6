Return-Path: <poza@qualcomm.com>
X-Google-Smtp-Source: AB8JxZojBScwdUexXaKScxXcvRYexMTeYzAc9huNcWd7Ju7sIu8YcSwRMLB+iqv58769cqotzCpR
ARC-Seal: i=1; a=rsa-sha256; t=1525323846; cv=none;
        d=google.com; s=arc-20160816;
        b=VH4NKv3i1Vpe+9w1ftcbLXddOGoGzKXuvZW+wjOpMRWgUwrEl3jwBFtr+0wrh9QMQt
         sEikhqpHWYMI1dNoi2JTCf3zDeTjeqwQmg2+/4Bi8RDqyPEFPN1MSjJNg3jNAzq1LwRO
         OGeHOx1U7JZV2kSS2JYV6qCOVK+hVexnOYpD2jw4xPLSI3WxuDelINEmcO/IPGs4Kx9+
         GN30/RS2WlJXIQGQeGUQWMeNKu61+8gnmWlD0z2dV1BxoEMyjlCFI3CKbirPAiZ2/mcV
         f65lP39Wv8o2VbtdAxwgAYz4GebujopRp/WfTUPXb+HdOxv3rajwB9xCdBr5pp01pqPL
         V95A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=rbDJPF8reTwDuA6mqr3Qn8HMsERKz+JaMXLkz+6cP50=;
        b=Xc+5J1v5QNRN0QI1Z7v1wyzkW8WqVlMD1jYjCNrNxbgLyFPRmz9oKWIh0oKrOYwG2m
         PxhY2Lnu8ZixSBBw75dp3y9wLTLwEAKn5iv+4r8eNrcZ8hBBVafO3hQrSzslbbOwj4gh
         gaRrGmOrpbsUq50KrI1P7weSx2oYLek4i4JkTFbH2/WMwgp4motuChYzbDXYkuMcCi3f
         QhWtdgdqIVqUZ25BtXby5SJIddxzOJk7o7iO0upowrCCj1fQkH+sRxJGJf4Ag550+WWK
         8+O4/qPHtA0BT95B4vEqZPgv3W712rCW8ZNZPYQ+7DnzhSUsG0p2gsm5U0IVSiihNl/z
         EpfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 65.197.215.72 as permitted sender) smtp.mailfrom=poza@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 65.197.215.72 as permitted sender) smtp.mailfrom=poza@qualcomm.com
X-IronPort-AV: E=Sophos;i="5.49,356,1520924400";
   d="scan'208";a="126361294"
X-IronPort-AV: E=McAfee;i="5900,7806,8881"; a="152473228"
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
Subject: [PATCH v15 3/9] PCI/AER: Handle ERR_FATAL with removal and re-enumeration of devices
Date: Thu,  3 May 2018 01:03:52 -0400
Message-Id: <1525323838-1735-4-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525323838-1735-1-git-send-email-poza@codeaurora.org>
References: <1525323838-1735-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599417977501212020?=
X-GMAIL-MSGID: =?utf-8?q?1599417977501212020?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch alters the behavior of handling of ERR_FATAL, where removal
of devices is initiated, followed by reset link, followed by
re-enumeration.

So the errors are handled in a different way as follows:
ERR_NONFATAL => call driver recovery entry points
ERR_FATAL    => remove and re-enumerate

please refer to Documentation/PCI/pci-error-recovery.txt for more details.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 779b387..206f590 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -330,6 +330,13 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
 	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
 
+	/*
+	 * This function is called only on ERR_FATAL now, and since
+	 * the pci_report_resume is called only in ERR_NONFATAL case,
+	 * the clearing part has to be taken care here.
+	 */
+	aer_error_resume(dev);
+
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 0ea5acc..655d4e8 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -20,6 +20,7 @@
 #include <linux/slab.h>
 #include <linux/kfifo.h>
 #include "aerdrv.h"
+#include "../../pci.h"
 
 #define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
 				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
@@ -474,6 +475,44 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
 	return status;
 }
 
+static pci_ers_result_t do_fatal_recovery(struct pci_dev *dev, int severity)
+{
+	struct pci_dev *udev;
+	struct pci_bus *parent;
+	struct pci_dev *pdev, *temp;
+	pci_ers_result_t result = PCI_ERS_RESULT_RECOVERED;
+
+	if (severity == AER_FATAL)
+		pci_cleanup_aer_uncorrect_error_status(dev);
+
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
+		udev = dev;
+	else
+		udev = dev->bus->self;
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
+	result = reset_link(udev);
+	if (result == PCI_ERS_RESULT_RECOVERED)
+		if (pcie_wait_for_link(udev, true))
+			pci_rescan_bus(udev->bus);
+
+	pci_unlock_rescan_remove();
+
+	return result;
+}
+
 /**
  * do_recovery - handle nonfatal/fatal error recovery process
  * @dev: pointer to a pci_dev data structure of agent detecting an error
@@ -485,11 +524,15 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
  */
 static void do_recovery(struct pci_dev *dev, int severity)
 {
-	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
+	pci_ers_result_t status;
 	enum pci_channel_state state;
 
-	if (severity == AER_FATAL)
-		state = pci_channel_io_frozen;
+	if (severity == AER_FATAL) {
+		status = do_fatal_recovery(dev, severity);
+		if (status != PCI_ERS_RESULT_RECOVERED)
+			goto failed;
+		return;
+	}
 	else
 		state = pci_channel_io_normal;
 
@@ -498,12 +541,6 @@ static void do_recovery(struct pci_dev *dev, int severity)
 			"error_detected",
 			report_error_detected);
 
-	if (severity == AER_FATAL) {
-		result = reset_link(dev);
-		if (result != PCI_ERS_RESULT_RECOVERED)
-			goto failed;
-	}
-
 	if (status == PCI_ERS_RESULT_CAN_RECOVER)
 		status = broadcast_error_message(dev,
 				state,
-- 
2.7.4
