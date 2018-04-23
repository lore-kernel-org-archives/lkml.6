Return-Path: <poza@qualcomm.com>
X-Google-Smtp-Source: AIpwx48nkCiJ4ydinZ9GjKD+sIaheyiGvJ59tEMya1lBkT7vvng4lsFedeKymU5lUXcB2M/neDg2
ARC-Seal: i=1; a=rsa-sha256; t=1524496997; cv=none;
        d=google.com; s=arc-20160816;
        b=S0T7c57YO32gdFhlprDyEObcAtLwcas0+s6uEJG238lrjdgqh/REEo2LyKNhPt3Aay
         U3Z+W9sAZmFCR1/hbHS2Zb+MlL7Bw48Tljnrba+zN9u6U6sY9LnkiDFdwh+UHOq+whEc
         i71gvA6rXUTEmWuWqXfq06Dp+9LMzmhUCu3d0WPSiSTvKiu/JV6iWMQBoUwLa6eAf6+1
         alS1dQJwiMN41i3qRCkt6jz59G1H0N4+e9/qSsfpV5J42aI//LhNlx5ye30HAf9MpQm2
         5jsvoOzqKpMNsXGI+rqFTXOiGWW+yq8YaNaBWfMfYff1mIIeVl3zp9k/orgsSGEjjctE
         ghew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=+d3MgnKfIoj7f2/bsjlph13GVBInKp2VnVePwVd4Gg8=;
        b=ndyoZV/C0dmc8McFArDWfyb1oQFY/HCip5isEa/PtA+yMBeNUUxRGhBJ7TbPDAq8sb
         2iGhZr9XShJlr846afdg7PNpMkz1a4SnU47jhhA8b5MgvimaIz0sjKjGEXg1m64tO8rn
         Lsaw4GHMvkJBaFZENJ0YxASoM+sNPLJ9y5FxRTa0l4b00UF1dVvN20f3ieWXRAS+GKUz
         MwsU70HlOiadpyfqVu8UR1VbF/LD5ExZJqq5Q68LJTf7eKddoJ4TFXb4pIdNW76wbHlq
         7dXXRaQrBgcY53ym4pzdfCuojHeuLeyfxB/gPnfqwyUXb5tAWxb/6W3B5na1qgomfO+a
         B8+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 199.106.114.254 as permitted sender) smtp.mailfrom=poza@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 199.106.114.254 as permitted sender) smtp.mailfrom=poza@qualcomm.com
X-IronPort-AV: E=Sophos;i="5.49,318,1520924400";
   d="scan'208";a="337205360"
X-IronPort-AV: E=McAfee;i="5900,7806,8871"; a="68659285"
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
Subject: [PATCH v14 6/9] PCI: Unify wait for link active into generic PCI
Date: Mon, 23 Apr 2018 11:23:10 -0400
Message-Id: <1524496993-29799-7-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524496993-29799-1-git-send-email-poza@codeaurora.org>
References: <1524496993-29799-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598550963964253272?=
X-GMAIL-MSGID: =?utf-8?q?1598550963964253272?=
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
index f6a4dd1..2bcf977 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4176,6 +4176,36 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
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
+		msleep(10);
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
index ad02298..6baed85 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -68,19 +68,9 @@ static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
 
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
