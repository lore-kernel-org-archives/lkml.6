Return-Path: <poza@qualcomm.com>
X-Google-Smtp-Source: AIpwx48hBKqe9RllzZzx79+V/rKDN+MVylbB4dpoNWmVU5nTBAzvaf5MA90sonnxlrO2KwtH5N2l
ARC-Seal: i=1; a=rsa-sha256; t=1524496997; cv=none;
        d=google.com; s=arc-20160816;
        b=Sr7UraXIe7EN+ofgbbnVMiK5PjiWyjDL6GLOPMNyEF/Zk2n+73auJusf2IBaV6a/P8
         W6qVLU8+wD+czhM+AKRnypaSv5AzRwFs2FtX+m/em7Ygc8gel8V3w3s1z887bAybBlDy
         XqV9BwxwbLHq+bgvPt8Bjq+heAIZreCMSk6QFlhruL0chxozCM6yLprC3hbL4esEegdf
         EyXtSzd4STBwnnyuKkHgQ7oXpHX0upTDz9UesnLIPsCzibBP122KrO4khhjXTQLvhXvl
         la7uq8MFpzv4wjjG0S2uTUehqNontm/SdBf9MGcd/7jqzNiDpScst2O2/yoJYQLc5Kdx
         4ePw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=3QkSaovNbMONaTcYWGo1A2AwFcCFjbmse+KOm2UGAIk=;
        b=qxjYGZLtvV4fmXlx1FDRBYjeSYB6FfiKZBHCgUEdOWrlnGA5xgHkZJG/pLA7oytfi+
         Pfte11sh1TPJ/WcRo4Sr6kPgKhQd/efmyiuSXujPB4Xz+H1i7S6PalMLnfIhKm/Gp2Th
         3jxQSyrtXVWrRyQ8398E5LOebdyjLJcI003m4L2TOeKEs5ybf0NrWWXBixn5zX3r6j7w
         pS96owg79LlPhuRGVkLpVbs1NZfdGXPVWpSzCrSFtoI2A/IEcsQgAsWTxRT/fv60yWwI
         Br9jWmMZXcY0rEPplPtffGDAHxnzl6SzlFU93cR6q7uJDE+oRZsemicX9oWjvMdgltwj
         CQAw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 129.46.98.28 as permitted sender) smtp.mailfrom=poza@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 129.46.98.28 as permitted sender) smtp.mailfrom=poza@qualcomm.com
X-IronPort-AV: E=Sophos;i="5.49,318,1520924400";
   d="scan'208";a="16839214"
X-IronPort-AV: E=McAfee;i="5900,7806,8871"; a="173875856"
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
Subject: [PATCH v14 4/9] PCI/PORTDRV: Implement generic find device
Date: Mon, 23 Apr 2018 11:23:08 -0400
Message-Id: <1524496993-29799-5-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524496993-29799-1-git-send-email-poza@codeaurora.org>
References: <1524496993-29799-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598550963934276875?=
X-GMAIL-MSGID: =?utf-8?q?1598550963934276875?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch implements generic pcie_port_find_device() routine.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 419bdf3..06f4e11d 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -81,4 +81,6 @@ static inline void pcie_port_platform_notify(struct pci_dev *port, int *mask){}
 
 struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
 							u32 service);
+struct device *pcie_port_find_device(struct pci_dev *dev,
+				     u32 service);
 #endif /* _PORTDRV_H_ */
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 94de1fa..dd13cc8 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -25,6 +25,7 @@ bool pciehp_msi_disabled;
 
 struct portdrv_service_data {
 	struct pcie_port_service_driver *drv;
+	struct device *dev;
 	u32 service;
 };
 
@@ -432,12 +433,14 @@ static int find_service_iter(struct device *device, void *data)
 		service_driver = to_service_driver(device->driver);
 		if (service_driver->service == service) {
 			pdrvs->drv = service_driver;
+			pdrvs->dev = device;
 			return 1;
 		}
 	}
 
 	return 0;
 }
+
 /**
  * pcie_port_find_service - find the service driver
  * @dev: PCI Express port the service devices associated with
@@ -460,6 +463,27 @@ struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
 }
 
 /**
+ * pcie_port_find_device - find the struct device
+ * @dev: PCI Express port the service devices associated with
+ * @service: For the service to find
+ *
+ * Find PCI Express port service driver associated with given service
+ */
+struct  device *pcie_port_find_device(struct pci_dev *dev,
+				      u32 service)
+{
+	struct device *device;
+	struct portdrv_service_data pdrvs;
+
+	pdrvs.dev = NULL;
+	pdrvs.service = service;
+	device_for_each_child(&dev->dev, &pdrvs, find_service_iter);
+
+	device = pdrvs.dev;
+	return device;
+}
+
+/**
  * pcie_port_device_remove - unregister PCI Express port service devices
  * @dev: PCI Express port the service devices to unregister are associated with
  *
-- 
2.7.4
