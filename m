Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x226guNSh+9fNdj9CjjI26H6E3DWwM/gldRP9mU0AMZLxsnPiRxduaa1K/7t+FjHblCFFxpyk
ARC-Seal: i=1; a=rsa-sha256; t=1519837497; cv=none;
        d=google.com; s=arc-20160816;
        b=HhpTfYVWgKbFIDAzRy5oqwetuQrxUq1dJMWcmbRITlYUyGLN8LlepVQ3L2xfvFBKdK
         Afaod7h/s4BlflUjDiZBtyJ1SEUAgUfRzSoufmTboxSPtWFEnimcmhwXOCKHkcttcZlC
         nlfabs+6fyc1H9UJAB2D8eiubKtJqxsei+pEhLNjrvamp5GyhUlBi2lklfmXbls/+QjX
         2StO4+md/ZiX3KlXQu9EkHJV2a2Tw4SC6W3rGNbcJVkIfpoucf5R6RFfwCbEOymTXlfO
         mNFUyMWX0SNqxLCE78Gsr3SlfQwOdR7lpzx9V31Fx3YTMNOdvYPAMi1bTNtAf1eHQ44m
         M49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=6KTNgowjfN2mzrXRCCzwrDRXHBCsydxEM1GujcQqxKc=;
        b=mWLcuZ9vvea89Eo/FYmkqz7XMgvlI7HEfWzJ1EQ48B9mnqA6J+CrAGwPRPZ5AQSxUA
         1LqQBHqmUEyveocbTNK8QUjyo990JTu96oNpSYBJDIKARZUwN2jAR5+yKABISQ2X0CmP
         s7NSPYbJfFIGoukqGOE5iY5Gjp47b2zndGxWwJ7CfWRxyZIStws8alkZ6tDLJAxJJHHc
         /vF2RRF8ZV8pAPohW52I3miuRVMJ/BIkTqYm2BclQ/R8gnG6QigIKPKXi9ARC6PwxJ0/
         y65Sj2MUGA2WAyzcS1PDCYX6dNHS5J00if4uvBxfAQADQZgwNVWsHN6/UtuRCXrPb5dx
         k/GA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=C0ea/7Rs;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=DsVdPyOR;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=C0ea/7Rs;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=DsVdPyOR;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 16B3A607F5
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
Subject: [PATCH v12 5/6] PCI: Unify wait for link active into generic PCI
Date: Wed, 28 Feb 2018 22:34:16 +0530
Message-Id: <1519837457-3596-6-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593665123498862590?=
X-GMAIL-MSGID: =?utf-8?q?1593665123498862590?=
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
@@ -345,6 +345,8 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
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
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
