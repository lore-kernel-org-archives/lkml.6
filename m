Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82ADECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00FB21476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKXqlDb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00FB21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbeJSCBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:01:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728788AbeJSCBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:01:13 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39D2021479;
        Thu, 18 Oct 2018 17:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885547;
        bh=8fTwK+f0g0tlJVSmWk+YzwHrTgBRcCNh1LYVsZHgqkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jKXqlDb8fs1DJXxtIeM5B8erMoimI/aYwJC1UfrCmkoo8Eprll0N0V2Kr1T5cnwBE
         HYuSrhnSq6qWazcRRyoWhQp7GjP34+N5fAIPVl14DCnJA8uomQqfQi0yQGLz/Iwh5t
         dy4ngFjYrcuogOpcwZRhr5tS+68Z8972kSHHH+6s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 44/53] pinctrl/amd: poll InterruptEnable bits in amd_gpio_irq_set_type
Date:   Thu, 18 Oct 2018 19:54:37 +0200
Message-Id: <20181018175424.041182494@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.561567978@linuxfoundation.org>
References: <20181018175416.561567978@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Kurtz <djkurtz@chromium.org>

[ Upstream commit b85bfa246efd24ea3fdb5ee949c28e3110c6d299 ]

>From the AMD BKDG, if WAKE_INT_MASTER_REG.MaskStsEn is set, a software
write to the debounce registers of *any* gpio will block wake/interrupt
status generation for *all* gpios for a length of time that depends on
WAKE_INT_MASTER_REG.MaskStsLength[11:0].  During this period the Interrupt
Delivery bit (INTERRUPT_ENABLE) will read as 0.

In commit 4c1de0414a1340 ("pinctrl/amd: poll InterruptEnable bits in
enable_irq") we tried to fix this same "gpio Interrupts are blocked
immediately after writing debounce registers" problem, but incorrectly
assumed it only affected the gpio whose debounce was being configured
and not ALL gpios.

To solve this for all gpios, we move the polling loop from
amd_gpio_irq_enable() to amd_gpio_irq_set_type(), while holding the gpio
spinlock.  This ensures that another gpio operation (e.g.
amd_gpio_irq_unmask()) can read a temporarily disabled IRQ and
incorrectly disable it while trying to modify some other register bits.

Fixes: 4c1de0414a1340 pinctrl/amd: poll InterruptEnable bits in enable_irq
Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/pinctrl-amd.c |   33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -348,21 +348,12 @@ static void amd_gpio_irq_enable(struct i
 	unsigned long flags;
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct amd_gpio *gpio_dev = gpiochip_get_data(gc);
-	u32 mask = BIT(INTERRUPT_ENABLE_OFF) | BIT(INTERRUPT_MASK_OFF);
 
 	raw_spin_lock_irqsave(&gpio_dev->lock, flags);
 	pin_reg = readl(gpio_dev->base + (d->hwirq)*4);
 	pin_reg |= BIT(INTERRUPT_ENABLE_OFF);
 	pin_reg |= BIT(INTERRUPT_MASK_OFF);
 	writel(pin_reg, gpio_dev->base + (d->hwirq)*4);
-	/*
-	 * When debounce logic is enabled it takes ~900 us before interrupts
-	 * can be enabled.  During this "debounce warm up" period the
-	 * "INTERRUPT_ENABLE" bit will read as 0. Poll the bit here until it
-	 * reads back as 1, signaling that interrupts are now enabled.
-	 */
-	while ((readl(gpio_dev->base + (d->hwirq)*4) & mask) != mask)
-		continue;
 	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
 }
 
@@ -426,7 +417,7 @@ static void amd_gpio_irq_eoi(struct irq_
 static int amd_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	int ret = 0;
-	u32 pin_reg;
+	u32 pin_reg, pin_reg_irq_en, mask;
 	unsigned long flags, irq_flags;
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct amd_gpio *gpio_dev = gpiochip_get_data(gc);
@@ -495,6 +486,28 @@ static int amd_gpio_irq_set_type(struct
 	}
 
 	pin_reg |= CLR_INTR_STAT << INTERRUPT_STS_OFF;
+	/*
+	 * If WAKE_INT_MASTER_REG.MaskStsEn is set, a software write to the
+	 * debounce registers of any GPIO will block wake/interrupt status
+	 * generation for *all* GPIOs for a lenght of time that depends on
+	 * WAKE_INT_MASTER_REG.MaskStsLength[11:0].  During this period the
+	 * INTERRUPT_ENABLE bit will read as 0.
+	 *
+	 * We temporarily enable irq for the GPIO whose configuration is
+	 * changing, and then wait for it to read back as 1 to know when
+	 * debounce has settled and then disable the irq again.
+	 * We do this polling with the spinlock held to ensure other GPIO
+	 * access routines do not read an incorrect value for the irq enable
+	 * bit of other GPIOs.  We keep the GPIO masked while polling to avoid
+	 * spurious irqs, and disable the irq again after polling.
+	 */
+	mask = BIT(INTERRUPT_ENABLE_OFF);
+	pin_reg_irq_en = pin_reg;
+	pin_reg_irq_en |= mask;
+	pin_reg_irq_en &= ~BIT(INTERRUPT_MASK_OFF);
+	writel(pin_reg_irq_en, gpio_dev->base + (d->hwirq)*4);
+	while ((readl(gpio_dev->base + (d->hwirq)*4) & mask) != mask)
+		continue;
 	writel(pin_reg, gpio_dev->base + (d->hwirq)*4);
 	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
 


