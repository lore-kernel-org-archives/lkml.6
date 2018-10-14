Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E84C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 17:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67B520835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 17:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67B520835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbeJOBgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 21:36:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbeJOBgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 21:36:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A3ED883F4C;
        Sun, 14 Oct 2018 17:54:30 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-22.ams2.redhat.com [10.36.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D5387FC04;
        Sun, 14 Oct 2018 17:54:29 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] platform/x86: Add Intel AtomISP2 dummy / power-management driver
Date:   Sun, 14 Oct 2018 19:54:27 +0200
Message-Id: <20181014175427.22139-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Sun, 14 Oct 2018 17:54:30 +0000 (UTC)
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
Changes in v2:
-Rename the driver and Kconfig option from intel-isp-dummy to intel-atomisp2-pm
---
 MAINTAINERS                              |   6 ++
 drivers/platform/x86/Kconfig             |  12 +++
 drivers/platform/x86/Makefile            |   1 +
 drivers/platform/x86/intel_atomisp2_pm.c | 119 +++++++++++++++++++++++
 4 files changed, 138 insertions(+)
 create mode 100644 drivers/platform/x86/intel_atomisp2_pm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2c5d5c6859b8..ba9e5da792ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7306,6 +7306,12 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	sound/soc/intel/
 
+INTEL ATOMISP2 DUMMY / POWER-MANAGEMENT DRIVER
+M:	Hans de Goede <hdegoede@redhat.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/x86/intel_atomisp2_pm.c
+
 INTEL C600 SERIES SAS CONTROLLER DRIVER
 M:	Intel SCU Linux support <intel-linux-scu@intel.com>
 M:	Artur Paszkiewicz <artur.paszkiewicz@intel.com>
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 48bec711e5e3..5eedcec0fefe 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1232,6 +1232,18 @@ config I2C_MULTI_INSTANTIATE
 	  To compile this driver as a module, choose M here: the module
 	  will be called i2c-multi-instantiate.
 
+config INTEL_ATOMISP2_PM
+	tristate "Intel AtomISP2 dummy / power-management driver"
+	depends on PCI && IOSF_MBI && PM
+	help
+	  Power-management driver for Intel's Image Signal Processor found on
+	  Bay and Cherry Trail devices. This dummy driver's sole purpose is to
+	  turn the ISP off (put it in D3) to save power and to allow entering
+	  of S0ix modes.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called intel_atomisp2_pm.
+
 endif # X86_PLATFORM_DEVICES
 
 config PMC_ATOM
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index e6d1becf81ce..dc29af4d8e2f 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -92,3 +92,4 @@ obj-$(CONFIG_MLX_PLATFORM)	+= mlx-platform.o
 obj-$(CONFIG_INTEL_TURBO_MAX_3) += intel_turbo_max_3.o
 obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)	+= intel_chtdc_ti_pwrbtn.o
 obj-$(CONFIG_I2C_MULTI_INSTANTIATE)	+= i2c-multi-instantiate.o
+obj-$(CONFIG_INTEL_ATOMISP2_PM)	+= intel_atomisp2_pm.o
diff --git a/drivers/platform/x86/intel_atomisp2_pm.c b/drivers/platform/x86/intel_atomisp2_pm.c
new file mode 100644
index 000000000000..9371603a0ac9
--- /dev/null
+++ b/drivers/platform/x86/intel_atomisp2_pm.c
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
+	.name = "intel_atomisp2_pm",
+	.id_table = isp_id_table,
+	.probe = isp_probe,
+	.remove = isp_remove,
+	.driver.pm = &isp_pm_ops,
+};
+
+module_pci_driver(isp_pci_driver);
+
+MODULE_DESCRIPTION("Intel AtomISP2 dummy / power-management drv (for suspend)");
+MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.19.0

