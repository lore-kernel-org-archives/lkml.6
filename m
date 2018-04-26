Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756910AbeDZQUv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:20:51 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:62448 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756798AbeDZQTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:19:18 -0400
From: Ludovic Barre <ludovic.Barre@st.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald BAEZA <gerald.baeza@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        radek <radoslaw.pietrzyk@gmail.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH 01/11] irqchip: stm32: Optimizes and cleans up stm32-exti irq_domain
Date: Thu, 26 Apr 2018 18:18:24 +0200
Message-ID: <1524759514-12392-2-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524759514-12392-1-git-send-email-ludovic.Barre@st.com>
References: <1524759514-12392-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-26_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: radek <radoslaw.pietrzyk@gmail.com>

- In stm32_exti_alloc function, discards irq_domain_set_info
  with handle_simple_irq. This overwrite the setting defined while init
  of generic chips. Exti controller manages edge irq type.
- Removes acking in chained irq handler as this is done by
  irq_chip itself inside handle_edge_irq
- removes unneeded irq_domain_ops.xlate callback

Signed-off-by: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>
Acked-by: Ludovic Barre <ludovic.barre@st.com>
Tested-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 36f0fbe..8013a87 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -79,13 +79,6 @@ static unsigned long stm32_exti_pending(struct irq_chip_generic *gc)
 	return irq_reg_readl(gc, stm32_bank->pr_ofst);
 }
 
-static void stm32_exti_irq_ack(struct irq_chip_generic *gc, u32 mask)
-{
-	const struct stm32_exti_bank *stm32_bank = gc->private;
-
-	irq_reg_writel(gc, mask, stm32_bank->pr_ofst);
-}
-
 static void stm32_irq_handler(struct irq_desc *desc)
 {
 	struct irq_domain *domain = irq_desc_get_handler_data(desc);
@@ -106,7 +99,6 @@ static void stm32_irq_handler(struct irq_desc *desc)
 			for_each_set_bit(n, &pending, IRQS_PER_BANK) {
 				virq = irq_find_mapping(domain, irq_base + n);
 				generic_handle_irq(virq);
-				stm32_exti_irq_ack(gc, BIT(n));
 			}
 		}
 	}
@@ -176,16 +168,12 @@ static int stm32_irq_set_wake(struct irq_data *data, unsigned int on)
 static int stm32_exti_alloc(struct irq_domain *d, unsigned int virq,
 			    unsigned int nr_irqs, void *data)
 {
-	struct irq_chip_generic *gc;
 	struct irq_fwspec *fwspec = data;
 	irq_hw_number_t hwirq;
 
 	hwirq = fwspec->param[0];
-	gc = irq_get_domain_generic_chip(d, hwirq);
 
 	irq_map_generic_chip(d, virq, hwirq);
-	irq_domain_set_info(d, virq, hwirq, &gc->chip_types->chip, gc,
-			    handle_simple_irq, NULL, NULL);
 
 	return 0;
 }
@@ -200,7 +188,6 @@ static void stm32_exti_free(struct irq_domain *d, unsigned int virq,
 
 struct irq_domain_ops irq_exti_domain_ops = {
 	.map	= irq_map_generic_chip,
-	.xlate	= irq_domain_xlate_onetwocell,
 	.alloc  = stm32_exti_alloc,
 	.free	= stm32_exti_free,
 };
-- 
2.7.4
