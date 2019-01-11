Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9395C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAC320874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbfAKFJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:09:16 -0500
Received: from mga01.intel.com ([192.55.52.88]:42647 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727900AbfAKFJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:09:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2019 21:09:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,464,1539673200"; 
   d="scan'208";a="290694027"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by orsmga005.jf.intel.com with ESMTP; 10 Jan 2019 21:09:13 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Support page request in scalable mode
Date:   Fri, 11 Jan 2019 13:04:57 +0800
Message-Id: <20190111050457.27234-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

VT-d Rev3.0 has made a few changes to the page request interface,

1. widened PRQ descriptor from 128 bits to 256 bits;
2. removed streaming response type;
3. introduced private data that requires page response even the
   request is not last request in group (LPIG).

This is a supplement to commit 1c4f88b7f1f92 ("iommu/vt-d: Shared
virtual address in scalable mode") and makes the svm code compliant
with VT-d Rev3.0.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Fixes: 1c4f88b7f1f92 ("iommu/vt-d: Shared virtual address in scalable mode")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-svm.c   | 77 ++++++++++++++++++++++---------------
 include/linux/intel-iommu.h | 21 +++++-----
 include/linux/intel-svm.h   |  2 +-
 3 files changed, 55 insertions(+), 45 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index a2a2aa4439aa..79add5716552 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -470,20 +470,31 @@ EXPORT_SYMBOL_GPL(intel_svm_is_pasid_valid);
 
 /* Page request queue descriptor */
 struct page_req_dsc {
-	u64 srr:1;
-	u64 bof:1;
-	u64 pasid_present:1;
-	u64 lpig:1;
-	u64 pasid:20;
-	u64 bus:8;
-	u64 private:23;
-	u64 prg_index:9;
-	u64 rd_req:1;
-	u64 wr_req:1;
-	u64 exe_req:1;
-	u64 priv_req:1;
-	u64 devfn:8;
-	u64 addr:52;
+	union {
+		struct {
+			u64 type:8;
+			u64 pasid_present:1;
+			u64 priv_data_present:1;
+			u64 rsvd:6;
+			u64 rid:16;
+			u64 pasid:20;
+			u64 exe_req:1;
+			u64 pm_req:1;
+			u64 rsvd2:10;
+		};
+		u64 qw_0;
+	};
+	union {
+		struct {
+			u64 rd_req:1;
+			u64 wr_req:1;
+			u64 lpig:1;
+			u64 prg_index:9;
+			u64 addr:52;
+		};
+		u64 qw_1;
+	};
+	u64 priv_data[2];
 };
 
 #define PRQ_RING_MASK ((0x1000 << PRQ_ORDER) - 0x10)
@@ -596,7 +607,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		/* Accounting for major/minor faults? */
 		rcu_read_lock();
 		list_for_each_entry_rcu(sdev, &svm->devs, list) {
-			if (sdev->sid == PCI_DEVID(req->bus, req->devfn))
+			if (sdev->sid == req->rid)
 				break;
 		}
 		/* Other devices can go away, but the drivers are not permitted
@@ -609,33 +620,35 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 
 		if (sdev && sdev->ops && sdev->ops->fault_cb) {
 			int rwxp = (req->rd_req << 3) | (req->wr_req << 2) |
-				(req->exe_req << 1) | (req->priv_req);
-			sdev->ops->fault_cb(sdev->dev, req->pasid, req->addr, req->private, rwxp, result);
+				(req->exe_req << 1) | (req->pm_req);
+			sdev->ops->fault_cb(sdev->dev, req->pasid, req->addr,
+					    req->priv_data, rwxp, result);
 		}
 		/* We get here in the error case where the PASID lookup failed,
 		   and these can be NULL. Do not use them below this point! */
 		sdev = NULL;
 		svm = NULL;
 	no_pasid:
-		if (req->lpig) {
-			/* Page Group Response */
+		if (req->lpig || req->priv_data_present) {
+			/*
+			 * Per VT-d spec. v3.0 ch7.7, system software must
+			 * respond with page group response if private data
+			 * is present (PDP) or last page in group (LPIG) bit
+			 * is set. This is an additional VT-d feature beyond
+			 * PCI ATS spec.
+			 */
 			resp.qw0 = QI_PGRP_PASID(req->pasid) |
-				QI_PGRP_DID((req->bus << 8) | req->devfn) |
+				QI_PGRP_DID(req->rid) |
 				QI_PGRP_PASID_P(req->pasid_present) |
+				QI_PGRP_PDP(req->pasid_present) |
+				QI_PGRP_RESP_CODE(result) |
 				QI_PGRP_RESP_TYPE;
 			resp.qw1 = QI_PGRP_IDX(req->prg_index) |
-				QI_PGRP_PRIV(req->private) |
-				QI_PGRP_RESP_CODE(result);
-		} else if (req->srr) {
-			/* Page Stream Response */
-			resp.qw0 = QI_PSTRM_IDX(req->prg_index) |
-				QI_PSTRM_PRIV(req->private) |
-				QI_PSTRM_BUS(req->bus) |
-				QI_PSTRM_PASID(req->pasid) |
-				QI_PSTRM_RESP_TYPE;
-			resp.qw1 = QI_PSTRM_ADDR(address) |
-				QI_PSTRM_DEVFN(req->devfn) |
-				QI_PSTRM_RESP_CODE(result);
+				QI_PGRP_LPIG(req->lpig);
+
+			if (req->priv_data_present)
+				memcpy(&resp.qw2, req->priv_data,
+				       sizeof(req->priv_data));
 		}
 		resp.qw2 = 0;
 		resp.qw3 = 0;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 0605f3bf6e79..fa364de9db18 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -374,20 +374,17 @@ enum {
 #define QI_DEV_EIOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | ((u64)(pfsid & 0xfff) << 52))
 #define QI_DEV_EIOTLB_MAX_INVS	32
 
-#define QI_PGRP_IDX(idx)	(((u64)(idx)) << 55)
-#define QI_PGRP_PRIV(priv)	(((u64)(priv)) << 32)
-#define QI_PGRP_RESP_CODE(res)	((u64)(res))
-#define QI_PGRP_PASID(pasid)	(((u64)(pasid)) << 32)
-#define QI_PGRP_DID(did)	(((u64)(did)) << 16)
+/* Page group response descriptor QW0 */
 #define QI_PGRP_PASID_P(p)	(((u64)(p)) << 4)
+#define QI_PGRP_PDP(p)		(((u64)(p)) << 5)
+#define QI_PGRP_RESP_CODE(res)	(((u64)(res)) << 12)
+#define QI_PGRP_DID(rid)	(((u64)(rid)) << 16)
+#define QI_PGRP_PASID(pasid)	(((u64)(pasid)) << 32)
+
+/* Page group response descriptor QW1 */
+#define QI_PGRP_LPIG(x)		(((u64)(x)) << 2)
+#define QI_PGRP_IDX(idx)	(((u64)(idx)) << 3)
 
-#define QI_PSTRM_ADDR(addr)	(((u64)(addr)) & VTD_PAGE_MASK)
-#define QI_PSTRM_DEVFN(devfn)	(((u64)(devfn)) << 4)
-#define QI_PSTRM_RESP_CODE(res)	((u64)(res))
-#define QI_PSTRM_IDX(idx)	(((u64)(idx)) << 55)
-#define QI_PSTRM_PRIV(priv)	(((u64)(priv)) << 32)
-#define QI_PSTRM_BUS(bus)	(((u64)(bus)) << 24)
-#define QI_PSTRM_PASID(pasid)	(((u64)(pasid)) << 4)
 
 #define QI_RESP_SUCCESS		0x0
 #define QI_RESP_INVALID		0x1
diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
index 99bc5b3ae26e..e3f76315ca4d 100644
--- a/include/linux/intel-svm.h
+++ b/include/linux/intel-svm.h
@@ -20,7 +20,7 @@ struct device;
 
 struct svm_dev_ops {
 	void (*fault_cb)(struct device *dev, int pasid, u64 address,
-			 u32 private, int rwxp, int response);
+			 void *private, int rwxp, int response);
 };
 
 /* Values for rxwp in fault_cb callback */
-- 
2.17.1

