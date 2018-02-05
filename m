Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753237AbeBEQve (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 11:51:34 -0500
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:35371 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752582AbeBEQv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 11:51:26 -0500
From: Matt Redfearn <matt.redfearn@mips.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
CC: <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Jason Cooper <jason@lakedaemon.net>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] irqchip: mips-gic: Avoid spuriously handling masked interrupts
Date: Mon, 5 Feb 2018 16:45:36 +0000
Message-ID: <1517849136-29508-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1517849406-321458-23044-1056-2
X-BESS-VER: 2018.1-r1801290438
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189699
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7778c4b27cbe ("irqchip: mips-gic: Use pcpu_masks to avoid reading
GIC_SH_MASK*") removed the read of the hardware mask register when
handling shared interrupts, instead using the driver's shadow pcpu_masks
entry as the effective mask. Unfortunately this did not take account of
the write to pcpu_masks during gic_shared_irq_domain_map, which
effectively unmasks the interrupt early. If an interrupt is asserted,
gic_handle_shared_int decodes and processes the interrupt even though it
has not yet been unmasked via gic_unmask_irq, which also sets the
appropriate bit in pcpu_masks.

On the MIPS Boston board, when a console command line of
"console=ttyS0,115200n8r" is passed, the modem status IRQ is enabled in
the UART, which is immediately raised to the GIC. The interrupt has been
mapped, but no handler has yet been registered, nor is it expected to be
unmasked. However, the write to pcpu_masks in gic_shared_irq_domain_map
has effectively unmasked it, resulting in endless reports of:

[    5.058454] irq 13, desc: ffffffff80a7ad80, depth: 1, count: 0, unhandled: 0
[    5.062057] ->handle_irq():  ffffffff801b1838,
[    5.062175] handle_bad_irq+0x0/0x2c0

Where IRQ 13 is the UART interrupt.

To fix this, just remove the write to pcpu_masks in
gic_shared_irq_domain_map. The existing write in gic_unmask_irq is the
correct place for what is now the effective unmasking.

Fixes: 7778c4b27cbe ("irqchip: mips-gic: Use pcpu_masks to avoid reading GIC_SH_MASK*")
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Reviewed-by: Paul Burton <paul.burton@mips.com>

---

 drivers/irqchip/irq-mips-gic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index b2cfc6d66d74..2c3684ba46e5 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -429,8 +429,6 @@ static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	spin_lock_irqsave(&gic_lock, flags);
 	write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | shared_cpu_pin);
 	write_gic_map_vp(intr, BIT(mips_cm_vp_id(cpu)));
-	gic_clear_pcpu_masks(intr);
-	set_bit(intr, per_cpu_ptr(pcpu_masks, cpu));
 	irq_data_update_effective_affinity(data, cpumask_of(cpu));
 	spin_unlock_irqrestore(&gic_lock, flags);
 
-- 
2.7.4
