Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611ABECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 05:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A784204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 05:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A784204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbeKEOwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 09:52:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:13964 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728921AbeKEOwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 09:52:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 21:34:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,466,1534834800"; 
   d="scan'208";a="105288949"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by fmsmga001.fm.intel.com with ESMTP; 04 Nov 2018 21:34:24 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        yi.y.sun@intel.com, peterx@redhat.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 02/12] iommu/vt-d: Manage scalalble mode PASID tables
Date:   Mon,  5 Nov 2018 13:31:41 +0800
Message-Id: <20181105053151.7173-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181105053151.7173-1-baolu.lu@linux.intel.com>
References: <20181105053151.7173-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In scalable mode, pasid structure is a two level table with
a pasid directory table and a pasid table. Any pasid entry
can be identified by a pasid value in below way.

   1
   9                       6 5      0
    .-----------------------.-------.
    |              PASID    |       |
    '-----------------------'-------'    .-------------.
             |                    |      |             |
             |                    |      |             |
             |                    |      |             |
             |     .-----------.  |      .-------------.
             |     |           |  |----->| PASID Entry |
             |     |           |  |      '-------------'
             |     |           |  |Plus  |             |
             |     .-----------.  |      |             |
             |---->| DIR Entry |-------->|             |
             |     '-----------'         '-------------'
.---------.  |Plus |           |
| Context |  |     |           |
|  Entry  |------->|           |
'---------'        '-----------'

This changes the pasid table APIs to support scalable mode
PASID directory and PASID table. It also adds a helper to
get the PASID table entry according to the pasid value.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/intel-iommu.c |  9 ++--
 drivers/iommu/intel-pasid.c | 84 ++++++++++++++++++++++++++++++-------
 drivers/iommu/intel-pasid.h | 12 +++++-
 drivers/iommu/intel-svm.c   |  6 +--
 4 files changed, 86 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 149561420a75..9c8fabe42b04 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2482,12 +2482,13 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	if (dev)
 		dev->archdata.iommu = info;
 
-	if (dev && dev_is_pci(dev) && info->pasid_supported) {
+	/* PASID table is mandatory for a PCI device in scalable mode. */
+	if (dev && dev_is_pci(dev) && sm_supported(iommu)) {
 		ret = intel_pasid_alloc_table(dev);
 		if (ret) {
-			pr_warn("No pasid table for %s, pasid disabled\n",
-				dev_name(dev));
-			info->pasid_supported = 0;
+			__dmar_remove_one_dev_info(info);
+			spin_unlock_irqrestore(&device_domain_lock, flags);
+			return NULL;
 		}
 	}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index fe95c9bd4d33..aeae209ec1b7 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -123,12 +123,12 @@ int intel_pasid_alloc_table(struct device *dev)
 	struct pasid_table *pasid_table;
 	struct pasid_table_opaque data;
 	struct page *pages;
-	size_t size, count;
+	int max_pasid = 0;
 	int ret, order;
+	int size;
 
 	info = dev->archdata.iommu;
-	if (WARN_ON(!info || !dev_is_pci(dev) ||
-		    !info->pasid_supported || info->pasid_table))
+	if (WARN_ON(!info || !dev_is_pci(dev) || info->pasid_table))
 		return -EINVAL;
 
 	/* DMA alias device already has a pasid table, use it: */
@@ -143,18 +143,20 @@ int intel_pasid_alloc_table(struct device *dev)
 		return -ENOMEM;
 	INIT_LIST_HEAD(&pasid_table->dev);
 
-	size = sizeof(struct pasid_entry);
-	count = min_t(int, pci_max_pasids(to_pci_dev(dev)), intel_pasid_max_id);
-	order = get_order(size * count);
+	if (info->pasid_supported)
+		max_pasid = min_t(int, pci_max_pasids(to_pci_dev(dev)),
+				  intel_pasid_max_id);
+
+	size = max_pasid >> (PASID_PDE_SHIFT - 3);
+	order = size ? get_order(size) : 0;
 	pages = alloc_pages_node(info->iommu->node,
-				 GFP_ATOMIC | __GFP_ZERO,
-				 order);
+				 GFP_ATOMIC | __GFP_ZERO, order);
 	if (!pages)
 		return -ENOMEM;
 
 	pasid_table->table = page_address(pages);
 	pasid_table->order = order;
-	pasid_table->max_pasid = count;
+	pasid_table->max_pasid = 1 << (order + PAGE_SHIFT + 3);
 
 attach_out:
 	device_attach_pasid_table(info, pasid_table);
@@ -162,14 +164,33 @@ int intel_pasid_alloc_table(struct device *dev)
 	return 0;
 }
 
+/* Get PRESENT bit of a PASID directory entry. */
+static inline bool
+pasid_pde_is_present(struct pasid_dir_entry *pde)
+{
+	return READ_ONCE(pde->val) & PASID_PTE_PRESENT;
+}
+
+/* Get PASID table from a PASID directory entry. */
+static inline struct pasid_entry *
+get_pasid_table_from_pde(struct pasid_dir_entry *pde)
+{
+	if (!pasid_pde_is_present(pde))
+		return NULL;
+
+	return phys_to_virt(READ_ONCE(pde->val) & PDE_PFN_MASK);
+}
+
 void intel_pasid_free_table(struct device *dev)
 {
 	struct device_domain_info *info;
 	struct pasid_table *pasid_table;
+	struct pasid_dir_entry *dir;
+	struct pasid_entry *table;
+	int i, max_pde;
 
 	info = dev->archdata.iommu;
-	if (!info || !dev_is_pci(dev) ||
-	    !info->pasid_supported || !info->pasid_table)
+	if (!info || !dev_is_pci(dev) || !info->pasid_table)
 		return;
 
 	pasid_table = info->pasid_table;
@@ -178,6 +199,14 @@ void intel_pasid_free_table(struct device *dev)
 	if (!list_empty(&pasid_table->dev))
 		return;
 
+	/* Free scalable mode PASID directory tables: */
+	dir = pasid_table->table;
+	max_pde = pasid_table->max_pasid >> PASID_PDE_SHIFT;
+	for (i = 0; i < max_pde; i++) {
+		table = get_pasid_table_from_pde(&dir[i]);
+		free_pgtable_page(table);
+	}
+
 	free_pages((unsigned long)pasid_table->table, pasid_table->order);
 	kfree(pasid_table);
 }
@@ -206,17 +235,37 @@ int intel_pasid_get_dev_max_id(struct device *dev)
 
 struct pasid_entry *intel_pasid_get_entry(struct device *dev, int pasid)
 {
+	struct device_domain_info *info;
 	struct pasid_table *pasid_table;
+	struct pasid_dir_entry *dir;
 	struct pasid_entry *entries;
+	int dir_index, index;
 
 	pasid_table = intel_pasid_get_table(dev);
 	if (WARN_ON(!pasid_table || pasid < 0 ||
 		    pasid >= intel_pasid_get_dev_max_id(dev)))
 		return NULL;
 
-	entries = pasid_table->table;
+	dir = pasid_table->table;
+	info = dev->archdata.iommu;
+	dir_index = pasid >> PASID_PDE_SHIFT;
+	index = pasid & PASID_PTE_MASK;
+
+	spin_lock(&pasid_lock);
+	entries = get_pasid_table_from_pde(&dir[dir_index]);
+	if (!entries) {
+		entries = alloc_pgtable_page(info->iommu->node);
+		if (!entries) {
+			spin_unlock(&pasid_lock);
+			return NULL;
+		}
+
+		WRITE_ONCE(dir[dir_index].val,
+			   (u64)virt_to_phys(entries) | PASID_PTE_PRESENT);
+	}
+	spin_unlock(&pasid_lock);
 
-	return &entries[pasid];
+	return &entries[index];
 }
 
 /*
@@ -224,7 +273,14 @@ struct pasid_entry *intel_pasid_get_entry(struct device *dev, int pasid)
  */
 static inline void pasid_clear_entry(struct pasid_entry *pe)
 {
-	WRITE_ONCE(pe->val, 0);
+	WRITE_ONCE(pe->val[0], 0);
+	WRITE_ONCE(pe->val[1], 0);
+	WRITE_ONCE(pe->val[2], 0);
+	WRITE_ONCE(pe->val[3], 0);
+	WRITE_ONCE(pe->val[4], 0);
+	WRITE_ONCE(pe->val[5], 0);
+	WRITE_ONCE(pe->val[6], 0);
+	WRITE_ONCE(pe->val[7], 0);
 }
 
 void intel_pasid_clear_entry(struct device *dev, int pasid)
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index 1fb5e12b029a..12f480c2bb8b 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -11,12 +11,20 @@
 #define __INTEL_PASID_H
 
 #define PASID_MIN			0x1
-#define PASID_MAX			0x20000
+#define PASID_MAX			0x100000
+#define PASID_PTE_MASK			0x3F
+#define PASID_PTE_PRESENT		1
+#define PDE_PFN_MASK			PAGE_MASK
+#define PASID_PDE_SHIFT			6
 
-struct pasid_entry {
+struct pasid_dir_entry {
 	u64 val;
 };
 
+struct pasid_entry {
+	u64 val[8];
+};
+
 /* The representative of a PASID table */
 struct pasid_table {
 	void			*table;		/* pasid table pointer */
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 887150907526..9014b07ab975 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -65,8 +65,6 @@ int intel_svm_init(struct intel_iommu *iommu)
 
 	order = get_order(sizeof(struct pasid_entry) * iommu->pasid_max);
 	if (ecap_dis(iommu->ecap)) {
-		/* Just making it explicit... */
-		BUILD_BUG_ON(sizeof(struct pasid_entry) != sizeof(struct pasid_state_entry));
 		pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
 		if (pages)
 			iommu->pasid_state_table = page_address(pages);
@@ -405,9 +403,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 			pasid_entry_val |= PASID_ENTRY_FLPM_5LP;
 
 		entry = intel_pasid_get_entry(dev, svm->pasid);
-		entry->val = pasid_entry_val;
-
-		wmb();
+		WRITE_ONCE(entry->val[0], pasid_entry_val);
 
 		/*
 		 * Flush PASID cache when a PASID table entry becomes
-- 
2.17.1

