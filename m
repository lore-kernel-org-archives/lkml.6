Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19B6C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8559620883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547029281;
	bh=arRYmQass9A+2eZJT3cKmLmZcqFvACHd9vziwKI9j7o=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=sywUgQkA/tmlSlqDCw8J2HixKl48poeFF1VCVPQz/uSbVp0rBLHymjI7sVqhkMpxb
	 mZ+4bPzbHYJ3E2GE2DdN9nBoDnNYXQEeTcjEfWt5eXxzOpMcFNJF0pkzHOrNBdWckO
	 OPrP8GJVctJs7wyamH8w2aMbQSFttcMaKJim02Ys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbfAIKVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:21:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:52436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730150AbfAIKVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:21:20 -0500
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79A312064C;
        Wed,  9 Jan 2019 10:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547029278;
        bh=arRYmQass9A+2eZJT3cKmLmZcqFvACHd9vziwKI9j7o=;
        h=From:To:Cc:Subject:Date:From;
        b=DZql/kYx5w2NQSBnb7tu3SKQy47FQLQEvQu713jF7tAKKRf9Kp5p1aLeSk+NfwHWQ
         KJpKauTIXUMeHDCbLLNcTjlTDKDj1dnzun819hiWGacXQWnaou0wiRFCgzlI68gIAf
         BMhs49v/dJd+aoMhyY/dPHpUQ9Tq8uOP8a3LD2mU=
From:   guoren@kernel.org
To:     jason@lakedaemon.net, tglx@linutronix.de, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH] irqchip/csky: support csky,dh7k SOC intc driver
Date:   Wed,  9 Jan 2019 18:18:26 +0800
Message-Id: <1547029106-20846-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

C-SKY dh7k SOC use simple APB interrupt controller and most of driver's
implementation codes could be reused in csky-apb-intc.c. So merge them
together.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 .../interrupt-controller/csky,apb-intc.txt         |  1 +
 drivers/irqchip/irq-csky-apb-intc.c                | 95 +++++++++++++++++++---
 2 files changed, 86 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
index 44286dc..63bc9dc 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
@@ -23,6 +23,7 @@ intc node bindings definition
 		Definition: must be "csky,apb-intc"
 				    "csky,dual-apb-intc"
 				    "csky,gx6605s-intc"
+				    "csky,dh7k-intc"
 	- #interrupt-cells
 		Usage: required
 		Value type: <u32>
diff --git a/drivers/irqchip/irq-csky-apb-intc.c b/drivers/irqchip/irq-csky-apb-intc.c
index 5a2ec43..fcc5444 100644
--- a/drivers/irqchip/irq-csky-apb-intc.c
+++ b/drivers/irqchip/irq-csky-apb-intc.c
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <asm/irq.h>
+#include <asm/traps.h>
 
 #define INTC_IRQS		64
 
@@ -31,6 +32,17 @@
 #define GX_INTC_NMASK63_32	0x54
 #define GX_INTC_SOURCE		0x60
 
+#define DH_INTC_CLR		0x10
+#define DH_INTC_INIT		0x34
+#define DH_INTC_NMASK31_00	0x08
+#define DH_INTC_NMASK63_32	0x68
+#define DH_INTC_SOURCE31_00	0x14
+#define DH_INTC_SOURCE63_32	0x6c
+#define DH_INTC_EDGE31_00	0x00
+#define DH_INTC_EDGE63_32	0x60
+#define DH_INTC_POLL31_00	0x04
+#define DH_INTC_POLL63_32	0x64
+
 static void __iomem *reg_base;
 static struct irq_domain *root_domain;
 
@@ -58,15 +70,21 @@ static void irq_ck_mask_set_bit(struct irq_data *d)
 }
 
 static void __init ck_set_gc(struct device_node *node, void __iomem *reg_base,
-			     u32 mask_reg, u32 irq_base)
+				u32 en_off, u32 mask_off, u32 irq_base)
 {
 	struct irq_chip_generic *gc;
 
 	gc = irq_get_domain_generic_chip(root_domain, irq_base);
 	gc->reg_base = reg_base;
-	gc->chip_types[0].regs.mask = mask_reg;
-	gc->chip_types[0].chip.irq_mask = irq_gc_mask_clr_bit;
-	gc->chip_types[0].chip.irq_unmask = irq_gc_mask_set_bit;
+	if (en_off) {
+		gc->chip_types[0].regs.mask = en_off;
+		gc->chip_types[0].chip.irq_mask = irq_gc_mask_clr_bit;
+		gc->chip_types[0].chip.irq_unmask = irq_gc_mask_set_bit;
+	} else if (mask_off) {
+		gc->chip_types[0].regs.mask = mask_off;
+		gc->chip_types[0].chip.irq_mask = irq_gc_mask_set_bit;
+		gc->chip_types[0].chip.irq_unmask = irq_gc_mask_clr_bit;
+	}
 
 	if (of_find_property(node, "csky,support-pulse-signal", NULL))
 		gc->chip_types[0].chip.irq_unmask = irq_ck_mask_set_bit;
@@ -183,8 +201,8 @@ gx_intc_init(struct device_node *node, struct device_node *parent)
 
 	setup_irq_channel(0x03020100, reg_base + GX_INTC_SOURCE);
 
-	ck_set_gc(node, reg_base, GX_INTC_NEN31_00, 0);
-	ck_set_gc(node, reg_base, GX_INTC_NEN63_32, 32);
+	ck_set_gc(node, reg_base, GX_INTC_NEN31_00, 0, 0);
+	ck_set_gc(node, reg_base, GX_INTC_NEN63_32, 0, 32);
 
 	set_handle_irq(gx_irq_handler);
 
@@ -192,6 +210,63 @@ gx_intc_init(struct device_node *node, struct device_node *parent)
 }
 IRQCHIP_DECLARE(csky_gx6605s_intc, "csky,gx6605s-intc", gx_intc_init);
 
+static void dh_irq_handler(struct pt_regs *regs)
+{
+	u32 tmp;
+	unsigned long vector = (mfcr("psr") >> 16) & 0xff;
+
+	tmp = readl(reg_base + DH_INTC_CLR);
+	tmp |= BIT(2);
+	writel(tmp, reg_base + DH_INTC_CLR);
+
+	handle_domain_irq(root_domain, vector - 32, regs);
+}
+
+extern void csky_irq(void);
+
+static int __init
+dh_intc_init(struct device_node *node, struct device_node *parent)
+{
+	int ret, i;
+
+	ret = ck_intc_init_comm(node, parent);
+	if (ret)
+		return ret;
+
+	/* set default mode */
+	writel(0xffffffff, reg_base + DH_INTC_EDGE31_00);
+	writel(0xffffffff, reg_base + DH_INTC_EDGE63_32);
+	writel(0xffffffff, reg_base + DH_INTC_POLL31_00);
+	writel(0xffffffff, reg_base + DH_INTC_POLL63_32);
+
+	writel(BIT(1) | BIT(6), reg_base + DH_INTC_INIT);
+
+	/* Setup  0-31 channel slots */
+	for (i = 0; i < INTC_IRQS/2; i += 4)
+		writel(build_channel_val(i, 0x03020100) + 0x40404040,
+				reg_base + DH_INTC_SOURCE31_00 + i);
+
+	/* Setup 32-63 channel slots */
+	for (i = 0; i < INTC_IRQS/2; i += 4)
+		writel(build_channel_val(i, 0x03020100) + 0x40404040,
+				reg_base + DH_INTC_SOURCE63_32 + i);
+
+	/* mask all interrrupts */
+	writel(0xffffffff, reg_base + DH_INTC_NMASK31_00);
+	writel(0xffffffff, reg_base + DH_INTC_NMASK63_32);
+
+	ck_set_gc(node, reg_base, 0, DH_INTC_NMASK31_00, 0);
+	ck_set_gc(node, reg_base, 0, DH_INTC_NMASK63_32, 32);
+
+	for (i = 32; i < 128; i++)
+		VEC_INIT(i, csky_irq);
+
+	set_handle_irq(dh_irq_handler);
+
+	return 0;
+}
+IRQCHIP_DECLARE(csky_dh7k_intc, "csky,dh7k-intc", dh_intc_init);
+
 /*
  * C-SKY simple 64 irqs interrupt controller, dual-together could support 128
  * irqs.
@@ -243,8 +318,8 @@ ck_intc_init(struct device_node *node, struct device_node *parent)
 	/* Enable irq intc */
 	writel(BIT(31), reg_base + CK_INTC_ICR);
 
-	ck_set_gc(node, reg_base, CK_INTC_NEN31_00, 0);
-	ck_set_gc(node, reg_base, CK_INTC_NEN63_32, 32);
+	ck_set_gc(node, reg_base, CK_INTC_NEN31_00, 0, 0);
+	ck_set_gc(node, reg_base, CK_INTC_NEN63_32, 0, 32);
 
 	setup_irq_channel(0x00010203, reg_base + CK_INTC_SOURCE);
 
@@ -270,8 +345,8 @@ ck_dual_intc_init(struct device_node *node, struct device_node *parent)
 	writel(0, reg_base + CK_INTC_NEN31_00 + CK_INTC_DUAL_BASE);
 	writel(0, reg_base + CK_INTC_NEN63_32 + CK_INTC_DUAL_BASE);
 
-	ck_set_gc(node, reg_base + CK_INTC_DUAL_BASE, CK_INTC_NEN31_00, 64);
-	ck_set_gc(node, reg_base + CK_INTC_DUAL_BASE, CK_INTC_NEN63_32, 96);
+	ck_set_gc(node, reg_base + CK_INTC_DUAL_BASE, CK_INTC_NEN31_00, 0, 64);
+	ck_set_gc(node, reg_base + CK_INTC_DUAL_BASE, CK_INTC_NEN63_32, 0, 96);
 
 	setup_irq_channel(0x00010203,
 			  reg_base + CK_INTC_SOURCE + CK_INTC_DUAL_BASE);
-- 
2.7.4

