Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x226Zioq7yqHNvyZ8EQU72PYGwzzOxrzHlrkEQ6aIYG8Ybu4sJYgG2ro2Oozc+BLBAS6PRV/g
ARC-Seal: i=1; a=rsa-sha256; t=1519837488; cv=none;
        d=google.com; s=arc-20160816;
        b=i/Ez4aO/Ct7blzT5voxqDhskz7RxM1/PK29hYTv2J+rXou5x8/lxMVfgF++8CprSla
         WiO1ijd0tRp9zNam186JPy4ycq12JT24m14xh+TFQIdC0q9w5OBsRix2dq5dufSEcY6S
         3bIyX77D3bdNJ5vX+fg912MYzbOetNxXKjXr53u2jolQC/wTcaQuwNafCYXCnvGOwlYG
         k4nBvKk+17yN/1oZC8iHyKFk7gNSvKP+baQ9tW6erTN4rWEG/PgC42NIcRPrFFOl9Cwq
         TyWDTu3/WuczECrCt5bu8/OhCMGZQf0EiIXg4ao1/31gLwGj4SJLhWvQuwE298NtOl7/
         CN0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=h3by/I4VCyYUGVEYIiGTOmWXbriPot57Z1K45Ctr5O4=;
        b=lqo5PTLMZEe2cCaSuC0FO00Xq4m8AVLV8BvS/5ANjmaMRCxe5CIFYV38aB6b4H+34D
         veCKWklt78pZJKK6N5BUtm3I1ZBH88YwXZEnJlSiXArX9lelSHYpo6XPrRwlUJ4WFM/0
         EPvxFnLNZZFiYxkfSiA0lSnAc+MJV/hjIOQRZeMpTeRB1onH1DaTxI9huPR0Vi2Dpvnx
         j+uEAZMgDJMsJ49djkLAumAmxNZ9aGJqELVXtR3dLZ0kfE7AXJQdhFGULCrBppEZWc6W
         F807escpZYolVJG6vpL/tltBHVTvNS1G4B1K4Qv1cMsXJm9H9jH6npco3jWPM+AWm8Ou
         eZDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=hidHHpio;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Nco+FFj6;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=hidHHpio;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Nco+FFj6;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F395B60240
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
Subject: [PATCH v12 3/6] PCI/PORTDRV: Implement generic find service
Date: Wed, 28 Feb 2018 22:34:14 +0530
Message-Id: <1519837457-3596-4-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593665114849236705?=
X-GMAIL-MSGID: =?utf-8?q?1593665114849236705?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch implements generic pcie_port_find_service() routine.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 4acec3b..aeb8236 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -231,32 +231,6 @@ static bool find_source_device(struct pci_dev *parent,
 	return true;
 }
 
-static int find_aer_service_iter(struct device *device, void *data)
-{
-	struct pcie_port_service_driver *service_driver, **drv;
-
-	drv = (struct pcie_port_service_driver **) data;
-
-	if (device->bus == &pcie_port_bus_type && device->driver) {
-		service_driver = to_service_driver(device->driver);
-		if (service_driver->service == PCIE_PORT_SERVICE_AER) {
-			*drv = service_driver;
-			return 1;
-		}
-	}
-
-	return 0;
-}
-
-struct pcie_port_service_driver *find_aer_service(struct pci_dev *dev)
-{
-	struct pcie_port_service_driver *drv = NULL;
-
-	device_for_each_child(&dev->dev, &drv, find_aer_service_iter);
-
-	return drv;
-}
-
 /**
  * handle_error_source - handle logging error into an event log
  * @aerdev: pointer to pcie_device data structure of the root port
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index c48eb0a..98aeec4 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -194,7 +194,7 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
 	}
 
 	/* Use the aer driver of the component firstly */
-	driver = find_aer_service(udev);
+	driver = pcie_port_find_service(udev, PCIE_PORT_SERVICE_AER);
 
 	if (driver && driver->reset_link) {
 		status = driver->reset_link(udev);
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 9a8d0dd..419bdf3 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -79,5 +79,6 @@ static inline void pcie_port_platform_notify(struct pci_dev *port, int *mask)
 static inline void pcie_port_platform_notify(struct pci_dev *port, int *mask){}
 #endif /* !CONFIG_ACPI */
 
-struct pcie_port_service_driver *find_aer_service(struct pci_dev *dev);
+struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
+							u32 service);
 #endif /* _PORTDRV_H_ */
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index ef3bad4..ffc6f4f 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -23,6 +23,11 @@
 
 bool pciehp_msi_disabled;
 
+struct portdrv_service_data {
+	struct pcie_port_service_driver *drv;
+	u32 service;
+};
+
 static int __init pciehp_setup(char *str)
 {
 	if (!strncmp(str, "nomsi", 5))
@@ -414,6 +419,45 @@ static int remove_iter(struct device *dev, void *data)
 	return 0;
 }
 
+static int find_service_iter(struct device *device, void *data)
+{
+	struct pcie_port_service_driver *service_driver;
+	struct portdrv_service_data *pdrvs;
+	u32 service;
+
+	pdrvs = (struct portdrv_service_data *) data;
+	service = pdrvs->service;
+
+	if (device->bus == &pcie_port_bus_type && device->driver) {
+		service_driver = to_service_driver(device->driver);
+		if (service_driver->service == service) {
+			pdrvs->drv = service_driver;
+			return 1;
+		}
+	}
+
+	return 0;
+}
+/**
+ * pcie_port_find_service - find the service driver
+ * @dev: PCI Express port the service devices associated with
+ * @service: Service to find
+ *
+ * Find PCI Express port service driver associated with given service
+ */
+struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
+							u32 service)
+{
+	struct pcie_port_service_driver *drv = NULL;
+	struct portdrv_service_data pdrvs;
+
+	pdrvs.service = service;
+	device_for_each_child(&dev->dev, &pdrvs, find_service_iter);
+
+	drv = pdrvs.drv;
+	return drv;
+}
+
 /**
  * pcie_port_device_remove - unregister PCI Express port service devices
  * @dev: PCI Express port the service devices to unregister are associated with
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
