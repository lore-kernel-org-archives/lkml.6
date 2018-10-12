Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767F9C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 05:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE2A2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 05:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE2A2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbeJLMtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 08:49:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:62493 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727610AbeJLMtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 08:49:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 22:19:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,371,1534834800"; 
   d="scan'208";a="80842263"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by orsmga008.jf.intel.com with ESMTP; 11 Oct 2018 22:19:02 -0700
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
Subject: [PATCH v3 7/8] vfio/type1: Add domain at(de)taching group helpers
Date:   Fri, 12 Oct 2018 13:16:31 +0800
Message-Id: <20181012051632.26064-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181012051632.26064-1-baolu.lu@linux.intel.com>
References: <20181012051632.26064-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds helpers to attach or detach a domain to a
group. This will replace iommu_attach_group() which
only works for pci devices.

If a domain is attaching to a group which includes the
mediated devices, it should attach to the iommu device
(a pci device which represents the mdev in iommu scope)
instead. The added helper supports attaching domain to
groups for both pci and mdev devices.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/vfio/vfio_iommu_type1.c | 98 ++++++++++++++++++++++++++++++---
 1 file changed, 91 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index d9fd3188615d..3617499c95c9 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -91,6 +91,7 @@ struct vfio_dma {
 struct vfio_group {
 	struct iommu_group	*iommu_group;
 	struct list_head	next;
+	bool			mdev_group;	/* An mdev group */
 };
 
 /*
@@ -1327,6 +1328,89 @@ static bool vfio_iommu_has_sw_msi(struct iommu_group *group, phys_addr_t *base)
 	return ret;
 }
 
+static struct device *vfio_mdev_get_iommu_device(struct device *dev)
+{
+	struct device *(*fn)(struct device *dev);
+	struct device *iommu_parent;
+
+	fn = symbol_get(mdev_get_iommu_device);
+	if (fn) {
+		iommu_parent = fn(dev);
+		symbol_put(mdev_get_iommu_device);
+
+		return iommu_parent;
+	}
+
+	return NULL;
+}
+
+static int vfio_mdev_set_domain(struct device *dev, struct iommu_domain *domain)
+{
+	int (*fn)(struct device *dev, void *domain);
+	int ret;
+
+	fn = symbol_get(mdev_set_iommu_domain);
+	if (fn) {
+		ret = fn(dev, domain);
+		symbol_put(mdev_set_iommu_domain);
+
+		return ret;
+	}
+
+	return -EINVAL;
+}
+
+static int vfio_mdev_attach_domain(struct device *dev, void *data)
+{
+	struct iommu_domain *domain = data;
+	struct device *iommu_device;
+	int ret;
+
+	ret = vfio_mdev_set_domain(dev, domain);
+	if (ret)
+		return ret;
+
+	iommu_device = vfio_mdev_get_iommu_device(dev);
+	if (iommu_device)
+		return iommu_attach_device(domain, iommu_device);
+
+	return -EINVAL;
+}
+
+static int vfio_mdev_detach_domain(struct device *dev, void *data)
+{
+	struct iommu_domain *domain = data;
+	struct device *iommu_device;
+
+	vfio_mdev_set_domain(dev, NULL);
+	iommu_device = vfio_mdev_get_iommu_device(dev);
+	if (iommu_device)
+		iommu_detach_device(domain, iommu_device);
+
+	return 0;
+}
+
+static int vfio_iommu_attach_group(struct vfio_domain *domain,
+				   struct vfio_group *group)
+{
+	if (group->mdev_group)
+		return iommu_group_for_each_dev(group->iommu_group,
+						domain->domain,
+						vfio_mdev_attach_domain);
+	else
+		return iommu_attach_group(domain->domain, group->iommu_group);
+}
+
+static void vfio_iommu_detach_group(struct vfio_domain *domain,
+				    struct vfio_group *group)
+{
+	if (group->mdev_group)
+		iommu_group_for_each_dev(group->iommu_group, domain->domain,
+					 vfio_mdev_detach_domain);
+	else
+		iommu_detach_group(domain->domain, group->iommu_group);
+}
+
 static int vfio_iommu_type1_attach_group(void *iommu_data,
 					 struct iommu_group *iommu_group)
 {
@@ -1402,7 +1486,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 			goto out_domain;
 	}
 
-	ret = iommu_attach_group(domain->domain, iommu_group);
+	ret = vfio_iommu_attach_group(domain, group);
 	if (ret)
 		goto out_domain;
 
@@ -1434,8 +1518,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	list_for_each_entry(d, &iommu->domain_list, next) {
 		if (d->domain->ops == domain->domain->ops &&
 		    d->prot == domain->prot) {
-			iommu_detach_group(domain->domain, iommu_group);
-			if (!iommu_attach_group(d->domain, iommu_group)) {
+			vfio_iommu_detach_group(domain, group);
+			if (!vfio_iommu_attach_group(d, group)) {
 				list_add(&group->next, &d->group_list);
 				iommu_domain_free(domain->domain);
 				kfree(domain);
@@ -1443,7 +1527,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 				return 0;
 			}
 
-			ret = iommu_attach_group(domain->domain, iommu_group);
+			ret = vfio_iommu_attach_group(domain, group);
 			if (ret)
 				goto out_domain;
 		}
@@ -1469,7 +1553,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	return 0;
 
 out_detach:
-	iommu_detach_group(domain->domain, iommu_group);
+	vfio_iommu_detach_group(domain, group);
 out_domain:
 	iommu_domain_free(domain->domain);
 out_free:
@@ -1560,7 +1644,7 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 		if (!group)
 			continue;
 
-		iommu_detach_group(domain->domain, iommu_group);
+		vfio_iommu_detach_group(domain, group);
 		list_del(&group->next);
 		kfree(group);
 		/*
@@ -1625,7 +1709,7 @@ static void vfio_release_domain(struct vfio_domain *domain, bool external)
 	list_for_each_entry_safe(group, group_tmp,
 				 &domain->group_list, next) {
 		if (!external)
-			iommu_detach_group(domain->domain, group->iommu_group);
+			vfio_iommu_detach_group(domain, group);
 		list_del(&group->next);
 		kfree(group);
 	}
-- 
2.17.1

