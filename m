Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BFEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233302175B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 233302175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbeKLQj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 11:39:57 -0500
Received: from mga17.intel.com ([192.55.52.151]:53355 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731284AbeKLQjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 11:39:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2018 22:48:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,494,1534834800"; 
   d="scan'208";a="88579665"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by orsmga007.jf.intel.com with ESMTP; 11 Nov 2018 22:47:57 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com,
        tiwei.bie@intel.com, Zeng Xin <xin.zeng@intel.com>,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [RFC PATCH 2/5] iommu/vt-d: Initialize a PASID consumer
Date:   Mon, 12 Nov 2018 14:44:58 +0800
Message-Id: <20181112064501.2290-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181112064501.2290-1-baolu.lu@linux.intel.com>
References: <20181112064501.2290-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the Intel vt-d specific ops to initialize a PASID
consumer.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 49a278a699b0..769b7059d52f 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5597,6 +5597,35 @@ static int intel_iommu_domain_get_attr(struct iommu_domain *domain,
 	return ret;
 }
 
+static int intel_iommu_pasid_init(struct iommu_pasid *pasid)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu = NULL, *temp;
+
+	/*
+	 *  Iterate the iommu units and get a scalable mode capable one
+	 *  for virtual command usages. Return failure if scalable mode
+	 *  doesn't support by any unit.
+	 */
+	rcu_read_lock();
+	for_each_active_iommu(temp, drhd) {
+		if (sm_supported(temp)) {
+			iommu = temp;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	if (!iommu)
+		return -ENODEV;
+
+	pasid->max = intel_pasid_max_id;
+	pasid->min = PASID_MIN;
+	pasid->priv = iommu;
+
+	return 0;
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -5616,6 +5645,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.domain_get_attr	= intel_iommu_domain_get_attr,
 	.get_dev_attr		= intel_iommu_get_dev_attr,
 	.set_dev_attr		= intel_iommu_set_dev_attr,
+	.pasid_init		= intel_iommu_pasid_init,
 	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
 };
 
-- 
2.17.1

