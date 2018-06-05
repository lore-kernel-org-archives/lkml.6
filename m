Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752259AbeFETHA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:07:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751823AbeFETG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:06:58 -0400
Subject: [RFC PATCH] iommu/vt-d: Exclude known RMRRs from reserved ranges
From: Alex Williamson <alex.williamson@redhat.com>
To: dwmw2@infradead.org, iommu@lists.linux-foundation.org
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        shameerali.kolothum.thodi@huawei.com
Date: Tue, 05 Jun 2018 13:06:54 -0600
Message-ID: <20180605190400.22732.2998.stgit@gimli.home>
User-Agent: StGit/0.18-102-gdf9f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_is_rmrr_locked() allows graphics and USB devices to participate
in the IOMMU API despite, and ignoring their RMRR association, however
intel_iommu_get_resv_regions() still includes the RMRRs as unavailable
IOVA space for the device.  Are we ignoring the RMRR for these devices
or are we not?  If vfio starts consuming reserved regions, perhaps we
no longer need to consider devices with RMRRs excluded from the IOMMU
API interface, but we have a transitional problem that these allowed
devices still impose incompatible IOVA restrictions per the reserved
region reporting.  Dive further down the rabbit hole by also ignoring
RMRRs for "known" devices in the reserved region reporting.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/iommu/intel-iommu.c |   35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

If this is the approach we want to take, I could pull this in via the
vfio tree, along with Shameer's patches which expose an IOVA list and
enforce it to userspace, otherwise I'm afraid Shameer's patches will
be blocked a while longer.  Thanks,

Alex

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 749d8f235346..f312f93199c5 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2864,19 +2864,24 @@ static bool device_has_rmrr(struct device *dev)
  * any use of the RMRR regions will be torn down before assigning the device
  * to a guest.
  */
-static bool device_is_rmrr_locked(struct device *dev)
+static bool rmrr_is_ignored(struct device *dev)
 {
-	if (!device_has_rmrr(dev))
-		return false;
-
 	if (dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(dev);
 
 		if (IS_USB_DEVICE(pdev) || IS_GFX_DEVICE(pdev))
-			return false;
+			return true;
 	}
 
-	return true;
+	return false;
+}
+
+static bool device_is_rmrr_locked(struct device *dev)
+{
+	if (!device_has_rmrr(dev))
+		return false;
+
+	return !rmrr_is_ignored(dev);
 }
 
 static int iommu_should_identity_map(struct device *dev, int startup)
@@ -5141,17 +5146,19 @@ static void intel_iommu_get_resv_regions(struct device *device,
 	struct device *i_dev;
 	int i;
 
-	rcu_read_lock();
-	for_each_rmrr_units(rmrr) {
-		for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
-					  i, i_dev) {
-			if (i_dev != device)
-				continue;
+	if (!rmrr_is_ignored(device)) {
+		rcu_read_lock();
+		for_each_rmrr_units(rmrr) {
+			for_each_active_dev_scope(rmrr->devices,
+						  rmrr->devices_cnt, i, i_dev) {
+				if (i_dev != device)
+					continue;
 
-			list_add_tail(&rmrr->resv->list, head);
+				list_add_tail(&rmrr->resv->list, head);
+			}
 		}
+		rcu_read_unlock();
 	}
-	rcu_read_unlock();
 
 	reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
 				      IOAPIC_RANGE_END - IOAPIC_RANGE_START + 1,
