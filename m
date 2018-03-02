Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423235AbeCBNEj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 08:04:39 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:53925 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423109AbeCBNEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 08:04:37 -0500
Date: Fri, 2 Mar 2018 14:04:36 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org
Subject: [PATCH] x86/ioapic: Do not unmask io_apic when interrupt is in
 progress
Message-ID: <20180302130436.uxv7hjruung6m5x7@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>
Date: Fri, 3 Jul 2009 08:29:27 -0500

With threaded interrupts we might see an interrupt in progress on
migration. Do not unmask it when this is the case.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/apic/io_apic.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1690,7 +1690,8 @@ static bool io_apic_level_ack_pending(st
 static inline bool ioapic_irqd_mask(struct irq_data *data)
 {
 	/* If we are moving the irq we need to mask it */
-	if (unlikely(irqd_is_setaffinity_pending(data))) {
+	if (unlikely(irqd_is_setaffinity_pending(data) &&
+		     !irqd_irq_inprogress(data))) {
 		mask_ioapic_irq(data);
 		return true;
 	}
