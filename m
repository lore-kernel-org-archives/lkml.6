Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753846AbeDRLpB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 07:45:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42314 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754032AbeDRLnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 07:43:55 -0400
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <alex.williamson@redhat.com>, <eric.auger@redhat.com>,
        <pmorel@linux.vnet.ibm.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <linuxarm@huawei.com>,
        <john.garry@huawei.com>, <xuwei5@hisilicon.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v6 4/7] iommu/dma: Move PCI window region reservation back into dma specific path.
Date: Wed, 18 Apr 2018 12:40:42 +0100
Message-ID: <20180418114045.7968-5-shameerali.kolothum.thodi@huawei.com>
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

This pretty much reverts commit 273df9635385 ("iommu/dma: Make PCI
window reservation generic")  by moving the PCI window region
reservation back into the dma specific path so that these regions
doesn't get exposed via the IOMMU API interface. With this change,
the vfio interface will report only iommu specific reserved regions
to the user space.

Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 54 ++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f05f3cf..ddcbbdb 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -167,40 +167,16 @@ EXPORT_SYMBOL(iommu_put_dma_cookie);
  * @list: Reserved region list from iommu_get_resv_regions()
  *
  * IOMMU drivers can use this to implement their .get_resv_regions callback
- * for general non-IOMMU-specific reservations. Currently, this covers host
- * bridge windows for PCI devices and GICv3 ITS region reservation on ACPI
- * based ARM platforms that may require HW MSI reservation.
+ * for general non-IOMMU-specific reservations. Currently, this covers GICv3
+ * ITS region reservation on ACPI based ARM platforms that may require HW MSI
+ * reservation.
  */
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 {
-	struct pci_host_bridge *bridge;
-	struct resource_entry *window;
-
-	if (!is_of_node(dev->iommu_fwspec->iommu_fwnode) &&
-		iort_iommu_msi_get_resv_regions(dev, list) < 0)
-		return;
-
-	if (!dev_is_pci(dev))
-		return;
-
-	bridge = pci_find_host_bridge(to_pci_dev(dev)->bus);
-	resource_list_for_each_entry(window, &bridge->windows) {
-		struct iommu_resv_region *region;
-		phys_addr_t start;
-		size_t length;
-
-		if (resource_type(window->res) != IORESOURCE_MEM)
-			continue;
 
-		start = window->res->start - window->offset;
-		length = window->res->end - window->res->start + 1;
-		region = iommu_alloc_resv_region(start, length, 0,
-				IOMMU_RESV_RESERVED);
-		if (!region)
-			return;
+	if (!is_of_node(dev->iommu_fwspec->iommu_fwnode))
+		iort_iommu_msi_get_resv_regions(dev, list);
 
-		list_add_tail(&region->list, list);
-	}
 }
 EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 
@@ -229,6 +205,23 @@ static int cookie_init_hw_msi_region(struct iommu_dma_cookie *cookie,
 	return 0;
 }
 
+static void iova_reserve_pci_windows(struct pci_dev *dev,
+		struct iova_domain *iovad)
+{
+	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
+	struct resource_entry *window;
+	unsigned long lo, hi;
+
+	resource_list_for_each_entry(window, &bridge->windows) {
+		if (resource_type(window->res) != IORESOURCE_MEM)
+			continue;
+
+		lo = iova_pfn(iovad, window->res->start - window->offset);
+		hi = iova_pfn(iovad, window->res->end - window->offset);
+		reserve_iova(iovad, lo, hi);
+	}
+}
+
 static int iova_reserve_iommu_regions(struct device *dev,
 		struct iommu_domain *domain)
 {
@@ -238,6 +231,9 @@ static int iova_reserve_iommu_regions(struct device *dev,
 	LIST_HEAD(resv_regions);
 	int ret = 0;
 
+	if (dev_is_pci(dev))
+		iova_reserve_pci_windows(to_pci_dev(dev), iovad);
+
 	iommu_get_resv_regions(dev, &resv_regions);
 	list_for_each_entry(region, &resv_regions, list) {
 		unsigned long lo, hi;
-- 
2.7.4
