Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x226lf7nWccFu4YEAS5ODXWmowraJbu9O7cfZYyfgO6BL9z4RZV02bxGdqAQRPE3y0tlrUBej
ARC-Seal: i=1; a=rsa-sha256; t=1519374280; cv=none;
        d=google.com; s=arc-20160816;
        b=D9xYNg/cwsV4lxz0GHIzSCX+NZSXs1yItOR/4nwcbFiJpYKpufq2+NGei7H7vPi8SJ
         fy49yG2L8LonR6YgU/lTbBa7VEGJr4T09wFIo6c/tjlr94Inf37ghTxTbrVkaoA8OPiH
         eqJUeNdGU82ByDKWcn4VnYHo90dnlhOjLmdrSGLECobSl616PgCQSL12GifB/FQO9J6h
         NzktPAjVSz1+spIZY44/tNVO7PYTyTaZNemA1nHOdXD4c8t+mtTmja06VBhMkCZkS6EN
         cK0dsZ7MxQwfgGtRj/x+PhVuKFgru7vpkWOVm7lYmgsvy4n3gUi1MV4n/+tKnzZOnhwU
         uZ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=m6gvST5HNHM3/4tlt3ll0haevBnLk8uI5b6kaT8KeLk=;
        b=vhtS26jyY270TI5+UWLjssLpvyKmQmGlI6hCNTv+DdfAQz+g6TpfQuVgcryxnw9iWb
         ZrkueByLDhDpTGIUhhyVdh481O8HBnamvPw2dyxlxz5P1/ZXSOYDQ2zGtiAkAKJId24S
         H6xykg8iCJvz+popp3kV6MATCXvFoWeCKdzjeqDcCXH1MncmpHj3V3qe9cHPhlAUCa3J
         8/2Mo+Ytgq6elQv9c6eqMV2VKCvZ0QlS4oX7EZ2gRkdcwWqvS2kVwy2UOPeSLeWLP8FK
         g1N+6lDtAVsacqesVRfd6Asy40u6KYjFePmcLW/AEeQIsE8bKvQxtXPN36JNcil2+MNy
         +XOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=df07v6e5;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=df07v6e5;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=df07v6e5;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=df07v6e5;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9187460F6B
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
Subject: [PATCH v11 6/7] PCI: Unify wait for link active into generic pci
Date: Fri, 23 Feb 2018 13:54:03 +0530
Message-Id: <1519374244-20539-7-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519374244-20539-1-git-send-email-poza@codeaurora.org>
References: <1519374244-20539-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086424372892434?=
X-GMAIL-MSGID: =?utf-8?q?1593179405111225142?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Clients such as pciehp, dpc are using pcie_wait_link_active, which waits
till the link becomes active or inactive.

Made generic function and moved it to drivers/pci/pci.c

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 18a42f8..de9b0ea 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -231,25 +231,11 @@ bool pciehp_check_link_active(struct controller *ctrl)
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
 
-static void pcie_wait_link_active(struct controller *ctrl)
-{
-	__pcie_wait_link_active(ctrl, true);
+	return pci_wait_for_link(pdev, true);
 }
 
 static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f6a4dd1..f8d44b4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4176,6 +4176,37 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
 	return 0;
 }
 
+/**
+ * pci_wait_for_link - Wait for link till its active/inactive
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
index 5c01c63..e15bcda 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -120,19 +120,9 @@ static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
 
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
+	pci_wait_for_link(pdev, false);
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
