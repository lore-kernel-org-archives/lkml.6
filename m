Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E753C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F36214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548764704;
	bh=NNkb7yH1r01GoJpXR/vG2bsm33g2t1J4FfmsJ0Or540=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BlfRo3IaZNnRdobq32n5FrbdCuNzG5XJoSTFt/Mjq/QHt8igWL+7IMvi/b4bNqNuO
	 KBPE1yZiO0/w/FVOezd1ftgeRPYOn0WJm1zXD2cvmpqFttaWRFBpCfB6ntfAc/luir
	 G01Q2N/s+4grPi5CnzFJfljhm6zjrttc3+C9IPhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfA2MZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:25:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:35868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727589AbfA2MZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:25:00 -0500
Received: from localhost.localdomain (unknown [60.186.218.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76DD520870;
        Tue, 29 Jan 2019 12:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548764699;
        bh=NNkb7yH1r01GoJpXR/vG2bsm33g2t1J4FfmsJ0Or540=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n07dnbYBhAx6Js1giYlHw1C4ktYNPxtSH/C9BxiPZsETs1tZHHM2NmgHKvrm7WTIQ
         4aMC+thEXNOSOCJjLFm1T+P+yyzSxG/NgUVEJB/YIYU1Y4tJVBHqZGRWze1qJ8wMQ8
         qdWzwrncCajuszFbVFefeJ2qD5bsTlA01J+hU7+Q=
From:   guoren@kernel.org
To:     arnd@arndb.de, robh+dt@kernel.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, guoren@kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 05/10] irqchip/irq-csky-mpintc: Add triger type and priority
Date:   Tue, 29 Jan 2019 20:24:24 +0800
Message-Id: <1548764669-16656-5-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548764669-16656-1-git-send-email-guoren@kernel.org>
References: <1548764669-16656-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Support 4 triger types:
 - IRQ_TYPE_LEVEL_HIGH
 - IRQ_TYPE_LEVEL_LOW
 - IRQ_TYPE_EDGE_RISING
 - IRQ_TYPE_EDGE_FALLING

Support 0-255 priority setting for each irq.

Changelog:
 - Fixup this_cpu_read() preempted problem.
 - Optimize the coding style.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-csky-mpintc.c | 105 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-csky-mpintc.c b/drivers/irqchip/irq-csky-mpintc.c
index 99d3f3f..07a3752 100644
--- a/drivers/irqchip/irq-csky-mpintc.c
+++ b/drivers/irqchip/irq-csky-mpintc.c
@@ -17,6 +17,7 @@
 #include <asm/reg_ops.h>
 
 static struct irq_domain *root_domain;
+
 static void __iomem *INTCG_base;
 static void __iomem *INTCL_base;
 
@@ -29,9 +30,12 @@ static void __iomem *INTCL_base;
 
 #define INTCG_ICTLR	0x0
 #define INTCG_CICFGR	0x100
+#define INTCG_CIPRTR	0x200
 #define INTCG_CIDSTR	0x1000
 
 #define INTCL_PICTLR	0x0
+#define INTCL_CFGR	0x14
+#define INTCL_PRTR	0x20
 #define INTCL_SIGR	0x60
 #define INTCL_RDYIR	0x6c
 #define INTCL_SENR	0xa0
@@ -40,6 +44,51 @@ static void __iomem *INTCL_base;
 
 static DEFINE_PER_CPU(void __iomem *, intcl_reg);
 
+static unsigned long *__trigger;
+static unsigned long *__priority;
+
+#define IRQ_OFFSET(irq) ((irq < COMM_IRQ_BASE) ? irq : (irq - COMM_IRQ_BASE))
+
+#define TRIG_BYTE_OFFSET(i)	((((i) * 2) / 32) * 4)
+#define TRIG_BIT_OFFSET(i)	 (((i) * 2) % 32)
+
+#define PRI_BYTE_OFFSET(i)	((((i) * 8) / 32) * 4)
+#define PRI_BIT_OFFSET(i)	 (((i) * 8) % 32)
+
+#define TRIG_VAL(trigger, irq)	(trigger << TRIG_BIT_OFFSET(IRQ_OFFSET(irq)))
+#define TRIG_VAL_MSK(irq)	    (~(3 << TRIG_BIT_OFFSET(IRQ_OFFSET(irq))))
+#define PRI_VAL(priority, irq)	(priority << PRI_BIT_OFFSET(IRQ_OFFSET(irq)))
+#define PRI_VAL_MSK(irq)	  (~(0xff << PRI_BIT_OFFSET(IRQ_OFFSET(irq))))
+
+#define TRIG_BASE(irq) \
+	(TRIG_BYTE_OFFSET(IRQ_OFFSET(irq)) + ((irq < COMM_IRQ_BASE) ? \
+	(this_cpu_read(intcl_reg) + INTCL_CFGR) : (INTCG_base + INTCG_CICFGR)))
+
+#define PRI_BASE(irq) \
+	(PRI_BYTE_OFFSET(IRQ_OFFSET(irq)) + ((irq < COMM_IRQ_BASE) ? \
+	(this_cpu_read(intcl_reg) + INTCL_PRTR) : (INTCG_base + INTCG_CIPRTR)))
+
+static DEFINE_SPINLOCK(setup_lock);
+static void setup_trigger_priority(unsigned long irq, unsigned long trigger,
+				   unsigned long priority)
+{
+	unsigned int tmp;
+
+	spin_lock(&setup_lock);
+
+	/* setup trigger */
+	tmp = readl_relaxed(TRIG_BASE(irq)) & TRIG_VAL_MSK(irq);
+
+	writel_relaxed(tmp | TRIG_VAL(trigger, irq), TRIG_BASE(irq));
+
+	/* setup priority */
+	tmp = readl_relaxed(PRI_BASE(irq)) & PRI_VAL_MSK(irq);
+
+	writel_relaxed(tmp | PRI_VAL(priority, irq), PRI_BASE(irq));
+
+	spin_unlock(&setup_lock);
+}
+
 static void csky_mpintc_handler(struct pt_regs *regs)
 {
 	void __iomem *reg_base = this_cpu_read(intcl_reg);
@@ -52,6 +101,9 @@ static void csky_mpintc_enable(struct irq_data *d)
 {
 	void __iomem *reg_base = this_cpu_read(intcl_reg);
 
+	setup_trigger_priority(d->hwirq, __trigger[d->hwirq],
+				 __priority[d->hwirq]);
+
 	writel_relaxed(d->hwirq, reg_base + INTCL_SENR);
 }
 
@@ -69,6 +121,28 @@ static void csky_mpintc_eoi(struct irq_data *d)
 	writel_relaxed(d->hwirq, reg_base + INTCL_CACR);
 }
 
+static int csky_mpintc_set_type(struct irq_data *d, unsigned int type)
+{
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_LEVEL_HIGH:
+		__trigger[d->hwirq] = 0;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		__trigger[d->hwirq] = 1;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		__trigger[d->hwirq] = 2;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		__trigger[d->hwirq] = 3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_SMP
 static int csky_irq_set_affinity(struct irq_data *d,
 				 const struct cpumask *mask_val,
@@ -101,6 +175,7 @@ static struct irq_chip csky_irq_chip = {
 	.irq_eoi	= csky_mpintc_eoi,
 	.irq_enable	= csky_mpintc_enable,
 	.irq_disable	= csky_mpintc_disable,
+	.irq_set_type	= csky_mpintc_set_type,
 #ifdef CONFIG_SMP
 	.irq_set_affinity = csky_irq_set_affinity,
 #endif
@@ -121,9 +196,29 @@ static int csky_irqdomain_map(struct irq_domain *d, unsigned int irq,
 	return 0;
 }
 
+static int csky_irq_domain_xlate_cells(struct irq_domain *d,
+		struct device_node *ctrlr, const u32 *intspec,
+		unsigned int intsize, unsigned long *out_hwirq,
+		unsigned int *out_type)
+{
+	if (WARN_ON(intsize < 1))
+		return -EINVAL;
+
+	*out_hwirq = intspec[0];
+	if (intsize > 1)
+		*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
+	else
+		*out_type = IRQ_TYPE_NONE;
+
+	if (intsize > 2)
+		__priority[*out_hwirq] = intspec[2];
+
+	return 0;
+}
+
 static const struct irq_domain_ops csky_irqdomain_ops = {
 	.map	= csky_irqdomain_map,
-	.xlate	= irq_domain_xlate_onecell,
+	.xlate	= csky_irq_domain_xlate_cells,
 };
 
 #ifdef CONFIG_SMP
@@ -157,6 +252,14 @@ csky_mpintc_init(struct device_node *node, struct device_node *parent)
 	if (ret < 0)
 		nr_irq = INTC_IRQS;
 
+	__priority = kcalloc(nr_irq, sizeof(unsigned long), GFP_KERNEL);
+	if (__priority == NULL)
+		return -ENXIO;
+
+	__trigger  = kcalloc(nr_irq, sizeof(unsigned long), GFP_KERNEL);
+	if (__trigger == NULL)
+		return -ENXIO;
+
 	if (INTCG_base == NULL) {
 		INTCG_base = ioremap(mfcr("cr<31, 14>"),
 				     INTCL_SIZE*nr_cpu_ids + INTCG_SIZE);
-- 
2.7.4

