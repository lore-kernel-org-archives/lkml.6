Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbeCaAdU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 20:33:20 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54599 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752561AbeCaAdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 20:33:17 -0400
X-Google-Smtp-Source: AIpwx49JvC/qIn7Hdmte8yOZ4rDfF5YNrikKmnYAj522nlfvJrYHFlH9GntsCwN09G+CEgFc48OSqw==
From: Dmitry Safonov <dima@arista.com>
To: linux-kernel@vger.kernel.org, joro@8bytes.org
Cc: 0x7f454c46@gmail.com, Dmitry Safonov <dima@arista.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org
Subject: [PATCHv4 2/2] iommu/vt-d: Limit number of faults to clear in irq handler
Date: Sat, 31 Mar 2018 01:33:12 +0100
Message-Id: <20180331003312.6390-2-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180331003312.6390-1-dima@arista.com>
References: <20180331003312.6390-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Theoretically, on some machines faults might be generated faster than
they're cleared by CPU. Let's limit the cleaning-loop by number of hw
fault registers.

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/iommu/dmar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 6c4ea32ee6a9..cf1105111209 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1615,7 +1615,7 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 irqreturn_t dmar_fault(int irq, void *dev_id)
 {
 	struct intel_iommu *iommu = dev_id;
-	int reg, fault_index;
+	int reg, fault_index, i;
 	u32 fault_status;
 	unsigned long flag;
 	static DEFINE_RATELIMIT_STATE(rs,
@@ -1633,7 +1633,7 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
 
 	fault_index = dma_fsts_fault_record_index(fault_status);
 	reg = cap_fault_reg_offset(iommu->cap);
-	while (1) {
+	for (i = 0; i < cap_num_fault_regs(iommu->cap); i++) {
 		/* Disable printing, simply clear the fault when ratelimited */
 		bool ratelimited = !__ratelimit(&rs);
 		u8 fault_reason;
-- 
2.13.6
