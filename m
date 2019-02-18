Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED455C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B128321902
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497548;
	bh=MKMXQycbnAEY82m0lUN2bMLLwWKV+TglzRMHmb+OoMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dro9z9qcDbGoFBNri7IqZXqqBLp4ggMhmIynFcw5zwfqriD5jygZpp06kM6NSzVs8
	 8lseLRT0VvAtJU/IK0l2QtOXCvGB1Cem1XbU3eZiKIIrHjs0bI2KKin4TQ7qUkGLvM
	 wOoUU9EDjcdDDZmBGGDngwiYWk3o/ZgwFpBNFi70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbfBRNpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:45:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:52000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731370AbfBRNpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:45:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E124821900;
        Mon, 18 Feb 2019 13:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497542;
        bh=MKMXQycbnAEY82m0lUN2bMLLwWKV+TglzRMHmb+OoMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XXrvWa4uFOqI4gAbxvYq28d+3z+4dH1JAKf6RA6A7UyIVq++vPUj+nh3+1UFcEEqn
         9snPXOrgx6NVDibZhRirME4GO1CtXhEcdjriLE5UxtSyyilGs0t5/MauWkIF/SlaJZ
         0BVqcr8rGZ7m9h38VsJsD10JhuWTyJ3o/4qnne2Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>,
        Lu Baoquan <lu.baoquan@intellif.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 16/92] irqchip/csky: fixup handle_irq_perbit break irq
Date:   Mon, 18 Feb 2019 14:42:19 +0100
Message-Id: <20190218133456.192109458@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 56752b21755aef598709d143684cb363db98a7d2 ]

The handle_irq_perbit function loop every bit in hwirq local variable.

handle_irq_perbit(hwirq) {
  for_everyt_bit_in(hwirq) {
	handle_domain_irq()
		->irq_exit()
		->invoke_softirq()
		->__do_softirq()
		->local_irq_enable() // Here will cause new interrupt.
  }
}

When new interrupt coming at local_irq_enable, it will finish another
interrupt handler and pull down the interrupt source. But hwirq is the
local variable for handle_irq_perbit(), it can't get new interrupt
controller pending reg status. So we need update hwirq with pending reg
in every loop.

Also change write_relax to writel could prevent stw from fast retire.
When local_irq is enabled, intc regs is really set-in.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Lu Baoquan <lu.baoquan@intellif.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-csky-apb-intc.c | 77 ++++++++++++++++-------------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/drivers/irqchip/irq-csky-apb-intc.c b/drivers/irqchip/irq-csky-apb-intc.c
index 2543baba8b1f..5a2ec43b7ddd 100644
--- a/drivers/irqchip/irq-csky-apb-intc.c
+++ b/drivers/irqchip/irq-csky-apb-intc.c
@@ -95,7 +95,7 @@ static inline void setup_irq_channel(u32 magic, void __iomem *reg_addr)
 
 	/* Setup 64 channel slots */
 	for (i = 0; i < INTC_IRQS; i += 4)
-		writel_relaxed(build_channel_val(i, magic), reg_addr + i);
+		writel(build_channel_val(i, magic), reg_addr + i);
 }
 
 static int __init
@@ -135,16 +135,10 @@ ck_intc_init_comm(struct device_node *node, struct device_node *parent)
 static inline bool handle_irq_perbit(struct pt_regs *regs, u32 hwirq,
 				     u32 irq_base)
 {
-	u32 irq;
-
 	if (hwirq == 0)
 		return 0;
 
-	while (hwirq) {
-		irq = __ffs(hwirq);
-		hwirq &= ~BIT(irq);
-		handle_domain_irq(root_domain, irq_base + irq, regs);
-	}
+	handle_domain_irq(root_domain, irq_base + __fls(hwirq), regs);
 
 	return 1;
 }
@@ -154,12 +148,16 @@ static void gx_irq_handler(struct pt_regs *regs)
 {
 	bool ret;
 
-	do {
-		ret  = handle_irq_perbit(regs,
-				readl_relaxed(reg_base + GX_INTC_PEN31_00), 0);
-		ret |= handle_irq_perbit(regs,
-				readl_relaxed(reg_base + GX_INTC_PEN63_32), 32);
-	} while (ret);
+retry:
+	ret = handle_irq_perbit(regs,
+			readl(reg_base + GX_INTC_PEN63_32), 32);
+	if (ret)
+		goto retry;
+
+	ret = handle_irq_perbit(regs,
+			readl(reg_base + GX_INTC_PEN31_00), 0);
+	if (ret)
+		goto retry;
 }
 
 static int __init
@@ -174,14 +172,14 @@ gx_intc_init(struct device_node *node, struct device_node *parent)
 	/*
 	 * Initial enable reg to disable all interrupts
 	 */
-	writel_relaxed(0x0, reg_base + GX_INTC_NEN31_00);
-	writel_relaxed(0x0, reg_base + GX_INTC_NEN63_32);
+	writel(0x0, reg_base + GX_INTC_NEN31_00);
+	writel(0x0, reg_base + GX_INTC_NEN63_32);
 
 	/*
 	 * Initial mask reg with all unmasked, because we only use enalbe reg
 	 */
-	writel_relaxed(0x0, reg_base + GX_INTC_NMASK31_00);
-	writel_relaxed(0x0, reg_base + GX_INTC_NMASK63_32);
+	writel(0x0, reg_base + GX_INTC_NMASK31_00);
+	writel(0x0, reg_base + GX_INTC_NMASK63_32);
 
 	setup_irq_channel(0x03020100, reg_base + GX_INTC_SOURCE);
 
@@ -204,20 +202,29 @@ static void ck_irq_handler(struct pt_regs *regs)
 	void __iomem *reg_pen_lo = reg_base + CK_INTC_PEN31_00;
 	void __iomem *reg_pen_hi = reg_base + CK_INTC_PEN63_32;
 
-	do {
-		/* handle 0 - 31 irqs */
-		ret  = handle_irq_perbit(regs, readl_relaxed(reg_pen_lo), 0);
-		ret |= handle_irq_perbit(regs, readl_relaxed(reg_pen_hi), 32);
+retry:
+	/* handle 0 - 63 irqs */
+	ret = handle_irq_perbit(regs, readl(reg_pen_hi), 32);
+	if (ret)
+		goto retry;
 
-		if (nr_irq == INTC_IRQS)
-			continue;
+	ret = handle_irq_perbit(regs, readl(reg_pen_lo), 0);
+	if (ret)
+		goto retry;
+
+	if (nr_irq == INTC_IRQS)
+		return;
 
-		/* handle 64 - 127 irqs */
-		ret |= handle_irq_perbit(regs,
-			readl_relaxed(reg_pen_lo + CK_INTC_DUAL_BASE), 64);
-		ret |= handle_irq_perbit(regs,
-			readl_relaxed(reg_pen_hi + CK_INTC_DUAL_BASE), 96);
-	} while (ret);
+	/* handle 64 - 127 irqs */
+	ret = handle_irq_perbit(regs,
+			readl(reg_pen_hi + CK_INTC_DUAL_BASE), 96);
+	if (ret)
+		goto retry;
+
+	ret = handle_irq_perbit(regs,
+			readl(reg_pen_lo + CK_INTC_DUAL_BASE), 64);
+	if (ret)
+		goto retry;
 }
 
 static int __init
@@ -230,11 +237,11 @@ ck_intc_init(struct device_node *node, struct device_node *parent)
 		return ret;
 
 	/* Initial enable reg to disable all interrupts */
-	writel_relaxed(0, reg_base + CK_INTC_NEN31_00);
-	writel_relaxed(0, reg_base + CK_INTC_NEN63_32);
+	writel(0, reg_base + CK_INTC_NEN31_00);
+	writel(0, reg_base + CK_INTC_NEN63_32);
 
 	/* Enable irq intc */
-	writel_relaxed(BIT(31), reg_base + CK_INTC_ICR);
+	writel(BIT(31), reg_base + CK_INTC_ICR);
 
 	ck_set_gc(node, reg_base, CK_INTC_NEN31_00, 0);
 	ck_set_gc(node, reg_base, CK_INTC_NEN63_32, 32);
@@ -260,8 +267,8 @@ ck_dual_intc_init(struct device_node *node, struct device_node *parent)
 		return ret;
 
 	/* Initial enable reg to disable all interrupts */
-	writel_relaxed(0, reg_base + CK_INTC_NEN31_00 + CK_INTC_DUAL_BASE);
-	writel_relaxed(0, reg_base + CK_INTC_NEN63_32 + CK_INTC_DUAL_BASE);
+	writel(0, reg_base + CK_INTC_NEN31_00 + CK_INTC_DUAL_BASE);
+	writel(0, reg_base + CK_INTC_NEN63_32 + CK_INTC_DUAL_BASE);
 
 	ck_set_gc(node, reg_base + CK_INTC_DUAL_BASE, CK_INTC_NEN31_00, 64);
 	ck_set_gc(node, reg_base + CK_INTC_DUAL_BASE, CK_INTC_NEN63_32, 96);
-- 
2.19.1



