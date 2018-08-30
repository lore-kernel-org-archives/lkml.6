Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375D5C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 04:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D4D20645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 04:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D4D20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbeH3ILX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 04:11:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:31597 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727694AbeH3ILX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 04:11:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 21:11:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,306,1531810800"; 
   d="scan'208";a="68959991"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by orsmga007.jf.intel.com with ESMTP; 29 Aug 2018 21:11:10 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com,
        tiwei.bie@intel.com, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [RFC PATCH v2 09/10] vfio/type1: Determine domain type of an mdev group
Date:   Thu, 30 Aug 2018 12:09:21 +0800
Message-Id: <20180830040922.30426-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830040922.30426-1-baolu.lu@linux.intel.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the support to determine the domain type of a group
of mediated devices according to the domain type attribute of
each device.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/vfio/vfio_iommu_type1.c | 47 ++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 89e2e6123223..64bf55b91de1 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1390,6 +1390,27 @@ static void vfio_iommu_detach_group(struct vfio_domain *domain,
 		iommu_detach_group(domain->domain, group->iommu_group);
 }
 
+static int vfio_mdev_domain_type(struct device *dev, void *data)
+{
+	enum mdev_domain_type new, *old = data;
+	enum mdev_domain_type (*fn)(struct device *dev);
+
+	fn = symbol_get(mdev_get_domain_type);
+	if (fn) {
+		new = fn(dev);
+		symbol_put(mdev_get_domain_type);
+
+		if (*old && *old != new)
+			return -EINVAL;
+
+		*old = new;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static int vfio_iommu_type1_attach_group(void *iommu_data,
 					 struct iommu_group *iommu_group)
 {
@@ -1433,9 +1454,19 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 
 	mdev_bus = symbol_get(mdev_bus_type);
 
-	if (mdev_bus) {
-		if ((bus == mdev_bus) && !iommu_present(bus)) {
-			symbol_put(mdev_bus_type);
+	if (mdev_bus && bus == mdev_bus) {
+		enum mdev_domain_type type = 0;
+
+		symbol_put(mdev_bus_type);
+
+		/* Determine the domain type: */
+		ret = iommu_group_for_each_dev(iommu_group, &type,
+					       vfio_mdev_domain_type);
+		if (ret)
+			goto out_free;
+
+		switch (type) {
+		case DOMAIN_TYPE_NO_IOMMU:
 			if (!iommu->external_domain) {
 				INIT_LIST_HEAD(&domain->group_list);
 				iommu->external_domain = domain;
@@ -1445,11 +1476,19 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 			list_add(&group->next,
 				 &iommu->external_domain->group_list);
 			mutex_unlock(&iommu->lock);
+
 			return 0;
+		case DOMAIN_TYPE_ATTACH_PARENT:
+		/* FALLTHROUGH */
+		default:
+			ret = -EINVAL;
+			goto out_free;
 		}
-		symbol_put(mdev_bus_type);
 	}
 
+	if (mdev_bus)
+		symbol_put(mdev_bus_type);
+
 	domain->domain = iommu_domain_alloc(bus);
 	if (!domain->domain) {
 		ret = -EIO;
-- 
2.17.1

