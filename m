Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751613AbeEBOB0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:01:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33817 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbeEBOBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:01:24 -0400
Date: Wed, 2 May 2018 07:01:01 -0700
From: tip-bot for Agustin Vega-Frias <tipbot@zytor.com>
Message-ID: <tip-1bc2463cee92ef0e2034c813d5e511adeb58b5fd@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        agustinv@codeaurora.org, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org, marc.zyngier@arm.com
Reply-To: marc.zyngier@arm.com, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, agustinv@codeaurora.org, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org
In-Reply-To: <1525184090-26143-1-git-send-email-agustinv@codeaurora.org>
References: <1525184090-26143-1-git-send-email-agustinv@codeaurora.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] irqchip/qcom: Fix check for spurious interrupts
Git-Commit-ID: 1bc2463cee92ef0e2034c813d5e511adeb58b5fd
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1bc2463cee92ef0e2034c813d5e511adeb58b5fd
Gitweb:     https://git.kernel.org/tip/1bc2463cee92ef0e2034c813d5e511adeb58b5fd
Author:     Agustin Vega-Frias <agustinv@codeaurora.org>
AuthorDate: Tue, 1 May 2018 10:14:50 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 2 May 2018 15:56:10 +0200

irqchip/qcom: Fix check for spurious interrupts

When the interrupts for a combiner span multiple registers it must be
checked if any interrupts have been asserted on each register before
checking for spurious interrupts.

Checking each register seperately leads to false positive warnings.

[ tglx: Massaged changelog ]

Fixes: f20cc9b00c7b ("irqchip/qcom: Add IRQ combiner driver")
Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: timur@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/1525184090-26143-1-git-send-email-agustinv@codeaurora.org

---
 drivers/irqchip/qcom-irq-combiner.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/qcom-irq-combiner.c b/drivers/irqchip/qcom-irq-combiner.c
index f31265937439..7f0c0be322e0 100644
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
