Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8E7C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 05:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E09E204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 05:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E09E204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbeKEOw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 09:52:29 -0500
Received: from mga12.intel.com ([192.55.52.136]:13964 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728921AbeKEOw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 09:52:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 21:34:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,466,1534834800"; 
   d="scan'208";a="105288982"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by fmsmga001.fm.intel.com with ESMTP; 04 Nov 2018 21:34:33 -0800
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
Subject: [PATCH v4 05/12] iommu/vt-d: Reserve a domain id for FL and PT modes
Date:   Mon,  5 Nov 2018 13:31:44 +0800
Message-Id: <20181105053151.7173-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181105053151.7173-1-baolu.lu@linux.intel.com>
References: <20181105053151.7173-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vt-d spec rev3.0 (section 6.2.3.1) requires that each pasid
entry for first-level or pass-through translation should be
programmed with a domain id different from those used for
second-level or nested translation. It is recommended that
software could use a same domain id for all first-only and
pass-through translations.

This reserves a domain id for first-level and pass-through
translations.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Cc: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 10 ++++++++++
 drivers/iommu/intel-pasid.h |  6 ++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 9331240c70b8..2f7455ee4e7a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1618,6 +1618,16 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 	 */
 	set_bit(0, iommu->domain_ids);
 
+	/*
+	 * Vt-d spec rev3.0 (section 6.2.3.1) requires that each pasid
+	 * entry for first-level or pass-through translation modes should
+	 * be programmed with a domain id different from those used for
+	 * second-level or nested translation. We reserve a domain id for
+	 * this purpose.
+	 */
+	if (sm_supported(iommu))
+		set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
+
 	return 0;
 }
 
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index 12f480c2bb8b..03c1612d173c 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -17,6 +17,12 @@
 #define PDE_PFN_MASK			PAGE_MASK
 #define PASID_PDE_SHIFT			6
 
+/*
+ * Domain ID reserved for pasid entries programmed for first-level
+ * only and pass-through transfer modes.
+ */
+#define FLPT_DEFAULT_DID		1
+
 struct pasid_dir_entry {
 	u64 val;
 };
-- 
2.17.1

