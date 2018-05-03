Return-Path: <poza@qualcomm.com>
X-Google-Smtp-Source: AB8JxZrSXG7vynKyEMTi6/fV+lTg7qIYcouNIOMFFJElKVyNTkfuKePy4yEcIudqkVLbRZ0f7w3j
ARC-Seal: i=1; a=rsa-sha256; t=1525323847; cv=none;
        d=google.com; s=arc-20160816;
        b=LYA5Vz6tzys8/uLyjzKqT+t2kB2Bl92wjJ3qCpGA0ObveCG6anux3KwvrYuLTyXuRe
         4yp/uqyxwjt0nu3ubZREelapf4KWV/hf+kMnIGZtHHBIQh3f9X/7DiNIUKtpByK64XM8
         K+k+7Ivzy0n4eo9SiQdRIL7e+mYBvhHxdMfrxmfYOIeVVP3h5Lb+EwkSHbPzHN5fAL/f
         F7psxGZZCVJsOtdUoPaEIF99Fd5C3gCcrpQjFKs9KBAv2dG1VRThBUpF7EtrhyQhBRw/
         1SKGh3l3Sa9znCntNJDigGNuRpQne/pIJJSTqT+T5fKKLluHhhUz8wUf8onKj8oPhA6Q
         gquA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=jVnavRtPW7QLrHDqBj1mvSLisgWy38a8+qEoZq4aJMc=;
        b=c1t+T3TDGh7NiNLdLsK0INH3Ti8IFi3U4syieJIaMlpoui8H91mg2xmHeS2fEp/vd7
         jN8WWf+9kzVdXq8lY2pV7oPXkJFh3pU7KVqizm+iob4Jsr6SeqtdMuxGKpyFZ1vUBQ9i
         yRL4iwPnxh0QCz479zoZ9flHBxylTP0X2hTvhMJCV6khrU86dNEd7KYnktEQUpezKWX4
         Cq1oly0VPZ5YkYimpaSfgutPMi3V53d+ZHOrQbXUOM85Fl9HyjDcEqjIyzC4N4DNwu29
         dYrbo7RAHgO8QcwWC1J5I5nCngjrB9QXjtcx76eoePbLh71ZvdZjE9of/hosV5JABId2
         k6OA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 65.197.215.72 as permitted sender) smtp.mailfrom=poza@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 65.197.215.72 as permitted sender) smtp.mailfrom=poza@qualcomm.com
X-IronPort-AV: E=Sophos;i="5.49,356,1520924400";
   d="scan'208";a="126361299"
X-IronPort-AV: E=McAfee;i="5900,7806,8881"; a="182707667"
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
Subject: [PATCH v15 7/9] PCI/PORTDRV: Implement generic find device
Date: Thu,  3 May 2018 01:03:56 -0400
Message-Id: <1525323838-1735-8-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525323838-1735-1-git-send-email-poza@codeaurora.org>
References: <1525323838-1735-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599417978309229425?=
X-GMAIL-MSGID: =?utf-8?q?1599417978309229425?=
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
index d843055..c6147c4 100644
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
