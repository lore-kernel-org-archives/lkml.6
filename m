Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8D1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D99C218E2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550455502;
	bh=ed1VjmqKzMydv/xvnLDn+jcuERcIg8YPmwr8UPds0LQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m5t+9bjnNed2ay92nP1d/nznnyI+w+YSxaB9li4PEqegKHWoHl9UNWmxndXgqrohZ
	 P5r3hsehcZBIYbR+c0/HIL7HyjTJ+mvFNcj0H30NxYcqGLmL3o+CeK67hJKsgDIeYa
	 5rqOHpqN7pDnK9e5AL1Aa5qDL2mKyJO+546dJ0zY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfBRCFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 21:05:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:52906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728238AbfBRCE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 21:04:58 -0500
Received: from localhost.localdomain (unknown [122.234.57.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BAAA218DE;
        Mon, 18 Feb 2019 02:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550455497;
        bh=ed1VjmqKzMydv/xvnLDn+jcuERcIg8YPmwr8UPds0LQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hHF89bj/r+8/cUAlPQNmLjcCblhL6j3E/jDJSZWKIonKl+Zx388XrgqK7BMcKPQ6B
         h5No+U2BGKGmMrb5EoegPj7OMNQgryP923cTHwWVDHP0PmWkuQvt5CfmYTjc6mxixO
         +P7nA2/elu+ZyFOOuS2xS8XBmI6CzUHo6rVJY9aU=
From:   guoren@kernel.org
To:     marc.zyngier@arm.com, tglx@linutronix.de, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, guoren@kernel.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V2 3/7] irqchip/csky: Optimize remove unnecessary loop irq handle
Date:   Mon, 18 Feb 2019 10:04:39 +0800
Message-Id: <1550455483-11710-3-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550455483-11710-1-git-send-email-guoren@kernel.org>
References: <1550455483-11710-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Here is the previous interrupt processing flow:
while (pending) {
^^^^^^^^^^^^^^^ It's unnecessary!
	get irq
	handle_level/fasteoi_irq {
		mask irq
		driver irq handler
		unmask irq
	}
	irq_exit {
		preempt_count_sub(HARDIRQ_OFFSET);
		if (!in_interrupt() && local_softirq_pending())
			invoke_softirq();
Because:		^^^^^^^^^^^^^^^^ linux enable irq Here!
	}
}

Because linux enable the irq in irq_exit() before ret, we needn't loop
read pending register again for next irq which is done during irq_exit().

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-csky-apb-intc.c | 36 ++++++++++++++++++------------------
 drivers/irqchip/irq-csky-mpintc.c   |  8 ++------
 2 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/irqchip/irq-csky-apb-intc.c b/drivers/irqchip/irq-csky-apb-intc.c
index fcc5444..ae4c59b 100644
--- a/drivers/irqchip/irq-csky-apb-intc.c
+++ b/drivers/irqchip/irq-csky-apb-intc.c
@@ -150,7 +150,7 @@ ck_intc_init_comm(struct device_node *node, struct device_node *parent)
 	return 0;
 }
 
-static inline bool handle_irq_perbit(struct pt_regs *regs, u32 hwirq,
+static inline bool handle_irq_onebit(struct pt_regs *regs, u32 hwirq,
 				     u32 irq_base)
 {
 	if (hwirq == 0)
@@ -166,16 +166,15 @@ static void gx_irq_handler(struct pt_regs *regs)
 {
 	bool ret;
 
-retry:
-	ret = handle_irq_perbit(regs,
+	ret = handle_irq_onebit(regs,
 			readl(reg_base + GX_INTC_PEN63_32), 32);
 	if (ret)
-		goto retry;
+		return;
 
-	ret = handle_irq_perbit(regs,
+	ret = handle_irq_onebit(regs,
 			readl(reg_base + GX_INTC_PEN31_00), 0);
-	if (ret)
-		goto retry;
+	if (!ret)
+		pr_err("%s: none irq pending!\n", __func__);
 }
 
 static int __init
@@ -277,29 +276,30 @@ static void ck_irq_handler(struct pt_regs *regs)
 	void __iomem *reg_pen_lo = reg_base + CK_INTC_PEN31_00;
 	void __iomem *reg_pen_hi = reg_base + CK_INTC_PEN63_32;
 
-retry:
 	/* handle 0 - 63 irqs */
-	ret = handle_irq_perbit(regs, readl(reg_pen_hi), 32);
+	ret = handle_irq_onebit(regs, readl(reg_pen_hi), 32);
 	if (ret)
-		goto retry;
+		return;
 
-	ret = handle_irq_perbit(regs, readl(reg_pen_lo), 0);
+	ret = handle_irq_onebit(regs, readl(reg_pen_lo), 0);
 	if (ret)
-		goto retry;
+		return;
 
-	if (nr_irq == INTC_IRQS)
+	if (nr_irq == INTC_IRQS) {
+		pr_err("%s: none irq pending!\n", __func__);
 		return;
+	}
 
 	/* handle 64 - 127 irqs */
-	ret = handle_irq_perbit(regs,
+	ret = handle_irq_onebit(regs,
 			readl(reg_pen_hi + CK_INTC_DUAL_BASE), 96);
 	if (ret)
-		goto retry;
+		return;
 
-	ret = handle_irq_perbit(regs,
+	ret = handle_irq_onebit(regs,
 			readl(reg_pen_lo + CK_INTC_DUAL_BASE), 64);
-	if (ret)
-		goto retry;
+	if (!ret)
+		pr_err("%s: none irq pending!\n", __func__);
 }
 
 static int __init
diff --git a/drivers/irqchip/irq-csky-mpintc.c b/drivers/irqchip/irq-csky-mpintc.c
index c67c961..99d3f3f 100644
--- a/drivers/irqchip/irq-csky-mpintc.c
+++ b/drivers/irqchip/irq-csky-mpintc.c
@@ -33,7 +33,6 @@ static void __iomem *INTCL_base;
 
 #define INTCL_PICTLR	0x0
 #define INTCL_SIGR	0x60
-#define INTCL_HPPIR	0x68
 #define INTCL_RDYIR	0x6c
 #define INTCL_SENR	0xa0
 #define INTCL_CENR	0xa4
@@ -45,11 +44,8 @@ static void csky_mpintc_handler(struct pt_regs *regs)
 {
 	void __iomem *reg_base = this_cpu_read(intcl_reg);
 
-	do {
-		handle_domain_irq(root_domain,
-				  readl_relaxed(reg_base + INTCL_RDYIR),
-				  regs);
-	} while (readl_relaxed(reg_base + INTCL_HPPIR) & BIT(31));
+	handle_domain_irq(root_domain,
+		readl_relaxed(reg_base + INTCL_RDYIR), regs);
 }
 
 static void csky_mpintc_enable(struct irq_data *d)
-- 
2.7.4

