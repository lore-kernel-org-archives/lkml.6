Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966846AbeBOJrU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 04:47:20 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:5653 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755342AbeBOJrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 04:47:16 -0500
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <alex.williamson@redhat.com>, <eric.auger@redhat.com>,
        <pmorel@linux.vnet.ibm.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <john.garry@huawei.com>, <xuwei5@hisilicon.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v3 1/6] vfio/type1: Introduce iova list and add iommu aperture validity check
Date: Thu, 15 Feb 2018 09:44:59 +0000
Message-ID: <20180215094504.4972-2-shameerali.kolothum.thodi@huawei.com>
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

This introduces an iova list that is valid for dma mappings. Make
sure the new iommu aperture window doesn't conflict with the current
one or with any existing dma mappings during attach.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/vfio/vfio_iommu_type1.c | 183 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 181 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index e30e29a..4726f55 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -60,6 +60,7 @@ MODULE_PARM_DESC(disable_hugepages,
 
 struct vfio_iommu {
 	struct list_head	domain_list;
+	struct list_head	iova_list;
 	struct vfio_domain	*external_domain; /* domain for external user */
 	struct mutex		lock;
 	struct rb_root		dma_list;
@@ -92,6 +93,12 @@ struct vfio_group {
 	struct list_head	next;
 };
 
+struct vfio_iova {
+	struct list_head	list;
+	dma_addr_t		start;
+	dma_addr_t		end;
+};
+
 /*
  * Guest RAM pinning working set or DMA target
  */
@@ -1192,6 +1199,142 @@ static bool vfio_iommu_has_sw_msi(struct iommu_group *group, phys_addr_t *base)
 	return ret;
 }
 
+/*
+ * This is a helper function to insert an address range to iova list.
+ * The list starts with a single entry corresponding to the IOMMU
+ * domain geometry to which the device group is attached. The list
+ * aperture gets modified when a new domain is added to the container
+ * if the new aperture doesn't conflict with the current one or with
+ * any existing dma mappings. The list is also modified to exclude
+ * any reserved regions associated with the device group.
+ */
+static int vfio_insert_iova(phys_addr_t start, phys_addr_t end,
+				struct list_head *head)
+{
+	struct vfio_iova *region;
+
+	region = kmalloc(sizeof(*region), GFP_KERNEL);
+	if (!region)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&region->list);
+	region->start = start;
+	region->end = end;
+
+	list_add_tail(&region->list, head);
+	return 0;
+}
+
+/*
+ * Check the new iommu aperture conflicts with existing aper or
+ * with any existing dma mappings.
+ */
+static bool vfio_iommu_aper_conflict(struct vfio_iommu *iommu,
+				     phys_addr_t start,
+				     phys_addr_t end)
+{
+	struct vfio_iova *first, *last;
+	struct list_head *iova = &iommu->iova_list;
+
+	if (list_empty(iova))
+		return false;
+
+	/* Disjoint sets, return conflict */
+	first = list_first_entry(iova, struct vfio_iova, list);
+	last = list_last_entry(iova, struct vfio_iova, list);
+	if ((start > last->end) || (end < first->start))
+		return true;
+
+	/* Check for any existing dma mappings outside the new start */
+	if (start > first->start) {
+		if (vfio_find_dma(iommu, first->start, start - first->start))
+			return true;
+	}
+
+	/* Check for any existing dma mappings outside the new end */
+	if (end < last->end) {
+		if (vfio_find_dma(iommu, end + 1, last->end - end))
+			return true;
+	}
+
+	return false;
+}
+
+/*
+ * Resize iommu iova aperture window. This is called only if the new
+ * aperture has no conflict with existing aperture and dma mappings.
+ */
+static int vfio_iommu_aper_resize(struct list_head *iova,
+				      dma_addr_t start,
+				      dma_addr_t end)
+{
+	struct vfio_iova *node, *next;
+
+	if (list_empty(iova))
+		return vfio_insert_iova(start, end, iova);
+
+	/* Adjust iova list start */
+	list_for_each_entry_safe(node, next, iova, list) {
+		if (start < node->start)
+			break;
+		if ((start >= node->start) && (start < node->end)) {
+			node->start = start;
+			break;
+		}
+		/* Delete nodes before new start */
+		list_del(&node->list);
+		kfree(node);
+	}
+
+	/* Adjust iova list end */
+	list_for_each_entry_safe(node, next, iova, list) {
+		if (end > node->end)
+			continue;
+
+		if ((end >= node->start) && (end < node->end)) {
+			node->end = end;
+			continue;
+		}
+		/* Delete nodes after new end */
+		list_del(&node->list);
+		kfree(node);
+	}
+
+	return 0;
+}
+
+static int vfio_iommu_get_iova_copy(struct vfio_iommu *iommu,
+				struct list_head *iova_copy)
+{
+
+	struct list_head *iova = &iommu->iova_list;
+	struct vfio_iova *n;
+
+	list_for_each_entry(n, iova, list) {
+		int ret;
+
+		ret = vfio_insert_iova(n->start, n->end, iova_copy);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void vfio_iommu_insert_iova_copy(struct vfio_iommu *iommu,
+					struct list_head *iova_copy)
+{
+	struct list_head *iova = &iommu->iova_list;
+	struct vfio_iova *n, *next;
+
+	list_for_each_entry_safe(n, next, iova, list) {
+		list_del(&n->list);
+		kfree(n);
+	}
+
+	list_splice_tail(iova_copy, iova);
+}
+
 static int vfio_iommu_type1_attach_group(void *iommu_data,
 					 struct iommu_group *iommu_group)
 {
@@ -1202,6 +1345,9 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	int ret;
 	bool resv_msi, msi_remap;
 	phys_addr_t resv_msi_base;
+	struct iommu_domain_geometry geo;
+	struct list_head iova_copy;
+	struct vfio_iova *iova, *iova_next;
 
 	mutex_lock(&iommu->lock);
 
@@ -1271,6 +1417,26 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	if (ret)
 		goto out_domain;
 
+	/* Get aperture info */
+	iommu_domain_get_attr(domain->domain, DOMAIN_ATTR_GEOMETRY, &geo);
+
+	if (vfio_iommu_aper_conflict(iommu, geo.aperture_start,
+					    geo.aperture_end)) {
+		ret = -EINVAL;
+		goto out_detach;
+	}
+
+	/* Get a copy of the current iova list and work on it */
+	INIT_LIST_HEAD(&iova_copy);
+	ret = vfio_iommu_get_iova_copy(iommu, &iova_copy);
+	if (ret)
+		goto out_detach;
+
+	ret = vfio_iommu_aper_resize(&iova_copy, geo.aperture_start,
+							geo.aperture_end);
+	if (ret)
+		goto out_detach;
+
 	resv_msi = vfio_iommu_has_sw_msi(iommu_group, &resv_msi_base);
 
 	INIT_LIST_HEAD(&domain->group_list);
@@ -1304,8 +1470,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 				list_add(&group->next, &d->group_list);
 				iommu_domain_free(domain->domain);
 				kfree(domain);
-				mutex_unlock(&iommu->lock);
-				return 0;
+				goto done;
 			}
 
 			ret = iommu_attach_group(domain->domain, iommu_group);
@@ -1328,6 +1493,9 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	}
 
 	list_add(&domain->next, &iommu->domain_list);
+done:
+	/* Delete the old one and insert new iova list */
+	vfio_iommu_insert_iova_copy(iommu, &iova_copy);
 
 	mutex_unlock(&iommu->lock);
 
@@ -1337,6 +1505,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	iommu_detach_group(domain->domain, iommu_group);
 out_domain:
 	iommu_domain_free(domain->domain);
+	list_for_each_entry_safe(iova, iova_next, &iova_copy, list)
+		kfree(iova);
 out_free:
 	kfree(domain);
 	kfree(group);
@@ -1475,6 +1645,7 @@ static void *vfio_iommu_type1_open(unsigned long arg)
 	}
 
 	INIT_LIST_HEAD(&iommu->domain_list);
+	INIT_LIST_HEAD(&iommu->iova_list);
 	iommu->dma_list = RB_ROOT;
 	mutex_init(&iommu->lock);
 	BLOCKING_INIT_NOTIFIER_HEAD(&iommu->notifier);
@@ -1502,6 +1673,7 @@ static void vfio_iommu_type1_release(void *iommu_data)
 {
 	struct vfio_iommu *iommu = iommu_data;
 	struct vfio_domain *domain, *domain_tmp;
+	struct vfio_iova *iova, *iova_next;
 
 	if (iommu->external_domain) {
 		vfio_release_domain(iommu->external_domain, true);
@@ -1517,6 +1689,13 @@ static void vfio_iommu_type1_release(void *iommu_data)
 		list_del(&domain->next);
 		kfree(domain);
 	}
+
+	list_for_each_entry_safe(iova, iova_next,
+				 &iommu->iova_list, list) {
+		list_del(&iova->list);
+		kfree(iova);
+	}
+
 	kfree(iommu);
 }
 
-- 
2.7.4
