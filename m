Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09EFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8052D2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfBSLxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:53:40 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:50733 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726180AbfBSLxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 06:53:38 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06712966|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.213033-0.175736-0.611232;FP=0|0|0|0|0|-1|-1|-1;HT=e01e01542;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.E-W9w0Q_1550577197;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.E-W9w0Q_1550577197)
          by smtp.aliyun-inc.com(10.147.40.233);
          Tue, 19 Feb 2019 19:53:30 +0800
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
Subject: [RFC v9 3/5] pstore/blk: add blkoops for pstore_blk
Date:   Tue, 19 Feb 2019 19:52:48 +0800
Message-Id: <1550577170-18761-4-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550577170-18761-1-git-send-email-liaoweixiong@allwinnertech.com>
References: <1550577170-18761-1-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blkoops is a sample for pstore/blk. It can only record oops, excluding
panics as no read/write apis for panic registered. It support settings
on Kconfg/device tree/module parameters. It can record oops log even
power failure if "PSTORE_BLKOOPS_BLKDEV" on Kconfig or "block-device"
on dts or "blkdev" on module parameter is valid.
Otherwise, it can only record data to ram buffer, which will be dropped
when reboot.

Signed-off-by: liaoweixiong <liaoweixiong@allwinnertech.com>
---
 MAINTAINERS                |   2 +-
 fs/pstore/Kconfig          | 114 ++++++++++++++++++++
 fs/pstore/Makefile         |   2 +
 fs/pstore/blkoops.c        | 254 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pstore_blk.h |  14 ++-
 5 files changed, 381 insertions(+), 5 deletions(-)
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
index defcb75..a3c3f34 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -160,3 +160,117 @@ config PSTORE_BLK
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
+	  "PSTORE_BLKOOPS_BLKDEV" on Kconfig or "block-device" on dts or
+	  "blkdev" on module parameter is valid.
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
+	int "dmesg size in kbytes for blkoops"
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
+config PSTORE_BLKOOPS_TOTAL_SIZE
+	int "total size in kbytes for blkoops"
+	depends on PSTORE_BLKOOPS
+	default 1024
+	help
+	  The total size in kbytes pstore/blk can use. It must be less than or
+	  equal to size of block device if @blkdev valid. If @total_size is zero
+	  with @blkdev, @total_size will be set to equal to size of @blkdev.
+	  The value must be a multiple of 4096.
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
+config PSTORE_BLKOOPS_BLKDEV
+	string "block device for blkoops"
+	depends on PSTORE_BLKOOPS
+	default ""
+	help
+	  This just sets block device (blkdev) for pstore/blk. Pstore/blk
+	  will record data to this block device to avoid losing data due to
+	  power failure. So, If it is not set, pstore/blk will drop all data
+	  when reboot.
+
+	  It accpet the following variants:
+	  1) <hex_major><hex_minor> device number in hexadecimal represents
+	     itself no leading 0x, for example b302.
+	  2) /dev/<disk_name> represents the device number of disk
+	  3) /dev/<disk_name><decimal> represents the device number
+	     of partition - device number of disk plus the partition number
+	  4) /dev/<disk_name>p<decimal> - same as the above, that form is
+	     used when disk name of partitioned disk ends on a digit.
+	  5) PARTUUID=00112233-4455-6677-8899-AABBCCDDEEFF representing the
+	     unique id of a partition if the partition table provides it.
+	     The UUID may be either an EFI/GPT UUID, or refer to an MSDOS
+	     partition using the format SSSSSSSS-PP, where SSSSSSSS is a zero-
+	     filled hex representation of the 32-bit "NT disk signature", and PP
+	     is a zero-filled hex representation of the 1-based partition number.
+	  6) PARTUUID=<UUID>/PARTNROFF=<int> to select a partition in relation
+	     to a partition with a known unique id.
+	  7) <major>:<minor> major and minor number of the device separated by
+	     a colon.
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
index 0000000..3885584
--- /dev/null
+++ b/fs/pstore/blkoops.c
@@ -0,0 +1,254 @@
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
+static long total_size = -1;
+module_param(total_size, long, 0400);
+MODULE_PARM_DESC(total_size, "total size in kbytes");
+
+#define BLKDEV_INVALID "INVALID"
+static char blkdev[80] = {BLKDEV_INVALID};
+module_param_string(blkdev, blkdev, 80, 0400);
+MODULE_PARM_DESC(blkdev, "the block device for general read/write");
+
+struct blkz_info blkz_info = {
+	.owner = THIS_MODULE,
+	.name = "blkoops",
+	.dump_oops = true,
+};
+
+struct blkoops_info {
+	unsigned long dmesg_size;
+	unsigned long total_size;
+	const char *blkdev;
+};
+struct blkoops_info blkoops_info = {
+	.dmesg_size = CONFIG_PSTORE_BLKOOPS_DMESG_SIZE * 1024,
+	.total_size = CONFIG_PSTORE_BLKOOPS_TOTAL_SIZE * 1024,
+	.blkdev = CONFIG_PSTORE_BLKOOPS_BLKDEV,
+};
+
+static struct platform_device *dummy;
+
+/**
+ * Block driver use this function to add panic read/write apis to blkoops.
+ * By this, block driver can do the least work that just provides panic ops.
+ */
+int blkoops_add_panic_ops(blkz_read_op panic_read, blkz_write_op panic_write)
+{
+	struct blkz_info *info = &blkz_info;
+
+	if (info->panic_read || info->panic_write)
+		return -EBUSY;
+
+	info->panic_read = panic_read;
+	info->panic_write = panic_write;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(blkoops_add_panic_ops);
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
+	ret = of_property_read_string(np, "block-device",
+			&info->blkdev);
+	if (ret < 0 && ret != -EINVAL) {
+		pr_err("failed to parse block-device: %d\n", ret);
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
+	parse_size("total-size", info->total_size);
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
+	if (!strcmp(info->blkdev, BLKDEV_INVALID) ||
+			strlen(info->blkdev) == 0) {
+		pr_info("no block device, use ram buffer only\n");
+	} else {
+		pr_debug("block device: %s\n", info->blkdev);
+		blkz_info.blkdev = info->blkdev;
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
+	check_size(total_size, 4096);
+	check_size(dmesg_size, 4096);
+
+#undef check_size
+
+	/*
+	 * Update the module parameter variables as well so they are visible
+	 * through /sys/module/blkoops/parameters/
+	 */
+	dmesg_size = blkz_info.dmesg_size;
+	total_size = blkz_info.total_size;
+	if (blkz_info.blkdev)
+		strncpy(blkdev, blkz_info.blkdev, 80 - 1);
+	else
+		blkdev[0] = '\0';
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
+	 * parameters. If mem_size or blkdev isn't set, then there are
+	 * no module parameters, and we can skip this.
+	 */
+	if (total_size < 0 && !strcmp(blkdev, BLKDEV_INVALID))
+		return;
+
+	pr_info("using module parameters\n");
+
+	if (total_size >= 0)
+		info->total_size = (unsigned long)total_size * 1024;
+	if (strcmp(blkdev, BLKDEV_INVALID))
+		info->blkdev = (const char *)blkdev;
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
+late_initcall(blkoops_init);
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
diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
index 4f239f0..2d2ff97 100644
--- a/include/linux/pstore_blk.h
+++ b/include/linux/pstore_blk.h
@@ -60,6 +60,8 @@
  * @panic_write:
  *	the write operation only used for panic.
  */
+typedef ssize_t (*blkz_read_op)(char *, size_t, loff_t);
+typedef ssize_t (*blkz_write_op)(const char *, size_t, loff_t);
 struct blkz_info {
 	struct module *owner;
 	const char *name;
@@ -68,13 +70,17 @@ struct blkz_info {
 	unsigned long total_size;
 	unsigned long dmesg_size;
 	int dump_oops;
-	ssize_t (*read)(char *buf, size_t bytes, loff_t pos);
-	ssize_t (*write)(const char *buf, size_t bytes, loff_t pos);
-	ssize_t (*panic_read)(char *buf, size_t bytes, loff_t pos);
-	ssize_t (*panic_write)(const char *buf, size_t bytes, loff_t pos);
+	blkz_read_op read;
+	blkz_write_op write;
+	blkz_read_op panic_read;
+	blkz_write_op panic_write;
 };
 
 extern int blkz_register(struct blkz_info *info);
 extern void blkz_unregister(struct blkz_info *info);
 
+#if IS_ENABLED(CONFIG_PSTORE_BLKOOPS)
+extern int blkoops_add_panic_ops(blkz_read_op, blkz_write_op);
+#endif
+
 #endif
-- 
1.9.1

