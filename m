Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751204AbeEFHzD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 03:55:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47151 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbeEFHzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 03:55:01 -0400
Date: Sun, 6 May 2018 09:54:59 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] irq fix for 4.17
Message-ID: <alpine.DEB.2.21.1805060948550.1685@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

A single fix to prevent false positives in the spurious interrupt detector
when more than a single demultiplex register is evaluated in the Qualcom
irq combiner driver.

Thanks,

	tglx

------------------>
Agustin Vega-Frias (1):
      irqchip/qcom: Fix check for spurious interrupts


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
