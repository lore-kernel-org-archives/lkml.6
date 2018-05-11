Return-Path: <poza@qualcomm.com>
X-Google-Smtp-Source: AB8JxZqrCDxsLfBJgpdXWSCiQHVkVtfYeVFifUbeDBQR86j2FjapGzzfliqZAUgBPbU7Hrad7x7L
ARC-Seal: i=1; a=rsa-sha256; t=1526035414; cv=none;
        d=google.com; s=arc-20160816;
        b=HhS04ArccBZRsETkW4AY/DNJo2VPbxPVibKCojrWoC6mAzwGH5Q5IW7Wo8jxNuRSES
         tf0zh+0ISglQO9WsMoUxDpBkTRXhaTgy4OMhjig7vOvocYR/Ouq0/hAhCLx/tPK1uj+K
         pZuaZmV0HuAus3KKPEVc4P90VUrJ1LBr9nhPgUdewwPqxIPIV57OQh3twl0kd5gVQ2P2
         EYhYLZb/0C654iZQkRckBQuEdRwD+7T3rpaf6M9SuRH4NgqS+OYZbLaezVGF2E8AHdG9
         lmoTNMIXuH6auZ0A3INjVWWqCSybJq9jn6SgQR3yLUjVRbFd4MF79Oo6iMHrBqyOq48w
         Fw1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Uamu9nTixlFw/nVi39a2NIxDgFepUNEIpAxUJNxh8H4=;
        b=UJUODV+Y0d75CudvSn8S5J0t2i0lBcTbkXe+FaOh81GcqUGJMnvixx2eDdzEg5cU70
         2RcWdqD8F3DVwR/Q18vs6NAqeN3BhJoahv+RYBgnuHhas6gtUqZN+r0/wWdGp+aqAp4f
         XFctNyQA0OX3/b9SdkQAzUIZdarW6JLwBFh4W8zCYJ2JNLvG4k74Y6GAWdKG1dsQmn1D
         6VIqlHlyD7hemF/bqJbNK/Pix1SqZeH/jDaxTy/G4VK1ZHMHcszEM7G9tgCV2MYktMnf
         T+PUiScFAxExJBSYADkrqzwjS2ncAoIE1mE/kelI8lFS0eOeF1qAC1IMxagZnVUkdFbV
         2s5A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 199.106.114.38 as permitted sender) smtp.mailfrom=poza@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 199.106.114.38 as permitted sender) smtp.mailfrom=poza@qualcomm.com
X-IronPort-AV: E=McAfee;i="5900,7806,8889"; a="82987134"
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
Subject: [PATCH v16 7/9] PCI/PORTDRV: Implement generic find device
Date: Fri, 11 May 2018 06:43:26 -0400
Message-Id: <1526035408-31328-8-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526035408-31328-1-git-send-email-poza@codeaurora.org>
References: <1526035408-31328-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600164110804285465?=
X-GMAIL-MSGID: =?utf-8?q?1600164110804285465?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch implements generic pcie_port_find_device() routine.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
Reviewed-by: Keith Busch <keith.busch@intel.com>

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index ba6c963..896608a 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -114,4 +114,6 @@ static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
 
 struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
 							u32 service);
+struct device *pcie_port_find_device(struct pci_dev *dev,
+				     u32 service);
 #endif /* _PORTDRV_H_ */
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index d843055..bc2c337 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -20,6 +20,7 @@
 #include "portdrv.h"
 struct portdrv_service_data {
 	struct pcie_port_service_driver *drv;
+	struct device *dev;
 	u32 service;
 };
 
@@ -415,6 +416,7 @@ static int find_service_iter(struct device *device, void *data)
 		service_driver = to_service_driver(device->driver);
 		if (service_driver->service == service) {
 			pdrvs->drv = service_driver;
+			pdrvs->dev = device;
 			return 1;
 		}
 	}
@@ -443,6 +445,27 @@ struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
 }
 
 /**
+ * pcie_port_find_device - find the struct device
+ * @dev: PCI Express port the service devices associated with
+ * @service: For the service to find
+ *
+ * Find PCI Express port service driver associated with given service
+ */
+struct device *pcie_port_find_device(struct pci_dev *dev,
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
