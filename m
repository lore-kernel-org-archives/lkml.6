Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B2CECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 19:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1D52150E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 19:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JAy3iKDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1D52150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeIWBxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 21:53:15 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35802 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbeIWBxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 21:53:15 -0400
Received: by mail-io1-f66.google.com with SMTP id w11-v6so14956481iob.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 12:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+aGHIjhq3Ey4Dk/p/B20R+5ju1ygdAY3HfZG6TiSlm8=;
        b=JAy3iKDtIMAoU5683hV9OD47awjPkEO5j0dXtV2dSjVKNFgQhl+s+j901KDSiKeKyd
         ea1lgztaKj6VtN7p3xxGNyLun/vRgJudMPgf4kftoBiUajbm02dRMOmbYKR06IKEG4Ni
         8IQzBhCHvENkWRIaoHqCfH88xqO9BeHZxt9V4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+aGHIjhq3Ey4Dk/p/B20R+5ju1ygdAY3HfZG6TiSlm8=;
        b=uZk72U2QNnqOfoyFtB3fUb+C3xIIYaVdfJwurkQQkT+0Cz5GzCuTOJBiEKqUNaECIl
         R6R8OIrX/HaRkaRXLoG/JRugxdokzhC6reQKKkOgoZqWSfR8MZ7qxHKmq6qv4OFfTpZC
         +p/Exj3knNVNvq+q0fn3p/MWlSn6PlYX1gQ/G6rEYcbcz1OywP+MJVkzzJKyAqfzaJnh
         jjD40sTeCOoXzrL9A9TuYVa7Q1KsXiJfJ7SJaYSZovyztpoWWTyYy0SGTp0lvLB+hxC3
         XAVRvjMyJo6CWguVOm48QGfEJSVfGJNreL8q3/WPNziKU0d4MnEIJksnRfFvHKopKbg4
         74Rg==
X-Gm-Message-State: ABuFfoiF2xXqSC6mudydcLZxj9FymuA9se2+I6uYCh/ZpuNPm7S0Lk1p
        MSjiPGauurDbxCanX3siIChbDg==
X-Google-Smtp-Source: ACcGV61mjjvM0udyJmTXfltxjFPUV28jmXCUzpNBrysrAQwBEe1lW5TDfJJZ/NkjPhhug9wCk7d+ig==
X-Received: by 2002:a6b:ab41:: with SMTP id u62-v6mr2858544ioe.104.1537646309848;
        Sat, 22 Sep 2018 12:58:29 -0700 (PDT)
Received: from djkurtz2.bld.corp.google.com ([2620:15c:183:0:1cfd:61a5:7215:5f9c])
        by smtp.gmail.com with ESMTPSA id w140-v6sm1333158iof.22.2018.09.22.12.58.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 12:58:29 -0700 (PDT)
From:   Daniel Kurtz <djkurtz@chromium.org>
To:     Daniel Drake <drake@endlessm.com>
Cc:     Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com,
        Ken.Xue@amd.com, Daniel Kurtz <djkurtz@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org (open list:PIN CONTROL SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] pinctrl/amd: poll InterruptEnable bits in amd_gpio_irq_set_type
Date:   Sat, 22 Sep 2018 13:58:26 -0600
Message-Id: <20180922195826.175628-1-djkurtz@chromium.org>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/pinctrl/pinctrl-amd.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index b7788140641ee2..67718b0f978d34 100644
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
2.19.0.444.g18242da7ef-goog

