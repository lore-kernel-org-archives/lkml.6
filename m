Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCB8ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7164A20821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7164A20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbeJaMVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 08:21:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:62080 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728773AbeJaMVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 08:21:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 20:25:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,447,1534834800"; 
   d="scan'208";a="100188956"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga002.fm.intel.com with ESMTP; 30 Oct 2018 20:25:14 -0700
Subject: [PATCH 7/8] device-dax: Add support for a dax override driver
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com
Date:   Tue, 30 Oct 2018 20:13:26 -0700
Message-ID: <154095560594.3271337.11620109886861134971.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Introduce the 'new_id' concept for enabling a custom device-driver attach
policy for dax-bus drivers. The intended use is to have a mechanism for
hot-plugging device-dax ranges into the page allocator on-demand. With
this in place the default policy of using device-dax for performance
differentiated memory can be overridden by user-space policy that can
arrange for the memory range to be managed as 'System RAM' with
user-defined NUMA and other performance attributes.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/bus.c    |  145 ++++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/dax/bus.h    |   10 +++
 drivers/dax/device.c |   11 ++--
 3 files changed, 156 insertions(+), 10 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 69aae2cbd45f..178d76504f79 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -2,11 +2,21 @@
 /* Copyright(c) 2017-2018 Intel Corporation. All rights reserved. */
 #include <linux/memremap.h>
 #include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/list.h>
 #include <linux/slab.h>
 #include <linux/dax.h>
 #include "dax-private.h"
 #include "bus.h"
 
+static DEFINE_MUTEX(dax_bus_lock);
+
+#define DAX_NAME_LEN 30
+struct dax_id {
+	struct list_head list;
+	char dev_name[DAX_NAME_LEN];
+};
+
 static int dax_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	/*
@@ -16,22 +26,115 @@ static int dax_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return add_uevent_var(env, "MODALIAS=" DAX_DEVICE_MODALIAS_FMT, 0);
 }
 
+static struct dax_device_driver *to_dax_drv(struct device_driver *drv)
+{
+	return container_of(drv, struct dax_device_driver, drv);
+}
+
+static struct dax_id *__dax_match_id(struct dax_device_driver *dax_drv,
+		const char *dev_name)
+{
+	struct dax_id *dax_id;
+
+	lockdep_assert_held(&dax_bus_lock);
+
+	list_for_each_entry(dax_id, &dax_drv->ids, list)
+		if (strcmp(dax_id->dev_name, dev_name) == 0)
+			return dax_id;
+	return NULL;
+}
+
+static int dax_match_id(struct dax_device_driver *dax_drv, struct device *dev)
+{
+	int match;
+
+	mutex_lock(&dax_bus_lock);
+	match = !!__dax_match_id(dax_drv, dev_name(dev));
+	mutex_unlock(&dax_bus_lock);
+
+	return match;
+}
+
+static ssize_t do_id_store(struct device_driver *drv, const char *buf,
+		size_t count, bool add)
+{
+	struct dax_device_driver *dax_drv = to_dax_drv(drv);
+	unsigned int region_id, id;
+	struct dax_id *dax_id;
+	ssize_t rc = count;
+	int fields;
+
+	fields = sscanf(buf, "dax%d.%d", &region_id, &id);
+	if (fields != 2)
+		return -EINVAL;
+
+	if (strlen(buf) + 1 > DAX_NAME_LEN)
+		return -EINVAL;
+
+	mutex_lock(&dax_bus_lock);
+	dax_id = __dax_match_id(dax_drv, buf);
+	if (!dax_id) {
+		if (add) {
+			dax_id = kzalloc(sizeof(*dax_id), GFP_KERNEL);
+			if (dax_id) {
+				strncpy(dax_id->dev_name, buf, DAX_NAME_LEN);
+				list_add(&dax_id->list, &dax_drv->ids);
+			} else
+				rc = -ENOMEM;
+		} else
+			/* nothing to remove */;
+	} else if (!add) {
+		list_del(&dax_id->list);
+		kfree(dax_id);
+	} else
+		/* dax_id already added */;
+	mutex_unlock(&dax_bus_lock);
+	return rc;
+}
+
+static ssize_t new_id_store(struct device_driver *drv, const char *buf,
+		size_t count)
+{
+	return do_id_store(drv, buf, count, true);
+}
+static DRIVER_ATTR_WO(new_id);
+
+
+static ssize_t remove_id_store(struct device_driver *drv, const char *buf,
+		size_t count)
+{
+	return do_id_store(drv, buf, count, false);
+}
+static DRIVER_ATTR_WO(remove_id);
+
+static struct attribute *dax_drv_attrs[] = {
+	&driver_attr_new_id.attr,
+	&driver_attr_remove_id.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(dax_drv);
+
 static int dax_bus_match(struct device *dev, struct device_driver *drv);
 
 static struct bus_type dax_bus_type = {
 	.name = "dax",
 	.uevent = dax_bus_uevent,
 	.match = dax_bus_match,
+	.drv_groups = dax_drv_groups,
 };
 
 static int dax_bus_match(struct device *dev, struct device_driver *drv)
 {
+	struct dax_device_driver *dax_drv = to_dax_drv(drv);
+
 	/*
-	 * The drivers that can register on the 'dax' bus are private to
-	 * drivers/dax/ so any device and driver on the bus always
-	 * match.
+	 * All but the 'device-dax' driver, which has 'match_always'
+	 * set, requires an exact id match.
 	 */
-	return 1;
+	if (dax_drv->match_always)
+		return 1;
+
+	return dax_match_id(dax_drv, dev);
 }
 
 /*
@@ -273,17 +376,49 @@ struct dev_dax *devm_create_dev_dax(struct dax_region *dax_region, int id,
 }
 EXPORT_SYMBOL_GPL(devm_create_dev_dax);
 
-int __dax_driver_register(struct device_driver *drv,
+static int match_always_count;
+
+int __dax_driver_register(struct dax_device_driver *dax_drv,
 		struct module *module, const char *mod_name)
 {
+	struct device_driver *drv = &dax_drv->drv;
+	int rc = 0;
+
+	INIT_LIST_HEAD(&dax_drv->ids);
 	drv->owner = module;
 	drv->name = mod_name;
 	drv->mod_name = mod_name;
 	drv->bus = &dax_bus_type;
+
+	/* there can only be one default driver */
+	mutex_lock(&dax_bus_lock);
+	match_always_count += dax_drv->match_always;
+	if (match_always_count > 1) {
+		match_always_count--;
+		WARN_ON(1);
+		rc = -EINVAL;
+	}
+	mutex_unlock(&dax_bus_lock);
+	if (rc)
+		return rc;
 	return driver_register(drv);
 }
 EXPORT_SYMBOL_GPL(__dax_driver_register);
 
+void dax_driver_unregister(struct dax_device_driver *dax_drv)
+{
+	struct dax_id *dax_id, *_id;
+
+	mutex_lock(&dax_bus_lock);
+	match_always_count -= dax_drv->match_always;
+	list_for_each_entry_safe(dax_id, _id, &dax_drv->ids, list) {
+		list_del(&dax_id->list);
+		kfree(dax_id);
+	}
+	mutex_unlock(&dax_bus_lock);
+}
+EXPORT_SYMBOL_GPL(dax_driver_unregister);
+
 int __init dax_bus_init(void)
 {
 	return bus_register(&dax_bus_type);
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index e08e0c394983..395ab812367c 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -12,10 +12,18 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 		struct resource *res, unsigned int align, unsigned long flags);
 struct dev_dax *devm_create_dev_dax(struct dax_region *dax_region, int id,
 		struct dev_pagemap *pgmap);
-int __dax_driver_register(struct device_driver *drv,
+
+struct dax_device_driver {
+	struct device_driver drv;
+	struct list_head ids;
+	int match_always;
+};
+
+int __dax_driver_register(struct dax_device_driver *dax_drv,
 		struct module *module, const char *mod_name);
 #define dax_driver_register(driver) \
 	__dax_driver_register(driver, THIS_MODULE, KBUILD_MODNAME)
+void dax_driver_unregister(struct dax_device_driver *dax_drv);
 void kill_dev_dax(struct dev_dax *dev_dax);
 
 /*
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 967bab097013..052aed3ab600 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -508,9 +508,12 @@ static int dev_dax_remove(struct device *dev)
 	return 0;
 }
 
-static struct device_driver device_dax_driver = {
-	.probe = dev_dax_probe,
-	.remove = dev_dax_remove,
+static struct dax_device_driver device_dax_driver = {
+	.drv = {
+		.probe = dev_dax_probe,
+		.remove = dev_dax_remove,
+	},
+	.match_always = 1,
 };
 
 static int __init dax_init(void)
@@ -520,7 +523,7 @@ static int __init dax_init(void)
 
 static void __exit dax_exit(void)
 {
-	driver_unregister(&device_dax_driver);
+	dax_driver_unregister(&device_dax_driver);
 }
 
 MODULE_AUTHOR("Intel Corporation");

