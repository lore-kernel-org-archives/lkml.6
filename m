Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08276ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE94208EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE94208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbeGPVLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:11:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:22334 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728075AbeGPVLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:11:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 13:42:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,363,1526367600"; 
   d="scan'208";a="240773031"
Received: from otc-nc-03.jf.intel.com ([10.54.39.32])
  by orsmga005.jf.intel.com with ESMTP; 16 Jul 2018 13:42:32 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>,
        iommu@lists.linux-foundation.org
Cc:     Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Gage Eads <gage.eads@intel.com>
Subject: [PATCH] x86/pci: Some buggy virtual functions incorrectly report 1 for intx.
Date:   Mon, 16 Jul 2018 13:42:25 -0700
Message-Id: <1531773745-41876-1-git-send-email-ashok.raj@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCI_INTERRUPT_PIN should always read  0 for SRIOV Virtual Functions.

Some SRIOV devices have some bugs in RTL and VF's end up reading 1
instead of 0 for the PIN.

We could enforce it by default in vfio_pci_nointx.

Reported-by: Gage Eads <gage.eads@intel.com>
Tested-by: Gage Eads <gage.eads@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Cc: iommu@lists.linux-foundation.org
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Gage Eads <gage.eads@intel.com>
---
 drivers/vfio/pci/vfio_pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index b423a30..bc3f4fa 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -192,6 +192,13 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev);
  */
 static bool vfio_pci_nointx(struct pci_dev *pdev)
 {
+	/*
+	 * Per PCI, no VF's should have INTx
+	 * Simply disable it here
+	 */
+	if (pdev->is_virtfn)
+		return true;
+
 	switch (pdev->vendor) {
 	case PCI_VENDOR_ID_INTEL:
 		switch (pdev->device) {
-- 
2.7.4

