Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D7AC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A3D222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391749AbfBMOHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:07:48 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:32788 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391646AbfBMOHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:07:47 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06712966|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16384;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.Dy6iQiS_1550066841;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.Dy6iQiS_1550066841)
          by smtp.aliyun-inc.com(10.147.40.233);
          Wed, 13 Feb 2019 22:07:38 +0800
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        liaoweixiong <liaoweixiong@allwinnertech.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [RFC v8 3/5] pstore/blk: add blkoops for pstore_blk
Date:   Wed, 13 Feb 2019 22:07:06 +0800
Message-Id: <1550066828-18806-4-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550066828-18806-1-git-send-email-liaoweixiong@allwinnertech.com>
References: <1550066828-18806-1-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blkoops is a sample for pstore/blk. It can only record oops, excluding
panics as no read/write apis for panic registered. It support settings
on Kconfg/device tree/module parameters. It can record oops log even
power failure if "PSTORE_BLKOOPS_PART_PATH" on Kconfig or
"partition-path" on dts or "part_path" on module parameter is valid.
Otherwise, it can only record data to ram buffer, which will be dropped
when reboot.

Signed-off-by: liaoweixiong <liaoweixiong@allwinnertech.com>
---
 MAINTAINERS         |   2 +-
 fs/pstore/Kconfig   | 117 +++++++++++++++++++++++++
 fs/pstore/Makefile  |   2 +
 fs/pstore/blkoops.c | 239 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 359 insertions(+), 1 deletion(-)
 create mode 100644 fs/pstore/blkoops.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f49dd37..44647a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12319,7 +12319,7 @@ F:	drivers/acpi/apei/erst.c
 F:	Documentation/admin-guide/ramoops.rst
 F:	Documentation/devicetree/bindings/reserved-memory/ramoops.txt
 F:	Documentation/devicetree/bindings/pstore-block/
-K:	\b(pstore|ramoops)
+K:	\b(pstore|ramoops|blkoops)
 
 PTP HARDWARE CLOCK SUPPORT
 M:	Richard Cochran <richardcochran@gmail.com>
diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index a881c53..f0a1a49 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -159,3 +159,120 @@ config PSTORE_BLK
 	help
 	  This enables panic and oops message to be logged to a block dev
 	  where it can be read back at some later point.
+
+config PSTORE_BLKOOPS
+	tristate "pstore block with oops logger"
+	depends on PSTORE_BLK
+	help
+	  This is a sample for pstore block with oops logger.
+
+	  It CANNOT record panic log as no read/write apis for panic registered.
+
+	  It CAN record oops log even power failure if
+	  "PSTORE_BLKOOPS_PART_PATH" on Kconfig or "partition-path" on dts or
+	  "part_path" on module parameter is valid.
+
+	  Otherwise, it can only record data to ram buffer, which will be
+	  dropped when reboot.
+
+	  NOTE that, there are three ways to set parameters of blkoops and
+	  prioritize according to configuration flexibility. That is
+	  Kconfig < device tree < module parameters. It means that the value can
+	  be overwritten by higher priority settings.
+	  1. Kconfig
+	     It	just sets a default value.
+	  2. device tree
+	     It is set on device tree, which will overwrites value from Kconfig,
+	     but can also be overwritten by module parameters.
+	  3. module parameters
+	     It is the first priority. Take care of that blkoops will take lower
+	     priority settings if higher priority one do not set.
+
+config PSTORE_BLKOOPS_DMESG_SIZE
+	int "dmesg_size in kbytes for blkoops"
+	depends on PSTORE_BLKOOPS
+	default 64
+	help
+	  This just sets size of dmesg (dmesg_size) for pstore/blk. The value
+	  must be a multiple of 4096.
+
+	  NOTE that, there are three ways to set parameters of blkoops and
+	  prioritize according to configuration flexibility. That is
+	  Kconfig < device tree < module parameters. It means that the value can
+	  be overwritten by higher priority settings.
+	  1. Kconfig
+	     It	just sets a default value.
+	  2. device tree
+	     It is set on device tree, which will overwrites value from Kconfig,
+	     but can also be overwritten by module parameters.
+	  3. module parameters
+	     It is the first priority. Take care of that blkoops will take lower
+	     priority settings if higher priority one do not set.
+
+config PSTORE_BLKOOPS_PMSG_SIZE
+	int "pmsg_size in kbytes for blkoops"
+	depends on PSTORE_BLKOOPS
+	default 64
+	help
+	  This just sets size of pmsg (pmsg_size) for pstore/blk. The value must
+	  be a multiple of 4096. Pmsg work only if "part_path" is set.
+
+	  NOTE that, there are three ways to set parameters of blkoops and
+	  prioritize according to configuration flexibility. That is
+	  Kconfig < device tree < module parameters. It means that the value can
+	  be overwritten by higher priority settings.
+	  1. Kconfig
+	     It	just sets a default value.
+	  2. device tree
+	     It is set on device tree, which will overwrites value from Kconfig,
+	     but can also be overwritten by module parameters.
+	  3. module parameters
+	     It is the first priority. Take care of that blkoops will take lower
+	     priority settings if higher priority one do not set.
+
+config PSTORE_BLKOOPS_PART_SIZE
+	int "part_size in kbytes for blkoops"
+	depends on PSTORE_BLKOOPS
+	default 1024
+	help
+	  This just sets partition size (part_size) for pstore/blk. Pstore/blk
+	  will allocate part_size memory to temporarily hold the data. It's the
+	  size of partition on part_path. The value must be a multiple of 4096.
+
+	  NOTE that, there are three ways to set parameters of blkoops and
+	  prioritize according to configuration flexibility. That is
+	  Kconfig < device tree < module parameters. It means that the value can
+	  be overwritten by higher priority settings.
+	  1. Kconfig
+	     It	just sets a default value.
+	  2. device tree
+	     It is set on device tree, which will overwrites value from Kconfig,
+	     but can also be overwritten by module parameters.
+	  3. module parameters
+	     It is the first priority. Take care of that blkoops will take lower
+	     priority settings if higher priority one do not set.
+
+config PSTORE_BLKOOPS_PART_PATH
+	string "part_path for blkoops"
+	depends on PSTORE_BLKOOPS
+	default ""
+	help
+	  This just sets partition path (part_path) for pstore/blk. Pstore/blk
+	  will record data to this block partition to avoid losing data due to
+	  power failure. So, If it is not set, pstore/blk will drop all data
+	  when reboot.
+
+	  The strings must begin with "/dev/".
+
+	  NOTE that, there are three ways to set parameters of blkoops and
+	  prioritize according to configuration flexibility. That is
+	  Kconfig < device tree < module parameters. It means that the value can
+	  be overwritten by higher priority settings.
+	  1. Kconfig
+	     It	just sets a default value.
+	  2. device tree
+	     It is set on device tree, which will overwrites value from Kconfig,
+	     but can also be overwritten by module parameters.
+	  3. module parameters
+	     It is the first priority. Take care of that blkoops will take lower
+	     priority settings if higher priority one do not set.
diff --git a/fs/pstore/Makefile b/fs/pstore/Makefile
index 0ee2fc8..24b3d48 100644
--- a/fs/pstore/Makefile
+++ b/fs/pstore/Makefile
@@ -15,3 +15,5 @@ obj-$(CONFIG_PSTORE_RAM)	+= ramoops.o
 
 obj-$(CONFIG_PSTORE_BLK) += pstore_blk.o
 pstore_blk-y += blkzone.o
+
+obj-$(CONFIG_PSTORE_BLKOOPS) += blkoops.o
diff --git a/fs/pstore/blkoops.c b/fs/pstore/blkoops.c
new file mode 100644
index 0000000..fd926a5
--- /dev/null
+++ b/fs/pstore/blkoops.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *
+ * blkoops.c: Block device Oops logger
+ *
+ * Copyright (C) 2019 liaoweixiong <liaoweixiong@gallwinnertech.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ */
+#define MODNAME "blkoops"
+#define pr_fmt(fmt) MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/pstore_blk.h>
+
+static long dmesg_size = -1;
+module_param(dmesg_size, long, 0400);
+MODULE_PARM_DESC(dmesg_size, "demsg size in kbytes");
+
+static long part_size = -1;
+module_param(part_size, long, 0400);
+MODULE_PARM_DESC(part_size, "partition size in kbytes");
+
+#define PART_PATH_INVALID "INVALID"
+static char part_path[80] = {PART_PATH_INVALID};
+module_param_string(part_path, part_path, 80, 0400);
+MODULE_PARM_DESC(part_path, "path of partition in /dev for general read/write");
+
+struct blkz_info blkz_info = {
+	.owner = THIS_MODULE,
+	.name = "blkoops",
+	.dump_oops = true,
+};
+
+struct blkoops_info {
+	unsigned long dmesg_size;
+	unsigned long part_size;
+	const char *part_path;
+};
+struct blkoops_info blkoops_info = {
+	.dmesg_size = CONFIG_PSTORE_BLKOOPS_DMESG_SIZE * 1024,
+	.part_size = CONFIG_PSTORE_BLKOOPS_PART_SIZE * 1024,
+	.part_path = CONFIG_PSTORE_BLKOOPS_PART_PATH,
+};
+
+static struct platform_device *dummy;
+
+static int blkoops_parse_dt_size(struct device_node *np,
+		const char *propname, u32 *value)
+{
+	u32 val32 = 0;
+	int ret;
+
+	ret = of_property_read_u32(np, propname, &val32);
+	if (ret < 0) {
+		if (ret != -EINVAL)
+			pr_err("failed to parse property %s: %d\n",
+				propname, ret);
+		return ret;
+	}
+
+	if (val32 * 1024 > INT_MAX) {
+		pr_err("%s %u > INT_MAX\n", propname, val32);
+		return -EOVERFLOW;
+	}
+
+	*value = val32 * 1024;
+	return 0;
+}
+
+static int __init blkoops_parse_dt(struct blkoops_info *info,
+		struct device_node *np)
+{
+	int ret;
+	u32 value;
+
+	pr_info("using device tree\n");
+
+	ret = of_property_read_string(np, "partition-path",
+			&info->part_path);
+	if (ret < 0 && ret != -EINVAL) {
+		pr_err("failed to parse partition path : %d\n", ret);
+		return ret;
+	}
+
+#define parse_size(name, field) {					\
+		ret = blkoops_parse_dt_size(np, name, &value);		\
+		if (ret < 0 && ret != -EINVAL)				\
+			return ret;					\
+		else if (ret == 0)					\
+			field = value;					\
+	}
+
+	parse_size("partition-size", info->part_size);
+	parse_size("dmesg-size", info->dmesg_size);
+
+#undef parse_size
+	return 0;
+}
+
+static int blkoops_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *of_node = dev_of_node(dev);
+	struct blkoops_info *info = dev->platform_data;
+
+	if (of_node && !info) {
+		int err;
+
+		info = &blkoops_info;
+		err = blkoops_parse_dt(info, of_node);
+		if (err)
+			return err;
+	}
+
+	if (!strcmp(info->part_path, PART_PATH_INVALID) ||
+			strlen(info->part_path) == 0) {
+		pr_info("no path for block partition, use ram buffer only\n");
+	} else if (strncmp(info->part_path, "/dev/", 5) != 0) {
+		pr_err("invalid partition path %s, use ram buffer only\n",
+				info->part_path);
+	} else {
+		pr_debug("path for block partition: %s\n", info->part_path);
+		blkz_info.part_path = info->part_path;
+	}
+
+#define check_size(name, size) {					\
+		if (info->name & (size - 1)) {				\
+			pr_err(#name " must be a multiple of %d\n",	\
+					(size));			\
+			return -EINVAL;					\
+		}							\
+		blkz_info.name = info->name;				\
+	}
+
+	check_size(part_size, 4096);
+	check_size(dmesg_size, 4096);
+
+#undef check_size
+
+	/*
+	 * Update the module parameter variables as well so they are visible
+	 * through /sys/module/blkoops/parameters/
+	 */
+	dmesg_size = blkz_info.dmesg_size;
+	part_size = blkz_info.part_size;
+	if (blkz_info.part_path)
+		strncpy(part_path, blkz_info.part_path, 80 - 1);
+	else
+		part_path[0] = '\0';
+	return blkz_register(&blkz_info);
+}
+
+static int blkoops_remove(struct platform_device *pdev)
+{
+	blkz_unregister(&blkz_info);
+	return 0;
+}
+
+static const struct of_device_id dt_match[] = {
+	{ .compatible = MODNAME},
+	{}
+};
+
+static struct platform_driver blkoops_driver = {
+	.probe		= blkoops_probe,
+	.remove		= blkoops_remove,
+	.driver		= {
+		.name		= MODNAME,
+		.of_match_table	= dt_match,
+	},
+};
+
+void blkoops_register_dummy(void)
+{
+	struct blkoops_info *info = &blkoops_info;
+	/*
+	 * Prepare a dummy platform data structure to carry the module
+	 * parameters. If mem_size isn't set, then there are no module
+	 * parameters, and we can skip this.
+	 */
+	if (part_size < 0)
+		return;
+
+	pr_info("using module parameters\n");
+
+	info->part_size = (unsigned long)part_size * 1024;
+	if (strcmp(part_path, PART_PATH_INVALID))
+		info->part_path = (const char *)part_path;
+	if (dmesg_size >= 0)
+		info->dmesg_size = (unsigned long)dmesg_size * 1024;
+
+	dummy = platform_device_register_data(NULL, MODNAME, -1, info,
+			sizeof(*info));
+	if (IS_ERR(dummy)) {
+		pr_err("could not create platform device: %ld\n",
+			PTR_ERR(dummy));
+		dummy = NULL;
+	}
+}
+
+static int __init blkoops_init(void)
+{
+	int ret;
+
+	blkoops_register_dummy();
+	ret = platform_driver_register(&blkoops_driver);
+	if (ret != 0) {
+		platform_device_unregister(dummy);
+		dummy = NULL;
+	}
+	return ret;
+}
+module_init(blkoops_init);
+
+static void __exit blkoops_exit(void)
+{
+	platform_driver_unregister(&blkoops_driver);
+	platform_device_unregister(dummy);
+	dummy = NULL;
+}
+module_exit(blkoops_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("liaoweixiong <liaoweixiong@allwinnertech.com>");
+MODULE_DESCRIPTION("Sample for Pstore BLK with Oops logger");
-- 
1.9.1

