Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755825AbeEAOPT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 10:15:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35226 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755074AbeEAOPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 10:15:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B42A6090E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=agustinv@codeaurora.org
From: Agustin Vega-Frias <agustinv@codeaurora.org>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc: timur@codeaurora.org, agustinv@codeaurora.org
Subject: [PATCH V1] irqchip/qcom: Fix check for spurious interrupts
Date: Tue,  1 May 2018 10:14:50 -0400
Message-Id: <1525184090-26143-1-git-send-email-agustinv@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the interrupts for a combiner span multiple registers we need
to check if any interrupts have been asserted on each register
before checking for spurious interrupts.

Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
---
 drivers/irqchip/qcom-irq-combiner.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/qcom-irq-combiner.c b/drivers/irqchip/qcom-irq-combiner.c
index f312659..7f0c0be 100644
--- a/drivers/irqchip/qcom-irq-combiner.c
+++ b/drivers/irqchip/qcom-irq-combiner.c
@@ -1,4 +1,4 @@
-/* Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
+/* Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
@@ -68,7 +68,7 @@ static void combiner_handle_irq(struct irq_desc *desc)
 
 		bit = readl_relaxed(combiner->regs[reg].addr);
 		status = bit & combiner->regs[reg].enabled;
-		if (!status)
+		if (bit && !status)
 			pr_warn_ratelimited("Unexpected IRQ on CPU%d: (%08x %08lx %p)\n",
 					    smp_processor_id(), bit,
 					    combiner->regs[reg].enabled,
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
