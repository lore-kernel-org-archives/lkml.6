Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967873AbeBOJrf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 04:47:35 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:59985 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S966863AbeBOJra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 04:47:30 -0500
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <alex.williamson@redhat.com>, <eric.auger@redhat.com>,
        <pmorel@linux.vnet.ibm.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <john.garry@huawei.com>, <xuwei5@hisilicon.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v3 6/6] vfio/type1: remove duplicate retrieval of reserved regions.
Date: Thu, 15 Feb 2018 09:45:04 +0000
Message-ID: <20180215094504.4972-7-shameerali.kolothum.thodi@huawei.com>
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

As we now already have the reserved regions list, just pass that into
vfio_iommu_has_sw_msi() fn.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/vfio/vfio_iommu_type1.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 21e575c..ff9818b 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1192,15 +1192,13 @@ static struct vfio_group *find_iommu_group(struct vfio_domain *domain,
 	return NULL;
 }
 
-static bool vfio_iommu_has_sw_msi(struct iommu_group *group, phys_addr_t *base)
+static bool vfio_iommu_has_sw_msi(struct list_head *group_resv_regions,
+						phys_addr_t *base)
 {
-	struct list_head group_resv_regions;
-	struct iommu_resv_region *region, *next;
+	struct iommu_resv_region *region;
 	bool ret = false;
 
-	INIT_LIST_HEAD(&group_resv_regions);
-	iommu_get_group_resv_regions(group, &group_resv_regions);
-	list_for_each_entry(region, &group_resv_regions, list) {
+	list_for_each_entry(region, group_resv_regions, list) {
 		/*
 		 * The presence of any 'real' MSI regions should take
 		 * precedence over the software-managed one if the
@@ -1216,8 +1214,7 @@ static bool vfio_iommu_has_sw_msi(struct iommu_group *group, phys_addr_t *base)
 			ret = true;
 		}
 	}
-	list_for_each_entry_safe(region, next, &group_resv_regions, list)
-		kfree(region);
+
 	return ret;
 }
 
@@ -1538,7 +1535,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	if (ret)
 		goto out_detach;
 
-	resv_msi = vfio_iommu_has_sw_msi(iommu_group, &resv_msi_base);
+	resv_msi = vfio_iommu_has_sw_msi(&group_resv_regions, &resv_msi_base);
 
 	INIT_LIST_HEAD(&domain->group_list);
 	list_add(&group->next, &domain->group_list);
-- 
2.7.4
