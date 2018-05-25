Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966127AbeEYJ4I (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:56:08 -0400
Received: from foss.arm.com ([217.140.101.70]:57476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965681AbeEYJuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:50:13 -0400
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH v4 07/26] irqchip/gic-v3: Remove acknowledge loop
Date: Fri, 25 May 2018 10:49:13 +0100
Message-Id: <1527241772-48007-8-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple interrupts pending for a CPU is actually rare. Doing an
acknowledge loop does not give much better performance or even can
deteriorate them.

Do not loop when an interrupt has been acknowledged, just return
from interrupt and wait for another one to be raised.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 65 +++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 34 deletions(-)

Note:
The loop pattern also discourages from using PMR for IRQ masking because
PMR needs to be unmasked to acknowledge interrupts.

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index e5d1014..0c58db3 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -348,48 +348,45 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 {
 	u32 irqnr;

-	do {
-		irqnr = gic_read_iar();
+	irqnr = gic_read_iar();

-		if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
-			int err;
+	if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
+		int err;

-			if (static_branch_likely(&supports_deactivate_key))
+		if (static_branch_likely(&supports_deactivate_key))
+			gic_write_eoir(irqnr);
+		else
+			isb();
+
+		err = handle_domain_irq(gic_data.domain, irqnr, regs);
+		if (err) {
+			WARN_ONCE(true, "Unexpected interrupt received!\n");
+			if (static_branch_likely(&supports_deactivate_key)) {
+				if (irqnr < 8192)
+					gic_write_dir(irqnr);
+			} else {
 				gic_write_eoir(irqnr);
-			else
-				isb();
-
-			err = handle_domain_irq(gic_data.domain, irqnr, regs);
-			if (err) {
-				WARN_ONCE(true, "Unexpected interrupt received!\n");
-				if (static_branch_likely(&supports_deactivate_key)) {
-					if (irqnr < 8192)
-						gic_write_dir(irqnr);
-				} else {
-					gic_write_eoir(irqnr);
-				}
 			}
-			continue;
 		}
-		if (irqnr < 16) {
-			gic_write_eoir(irqnr);
-			if (static_branch_likely(&supports_deactivate_key))
-				gic_write_dir(irqnr);
+		return;
+	}
+	if (irqnr < 16) {
+		gic_write_eoir(irqnr);
+		if (static_branch_likely(&supports_deactivate_key))
+			gic_write_dir(irqnr);
 #ifdef CONFIG_SMP
-			/*
-			 * Unlike GICv2, we don't need an smp_rmb() here.
-			 * The control dependency from gic_read_iar to
-			 * the ISB in gic_write_eoir is enough to ensure
-			 * that any shared data read by handle_IPI will
-			 * be read after the ACK.
-			 */
-			handle_IPI(irqnr, regs);
+		/*
+		 * Unlike GICv2, we don't need an smp_rmb() here.
+		 * The control dependency from gic_read_iar to
+		 * the ISB in gic_write_eoir is enough to ensure
+		 * that any shared data read by handle_IPI will
+		 * be read after the ACK.
+		 */
+		handle_IPI(irqnr, regs);
 #else
-			WARN_ONCE(true, "Unexpected SGI received!\n");
+		WARN_ONCE(true, "Unexpected SGI received!\n");
 #endif
-			continue;
-		}
-	} while (irqnr != ICC_IAR1_EL1_SPURIOUS);
+	}
 }

 static void __init gic_dist_init(void)
--
1.9.1
