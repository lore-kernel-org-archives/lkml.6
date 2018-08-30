Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40194C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3D320647
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3D320647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeH3FgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 01:36:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:9350 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeH3FgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 01:36:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 18:36:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,305,1531810800"; 
   d="scan'208";a="79442254"
Received: from allen-box.sh.intel.com ([10.239.161.122])
  by orsmga003.jf.intel.com with ESMTP; 29 Aug 2018 18:36:42 -0700
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
Subject: [PATCH v2 04/12] iommu/vt-d: Add 256-bit invalidation descriptor support
Date:   Thu, 30 Aug 2018 09:35:16 +0800
Message-Id: <20180830013524.28743-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830013524.28743-1-baolu.lu@linux.intel.com>
References: <20180830013524.28743-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel vt-d spec rev3.0 requires software to use 256-bit
descriptors in invalidation queue. As the spec reads in
section 6.5.2:

Remapping hardware supporting Scalable Mode Translations
(ECAP_REG.SMTS=1) allow software to additionally program
the width of the descriptors (128-bits or 256-bits) that
will be written into the Queue. Software should setup the
Invalidation Queue for 256-bit descriptors before progra-
mming remapping hardware for scalable-mode translation as
128-bit descriptors are treated as invalid descriptors
(see Table 21 in Section 6.5.2.10) in scalable-mode.

This patch adds 256-bit invalidation descriptor support
if the hardware presents scalable mode capability.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/dmar.c                | 83 +++++++++++++++++++----------
 drivers/iommu/intel-svm.c           | 76 ++++++++++++++++----------
 drivers/iommu/intel_irq_remapping.c |  6 ++-
 include/linux/intel-iommu.h         |  7 ++-
 4 files changed, 113 insertions(+), 59 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index d9c748b6f9e4..b1429fa2cf29 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1160,6 +1160,7 @@ static int qi_check_fault(struct intel_iommu *iommu, int index)
 	int head, tail;
 	struct q_inval *qi = iommu->qi;
 	int wait_index = (index + 1) % QI_LENGTH;
+	int shift = DMAR_IQ_SHIFT + !!ecap_smts(iommu->ecap);
 
 	if (qi->desc_status[wait_index] == QI_ABORT)
 		return -EAGAIN;
@@ -1173,13 +1174,15 @@ static int qi_check_fault(struct intel_iommu *iommu, int index)
 	 */
 	if (fault & DMA_FSTS_IQE) {
 		head = readl(iommu->reg + DMAR_IQH_REG);
-		if ((head >> DMAR_IQ_SHIFT) == index) {
+		if ((head >> shift) == index) {
+			struct qi_desc *desc = qi->desc + head;
+
 			pr_err("VT-d detected invalid descriptor: "
 				"low=%llx, high=%llx\n",
-				(unsigned long long)qi->desc[index].low,
-				(unsigned long long)qi->desc[index].high);
-			memcpy(&qi->desc[index], &qi->desc[wait_index],
-					sizeof(struct qi_desc));
+				(unsigned long long)desc->qw0,
+				(unsigned long long)desc->qw1);
+			memcpy(desc, qi->desc + (wait_index << shift),
+			       1 << shift);
 			writel(DMA_FSTS_IQE, iommu->reg + DMAR_FSTS_REG);
 			return -EINVAL;
 		}
@@ -1191,10 +1194,10 @@ static int qi_check_fault(struct intel_iommu *iommu, int index)
 	 */
 	if (fault & DMA_FSTS_ITE) {
 		head = readl(iommu->reg + DMAR_IQH_REG);
-		head = ((head >> DMAR_IQ_SHIFT) - 1 + QI_LENGTH) % QI_LENGTH;
+		head = ((head >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
 		head |= 1;
 		tail = readl(iommu->reg + DMAR_IQT_REG);
-		tail = ((tail >> DMAR_IQ_SHIFT) - 1 + QI_LENGTH) % QI_LENGTH;
+		tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
 
 		writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG);
 
@@ -1222,15 +1225,14 @@ int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu)
 {
 	int rc;
 	struct q_inval *qi = iommu->qi;
-	struct qi_desc *hw, wait_desc;
+	int offset, shift, length;
+	struct qi_desc wait_desc;
 	int wait_index, index;
 	unsigned long flags;
 
 	if (!qi)
 		return 0;
 
-	hw = qi->desc;
-
 restart:
 	rc = 0;
 
@@ -1243,16 +1245,21 @@ int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu)
 
 	index = qi->free_head;
 	wait_index = (index + 1) % QI_LENGTH;
+	shift = DMAR_IQ_SHIFT + !!ecap_smts(iommu->ecap);
+	length = 1 << shift;
 
 	qi->desc_status[index] = qi->desc_status[wait_index] = QI_IN_USE;
 
-	hw[index] = *desc;
-
-	wait_desc.low = QI_IWD_STATUS_DATA(QI_DONE) |
+	offset = index << shift;
+	memcpy(qi->desc + offset, desc, length);
+	wait_desc.qw0 = QI_IWD_STATUS_DATA(QI_DONE) |
 			QI_IWD_STATUS_WRITE | QI_IWD_TYPE;
-	wait_desc.high = virt_to_phys(&qi->desc_status[wait_index]);
+	wait_desc.qw1 = virt_to_phys(&qi->desc_status[wait_index]);
+	wait_desc.qw2 = 0;
+	wait_desc.qw3 = 0;
 
-	hw[wait_index] = wait_desc;
+	offset = wait_index << shift;
+	memcpy(qi->desc + offset, &wait_desc, length);
 
 	qi->free_head = (qi->free_head + 2) % QI_LENGTH;
 	qi->free_cnt -= 2;
@@ -1261,7 +1268,7 @@ int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu)
 	 * update the HW tail register indicating the presence of
 	 * new descriptors.
 	 */
-	writel(qi->free_head << DMAR_IQ_SHIFT, iommu->reg + DMAR_IQT_REG);
+	writel(qi->free_head << shift, iommu->reg + DMAR_IQT_REG);
 
 	while (qi->desc_status[wait_index] != QI_DONE) {
 		/*
@@ -1298,8 +1305,10 @@ void qi_global_iec(struct intel_iommu *iommu)
 {
 	struct qi_desc desc;
 
-	desc.low = QI_IEC_TYPE;
-	desc.high = 0;
+	desc.qw0 = QI_IEC_TYPE;
+	desc.qw1 = 0;
+	desc.qw2 = 0;
+	desc.qw3 = 0;
 
 	/* should never fail */
 	qi_submit_sync(&desc, iommu);
@@ -1310,9 +1319,11 @@ void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid, u8 fm,
 {
 	struct qi_desc desc;
 
-	desc.low = QI_CC_FM(fm) | QI_CC_SID(sid) | QI_CC_DID(did)
+	desc.qw0 = QI_CC_FM(fm) | QI_CC_SID(sid) | QI_CC_DID(did)
 			| QI_CC_GRAN(type) | QI_CC_TYPE;
-	desc.high = 0;
+	desc.qw1 = 0;
+	desc.qw2 = 0;
+	desc.qw3 = 0;
 
 	qi_submit_sync(&desc, iommu);
 }
@@ -1331,10 +1342,12 @@ void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 	if (cap_read_drain(iommu->cap))
 		dr = 1;
 
-	desc.low = QI_IOTLB_DID(did) | QI_IOTLB_DR(dr) | QI_IOTLB_DW(dw)
+	desc.qw0 = QI_IOTLB_DID(did) | QI_IOTLB_DR(dr) | QI_IOTLB_DW(dw)
 		| QI_IOTLB_GRAN(type) | QI_IOTLB_TYPE;
-	desc.high = QI_IOTLB_ADDR(addr) | QI_IOTLB_IH(ih)
+	desc.qw1 = QI_IOTLB_ADDR(addr) | QI_IOTLB_IH(ih)
 		| QI_IOTLB_AM(size_order);
+	desc.qw2 = 0;
+	desc.qw3 = 0;
 
 	qi_submit_sync(&desc, iommu);
 }
@@ -1347,15 +1360,17 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 	if (mask) {
 		WARN_ON_ONCE(addr & ((1ULL << (VTD_PAGE_SHIFT + mask)) - 1));
 		addr |= (1ULL << (VTD_PAGE_SHIFT + mask - 1)) - 1;
-		desc.high = QI_DEV_IOTLB_ADDR(addr) | QI_DEV_IOTLB_SIZE;
+		desc.qw1 = QI_DEV_IOTLB_ADDR(addr) | QI_DEV_IOTLB_SIZE;
 	} else
-		desc.high = QI_DEV_IOTLB_ADDR(addr);
+		desc.qw1 = QI_DEV_IOTLB_ADDR(addr);
 
 	if (qdep >= QI_DEV_IOTLB_MAX_INVS)
 		qdep = 0;
 
-	desc.low = QI_DEV_IOTLB_SID(sid) | QI_DEV_IOTLB_QDEP(qdep) |
+	desc.qw0 = QI_DEV_IOTLB_SID(sid) | QI_DEV_IOTLB_QDEP(qdep) |
 		   QI_DIOTLB_TYPE | QI_DEV_IOTLB_PFSID(pfsid);
+	desc.qw2 = 0;
+	desc.qw3 = 0;
 
 	qi_submit_sync(&desc, iommu);
 }
@@ -1403,16 +1418,24 @@ static void __dmar_enable_qi(struct intel_iommu *iommu)
 	u32 sts;
 	unsigned long flags;
 	struct q_inval *qi = iommu->qi;
+	u64 val = virt_to_phys(qi->desc);
 
 	qi->free_head = qi->free_tail = 0;
 	qi->free_cnt = QI_LENGTH;
 
+	/*
+	 * Set DW=1 and QS=1 in IQA_REG when Scalable Mode capability
+	 * is present.
+	 */
+	if (ecap_smts(iommu->ecap))
+		val |= (1 << 11) | 1;
+
 	raw_spin_lock_irqsave(&iommu->register_lock, flags);
 
 	/* write zero to the tail reg */
 	writel(0, iommu->reg + DMAR_IQT_REG);
 
-	dmar_writeq(iommu->reg + DMAR_IQA_REG, virt_to_phys(qi->desc));
+	dmar_writeq(iommu->reg + DMAR_IQA_REG, val);
 
 	iommu->gcmd |= DMA_GCMD_QIE;
 	writel(iommu->gcmd, iommu->reg + DMAR_GCMD_REG);
@@ -1448,8 +1471,12 @@ int dmar_enable_qi(struct intel_iommu *iommu)
 
 	qi = iommu->qi;
 
-
-	desc_page = alloc_pages_node(iommu->node, GFP_ATOMIC | __GFP_ZERO, 0);
+	/*
+	 * Need two pages to accommodate 256 descriptors of 256 bits each
+	 * if the remapping hardware supports scalable mode translation.
+	 */
+	desc_page = alloc_pages_node(iommu->node, GFP_ATOMIC | __GFP_ZERO,
+				     !!ecap_smts(iommu->ecap));
 	if (!desc_page) {
 		kfree(qi);
 		iommu->qi = NULL;
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 6c0bd9ee9602..a06ed098e928 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -161,27 +161,40 @@ static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_d
 		 * because that's the only option the hardware gives us. Despite
 		 * the fact that they are actually only accessible through one. */
 		if (gl)
-			desc.low = QI_EIOTLB_PASID(svm->pasid) | QI_EIOTLB_DID(sdev->did) |
-				QI_EIOTLB_GRAN(QI_GRAN_ALL_ALL) | QI_EIOTLB_TYPE;
+			desc.qw0 = QI_EIOTLB_PASID(svm->pasid) |
+					QI_EIOTLB_DID(sdev->did) |
+					QI_EIOTLB_GRAN(QI_GRAN_ALL_ALL) |
+					QI_EIOTLB_TYPE;
 		else
-			desc.low = QI_EIOTLB_PASID(svm->pasid) | QI_EIOTLB_DID(sdev->did) |
-				QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) | QI_EIOTLB_TYPE;
-		desc.high = 0;
+			desc.qw0 = QI_EIOTLB_PASID(svm->pasid) |
+					QI_EIOTLB_DID(sdev->did) |
+					QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) |
+					QI_EIOTLB_TYPE;
+		desc.qw1 = 0;
 	} else {
 		int mask = ilog2(__roundup_pow_of_two(pages));
 
-		desc.low = QI_EIOTLB_PASID(svm->pasid) | QI_EIOTLB_DID(sdev->did) |
-			QI_EIOTLB_GRAN(QI_GRAN_PSI_PASID) | QI_EIOTLB_TYPE;
-		desc.high = QI_EIOTLB_ADDR(address) | QI_EIOTLB_GL(gl) |
-			QI_EIOTLB_IH(ih) | QI_EIOTLB_AM(mask);
+		desc.qw0 = QI_EIOTLB_PASID(svm->pasid) |
+				QI_EIOTLB_DID(sdev->did) |
+				QI_EIOTLB_GRAN(QI_GRAN_PSI_PASID) |
+				QI_EIOTLB_TYPE;
+		desc.qw1 = QI_EIOTLB_ADDR(address) |
+				QI_EIOTLB_GL(gl) |
+				QI_EIOTLB_IH(ih) |
+				QI_EIOTLB_AM(mask);
 	}
+	desc.qw2 = 0;
+	desc.qw3 = 0;
 	qi_submit_sync(&desc, svm->iommu);
 
 	if (sdev->dev_iotlb) {
-		desc.low = QI_DEV_EIOTLB_PASID(svm->pasid) | QI_DEV_EIOTLB_SID(sdev->sid) |
-			QI_DEV_EIOTLB_QDEP(sdev->qdep) | QI_DEIOTLB_TYPE;
+		desc.qw0 = QI_DEV_EIOTLB_PASID(svm->pasid) |
+				QI_DEV_EIOTLB_SID(sdev->sid) |
+				QI_DEV_EIOTLB_QDEP(sdev->qdep) |
+				QI_DEIOTLB_TYPE;
 		if (pages == -1) {
-			desc.high = QI_DEV_EIOTLB_ADDR(-1ULL >> 1) | QI_DEV_EIOTLB_SIZE;
+			desc.qw1 = QI_DEV_EIOTLB_ADDR(-1ULL >> 1) |
+					QI_DEV_EIOTLB_SIZE;
 		} else if (pages > 1) {
 			/* The least significant zero bit indicates the size. So,
 			 * for example, an "address" value of 0x12345f000 will
@@ -189,10 +202,13 @@ static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_d
 			unsigned long last = address + ((unsigned long)(pages - 1) << VTD_PAGE_SHIFT);
 			unsigned long mask = __rounddown_pow_of_two(address ^ last);
 
-			desc.high = QI_DEV_EIOTLB_ADDR((address & ~mask) | (mask - 1)) | QI_DEV_EIOTLB_SIZE;
+			desc.qw1 = QI_DEV_EIOTLB_ADDR((address & ~mask) |
+					(mask - 1)) | QI_DEV_EIOTLB_SIZE;
 		} else {
-			desc.high = QI_DEV_EIOTLB_ADDR(address);
+			desc.qw1 = QI_DEV_EIOTLB_ADDR(address);
 		}
+		desc.qw2 = 0;
+		desc.qw3 = 0;
 		qi_submit_sync(&desc, svm->iommu);
 	}
 }
@@ -237,8 +253,11 @@ static void intel_flush_pasid_dev(struct intel_svm *svm, struct intel_svm_dev *s
 {
 	struct qi_desc desc;
 
-	desc.high = 0;
-	desc.low = QI_PC_TYPE | QI_PC_DID(sdev->did) | QI_PC_PASID_SEL | QI_PC_PASID(pasid);
+	desc.qw0 = QI_PC_TYPE | QI_PC_DID(sdev->did) |
+			QI_PC_PASID_SEL | QI_PC_PASID(pasid);
+	desc.qw1 = 0;
+	desc.qw2 = 0;
+	desc.qw3 = 0;
 
 	qi_submit_sync(&desc, svm->iommu);
 }
@@ -668,24 +687,27 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 	no_pasid:
 		if (req->lpig) {
 			/* Page Group Response */
-			resp.low = QI_PGRP_PASID(req->pasid) |
+			resp.qw0 = QI_PGRP_PASID(req->pasid) |
 				QI_PGRP_DID((req->bus << 8) | req->devfn) |
 				QI_PGRP_PASID_P(req->pasid_present) |
 				QI_PGRP_RESP_TYPE;
-			resp.high = QI_PGRP_IDX(req->prg_index) |
-				QI_PGRP_PRIV(req->private) | QI_PGRP_RESP_CODE(result);
-
-			qi_submit_sync(&resp, iommu);
+			resp.qw1 = QI_PGRP_IDX(req->prg_index) |
+				QI_PGRP_PRIV(req->private) |
+				QI_PGRP_RESP_CODE(result);
 		} else if (req->srr) {
 			/* Page Stream Response */
-			resp.low = QI_PSTRM_IDX(req->prg_index) |
-				QI_PSTRM_PRIV(req->private) | QI_PSTRM_BUS(req->bus) |
-				QI_PSTRM_PASID(req->pasid) | QI_PSTRM_RESP_TYPE;
-			resp.high = QI_PSTRM_ADDR(address) | QI_PSTRM_DEVFN(req->devfn) |
+			resp.qw0 = QI_PSTRM_IDX(req->prg_index) |
+				QI_PSTRM_PRIV(req->private) |
+				QI_PSTRM_BUS(req->bus) |
+				QI_PSTRM_PASID(req->pasid) |
+				QI_PSTRM_RESP_TYPE;
+			resp.qw1 = QI_PSTRM_ADDR(address) |
+				QI_PSTRM_DEVFN(req->devfn) |
 				QI_PSTRM_RESP_CODE(result);
-
-			qi_submit_sync(&resp, iommu);
 		}
+		resp.qw2 = 0;
+		resp.qw3 = 0;
+		qi_submit_sync(&resp, iommu);
 
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 967450bd421a..916391f33ca6 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -145,9 +145,11 @@ static int qi_flush_iec(struct intel_iommu *iommu, int index, int mask)
 {
 	struct qi_desc desc;
 
-	desc.low = QI_IEC_IIDEX(index) | QI_IEC_TYPE | QI_IEC_IM(mask)
+	desc.qw0 = QI_IEC_IIDEX(index) | QI_IEC_TYPE | QI_IEC_IM(mask)
 		   | QI_IEC_SELECTIVE;
-	desc.high = 0;
+	desc.qw1 = 0;
+	desc.qw2 = 0;
+	desc.qw3 = 0;
 
 	return qi_submit_sync(&desc, iommu);
 }
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 41791903a5e3..72aff482b293 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -340,12 +340,15 @@ enum {
 #define QI_GRAN_PSI_PASID		3
 
 struct qi_desc {
-	u64 low, high;
+	u64 qw0;
+	u64 qw1;
+	u64 qw2;
+	u64 qw3;
 };
 
 struct q_inval {
 	raw_spinlock_t  q_lock;
-	struct qi_desc  *desc;          /* invalidation queue */
+	void		*desc;          /* invalidation queue */
 	int             *desc_status;   /* desc status */
 	int             free_head;      /* first free entry */
 	int             free_tail;      /* last free entry */
-- 
2.17.1

