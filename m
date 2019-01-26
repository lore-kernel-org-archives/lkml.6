Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28634C282C9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29C121903
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="cQ7o13w8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfAZPlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 10:41:00 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25411 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfAZPk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 10:40:59 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548517222; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=WtsC50LBz9XFM9Qjo6XVlvX6Jw7eWScq93q+QIF4+C8rqsrWz/kP2hibXL+bcCfR2fBluJwyCnINY7V9B+RwKwDPFz0fwsr2yInMVV6GOp6I3tv4c6IXRmGYnm8BP8VcSeHXrVc7kl+pLoFuBq6Xl+jF4CgJqNmpiyIt8iHx80Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548517222; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=ZMQQb6RMo6Ql1KTU7vlFdr3a00HbQD3abxu6KZlZ8q4=; 
        b=IP9bJbPjbhAWyNK2ysPUqocZolUTnOQZ01sK9DBFzgjobfnhzZE4W+IzQUWlG6pl/1G+JaSAjHvQpFFVQsETqhYfIvxlx9dk0HZZw5jHmJpUp+I2qHEVZKiXLNnarAP3GGNAV6W/WtckVvC82XBwAt32bSjufkcujExvNzbuM+4=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=WBd9tfbczSNfEE177UR7jpOroTlfw3t456XAekneGuF44YusKUZVsPbT0Do8ylIOAjyVaeSIDqf5
    EZuEbBMYuRZKCqXD15HE3f0ZB3XkbdCZCxs0UbG4NXDjFjU5n44F  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548517222;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=3387; bh=ZMQQb6RMo6Ql1KTU7vlFdr3a00HbQD3abxu6KZlZ8q4=;
        b=cQ7o13w8W9z/bU/EyWtbCrt9uW/7XkqrJxzvYelHMyLAs40AkdkB4pNCxqb4K0Uk
        d6idzV6vKBJxFUg2DbqCBu9+idTeaN+/7d3a8U9pMARL3BSyNurD84KiVtKmh/GRBdY
        RZsE3sMK72nB2THMrGTOV6sffxwZ3MsYxcBTOpjI=
Received: from localhost.localdomain (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548517220681724.8545439013658; Sat, 26 Jan 2019 07:40:20 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, mark.rutland@arm.com,
        marc.zyngier@arm.com, jason@lakedaemon.net, tglx@linutronix.de,
        syq@debian.org, jiaxun.yang@flygoat.com, 772753199@qq.com
Subject: [PATCH 1/4] Irqchip: Ingenic: Change interrupt handling form cascade to chained_irq.
Date:   Sat, 26 Jan 2019 23:38:40 +0800
Message-Id: <1548517123-60058-2-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548517123-60058-1-git-send-email-zhouyanjie@zoho.com>
References: <1548517123-60058-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt handling method is changed from old-style cascade to
chained_irq which is more appropriate. Also, it can process the
corner situation that more than one irq is coming to a single
chip at the same time.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---
 drivers/irqchip/irq-ingenic.c | 49 ++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index 2ff0898..2713ec4 100644
--- a/drivers/irqchip/irq-ingenic.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -1,16 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
- *  JZ4740 platform IRQ support
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under  the terms of the GNU General	 Public License as published by the
- *  Free Software Foundation;  either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
+ *  Ingenic XBurst platform IRQ support
  */
 
 #include <linux/errno.h>
@@ -19,6 +10,7 @@
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/irqchip/ingenic.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -41,22 +33,35 @@ struct ingenic_intc_data {
 #define JZ_REG_INTC_PENDING	0x10
 #define CHIP_SIZE		0x20
 
-static irqreturn_t intc_cascade(int irq, void *data)
+static void ingenic_chained_handle_irq(struct irq_desc *desc)
 {
-	struct ingenic_intc_data *intc = irq_get_handler_data(irq);
-	uint32_t irq_reg;
+	struct ingenic_intc_data *intc = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	bool have_irq = false;
+	u32 pending;
 	unsigned i;
 
+	chained_irq_enter(chip, desc);
 	for (i = 0; i < intc->num_chips; i++) {
-		irq_reg = readl(intc->base + (i * CHIP_SIZE) +
+		pending = readl(intc->base + (i * CHIP_SIZE) +
 				JZ_REG_INTC_PENDING);
-		if (!irq_reg)
+		if (!pending)
 			continue;
 
-		generic_handle_irq(__fls(irq_reg) + (i * 32) + JZ4740_IRQ_BASE);
+		have_irq = true;
+		while (pending) {
+			int bit = __ffs(pending);
+
+			generic_handle_irq(__fls(pending) + (i * 32) +
+					JZ4740_IRQ_BASE);
+			pending &= ~BIT(bit);
+		}
 	}
 
-	return IRQ_HANDLED;
+	if (!have_irq)
+		spurious_interrupt();
+
+	chained_irq_exit(chip, desc);
 }
 
 static void intc_irq_set_mask(struct irq_chip_generic *gc, uint32_t mask)
@@ -79,11 +84,6 @@ void ingenic_intc_irq_resume(struct irq_data *data)
 	intc_irq_set_mask(gc, gc->mask_cache);
 }
 
-static struct irqaction intc_cascade_action = {
-	.handler = intc_cascade,
-	.name = "SoC intc cascade interrupt",
-};
-
 static int __init ingenic_intc_of_init(struct device_node *node,
 				       unsigned num_chips)
 {
@@ -148,7 +148,8 @@ static int __init ingenic_intc_of_init(struct device_node *node,
 	if (!domain)
 		pr_warn("unable to register IRQ domain\n");
 
-	setup_irq(parent_irq, &intc_cascade_action);
+	irq_set_chained_handler_and_data(parent_irq,
+					ingenic_chained_handle_irq, intc);
 	return 0;
 
 out_unmap_irq:
-- 
2.7.4


