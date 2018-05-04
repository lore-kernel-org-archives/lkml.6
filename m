Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbeEDBu5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 21:50:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:35622 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751133AbeEDBux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 21:50:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,360,1520924400";
   d="scan'208";a="37326258"
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 6/9] iommu/vt-d: Allocate and free pasid table
Date: Fri,  4 May 2018 09:41:21 +0800
Message-Id: <1525398084-28815-7-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525398084-28815-1-git-send-email-baolu.lu@linux.intel.com>
References: <1525398084-28815-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allocates PASID table for a domain at the time when
it is being created (if any devices using this domain supports
PASID feature), and free it when the domain is freed.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/intel-iommu.c | 19 +++++++++++++++++++
 drivers/iommu/intel-svm.c   |  8 --------
 include/linux/intel-iommu.h | 10 ++++++++--
 3 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index caa0b5c..f86302d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2460,6 +2460,24 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		dev->archdata.iommu = info;
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 
+	if (dev && dev_is_pci(dev) && info->pasid_supported) {
+		if (pasid_enabled(iommu)) {
+			size_t size, count;
+
+			size = sizeof(struct pasid_entry);
+			count = min_t(int,
+				      pci_max_pasids(to_pci_dev(dev)),
+				      intel_pasid_max_id);
+			ret = intel_pasid_alloc_table(dev, size, count);
+			if (ret) {
+				pr_err("PASID table allocation for %s failed\n",
+				       dev_name(dev));
+				dmar_remove_one_dev_info(domain, dev);
+				return NULL;
+			}
+		}
+	}
+
 	if (dev && domain_context_mapping(domain, dev)) {
 		pr_err("Domain context map for %s failed\n", dev_name(dev));
 		dmar_remove_one_dev_info(domain, dev);
@@ -4826,6 +4844,7 @@ static void dmar_remove_one_dev_info(struct dmar_domain *domain,
 	unsigned long flags;
 
 	spin_lock_irqsave(&device_domain_lock, flags);
+	intel_pasid_free_table(dev);
 	info = dev->archdata.iommu;
 	__dmar_remove_one_dev_info(info);
 	spin_unlock_irqrestore(&device_domain_lock, flags);
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 24d0ea1..3abc94f 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -34,14 +34,6 @@
 
 static irqreturn_t prq_event_thread(int irq, void *d);
 
-struct pasid_entry {
-	u64 val;
-};
-
-struct pasid_state_entry {
-	u64 val;
-};
-
 int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
 {
 	struct page *pages;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index bee7a3f..08e5811 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -382,8 +382,14 @@ enum {
 #define VTD_FLAG_TRANS_PRE_ENABLED	(1 << 0)
 #define VTD_FLAG_IRQ_REMAP_PRE_ENABLED	(1 << 1)
 
-struct pasid_entry;
-struct pasid_state_entry;
+struct pasid_entry {
+	u64 val;
+};
+
+struct pasid_state_entry {
+	u64 val;
+};
+
 struct page_req_dsc;
 
 struct dmar_domain {
-- 
2.7.4
