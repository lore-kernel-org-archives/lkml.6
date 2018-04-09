Return-Path: <poza@qualcomm.com>
X-Google-Smtp-Source: AIpwx4+AAisFAxCjLK7i2h9JEoKEcnT4u+6Ojl3V1IkYw27fmd5F78rymXPfeHCVVtQmWgY8DRyp
ARC-Seal: i=1; a=rsa-sha256; t=1523284938; cv=none;
        d=google.com; s=arc-20160816;
        b=KP3jbr/QFORI240OVRAN04CqAFvs92m6Q4HAt20cdpn4OhsWKSceUK9w00rdez+CP1
         Na0Ai4I0bfRPaBvg2SwzgPc/facFPo0Q8MRFBRGQYAW7QXRvV51aUyFeeZufzWuTpBLU
         uBkiqOsfBL7iRvsCiji/11j3g0m5pwym6QZNqlg1b03uj1J33KusaBwydvw5zoz3xcJC
         ZC/H9HisDT4Z0zx3pVpu52OZ50mMa1+I3PVjhGpnNjRxjaFbh5p5ouUUqE+RKNPW5p00
         CDfn1hyfKGJNkIdBS9zz0cr8f2r87PvgVAFztSQFYqz08saIWU+X0zND+irl5z2+tEKm
         OgAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=erke60aKxtq5XDPmuECLdNt25cD074ivzGMy0bTciZA=;
        b=nPfzGnrYbnOMq8xXbYxBjc4Z9HPe4GwE1kATxeurAP0qow34tYEd8T6Cs2vJTn6AHG
         tjJF7rInA3eoZkNpo4yTMFjf4U+8FLKQ8EPc+GnR8e6iAj6Rz7yCG0INKWgot+7cw1ZF
         Ft4bBZuHJOhJuPsVnQWuMN9YVoncH5I/7mPoFZXkwjTjZBuO4HSBDJObGyxsJjmPgGcg
         91FmwSOeFpN3mr2e8PXpoEHNemUhfswOhaISq1QcDKrG10g3Wb073o4E3N7vKS2bcRW0
         CLHDlV/TwurOq5vn3aObtmd3KPhvZu8dtjZaU33OxrnFhHtD0BczkAIQ2XE2EmeynoSM
         aTyA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 199.106.114.254 as permitted sender) smtp.mailfrom=poza@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 199.106.114.254 as permitted sender) smtp.mailfrom=poza@qualcomm.com
X-IronPort-AV: E=Sophos;i="5.48,427,1517904000";
   d="scan'208";a="334950783"
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
Subject: [PATCH v13 3/6] PCI/PORTDRV: Implement generic find service
Date: Mon,  9 Apr 2018 10:41:51 -0400
Message-Id: <1523284914-2037-4-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280026938486684?=
X-GMAIL-MSGID: =?utf-8?q?1597280026938486684?=
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
