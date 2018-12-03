Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6FEC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD92620850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD92620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbeLCXfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:35:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbeLCXfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:35:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8D28530024C8;
        Mon,  3 Dec 2018 23:35:51 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-120-188.rdu2.redhat.com [10.10.120.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49B55600C1;
        Mon,  3 Dec 2018 23:35:45 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Haggai Eran <haggaie@mellanox.com>,
        Balbir Singh <balbirs@au1.ibm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felix Kuehling <felix.kuehling@amd.com>,
        Philip Yang <Philip.Yang@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Paul Blinzer <Paul.Blinzer@amd.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Vivek Kini <vkini@nvidia.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Airlie <airlied@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [RFC PATCH 03/14] mm/hms: add target memory to heterogeneous memory system infrastructure
Date:   Mon,  3 Dec 2018 18:34:58 -0500
Message-Id: <20181203233509.20671-4-jglisse@redhat.com>
In-Reply-To: <20181203233509.20671-1-jglisse@redhat.com>
References: <20181203233509.20671-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 03 Dec 2018 23:35:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

A target is some kind of memory, it can be regular main memory or some
more specialize memory like CPU's HBM (High Bandwidth Memory) or some
device's memory.

Some target memory might not be accessible by all initiators (anything
that can trigger memory access). For instance some device memory might
not be accessible by CPU. This is truely heterogeneous systems at its
heart.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Haggai Eran <haggaie@mellanox.com>
Cc: Balbir Singh <balbirs@au1.ibm.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Philip Yang <Philip.Yang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Paul Blinzer <Paul.Blinzer@amd.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Mark Hairgrove <mhairgrove@nvidia.com>
Cc: Vivek Kini <vkini@nvidia.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
---
 drivers/base/Makefile     |   2 +-
 drivers/base/hms-target.c | 193 ++++++++++++++++++++++++++++++++++++++
 include/linux/hms.h       |  43 ++++++++-
 3 files changed, 235 insertions(+), 3 deletions(-)
 create mode 100644 drivers/base/hms-target.c

diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 92ebfacbf0dc..8e8092145f18 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -12,7 +12,7 @@ obj-y			+= power/
 obj-$(CONFIG_ISA_BUS_API)	+= isa.o
 obj-y				+= firmware_loader/
 obj-$(CONFIG_NUMA)	+= node.o
-obj-$(CONFIG_HMS)	+= hms.o
+obj-$(CONFIG_HMS)	+= hms.o hms-target.o
 obj-$(CONFIG_MEMORY_HOTPLUG_SPARSE) += memory.o
 ifeq ($(CONFIG_SYSFS),y)
 obj-$(CONFIG_MODULES)	+= module.o
diff --git a/drivers/base/hms-target.c b/drivers/base/hms-target.c
new file mode 100644
index 000000000000..ce28dfe089a3
--- /dev/null
+++ b/drivers/base/hms-target.c
@@ -0,0 +1,193 @@
+/*
+ * Copyright 2018 Red Hat Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Authors:
+ * Jérôme Glisse <jglisse@redhat.com>
+ */
+/* Heterogeneous memory system (HMS) see Documentation/vm/hms.rst */
+#include <linux/capability.h>
+#include <linux/topology.h>
+#include <linux/uaccess.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/hms.h>
+
+
+static DEFINE_MUTEX(hms_target_mutex);
+
+
+static inline struct hms_target *hms_object_to_target(struct hms_object *object)
+{
+	if (object == NULL)
+		return NULL;
+
+	if (object->type != HMS_TARGET)
+		return NULL;
+	return container_of(object, struct hms_target, object);
+}
+
+static inline struct hms_target *device_to_hms_target(struct device *device)
+{
+	if (device == NULL)
+		return NULL;
+
+	return hms_object_to_target(to_hms_object(device));
+}
+
+struct hms_target *hms_target_find_locked(unsigned uid)
+{
+	struct hms_object *object = hms_object_find_locked(uid);
+	struct hms_target *target;
+
+	target = hms_object_to_target(object);
+	if (target)
+		return target;
+	hms_object_put(object);
+	return NULL;
+}
+
+struct hms_target *hms_target_find(unsigned uid)
+{
+	struct hms_object *object = hms_object_find(uid);
+	struct hms_target *target;
+
+	target = hms_object_to_target(object);
+	if (target)
+		return target;
+	hms_object_put(object);
+	return NULL;
+}
+
+static void hms_target_release(struct device *device)
+{
+	struct hms_target *target = device_to_hms_target(device);
+
+	hms_object_release(&target->object);
+	kfree(target);
+}
+
+static ssize_t hms_target_show_size(struct device *device,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct hms_target *target = device_to_hms_target(device);
+
+	if (target == NULL)
+		return -EINVAL;
+
+	return sprintf(buf, "%ld\n", target->size);
+}
+
+static ssize_t hms_target_show_nid(struct device *device,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct hms_target *target = device_to_hms_target(device);
+
+	if (target == NULL)
+		return -EINVAL;
+
+	return sprintf(buf, "%d\n", target->nid);
+}
+
+static ssize_t hms_target_show_uid(struct device *device,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct hms_target *target = device_to_hms_target(device);
+
+	if (target == NULL)
+		return -EINVAL;
+
+	return sprintf(buf, "%d\n", target->object.uid);
+}
+
+static DEVICE_ATTR(size, 0444, hms_target_show_size, NULL);
+static DEVICE_ATTR(nid, 0444, hms_target_show_nid, NULL);
+static DEVICE_ATTR(uid, 0444, hms_target_show_uid, NULL);
+
+static struct attribute *hms_target_attrs[] = {
+	&dev_attr_size.attr,
+	&dev_attr_nid.attr,
+	&dev_attr_uid.attr,
+	NULL
+};
+
+static struct attribute_group hms_target_attr_group = {
+	.attrs = hms_target_attrs,
+};
+
+static const struct attribute_group *hms_target_attr_groups[] = {
+	&hms_target_attr_group,
+	NULL,
+};
+
+void hms_target_register(struct hms_target **targetp, struct device *parent,
+			 int nid, const struct hms_target_hbind *hbind,
+			 unsigned long size, unsigned version)
+{
+	struct hms_target *target;
+
+	*targetp = NULL;
+	target = kzalloc(sizeof(*target), GFP_KERNEL);
+	if (target == NULL)
+		return;
+
+	target->nid = nid;
+	target->size = size;
+	target->hbind = hbind;
+
+	if (hms_object_init(&target->object, parent, HMS_TARGET, version,
+			    hms_target_release, hms_target_attr_groups)) {
+		kfree(target);
+		target = NULL;
+	}
+
+	*targetp = target;
+}
+EXPORT_SYMBOL(hms_target_register);
+
+void hms_target_add_memory(struct hms_target *target, unsigned long size)
+{
+	if (target) {
+		mutex_lock(&hms_target_mutex);
+		target->size += size;
+		mutex_unlock(&hms_target_mutex);
+	}
+}
+EXPORT_SYMBOL(hms_target_add_memory);
+
+void hms_target_remove_memory(struct hms_target *target, unsigned long size)
+{
+	if (target) {
+		mutex_lock(&hms_target_mutex);
+		target->size = size < target->size ? target->size - size : 0;
+		mutex_unlock(&hms_target_mutex);
+	}
+}
+EXPORT_SYMBOL(hms_target_remove_memory);
+
+void hms_target_unregister(struct hms_target **targetp)
+{
+	struct hms_target *target = *targetp;
+
+	*targetp = NULL;
+	if (target == NULL)
+		return;
+
+	hms_object_unregister(&target->object);
+}
+EXPORT_SYMBOL(hms_target_unregister);
diff --git a/include/linux/hms.h b/include/linux/hms.h
index 1ab288df0158..0568fdf6d479 100644
--- a/include/linux/hms.h
+++ b/include/linux/hms.h
@@ -17,10 +17,21 @@
 /* Heterogeneous memory system (HMS) see Documentation/vm/hms.rst */
 #ifndef HMS_H
 #define HMS_H
-#if IS_ENABLED(CONFIG_HMS)
-
 
 #include <linux/device.h>
+#include <linux/types.h>
+
+
+struct hms_target;
+
+struct hms_target_hbind {
+	int (*migrate)(struct hms_target *target, struct mm_struct *mm,
+		       unsigned long start, unsigned long end,
+		       unsigned natoms, uint32_t *atoms);
+};
+
+
+#if IS_ENABLED(CONFIG_HMS)
 
 
 #define to_hms_object(device) container_of(device, struct hms_object, device)
@@ -56,12 +67,40 @@ struct hms_object *hms_object_find_locked(unsigned uid);
 struct hms_object *hms_object_find(unsigned uid);
 
 
+struct hms_target {
+	const struct hms_target_hbind *hbind;
+	struct hms_object object;
+	unsigned long size;
+	void *private;
+	int nid;
+};
+
+void hms_target_add_memory(struct hms_target *target, unsigned long size);
+void hms_target_remove_memory(struct hms_target *target, unsigned long size);
+void hms_target_register(struct hms_target **targetp, struct device *parent,
+			 int nid, const struct hms_target_hbind *hbind,
+			 unsigned long size, unsigned version);
+void hms_target_unregister(struct hms_target **targetp);
+struct hms_target *hms_target_find(unsigned uid);
+
+static inline void hms_target_put(struct hms_target *target)
+{
+	hms_object_put(&target->object);
+}
+
+
 int hms_init(void);
 
 
 #else /* IS_ENABLED(CONFIG_HMS) */
 
 
+#define hms_target_add_memory(target, size)
+#define hms_target_remove_memory(target, size)
+#define hms_target_register(targetp, nid, size)
+#define hms_target_unregister(targetp)
+
+
 static inline int hms_init(void)
 {
 	return 0;
-- 
2.17.2

