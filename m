Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339E3ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 06:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E551320880
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 06:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E551320880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbeGVHGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 03:06:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:8994 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbeGVHGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 03:06:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jul 2018 23:11:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,388,1526367600"; 
   d="scan'208";a="218015822"
Received: from allen-box.sh.intel.com ([10.239.48.172])
  by orsmga004.jf.intel.com with ESMTP; 21 Jul 2018 23:11:12 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        yi.y.sun@intel.com, peterx@redhat.com,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [RFC PATCH 02/10] iommu/vt-d: Alloc domain for a mediated device
Date:   Sun, 22 Jul 2018 14:09:25 +0800
Message-Id: <1532239773-15325-3-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PASID-granular 2nd level address translation makes it possible
to isolate and protect a mediated device exposed by a real device
which support PCI PASID features. This patch adds support to allocate
a domain for a mediated device. A default pasid value will be
allocated as well for the mediated device. This will be used by the
mediated device attached to this domain for non-SVM DMA transactions.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 17 ++++++++++++++++-
 include/linux/intel-iommu.h |  5 +++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index fc3ac1c..3ede34a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1926,6 +1926,9 @@ static void domain_exit(struct dmar_domain *domain)
 	domain_remove_dev_info(domain);
 	rcu_read_unlock();
 
+	if (domain->default_pasid > 0)
+		intel_pasid_free_id(domain->default_pasid);
+
 	/* destroy iovas */
 	put_iova_domain(&domain->iovad);
 
@@ -2519,11 +2522,23 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		}
 	}
 
+	if (dev && dev_is_mdev(dev) && domain->default_pasid <= 0) {
+		int max = intel_pasid_get_dev_max_id(dev_mdev_parent(dev));
+
+		domain->default_pasid = intel_pasid_alloc_id(domain, PASID_MIN,
+							     max, GFP_KERNEL);
+		if (domain->default_pasid < 0) {
+			free_devinfo_mem(info);
+			return NULL;
+		}
+	}
+
 	spin_lock_irqsave(&device_domain_lock, flags);
 	if (dev)
 		found = find_domain(dev);
 
-	if (!found) {
+	/* A mediated device never has an DMA alias. Ignore searching. */
+	if (!found && !dev_is_mdev(dev)) {
 		struct device_domain_info *info2;
 		info2 = dmar_search_domain_by_dev_info(iommu->segment, bus, devfn);
 		if (info2) {
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 7efc632..9f5dcf6 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -423,6 +423,11 @@ struct dmar_domain {
 					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
 	u64		max_addr;	/* maximum mapped address */
 
+	int		default_pasid;	/*
+					 * The default pasid used for non-SVM
+					 * traffic on mediated devices.
+					 */
+
 	struct iommu_domain domain;	/* generic domain data structure for
 					   iommu core */
 };
-- 
2.7.4

