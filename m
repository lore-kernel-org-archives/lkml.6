Return-Path: <poza@qualcomm.com>
X-Google-Smtp-Source: AIpwx48Z5qASFApRoPVUqxX5y9qCJsiU5QHZ8KZ5lqeyeOq2oSAg6XEpJlVJLgjiQs2VT9T/x/1y
ARC-Seal: i=1; a=rsa-sha256; t=1523284938; cv=none;
        d=google.com; s=arc-20160816;
        b=bI1XsFWgPGOBf3D4RxczGZIFsj5WugKznUjh+/OrTuHMpdeFQ0hDTTYsrHbhqG6BKe
         OJ49STDT9OyrI5k3vE5kNneeusDsutHd3tY4YGBc2q1GNQyAibGDjNmnyvIVc9ghuySC
         k7cfFivVaDHEt2lEyb2ErA5z6uH52ekb7YVbuwdAQ6DAEt4Jcy5b6vQA2obM+NseVnqT
         wf5mdrn+h04UhjTVC7QRMjkuZpm7qECm3U+OLtHR7ZYod3pOZAt0QPLTmtgcwUTjs/MH
         C9wLjzwheOUsr0ao2xDVVu2VHtVll+kj1jqcBHlgcQKLK+/7TnmnMtPVYKEM/VWfnRKQ
         /jfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=mWEKmoZm82PibK2mGEYujmW+o+/4oCioQV+dZ/hIcH8=;
        b=SB6eMfZpBcUDCWyNq+XPpD3bLTKsrj8swwfE6+96wf5MkWJfBKGgeE028761D7kX0B
         XfmGDRfB5/8lMRnVabgPzyQvIDnkFedBBAwZEuJQv2PTyi+nnLC55Q+NVMRFSIjX+Y5Z
         hv6QD7EWpmSCcINNceWbhPqwJtQXHMEEzqsIYBqtNP7Z3PWuu1QSkc5arzT+4DC5WsLy
         jfB1czg3p9Sz+qr9QE7TMSC5v3iUCmqCBOkJLIxNv4Rqj5eteyoX2FdJdNO+3fiGlujT
         lgBTq1wQUyycaFJwD9hLbIPnyfXBrneBkptCCVLfbPzbbcyzD3Y+GgbAe1+jf6C/ShyQ
         To+A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 129.46.98.28 as permitted sender) smtp.mailfrom=poza@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 129.46.98.28 as permitted sender) smtp.mailfrom=poza@qualcomm.com
X-IronPort-AV: E=Sophos;i="5.48,427,1517904000";
   d="scan'208";a="16629445"
X-IronPort-AV: E=McAfee;i="5900,7806,8857"; a="161794002"
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
Subject: [PATCH v13 5/6] PCI: Unify wait for link active into generic PCI
Date: Mon,  9 Apr 2018 10:41:53 -0400
Message-Id: <1523284914-2037-6-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280028398870927?=
X-GMAIL-MSGID: =?utf-8?q?1597280028398870927?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Clients such as HP, DPC are using pcie_wait_link_active(), which waits
till the link becomes active or inactive.

Made generic function and moved it to drivers/pci/pci.c

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 18a42f8..e0c2b8e 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -231,25 +231,11 @@ bool pciehp_check_link_active(struct controller *ctrl)
 	return ret;
 }
 
-static void __pcie_wait_link_active(struct controller *ctrl, bool active)
-{
-	int timeout = 1000;
-
-	if (pciehp_check_link_active(ctrl) == active)
-		return;
-	while (timeout > 0) {
-		msleep(10);
-		timeout -= 10;
-		if (pciehp_check_link_active(ctrl) == active)
-			return;
-	}
-	ctrl_dbg(ctrl, "Data Link Layer Link Active not %s in 1000 msec\n",
-			active ? "set" : "cleared");
-}
-
 static void pcie_wait_link_active(struct controller *ctrl)
 {
-	__pcie_wait_link_active(ctrl, true);
+	struct pci_dev *pdev = ctrl_dev(ctrl);
+
+	pcie_wait_for_link(pdev, true);
 }
 
 static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f6a4dd1..bbea997 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4176,6 +4176,35 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
 	return 0;
 }
 
+/**
+ * pcie_wait_for_link - Wait for link till it's active/inactive
+ * @pdev: Bridge device
+ * @active: waiting for active or inactive ?
+ *
+ * Use this to wait till link becomes active or inactive.
+ */
+bool pcie_wait_for_link(struct pci_dev *pdev, bool active)
+{
+	int timeout = 1000;
+	bool ret;
+	u16 lnk_status;
+
+	for (;;) {
+		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
+		ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
+		if (ret == active)
+			return true;
+		if (timeout <= 0)
+			break;
+		timeout -= 10;
+	}
+
+	pci_info(pdev, "Data Link Layer Link Active not %s in 1000 msec\n",
+		 active ? "set" : "cleared");
+
+	return false;
+}
+
 void pci_reset_secondary_bus(struct pci_dev *dev)
 {
 	u16 ctrl;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index abc514e..5c44fbc 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -345,6 +345,8 @@ void pci_enable_acs(struct pci_dev *dev);
 /* PCI error reporting and recovery */
 void pcie_do_recovery(struct pci_dev *dev, int severity);
 
+bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
+
 #ifdef CONFIG_PCIEASPM
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 517c8b4..8e1553b 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -95,19 +95,9 @@ static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
 
 static void dpc_wait_link_inactive(struct dpc_dev *dpc)
 {
-	unsigned long timeout = jiffies + HZ;
 	struct pci_dev *pdev = dpc->dev->port;
-	struct device *dev = &dpc->dev->device;
-	u16 lnk_status;
 
-	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
-	while (lnk_status & PCI_EXP_LNKSTA_DLLLA &&
-					!time_after(jiffies, timeout)) {
-		msleep(10);
-		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
-	}
-	if (lnk_status & PCI_EXP_LNKSTA_DLLLA)
-		dev_warn(dev, "Link state not disabled for DPC event\n");
+	pcie_wait_for_link(pdev, false);
 }
 
 /**
-- 
2.7.4
