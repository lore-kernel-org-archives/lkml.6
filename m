Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4D9ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B64820838
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B64820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbeJaMVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 08:21:09 -0400
Received: from mga07.intel.com ([134.134.136.100]:42129 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728773AbeJaMVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 08:21:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 20:24:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,447,1534834800"; 
   d="scan'208";a="88086345"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008.jf.intel.com with ESMTP; 30 Oct 2018 20:24:58 -0700
Subject: [PATCH 4/8] device-dax: Start defining a dax bus model
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com
Date:   Tue, 30 Oct 2018 20:13:10 -0700
Message-ID: <154095559024.3271337.430416943172824554.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <154095556915.3271337.12581429676272726902.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <154095556915.3271337.12581429676272726902.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Towards eliminating the dax_class, move the dax-device-attribute
enabling to a new bus.c file in the core. The amount of code
thrash of sub-sequent patches is reduced as no logic changes are made,
just pure code movement.

A temporary export of unregister_dex_dax() and dax_attribute_groups is
needed to preserve compilation, but those symbols become static again in
a follow-on patch.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/Makefile        |    1 
 drivers/dax/bus.c           |  174 ++++++++++++++++++++++++++++++++++++++++
 drivers/dax/bus.h           |   15 +++
 drivers/dax/dax-private.h   |   14 +++
 drivers/dax/dax.h           |   18 ----
 drivers/dax/device-dax.h    |   23 -----
 drivers/dax/device.c        |  185 +------------------------------------------
 drivers/dax/pmem.c          |    2 
 drivers/dax/super.c         |    1 
 tools/testing/nvdimm/Kbuild |    1 
 10 files changed, 210 insertions(+), 224 deletions(-)
 create mode 100644 drivers/dax/bus.c
 create mode 100644 drivers/dax/bus.h
 delete mode 100644 drivers/dax/dax.h
 delete mode 100644 drivers/dax/device-dax.h

diff --git a/drivers/dax/Makefile b/drivers/dax/Makefile
index 574286fac87c..658e6b9b1d74 100644
--- a/drivers/dax/Makefile
+++ b/drivers/dax/Makefile
@@ -4,5 +4,6 @@ obj-$(CONFIG_DEV_DAX) += device_dax.o
 obj-$(CONFIG_DEV_DAX_PMEM) += dax_pmem.o
 
 dax-y := super.o
+dax-y += bus.o
 dax_pmem-y := pmem.o
 device_dax-y := device.o
diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
new file mode 100644
index 000000000000..8a398e8e1956
--- /dev/null
+++ b/drivers/dax/bus.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2017-2018 Intel Corporation. All rights reserved. */
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/dax.h>
+#include "dax-private.h"
+#include "bus.h"
+
+/*
+ * Rely on the fact that drvdata is set before the attributes are
+ * registered, and that the attributes are unregistered before drvdata
+ * is cleared to assume that drvdata is always valid.
+ */
+static ssize_t id_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct dax_region *dax_region = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", dax_region->id);
+}
+static DEVICE_ATTR_RO(id);
+
+static ssize_t region_size_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct dax_region *dax_region = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%llu\n", (unsigned long long)
+			resource_size(&dax_region->res));
+}
+static struct device_attribute dev_attr_region_size = __ATTR(size, 0444,
+		region_size_show, NULL);
+
+static ssize_t align_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct dax_region *dax_region = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", dax_region->align);
+}
+static DEVICE_ATTR_RO(align);
+
+static struct attribute *dax_region_attributes[] = {
+	&dev_attr_region_size.attr,
+	&dev_attr_align.attr,
+	&dev_attr_id.attr,
+	NULL,
+};
+
+static const struct attribute_group dax_region_attribute_group = {
+	.name = "dax_region",
+	.attrs = dax_region_attributes,
+};
+
+static const struct attribute_group *dax_region_attribute_groups[] = {
+	&dax_region_attribute_group,
+	NULL,
+};
+
+static void dax_region_free(struct kref *kref)
+{
+	struct dax_region *dax_region;
+
+	dax_region = container_of(kref, struct dax_region, kref);
+	kfree(dax_region);
+}
+
+void dax_region_put(struct dax_region *dax_region)
+{
+	kref_put(&dax_region->kref, dax_region_free);
+}
+EXPORT_SYMBOL_GPL(dax_region_put);
+
+static void dax_region_unregister(void *region)
+{
+	struct dax_region *dax_region = region;
+
+	sysfs_remove_groups(&dax_region->dev->kobj,
+			dax_region_attribute_groups);
+	dax_region_put(dax_region);
+}
+
+struct dax_region *alloc_dax_region(struct device *parent, int region_id,
+		struct resource *res, unsigned int align,
+		unsigned long pfn_flags)
+{
+	struct dax_region *dax_region;
+
+	/*
+	 * The DAX core assumes that it can store its private data in
+	 * parent->driver_data. This WARN is a reminder / safeguard for
+	 * developers of device-dax drivers.
+	 */
+	if (dev_get_drvdata(parent)) {
+		dev_WARN(parent, "dax core failed to setup private data\n");
+		return NULL;
+	}
+
+	if (!IS_ALIGNED(res->start, align)
+			|| !IS_ALIGNED(resource_size(res), align))
+		return NULL;
+
+	dax_region = kzalloc(sizeof(*dax_region), GFP_KERNEL);
+	if (!dax_region)
+		return NULL;
+
+	dev_set_drvdata(parent, dax_region);
+	memcpy(&dax_region->res, res, sizeof(*res));
+	dax_region->pfn_flags = pfn_flags;
+	kref_init(&dax_region->kref);
+	dax_region->id = region_id;
+	dax_region->align = align;
+	dax_region->dev = parent;
+	if (sysfs_create_groups(&parent->kobj, dax_region_attribute_groups)) {
+		kfree(dax_region);
+		return NULL;
+	}
+
+	kref_get(&dax_region->kref);
+	if (devm_add_action_or_reset(parent, dax_region_unregister, dax_region))
+		return NULL;
+	return dax_region;
+}
+EXPORT_SYMBOL_GPL(alloc_dax_region);
+
+static ssize_t size_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+	unsigned long long size = resource_size(&dev_dax->region->res);
+
+	return sprintf(buf, "%llu\n", size);
+}
+static DEVICE_ATTR_RO(size);
+
+static struct attribute *dev_dax_attributes[] = {
+	&dev_attr_size.attr,
+	NULL,
+};
+
+static const struct attribute_group dev_dax_attribute_group = {
+	.attrs = dev_dax_attributes,
+};
+
+const struct attribute_group *dax_attribute_groups[] = {
+	&dev_dax_attribute_group,
+	NULL,
+};
+EXPORT_SYMBOL_GPL(dax_attribute_groups);
+
+void kill_dev_dax(struct dev_dax *dev_dax)
+{
+	struct dax_device *dax_dev = dev_dax->dax_dev;
+	struct inode *inode = dax_inode(dax_dev);
+
+	kill_dax(dax_dev);
+	unmap_mapping_range(inode->i_mapping, 0, 0, 1);
+}
+EXPORT_SYMBOL_GPL(kill_dev_dax);
+
+void unregister_dev_dax(void *dev)
+{
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+	struct dax_device *dax_dev = dev_dax->dax_dev;
+	struct inode *inode = dax_inode(dax_dev);
+	struct cdev *cdev = inode->i_cdev;
+
+	dev_dbg(dev, "trace\n");
+
+	kill_dev_dax(dev_dax);
+	cdev_device_del(cdev, dev);
+	put_device(dev);
+}
+EXPORT_SYMBOL_GPL(unregister_dev_dax);
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
new file mode 100644
index 000000000000..840865aa69e8
--- /dev/null
+++ b/drivers/dax/bus.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2016 - 2018 Intel Corporation. All rights reserved. */
+#ifndef __DAX_BUS_H__
+#define __DAX_BUS_H__
+struct device;
+struct dev_dax;
+struct resource;
+struct dax_device;
+struct dax_region;
+void dax_region_put(struct dax_region *dax_region);
+struct dax_region *alloc_dax_region(struct device *parent, int region_id,
+		struct resource *res, unsigned int align, unsigned long flags);
+struct dev_dax *devm_create_dev_dax(struct dax_region *dax_region, int id);
+void kill_dev_dax(struct dev_dax *dev_dax);
+#endif /* __DAX_BUS_H__ */
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index dbd077653b5c..620c3f4eefe7 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -16,6 +16,15 @@
 #include <linux/device.h>
 #include <linux/cdev.h>
 
+/* private routines between core files */
+struct dax_device;
+struct dax_device *inode_dax(struct inode *inode);
+struct inode *dax_inode(struct dax_device *dax_dev);
+
+/* temporary until devm_create_dax_dev moves to bus.c */
+extern const struct attribute_group *dax_attribute_groups[];
+void unregister_dev_dax(void *dev);
+
 /**
  * struct dax_region - mapping infrastructure for dax devices
  * @id: kernel-wide unique region for a memory range
@@ -45,4 +54,9 @@ struct dev_dax {
 	struct dax_device *dax_dev;
 	struct device dev;
 };
+
+static inline struct dev_dax *to_dev_dax(struct device *dev)
+{
+	return container_of(dev, struct dev_dax, dev);
+}
 #endif
diff --git a/drivers/dax/dax.h b/drivers/dax/dax.h
deleted file mode 100644
index f9e5feea742c..000000000000
--- a/drivers/dax/dax.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * Copyright(c) 2016 - 2017 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
-#ifndef __DAX_H__
-#define __DAX_H__
-struct dax_device;
-struct dax_device *inode_dax(struct inode *inode);
-struct inode *dax_inode(struct dax_device *dax_dev);
-#endif /* __DAX_H__ */
diff --git a/drivers/dax/device-dax.h b/drivers/dax/device-dax.h
deleted file mode 100644
index e9be99584b92..000000000000
--- a/drivers/dax/device-dax.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * Copyright(c) 2016 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
-#ifndef __DEVICE_DAX_H__
-#define __DEVICE_DAX_H__
-struct device;
-struct dev_dax;
-struct resource;
-struct dax_region;
-void dax_region_put(struct dax_region *dax_region);
-struct dax_region *alloc_dax_region(struct device *parent, int region_id,
-		struct resource *res, unsigned int align, unsigned long flags);
-struct dev_dax *devm_create_dev_dax(struct dax_region *dax_region, int id);
-#endif /* __DEVICE_DAX_H__ */
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index db12e24b8005..1fc375783e0b 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2016 - 2017 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2016-2018 Intel Corporation. All rights reserved. */
 #include <linux/pagemap.h>
 #include <linux/module.h>
 #include <linux/device.h>
@@ -21,156 +11,10 @@
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include "dax-private.h"
-#include "dax.h"
+#include "bus.h"
 
 static struct class *dax_class;
 
-/*
- * Rely on the fact that drvdata is set before the attributes are
- * registered, and that the attributes are unregistered before drvdata
- * is cleared to assume that drvdata is always valid.
- */
-static ssize_t id_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct dax_region *dax_region = dev_get_drvdata(dev);
-
-	return sprintf(buf, "%d\n", dax_region->id);
-}
-static DEVICE_ATTR_RO(id);
-
-static ssize_t region_size_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct dax_region *dax_region = dev_get_drvdata(dev);
-
-	return sprintf(buf, "%llu\n", (unsigned long long)
-			resource_size(&dax_region->res));
-}
-static struct device_attribute dev_attr_region_size = __ATTR(size, 0444,
-		region_size_show, NULL);
-
-static ssize_t align_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct dax_region *dax_region = dev_get_drvdata(dev);
-
-	return sprintf(buf, "%u\n", dax_region->align);
-}
-static DEVICE_ATTR_RO(align);
-
-static struct attribute *dax_region_attributes[] = {
-	&dev_attr_region_size.attr,
-	&dev_attr_align.attr,
-	&dev_attr_id.attr,
-	NULL,
-};
-
-static const struct attribute_group dax_region_attribute_group = {
-	.name = "dax_region",
-	.attrs = dax_region_attributes,
-};
-
-static const struct attribute_group *dax_region_attribute_groups[] = {
-	&dax_region_attribute_group,
-	NULL,
-};
-
-static void dax_region_free(struct kref *kref)
-{
-	struct dax_region *dax_region;
-
-	dax_region = container_of(kref, struct dax_region, kref);
-	kfree(dax_region);
-}
-
-void dax_region_put(struct dax_region *dax_region)
-{
-	kref_put(&dax_region->kref, dax_region_free);
-}
-EXPORT_SYMBOL_GPL(dax_region_put);
-
-static void dax_region_unregister(void *region)
-{
-	struct dax_region *dax_region = region;
-
-	sysfs_remove_groups(&dax_region->dev->kobj,
-			dax_region_attribute_groups);
-	dax_region_put(dax_region);
-}
-
-struct dax_region *alloc_dax_region(struct device *parent, int region_id,
-		struct resource *res, unsigned int align,
-		unsigned long pfn_flags)
-{
-	struct dax_region *dax_region;
-
-	/*
-	 * The DAX core assumes that it can store its private data in
-	 * parent->driver_data. This WARN is a reminder / safeguard for
-	 * developers of device-dax drivers.
-	 */
-	if (dev_get_drvdata(parent)) {
-		dev_WARN(parent, "dax core failed to setup private data\n");
-		return NULL;
-	}
-
-	if (!IS_ALIGNED(res->start, align)
-			|| !IS_ALIGNED(resource_size(res), align))
-		return NULL;
-
-	dax_region = kzalloc(sizeof(*dax_region), GFP_KERNEL);
-	if (!dax_region)
-		return NULL;
-
-	dev_set_drvdata(parent, dax_region);
-	memcpy(&dax_region->res, res, sizeof(*res));
-	dax_region->pfn_flags = pfn_flags;
-	kref_init(&dax_region->kref);
-	dax_region->id = region_id;
-	dax_region->align = align;
-	dax_region->dev = parent;
-	if (sysfs_create_groups(&parent->kobj, dax_region_attribute_groups)) {
-		kfree(dax_region);
-		return NULL;
-	}
-
-	kref_get(&dax_region->kref);
-	if (devm_add_action_or_reset(parent, dax_region_unregister, dax_region))
-		return NULL;
-	return dax_region;
-}
-EXPORT_SYMBOL_GPL(alloc_dax_region);
-
-static struct dev_dax *to_dev_dax(struct device *dev)
-{
-	return container_of(dev, struct dev_dax, dev);
-}
-
-static ssize_t size_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct dev_dax *dev_dax = to_dev_dax(dev);
-	unsigned long long size = resource_size(&dev_dax->region->res);
-
-	return sprintf(buf, "%llu\n", size);
-}
-static DEVICE_ATTR_RO(size);
-
-static struct attribute *dev_dax_attributes[] = {
-	&dev_attr_size.attr,
-	NULL,
-};
-
-static const struct attribute_group dev_dax_attribute_group = {
-	.attrs = dev_dax_attributes,
-};
-
-static const struct attribute_group *dax_attribute_groups[] = {
-	&dev_dax_attribute_group,
-	NULL,
-};
-
 static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 		const char *func)
 {
@@ -571,29 +415,6 @@ static void dev_dax_release(struct device *dev)
 	kfree(dev_dax);
 }
 
-static void kill_dev_dax(struct dev_dax *dev_dax)
-{
-	struct dax_device *dax_dev = dev_dax->dax_dev;
-	struct inode *inode = dax_inode(dax_dev);
-
-	kill_dax(dax_dev);
-	unmap_mapping_range(inode->i_mapping, 0, 0, 1);
-}
-
-static void unregister_dev_dax(void *dev)
-{
-	struct dev_dax *dev_dax = to_dev_dax(dev);
-	struct dax_device *dax_dev = dev_dax->dax_dev;
-	struct inode *inode = dax_inode(dax_dev);
-	struct cdev *cdev = inode->i_cdev;
-
-	dev_dbg(dev, "trace\n");
-
-	kill_dev_dax(dev_dax);
-	cdev_device_del(cdev, dev);
-	put_device(dev);
-}
-
 struct dev_dax *devm_create_dev_dax(struct dax_region *dax_region, int id)
 {
 	struct device *parent = dax_region->dev;
diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index 23bc8ed40e84..c94f17e662bd 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -16,7 +16,7 @@
 #include <linux/pfn_t.h>
 #include "../nvdimm/pfn.h"
 #include "../nvdimm/nd.h"
-#include "device-dax.h"
+#include "bus.h"
 
 struct dax_pmem {
 	struct device *dev;
diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 6e928f37d084..0ecc1a2cf1cc 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -22,6 +22,7 @@
 #include <linux/uio.h>
 #include <linux/dax.h>
 #include <linux/fs.h>
+#include "dax-private.h"
 
 static dev_t dax_devt;
 DEFINE_STATIC_SRCU(dax_srcu);
diff --git a/tools/testing/nvdimm/Kbuild b/tools/testing/nvdimm/Kbuild
index 0392153a0009..bfc4d8e98452 100644
--- a/tools/testing/nvdimm/Kbuild
+++ b/tools/testing/nvdimm/Kbuild
@@ -55,6 +55,7 @@ nd_e820-y := $(NVDIMM_SRC)/e820.o
 nd_e820-y += config_check.o
 
 dax-y := $(DAX_SRC)/super.o
+dax-y += $(DAX_SRC)/bus.o
 dax-y += config_check.o
 
 device_dax-y := $(DAX_SRC)/device.o

