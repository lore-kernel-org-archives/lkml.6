Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id jyLyFstAGFvuQgAAmS7hNA
	; Wed, 06 Jun 2018 20:15:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3B6EA608BF; Wed,  6 Jun 2018 20:15:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9C00260290;
	Wed,  6 Jun 2018 20:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9C00260290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbeFFUPF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 16:15:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:10537 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752030AbeFFUPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 16:15:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2018 13:15:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,484,1520924400";
   d="scan'208";a="205903723"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga004.jf.intel.com with ESMTP; 06 Jun 2018 13:15:02 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc: Raj Ashok <ashok.raj@intel.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 1/2] iommu/vt-d: add definitions for PFSID
Date: Wed,  6 Jun 2018 13:17:59 -0700
Message-Id: <1528316280-24307-2-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528316280-24307-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1528316280-24307-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SRIOV VF device IOTLB is invalidated, we need to provide
the PF source ID such that IOMMU hardware can gauge the depth
of invalidation queue which is shared among VFs. This is needed
when device invalidation throttle (DIT) capability is supported.

This patch adds bit definitions for checking and tracking PFSID.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 1 +
 include/linux/intel-iommu.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 749d8f2..3d77d61 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -422,6 +422,7 @@ struct device_domain_info {
 	struct list_head global; /* link to global list */
 	u8 bus;			/* PCI bus number */
 	u8 devfn;		/* PCI devfn number */
+	u16 pfsid;		/* SRIOV physical function source ID */
 	u8 pasid_supported:3;
 	u8 pasid_enabled:1;
 	u8 pri_supported:1;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index ef169d6..af1c05f 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -114,6 +114,7 @@
  * Extended Capability Register
  */
 
+#define ecap_dit(e)		((e >> 41) & 0x1)
 #define ecap_pasid(e)		((e >> 40) & 0x1)
 #define ecap_pss(e)		((e >> 35) & 0x1f)
 #define ecap_eafs(e)		((e >> 34) & 0x1)
@@ -284,6 +285,7 @@ enum {
 #define QI_DEV_IOTLB_SID(sid)	((u64)((sid) & 0xffff) << 32)
 #define QI_DEV_IOTLB_QDEP(qdep)	(((qdep) & 0x1f) << 16)
 #define QI_DEV_IOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
+#define QI_DEV_IOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | ((u64)(pfsid & 0xfff) << 52))
 #define QI_DEV_IOTLB_SIZE	1
 #define QI_DEV_IOTLB_MAX_INVS	32
 
@@ -308,6 +310,7 @@ enum {
 #define QI_DEV_EIOTLB_PASID(p)	(((u64)p) << 32)
 #define QI_DEV_EIOTLB_SID(sid)	((u64)((sid) & 0xffff) << 16)
 #define QI_DEV_EIOTLB_QDEP(qd)	((u64)((qd) & 0x1f) << 4)
+#define QI_DEV_EIOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | ((u64)(pfsid & 0xfff) << 52))
 #define QI_DEV_EIOTLB_MAX_INVS	32
 
 #define QI_PGRP_IDX(idx)	(((u64)(idx)) << 55)
-- 
2.7.4
