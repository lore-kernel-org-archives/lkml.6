Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EA9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD3820989
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfBYCv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 21:51:57 -0500
Received: from mga02.intel.com ([134.134.136.20]:25614 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbfBYCv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 21:51:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2019 18:51:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,410,1544515200"; 
   d="scan'208";a="120497484"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga008.jf.intel.com with ESMTP; 24 Feb 2019 18:51:54 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     joro@8bytes.org, dwmw2@infradead.org
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        jisben@google.com, xmdong@google.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, stable@vger.kernel.org
Subject: [PATCH 1/1] iommu/vt-d: Check identity map for hot-added devices
Date:   Mon, 25 Feb 2019 10:46:36 +0800
Message-Id: <20190225024636.32418-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel IOMMU driver will put devices into a static identity
mapped domain during boot if the kernel parameter "iommu=pt" is
used. That means the IOMMU hardware will translate a DMA address
into the same memory address.

Unfortunately, hot-added devices are not subject to this. That
results in some devices not working properly after hot added. A
quick way to reproduce this issue is to boot a system with

    iommu=pt

and, remove then readd the pci device with

    echo 1 > /sys/bus/pci/devices/[pci_source_id]/remove
    echo 1 > /sys/bus/pci/rescan

You will find the identity mapped domain was replaced with a
normal domain.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: stable@vger.kernel.org
Reported-by: Jis Ben <jisben@google.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: James Dong <xmdong@google.com>
---
 drivers/iommu/intel-iommu.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index af23cfc2a05e..4f77657a9c25 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4564,16 +4564,19 @@ static int device_notifier(struct notifier_block *nb,
 	if (iommu_dummy(dev))
 		return 0;
 
-	if (action != BUS_NOTIFY_REMOVED_DEVICE)
-		return 0;
-
-	domain = find_domain(dev);
-	if (!domain)
-		return 0;
+	if (action == BUS_NOTIFY_REMOVED_DEVICE) {
+		domain = find_domain(dev);
+		if (!domain)
+			return 0;
 
-	dmar_remove_one_dev_info(dev);
-	if (!domain_type_is_vm_or_si(domain) && list_empty(&domain->devices))
-		domain_exit(domain);
+		dmar_remove_one_dev_info(dev);
+		if (!domain_type_is_vm_or_si(domain) &&
+		    list_empty(&domain->devices))
+			domain_exit(domain);
+	} else if (action == BUS_NOTIFY_ADD_DEVICE) {
+		if (iommu_should_identity_map(dev, 1))
+			domain_add_dev_info(si_domain, dev);
+	}
 
 	return 0;
 }
-- 
2.17.1

