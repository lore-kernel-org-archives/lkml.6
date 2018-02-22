Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x224IQMeIQl74lEKIBRnNIK4qMcateiWg5TNmneNF/f0mhNGVzIqq44CCQCAnp02PN2gflnPY
ARC-Seal: i=1; a=rsa-sha256; t=1519285606; cv=none;
        d=google.com; s=arc-20160816;
        b=sT3K27nP0pqHHX8Tw8twJqGXeVDiClTHjLb2AfL/e8mB0dYJyNVOgkP5JKz2BLCaqt
         /2Nt8A87CZ9rc0U1/Vxk3N1zDDTR/Dn6CAwssNr4CDjvnouwftxm5wb9vmFT7F3CVF19
         tuIQurpoa+zt/13GNVntPa1IPF1w8FXjS+Ve+eKvnLKAxYj5i5MOYXQtvPmUhcuxOT+J
         ujYsHh3F2ljXyFd0gVSI2zozoDPKqBPMpByng0QgPvorkgFYciJD1g3+R9qJ9u18rGaf
         AQUKgxiQonhCOQ6flujEzHOUVcwU+cZYPpng8zR/ete4BEG/8vhIebZILfnlsvwPwDDR
         5vzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=bdwDvlfMapBRyMKuu0l7BS0cu/DWiMi4hUei9b2ZnOk=;
        b=hO7CN1v6RZ/6aZfMAmgZBRvuzI+0jS/x69au37jhlsKj2xeZqRzX6ueID9jRL6W8C/
         M8xXUZO9EnJZAEcoHHPlNCOq1FMsrTNmqrU1QYMEuVeoa54AyBKKglZ+DKZuGPvflCrJ
         M8NZ3QPkJK2jdLP/wBkz10kbWNtFsLshO9goZQ8VMFd8LNGBTrE7kYt0xFjmzL7N53rK
         eZDONViml2ffYeKTjLpKSBA3tpISf2OXpObxyIWqEsnZ6RkbA8D+gaJLl4DE/kKNdFCa
         I868Kw50JC2jL8wxo7afRnKweYVZ92uV5BOyXd8ll4B+J7lpP1biFWdE+G5WeokB01fH
         aTcA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Szix2YhJ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=CpUa+1Z4;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Szix2YhJ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=CpUa+1Z4;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B24096079B
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
Subject: [PATCH v9 6/7] PCI: Unify wait for link active into generic pci
Date: Thu, 22 Feb 2018 13:16:10 +0530
Message-Id: <1519285571-5634-7-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519285571-5634-1-git-send-email-poza@codeaurora.org>
References: <1519285571-5634-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086424372892434?=
X-GMAIL-MSGID: =?utf-8?q?1593086424372892434?=
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
index f6a4dd1..5440696 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4176,6 +4176,40 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
 	return 0;
 }
 
+/**
+ * pci__wait_for_link - Wait for link till its active/inactive
+ * @pdev: Bridge device
+ * @active: waiting for active or inactive ?
+ *
+ * Use this to wait till link becomes active or inactive.
+ */
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
