Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FDBC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A1920661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A1920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756158AbeFSF21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:28:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:14970 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752308AbeFSF10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:27:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 22:27:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,242,1526367600"; 
   d="scan'208";a="50424324"
Received: from allen-box.sh.intel.com ([10.239.48.172])
  by orsmga008.jf.intel.com with ESMTP; 18 Jun 2018 22:27:23 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        yi.y.sun@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 5/9] iommu/vt-d: Add for_each_device_domain() helper
Date:   Tue, 19 Jun 2018 13:17:25 +0800
Message-Id: <1529385449-25649-6-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529385449-25649-1-git-send-email-baolu.lu@linux.intel.com>
References: <1529385449-25649-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a helper named for_each_device_domain() to iterate
over the elements in device_domain_list and invoke a callback
against each element. This allows to search the device_domain
list in other source files.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/intel-iommu.c | 21 +++++++++++++++++++++
 include/linux/intel-iommu.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index d9a8222..aea182d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -448,6 +448,27 @@ EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
 static DEFINE_SPINLOCK(device_domain_lock);
 static LIST_HEAD(device_domain_list);
 
+/*
+ * Iterate over elements in device_domain_list and call the specified
+ * callback @fn against each element. This helper should only be used
+ * in the context where the device_domain_lock has already been holden.
+ */
+int for_each_device_domain(int (*fn)(struct device_domain_info *info,
+				     void *data), void *data)
+{
+	int ret = 0;
+	struct device_domain_info *info;
+
+	assert_spin_locked(&device_domain_lock);
+	list_for_each_entry(info, &device_domain_list, global) {
+		ret = fn(info, data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 const struct iommu_ops intel_iommu_ops;
 
 static bool translation_pre_enabled(struct intel_iommu *iommu)
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 3598dc0f..d52013e 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -525,6 +525,8 @@ struct dmar_domain *get_valid_domain_for_dev(struct device *dev);
 void *alloc_pgtable_page(int node);
 void free_pgtable_page(void *vaddr);
 struct intel_iommu *domain_get_iommu(struct dmar_domain *domain);
+int for_each_device_domain(int (*fn)(struct device_domain_info *info,
+				     void *data), void *data);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 extern int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu);
-- 
2.7.4

