Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30D3C65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 02:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765CC2064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 02:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 765CC2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbeLJCD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 21:03:27 -0500
Received: from mga06.intel.com ([134.134.136.31]:8030 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbeLJCC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 21:02:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2018 18:02:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,336,1539673200"; 
   d="scan'208";a="300767191"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by fmsmga006.fm.intel.com with ESMTP; 09 Dec 2018 18:02:56 -0800
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
Subject: [PATCH v6 08/12] iommu/vt-d: Pass pasid table to context mapping
Date:   Mon, 10 Dec 2018 09:59:02 +0800
Message-Id: <20181210015906.27929-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181210015906.27929-1-baolu.lu@linux.intel.com>
References: <20181210015906.27929-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that the pasid related info, such as the pasid table and the
maximum of pasid could be used during setting up scalable mode
context.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Cc: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel-iommu.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a077ff3f67a6..55c4ffda1246 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1920,6 +1920,7 @@ static void domain_exit(struct dmar_domain *domain)
 
 static int domain_context_mapping_one(struct dmar_domain *domain,
 				      struct intel_iommu *iommu,
+				      struct pasid_table *table,
 				      u8 bus, u8 devfn)
 {
 	u16 did = domain->iommu_did[iommu->seq_id];
@@ -2042,6 +2043,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 struct domain_context_mapping_data {
 	struct dmar_domain *domain;
 	struct intel_iommu *iommu;
+	struct pasid_table *table;
 };
 
 static int domain_context_mapping_cb(struct pci_dev *pdev,
@@ -2050,25 +2052,31 @@ static int domain_context_mapping_cb(struct pci_dev *pdev,
 	struct domain_context_mapping_data *data = opaque;
 
 	return domain_context_mapping_one(data->domain, data->iommu,
-					  PCI_BUS_NUM(alias), alias & 0xff);
+					  data->table, PCI_BUS_NUM(alias),
+					  alias & 0xff);
 }
 
 static int
 domain_context_mapping(struct dmar_domain *domain, struct device *dev)
 {
+	struct domain_context_mapping_data data;
+	struct pasid_table *table;
 	struct intel_iommu *iommu;
 	u8 bus, devfn;
-	struct domain_context_mapping_data data;
 
 	iommu = device_to_iommu(dev, &bus, &devfn);
 	if (!iommu)
 		return -ENODEV;
 
+	table = intel_pasid_get_table(dev);
+
 	if (!dev_is_pci(dev))
-		return domain_context_mapping_one(domain, iommu, bus, devfn);
+		return domain_context_mapping_one(domain, iommu, table,
+						  bus, devfn);
 
 	data.domain = domain;
 	data.iommu = iommu;
+	data.table = table;
 
 	return pci_for_each_dma_alias(to_pci_dev(dev),
 				      &domain_context_mapping_cb, &data);
-- 
2.17.1

