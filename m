Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbeEOURM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 16:17:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60464 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751149AbeEOURK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 16:17:10 -0400
Subject: [PATCH] vfio/mdev: Check globally for duplicate devices
From: Alex Williamson <alex.williamson@redhat.com>
To: kwankhede@nvidia.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com
Date: Tue, 15 May 2018 14:17:04 -0600
Message-ID: <20180515195947.12163.49363.stgit@gimli.home>
User-Agent: StGit/0.18-102-gdf9f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we create an mdev device, we check for duplicates against the
parent device and return -EEXIST if found, but the mdev device
namespace is global since we'll link all devices from the bus.  We do
catch this later in sysfs_do_create_link_sd() to return -EEXIST, but
with it comes a kernel warning and stack trace for trying to create
duplicate sysfs links, which makes it an undesirable response.

Therefore we should really be looking for duplicates across all mdev
parent devices, or as implemented here, against our mdev device list.

Notably, mdev_parent.lock really only seems to be serializing device
creation and removal per parent.  I'm not sure if this is necessary,
mdev vendor drivers could easily provide this serialization if it
is required, but a side-effect of holding the mdev_list_lock to
protect the namespace is actually greater serialization across the
create and remove paths, so mdev_parent.lock is removed.  If we can
show that vendor drivers handle the create/remove paths themselves,
perhaps we can refine the locking granularity.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/mdev/mdev_core.c    |   79 ++++++++++----------------------------
 drivers/vfio/mdev/mdev_private.h |    1 
 2 files changed, 20 insertions(+), 60 deletions(-)

diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index 126991046eb7..3d8898a2baaf 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -66,34 +66,6 @@ uuid_le mdev_uuid(struct mdev_device *mdev)
 }
 EXPORT_SYMBOL(mdev_uuid);
 
-static int _find_mdev_device(struct device *dev, void *data)
-{
-	struct mdev_device *mdev;
-
-	if (!dev_is_mdev(dev))
-		return 0;
-
-	mdev = to_mdev_device(dev);
-
-	if (uuid_le_cmp(mdev->uuid, *(uuid_le *)data) == 0)
-		return 1;
-
-	return 0;
-}
-
-static bool mdev_device_exist(struct mdev_parent *parent, uuid_le uuid)
-{
-	struct device *dev;
-
-	dev = device_find_child(parent->dev, &uuid, _find_mdev_device);
-	if (dev) {
-		put_device(dev);
-		return true;
-	}
-
-	return false;
-}
-
 /* Should be called holding parent_list_lock */
 static struct mdev_parent *__find_parent_device(struct device *dev)
 {
@@ -221,7 +193,6 @@ int mdev_register_device(struct device *dev, const struct mdev_parent_ops *ops)
 	}
 
 	kref_init(&parent->ref);
-	mutex_init(&parent->lock);
 
 	parent->dev = dev;
 	parent->ops = ops;
@@ -304,7 +275,7 @@ static void mdev_device_release(struct device *dev)
 int mdev_device_create(struct kobject *kobj, struct device *dev, uuid_le uuid)
 {
 	int ret;
-	struct mdev_device *mdev;
+	struct mdev_device *mdev, *tmp;
 	struct mdev_parent *parent;
 	struct mdev_type *type = to_mdev_type(kobj);
 
@@ -312,12 +283,14 @@ int mdev_device_create(struct kobject *kobj, struct device *dev, uuid_le uuid)
 	if (!parent)
 		return -EINVAL;
 
-	mutex_lock(&parent->lock);
+	mutex_lock(&mdev_list_lock);
 
 	/* Check for duplicate */
-	if (mdev_device_exist(parent, uuid)) {
-		ret = -EEXIST;
-		goto create_err;
+	list_for_each_entry(tmp, &mdev_list, next) {
+		if (!uuid_le_cmp(tmp->uuid, uuid)) {
+			ret = -EEXIST;
+			goto create_err;
+		}
 	}
 
 	mdev = kzalloc(sizeof(*mdev), GFP_KERNEL);
@@ -354,9 +327,6 @@ int mdev_device_create(struct kobject *kobj, struct device *dev, uuid_le uuid)
 	mdev->type_kobj = kobj;
 	dev_dbg(&mdev->dev, "MDEV: created\n");
 
-	mutex_unlock(&parent->lock);
-
-	mutex_lock(&mdev_list_lock);
 	list_add(&mdev->next, &mdev_list);
 	mutex_unlock(&mdev_list_lock);
 
@@ -366,7 +336,7 @@ int mdev_device_create(struct kobject *kobj, struct device *dev, uuid_le uuid)
 	device_unregister(&mdev->dev);
 
 create_err:
-	mutex_unlock(&parent->lock);
+	mutex_unlock(&mdev_list_lock);
 	mdev_put_parent(parent);
 	return ret;
 }
@@ -376,12 +346,13 @@ int mdev_device_remove(struct device *dev, bool force_remove)
 	struct mdev_device *mdev, *tmp;
 	struct mdev_parent *parent;
 	struct mdev_type *type;
-	int ret;
+	int ret = 0;
 	bool found = false;
 
 	mdev = to_mdev_device(dev);
 
 	mutex_lock(&mdev_list_lock);
+
 	list_for_each_entry(tmp, &mdev_list, next) {
 		if (tmp == mdev) {
 			found = true;
@@ -389,35 +360,25 @@ int mdev_device_remove(struct device *dev, bool force_remove)
 		}
 	}
 
-	if (found)
-		list_del(&mdev->next);
-
-	mutex_unlock(&mdev_list_lock);
-
-	if (!found)
-		return -ENODEV;
+	if (!found) {
+		ret = -ENODEV;
+		goto out;
+	}
 
 	type = to_mdev_type(mdev->type_kobj);
 	parent = mdev->parent;
-	mutex_lock(&parent->lock);
 
 	ret = mdev_device_remove_ops(mdev, force_remove);
-	if (ret) {
-		mutex_unlock(&parent->lock);
-
-		mutex_lock(&mdev_list_lock);
-		list_add(&mdev->next, &mdev_list);
-		mutex_unlock(&mdev_list_lock);
-
-		return ret;
-	}
+	if (ret)
+		goto out;
 
+	list_del(&mdev->next);
 	mdev_remove_sysfs_files(dev, type);
 	device_unregister(dev);
-	mutex_unlock(&parent->lock);
 	mdev_put_parent(parent);
-
-	return 0;
+out:
+	mutex_unlock(&mdev_list_lock);
+	return ret;
 }
 
 static int __init mdev_init(void)
diff --git a/drivers/vfio/mdev/mdev_private.h b/drivers/vfio/mdev/mdev_private.h
index a9cefd70a705..85bb268c91be 100644
--- a/drivers/vfio/mdev/mdev_private.h
+++ b/drivers/vfio/mdev/mdev_private.h
@@ -20,7 +20,6 @@ struct mdev_parent {
 	struct device *dev;
 	const struct mdev_parent_ops *ops;
 	struct kref ref;
-	struct mutex lock;
 	struct list_head next;
 	struct kset *mdev_types_kset;
 	struct list_head type_list;
