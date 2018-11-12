Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1097C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9225321722
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9225321722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732051AbeKLQkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 11:40:01 -0500
Received: from mga17.intel.com ([192.55.52.151]:53355 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731284AbeKLQkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 11:40:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2018 22:48:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,494,1534834800"; 
   d="scan'208";a="88579707"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by orsmga007.jf.intel.com with ESMTP; 11 Nov 2018 22:48:04 -0800
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
Subject: [RFC PATCH 4/5] iommu/vt-d: Allocate and free a pasid
Date:   Mon, 12 Nov 2018 14:45:00 +0800
Message-Id: <20181112064501.2290-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181112064501.2290-1-baolu.lu@linux.intel.com>
References: <20181112064501.2290-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the Intel vt-d specific ops to allocate and free a
pasid value.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 769b7059d52f..8dbd0c601dab 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5626,6 +5626,37 @@ static int intel_iommu_pasid_init(struct iommu_pasid *pasid)
 	return 0;
 }
 
+static int intel_iommu_pasid_alloc(struct iommu_pasid *pasid, ioasid_t start,
+				   ioasid_t end, ioasid_t *ioasid)
+{
+	struct intel_iommu *iommu;
+
+	iommu = pasid->priv;
+	if (!iommu)
+		return -EINVAL;
+
+	/*
+	 * In caching mode, PASID ID should be allocated and freed
+	 * through the virtual command registers. Otherwise, rely
+	 * on the iommu global idr.
+	 */
+	if (!cap_caching_mode(iommu->cap))
+		return -EAGAIN;
+
+	return vcmd_alloc_pasid(iommu, ioasid);
+}
+
+static void intel_iommu_pasid_free(struct iommu_pasid *pasid, ioasid_t ioasid)
+{
+	struct intel_iommu *iommu;
+
+	iommu = pasid->priv;
+	if (!iommu || !cap_caching_mode(iommu->cap))
+		return;
+
+	vcmd_free_pasid(iommu, ioasid);
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -5646,6 +5677,8 @@ const struct iommu_ops intel_iommu_ops = {
 	.get_dev_attr		= intel_iommu_get_dev_attr,
 	.set_dev_attr		= intel_iommu_set_dev_attr,
 	.pasid_init		= intel_iommu_pasid_init,
+	.pasid_alloc		= intel_iommu_pasid_alloc,
+	.pasid_free		= intel_iommu_pasid_free,
 	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
 };
 
-- 
2.17.1

