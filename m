Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754029AbeDRLnv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 07:43:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42251 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753982AbeDRLnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 07:43:49 -0400
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <alex.williamson@redhat.com>, <eric.auger@redhat.com>,
        <pmorel@linux.vnet.ibm.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <linuxarm@huawei.com>,
        <john.garry@huawei.com>, <xuwei5@hisilicon.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v6 2/7] vfio/type1: Check reserve region conflict and update iova list
Date: Wed, 18 Apr 2018 12:40:40 +0100
Message-ID: <20180418114045.7968-3-shameerali.kolothum.thodi@huawei.com>
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

This retrieves the reserved regions associated with dev group and
checks for conflicts with any existing dma mappings. Also update
the iova list excluding the reserved regions.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/vfio/vfio_iommu_type1.c | 90 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 775946d..a0a79e1 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1422,6 +1422,82 @@ static int vfio_iommu_aper_resize(struct list_head *iova,
 	return 0;
 }
 
+/*
+ * Check reserved region conflicts with existing dma mappings
+ */
+static bool vfio_iommu_resv_conflict(struct vfio_iommu *iommu,
+				struct list_head *resv_regions)
+{
+	struct iommu_resv_region *region;
+
+	/* Check for conflict with existing dma mappings */
+	list_for_each_entry(region, resv_regions, list) {
+		if (vfio_find_dma(iommu, region->start, region->length))
+			return true;
+	}
+
+	return false;
+}
+
+/*
+ * Check iova region overlap with  reserved regions and
+ * exclude them from the iommu iova range
+ */
+static int vfio_iommu_resv_exclude(struct list_head *iova,
+					struct list_head *resv_regions)
+{
+	struct iommu_resv_region *resv;
+	struct vfio_iova *n, *next;
+
+	list_for_each_entry(resv, resv_regions, list) {
+		phys_addr_t start, end;
+
+		start = resv->start;
+		end = resv->start + resv->length - 1;
+
+		list_for_each_entry_safe(n, next, iova, list) {
+			int ret = 0;
+
+			/* No overlap */
+			if ((start > n->end) || (end < n->start))
+				continue;
+			/*
+			 * Insert a new node if current node overlaps with the
+			 * reserve region to exlude that from valid iova range.
+			 * Note that, new node is inserted before the current
+			 * node and finally the current node is deleted keeping
+			 * the list updated and sorted.
+			 */
+			if (start > n->start)
+				ret = vfio_iommu_iova_insert(&n->list,
+							n->start, start - 1);
+			if (!ret && end < n->end)
+				ret = vfio_iommu_iova_insert(&n->list,
+							end + 1, n->end);
+			if (ret)
+				return ret;
+
+			list_del(&n->list);
+			kfree(n);
+		}
+	}
+
+	if (list_empty(iova))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void vfio_iommu_resv_free(struct list_head *resv_regions)
+{
+	struct iommu_resv_region *n, *next;
+
+	list_for_each_entry_safe(n, next, resv_regions, list) {
+		list_del(&n->list);
+		kfree(n);
+	}
+}
+
 static void vfio_iommu_iova_free(struct list_head *iova)
 {
 	struct vfio_iova *n, *next;
@@ -1475,6 +1551,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	phys_addr_t resv_msi_base;
 	struct iommu_domain_geometry geo;
 	LIST_HEAD(iova_copy);
+	LIST_HEAD(group_resv_regions);
 
 	mutex_lock(&iommu->lock);
 
@@ -1553,6 +1630,13 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 		goto out_detach;
 	}
 
+	iommu_get_group_resv_regions(iommu_group, &group_resv_regions);
+
+	if (vfio_iommu_resv_conflict(iommu, &group_resv_regions)) {
+		ret = -EINVAL;
+		goto out_detach;
+	}
+
 	/* Get a copy of the current iova list and work on it */
 	ret = vfio_iommu_iova_get_copy(iommu, &iova_copy);
 	if (ret)
@@ -1563,6 +1647,10 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	if (ret)
 		goto out_detach;
 
+	ret = vfio_iommu_resv_exclude(&iova_copy, &group_resv_regions);
+	if (ret)
+		goto out_detach;
+
 	resv_msi = vfio_iommu_has_sw_msi(iommu_group, &resv_msi_base);
 
 	INIT_LIST_HEAD(&domain->group_list);
@@ -1623,6 +1711,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	/* Delete the old one and insert new iova list */
 	vfio_iommu_iova_insert_copy(iommu, &iova_copy);
 	mutex_unlock(&iommu->lock);
+	vfio_iommu_resv_free(&group_resv_regions);
 
 	return 0;
 
@@ -1631,6 +1720,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 out_domain:
 	iommu_domain_free(domain->domain);
 	vfio_iommu_iova_free(&iova_copy);
+	vfio_iommu_resv_free(&group_resv_regions);
 out_free:
 	kfree(domain);
 	kfree(group);
-- 
2.7.4
