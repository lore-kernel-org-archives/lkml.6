Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbeECG4N (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 02:56:13 -0400
Received: from regular1.263xmail.com ([211.150.99.139]:60290 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751951AbeECG4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 02:56:12 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-IP-DOMAINF: 1
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <92eaf1be5e7c96fd754aef668736512d>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: briannorris@google.com, heiko@sntech.de,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH] pinctrl: rockchip: Disable interrupt when changing it's capability
Date: Thu,  3 May 2018 14:55:53 +0800
Message-Id: <20180503065553.7762-1-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We saw spurious irq when changing irq's trigger type, for example
setting gpio-keys's wakeup irq trigger type.

And according to the TRM:
"Programming the GPIO registers for interrupt capability, edge-sensitive
or level-sensitive interrupts, and interrupt polarity should be
completed prior to enabling the interrupts on Port A in order to prevent
spurious glitches on the interrupt lines to the interrupt controller."

Reported-by: Brian Norris <briannorris@google.com>
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/pinctrl/pinctrl-rockchip.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 3924779f55785..7ff45ec8330d1 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -2727,9 +2727,19 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 		return -EINVAL;
 	}
 
+	/**
+	 * According to the TRM, we should keep irq disabled during programming
+	 * interrupt capability to prevent spurious glitches on the interrupt
+	 * lines to the interrupt controller.
+	 */
+	data = readl(bank->reg_base + GPIO_INTEN);
+	writel_relaxed(data & ~mask, gc->reg_base + GPIO_INTEN);
+
 	writel_relaxed(level, gc->reg_base + GPIO_INTTYPE_LEVEL);
 	writel_relaxed(polarity, gc->reg_base + GPIO_INT_POLARITY);
 
+	writel_relaxed(data, gc->reg_base + GPIO_INTEN);
+
 	irq_gc_unlock(gc);
 	raw_spin_unlock_irqrestore(&bank->slock, flags);
 	clk_disable(bank->clk);
-- 
2.11.0
