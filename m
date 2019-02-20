Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3EEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D23E20859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IT4QAHOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfBTWPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 17:15:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33186 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfBTWPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 17:15:38 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so12646688pfb.0;
        Wed, 20 Feb 2019 14:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JIPebUwrfUQp4/lobhfycIns3KRkR56rOagABg4mSCM=;
        b=IT4QAHOqN9B5lNm3IJ1Q6dA+tYZgPGLa/s+njUzyaU20PCFZn5eHCwdmN8MpKlbGjs
         yUgziNaEEC7w2vNEWz1KCX2SJCJeQGgC4BPo68nzNqqVMRIJyM2rNbFEk4VRrqRkLhWl
         Vo5pIOaO1yYdODf6FGKJ1pW+RBzn5GjNIKzU3lLc7+dFHjIgytYyWjfGF+1CRsA2gQfj
         bl/R16dGORJ9HL7now3zRUWwOpL/PWkf0SheJAsar5MguqYnYnbtWp3WxN2sMvHp+z4z
         6QWIV62O7f1KaaC8aagGGMNblXn6qfGxaq4F+oA3JvN05HFY4WKEKMnpIsmSOpKPOtbv
         SudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JIPebUwrfUQp4/lobhfycIns3KRkR56rOagABg4mSCM=;
        b=Jc0MzyKbHJb5FV4qnZ7PuC3NsO6jBa0vYlSbdPRAU+WQDWBVaMKDfrjyJhypiqDwCx
         sh7hNFM5TRSMExz0TV/Qh9okUUAf1JSviWfrezTYF+OKguA8tTycqpSLlexnD9KKkA7m
         cxTidjfyGK92QRa9Q0KCsH71cZVHVcmfJVopxSTV2M+jTkh9Vwhfwc2peRM1VneV0DoI
         PHdf4IZxkLRnTY6rVrxpMMHOXQFr1Tkt744o2zoKEJTZRbVCLZFBf/PETsrhPkNvNHZ6
         oBS7Ca3UGnh8q2ohjPUx8puLWxCQiFey92z3z8aeukHXyRy2TFL5oFyZwfwCNzy/hSlY
         1BKg==
X-Gm-Message-State: AHQUAuaNrZMzrGngqO3j+dNprwHMF0A3zMX4ZoDJVuQhRx35q1g0xDT3
        dxVV758UTaLYMkatSkb/Wr6jPJhI
X-Google-Smtp-Source: AHgI3IaFNdYHO6F4cdbiItPo5PAZjXMdkk+Tn/fKRXp92LyuZ5qC0fNOwqF82i/6aFfRRctB26ZXaA==
X-Received: by 2002:a65:4608:: with SMTP id v8mr31686795pgq.9.1550700937254;
        Wed, 20 Feb 2019 14:15:37 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z9sm56779603pfd.99.2019.02.20.14.15.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 14:15:36 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org, marc.zyngier@arm.com
Cc:     Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        linux-mips@vger.kernel.org (open list:BROADCOM BMIPS MIPS ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH] irqchip: brcmstb-l2: use _irqsave variants in non-interrupt code
Date:   Wed, 20 Feb 2019 14:15:28 -0800
Message-Id: <20190220221528.20811-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>

Using the irq_gc_lock/irq_gc_unlock functions in the suspend and
resume functions creates the opportunity for a deadlock during
suspend, resume, and shutdown. Using the irq_gc_lock_irqsave/
irq_gc_unlock_irqrestore variants prevents this possible deadlock.

Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/irq-brcmstb-l2.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 0e65f609352e..83364fedbf0a 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -129,8 +129,9 @@ static void brcmstb_l2_intc_suspend(struct irq_data *d)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	struct brcmstb_l2_intc_data *b = gc->private;
+	unsigned long flags;
 
-	irq_gc_lock(gc);
+	irq_gc_lock_irqsave(gc, flags);
 	/* Save the current mask */
 	b->saved_mask = irq_reg_readl(gc, ct->regs.mask);
 
@@ -139,7 +140,7 @@ static void brcmstb_l2_intc_suspend(struct irq_data *d)
 		irq_reg_writel(gc, ~gc->wake_active, ct->regs.disable);
 		irq_reg_writel(gc, gc->wake_active, ct->regs.enable);
 	}
-	irq_gc_unlock(gc);
+	irq_gc_unlock_irqrestore(gc, flags);
 }
 
 static void brcmstb_l2_intc_resume(struct irq_data *d)
@@ -147,8 +148,9 @@ static void brcmstb_l2_intc_resume(struct irq_data *d)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	struct brcmstb_l2_intc_data *b = gc->private;
+	unsigned long flags;
 
-	irq_gc_lock(gc);
+	irq_gc_lock_irqsave(gc, flags);
 	if (ct->chip.irq_ack) {
 		/* Clear unmasked non-wakeup interrupts */
 		irq_reg_writel(gc, ~b->saved_mask & ~gc->wake_active,
@@ -158,7 +160,7 @@ static void brcmstb_l2_intc_resume(struct irq_data *d)
 	/* Restore the saved mask */
 	irq_reg_writel(gc, b->saved_mask, ct->regs.disable);
 	irq_reg_writel(gc, ~b->saved_mask, ct->regs.enable);
-	irq_gc_unlock(gc);
+	irq_gc_unlock_irqrestore(gc, flags);
 }
 
 static int __init brcmstb_l2_intc_of_init(struct device_node *np,
-- 
2.17.1

