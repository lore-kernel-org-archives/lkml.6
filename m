Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeBWIc2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 03:32:28 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40337 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbeBWIb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 03:31:56 -0500
X-Google-Smtp-Source: AH8x227+tOaZ0W5n5JTnU/v1GwsQgBWQXm4EzlRAIwtON4O0VIfEI7FbW9uNJ4TO5JWYdRLKiZ+tiQ==
From: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Ludovic BARRE <ludovic.barre@st.com>
Subject: [PATCH v2 1/2] irqchip: stm32: Optimizes and cleans up stm32-exti irq_domain
Date: Fri, 23 Feb 2018 09:31:44 +0100
Message-Id: <6491f248c6748f21a2acf310e186d2be4f9b4e4c.1519374248.git.radoslaw.pietrzyk@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1519374248.git.radoslaw.pietrzyk@gmail.com>
References: <cover.1519374248.git.radoslaw.pietrzyk@gmail.com>
In-Reply-To: <cover.1519374248.git.radoslaw.pietrzyk@gmail.com>
References: <1519221027-4028-1-git-send-email-radoslaw.pietrzyk@gmail.com> <cover.1519374248.git.radoslaw.pietrzyk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- discards setting handle_simple_irq handler for hierarchy interrupts
- removes acking in chained irq handler as this is done by
irq_chip itself inside handle_edge_irq
- removes unneeded irq_domain_ops.xlate callback

Signed-off-by: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>
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
1.9.1
