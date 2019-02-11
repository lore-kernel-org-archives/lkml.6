Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D39DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E18320700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895959;
	bh=VyoDQac3EzEIRzDuYJrE080cOn0aMaQB7t3onXdTEUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G53aMet+VcWwlZjQvkzM0B8amdGfdEC4q/UBqcCPcNgerYuL9XcUtAXmj92KrnZjU
	 zJ5LEmScLm1UcE/zgMKJrfs+H7PeivR9HXFijN0nCBuTw4dDB1yxR5Z5xVqFmTdArt
	 HZw/yjixBX8/2BrG2dkgGu1WFUoWDuBQbiW1Ki+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731845AbfBKOjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:39:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:49410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731348AbfBKOjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:39:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82236204FD;
        Mon, 11 Feb 2019 14:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895954;
        bh=VyoDQac3EzEIRzDuYJrE080cOn0aMaQB7t3onXdTEUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CmDCRC1blt3ouVTkO9p5ohB9k3PJGmAE0KcSKDA8P/T02pi3QDR9yhVJANv22ilpW
         D4tAEPGawtUzkO05unGCxl7FngjFW2HLNWM3td8EQ5Q427InM5NT0n0foODSsqEzeE
         MsEEamRv4X2I2i+yi+cZeXHcAHCvNaZTHC5kWt8c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mathias Duckeck <m.duckeck@kunbus.de>,
        Lukas Wunner <lukas@wunner.de>,
        Julia Cartwright <julia@ni.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 005/313] pinctrl: bcm2835: Use raw spinlock for RT compatibility
Date:   Mon, 11 Feb 2019 15:14:45 +0100
Message-Id: <20190211141853.152404879@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 3c7b30f704b6f5e53eed6bf89cf2c8d1b38b02c0 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index fa530913a2c8..08925d24180b 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -90,7 +90,7 @@ struct bcm2835_pinctrl {
 	struct gpio_chip gpio_chip;
 	struct pinctrl_gpio_range gpio_range;
 
-	spinlock_t irq_lock[BCM2835_NUM_BANKS];
+	raw_spinlock_t irq_lock[BCM2835_NUM_BANKS];
 };
 
 /* pins are just named GPIO0..GPIO53 */
@@ -461,10 +461,10 @@ static void bcm2835_gpio_irq_enable(struct irq_data *data)
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
@@ -476,12 +476,12 @@ static void bcm2835_gpio_irq_disable(struct irq_data *data)
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
@@ -584,7 +584,7 @@ static int bcm2835_gpio_irq_set_type(struct irq_data *data, unsigned int type)
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&pc->irq_lock[bank], flags);
+	raw_spin_lock_irqsave(&pc->irq_lock[bank], flags);
 
 	if (test_bit(offset, &pc->enabled_irq_map[bank]))
 		ret = __bcm2835_gpio_irq_set_type_enabled(pc, gpio, type);
@@ -596,7 +596,7 @@ static int bcm2835_gpio_irq_set_type(struct irq_data *data, unsigned int type)
 	else
 		irq_set_handler_locked(data, handle_level_irq);
 
-	spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
+	raw_spin_unlock_irqrestore(&pc->irq_lock[bank], flags);
 
 	return ret;
 }
@@ -1047,7 +1047,7 @@ static int bcm2835_pinctrl_probe(struct platform_device *pdev)
 		for_each_set_bit(offset, &events, 32)
 			bcm2835_gpio_wr(pc, GPEDS0 + i * 4, BIT(offset));
 
-		spin_lock_init(&pc->irq_lock[i]);
+		raw_spin_lock_init(&pc->irq_lock[i]);
 	}
 
 	err = gpiochip_add_data(&pc->gpio_chip, pc);
-- 
2.19.1



