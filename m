Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751411AbeFDQ1p (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 12:27:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40682 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbeFDQ1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 12:27:41 -0400
Message-Id: <20180604162224.471925894@linutronix.de>
User-Agent: quilt/0.65
Date: Mon, 04 Jun 2018 17:33:55 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Dmitry Safonov <0x7f454c46@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>, Song Liu <liu.song.a23@gmail.com>,
        Joerg Roedel <jroedel@suse.de>, Mike Travis <mike.travis@hpe.com>,
        stable@vger.kernel.org
Subject: [patch 3/8] x86/apic: Provide apic_ack_irq()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=x86-apic--Provide-apic_ack-variant.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

apic_ack_edge() is explicitely for handling interrupt affinity cleanup when
interrupt remapping is not available or disable.

Remapped interrupts and also some of the platform specific special
interrupts, e.g. UV, invoke ack_APIC_irq() directly.

To address the issue of failing an affinity update with -EBUSY the delayed
affinity mechanism can be reused, but ack_APIC_irq() does not handle
that. Adding this to ack_APIC_irq() is not possible, because that function
is also used for exceptions and directly handled interrupts like IPIs.

Create a new function, which just contains the conditional invocation of
irq_move_irq() and the final ack_APIC_irq(). Making the invocation of
irq_move_irq() conditional avoids the out of line call if the pending bit
is not set.

Reuse the new function in apic_ack_edge().

Preparatory change for the real fix

Fixes: dccfe3147b42 ("x86/vector: Simplify vector move cleanup")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
 arch/x86/include/asm/apic.h   |    2 ++
 arch/x86/kernel/apic/vector.c |   10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -436,6 +436,8 @@ static inline void apic_set_eoi_write(vo
 
 #endif /* CONFIG_X86_LOCAL_APIC */
 
+extern void apic_ack_irq(struct irq_data *data);
+
 static inline void ack_APIC_irq(void)
 {
 	/*
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -809,11 +809,17 @@ static int apic_retrigger_irq(struct irq
 	return 1;
 }
 
+void apic_ack_irq(struct irq_data *irqd)
+{
+	if (unlikely(irqd_is_setaffinity_pending(irqd)))
+		irq_move_irq(irqd);
+	ack_APIC_irq();
+}
+
 void apic_ack_edge(struct irq_data *irqd)
 {
 	irq_complete_move(irqd_cfg(irqd));
-	irq_move_irq(irqd);
-	ack_APIC_irq();
+	apic_ack_irq(irqd);
 }
 
 static struct irq_chip lapic_controller = {
