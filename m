Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AH8x227+ftr51LkzRoFH71YTfr+lFyHP9gqVUM6J7bp+j5FQDz+58dc/dZsqSdH5oSJqCWd67nG8
ARC-Seal: i=1; a=rsa-sha256; t=1518778088; cv=none;
        d=google.com; s=arc-20160816;
        b=CUKP3kkC51TLDrQyfhGQ5IxewUE+PUTv7t7jaNKE5GhJSHUE8HFvqBt8j85Bci6ggU
         T9RnUV6IGabQwMbcvSYkNqNzu1t0xGEPpiLjq7fk0hCQDpBKrPq/004OAXMmUHOl/F/r
         U27kzEwDRJrKcrVEDcsYuGPrmufJrmkcNu5e5+LI6wz15ldD0hHSAYz+sf10RAhJ96fN
         aSJ8sGmT//6YPkur0azYNoXr7CDdhI52Rjhs7ngHjdvQPlntqZtiEDKXOaCCJnh2RFE3
         U+Sn0eGCsam/kBatRvf1SLdwbe/Buz/KDCzJzJ/163938KbsyQeJpVlfRYxAz8oV7+SL
         eXow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Hlawz2eO/XO0QqlMp59eXhvUNNc5zpaMpj4RT5/wwWo=;
        b=N6Cb6bcgcjSobaynJcF1Z/DpGSwnwuWaPld91Z+5/DC97dKhfdM/S7c6IBf6lP5ElT
         lBfYX1iZvnYpd/+TGOglL0d3rJiIjKrTp261R+BkgAtzrf0Hf3naLVrflt6nmPMo0ElA
         OnEcAcJwspix7MmKOPsxeSl4W9RRTMIOKMcym6ecGVqj0af0jxcxeeo1KX+0NQXsaeHV
         rbDliBcDFkSQrMemkAfmpnkvQNpvAxXat8OAj3b/PXkrIpWOiTztDtgeMDYi5Qsrtz7z
         AM0uwRQnRBHNeZDKoyDc5tuRT7CsLShbKjoUi0qL8G9Kj5vj+e/ikdjQjQchr9VouXRg
         cLoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: Hans de Goede <hdegoede@redhat.com>
To: Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH 08/12] xhci: Add Intel extended cap / otg phy mux handling
Date: Fri, 16 Feb 2018 11:47:47 +0100
Message-Id: <20180216104751.8371-9-hdegoede@redhat.com>
In-Reply-To: <20180216104751.8371-1-hdegoede@redhat.com>
References: <20180216104751.8371-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592554252355342442?=
X-GMAIL-MSGID: =?utf-8?q?1592554252355342442?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The xHCI controller on various Intel SoCs has an extended cap mmio-range
which contains registers to control the muxing to the xHCI (host mode)
or the dwc3 (device mode) and vbus-detection for the otg usb-phy.

Having a role-sw driver included in the xhci code (under drivers/usb/host)
is not desirable. So this commit adds a simple handler for this extended
capability, which creates a platform device with the caps mmio region as
resource, this allows us to write a separate platform role-sw driver for
the role-switch.

Note this commit adds a call to the new xhci_ext_cap_init() function
to xhci_pci_probe(), it is added here because xhci_ext_cap_init() must
be called only once. If in the future we also want to handle ext-caps
on non pci xHCI HCDs from xhci_ext_cap_init() a call to it should also
be added to other bus probe paths.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
Changes in v2:
-Check xHCI controller PCI device-id instead of only checking for the
 Intel Extended capability ID, as the Extended capability ID is used on
 other model Intel xHCI controllers too

Changes in v3:
-Add a new generic xhci_ext_cap_init() function and handle the new
 XHCI_INTEL_CHT_USB_MUX quirk there.

Changes in v4:
-Stop using Cherry Trail / CHT in various places as other Intel SoCs
 (e.g. Broxton / Apollo Lake) also have this
---
 drivers/usb/host/Makefile        |  2 +-
 drivers/usb/host/xhci-ext-caps.c | 89 ++++++++++++++++++++++++++++++++++++++++
 drivers/usb/host/xhci-ext-caps.h |  2 +
 drivers/usb/host/xhci-pci.c      |  5 +++
 drivers/usb/host/xhci.h          |  2 +
 5 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/host/xhci-ext-caps.c

diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 4ede4ce12366..8a8cffe0b445 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -11,7 +11,7 @@ fhci-y += fhci-mem.o fhci-tds.o fhci-sched.o
 
 fhci-$(CONFIG_FHCI_DEBUG) += fhci-dbg.o
 
-xhci-hcd-y := xhci.o xhci-mem.o
+xhci-hcd-y := xhci.o xhci-mem.o xhci-ext-caps.o
 xhci-hcd-y += xhci-ring.o xhci-hub.o xhci-dbg.o
 xhci-hcd-y += xhci-trace.o
 
diff --git a/drivers/usb/host/xhci-ext-caps.c b/drivers/usb/host/xhci-ext-caps.c
new file mode 100644
index 000000000000..8622d1e95ae7
--- /dev/null
+++ b/drivers/usb/host/xhci-ext-caps.c
@@ -0,0 +1,89 @@
+/*
+ * XHCI extended capability handling
+ *
+ * Copyright (c) 2017 Hans de Goede <hdegoede@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/platform_device.h>
+#include "xhci.h"
+
+static void xhci_intel_unregister_pdev(void *arg)
+{
+	platform_device_unregister(arg);
+}
+
+static int xhci_create_intel_xhci_sw_pdev(struct xhci_hcd *xhci, u32 cap_offset)
+{
+	struct usb_hcd *hcd = xhci_to_hcd(xhci);
+	struct device *dev = hcd->self.controller;
+	struct platform_device *pdev;
+	struct resource	res = { 0, };
+	int ret;
+
+	pdev = platform_device_alloc("intel_xhci_usb_sw", PLATFORM_DEVID_NONE);
+	if (!pdev) {
+		xhci_err(xhci, "couldn't allocate intel_xhci_usb_sw pdev\n");
+		return -ENOMEM;
+	}
+
+	res.start = hcd->rsrc_start + cap_offset;
+	res.end	  = res.start + 0x3ff;
+	res.name  = "intel_xhci_usb_sw";
+	res.flags = IORESOURCE_MEM;
+
+	ret = platform_device_add_resources(pdev, &res, 1);
+	if (ret) {
+		dev_err(dev, "couldn't add resources to intel_xhci_usb_sw pdev\n");
+		platform_device_put(pdev);
+		return ret;
+	}
+
+	pdev->dev.parent = dev;
+
+	ret = platform_device_add(pdev);
+	if (ret) {
+		dev_err(dev, "couldn't register intel_xhci_usb_sw pdev\n");
+		platform_device_put(pdev);
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, xhci_intel_unregister_pdev, pdev);
+	if (ret) {
+		dev_err(dev, "couldn't add unregister action for intel_xhci_usb_sw pdev\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+int xhci_ext_cap_init(struct xhci_hcd *xhci)
+{
+	void __iomem *base = &xhci->cap_regs->hc_capbase;
+	u32 cap_offset, val;
+	int ret;
+
+	cap_offset = xhci_find_next_ext_cap(base, 0, 0);
+
+	while (cap_offset) {
+		val = readl(base + cap_offset);
+
+		switch (XHCI_EXT_CAPS_ID(val)) {
+		case XHCI_EXT_CAPS_VENDOR_INTEL:
+			if (xhci->quirks & XHCI_INTEL_USB_ROLE_SW) {
+				ret = xhci_create_intel_xhci_sw_pdev(
+							    xhci, cap_offset);
+				if (ret)
+					return ret;
+			}
+			break;
+		}
+		cap_offset = xhci_find_next_ext_cap(base, cap_offset, 0);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xhci_ext_cap_init);
diff --git a/drivers/usb/host/xhci-ext-caps.h b/drivers/usb/host/xhci-ext-caps.h
index 631e7cc62604..268328c20681 100644
--- a/drivers/usb/host/xhci-ext-caps.h
+++ b/drivers/usb/host/xhci-ext-caps.h
@@ -39,6 +39,8 @@
 #define XHCI_EXT_CAPS_ROUTE	5
 /* IDs 6-9 reserved */
 #define XHCI_EXT_CAPS_DEBUG	10
+/* Vendor caps */
+#define XHCI_EXT_CAPS_VENDOR_INTEL	192
 /* USB Legacy Support Capability - section 7.1.1 */
 #define XHCI_HC_BIOS_OWNED	(1 << 16)
 #define XHCI_HC_OS_OWNED	(1 << 24)
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 6c79037876db..4486640d925c 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -164,6 +164,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
 		 pdev->device == PCI_DEVICE_ID_INTEL_CHERRYVIEW_XHCI) {
 		xhci->quirks |= XHCI_SSIC_PORT_UNUSED;
+		xhci->quirks |= XHCI_INTEL_USB_ROLE_SW;
 	}
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
 	    (pdev->device == PCI_DEVICE_ID_INTEL_CHERRYVIEW_XHCI ||
@@ -297,6 +298,10 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		goto dealloc_usb2_hcd;
 	}
 
+	retval = xhci_ext_cap_init(xhci);
+	if (retval)
+		goto put_usb3_hcd;
+
 	retval = usb_add_hcd(xhci->shared_hcd, dev->irq,
 			IRQF_SHARED);
 	if (retval)
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 96099a245c69..5917e3095e2a 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1825,6 +1825,7 @@ struct xhci_hcd {
 /* Reserved. It was XHCI_U2_DISABLE_WAKE */
 #define XHCI_ASMEDIA_MODIFY_FLOWCONTROL	(1 << 28)
 #define XHCI_HW_LPM_DISABLE	(1 << 29)
+#define XHCI_INTEL_USB_ROLE_SW	(1 << 30)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
@@ -2020,6 +2021,7 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks);
 void xhci_init_driver(struct hc_driver *drv,
 		      const struct xhci_driver_overrides *over);
 int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id);
+int xhci_ext_cap_init(struct xhci_hcd *xhci);
 
 int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup);
 int xhci_resume(struct xhci_hcd *xhci, bool hibernated);
-- 
2.14.3
