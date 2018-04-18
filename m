Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753986AbeDRLpC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 07:45:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42309 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753996AbeDRLny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 07:43:54 -0400
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <alex.williamson@redhat.com>, <eric.auger@redhat.com>,
        <pmorel@linux.vnet.ibm.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <linuxarm@huawei.com>,
        <john.garry@huawei.com>, <xuwei5@hisilicon.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v6 3/7] vfio/type1: Update iova list on detach
Date: Wed, 18 Apr 2018 12:40:41 +0100
Message-ID: <20180418114045.7968-4-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20180418114045.7968-1-shameerali.kolothum.thodi@huawei.com>
References: <20180418114045.7968-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get a copy of iova list on _group_detach and try to update the list.
On success replace the current one with the copy. Leave the list as
it is if update fails.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/vfio/vfio_iommu_type1.c | 91 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index a0a79e1..6fd6841 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1776,12 +1776,88 @@ static void vfio_sanity_check_pfn_list(struct vfio_iommu *iommu)
 	WARN_ON(iommu->notifier.head);
 }
 
+/*
+ * Called when a domain is removed in detach. It is possible that
+ * the removed domain decided the iova aperture window. Modify the
+ * iova aperture with the smallest window among existing domains.
+ */
+static void vfio_iommu_aper_expand(struct vfio_iommu *iommu,
+				   struct list_head *iova_copy)
+{
+	struct vfio_domain *domain;
+	struct iommu_domain_geometry geo;
+	struct vfio_iova *node;
+	dma_addr_t start = 0;
+	dma_addr_t end = (dma_addr_t)~0;
+
+	list_for_each_entry(domain, &iommu->domain_list, next) {
+		iommu_domain_get_attr(domain->domain, DOMAIN_ATTR_GEOMETRY,
+				      &geo);
+		if (geo.aperture_start > start)
+			start = geo.aperture_start;
+		if (geo.aperture_end < end)
+			end = geo.aperture_end;
+	}
+
+	/* Modify aperture limits. The new aper is either same or bigger */
+	node = list_first_entry(iova_copy, struct vfio_iova, list);
+	node->start = start;
+	node = list_last_entry(iova_copy, struct vfio_iova, list);
+	node->end = end;
+}
+
+/*
+ * Called when a group is detached. The reserved regions for that
+ * group can be part of valid iova now. But since reserved regions
+ * may be duplicated among groups, populate the iova valid regions
+ * list again.
+ */
+static int vfio_iommu_resv_refresh(struct vfio_iommu *iommu,
+				   struct list_head *iova_copy)
+{
+	struct vfio_domain *d;
+	struct vfio_group *g;
+	struct vfio_iova *node;
+	dma_addr_t start, end;
+	LIST_HEAD(resv_regions);
+	int ret;
+
+	list_for_each_entry(d, &iommu->domain_list, next) {
+		list_for_each_entry(g, &d->group_list, next)
+			iommu_get_group_resv_regions(g->iommu_group,
+							 &resv_regions);
+	}
+
+	if (list_empty(&resv_regions))
+		return 0;
+
+	node = list_first_entry(iova_copy, struct vfio_iova, list);
+	start = node->start;
+	node = list_last_entry(iova_copy, struct vfio_iova, list);
+	end = node->end;
+
+	/* purge the iova list and create new one */
+	vfio_iommu_iova_free(iova_copy);
+
+	ret = vfio_iommu_aper_resize(iova_copy, start, end);
+	if (ret)
+		goto done;
+
+	/* Exclude current reserved regions from iova ranges */
+	ret = vfio_iommu_resv_exclude(iova_copy, &resv_regions);
+done:
+	vfio_iommu_resv_free(&resv_regions);
+	return ret;
+}
+
 static void vfio_iommu_type1_detach_group(void *iommu_data,
 					  struct iommu_group *iommu_group)
 {
 	struct vfio_iommu *iommu = iommu_data;
 	struct vfio_domain *domain;
 	struct vfio_group *group;
+	bool iova_copy_fail;
+	LIST_HEAD(iova_copy);
 
 	mutex_lock(&iommu->lock);
 
@@ -1804,6 +1880,12 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 		}
 	}
 
+	/*
+	 * Get a copy of iova list. If success, use copy to update the
+	 * list and to replace the current one.
+	 */
+	iova_copy_fail = !!vfio_iommu_iova_get_copy(iommu, &iova_copy);
+
 	list_for_each_entry(domain, &iommu->domain_list, next) {
 		group = find_iommu_group(domain, iommu_group);
 		if (!group)
@@ -1829,10 +1911,19 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 			iommu_domain_free(domain->domain);
 			list_del(&domain->next);
 			kfree(domain);
+			if (!iova_copy_fail && !list_empty(&iommu->domain_list))
+				vfio_iommu_aper_expand(iommu, &iova_copy);
 		}
 		break;
 	}
 
+	if (!iova_copy_fail && !list_empty(&iommu->domain_list)) {
+		if (!vfio_iommu_resv_refresh(iommu, &iova_copy))
+			vfio_iommu_iova_insert_copy(iommu, &iova_copy);
+		else
+			vfio_iommu_iova_free(&iova_copy);
+	}
+
 detach_group_done:
 	mutex_unlock(&iommu->lock);
 }
-- 
2.7.4
