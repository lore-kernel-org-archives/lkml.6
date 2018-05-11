Return-Path: <poza@qualcomm.com>
X-Google-Smtp-Source: AB8JxZrliyhg+6K1X1rOKw0NbrPqIZHBFy4FnkmOYFX6kvWg4bW1g21nRW5u9qogw9045v50ssiO
ARC-Seal: i=1; a=rsa-sha256; t=1526035415; cv=none;
        d=google.com; s=arc-20160816;
        b=PErF6RsXapBJxYR5gAVIcJWoNp8Kpnvh+2+9fQMHYZJwOJKQWdnJ19aInAUoCKPNld
         2mOQk1wIOGUux4JH91opPEqArC8Bnswfi2lLaRYbYGO3/sCKJg9vVHY1RNd5TBnYhAhv
         6yM59cGszfQG6PFekzHdxoqkJnlfhKuRAAhZnQcbuZAqBoqAZLaWoZg6rmG3ua23rCEj
         wuNuqRoFM2E3t9czk6wpYcSFyVbLXp+bJTK0e3mwf/dfSE+E0h+jMIPsgjnIBpBDBjH/
         jN9q+Q3FZ7+miZhUkeicMfXR7d9DLc4Qh15BpW5LizAsbqQG6JlDWY0XGK+gUYs5FzAa
         nvtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=BI/bIlwpt0QcXf2z+cu73dOhRJzklg5ml2BrUn25d34=;
        b=rBNklhHSUlwNM0qlwuFGjhjRGJVj7q2HAWGMm88gTdXe7jK4TJK0j1nF5n7dYe7DTz
         mZc3yFR7JQ5Wwc+89h4w/+bx7RulZ9B6HO8p84CCf90DqXBl8XVnT+/EudTu4y/HD+gq
         d+q4f5YbzwBcuyxAR3FIqVpqJMIIZPB0TrglnBn5dhMrOYe8QuhdtYc0ZrJQOoyJKeec
         tJ/wX0N/eNSosv4OiTzm3mw933glIanwjpqx5hFuunto4M+5NtNqZt4R33oOPp2nz1RF
         KL7LMfrzMsdPLV6Z2vPSdKXUH5az43uZ6MYpWchDGeckKYoeCoiRm4zIUyMqq51jezuU
         im+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 199.106.114.251 as permitted sender) smtp.mailfrom=poza@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 199.106.114.251 as permitted sender) smtp.mailfrom=poza@qualcomm.com
X-IronPort-AV: E=Sophos;i="5.49,388,1520924400";
   d="scan'208";a="435728393"
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
Subject: [PATCH v16 6/9] PCI/PORTDRV: Implement generic find service
Date: Fri, 11 May 2018 06:43:25 -0400
Message-Id: <1526035408-31328-7-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526035408-31328-1-git-send-email-poza@codeaurora.org>
References: <1526035408-31328-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600164111686652735?=
X-GMAIL-MSGID: =?utf-8?q?1600164111686652735?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch implements generic pcie_port_find_service() routine.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
Reviewed-by: Keith Busch <keith.busch@intel.com>

diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 4fa1ee4..fdfc474 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -228,32 +228,6 @@ static bool find_source_device(struct pci_dev *parent,
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
index c4ded88..33a16b1 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -199,10 +199,8 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
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
index 47c9824..ba6c963 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -112,5 +112,6 @@ static inline bool pcie_pme_no_msi(void) { return false; }
 static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
 #endif /* !CONFIG_PCIE_PME */
 
-struct pcie_port_service_driver *find_aer_service(struct pci_dev *dev);
+struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
+							u32 service);
 #endif /* _PORTDRV_H_ */
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index c9c0663..d843055 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -18,6 +18,10 @@
 
 #include "../pci.h"
 #include "portdrv.h"
+struct portdrv_service_data {
+	struct pcie_port_service_driver *drv;
+	u32 service;
+};
 
 /**
  * release_pcie_device - free PCI Express port service device structure
@@ -398,6 +402,46 @@ static int remove_iter(struct device *dev, void *data)
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
