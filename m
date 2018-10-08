Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25970C677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00322089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6bDKsE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00322089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbeJHWic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:38:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727563AbeJHWib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:38:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17D3D2150F;
        Mon,  8 Oct 2018 15:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012376;
        bh=3MRtnVqi5AAqySeQ2o8Ii8hXF6IhZZHpVsGuNwW6A4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M6bDKsE4vIi5wOS+7dBdjT1AvAjdGbwbD5mGhYwjOFbSucNZI+gfAyAjHOhHyLLWB
         gSVPQNDQC/5YsNbsi+zd5ksaKHK8zpTYUCgrctUBp7CPFfswllZKYrrBycnHZpBAC8
         McxsyLOlSZio192vAKFIUIIkabO0CnU/CA4myksE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Kurtz <djkurtz@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 53/58] pinctrl/amd: poll InterruptEnable bits in amd_gpio_irq_set_type
Date:   Mon,  8 Oct 2018 11:25:18 -0400
Message-Id: <20181008152523.70705-53-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Kurtz <djkurtz@chromium.org>

[ Upstream commit b85bfa246efd24ea3fdb5ee949c28e3110c6d299 ]

From the AMD BKDG, if WAKE_INT_MASTER_REG.MaskStsEn is set, a software
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
---
 drivers/pinctrl/pinctrl-amd.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index b91db89eb924..d3ba867d01f0 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -348,21 +348,12 @@ static void amd_gpio_irq_enable(struct irq_data *d)
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
 
@@ -426,7 +417,7 @@ static void amd_gpio_irq_eoi(struct irq_data *d)
 static int amd_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	int ret = 0;
-	u32 pin_reg;
+	u32 pin_reg, pin_reg_irq_en, mask;
 	unsigned long flags, irq_flags;
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct amd_gpio *gpio_dev = gpiochip_get_data(gc);
@@ -495,6 +486,28 @@ static int amd_gpio_irq_set_type(struct irq_data *d, unsigned int type)
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
 
-- 
2.17.1

