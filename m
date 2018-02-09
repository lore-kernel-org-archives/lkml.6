Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751179AbeBIK1W (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 05:27:22 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48466 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751024AbeBIK1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 05:27:20 -0500
From: Cornelia Huck <cohuck@redhat.com>
To: kwankhede@nvidia.com, alex.williamson@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        cordius.wu@huawei.com, eskultet@redhat.com,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH RFC] vfio/mdev: delay uevent after initialization complete
Date: Fri,  9 Feb 2018 11:27:16 +0100
Message-Id: <20180209102716.32253-1-cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The registration code first registers the mdev device, and then
proceeds to populate sysfs. An userspace application that listens
for the ADD uevent is therefore likely to look for sysfs entries
that have not yet been created.

The canonical way to fix this is to use attribute groups that are
registered by the driver core before it sends the ADD uevent; I
unfortunately did not find a way to make this work in this case,
though.

An alternative approach is to suppress uevents before we register
with the core and generate the ADD uevent ourselves after the
sysfs infrastructure is in place.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---

This feels like a band-aid, but I can't figure out how to handle creating
attribute groups when there's a callback in the parent involved.

This should address the issue with libvirt's processing of mdevs raised in
https://www.redhat.com/archives/libvir-list/2018-February/msg00023.html
- although libvirt will still need to deal with older kernels, of course.

Best to consider this an untested patch :)

---
 drivers/vfio/mdev/mdev_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index 126991046eb7..942e880d8e7f 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -335,6 +335,8 @@ int mdev_device_create(struct kobject *kobj, struct device *dev, uuid_le uuid)
 	mdev->dev.release = mdev_device_release;
 	dev_set_name(&mdev->dev, "%pUl", uuid.b);
 
+	/* don't notify userspace until we're ready */
+	dev_set_uevent_suppress(&mdev->dev, 1);
 	ret = device_register(&mdev->dev);
 	if (ret) {
 		put_device(&mdev->dev);
@@ -350,6 +352,9 @@ int mdev_device_create(struct kobject *kobj, struct device *dev, uuid_le uuid)
 		mdev_device_remove_ops(mdev, true);
 		goto create_failed;
 	}
+	/* all done, notify userspace */
+	dev_set_uevent_suppress(&mdev->dev, 0);
+	kobject_uevent(&mdev->dev.kobj, KOBJ_ADD);
 
 	mdev->type_kobj = kobj;
 	dev_dbg(&mdev->dev, "MDEV: created\n");
@@ -363,6 +368,10 @@ int mdev_device_create(struct kobject *kobj, struct device *dev, uuid_le uuid)
 	return ret;
 
 create_failed:
+	/*
+	 * If we reach this, uevents are still suppressed for mdev->dev,
+	 * so we don't get a KOBJ_DEL uevent without a previous KOBJ_ADD.
+	 */
 	device_unregister(&mdev->dev);
 
 create_err:
-- 
2.13.6
