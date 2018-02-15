Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755375AbeBOJse (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 04:48:34 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:59926 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S966892AbeBOJrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 04:47:21 -0500
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <alex.williamson@redhat.com>, <eric.auger@redhat.com>,
        <pmorel@linux.vnet.ibm.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <john.garry@huawei.com>, <xuwei5@hisilicon.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v3 2/6] vfio/type1: Check reserve region conflict and update iova list
Date: Thu, 15 Feb 2018 09:45:00 +0000
Message-ID: <20180215094504.4972-3-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20180215094504.4972-1-shameerali.kolothum.thodi@huawei.com>
References: <20180215094504.4972-1-shameerali.kolothum.thodi@huawei.com>
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
 drivers/vfio/vfio_iommu_type1.c | 86 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 4726f55..4db87a9 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1303,6 +1303,72 @@ static int vfio_iommu_aper_resize(struct list_head *iova,
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
+				ret = vfio_insert_iova(n->start, start - 1,
+								 &n->list);
+			if (!ret && end < n->end)
+				ret = vfio_insert_iova(end + 1, n->end,
+							     &n->list);
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
 static int vfio_iommu_get_iova_copy(struct vfio_iommu *iommu,
 				struct list_head *iova_copy)
 {
@@ -1346,7 +1412,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	bool resv_msi, msi_remap;
 	phys_addr_t resv_msi_base;
 	struct iommu_domain_geometry geo;
-	struct list_head iova_copy;
+	struct list_head iova_copy, group_resv_regions;
+	struct iommu_resv_region *resv, *resv_next;
 	struct vfio_iova *iova, *iova_next;
 
 	mutex_lock(&iommu->lock);
@@ -1426,6 +1493,14 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 		goto out_detach;
 	}
 
+	INIT_LIST_HEAD(&group_resv_regions);
+	iommu_get_group_resv_regions(iommu_group, &group_resv_regions);
+
+	if (vfio_iommu_resv_conflict(iommu, &group_resv_regions)) {
+		ret = -EINVAL;
+		goto out_detach;
+	}
+
 	/* Get a copy of the current iova list and work on it */
 	INIT_LIST_HEAD(&iova_copy);
 	ret = vfio_iommu_get_iova_copy(iommu, &iova_copy);
@@ -1437,6 +1512,10 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	if (ret)
 		goto out_detach;
 
+	ret = vfio_iommu_resv_exclude(&iova_copy, &group_resv_regions);
+	if (ret)
+		goto out_detach;
+
 	resv_msi = vfio_iommu_has_sw_msi(iommu_group, &resv_msi_base);
 
 	INIT_LIST_HEAD(&domain->group_list);
@@ -1497,6 +1576,9 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	/* Delete the old one and insert new iova list */
 	vfio_iommu_insert_iova_copy(iommu, &iova_copy);
 
+	list_for_each_entry_safe(resv, resv_next, &group_resv_regions, list)
+		kfree(resv);
+
 	mutex_unlock(&iommu->lock);
 
 	return 0;
@@ -1507,6 +1589,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	iommu_domain_free(domain->domain);
 	list_for_each_entry_safe(iova, iova_next, &iova_copy, list)
 		kfree(iova);
+	list_for_each_entry_safe(resv, resv_next, &group_resv_regions, list)
+		kfree(resv);
 out_free:
 	kfree(domain);
 	kfree(group);
-- 
2.7.4
