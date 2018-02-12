Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754164AbeBLQsf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:48:35 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37342 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752591AbeBLQsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:48:32 -0500
X-Google-Smtp-Source: AH8x226KW0LWZxNLDtfPbEl2OLmcqXhOtu/n1uaDZe+8JseT3ePUofY/306aFh4jUlMByzhFdc2w4w==
From: Dmitry Safonov <dima@arista.com>
To: linux-kernel@vger.kernel.org
Cc: 0x7f454c46@gmail.com, Dmitry Safonov <dima@arista.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org
Subject: [PATCHv2 3/6] iommu/intel: Introduce clear_primary_faults() helper
Date: Mon, 12 Feb 2018 16:48:22 +0000
Message-Id: <20180212164825.22421-4-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180212164825.22421-1-dima@arista.com>
References: <20180212164825.22421-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To my mind it's a bit more readable - and I will re-use it in the next
patch.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/iommu/dmar.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index accf58388bdb..33fb4244e438 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1611,6 +1611,15 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 	return 0;
 }
 
+static void clear_primary_faults(struct intel_iommu *iommu)
+{
+	volatile void __iomem *fsts = iommu->reg + DMAR_FSTS_REG;
+
+	assert_raw_spin_locked(&iommu->register_lock);
+
+	writel(DMA_FSTS_PFO | DMA_FSTS_PPF | DMA_FSTS_PRO, fsts);
+}
+
 #define PRIMARY_FAULT_REG_LEN (16)
 irqreturn_t dmar_fault(int irq, void *dev_id)
 {
@@ -1679,8 +1688,7 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
 		raw_spin_lock_irqsave(&iommu->register_lock, flag);
 	}
 
-	writel(DMA_FSTS_PFO | DMA_FSTS_PPF | DMA_FSTS_PRO,
-	       iommu->reg + DMAR_FSTS_REG);
+	clear_primary_faults(iommu);
 
 unlock_exit:
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
-- 
2.13.6
