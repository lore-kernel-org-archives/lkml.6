Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932128AbeCERBo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 12:01:44 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:23495 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751852AbeCERBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 12:01:41 -0500
X-IronPort-AV: E=Sophos;i="5.47,427,1515456000";
   d="scan'208";a="334437406"
From: Filippo Sironi <sironi@amazon.de>
To: alex.williamson@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Filippo Sironi <sironi@amazon.de>
Subject: [PATCH] vfio/type1: Search for a fitting iommu_domain before attaching the iommu_group
Date: Mon,  5 Mar 2018 18:01:11 +0100
Message-Id: <1520269271-12662-1-git-send-email-sironi@amazon.de>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... to avoid an unnecessary attach/detach of the iommu_group to the
newly created iommu_domain.  This also saves us a context-cache and an
IOTLB flush.

This is possible because allocating an iommu_domain for the iommu_group
we're attaching is enough to understand whether a fitting iommu_domain
already exists.

Signed-off-by: Filippo Sironi <sironi@amazon.de>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/vfio/vfio_iommu_type1.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 45657e2b1ff7..88359b4993f3 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1279,15 +1279,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 			goto out_domain;
 	}
 
-	ret = iommu_attach_group(domain->domain, iommu_group);
-	if (ret)
-		goto out_domain;
-
 	resv_msi = vfio_iommu_has_sw_msi(iommu_group, &resv_msi_base);
 
-	INIT_LIST_HEAD(&domain->group_list);
-	list_add(&group->next, &domain->group_list);
-
 	msi_remap = irq_domain_check_msi_remap() ||
 		    iommu_capable(bus, IOMMU_CAP_INTR_REMAP);
 
@@ -1295,7 +1288,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 		pr_warn("%s: No interrupt remapping support.  Use the module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU support on this platform\n",
 		       __func__);
 		ret = -EPERM;
-		goto out_detach;
+		goto out_domain;
 	}
 
 	if (iommu_capable(bus, IOMMU_CAP_CACHE_COHERENCY))
@@ -1311,21 +1304,24 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	list_for_each_entry(d, &iommu->domain_list, next) {
 		if (d->domain->ops == domain->domain->ops &&
 		    d->prot == domain->prot) {
-			iommu_detach_group(domain->domain, iommu_group);
-			if (!iommu_attach_group(d->domain, iommu_group)) {
-				list_add(&group->next, &d->group_list);
-				iommu_domain_free(domain->domain);
-				kfree(domain);
-				mutex_unlock(&iommu->lock);
-				return 0;
-			}
-
-			ret = iommu_attach_group(domain->domain, iommu_group);
+			ret = iommu_attach_group(d->domain, iommu_group);
 			if (ret)
 				goto out_domain;
+			list_add(&group->next, &d->group_list);
+			iommu_domain_free(domain->domain);
+			kfree(domain);
+			mutex_unlock(&iommu->lock);
+			return 0;
 		}
 	}
 
+	ret = iommu_attach_group(domain->domain, iommu_group);
+	if (ret)
+		goto out_domain;
+
+	INIT_LIST_HEAD(&domain->group_list);
+	list_add(&group->next, &domain->group_list);
+
 	vfio_test_domain_fgsp(domain);
 
 	/* replay mappings on new domains */
-- 
2.7.4
