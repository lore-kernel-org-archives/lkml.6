Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12D9ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7170020864
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7170020864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbeGPH0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 03:26:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:45301 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727540AbeGPH0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 03:26:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 00:00:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,360,1526367600"; 
   d="scan'208";a="72647303"
Received: from allen-box.sh.intel.com ([10.239.48.172])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jul 2018 00:00:24 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        yi.y.sun@intel.com, peterx@redhat.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 06/10] iommu/vt-d: Pass pasid table to context mapping
Date:   Mon, 16 Jul 2018 14:49:49 +0800
Message-Id: <1531723793-14607-7-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531723793-14607-1-git-send-email-baolu.lu@linux.intel.com>
References: <1531723793-14607-1-git-send-email-baolu.lu@linux.intel.com>
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
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/intel-iommu.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 62e9579..add7e3e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1918,6 +1918,7 @@ static void domain_exit(struct dmar_domain *domain)
 
 static int domain_context_mapping_one(struct dmar_domain *domain,
 				      struct intel_iommu *iommu,
+				      struct pasid_table *table,
 				      u8 bus, u8 devfn)
 {
 	u16 did = domain->iommu_did[iommu->seq_id];
@@ -2040,6 +2041,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 struct domain_context_mapping_data {
 	struct dmar_domain *domain;
 	struct intel_iommu *iommu;
+	struct pasid_table *table;
 };
 
 static int domain_context_mapping_cb(struct pci_dev *pdev,
@@ -2048,25 +2050,31 @@ static int domain_context_mapping_cb(struct pci_dev *pdev,
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
2.7.4

