Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423FEC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC252148D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfBUKPq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:15:46 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40774 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfBUKPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:15:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 113C7A78;
        Thu, 21 Feb 2019 02:15:46 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CE9A3F719;
        Thu, 21 Feb 2019 02:15:43 -0800 (PST)
Date:   Thu, 21 Feb 2019 10:15:35 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        linux-mips@vger.kernel.org (open list:BROADCOM BMIPS MIPS ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: Re: [PATCH] irqchip: brcmstb-l2: use _irqsave variants in
 non-interrupt code
Message-ID: <20190221101535.3f7f26e3@why.wild-wind.fr.eu.org>
In-Reply-To: <20190220221528.20811-1-f.fainelli@gmail.com>
References: <20190220221528.20811-1-f.fainelli@gmail.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 14:15:28 -0800
Florian Fainelli <f.fainelli@gmail.com> wrote:

> From: Doug Berger <opendmb@gmail.com>
> 
> Using the irq_gc_lock/irq_gc_unlock functions in the suspend and
> resume functions creates the opportunity for a deadlock during
> suspend, resume, and shutdown. Using the irq_gc_lock_irqsave/
> irq_gc_unlock_irqrestore variants prevents this possible deadlock.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to irqchip-next with:

Cc: stable@vger.kernel.org
Fixes: 7f646e92766e2 ("irqchip: brcmstb-l2: Add Broadcom Set Top Box
Level-2 interrupt controller")

Now, I'm worried this is not the only issue, see below.

> ---
>  drivers/irqchip/irq-brcmstb-l2.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
> index 0e65f609352e..83364fedbf0a 100644
> --- a/drivers/irqchip/irq-brcmstb-l2.c
> +++ b/drivers/irqchip/irq-brcmstb-l2.c
> @@ -129,8 +129,9 @@ static void brcmstb_l2_intc_suspend(struct irq_data *d)
>  	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
>  	struct irq_chip_type *ct = irq_data_get_chip_type(d);
>  	struct brcmstb_l2_intc_data *b = gc->private;
> +	unsigned long flags;
>  
> -	irq_gc_lock(gc);
> +	irq_gc_lock_irqsave(gc, flags);
>  	/* Save the current mask */
>  	b->saved_mask = irq_reg_readl(gc, ct->regs.mask);
>  
> @@ -139,7 +140,7 @@ static void brcmstb_l2_intc_suspend(struct irq_data *d)
>  		irq_reg_writel(gc, ~gc->wake_active, ct->regs.disable);
>  		irq_reg_writel(gc, gc->wake_active, ct->regs.enable);
>  	}
> -	irq_gc_unlock(gc);
> +	irq_gc_unlock_irqrestore(gc, flags);
>  }
>  
>  static void brcmstb_l2_intc_resume(struct irq_data *d)
> @@ -147,8 +148,9 @@ static void brcmstb_l2_intc_resume(struct irq_data *d)
>  	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
>  	struct irq_chip_type *ct = irq_data_get_chip_type(d);
>  	struct brcmstb_l2_intc_data *b = gc->private;
> +	unsigned long flags;
>  
> -	irq_gc_lock(gc);
> +	irq_gc_lock_irqsave(gc, flags);
>  	if (ct->chip.irq_ack) {
>  		/* Clear unmasked non-wakeup interrupts */
>  		irq_reg_writel(gc, ~b->saved_mask & ~gc->wake_active,
> @@ -158,7 +160,7 @@ static void brcmstb_l2_intc_resume(struct irq_data *d)
>  	/* Restore the saved mask */
>  	irq_reg_writel(gc, b->saved_mask, ct->regs.disable);
>  	irq_reg_writel(gc, ~b->saved_mask, ct->regs.enable);
> -	irq_gc_unlock(gc);
> +	irq_gc_unlock_irqrestore(gc, flags);
>  }
>  
>  static int __init brcmstb_l2_intc_of_init(struct device_node *np,


I've had a quick look at the generic irqchip code, and the mask/unmask
code seems to suffer from something similar. Both implementations use
the non irq-safe version, and seem vulnerable to the following scenario:

From a non-interrupt context:

irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY)
disable_irq(irq)
    irq_disable(irqdesc, true)
	irq_gc_mask_disable_reg(&irqdesc->irq_data)
	    irq_gc_lock()

interrupt fires here:

brcmstb_l2_intc_irq_handle()
    generic_handle_irq()
        handle_edge_irq()
            mask_ack_irq()
                brcmstb_l2_mask_and_ack()
                    irq_gc_lock() ----> deadlock

I haven't actually observed this, but it feels like it could happen.
This should just be a matter of turning the mask/unmask/set_wake
callbacks into the irq-safe version (see patch below).

Thomas, what do you think?

Thanks,

	M.

From ef003fbeb54c7f12920b842636ee3c7867cc7d69 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <marc.zyngier@arm.com>
Date: Thu, 21 Feb 2019 10:05:24 +0000
Subject: [PATCH] genirq: Fix generic irq chip locking in non-interrupt code

A number of the irqchip methods can be called both in and out
of interrupt context (mask, unmask). If these methods are
using any form of locking, it is crucial to make this locking
interrupt safe, or risk a deadlock in an interrupt occurs during
the critical section.

The generic irqchip implementation doesn't obey the above rule.
Let's address it by changing all the callbacks that can be used
in non-interrupt context to using irqsafe locking.

Fixes: 7d8280624797 ("genirq: Implement a generic interrupt chip")
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 kernel/irq/generic-chip.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index e2999a070a99..a21c42c6db51 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -38,11 +38,12 @@ void irq_gc_mask_disable_reg(struct irq_data *d)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	u32 mask = d->mask;
+	unsigned long flags;
 
-	irq_gc_lock(gc);
+	irq_gc_lock_irqsave(gc, flags);
 	irq_reg_writel(gc, mask, ct->regs.disable);
 	*ct->mask_cache &= ~mask;
-	irq_gc_unlock(gc);
+	irq_gc_unlock_irqrestore(gc, flags);
 }
 
 /**
@@ -57,11 +58,12 @@ void irq_gc_mask_set_bit(struct irq_data *d)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	u32 mask = d->mask;
+	unsigned long flags;
 
-	irq_gc_lock(gc);
+	irq_gc_lock_irqsave(gc, flags);
 	*ct->mask_cache |= mask;
 	irq_reg_writel(gc, *ct->mask_cache, ct->regs.mask);
-	irq_gc_unlock(gc);
+	irq_gc_unlock_irqrestore(gc, flags);
 }
 EXPORT_SYMBOL_GPL(irq_gc_mask_set_bit);
 
@@ -77,11 +79,12 @@ void irq_gc_mask_clr_bit(struct irq_data *d)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	u32 mask = d->mask;
+	unsigned long flags;
 
-	irq_gc_lock(gc);
+	irq_gc_lock_irqsave(gc, flags);
 	*ct->mask_cache &= ~mask;
 	irq_reg_writel(gc, *ct->mask_cache, ct->regs.mask);
-	irq_gc_unlock(gc);
+	irq_gc_unlock_irqrestore(gc, flags);
 }
 EXPORT_SYMBOL_GPL(irq_gc_mask_clr_bit);
 
@@ -97,11 +100,12 @@ void irq_gc_unmask_enable_reg(struct irq_data *d)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	u32 mask = d->mask;
+	unsigned long flags;
 
-	irq_gc_lock(gc);
+	irq_gc_lock_irqsave(gc, flags);
 	irq_reg_writel(gc, mask, ct->regs.enable);
 	*ct->mask_cache |= mask;
-	irq_gc_unlock(gc);
+	irq_gc_unlock_irqrestore(gc, flags);
 }
 
 /**
@@ -188,16 +192,17 @@ int irq_gc_set_wake(struct irq_data *d, unsigned int on)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	u32 mask = d->mask;
+	unsigned long flags;
 
 	if (!(mask & gc->wake_enabled))
 		return -EINVAL;
 
-	irq_gc_lock(gc);
+	irq_gc_lock_irqsave(gc, flags);
 	if (on)
 		gc->wake_active |= mask;
 	else
 		gc->wake_active &= ~mask;
-	irq_gc_unlock(gc);
+	irq_gc_unlock_irqrestore(gc, flags);
 	return 0;
 }
 
-- 
2.20.1


-- 
Without deviation from the norm, progress is not possible.
