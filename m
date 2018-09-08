Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0156C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 356A4206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=obeliks.de header.i=@obeliks.de header.b="iPCxHzny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356A4206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nospam.obeliks.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbeIHSGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 14:06:30 -0400
Received: from scopuli.esotechnik.de ([79.143.188.15]:52669 "EHLO
        mail.esotechnik.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbeIHSG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 14:06:29 -0400
Received: by mail.esotechnik.net (Postfix) with ESMTPSA id 58425AE0B84;
        Sat,  8 Sep 2018 15:14:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=obeliks.de; s=jul2017;
        t=1536412445; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3RVMszzhPytHPhn/eAJITVq/4BY2TnAnnsNdD4Pgbzo=;
        b=iPCxHznyAkPcGHkzBfYTNK4raVh+SjxM3Vxj04F2VzRGWPXRVMoRlHRa1S08da2a9loVAA
        L32E8avPfVapetio4fU4yZfG68Y0MGIorJjQ6GOpdstyHcxZPtcsfqJavQ48CVEkX1bHsF
        yI7MJg+OPDAlzArIywL/0oEdOXS4+6vjwujQ/NBQ3hFZfJ3wea1aJAuZR0YzdBGrnu3835
        zzHfGVKVoUiGXDphTZ9giV9Ht7Ii0mmkXcMhwMU5gGW7cxScNxV+9oFfV4BaiDggls4ONx
        WhDlmEAfGdX4Nv5d4z934H5NZhFijMYKGOfZqKXdpsKUE5I29W/I8/1VV3hyqA==
From:   Bernhard Frauendienst <kernel@nospam.obeliks.de>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Bernhard Frauendienst <kernel@nospam.obeliks.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] mtd: mtdconcat: add dt driver for concat devices
Date:   Sat,  8 Sep 2018 15:13:45 +0200
Message-Id: <20180908131345.8145-4-kernel@nospam.obeliks.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180908131345.8145-1-kernel@nospam.obeliks.de>
References: <20180908131345.8145-1-kernel@nospam.obeliks.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some mtd drivers like physmap variants have support for concatenating
multiple mtd devices, but there is no generic way to define such a
concat device from within the device tree.

This is useful for some SoC boards that use multiple flash chips as
memory banks of a single mtd device, with partitions spanning chip
borders.

This commit adds a driver for creating virtual mtd-concat devices. They
must have a compatible = "mtd-concat" line, and define a list of devices
to concat in the 'devices' property, for example:

flash {
  compatible = "mtd-concat";

  devices = <&flash0 &flash1>;

  partitions {
    ...
  };
};

The driver is added to the very end of the mtd Makefile to increase the
likelyhood of all child devices already being loaded at the time of
probing, preventing unnecessary deferred probes.

Signed-off-by: Bernhard Frauendienst <kernel@nospam.obeliks.de>
---
 drivers/mtd/Kconfig                 |   2 +
 drivers/mtd/Makefile                |   3 +
 drivers/mtd/composite/Kconfig       |  12 +++
 drivers/mtd/composite/Makefile      |   7 ++
 drivers/mtd/composite/virt_concat.c | 128 ++++++++++++++++++++++++++++
 5 files changed, 152 insertions(+)
 create mode 100644 drivers/mtd/composite/Kconfig
 create mode 100644 drivers/mtd/composite/Makefile
 create mode 100644 drivers/mtd/composite/virt_concat.c

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index c77f537323ec..6345d886d458 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -339,4 +339,6 @@ source "drivers/mtd/spi-nor/Kconfig"
 
 source "drivers/mtd/ubi/Kconfig"
 
+source "drivers/mtd/composite/Kconfig"
+
 endif # MTD
diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
index 93473d215a38..57af7190b063 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -36,3 +36,6 @@ obj-y		+= chips/ lpddr/ maps/ devices/ nand/ tests/
 
 obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor/
 obj-$(CONFIG_MTD_UBI)		+= ubi/
+
+# Composite drivers must be loaded last
+obj-y		+= composite/
diff --git a/drivers/mtd/composite/Kconfig b/drivers/mtd/composite/Kconfig
new file mode 100644
index 000000000000..0490fc0284bb
--- /dev/null
+++ b/drivers/mtd/composite/Kconfig
@@ -0,0 +1,12 @@
+menu "Composite MTD device drivers"
+	depends on MTD!=n
+
+config MTD_VIRT_CONCAT
+	tristate "Virtual concat MTD device"
+	help
+	  This driver allows creation of a virtual MTD concat device, which
+	  concatenates multiple underlying MTD devices to a single device.
+	  This is required by some SoC boards where multiple memory banks are
+	  used as one device with partitions spanning across device boundaries.
+
+endmenu
diff --git a/drivers/mtd/composite/Makefile b/drivers/mtd/composite/Makefile
new file mode 100644
index 000000000000..8421a0a30606
--- /dev/null
+++ b/drivers/mtd/composite/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# linux/drivers/mtd/composite/Makefile
+#
+
+obj-$(CONFIG_MTD_VIRT_CONCAT)   += virt_concat.o
diff --git a/drivers/mtd/composite/virt_concat.c b/drivers/mtd/composite/virt_concat.c
new file mode 100644
index 000000000000..76918d4ef07f
--- /dev/null
+++ b/drivers/mtd/composite/virt_concat.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Virtual concat MTD device driver
+ *
+ * Copyright (C) 2018 Bernhard Frauendienst
+ * Author: Bernhard Frauendienst, kernel@nospam.obeliks.de
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/mtd/concat.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+
+/*
+ * struct of_virt_concat - platform device driver data.
+ * @cmtd the final mtd_concat device
+ * @num_devices the number of devices in @devices
+ * @devices points to an array of devices already loaded
+ */
+struct of_virt_concat {
+	struct mtd_info	*cmtd;
+	int num_devices;
+	struct mtd_info	**devices;
+};
+
+static int virt_concat_remove(struct platform_device *pdev)
+{
+	struct of_virt_concat *info;
+	int i;
+
+	info = platform_get_drvdata(pdev);
+	if (!info)
+		return 0;
+
+	// unset data for when this is called after a probe error
+	platform_set_drvdata(pdev, NULL);
+
+	if (info->cmtd) {
+		mtd_device_unregister(info->cmtd);
+		mtd_concat_destroy(info->cmtd);
+	}
+
+	if (info->devices) {
+		for (i = 0; i < info->num_devices; i++)
+			put_mtd_device(info->devices[i]);
+	}
+
+	return 0;
+}
+
+static int virt_concat_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct of_phandle_iterator it;
+	struct of_virt_concat *info;
+	struct mtd_info *mtd;
+	int err = 0, count;
+
+	count = of_count_phandle_with_args(node, "devices", NULL);
+	if (count <= 0)
+		return -EINVAL;
+
+	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	info->devices = devm_kcalloc(&pdev->dev, count,
+				     sizeof(*(info->devices)), GFP_KERNEL);
+	if (!info->devices) {
+		err = -ENOMEM;
+		goto err_remove;
+	}
+
+	platform_set_drvdata(pdev, info);
+
+	of_for_each_phandle(&it, err, node, "devices", NULL, 0) {
+		mtd = get_mtd_device_by_node(it.node);
+		if (IS_ERR(mtd)) {
+			of_node_put(it.node);
+			err = -EPROBE_DEFER;
+			goto err_remove;
+		}
+
+		info->devices[info->num_devices++] = mtd;
+	}
+
+	info->cmtd = mtd_concat_create(info->devices, info->num_devices,
+				       dev_name(&pdev->dev));
+	if (!info->cmtd) {
+		err = -ENXIO;
+		goto err_remove;
+	}
+
+	info->cmtd->dev.parent = &pdev->dev;
+	mtd_set_of_node(info->cmtd, node);
+	mtd_device_register(info->cmtd, NULL, 0);
+
+	return 0;
+
+err_remove:
+	virt_concat_remove(pdev);
+
+	return err;
+}
+
+static const struct of_device_id virt_concat_of_match[] = {
+	{ .compatible = "mtd-concat", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, virt_concat_of_match);
+
+static struct platform_driver virt_concat_driver = {
+	.probe = virt_concat_probe,
+	.remove = virt_concat_remove,
+	.driver	 = {
+		.name   = "virt-mtdconcat",
+		.of_match_table = virt_concat_of_match,
+	},
+};
+
+module_platform_driver(virt_concat_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Bernhard Frauendienst <kernel@nospam.obeliks.de>");
+MODULE_DESCRIPTION("Virtual concat MTD device driver");
-- 
2.18.0

