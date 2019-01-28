Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690F5C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385EC2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697972;
	bh=cu9oaL5Qh4oRfgsQ43pu620QNt3zV7o3X9rv5QO/njw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aoMr651X7+HJd6H39wedlFoITBvKo5OD7RnIR65BLGmLpvFtZD/ysrBA413xZRgW6
	 6NWcXe4MtO4QI+J8888dcqjZrZkTGxgky10H0KEf1ZaGlJohlHriVZ3klYcH+5Xr0J
	 Zv9WrnuHTVZWll1G+FNXuX2tSUnzO/ecH6vURAuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfA1Rwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:52:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:56996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbfA1Pns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:43:48 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD27521738;
        Mon, 28 Jan 2019 15:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690227;
        bh=cu9oaL5Qh4oRfgsQ43pu620QNt3zV7o3X9rv5QO/njw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zIOu1A4jX+ENRRrroXTGNFhga81q4OjJgyY7OrrioCKLVUtSwIZI57svJ6KxK2Bql
         ivPLvvdA7LRQRrvTdVtj16iJ0sOI6P3HWe6BXocTeaKQZY+PGon6HcWftdG9+XXf4d
         pUgqw7ZOM+6nSKDjuohFtmL6EKNpzv3CBA+8tJA8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lukas Wunner <lukas@wunner.de>,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 005/304] pinctrl: bcm2835: Use raw spinlock for RT compatibility
Date:   Mon, 28 Jan 2019 10:38:42 -0500
Message-Id: <20190128154341.47195-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>

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

