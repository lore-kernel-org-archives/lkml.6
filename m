Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A37C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D58120661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D58120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937293AbeFSF1c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:27:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:14970 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755777AbeFSF12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:27:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 22:27:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,242,1526367600"; 
   d="scan'208";a="50424329"
Received: from allen-box.sh.intel.com ([10.239.48.172])
  by orsmga008.jf.intel.com with ESMTP; 18 Jun 2018 22:27:25 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        yi.y.sun@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 6/9] iommu/vt-d: Per PCI device pasid table interfaces
Date:   Tue, 19 Jun 2018 13:17:26 +0800
Message-Id: <1529385449-25649-7-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529385449-25649-1-git-send-email-baolu.lu@linux.intel.com>
References: <1529385449-25649-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the interfaces for per PCI device pasid
table management. Currently we allocate one pasid table
for all PCI devices under the scope of an IOMMU. It's
insecure in some cases where multiple devices under one
single IOMMU unit support PASID features. With per PCI
device pasid table, we can achieve finer protection and
isolation granularity.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/intel-iommu.c |   1 +
 drivers/iommu/intel-pasid.c | 178 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-pasid.h |  18 +++++
 drivers/iommu/intel-svm.c   |   4 -
 include/linux/intel-iommu.h |   2 +
 5 files changed, 199 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index aea182d..44ce77a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2436,6 +2436,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	info->dev = dev;
 	info->domain = domain;
 	info->iommu = iommu;
+	info->pasid_table = NULL;
 
 	if (dev && dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(info->dev);
diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index e918fe0..1b61942 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -13,6 +13,8 @@
 #include <linux/intel-iommu.h>
 #include <linux/iommu.h>
 #include <linux/memory.h>
+#include <linux/pci.h>
+#include <linux/pci-ats.h>
 #include <linux/spinlock.h>
 
 #include "intel-pasid.h"
@@ -58,3 +60,179 @@ void *intel_pasid_lookup_id(int pasid)
 
 	return p;
 }
+
+/*
+ * Per device pasid table management:
+ */
+static inline void
+device_attach_pasid_table(struct device_domain_info *info,
+			  struct pasid_table *pasid_table)
+{
+	info->pasid_table = pasid_table;
+	list_add(&info->table, &pasid_table->dev);
+}
+
+static inline void
+device_detach_pasid_table(struct device_domain_info *info,
+			  struct pasid_table *pasid_table)
+{
+	info->pasid_table = NULL;
+	list_del(&info->table);
+}
+
+struct pasid_table_opaque {
+	struct pasid_table	**pasid_table;
+	int			segment;
+	int			bus;
+	int			devfn;
+};
+
+static int search_pasid_table(struct device_domain_info *info, void *opaque)
+{
+	struct pasid_table_opaque *data = opaque;
+
+	if (info->iommu->segment == data->segment &&
+	    info->bus == data->bus &&
+	    info->devfn == data->devfn &&
+	    info->pasid_table) {
+		*data->pasid_table = info->pasid_table;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int get_alias_pasid_table(struct pci_dev *pdev, u16 alias, void *opaque)
+{
+	struct pasid_table_opaque *data = opaque;
+
+	data->segment = pci_domain_nr(pdev->bus);
+	data->bus = PCI_BUS_NUM(alias);
+	data->devfn = alias & 0xff;
+
+	return for_each_device_domain(&search_pasid_table, data);
+}
+
+int intel_pasid_alloc_table(struct device *dev)
+{
+	struct device_domain_info *info;
+	struct pasid_table *pasid_table;
+	struct pasid_table_opaque data;
+	struct page *pages;
+	size_t size, count;
+	int ret, order;
+
+	info = dev->archdata.iommu;
+	if (WARN_ON(!info || !dev_is_pci(dev) ||
+		    !info->pasid_supported || info->pasid_table))
+		return -EINVAL;
+
+	/* DMA alias device already has a pasid table, use it: */
+	data.pasid_table = &pasid_table;
+	ret = pci_for_each_dma_alias(to_pci_dev(dev),
+				     &get_alias_pasid_table, &data);
+	if (ret)
+		goto attach_out;
+
+	pasid_table = kzalloc(sizeof(*pasid_table), GFP_ATOMIC);
+	if (!pasid_table)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&pasid_table->dev);
+
+	size = sizeof(struct pasid_entry);
+	count = min_t(int, pci_max_pasids(to_pci_dev(dev)), intel_pasid_max_id);
+	order = get_order(size * count);
+	pages = alloc_pages_node(info->iommu->node,
+				 GFP_ATOMIC | __GFP_ZERO,
+				 order);
+	if (!pages)
+		return -ENOMEM;
+
+	pasid_table->table = page_address(pages);
+	pasid_table->order = order;
+	pasid_table->max_pasid = count;
+
+attach_out:
+	device_attach_pasid_table(info, pasid_table);
+
+	return 0;
+}
+
+void intel_pasid_free_table(struct device *dev)
+{
+	struct device_domain_info *info;
+	struct pasid_table *pasid_table;
+
+	info = dev->archdata.iommu;
+	if (!info || !dev_is_pci(dev) ||
+	    !info->pasid_supported || !info->pasid_table)
+		return;
+
+	pasid_table = info->pasid_table;
+	device_detach_pasid_table(info, pasid_table);
+
+	if (!list_empty(&pasid_table->dev))
+		return;
+
+	free_pages((unsigned long)pasid_table->table, pasid_table->order);
+	kfree(pasid_table);
+}
+
+struct pasid_table *intel_pasid_get_table(struct device *dev)
+{
+	struct device_domain_info *info;
+
+	info = dev->archdata.iommu;
+	if (!info)
+		return NULL;
+
+	return info->pasid_table;
+}
+
+int intel_pasid_get_dev_max_id(struct device *dev)
+{
+	struct device_domain_info *info;
+
+	info = dev->archdata.iommu;
+	if (!info || !info->pasid_table)
+		return 0;
+
+	return info->pasid_table->max_pasid;
+}
+
+struct pasid_entry *intel_pasid_get_entry(struct device *dev, int pasid)
+{
+	struct pasid_table *pasid_table;
+	struct pasid_entry *entries;
+
+	pasid_table = intel_pasid_get_table(dev);
+	if (WARN_ON(!pasid_table || pasid < 0 ||
+		    pasid >= intel_pasid_get_dev_max_id(dev)))
+		return NULL;
+
+	entries = pasid_table->table;
+
+	return &entries[pasid];
+}
+
+/*
+ * Interfaces for PASID table entry manipulation:
+ */
+static void sm_pasid_clear_entry(struct pasid_entry *pe)
+{
+	memset(pe, 0, sizeof(struct pasid_entry));
+}
+
+void intel_pasid_clear_entry(struct device *dev, int pasid)
+{
+	struct pasid_entry *pe;
+
+	pe = intel_pasid_get_entry(dev, pasid);
+	if (WARN_ON(!pe))
+		return;
+
+	sm_pasid_clear_entry(pe);
+
+	/* Make sure the entry update is visible before translation. */
+	wmb();
+}
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index d5feb3d..1fb5e12 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -13,9 +13,27 @@
 #define PASID_MIN			0x1
 #define PASID_MAX			0x20000
 
+struct pasid_entry {
+	u64 val;
+};
+
+/* The representative of a PASID table */
+struct pasid_table {
+	void			*table;		/* pasid table pointer */
+	int			order;		/* page order of pasid table */
+	int			max_pasid;	/* max pasid */
+	struct list_head	dev;		/* device list */
+};
+
 extern u32 intel_pasid_max_id;
 int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp);
 void intel_pasid_free_id(int pasid);
 void *intel_pasid_lookup_id(int pasid);
+int intel_pasid_alloc_table(struct device *dev);
+void intel_pasid_free_table(struct device *dev);
+struct pasid_table *intel_pasid_get_table(struct device *dev);
+int intel_pasid_get_dev_max_id(struct device *dev);
+struct pasid_entry *intel_pasid_get_entry(struct device *dev, int pasid);
+void intel_pasid_clear_entry(struct device *dev, int pasid);
 
 #endif /* __INTEL_PASID_H */
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 56e65d0..9b5dc72 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -34,10 +34,6 @@
 
 static irqreturn_t prq_event_thread(int irq, void *d);
 
-struct pasid_entry {
-	u64 val;
-};
-
 struct pasid_state_entry {
 	u64 val;
 };
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index d52013e..8ec22b3 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -481,6 +481,7 @@ struct intel_iommu {
 struct device_domain_info {
 	struct list_head link;	/* link to domain siblings */
 	struct list_head global; /* link to global list */
+	struct list_head table;	/* link to pasid table */
 	u8 bus;			/* PCI bus number */
 	u8 devfn;		/* PCI devfn number */
 	u8 pasid_supported:3;
@@ -493,6 +494,7 @@ struct device_domain_info {
 	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
 	struct intel_iommu *iommu; /* IOMMU used by this device */
 	struct dmar_domain *domain; /* pointer to domain */
+	struct pasid_table *pasid_table; /* pasid table */
 };
 
 static inline void __iommu_flush_cache(
-- 
2.7.4

