Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC02C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDB020660
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDB020660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937178AbeFSC6u (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 22:58:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:19993 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934644AbeFSC6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 22:58:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 19:58:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,241,1526367600"; 
   d="scan'208";a="60309551"
Received: from allen-box.sh.intel.com ([10.239.48.172])
  by orsmga003.jf.intel.com with ESMTP; 18 Jun 2018 19:58:47 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Remove unnecessary WARN_ON()
Date:   Tue, 19 Jun 2018 10:49:19 +0800
Message-Id: <1529376559-25759-1-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When drivers call intel_svm_available() to check whether the
Shared Virtual Memory(SVM) is supported by the IOMMU driver,
they will get a warning in the kernel message if the SVM is
not supported by the hardware.

[    3.790876] WARNING: CPU: 0 PID: 267 at drivers/iommu/intel-svm.c:334 intel_svm_bind_mm+0x292/0x570
[    3.790877] Modules linked in: dsa(+) vfio_mdev mdev vfio_iommu_type1 soundcore vfio serio_raw parport_pc ppdev lp parport autofs4 psmouse virtio_net pata_acpi
[    3.790884] CPU: 0 PID: 267 Comm: systemd-udevd Not tainted 4.15.0+ #358
[    3.790885] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.0-0-g63451fca13-prebuilt.qemu-project.org 04/01/2014
[    3.790887] RIP: 0010:intel_svm_bind_mm+0x292/0x570
[    3.790887] RSP: 0000:ffffac72c08a3a70 EFLAGS: 00010246
[    3.790889] RAX: 0000000000000000 RBX: ffff90447a5160a0 RCX: 0000000000000000
[    3.790889] RDX: 0000000000000000 RSI: 0000000000000082 RDI: ffff90447fc16550
[    3.790890] RBP: ffff90447a516000 R08: 0000000000000000 R09: 0000000000000178
[    3.790891] R10: 0000000000000220 R11: 0000000000aaaaaa R12: 0000000000000000
[    3.790891] R13: 0000000000000002 R14: ffffac72c08a3b18 R15: ffffac72c08a3eb8
[    3.790893] FS:  00007fb21e85b8c0(0000) GS:ffff90447fc00000(0000) knlGS:0000000000000000
[    3.790894] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.790894] CR2: 000055c08167d148 CR3: 000000013a6f4000 CR4: 00000000000006f0
[    3.790903] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    3.790904] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

This is caused by a unnecessary WARN_ON() in intel_svm_bind_mm().
Hence, remove it.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 45f6e58..2cc0aac 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -309,7 +309,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 	int pasid_max;
 	int ret;
 
-	if (WARN_ON(!iommu || !iommu->pasid_table))
+	if (!iommu || !iommu->pasid_table)
 		return -EINVAL;
 
 	if (dev_is_pci(dev)) {
-- 
2.7.4

