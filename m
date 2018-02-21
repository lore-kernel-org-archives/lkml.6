Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x227sBarP+chsdo2rcqvubi+pRKoNvCFGggK5Y+s5DZ9HY9f+yJmhpuIgIxSpQasOhBMYgP1q
ARC-Seal: i=1; a=rsa-sha256; t=1519208845; cv=none;
        d=google.com; s=arc-20160816;
        b=K7igYUE1CjFDMT5QRAkD0oMpV/jBllRJOnC/znk+5eUgX/rJ24C+MdVrlGLuzXYNFc
         NOe+TnICrbtIdDW83qDWZqKF7IOBR0W8PyHX9GHHdAeb6R2A6rNB5ycpHyZAE40FgYj7
         Tfpn3LR2KlQE+4x7rF8RLfR+ufITNIjruvOXWkS/RjDo5YflIek6naxZRPp9bwZJApsS
         ceW3QDVP8sPr84WOJsZov/p4JnCNLhGUq17EC1HuGCWVQqOUVqe5C7WE07Yi5jTUvCmF
         Y9n2su+lto3iu2t0Ds6lq8tNtiNa3PPSQ5K4x1r0P4kQGjFTFHqVu/MKKcjCsoXJpU/Z
         4SZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=C68F99KdfW2TcDW7fsC2u90EkCEZQeJJQ4o6ycCoyMw=;
        b=LMJSjchf662Gx4Il2hrBQGQQ8HmR7HiY6K5paMQ78vv08pMLRiNXeD0mVWfStF1Bk8
         b9S4OdI3phLsnRmNjHSWI63waxLrcIO5vM9pPK4k22lXGWTBoHcMfczg1hGawSANUeyg
         KxuTP3ywZOuWSK9Kyq9kKHoz7Ety3NN4GtlJFp3KeGaDX/0exlEvp0ljtXyYtJSgyu8m
         pNlbS75tkDhWX2Sqzx8ol+ifJ7FUbKKB7LNrdnm9wInkqyNwFEeTisLfH2xsAJXiHiNR
         XHTyv4HPWLk2Cp2FUlOk21C5vdC7zcpfITs0SCzyqGJdFALe4C8c3Cvf5T1EJjYDBQDG
         2TWA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=OB4nXpJG;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=N4ol+FDU;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=OB4nXpJG;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=N4ol+FDU;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0CBCF6070D
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
Subject: [PATCH v8 6/7] PCI: Unify wait for link active into generic pci
Date: Wed, 21 Feb 2018 15:56:43 +0530
Message-Id: <1519208804-24512-7-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519208804-24512-1-git-send-email-poza@codeaurora.org>
References: <1519208804-24512-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593005934077578175?=
X-GMAIL-MSGID: =?utf-8?q?1593005934077578175?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Clients such as pciehp, dpc are using pcie_wait_link_active, which waits
till the link becomes active or inactive.

Made generic function and moved it to drivers/pci/pci.c

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 18a42f8..a133b8b 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -231,25 +231,12 @@ bool pciehp_check_link_active(struct controller *ctrl)
 	return ret;
 }
 
-static void __pcie_wait_link_active(struct controller *ctrl, bool active)
+static bool pcie_wait_link_active(struct controller *ctrl)
 {
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
+	struct pci_dev *pdev = ctrl_dev(ctrl);
+	bool active = true;
 
-static void pcie_wait_link_active(struct controller *ctrl)
-{
-	__pcie_wait_link_active(ctrl, true);
+	return pci_wait_for_link(pdev, active);
 }
 
 static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f6a4dd1..aff13c5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4176,6 +4176,41 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
 	return 0;
 }
 
+/**
+ * pci__wait_for_link - Wait for link till its active/inactive
+ * @dev: Bridge device
+ * @active: waiting for active or inactive ?
+ *
+ * Use this to wait till link becomes active or inactive.
+ */
+
+bool pci_wait_for_link(struct pci_dev *pdev, bool active)
+{
+	int timeout = 1000;
+	bool ret;
+	u16 lnk_status;
+
+	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
+	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
+
+	while ((ret != active) && (timeout > 0)) {
+		msleep(10);
+		timeout -= 10;
+		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
+		ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
+	}
+
+	if (ret == active)
+		return true;
+
+	dev_printk(KERN_DEBUG, &pdev->dev,
+		   "Data Link Layer Link Active not %s in 1000 msec\n",
+		   active ? "set" : "cleared");
+
+	return false;
+}
+EXPORT_SYMBOL(pci_wait_for_link);
+
 void pci_reset_secondary_bus(struct pci_dev *dev)
 {
 	u16 ctrl;
diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 208b427..fce4518 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -122,19 +122,10 @@ static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
 
 static void dpc_wait_link_inactive(struct dpc_dev *dpc)
 {
-	unsigned long timeout = jiffies + HZ;
 	struct pci_dev *pdev = dpc->dev->port;
-	struct device *dev = &dpc->dev->device;
-	u16 lnk_status;
+	bool active = false;
 
-	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
-	while (lnk_status & PCI_EXP_LNKSTA_DLLLA &&
-					!time_after(jiffies, timeout)) {
-		msleep(10);
-		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
-	}
-	if (lnk_status & PCI_EXP_LNKSTA_DLLLA)
-		dev_warn(dev, "Link state not disabled for DPC event\n");
+	pci_wait_for_link(pdev, active);
 }
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 024a1be..cb674c3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1195,6 +1195,7 @@ int pci_add_ext_cap_save_buffer(struct pci_dev *dev,
 int pci_request_selected_regions(struct pci_dev *, int, const char *);
 int pci_request_selected_regions_exclusive(struct pci_dev *, int, const char *);
 void pci_release_selected_regions(struct pci_dev *, int);
+bool pci_wait_for_link(struct pci_dev *pdev, bool active);
 
 /* drivers/pci/bus.c */
 struct pci_bus *pci_bus_get(struct pci_bus *bus);
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
