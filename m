Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8808C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 06:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A524C20874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 06:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A524C20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbeGVHGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 03:06:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:8994 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbeGVHGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 03:06:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jul 2018 23:11:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,388,1526367600"; 
   d="scan'208";a="218015809"
Received: from allen-box.sh.intel.com ([10.239.48.172])
  by orsmga004.jf.intel.com with ESMTP; 21 Jul 2018 23:11:08 -0700
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
Subject: [RFC PATCH 01/10] iommu/vt-d: Get iommu device for a mediated device
Date:   Sun, 22 Jul 2018 14:09:24 +0800
Message-Id: <1532239773-15325-2-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the support to get the iommu device for a mediated
device. The assumption is that each mediated device is a minimal
assignable set of a physical PCI device. Hence, we should use the
iommu device of the parent PCI device to manage the translation.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c |  6 ++++++
 drivers/iommu/intel-pasid.h | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 7d198ea..fc3ac1c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -767,6 +767,12 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
 	if (iommu_dummy(dev))
 		return NULL;
 
+	if (dev_is_mdev(dev)) {
+		dev = dev_mdev_parent(dev);
+		if (WARN_ON(!dev_is_pci(dev)))
+			return NULL;
+	}
+
 	if (dev_is_pci(dev)) {
 		struct pci_dev *pf_pdev;
 
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index 518df72..46cde66 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -35,6 +35,22 @@ struct pasid_table {
 	struct list_head	dev;		/* device list */
 };
 
+static inline bool dev_is_mdev(struct device *dev)
+{
+	if (!dev)
+		return false;
+
+	return !strcmp(dev->bus->name, "mdev");
+}
+
+static inline struct device *dev_mdev_parent(struct device *dev)
+{
+	if (WARN_ON(!dev_is_mdev(dev)))
+		return NULL;
+
+	return dev->parent;
+}
+
 extern u32 intel_pasid_max_id;
 int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp);
 void intel_pasid_free_id(int pasid);
-- 
2.7.4

