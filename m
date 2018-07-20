Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF29ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2EE20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2EE20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387915AbeGTRGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:06:01 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:57092 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731746AbeGTRGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:06:01 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id D4H11y01d3XaVaC014H2pJ; Fri, 20 Jul 2018 18:17:02 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fgY5V-0005wv-Sz; Fri, 20 Jul 2018 18:17:01 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fgY5V-0007lX-QW; Fri, 20 Jul 2018 18:17:01 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Joerg Roedel <joro@8bytes.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     iommu@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] iommu/ipmmu-vmsa: Fix allocation in atomic context
Date:   Fri, 20 Jul 2018 18:16:59 +0200
Message-Id: <20180720161659.29800-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When attaching a device to an IOMMU group with
CONFIG_DEBUG_ATOMIC_SLEEP=y:

    BUG: sleeping function called from invalid context at mm/slab.h:421
    in_atomic(): 1, irqs_disabled(): 128, pid: 61, name: kworker/1:1
    ...
    Call trace:
     ...
     arm_lpae_alloc_pgtable+0x114/0x184
     arm_64_lpae_alloc_pgtable_s1+0x2c/0x128
     arm_32_lpae_alloc_pgtable_s1+0x40/0x6c
     alloc_io_pgtable_ops+0x60/0x88
     ipmmu_attach_device+0x140/0x334

ipmmu_attach_device() takes a spinlock, while arm_lpae_alloc_pgtable()
allocates memory using GFP_KERNEL.  Originally, the ipmmu-vmsa driver
had its own custom page table allocation implementation using
GFP_ATOMIC, hence the spinlock was fine.

Fix this by replacing the spinlock by a mutex, like the arm-smmu driver
does.

Fixes: f20ed39f53145e45 ("iommu/ipmmu-vmsa: Use the ARM LPAE page table allocator")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/iommu/ipmmu-vmsa.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 6a0e7142f41bf667..8f54f25404456035 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -73,7 +73,7 @@ struct ipmmu_vmsa_domain {
 	struct io_pgtable_ops *iop;
 
 	unsigned int context_id;
-	spinlock_t lock;			/* Protects mappings */
+	struct mutex mutex;			/* Protects mappings */
 };
 
 static struct ipmmu_vmsa_domain *to_vmsa_domain(struct iommu_domain *dom)
@@ -599,7 +599,7 @@ static struct iommu_domain *__ipmmu_domain_alloc(unsigned type)
 	if (!domain)
 		return NULL;
 
-	spin_lock_init(&domain->lock);
+	mutex_init(&domain->mutex);
 
 	return &domain->io_domain;
 }
@@ -645,7 +645,6 @@ static int ipmmu_attach_device(struct iommu_domain *io_domain,
 	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
 	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
-	unsigned long flags;
 	unsigned int i;
 	int ret = 0;
 
@@ -654,7 +653,7 @@ static int ipmmu_attach_device(struct iommu_domain *io_domain,
 		return -ENXIO;
 	}
 
-	spin_lock_irqsave(&domain->lock, flags);
+	mutex_lock(&domain->mutex);
 
 	if (!domain->mmu) {
 		/* The domain hasn't been used yet, initialize it. */
@@ -678,7 +677,7 @@ static int ipmmu_attach_device(struct iommu_domain *io_domain,
 	} else
 		dev_info(dev, "Reusing IPMMU context %u\n", domain->context_id);
 
-	spin_unlock_irqrestore(&domain->lock, flags);
+	mutex_unlock(&domain->mutex);
 
 	if (ret < 0)
 		return ret;
-- 
2.17.1

