Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B77C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E01F21848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L2tx3pX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfBSGf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 01:35:59 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36954 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfBSGfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 01:35:55 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1J6ZZQG073477;
        Tue, 19 Feb 2019 00:35:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550558135;
        bh=vxzw8soKU3JvNEV69lMF9xk8e7jCBElOTa2YADr4u68=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=L2tx3pX1yNC2fLLp/g3B+db7FDB5/zN3ysjBvddTnSGyO4/eSKiwqaADTm9yoQPPp
         tAgHszcmEgui9VM4Mn4+kHOUfdBvIxKLit5LtoianSBAAkwVLWWn11yuaKvIZke2+U
         F7kDsfuR0FBVVQ/BH6dmsE87AQT316JD+qAzsuzU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1J6ZZ34021920
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Feb 2019 00:35:35 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 19
 Feb 2019 00:35:35 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 19 Feb 2019 00:35:35 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1J6ZCt1025516;
        Tue, 19 Feb 2019 00:35:30 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Vignesh R <vigneshr@ti.com>, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-mtd@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <tudor.ambarus@microchip.com>, <nsekhar@ti.com>
Subject: [RFC PATCH 3/5] mtd: Add support for Hyperbus memory devices
Date:   Tue, 19 Feb 2019 12:06:05 +0530
Message-ID: <20190219063607.29949-4-vigneshr@ti.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219063607.29949-1-vigneshr@ti.com>
References: <20190219063607.29949-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cypress HyperBus is Low Signal Count, High Performance Double Data Rate Bus
interface between a host system master and one or more slave interfaces.
HyperBus is used to connect microprocessor, microcontroller, or ASIC
devices with random access NOR flash memory(called HyperFlash) or
self refresh DRAM(called HyperRAM).

Its a 8-bit data bus (DQ[7:0]) with  Read-Write Data Strobe (RWDS)
signal and either Single-ended clock(3.0V parts) or Differential clock
(1.8V parts). It uses ChipSelect lines to select b/w multiple slaves.
At bus level, it follows a separate protocol described in HyperBus
specification[1].

HyperFlash follows CFI AMD/Fujitsu Extended Command Set (0x0002) similar
to that of existing parallel NORs. Since Hyperbus is x8 DDR bus,
its equivalent to x16 parallel NOR flash wrt bits per clk. But Hyperbus
operates at >166MHz frequencies.
HyperRAM provides direct random read/write access to flash memory
array.

But, Hyperbus memory controllers seem to abstract implementation details
and expose a simple MMIO interface to access connected flash.

Add support for registering HyperFlash devices with MTD framework. MTD
maps framework along with CFI chip support framework are used to support
communicate with flash.

Framework is modelled along the lines of spi-nor framework. HyperBus
memory controller(HBMC) drivers call hb_register_device() to register a
single HyperFlash device. HyperFlash core parses MMIO access
information from DT, sets up the map_info struct, probes CFI flash and
registers it with MTD framework.

Some HBMC masters need calibration/training sequence[3] to be carried
out, in order for DLL inside the controller to lock, by reading a known
string/pattern. This is done by repeatedly reading CFI Query
Identification String. Calibration needs to be done before try to detect
flash as part of CFI flash probe.

HyperRAM is not supported atm.

HyperBus specification can be found at[1]
HyperFlash datasheet can be found at[2]

[1] https://www.cypress.com/file/213356/download
[2] https://www.cypress.com/file/213346/download
[3] http://www.ti.com/lit/ug/spruid7b/spruid7b.pdf
    Table 12-5741. HyperFlash Access Sequence

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 MAINTAINERS                   |   7 ++
 drivers/mtd/Kconfig           |   2 +
 drivers/mtd/Makefile          |   1 +
 drivers/mtd/hyperbus/Kconfig  |  23 +++++
 drivers/mtd/hyperbus/Makefile |   4 +
 drivers/mtd/hyperbus/core.c   | 167 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/hyperbus.h  |  73 +++++++++++++++
 7 files changed, 277 insertions(+)
 create mode 100644 drivers/mtd/hyperbus/Kconfig
 create mode 100644 drivers/mtd/hyperbus/Makefile
 create mode 100644 drivers/mtd/hyperbus/core.c
 create mode 100644 include/linux/mtd/hyperbus.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 08bf7418a97f..0808c22807bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7143,6 +7143,13 @@ F:	include/uapi/linux/hyperv.h
 F:	tools/hv/
 F:	Documentation/ABI/stable/sysfs-bus-vmbus
 
+HYPERBUS SUPPORT
+M:	Vignesh R <vigneshr@ti.com>
+S:	Supported
+F:	drivers/mtd/hyperbus/
+F:	include/linux/mtd/hyperbus.h
+F:	Documentation/devicetree/bindings/mtd/cypress,hyperbus.txt
+
 HYPERVISOR VIRTUAL CONSOLE DRIVER
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Odd Fixes
diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 79a8ff542883..a915ff300390 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -290,4 +290,6 @@ source "drivers/mtd/spi-nor/Kconfig"
 
 source "drivers/mtd/ubi/Kconfig"
 
+source "drivers/mtd/hyperbus/Kconfig"
+
 endif # MTD
diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
index 58fc327a5276..04c154906631 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -35,3 +35,4 @@ obj-y		+= chips/ lpddr/ maps/ devices/ nand/ tests/
 
 obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor/
 obj-$(CONFIG_MTD_UBI)		+= ubi/
+obj-$(CONFIG_MTD_HYPERBUS)	+= hyperbus/
diff --git a/drivers/mtd/hyperbus/Kconfig b/drivers/mtd/hyperbus/Kconfig
new file mode 100644
index 000000000000..02c38afc5c50
--- /dev/null
+++ b/drivers/mtd/hyperbus/Kconfig
@@ -0,0 +1,23 @@
+menuconfig MTD_HYPERBUS
+	tristate "Hyperbus support"
+	select MTD_CFI
+	select MTD_MAP_BANK_WIDTH_2
+	select MTD_CFI_AMDSTD
+	select MTD_COMPLEX_MAPPINGS
+	help
+	  This is the framework for the Hyperbus which can be used by
+	  the Hyperbus Controller driver to commmunicate with
+	  Hyperflash. See Cypress Hyperbus specification for more
+	  details
+
+
+if MTD_HYPERBUS
+
+config HBMC_AM654
+	tristate "Hyperbus controller driver for AM65x SoC"
+	help
+	 This is the driver for Hyperbus controller on TI's AM65x and
+	 other SoCs
+
+endif # MTD_HYPERBUS
+
diff --git a/drivers/mtd/hyperbus/Makefile b/drivers/mtd/hyperbus/Makefile
new file mode 100644
index 000000000000..64e377d7f636
--- /dev/null
+++ b/drivers/mtd/hyperbus/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_MTD_HYPERBUS)	+= core.o
+obj-$(CONFIG_HBMC_AM654)	+= hbmc_am654.o
diff --git a/drivers/mtd/hyperbus/core.c b/drivers/mtd/hyperbus/core.c
new file mode 100644
index 000000000000..d3d44aab7503
--- /dev/null
+++ b/drivers/mtd/hyperbus/core.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+// Author: Vignesh R <vigneshr@ti.com>
+
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/mtd/hyperbus.h>
+#include <linux/mtd/map.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/cfi.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/types.h>
+
+#define HB_CALIB_COUNT 25
+
+static struct hb_device *map_to_hbdev(struct map_info *map)
+{
+	return container_of(map, struct hb_device, map);
+}
+
+static map_word hb_read16(struct map_info *map, unsigned long addr)
+{
+	struct hb_device *hbdev = map_to_hbdev(map);
+	map_word read_data;
+
+	read_data.x[0] = hbdev->ops->read16(hbdev, addr);
+
+	return read_data;
+}
+
+static void hb_write16(struct map_info *map, map_word d, unsigned long addr)
+{
+	struct hb_device *hbdev = map_to_hbdev(map);
+
+	hbdev->ops->write16(hbdev, addr, d.x[0]);
+}
+
+static void hb_copy_from(struct map_info *map, void *to,
+			 unsigned long from, ssize_t len)
+{
+	struct hb_device *hbdev = map_to_hbdev(map);
+
+	hbdev->ops->copy_from(hbdev, to, from, len);
+}
+
+static void hb_copy_to(struct map_info *map, unsigned long to,
+		       const void *from, ssize_t len)
+{
+	struct hb_device *hbdev = map_to_hbdev(map);
+
+	hbdev->ops->copy_to(hbdev, to, from, len);
+}
+
+/* Calibrate HBMC by repeatedly reading "QRY" string from CFI space */
+static int hb_calibrate(struct hb_device *hbdev)
+{
+	struct map_info *map = &hbdev->map;
+	struct cfi_private cfi;
+	int count = HB_CALIB_COUNT;
+	int ret;
+
+	cfi.interleave = 1;
+	cfi.device_type = CFI_DEVICETYPE_X16;
+	cfi_send_gen_cmd(0xF0, 0, 0, map, &cfi, cfi.device_type, NULL);
+	cfi_send_gen_cmd(0x98, 0x55, 0, map, &cfi, cfi.device_type, NULL);
+
+	while (count--)
+		cfi_qry_present(map, 0, &cfi);
+
+	ret = cfi_qry_present(map, 0, &cfi);
+	cfi_qry_mode_off(0, map, &cfi);
+
+	return ret;
+}
+
+int hb_register_device(struct hb_device *hbdev)
+{
+	struct resource res;
+	struct device *dev;
+	struct device_node *np;
+	struct map_info *map;
+	struct hb_ops *ops;
+	int err;
+
+	if (!hbdev || !hbdev->dev || !hbdev->np) {
+		pr_err("hyperbus: please fill all the necessary fields!\n");
+		return -EINVAL;
+	}
+
+	np = hbdev->np;
+	if (!of_device_is_compatible(np, "cypress,hyperflash"))
+		return -ENODEV;
+
+	hbdev->memtype = HYPERFLASH;
+
+	if (of_address_to_resource(np, 0, &res))
+		return -EINVAL;
+
+	dev = hbdev->dev;
+	map = &hbdev->map;
+	map->size = resource_size(&res);
+	map->virt = devm_ioremap_resource(dev, &res);
+	if (IS_ERR(map->virt))
+		return PTR_ERR(map->virt);
+
+	map->name = dev_name(dev);
+	map->bankwidth = 2;
+
+	simple_map_init(map);
+	ops = hbdev->ops;
+	if (ops) {
+		if (ops->read16)
+			map->read = hb_read16;
+		if (ops->write16)
+			map->write = hb_write16;
+		if (ops->copy_to)
+			map->copy_to = hb_copy_to;
+		if (ops->copy_from)
+			map->copy_from = hb_copy_from;
+	}
+
+	if (hbdev->needs_calib) {
+		err = hb_calibrate(hbdev);
+		if (!err) {
+			dev_err(hbdev->dev, "Calibration failed\n");
+			return -ENODEV;
+		}
+	}
+
+	hbdev->mtd = do_map_probe("cfi_probe", map);
+	if (!hbdev->mtd) {
+		dev_err(hbdev->dev, "probing failed\n");
+		return -ENXIO;
+	}
+
+	hbdev->mtd->dev.parent = hbdev->dev;
+	mtd_set_of_node(hbdev->mtd, np);
+
+	err = mtd_device_register(hbdev->mtd, NULL, 0);
+	if (err) {
+		dev_err(hbdev->dev, "failed to register mtd device\n");
+		goto err_destroy;
+	}
+	hbdev->registered = true;
+
+	return 0;
+
+err_destroy:
+	map_destroy(hbdev->mtd);
+	return err;
+}
+EXPORT_SYMBOL_GPL(hb_register_device);
+
+int hb_unregister_device(struct hb_device *hbdev)
+{
+	int ret = 0;
+
+	if (hbdev && hbdev->mtd && hbdev->registered) {
+		ret = mtd_device_unregister(hbdev->mtd);
+		map_destroy(hbdev->mtd);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hb_unregister_device);
diff --git a/include/linux/mtd/hyperbus.h b/include/linux/mtd/hyperbus.h
new file mode 100644
index 000000000000..0aa11458c424
--- /dev/null
+++ b/include/linux/mtd/hyperbus.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#ifndef __LINUX_MTD_HYPERBUS_H__
+#define __LINUX_MTD_HYPERBUS_H__
+
+#include <linux/mtd/map.h>
+
+enum hb_memtype {
+	HYPERFLASH,
+	HYPERRAM,
+};
+
+/**
+ * struct hb_device - struct representing Hyperbus slave device
+ * @map: map_info struct for accessing MMIO Hyperbus flash memory
+ * @dev: device pointer of Hyperbus Controller
+ * @np:	pointer to Hyperbus slave device node
+ * @mtd: pointer to MTD struct
+ * @ops: pointer to custom Hyperbus ops
+ * @memtype: type of memory device: Hyperflash or HyperRAM
+ * @needs_calib: flag to indicate whether calibration sequence is needed
+ * @registered: flag to indicate whether device is registered with MTD core
+ */
+
+struct hb_device {
+	struct map_info map;
+	struct device *dev;
+	struct device_node *np;
+	struct mtd_info *mtd;
+	struct hb_ops *ops;
+	enum hb_memtype memtype;
+	bool needs_calib;
+	bool registered;
+};
+
+/**
+ * struct hb_ops - struct representing custom Hyperbus operations
+ * @read16: read 16 bit of data, usually from register/ID-CFI space
+ * @write16: write 16 bit of data, usually to register/ID-CFI space
+ * copy_from: copy data from flash memory
+ * copy_to: copy data to flash_memory
+ */
+
+struct hb_ops {
+	u16 (*read16)(struct hb_device *hbdev, unsigned long addr);
+	void (*write16)(struct hb_device *hbdev, unsigned long addr, u16 val);
+
+	void (*copy_from)(struct hb_device *hbdev, void *to,
+			  unsigned long from, ssize_t len);
+	void (*copy_to)(struct hb_device *dev, unsigned long to,
+			const void *from, ssize_t len);
+};
+
+/**
+ * hb_register_device - probe and register a Hyperbus slave memory device
+ * @hbdev: hb_device struct with dev, np populated
+ *
+ * Return: 0 for success, others for failure.
+ */
+int hb_register_device(struct hb_device *hbdev);
+
+/**
+ * hb_unregister_device - deregister Hyperbus slave memory device
+ * @hbdev: hb_device struct of device to be unregistered
+ *
+ * Return: 0 for success, others for failure.
+ */
+int hb_unregister_device(struct hb_device *hbdev);
+
+#endif /* __LINUX_MTD_HYPERBUS_H__ */
-- 
2.20.1

