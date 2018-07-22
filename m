Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEE9C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 06:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6187720874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 06:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6187720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbeGVHHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 03:07:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:37222 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728738AbeGVHHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 03:07:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jul 2018 23:11:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,388,1526367600"; 
   d="scan'208";a="218015939"
Received: from allen-box.sh.intel.com ([10.239.48.172])
  by orsmga004.jf.intel.com with ESMTP; 21 Jul 2018 23:11:31 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        yi.y.sun@intel.com, peterx@redhat.com,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [RFC PATCH 08/10] vfio/mdev: Set iommu ops for mdev bus
Date:   Sun, 22 Jul 2018 14:09:31 +0800
Message-Id: <1532239773-15325-9-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This sets the iommu ops for the mdev bus with iommu_set_bus().
With the iommu ops setting, a mediated device might be isolated
and protected by an IOMMU unit.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/vfio/mdev/mdev_core.c   |  9 ++++++++-
 drivers/vfio/mdev/mdev_driver.c | 10 ++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index 0212f0e..d8f19ba 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -16,6 +16,7 @@
 #include <linux/uuid.h>
 #include <linux/sysfs.h>
 #include <linux/mdev.h>
+#include <linux/iommu.h>
 
 #include "mdev_private.h"
 
@@ -392,7 +393,13 @@ int mdev_device_remove(struct device *dev, bool force_remove)
 
 static int __init mdev_init(void)
 {
-	return mdev_bus_register();
+	int ret;
+
+	ret = mdev_bus_register();
+	if (!ret)
+		iommu_set_bus(&mdev_bus_type);
+
+	return ret;
 }
 
 static void __exit mdev_exit(void)
diff --git a/drivers/vfio/mdev/mdev_driver.c b/drivers/vfio/mdev/mdev_driver.c
index 6f0391f..76ac9e6 100644
--- a/drivers/vfio/mdev/mdev_driver.c
+++ b/drivers/vfio/mdev/mdev_driver.c
@@ -21,6 +21,13 @@ static int mdev_attach_iommu(struct mdev_device *mdev)
 	int ret;
 	struct iommu_group *group;
 
+	/*
+	 * If iommu_ops is set for bus, add_device() will allocate
+	 * a group and add the device in the group.
+	 */
+	if (iommu_present(mdev->dev.bus))
+		return 0;
+
 	group = iommu_group_alloc();
 	if (IS_ERR(group))
 		return PTR_ERR(group);
@@ -36,6 +43,9 @@ static int mdev_attach_iommu(struct mdev_device *mdev)
 
 static void mdev_detach_iommu(struct mdev_device *mdev)
 {
+	if (iommu_present(mdev->dev.bus))
+		return;
+
 	iommu_group_remove_device(&mdev->dev);
 	dev_info(&mdev->dev, "MDEV: detaching iommu\n");
 }
-- 
2.7.4

