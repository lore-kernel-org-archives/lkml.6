Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A20DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB6220645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571754;
	bh=UR9+SQfF0n32BHrd0tDEo2iyX+WTVd+rZWfmUZobMts=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=JX5RbzOnKcN2FxRTl+xa66oOhKazNuogY+l3O9KCfSyjR5g8sHmzawWOMdNQQ0WPa
	 gKPMfsFREhCdUio8YsvqWt21AzKcvB8Kd/1DiSCyZzMId8+PZiM2HXS2baq82vN5Ha
	 +DiPfYsymNVeTOXQN9N6nDLlt4dfVRLfoAmR+cM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388270AbfAORCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:02:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:52050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731655AbfAOQgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:36:49 -0500
Received: from localhost.localdomain (unknown [60.186.143.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75ED720657;
        Tue, 15 Jan 2019 16:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570208;
        bh=UR9+SQfF0n32BHrd0tDEo2iyX+WTVd+rZWfmUZobMts=;
        h=From:To:Cc:Subject:Date:From;
        b=VLoeFVi45FXqJkYymjWEWhFII7M58ojP764ZE8YxNE/C338xa4vP3MF++5cUBj/HC
         bs1Q3z8ekYyfCEeet5Kbm0HpVpxZqvx6KCkhkaal4NqdhtjJQeQma4OwfZ0imwGB09
         aC8LSBw1mlpZx+xre7OvaPT26wtLHq52ZcnaV7KQ=
From:   guoren@kernel.org
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        guoren@kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH] irqchip/irq-csky-mpintc: Add triger type and priority setting
Date:   Wed, 16 Jan 2019 00:36:39 +0800
Message-Id: <1547570199-25944-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
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

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 .../bindings/interrupt-controller/csky,mpintc.txt  | 24 ++++++-
 drivers/irqchip/irq-csky-mpintc.c                  | 78 +++++++++++++++++++++-
 2 files changed, 99 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
index ab921f1..364b789 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
@@ -11,6 +11,14 @@ Interrupt number definition:
  16-31  : private  irq, and we use 16 as the co-processor timer.
  31-1024: common irq for soc ip.
 
+Interrupt triger mode:
+  IRQ_TYPE_LEVEL_HIGH (default)
+  IRQ_TYPE_LEVEL_LOW
+  IRQ_TYPE_EDGE_RISING
+  IRQ_TYPE_EDGE_FALLING
+
+Interrupt priority range: 0-255
+
 =============================
 intc node bindings definition
 =============================
@@ -26,7 +34,7 @@ intc node bindings definition
 	- #interrupt-cells
 		Usage: required
 		Value type: <u32>
-		Definition: must be <1>
+		Definition: could be <1> or <2>
 	- interrupt-controller:
 		Usage: required
 
@@ -35,6 +43,18 @@ Examples:
 
 	intc: interrupt-controller {
 		compatible = "csky,mpintc";
-		#interrupt-cells = <1>;
+		#interrupt-cells = <2>;
 		interrupt-controller;
 	};
+
+	0: device-example {
+		...
+		interrupts = <33 IRQ_TYPE_EDGE_RISING>;
+		interrupt-parent = <&intc>;
+	};
+
+	1: device-example {
+		...
+		interrupts = <34 ((priority << 4) | IRQ_TYPE_EDGE_RISING)>;
+		interrupt-parent = <&intc>;
+	};
diff --git a/drivers/irqchip/irq-csky-mpintc.c b/drivers/irqchip/irq-csky-mpintc.c
index c67c961..9edc6d3 100644
--- a/drivers/irqchip/irq-csky-mpintc.c
+++ b/drivers/irqchip/irq-csky-mpintc.c
@@ -29,9 +29,12 @@ static void __iomem *INTCL_base;
 
 #define INTCG_ICTLR	0x0
 #define INTCG_CICFGR	0x100
+#define INTCG_CIPRTR	0x200
 #define INTCG_CIDSTR	0x1000
 
 #define INTCL_PICTLR	0x0
+#define INTCL_CFGR	0x14
+#define INTCL_PRTR	0x20
 #define INTCL_SIGR	0x60
 #define INTCL_HPPIR	0x68
 #define INTCL_RDYIR	0x6c
@@ -73,6 +76,78 @@ static void csky_mpintc_eoi(struct irq_data *d)
 	writel_relaxed(d->hwirq, reg_base + INTCL_CACR);
 }
 
+static int csky_mpintc_set_type(struct irq_data *d, unsigned int type)
+{
+	unsigned int priority, triger;
+	unsigned int offset, bit_offset;
+	void __iomem *reg_base;
+
+	/*
+	 * type Bit field: | 32 - 12  |  11 - 4  |   3 - 0    |
+	 *                   reserved   priority   triger type
+	 */
+	triger	 = type & IRQ_TYPE_SENSE_MASK;
+	priority = (type >> 4) & 0xff;
+
+	switch (triger) {
+	case IRQ_TYPE_LEVEL_HIGH:
+		triger = 0;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		triger = 1;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		triger = 2;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		triger = 3;
+		break;
+	default:
+		triger = 0;
+		break;
+	}
+
+	if (d->hwirq < COMM_IRQ_BASE) {
+		reg_base = this_cpu_read(intcl_reg);
+
+		if (triger) {
+			offset = ((d->hwirq * 2) / 32) * 4;
+			bit_offset = (d->hwirq * 2) % 32;
+
+			writel_relaxed(triger << bit_offset,
+				reg_base + INTCL_CFGR + offset);
+		}
+
+		if (priority) {
+			offset = ((d->hwirq * 8) / 32) * 4;
+			bit_offset = (d->hwirq * 8) % 32;
+
+			writel_relaxed(priority << bit_offset,
+				reg_base + INTCL_PRTR + offset);
+		}
+	} else {
+		reg_base = INTCG_base;
+
+		if (triger) {
+			offset = (((d->hwirq - COMM_IRQ_BASE) * 2) / 32) * 4;
+			bit_offset = ((d->hwirq - COMM_IRQ_BASE) * 2) % 32;
+
+			writel_relaxed(triger << bit_offset,
+				reg_base + INTCG_CICFGR + offset);
+		}
+
+		if (priority) {
+			offset = (((d->hwirq - COMM_IRQ_BASE) * 8) / 32) * 4;
+			bit_offset = ((d->hwirq - COMM_IRQ_BASE) * 8) % 32;
+
+			writel_relaxed(priority << bit_offset,
+				reg_base + INTCG_CIPRTR + offset);
+		}
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_SMP
 static int csky_irq_set_affinity(struct irq_data *d,
 				 const struct cpumask *mask_val,
@@ -105,6 +180,7 @@ static struct irq_chip csky_irq_chip = {
 	.irq_eoi	= csky_mpintc_eoi,
 	.irq_enable	= csky_mpintc_enable,
 	.irq_disable	= csky_mpintc_disable,
+	.irq_set_type	= csky_mpintc_set_type,
 #ifdef CONFIG_SMP
 	.irq_set_affinity = csky_irq_set_affinity,
 #endif
@@ -127,7 +203,7 @@ static int csky_irqdomain_map(struct irq_domain *d, unsigned int irq,
 
 static const struct irq_domain_ops csky_irqdomain_ops = {
 	.map	= csky_irqdomain_map,
-	.xlate	= irq_domain_xlate_onecell,
+	.xlate	= irq_domain_xlate_onetwocell,
 };
 
 #ifdef CONFIG_SMP
-- 
2.7.4

