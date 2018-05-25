Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965757AbeEYJw1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:52:27 -0400
Received: from foss.arm.com ([217.140.101.70]:57696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966272AbeEYJvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:51:00 -0400
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH v4 26/26] irqchip/gic-v3: Allow interrupts to be set as pseudo-NMI
Date: Fri, 25 May 2018 10:49:32 +0100
Message-Id: <1527241772-48007-27-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a way to set a GICv3 interrupt as pseudo-NMI. The interrupt
must not be enabled when setting/clearing the NMI status of the interrupt.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/interrupt.h    |  1 +
 2 files changed, 55 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index fa23d12..cea1000 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -305,6 +305,43 @@ static void handle_percpu_devid_nmi(struct irq_desc *desc)
 		chip->irq_eoi(&desc->irq_data);
 }
 
+static int gic_irq_set_irqchip_prio(struct irq_data *d, bool val)
+{
+	u8 prio;
+	irq_flow_handler_t handler;
+
+	if (gic_peek_irq(d, GICD_ISENABLER)) {
+		pr_err("Cannot set NMI property of enabled IRQ %u\n", d->irq);
+		return -EPERM;
+	}
+
+	if (val) {
+		prio = GICD_INT_NMI_PRI;
+
+		if (gic_irq(d) < 32)
+			handler = handle_percpu_devid_nmi;
+		else
+			handler = handle_fasteoi_nmi;
+	} else {
+		prio = GICD_INT_DEF_PRI;
+
+		if (gic_irq(d) < 32)
+			handler = handle_percpu_devid_irq;
+		else
+			handler = handle_fasteoi_irq;
+	}
+
+	/*
+	 * Already in a locked context for the desc from calling
+	 * irq_set_irq_chip_state.
+	 * It should be safe to simply modify the handler.
+	 */
+	irq_to_desc(d->irq)->handle_irq = handler;
+	gic_set_irq_prio(gic_irq(d), gic_dist_base(d), prio);
+
+	return 0;
+}
+
 static int gic_irq_set_irqchip_state(struct irq_data *d,
 				     enum irqchip_irq_state which, bool val)
 {
@@ -326,6 +363,16 @@ static int gic_irq_set_irqchip_state(struct irq_data *d,
 		reg = val ? GICD_ICENABLER : GICD_ISENABLER;
 		break;
 
+	case IRQCHIP_STATE_NMI:
+		if (gic_supports_nmi()) {
+			return gic_irq_set_irqchip_prio(d, val);
+		} else if (val) {
+			pr_warn("Failed to set IRQ %u as NMI, NMIs are unsupported\n",
+				gic_irq(d));
+			return -EINVAL;
+		}
+		return 0;
+
 	default:
 		return -EINVAL;
 	}
@@ -353,6 +400,13 @@ static int gic_irq_get_irqchip_state(struct irq_data *d,
 		*val = !gic_peek_irq(d, GICD_ISENABLER);
 		break;
 
+	case IRQCHIP_STATE_NMI:
+		if (!gic_supports_nmi())
+			return -EINVAL;
+		*val = (gic_get_irq_prio(gic_irq(d), gic_dist_base(d)) ==
+			GICD_INT_NMI_PRI);
+		break;
+
 	default:
 		return -EINVAL;
 	}
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 5426627..02c794f 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -419,6 +419,7 @@ enum irqchip_irq_state {
 	IRQCHIP_STATE_ACTIVE,		/* Is interrupt in progress? */
 	IRQCHIP_STATE_MASKED,		/* Is interrupt masked? */
 	IRQCHIP_STATE_LINE_LEVEL,	/* Is IRQ line high? */
+	IRQCHIP_STATE_NMI,		/* Is IRQ an NMI? */
 };
 
 extern int irq_get_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
-- 
1.9.1
