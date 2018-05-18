Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752219AbeERTKm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 15:10:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751606AbeERTKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 15:10:38 -0400
Subject: [PATCH v4 2/2] vfio/mdev: Re-order sysfs attribute creation
From: Alex Williamson <alex.williamson@redhat.com>
To: kwankhede@nvidia.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com
Date: Fri, 18 May 2018 13:10:35 -0600
Message-ID: <20180518191035.3187.77957.stgit@gimli.home>
In-Reply-To: <20180518190145.3187.7620.stgit@gimli.home>
References: <20180518190145.3187.7620.stgit@gimli.home>
User-Agent: StGit/0.18-102-gdf9f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There exists a gap at the end of mdev_device_create() where the device
is visible to userspace, but we're not yet ready to handle removal, as
triggered through the 'remove' attribute.  We handle this properly in
mdev_device_remove() with an -EAGAIN return, but we can marginally
reduce this gap by adding this attribute as a final step of our sysfs
setup.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/mdev/mdev_sysfs.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/mdev/mdev_sysfs.c b/drivers/vfio/mdev/mdev_sysfs.c
index 802df210929b..249472f05509 100644
--- a/drivers/vfio/mdev/mdev_sysfs.c
+++ b/drivers/vfio/mdev/mdev_sysfs.c
@@ -257,24 +257,24 @@ int  mdev_create_sysfs_files(struct device *dev, struct mdev_type *type)
 {
 	int ret;
 
-	ret = sysfs_create_files(&dev->kobj, mdev_device_attrs);
-	if (ret)
-		return ret;
-
 	ret = sysfs_create_link(type->devices_kobj, &dev->kobj, dev_name(dev));
 	if (ret)
-		goto device_link_failed;
+		return ret;
 
 	ret = sysfs_create_link(&dev->kobj, &type->kobj, "mdev_type");
 	if (ret)
 		goto type_link_failed;
 
+	ret = sysfs_create_files(&dev->kobj, mdev_device_attrs);
+	if (ret)
+		goto create_files_failed;
+
 	return ret;
 
+create_files_failed:
+	sysfs_remove_link(&dev->kobj, "mdev_type");
 type_link_failed:
 	sysfs_remove_link(type->devices_kobj, dev_name(dev));
-device_link_failed:
-	sysfs_remove_files(&dev->kobj, mdev_device_attrs);
 	return ret;
 }
 
