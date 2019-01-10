Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40647C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 03:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106AF214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 03:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfAJDFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 22:05:13 -0500
Received: from mga03.intel.com ([134.134.136.65]:11620 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727497AbfAJDFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 22:05:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 19:05:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,459,1539673200"; 
   d="scan'208";a="115608498"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jan 2019 19:05:03 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com,
        tiwei.bie@intel.com, Zeng@vger.kernel.org,
        Xin <xin.zeng@intel.com>, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v5 7/8] vfio/type1: Add domain at(de)taching group helpers
Date:   Thu, 10 Jan 2019 11:00:26 +0800
Message-Id: <20190110030027.31447-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190110030027.31447-1-baolu.lu@linux.intel.com>
References: <20190110030027.31447-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds helpers to attach or detach a domain to a
group. This will replace iommu_attach_group() which
only works for non-mdev devices.

If a domain is attaching to a group which includes the
mediated devices, it should attach to the iommu device
(a pci device which represents the mdev in iommu scope)
instead. The added helper supports attaching domain to
groups for both pci and mdev devices.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/vfio/vfio_iommu_type1.c | 84 ++++++++++++++++++++++++++++++---
 1 file changed, 77 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 7651cfb14836..97278ac8da95 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -91,6 +91,7 @@ struct vfio_dma {
 struct vfio_group {
 	struct iommu_group	*iommu_group;
 	struct list_head	next;
+	bool			mdev_group;	/* An mdev group */
 };
 
 /*
@@ -1298,6 +1299,75 @@ static bool vfio_iommu_has_sw_msi(struct iommu_group *group, phys_addr_t *base)
 	return ret;
 }
 
+static struct device *vfio_mdev_get_iommu_device(struct device *dev)
+{
+	struct device *(*fn)(struct device *dev);
+	struct device *iommu_device;
+
+	fn = symbol_get(mdev_get_iommu_device);
+	if (fn) {
+		iommu_device = fn(dev);
+		symbol_put(mdev_get_iommu_device);
+
+		return iommu_device;
+	}
+
+	return NULL;
+}
+
+static int vfio_mdev_attach_domain(struct device *dev, void *data)
+{
+	struct iommu_domain *domain = data;
+	struct device *iommu_device;
+
+	iommu_device = vfio_mdev_get_iommu_device(dev);
+	if (iommu_device) {
+		if (iommu_dev_has_feature(iommu_device, IOMMU_DEV_FEAT_AUX))
+			return iommu_aux_attach_device(domain, iommu_device);
+		else
+			return iommu_attach_device(domain, iommu_device);
+	}
+
+	return -EINVAL;
+}
+
+static int vfio_mdev_detach_domain(struct device *dev, void *data)
+{
+	struct iommu_domain *domain = data;
+	struct device *iommu_device;
+
+	iommu_device = vfio_mdev_get_iommu_device(dev);
+	if (iommu_device) {
+		if (iommu_dev_has_feature(iommu_device, IOMMU_DEV_FEAT_AUX))
+			iommu_aux_detach_device(domain, iommu_device);
+		else
+			iommu_detach_device(domain, iommu_device);
+	}
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
@@ -1373,7 +1443,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 			goto out_domain;
 	}
 
-	ret = iommu_attach_group(domain->domain, iommu_group);
+	ret = vfio_iommu_attach_group(domain, group);
 	if (ret)
 		goto out_domain;
 
@@ -1405,8 +1475,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
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
@@ -1414,7 +1484,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 				return 0;
 			}
 
-			ret = iommu_attach_group(domain->domain, iommu_group);
+			ret = vfio_iommu_attach_group(domain, group);
 			if (ret)
 				goto out_domain;
 		}
@@ -1440,7 +1510,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	return 0;
 
 out_detach:
-	iommu_detach_group(domain->domain, iommu_group);
+	vfio_iommu_detach_group(domain, group);
 out_domain:
 	iommu_domain_free(domain->domain);
 out_free:
@@ -1531,7 +1601,7 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 		if (!group)
 			continue;
 
-		iommu_detach_group(domain->domain, iommu_group);
+		vfio_iommu_detach_group(domain, group);
 		list_del(&group->next);
 		kfree(group);
 		/*
@@ -1596,7 +1666,7 @@ static void vfio_release_domain(struct vfio_domain *domain, bool external)
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

