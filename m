Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36892ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E316020875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E316020875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388352AbeGXGKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 02:10:31 -0400
Received: from gate.crashing.org ([63.228.1.57]:54449 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388287AbeGXGKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 02:10:31 -0400
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w6O55JLH028169;
        Tue, 24 Jul 2018 00:05:24 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     openbmc@lists.ozlabs.org
Cc:     Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Eddie James <eajames@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/5] fsi: Add new central chardev support
Date:   Tue, 24 Jul 2018 15:05:15 +1000
Message-Id: <20180724050519.31920-2-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724050519.31920-1-benh@kernel.crashing.org>
References: <20180724050519.31920-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The various FSI devices (sbefifo, occ, scom, more to come)
currently use misc devices.

This is problematic as the minor device space for misc is
limited and there can be a lot of them. Also it limits our
ability to move them to a dedicated /dev/fsi directory or
to be smart about device naming and numbering.

It also means we have IDAs on every single of these drivers

This creates a common fsi "device_type" for the optional
/dev/fsi grouping and a dev_t allocator for all FSI devices.

"Legacy" devices get to use a backward compatible numbering
scheme (as long as chip id <16 and there's only one copy
of a given unit type per chip).

A single major number and a single IDA are shared for all
FSI devices.

This doesn't convert the FSI device drivers to use the new
scheme yet, they will be converted individually.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/Kconfig    | 15 +++++++
 drivers/fsi/fsi-core.c | 95 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/fsi.h    | 12 +++++-
 3 files changed, 119 insertions(+), 3 deletions(-)

diff --git a/drivers/fsi/Kconfig b/drivers/fsi/Kconfig
index 8d82b1e60514..af3a20dd5aa4 100644
--- a/drivers/fsi/Kconfig
+++ b/drivers/fsi/Kconfig
@@ -12,6 +12,21 @@ menuconfig FSI
 
 if FSI
 
+config FSI_NEW_DEV_NODE
+	bool "Create '/dev/fsi' directory for char devices"
+	default n
+	---help---
+	This option causes char devices created for FSI devices to be
+	located under a common /dev/fsi/ directory. Set to N unless your
+	userspace has been updated to handle the new location.
+
+	Additionally, it also causes the char device names to be offset
+	by one so that chip 0 will have /dev/scom1 and chip1 /dev/scom2
+	to match old userspace expectations.
+
+	New userspace will use udev rules to generate predictable access
+	symlinks in /dev/fsi/by-path when this option is enabled.
+
 config FSI_MASTER_GPIO
 	tristate "GPIO-based FSI master"
 	depends on GPIOLIB
diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index eab6c5c4990e..faa1760a5a40 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -92,6 +92,13 @@ struct fsi_slave {
 static const int slave_retries = 2;
 static int discard_errors;
 
+static dev_t fsi_base_dev;
+static DEFINE_IDA(fsi_minor_ida);
+#define FSI_CHAR_MAX_DEVICES	0x1000
+
+/* Legacy /dev numbering: 4 devices per chip, 16 chips */
+#define FSI_CHAR_LEGACY_TOP	64
+
 static int fsi_master_read(struct fsi_master *master, int link,
 		uint8_t slave_id, uint32_t addr, void *val, size_t size);
 static int fsi_master_write(struct fsi_master *master, int link,
@@ -627,6 +634,7 @@ static void fsi_slave_release(struct device *dev)
 {
 	struct fsi_slave *slave = to_fsi_slave(dev);
 
+	fsi_free_minor(slave->dev.devt);
 	of_node_put(dev->of_node);
 	kfree(slave);
 }
@@ -729,6 +737,75 @@ static ssize_t chip_id_show(struct device *dev,
 
 static DEVICE_ATTR_RO(chip_id);
 
+static char *fsi_cdev_devnode(struct device *dev, umode_t *mode,
+			      kuid_t *uid, kgid_t *gid)
+{
+#ifdef CONFIG_FSI_NEW_DEV_NODE
+	return kasprintf(GFP_KERNEL, "fsi/%s", dev_name(dev));
+#else
+	return kasprintf(GFP_KERNEL, "%s", dev_name(dev));
+#endif
+}
+
+const struct device_type fsi_cdev_type = {
+	.name = "fsi-cdev",
+	.devnode = fsi_cdev_devnode,
+};
+EXPORT_SYMBOL_GPL(fsi_cdev_type);
+
+/* Backward compatible /dev/ numbering in "old style" mode */
+static int fsi_adjust_index(int index)
+{
+#ifdef CONFIG_FSI_NEW_DEV_NODE
+	return index;
+#else
+	return index + 1;
+#endif
+}
+
+static int __fsi_get_new_minor(struct fsi_slave *slave, enum fsi_dev_type type,
+			       dev_t *out_dev, int *out_index)
+{
+	int cid = slave->chip_id;
+	int id;
+
+	/* Check if we qualify for legacy numbering */
+	if (cid >= 0 && cid < 16 && type < 4) {
+		/* Try reserving the legacy number */
+		id = (cid << 4) | type;
+		id = ida_simple_get(&fsi_minor_ida, id, id + 1, GFP_KERNEL);
+		if (id >= 0) {
+			*out_index = fsi_adjust_index(cid);
+			*out_dev = fsi_base_dev + id;
+			return 0;
+		}
+		/* Other failure */
+		if (id != -ENOSPC)
+			return id;
+		/* Fallback to non-legacy allocation */
+	}
+	id = ida_simple_get(&fsi_minor_ida, FSI_CHAR_LEGACY_TOP,
+			    FSI_CHAR_MAX_DEVICES, GFP_KERNEL);
+	if (id < 0)
+		return id;
+	*out_index = fsi_adjust_index(id);
+	*out_dev = fsi_base_dev + id;
+	return 0;
+}
+
+int fsi_get_new_minor(struct fsi_device *fdev, enum fsi_dev_type type,
+		      dev_t *out_dev, int *out_index)
+{
+	return __fsi_get_new_minor(fdev->slave, type, out_dev, out_index);
+}
+EXPORT_SYMBOL_GPL(fsi_get_new_minor);
+
+void fsi_free_minor(dev_t dev)
+{
+	ida_simple_remove(&fsi_minor_ida, MINOR(dev));
+}
+EXPORT_SYMBOL_GPL(fsi_free_minor);
+
 static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 {
 	uint32_t chip_id;
@@ -953,7 +1030,7 @@ static int fsi_slave_remove_device(struct device *dev, void *arg)
 static int fsi_master_remove_slave(struct device *dev, void *arg)
 {
 	device_for_each_child(dev, NULL, fsi_slave_remove_device);
-	device_unregister(dev);
+	put_device(dev);
 	return 0;
 }
 
@@ -1091,13 +1168,27 @@ EXPORT_SYMBOL_GPL(fsi_bus_type);
 
 static int __init fsi_init(void)
 {
-	return bus_register(&fsi_bus_type);
+	int rc;
+
+	rc = alloc_chrdev_region(&fsi_base_dev, 0, FSI_CHAR_MAX_DEVICES, "fsi");
+	if (rc)
+		return rc;
+	rc = bus_register(&fsi_bus_type);
+	if (rc)
+		goto fail_bus;
+	return 0;
+
+ fail_bus:
+	unregister_chrdev_region(fsi_base_dev, FSI_CHAR_MAX_DEVICES);
+	return rc;
 }
 postcore_initcall(fsi_init);
 
 static void fsi_exit(void)
 {
 	bus_unregister(&fsi_bus_type);
+	unregister_chrdev_region(fsi_base_dev, FSI_CHAR_MAX_DEVICES);
+	ida_destroy(&fsi_minor_ida);
 }
 module_exit(fsi_exit);
 module_param(discard_errors, int, 0664);
diff --git a/include/linux/fsi.h b/include/linux/fsi.h
index 141fd38d061f..ec3be0d5b786 100644
--- a/include/linux/fsi.h
+++ b/include/linux/fsi.h
@@ -76,8 +76,18 @@ extern int fsi_slave_read(struct fsi_slave *slave, uint32_t addr,
 extern int fsi_slave_write(struct fsi_slave *slave, uint32_t addr,
 		const void *val, size_t size);
 
+extern struct bus_type fsi_bus_type;
+extern const struct device_type fsi_cdev_type;
 
+enum fsi_dev_type {
+	fsi_dev_cfam,
+	fsi_dev_sbefifo,
+	fsi_dev_scom,
+	fsi_dev_occ
+};
 
-extern struct bus_type fsi_bus_type;
+extern int fsi_get_new_minor(struct fsi_device *fdev, enum fsi_dev_type type,
+			     dev_t *out_dev, int *out_index);
+extern void fsi_free_minor(dev_t dev);
 
 #endif /* LINUX_FSI_H */
-- 
2.17.1

