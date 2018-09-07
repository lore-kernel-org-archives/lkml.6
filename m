Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88761C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6C720844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6C720844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbeIHCXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:23:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54774 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbeIHCXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:23:53 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EFF41100B;
        Fri,  7 Sep 2018 21:40:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 4.4 31/47] iommu/vt-d: Fix dev iotlb pfsid use
Date:   Fri,  7 Sep 2018 23:10:27 +0200
Message-Id: <20180907210907.974719703@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210904.607934824@linuxfoundation.org>
References: <20180907210904.607934824@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

commit 1c48db44924298ad0cb5a6386b88017539be8822 upstream.

PFSID should be used in the invalidation descriptor for flushing
device IOTLBs on SRIOV VFs.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: stable@vger.kernel.org
Cc: "Ashok Raj" <ashok.raj@intel.com>
Cc: "Lu Baolu" <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/dmar.c        |    6 +++---
 drivers/iommu/intel-iommu.c |   17 ++++++++++++++++-
 include/linux/intel-iommu.h |    5 ++---
 3 files changed, 21 insertions(+), 7 deletions(-)

--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1315,8 +1315,8 @@ void qi_flush_iotlb(struct intel_iommu *
 	qi_submit_sync(&desc, iommu);
 }
 
-void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 qdep,
-			u64 addr, unsigned mask)
+void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
+			u16 qdep, u64 addr, unsigned mask)
 {
 	struct qi_desc desc;
 
@@ -1331,7 +1331,7 @@ void qi_flush_dev_iotlb(struct intel_iom
 		qdep = 0;
 
 	desc.low = QI_DEV_IOTLB_SID(sid) | QI_DEV_IOTLB_QDEP(qdep) |
-		   QI_DIOTLB_TYPE;
+		   QI_DIOTLB_TYPE | QI_DEV_IOTLB_PFSID(pfsid);
 
 	qi_submit_sync(&desc, iommu);
 }
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1480,6 +1480,20 @@ static void iommu_enable_dev_iotlb(struc
 		return;
 
 	pdev = to_pci_dev(info->dev);
+	/* For IOMMU that supports device IOTLB throttling (DIT), we assign
+	 * PFSID to the invalidation desc of a VF such that IOMMU HW can gauge
+	 * queue depth at PF level. If DIT is not set, PFSID will be treated as
+	 * reserved, which should be set to 0.
+	 */
+	if (!ecap_dit(info->iommu->ecap))
+		info->pfsid = 0;
+	else {
+		struct pci_dev *pf_pdev;
+
+		/* pdev will be returned if device is not a vf */
+		pf_pdev = pci_physfn(pdev);
+		info->pfsid = PCI_DEVID(pf_pdev->bus->number, pf_pdev->devfn);
+	}
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	/* The PCIe spec, in its wisdom, declares that the behaviour of
@@ -1538,7 +1552,8 @@ static void iommu_flush_dev_iotlb(struct
 
 		sid = info->bus << 8 | info->devfn;
 		qdep = info->ats_qdep;
-		qi_flush_dev_iotlb(info->iommu, sid, qdep, addr, mask);
+		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
+				qdep, addr, mask);
 	}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -466,9 +466,8 @@ extern void qi_flush_context(struct inte
 			     u8 fm, u64 type);
 extern void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 			  unsigned int size_order, u64 type);
-extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 qdep,
-			       u64 addr, unsigned mask);
-
+extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
+			u16 qdep, u64 addr, unsigned mask);
 extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu);
 
 extern int dmar_ir_support(void);


