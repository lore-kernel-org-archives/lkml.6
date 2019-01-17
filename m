Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B92C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 05:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C62720657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 05:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbfAQF5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 00:57:41 -0500
Received: from mga12.intel.com ([192.55.52.136]:50398 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbfAQF5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 00:57:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 21:57:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,488,1539673200"; 
   d="scan'208";a="117359345"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.37])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jan 2019 21:57:40 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH] driver core: move device->knode_class to device_private
Date:   Thu, 17 Jan 2019 13:57:19 +0800
Message-Id: <20190117055719.6161-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the description of struct device_private says, it stores data which
is private to driver core. And it already has similar fields like:
knode_parent, knode_driver, knode_driver and knode_bus. This look it is
more proper to put knode_class together with those fields to make it
private to driver core.

This patch move device->knode_class to device_private to make it comply
with code convention.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 drivers/base/base.h    |  4 ++++
 drivers/base/class.c   | 12 ++++++++----
 drivers/base/core.c    |  4 ++--
 include/linux/device.h |  1 -
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 7a419a7a6235..37329a668935 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -60,6 +60,7 @@ struct driver_private {
  * @knode_parent - node in sibling list
  * @knode_driver - node in driver list
  * @knode_bus - node in bus list
+ * @knode_class - node in class list
  * @deferred_probe - entry in deferred_probe_list which is used to retry the
  *	binding of drivers which were unable to get all the resources needed by
  *	the device; typically because it depends on another driver getting
@@ -74,6 +75,7 @@ struct device_private {
 	struct klist_node knode_parent;
 	struct klist_node knode_driver;
 	struct klist_node knode_bus;
+	struct klist_node knode_class;
 	struct list_head deferred_probe;
 	struct device *device;
 };
@@ -83,6 +85,8 @@ struct device_private {
 	container_of(obj, struct device_private, knode_driver)
 #define to_device_private_bus(obj)	\
 	container_of(obj, struct device_private, knode_bus)
+#define to_device_private_class(obj)	\
+	container_of(obj, struct device_private, knode_class)
 
 /* initialisation functions */
 extern int devices_init(void);
diff --git a/drivers/base/class.c b/drivers/base/class.c
index 54def4e02f00..df7fde599407 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -119,14 +119,16 @@ static void class_put(struct class *cls)
 
 static void klist_class_dev_get(struct klist_node *n)
 {
-	struct device *dev = container_of(n, struct device, knode_class);
+	struct device_private *p = to_device_private_class(n);
+	struct device *dev = p->device;
 
 	get_device(dev);
 }
 
 static void klist_class_dev_put(struct klist_node *n)
 {
-	struct device *dev = container_of(n, struct device, knode_class);
+	struct device_private *p = to_device_private_class(n);
+	struct device *dev = p->device;
 
 	put_device(dev);
 }
@@ -277,7 +279,7 @@ void class_dev_iter_init(struct class_dev_iter *iter, struct class *class,
 	struct klist_node *start_knode = NULL;
 
 	if (start)
-		start_knode = &start->knode_class;
+		start_knode = &start->p->knode_class;
 	klist_iter_init_node(&class->p->klist_devices, &iter->ki, start_knode);
 	iter->type = type;
 }
@@ -298,13 +300,15 @@ EXPORT_SYMBOL_GPL(class_dev_iter_init);
 struct device *class_dev_iter_next(struct class_dev_iter *iter)
 {
 	struct klist_node *knode;
+	struct device_private *p;
 	struct device *dev;
 
 	while (1) {
 		knode = klist_next(&iter->ki);
 		if (!knode)
 			return NULL;
-		dev = container_of(knode, struct device, knode_class);
+		p = to_device_private_class(knode);
+		dev = p->device;
 		if (!iter->type || iter->type == dev->type)
 			return dev;
 	}
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 04bbcd779e11..a624d27d11c0 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1932,7 +1932,7 @@ int device_add(struct device *dev)
 	if (dev->class) {
 		mutex_lock(&dev->class->p->mutex);
 		/* tie the class to the device */
-		klist_add_tail(&dev->knode_class,
+		klist_add_tail(&dev->p->knode_class,
 			       &dev->class->p->klist_devices);
 
 		/* notify any interfaces that the device is here */
@@ -2069,7 +2069,7 @@ void device_del(struct device *dev)
 			if (class_intf->remove_dev)
 				class_intf->remove_dev(dev, class_intf);
 		/* remove the device from the class list */
-		klist_del(&dev->knode_class);
+		klist_del(&dev->p->knode_class);
 		mutex_unlock(&dev->class->p->mutex);
 	}
 	device_remove_file(dev, &dev_attr_uevent);
diff --git a/include/linux/device.h b/include/linux/device.h
index 1b25c7a43f4c..040e97669f94 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1035,7 +1035,6 @@ struct device {
 	spinlock_t		devres_lock;
 	struct list_head	devres_head;
 
-	struct klist_node	knode_class;
 	struct class		*class;
 	const struct attribute_group **groups;	/* optional groups */
 
-- 
2.19.1

