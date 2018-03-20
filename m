Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AG47ELugEwl9JxMxp3mVJGAwA8O2E/xKk3F69TUrkvSD5oI6zF3MJKv7RQkh0B9uGKInhto3AeHW
ARC-Seal: i=1; a=rsa-sha256; t=1521550665; cv=none;
        d=google.com; s=arc-20160816;
        b=jnkD1lP6OxkkCvr5tmeU534W1GPeSXtadwuLXoAW5ROfTm2/tz1HTE6frKDx4+n/1p
         sgWCXnpNQMe+Ejzu8tM9CkjzzY4x04uo71P4GTlLK/IrTODV3iI+FgqF/aM1lRV/El8e
         362YyZrguLlefCqJ62j+AgsA4T0vhIV++ZB0m/h2SKG870oS9NMyIJWC+wUmv6/T7E3z
         DcucjypS2FiG/51OYWB04DRYHVqVdbxPHwHf5n0f9zt/vj1bmSqibF0Y4kP1l7B3PY4s
         iewiFnUU7TFtvMOLj0AvZavAo6WMpBVBjuLXmnJr27d1Xfvt6VewpyH+8LdITkIqSPqD
         a7BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=b1jr4YGmKQnkll0wRqmeRFlp5sf4G4YRhp+rNCCbVBo=;
        b=yzCELfRoCa99/K6kHuWNp+AfTO2a+5nW+u+LXKINzz9n27V4MuvcTSRHpd40M1/nCA
         m9tBu2ObeJFrmz1NZD8cUj8ck/EarKka/rq1NLZ1Q8QMcj2ejytb0GFsUBwk6KD1gwDK
         471JH2MU3kyOHb9AxpGVClaa+dwGPrRyBMUIvLEFeOY9tjndlCL2uE1I976fzRJP5nqm
         QUq07kmzxE+V1QLUSo/Kzfae5ENLHn83xnp9FcSuCHR8WZqHtqfLeFIhTf/p1EhgEEUD
         OT5QME7hQqJjO1tHd3McISaBYglByHHeW9NLh7yMoY6BoaWPwAZd2N1wADiG1WSapUto
         /LxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,335,1517904000";
   d="scan'208";a="39592572"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jun Li <jun.li@nxp.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v9 08/12] xhci: Add Intel extended cap / otg phy mux handling
Date: Tue, 20 Mar 2018 15:57:09 +0300
Message-Id: <20180320125713.85465-9-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320125713.85465-1-heikki.krogerus@linux.intel.com>
References: <20180320125713.85465-1-heikki.krogerus@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595461511144331478?=
X-GMAIL-MSGID: =?utf-8?q?1595461511144331478?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

The xHCI controller on various Intel SoCs has an extended cap mmio-range
which contains registers to control the muxing to the xHCI (host mode)
or the dwc3 (device mode) and vbus-detection for the otg usb-phy.

Having a role-sw driver included in the xHCI code (under drivers/usb/host)
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Changes in v4:
-Add Andy's Reviewed-by

Changes in v2:
-Use SPDX license header
-Various small style cleanups / changes
-Add Heikki's Reviewed-by

Changes from some time ago when this patch was part of another patch-set:
-Check xHCI controller PCI device-id instead of only checking for the
 Intel Extended capability ID, as the Extended capability ID is used on
 other model Intel xHCI controllers too
-Add a new generic xhci_ext_cap_init() function and handle the new
 XHCI_INTEL_CHT_USB_MUX quirk there.
-Stop using Cherry Trail / CHT in various places as other Intel SoCs
 (e.g. Broxton / Apollo Lake) also have this
---
 drivers/usb/host/Makefile        |  2 +-
 drivers/usb/host/xhci-ext-caps.c | 90 ++++++++++++++++++++++++++++++++++++++++
 drivers/usb/host/xhci-ext-caps.h |  2 +
 drivers/usb/host/xhci-pci.c      |  5 +++
 drivers/usb/host/xhci.h          |  2 +
 5 files changed, 100 insertions(+), 1 deletion(-)
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
index 000000000000..399113f9fc5c
--- /dev/null
+++ b/drivers/usb/host/xhci-ext-caps.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * XHCI extended capability handling
+ *
+ * Copyright (c) 2017 Hans de Goede <hdegoede@redhat.com>
+ */
+
+#include <linux/platform_device.h>
+#include "xhci.h"
+
+#define USB_SW_DRV_NAME		"intel_xhci_usb_sw"
+#define USB_SW_RESOURCE_SIZE	0x400
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
+	pdev = platform_device_alloc(USB_SW_DRV_NAME, PLATFORM_DEVID_NONE);
+	if (!pdev) {
+		xhci_err(xhci, "couldn't allocate %s platform device\n",
+			 USB_SW_DRV_NAME);
+		return -ENOMEM;
+	}
+
+	res.start = hcd->rsrc_start + cap_offset;
+	res.end	  = res.start + USB_SW_RESOURCE_SIZE - 1;
+	res.name  = USB_SW_DRV_NAME;
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
+	u32 offset, val;
+	int ret;
+
+	offset = xhci_find_next_ext_cap(base, 0, 0);
+
+	while (offset) {
+		val = readl(base + offset);
+
+		switch (XHCI_EXT_CAPS_ID(val)) {
+		case XHCI_EXT_CAPS_VENDOR_INTEL:
+			if (xhci->quirks & XHCI_INTEL_USB_ROLE_SW) {
+				ret = xhci_create_intel_xhci_sw_pdev(xhci,
+								     offset);
+				if (ret)
+					return ret;
+			}
+			break;
+		}
+		offset = xhci_find_next_ext_cap(base, offset, 0);
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
index d9f831b67e57..f17b7eab66cf 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -178,6 +178,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
 		 pdev->device == PCI_DEVICE_ID_INTEL_CHERRYVIEW_XHCI) {
 		xhci->quirks |= XHCI_SSIC_PORT_UNUSED;
+		xhci->quirks |= XHCI_INTEL_USB_ROLE_SW;
 	}
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
 	    (pdev->device == PCI_DEVICE_ID_INTEL_CHERRYVIEW_XHCI ||
@@ -311,6 +312,10 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
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
index 8acc8f8d790f..05c909b04f14 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1829,6 +1829,7 @@ struct xhci_hcd {
 #define XHCI_ASMEDIA_MODIFY_FLOWCONTROL	(1 << 28)
 #define XHCI_HW_LPM_DISABLE	(1 << 29)
 #define XHCI_SUSPEND_DELAY	(1 << 30)
+#define XHCI_INTEL_USB_ROLE_SW	(1 << 31)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
@@ -2024,6 +2025,7 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks);
 void xhci_init_driver(struct hc_driver *drv,
 		      const struct xhci_driver_overrides *over);
 int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id);
+int xhci_ext_cap_init(struct xhci_hcd *xhci);
 
 int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup);
 int xhci_resume(struct xhci_hcd *xhci, bool hibernated);
-- 
2.16.2
