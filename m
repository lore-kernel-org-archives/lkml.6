Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeBDPGC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 10:06:02 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51606 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbeBDPFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 10:05:54 -0500
Date: Sun, 4 Feb 2018 16:05:53 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] irq updates for 4.16
Message-ID: <alpine.DEB.2.21.1802041600380.1035@nanos.tec.linutronix.de>
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

Two small changes:

  - A fix for a interrupt regression caused by the vector management
    changes in 4.15 affecting museum pieces which rely on interrupt probing
    for legacy (e.g. parallel port) devices. One of the startup calls in
    the autoprobe code was not changed to the new activate_and_startup()
    function resulting in a warning and as a consequence failing to
    discover the device interrupt.

  - A trivial update to the copyright/license header of the STM32 irq chip
    driver.

Thanks,

	tglx

------------------>
Benjamin Gaignard (1):
      irqchip/stm32: Fix copyright

Thomas Gleixner (1):
      genirq: Make legacy autoprobing work again


 drivers/irqchip/irq-stm32-exti.c | 3 ++-
 kernel/irq/autoprobe.c           | 2 +-
 kernel/irq/chip.c                | 6 +++---
 kernel/irq/internals.h           | 2 +-
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 31ab0dee2ce7..36f0fbe36c35 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -1,7 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) Maxime Coquelin 2015
+ * Copyright (C) STMicroelectronics 2017
  * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
- * License terms:  GNU General Public License (GPL), version 2
  */
 
 #include <linux/bitops.h>
diff --git a/kernel/irq/autoprobe.c b/kernel/irq/autoprobe.c
index 4e8089b319ae..8c82ea26e837 100644
--- a/kernel/irq/autoprobe.c
+++ b/kernel/irq/autoprobe.c
@@ -71,7 +71,7 @@ unsigned long probe_irq_on(void)
 		raw_spin_lock_irq(&desc->lock);
 		if (!desc->action && irq_settings_can_probe(desc)) {
 			desc->istate |= IRQS_AUTODETECT | IRQS_WAITING;
-			if (irq_startup(desc, IRQ_NORESEND, IRQ_START_FORCE))
+			if (irq_activate_and_startup(desc, IRQ_NORESEND))
 				desc->istate |= IRQS_PENDING;
 		}
 		raw_spin_unlock_irq(&desc->lock);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 043bfc35b353..c69357a43849 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -294,11 +294,11 @@ int irq_activate(struct irq_desc *desc)
 	return 0;
 }
 
-void irq_activate_and_startup(struct irq_desc *desc, bool resend)
+int irq_activate_and_startup(struct irq_desc *desc, bool resend)
 {
 	if (WARN_ON(irq_activate(desc)))
-		return;
-	irq_startup(desc, resend, IRQ_START_FORCE);
+		return 0;
+	return irq_startup(desc, resend, IRQ_START_FORCE);
 }
 
 static void __irq_disable(struct irq_desc *desc, bool mask);
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index ab19371eab9b..ca6afa267070 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -76,7 +76,7 @@ extern void __enable_irq(struct irq_desc *desc);
 #define IRQ_START_COND	false
 
 extern int irq_activate(struct irq_desc *desc);
-extern void irq_activate_and_startup(struct irq_desc *desc, bool resend);
+extern int irq_activate_and_startup(struct irq_desc *desc, bool resend);
 extern int irq_startup(struct irq_desc *desc, bool resend, bool force);
 
 extern void irq_shutdown(struct irq_desc *desc);
