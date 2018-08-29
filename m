Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A701C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D42204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D42204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbeH2Ryw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:54:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727562AbeH2Ryw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:54:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DADF57A7E6;
        Wed, 29 Aug 2018 13:57:46 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-15.ams2.redhat.com [10.36.117.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C34610075DC;
        Wed, 29 Aug 2018 13:57:45 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: Add Intel ISP dummy driver
Date:   Wed, 29 Aug 2018 15:57:44 +0200
Message-Id: <20180829135744.16205-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 29 Aug 2018 13:57:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 29 Aug 2018 13:57:46 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'hdegoede@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Image Signal Processor found on Cherry Trail devices is brought up in
D0 state on devices which have camera sensors attached to it. The ISP will
not enter D3 state again without some massaging of its registers beforehand
and the ISP not being in D3 state blocks the SoC from entering S0ix modes.

There was a driver for the ISP in drivers/staging but that got removed
again because it never worked. It does not seem likely that a real
driver for the ISP will be added to the mainline kernel anytime soon.

This commit adds a dummy driver which contains the necessary magic from
the staging driver to powerdown the ISP, so that Cherry Trail devices where
the ISP is used will properly use S0ix modes when suspended.

Together with other recent S0ix related fixes this allows S0ix modes to
be entered on e.g. a Chuwi Hi8 Pro and a HP x2 210.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=196915
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 MAINTAINERS                            |   6 ++
 drivers/platform/x86/Kconfig           |  12 +++
 drivers/platform/x86/Makefile          |   1 +
 drivers/platform/x86/intel_isp_dummy.c | 119 +++++++++++++++++++++++++
 4 files changed, 138 insertions(+)
 create mode 100644 drivers/platform/x86/intel_isp_dummy.c

diff --git a/MAINTAINERS b/MAINTAINERS
index dbe7836e4f6b..ae654c69300a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7258,6 +7258,12 @@ S:	Maintained
 F:	drivers/media/pci/intel/ipu3/
 F:	Documentation/media/uapi/v4l/pixfmt-srggb10-ipu3.rst
 
+INTEL ISP DUMMY DRIVER
+M:	Hans de Goede <hdegoede@redhat.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/x86/intel_isp_dummy.c
+
 INTEL IXP4XX QMGR, NPE, ETHERNET and HSS SUPPORT
 M:	Krzysztof Halasa <khalasa@piap.pl>
 S:	Maintained
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 64c82592d4b6..0ba6fac1d0c9 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1230,6 +1230,18 @@ config I2C_MULTI_INSTANTIATE
 	  To compile this driver as a module, choose M here: the module
 	  will be called i2c-multi-instantiate.
 
+config INTEL_ISP_DUMMY
+	tristate "Intel ISP dummy driver"
+	depends on PCI && IOSF_MBI && PM
+	help
+	  Dummy driver for Intel's Image Signal Processor found on Bay and
+	  Cherry Trail devices. The sole purpose of this driver is to turn
+	  the ISP off (put it in D3) to save power and to allow entering of
+	  S0ix modes.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called intel_isp_dummy.
+
 endif # X86_PLATFORM_DEVICES
 
 config PMC_ATOM
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index e6d1becf81ce..df854a630a83 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -92,3 +92,4 @@ obj-$(CONFIG_MLX_PLATFORM)	+= mlx-platform.o
 obj-$(CONFIG_INTEL_TURBO_MAX_3) += intel_turbo_max_3.o
 obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)	+= intel_chtdc_ti_pwrbtn.o
 obj-$(CONFIG_I2C_MULTI_INSTANTIATE)	+= i2c-multi-instantiate.o
+obj-$(CONFIG_INTEL_ISP_DUMMY)	+= intel_isp_dummy.o
diff --git a/drivers/platform/x86/intel_isp_dummy.c b/drivers/platform/x86/intel_isp_dummy.c
new file mode 100644
index 000000000000..f65100e5a0bd
--- /dev/null
+++ b/drivers/platform/x86/intel_isp_dummy.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Dummy driver for Intel's Image Signal Processor found on Bay and Cherry
+ * Trail devices. The sole purpose of this driver is to allow the ISP to
+ * be put in D3.
+ *
+ * Copyright (C) 2018 Hans de Goede <hdegoede@redhat.com>
+ *
+ * Based on various non upstream patches for ISP support:
+ * Copyright (C) 2010-2017 Intel Corporation. All rights reserved.
+ * Copyright (c) 2010 Silicon Hive www.siliconhive.com.
+ */
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
+#include <asm/iosf_mbi.h>
+
+/* PCI configuration regs */
+#define PCI_INTERRUPT_CTRL		0x9c
+
+#define PCI_CSI_CONTROL			0xe8
+#define PCI_CSI_CONTROL_PORTS_OFF_MASK	0x7
+
+/* IOSF BT_MBI_UNIT_PMC regs */
+#define ISPSSPM0			0x39
+#define ISPSSPM0_ISPSSC_OFFSET		0
+#define ISPSSPM0_ISPSSC_MASK		0x00000003
+#define ISPSSPM0_ISPSSS_OFFSET		24
+#define ISPSSPM0_ISPSSS_MASK		0x03000000
+#define ISPSSPM0_IUNIT_POWER_ON		0x0
+#define ISPSSPM0_IUNIT_POWER_OFF	0x3
+
+static int isp_probe(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	unsigned long timeout;
+	u32 val;
+
+	pci_write_config_dword(dev, PCI_INTERRUPT_CTRL, 0);
+
+	/*
+	 * MRFLD IUNIT DPHY is located in an always-power-on island
+	 * MRFLD HW design need all CSI ports are disabled before
+	 * powering down the IUNIT.
+	 */
+	pci_read_config_dword(dev, PCI_CSI_CONTROL, &val);
+	val |= PCI_CSI_CONTROL_PORTS_OFF_MASK;
+	pci_write_config_dword(dev, PCI_CSI_CONTROL, val);
+
+	/* Write 0x3 to ISPSSPM0 bit[1:0] to power off the IUNIT */
+	iosf_mbi_modify(BT_MBI_UNIT_PMC, MBI_REG_READ, ISPSSPM0,
+			ISPSSPM0_IUNIT_POWER_OFF, ISPSSPM0_ISPSSC_MASK);
+
+	/*
+	 * There should be no IUNIT access while power-down is
+	 * in progress HW sighting: 4567865
+	 * Wait up to 50 ms for the IUNIT to shut down.
+	 */
+	timeout = jiffies + msecs_to_jiffies(50);
+	while (1) {
+		/* Wait until ISPSSPM0 bit[25:24] shows 0x3 */
+		iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ, ISPSSPM0, &val);
+		val = (val & ISPSSPM0_ISPSSS_MASK) >> ISPSSPM0_ISPSSS_OFFSET;
+		if (val == ISPSSPM0_IUNIT_POWER_OFF)
+			break;
+
+		if (time_after(jiffies, timeout)) {
+			dev_err(&dev->dev, "IUNIT power-off timeout.\n");
+			return -EBUSY;
+		}
+		usleep_range(1000, 2000);
+	}
+
+	pm_runtime_allow(&dev->dev);
+	pm_runtime_put_sync_suspend(&dev->dev);
+
+	return 0;
+}
+
+static void isp_remove(struct pci_dev *dev)
+{
+	pm_runtime_get_sync(&dev->dev);
+	pm_runtime_forbid(&dev->dev);
+}
+
+static int isp_pci_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int isp_pci_resume(struct device *dev)
+{
+	return 0;
+}
+
+static UNIVERSAL_DEV_PM_OPS(isp_pm_ops, isp_pci_suspend,
+			    isp_pci_resume, NULL);
+
+static const struct pci_device_id isp_id_table[] = {
+	{ PCI_VDEVICE(INTEL, 0x22b8), },
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, isp_id_table);
+
+static struct pci_driver isp_pci_driver = {
+	.name = "intel_isp_dummy",
+	.id_table = isp_id_table,
+	.probe = isp_probe,
+	.remove = isp_remove,
+	.driver.pm = &isp_pm_ops,
+};
+
+module_pci_driver(isp_pci_driver);
+
+MODULE_DESCRIPTION("Intel ISP dummy driver (to allow suspend)");
+MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.19.0.rc0

