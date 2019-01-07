Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FCFC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2FF2147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfAGTyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:54:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:35494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728189AbfAGTxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:53:35 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD61B218A3;
        Mon,  7 Jan 2019 19:53:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1ggaxo-0000Jz-Rf; Mon, 07 Jan 2019 14:53:32 -0500
Message-Id: <20190107195332.697308672@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Jan 2019 14:52:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Mathias Duckeck <m.duckeck@kunbus.de>,
        Lukas Wunner <lukas@wunner.de>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH RT 06/13] pinctrl: bcm2835: Use raw spinlock for RT compatibility
References: <20190107195252.599921907@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14.87-rt50-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

[ Upstream commit 71dfaa749f2f7c1722ebf6716d3f797a04528cba ]

The BCM2835 pinctrl driver acquires a spinlock in its ->irq_enable,
->irq_disable and ->irq_set_type callbacks.  Spinlocks become sleeping
locks with CONFIG_PREEMPT_RT_FULL=y, therefore invocation of one of the
callbacks in atomic context may cause a hard lockup if at least two GPIO
pins in the same bank are used as interrupts.  The issue doesn't occur
with just a single interrupt pin per bank because the lock is never
contended.  I'm experiencing such lockups with GPIO 8 and 28 used as
level-triggered interrupts, i.e. with ->irq_disable being invoked on
reception of every IRQ.

The critical section protected by the spinlock is very small (one bitop
and one RMW of an MMIO register), hence converting to a raw spinlock
seems a better trade-off than converting the driver to threaded IRQ
handling (which would increase latency to handle an interrupt).

Cc: Mathias Duckeck <m.duckeck@kunbus.de>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Acked-by: Julia Cartwright <julia@ni.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index ff782445dfb7..e72bf2502eca 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -92,7 +92,7 @@ struct bcm2835_pinctrl {
 	struct gpio_chip gpio_chip;
 	struct pinctrl_gpio_range gpio_range;
 
-	spinlock_t irq_lock[BCM2835_NUM_BANKS];
+	raw_spinlock_t irq_lock[BCM2835_NUM_BANKS];
 };
 
 /* pins are just named GPIO0..GPIO53 */
@@ -471,10 +471,10 @@ static void bcm2835_gpio_irq_enable(struct irq_data *data)
 	unsigned bank = GPIO_REG_OFFSET(gpio);
 	unsigned long flags;
 
-	spin_lock_irqsave(&pc->irq_lock[bank], flags);
+	raw_spin_lock_irqsave(&pc->irq_lock[bank], flags);
 	set_bit(offset, &pc->enabled_irq_map[bank]);
 	bcm2835_gpio_irq_config(pc, gpio, true);
-	spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
+	raw_spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
 }
 
 static void bcm2835_gpio_irq_disable(struct irq_data *data)
@@ -486,12 +486,12 @@ static void bcm2835_gpio_irq_disable(struct irq_data *data)
 	unsigned bank = GPIO_REG_OFFSET(gpio);
 	unsigned long flags;
 
-	spin_lock_irqsave(&pc->irq_lock[bank], flags);
+	raw_spin_lock_irqsave(&pc->irq_lock[bank], flags);
 	bcm2835_gpio_irq_config(pc, gpio, false);
 	/* Clear events that were latched prior to clearing event sources */
 	bcm2835_gpio_set_bit(pc, GPEDS0, gpio);
 	clear_bit(offset, &pc->enabled_irq_map[bank]);
-	spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
+	raw_spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
 }
 
 static int __bcm2835_gpio_irq_set_type_disabled(struct bcm2835_pinctrl *pc,
@@ -594,7 +594,7 @@ static int bcm2835_gpio_irq_set_type(struct irq_data *data, unsigned int type)
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&pc->irq_lock[bank], flags);
+	raw_spin_lock_irqsave(&pc->irq_lock[bank], flags);
 
 	if (test_bit(offset, &pc->enabled_irq_map[bank]))
 		ret = __bcm2835_gpio_irq_set_type_enabled(pc, gpio, type);
@@ -606,7 +606,7 @@ static int bcm2835_gpio_irq_set_type(struct irq_data *data, unsigned int type)
 	else
 		irq_set_handler_locked(data, handle_level_irq);
 
-	spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
+	raw_spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
 
 	return ret;
 }
@@ -1021,7 +1021,7 @@ static int bcm2835_pinctrl_probe(struct platform_device *pdev)
 		for_each_set_bit(offset, &events, 32)
 			bcm2835_gpio_wr(pc, GPEDS0 + i * 4, BIT(offset));
 
-		spin_lock_init(&pc->irq_lock[i]);
+		raw_spin_lock_init(&pc->irq_lock[i]);
 	}
 
 	err = gpiochip_add_data(&pc->gpio_chip, pc);
-- 
2.19.2


