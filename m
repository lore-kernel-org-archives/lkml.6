Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD6AC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 06:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71DA20874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 06:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71DA20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbeGVHHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 03:07:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:12836 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729585AbeGVHHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 03:07:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jul 2018 23:11:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,388,1526367600"; 
   d="scan'208";a="218015961"
Received: from allen-box.sh.intel.com ([10.239.48.172])
  by orsmga004.jf.intel.com with ESMTP; 21 Jul 2018 23:11:38 -0700
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
Subject: [RFC PATCH 10/10] vfio/type1: Allocate domain for mediated device
Date:   Sun, 22 Jul 2018 14:09:33 +0800
Message-Id: <1532239773-15325-11-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allocates a domain for the mediated device if it is able to
be isolated and protected individually by IOMMU.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/vfio/vfio_iommu_type1.c | 43 ++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 3e5b177..496bea6 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1177,6 +1177,22 @@ static int vfio_bus_type(struct device *dev, void *data)
 	return 0;
 }
 
+static int mdev_private_domain(struct device *dev, void *data)
+{
+	enum mdev_domain_type type;
+	enum mdev_domain_type (*fn)(struct device *dev);
+
+	fn = symbol_get(mdev_get_domain_type);
+	if (fn) {
+		type = fn(dev);
+		symbol_put(mdev_get_domain_type);
+
+		return type != DOMAIN_TYPE_PRIVATE;
+	}
+
+	return -EINVAL;
+}
+
 static int vfio_iommu_replay(struct vfio_iommu *iommu,
 			     struct vfio_domain *domain)
 {
@@ -1371,18 +1387,23 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	mdev_bus = symbol_get(mdev_bus_type);
 
 	if (mdev_bus) {
-		if ((bus == mdev_bus) && !iommu_present(bus)) {
-			symbol_put(mdev_bus_type);
-			if (!iommu->external_domain) {
-				INIT_LIST_HEAD(&domain->group_list);
-				iommu->external_domain = domain;
-			} else
-				kfree(domain);
+		if (bus == mdev_bus) {
+			ret = iommu_group_for_each_dev(iommu_group, NULL,
+						       mdev_private_domain);
+			if (!iommu_present(bus) || ret) {
+				symbol_put(mdev_bus_type);
+				if (!iommu->external_domain) {
+					INIT_LIST_HEAD(&domain->group_list);
+					iommu->external_domain = domain;
+				} else {
+					kfree(domain);
+				}
 
-			list_add(&group->next,
-				 &iommu->external_domain->group_list);
-			mutex_unlock(&iommu->lock);
-			return 0;
+				list_add(&group->next,
+					 &iommu->external_domain->group_list);
+				mutex_unlock(&iommu->lock);
+				return 0;
+			}
 		}
 		symbol_put(mdev_bus_type);
 	}
-- 
2.7.4

