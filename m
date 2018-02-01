Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754271AbeBAAEK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 19:04:10 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57048 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753730AbeBAAEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 19:04:08 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E214C6079C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=shankerd@codeaurora.org
From: Shanker Donthineni <shankerd@codeaurora.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Vikram Sethi <vikrams@codeaurora.org>,
        Sean Campbell <scampbel@codeaurora.org>,
        Thomas Speier <tspeier@codeaurora.org>,
        Shanker Donthineni <shankerd@codeaurora.org>
Subject: [PATCH] irqchip/gic-v3: Use wmb() instead of smb_wmb() in gic_raise_softirq()
Date: Wed, 31 Jan 2018 18:03:42 -0600
Message-Id: <1517443422-30693-1-git-send-email-shankerd@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A DMB instruction can be used to ensure the relative order of only
memory accesses before and after the barrier. Since writes to system
registers are not memory operations, barrier DMB is not sufficient
for observability of memory accesses that occur before ICC_SGI1R_EL1
writes.

A DSB instruction ensures that no instructions that appear in program
order after the DSB instruction, can execute until the DSB instruction
has completed.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
 drivers/irqchip/irq-gic-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index b56c3e2..980ae8e 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -688,7 +688,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	 * Ensure that stores to Normal memory are visible to the
 	 * other CPUs before issuing the IPI.
 	 */
-	smp_wmb();
+	wmb();
 
 	for_each_cpu(cpu, mask) {
 		u64 cluster_id = MPIDR_TO_SGI_CLUSTER_ID(cpu_logical_map(cpu));
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
