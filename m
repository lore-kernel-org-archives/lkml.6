Return-Path: <poza@qualcomm.com>
X-Google-Smtp-Source: AIpwx4+Yif3oiMTxy7D+MiGymwhXPZ2MYvS3EJIt/3NVcTOyjJpWgS/BgvBzDVTN2EPXR/oewEvd
ARC-Seal: i=1; a=rsa-sha256; t=1524496996; cv=none;
        d=google.com; s=arc-20160816;
        b=hW3PwhUJPtagmWs5qRcpvzMkOcyON5ymOPCs0a8oI1FJ3t17HX3aKp8JKkD8h3Vu8Y
         4Tt7lEg1B20AH6GX+RecEVuG7N06K33sJWGjNkbsX7wB63PipDnyRuvqqCXynF/HbjZc
         Q4yXrYg2+gnLdambcign1FV4eUix/N4u46KI/jY5vPx+jfDhkXc49DWoRv0f8gE1mkNf
         tuKQVV/AMxrCsZyrQBChlorhtmtPTDLGy8CqyAjug/zM4iH/d1sNKEtaQLUGpZgLmOYp
         Q4tSvLm8fcwveCJmjktX5kka5ZEMFKvXVvGHSR0x5rUOmD5LCMe91crTrRvk2qvL93iN
         6bAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=5QQnjT/FWAwInwIRRPSYUz3ajOaDFioCWZe5EfccPdI=;
        b=OjtZXe9mN1qV2iYou1/PAWKJrytDzSCa9gyrC6lNJDZ6bTUTjQFDHKilv4ruGGapg3
         mFg5K3KInKl3yhYh/TTzV8xIOU2JknDyyziCdig4dvckjMgGLE11Qap+YjKNIT3MpJC9
         9J/ohGUZrSua3NEyQpJZQqWfXu+a43a2zY0WF014GcSSVAH0LgmB4Z6CwKyYOosgfuVM
         gQ6xdLjVCo7lplOX+QsSO8Tp290OHccCJ1J80lRbEtxtoYce9YiHUq0KWQTWkMtnvAE2
         NgjeUBtmoDr0lR5WSO7WbCvx658/4pmK3fei75xW0n1YK+0jJ/VZhEor9dw/HJR/VXn/
         O0vQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 199.106.114.254 as permitted sender) smtp.mailfrom=poza@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 199.106.114.254 as permitted sender) smtp.mailfrom=poza@qualcomm.com
X-IronPort-AV: E=Sophos;i="5.49,318,1520924400";
   d="scan'208";a="337205356"
X-IronPort-AV: E=McAfee;i="5900,7806,8871"; a="68659280"
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
Subject: [PATCH v14 3/9] PCI/PORTDRV: Implement generic find service
Date: Mon, 23 Apr 2018 11:23:07 -0400
Message-Id: <1524496993-29799-4-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524496993-29799-1-git-send-email-poza@codeaurora.org>
References: <1524496993-29799-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598550963210380977?=
X-GMAIL-MSGID: =?utf-8?q?1598550963210380977?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch implements generic pcie_port_find_service() routine.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
Reviewed-by: Keith Busch <keith.busch@intel.com>

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
index c6a9a72..98aeec4 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -193,10 +193,8 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
 		udev = dev->bus->self;
 	}
 
-#if IS_ENABLED(CONFIG_PCIEAER)
 	/* Use the aer driver of the component firstly */
-	driver = find_aer_service(udev);
-#endif
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
index ef3bad4..94de1fa 100644
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
@@ -414,6 +419,46 @@ static int remove_iter(struct device *dev, void *data)
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
+	struct pcie_port_service_driver *drv;
+	struct portdrv_service_data pdrvs;
+
+	pdrvs.drv = NULL;
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
2.7.4
