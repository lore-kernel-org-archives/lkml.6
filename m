Return-Path: <poza@qualcomm.com>
X-Google-Smtp-Source: AB8JxZqqkZar3+j4VaDWhVAHsUaH4Rw3G12GnpxY0iy53lCkaCRoLC91qZFNq2rekIanZgZAXg71
ARC-Seal: i=1; a=rsa-sha256; t=1526035413; cv=none;
        d=google.com; s=arc-20160816;
        b=WkZtHFYG9+SeuKHcgtpEzS/nYk4ZdbmBcOnvCj2i3zaTP5Ap293yJfdgY4eibU9xFl
         +3UYZLJ062c/aU4niC3ehRqz6YCJ51Z3h85An0s8CLgaOLl87nPdjeK00DWC+mwOHN7o
         kW0ZVDVMIZSeA1MOsFlQQrGN9s8FlHS2OEj5lwR0bB2u1Osra/KuifdQEg5TjKCvtPTM
         aMXE3UKFhrFjt2ZGTfa9KtULmyMc2G+jc1m1Kpsh3duQ64F7S3G97woR+/SMaJnGHBtx
         CHfxtII+HSLrUP869YEOw+dmedEbXAj6/BKh5xMh2oVuT2eRF8gQc/jHTenOs02oUWwv
         tI1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=TiuAlLFcn85H1K/Qum+domAsG4GfMtJ972BYAOV4Luo=;
        b=isLQXT/mACc9dAgxOBiE2EZSfuCVudLyC3smPEOToY4vU3o81ihtT8pizKym3KVi1I
         fQmA5UGPvxGaH1KXcTyXdLtYHGQjW9OYV5sAfHCVkAqLj5AplbQHo4e1H07PrMnsmKDZ
         yu2852dRrA/xFqOrAqk7YQ5oC3qCwcJLhwfLDZ2Xsrer9wjH+7OpGAAisMwHD0ON8qHN
         67ajrHTl1Ig+DZoOXbeVYrFK9Su0ZczgSx2aJkzmQogahPVLfKeeDXW+zNanHOHJn+Ni
         pwALqKkD/kkUwBtrltnsLbDASHTSjjVY/ONGhHYi5k4CiEAEM5kkfAWiUNtAPaJAbqOP
         jfKA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 199.106.114.38 as permitted sender) smtp.mailfrom=poza@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 199.106.114.38 as permitted sender) smtp.mailfrom=poza@qualcomm.com
X-IronPort-AV: E=McAfee;i="5900,7806,8889"; a="82987115"
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
Subject: [PATCH v16 1/9] PCI: Unify wait for link active into generic PCI
Date: Fri, 11 May 2018 06:43:20 -0400
Message-Id: <1526035408-31328-2-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526035408-31328-1-git-send-email-poza@codeaurora.org>
References: <1526035408-31328-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600164109933664581?=
X-GMAIL-MSGID: =?utf-8?q?1600164109933664581?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Clients such as HP, DPC are using pcie_wait_link_active(), which waits
till the link becomes active or inactive.

Made generic function and moved it to drivers/pci/pci.c

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
Reviewed-by: Keith Busch <keith.busch@intel.com>

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
index e597655..adfc553 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4138,6 +4138,35 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
 
 	return pci_dev_wait(dev, "PM D3->D0", PCIE_RESET_READY_POLL_MS);
 }
+/**
+ * pcie_wait_for_link - Wait for link till it's active?/inactive?
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
 
 void pci_reset_secondary_bus(struct pci_dev *dev)
 {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 023f7cf..cec9d8c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -353,6 +353,7 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 
 void pci_enable_acs(struct pci_dev *dev);
 
+bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 #ifdef CONFIG_PCIEASPM
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 8c57d60..80ec384 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
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
 
 static void dpc_work(struct work_struct *work)
-- 
2.7.4
