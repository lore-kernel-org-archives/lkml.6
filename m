Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B33DECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADCE20661
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idMPapN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EADCE20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbeGSAhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 20:37:21 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37936 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbeGSAhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 20:37:19 -0400
Received: by mail-lf0-f66.google.com with SMTP id a4-v6so4709295lff.5;
        Wed, 18 Jul 2018 16:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CE/jxx2sQAbPpsFa3TmZtxhtrPIRLZ2UctIF4wmgTIo=;
        b=idMPapN1PMb2v3kaVFZwajOJPP3xHfJcUb8WU3xBxgb+nbB6xrDNlzN8y8Px1lWSJx
         +xpnKFkJLID0cyzWLQg0j5n/JSDIWy5MCZmWgCyAQm5qJpgzRAG/gcjhFzv76h/yawVY
         er4SSvjYM9V2AQTlxv6VajL6TJRPFNnG7L0yAoriRX1kUN/8o467HD9P+4E1MLFKrtZP
         +UfzF2TUcK50yK/peWuK9bui82ZoHG95gZRxlpmuvwtRb5ATKnahrT1EUqB3X5WBWlqD
         o48nQVH1bfOCMP9vN6+RISFx8mxbjnQG4HhE2Lzkwm4mBVFxhK2E81qc8XCDJNEnEEGo
         3qVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CE/jxx2sQAbPpsFa3TmZtxhtrPIRLZ2UctIF4wmgTIo=;
        b=T6Jh5Y3jAXE96cpvmURDphVxHLKumsymlQ1SIA0ZeHvgHSyihmhmrudMjwJbKXl90P
         YMstnjAAXFRoDN2O+6nYVucERq6mGknKZKtGKBpI/fZh9NjX7Mj01PPmAAcEy07UU6l9
         qYkAmeKUjLT8TVJDBRepgE5nQyXh7+qw30ACzjDNqElcARDCWWNOVYCn7T+D8WEyUH/N
         LuDHENdR8KxnXHnwXHFOBHnvrKQ5NOnZQ3nZB3WA//xq/svhTlD7/qxWya+J4aROFQZh
         2tEEX4YE0CBMs0eusT7mDIBwYoeufdIYs8ps+9I3LVIUs0mxIBzJ5rBQ6pxNMLYILoue
         xlyg==
X-Gm-Message-State: AOUpUlHZKKABpd+nXzMROTFPoU9KlPEPmfMosAbqkP2giZUftJHkJ8Hg
        ROKKHcCTf2pv45cl65ZNOlE=
X-Google-Smtp-Source: AAOMgpcKNid2fOSMPG4hIn05+moSynVjPs/1EOVnUIR+ZtsKh2JJ2UvoeBTuHTgJftkgB41Ewr2dEQ==
X-Received: by 2002:a19:4e06:: with SMTP id c6-v6mr4970804lfb.30.1531958218420;
        Wed, 18 Jul 2018 16:56:58 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id h7-v6sm826584ljk.27.2018.07.18.16.56.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 16:56:57 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH 6/8] gpio: omap: Add get/set_multiple() callbacks
Date:   Thu, 19 Jul 2018 01:57:08 +0200
Message-Id: <20180718235710.18242-7-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180718235710.18242-1-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should make applications utilizing whole banks work faster.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/gpio/gpio-omap.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index d1afedf4dcbf..e81008678a38 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -77,6 +77,8 @@ struct gpio_bank {
 	bool workaround_enabled;
 
 	void (*set_dataout)(struct gpio_bank *bank, unsigned gpio, int enable);
+	void (*set_dataout_multiple)(struct gpio_bank *bank,
+				     unsigned long *mask, unsigned long *bits);
 	int (*get_context_loss_count)(struct device *dev);
 
 	struct omap_gpio_reg_offs *regs;
@@ -161,6 +163,51 @@ static int omap_get_gpio_dataout(struct gpio_bank *bank, int offset)
 	return (readl_relaxed(reg) & (BIT(offset))) != 0;
 }
 
+/* set multiple data out values using dedicate set/clear register */
+static void omap_set_gpio_dataout_reg_multiple(struct gpio_bank *bank,
+					       unsigned long *mask,
+					       unsigned long *bits)
+{
+	void __iomem *reg = bank->base;
+	u32 l;
+
+	l = *bits & *mask;
+	writel_relaxed(l, reg + bank->regs->set_dataout);
+	bank->context.dataout |= l;
+
+	l = ~*bits & *mask;
+	writel_relaxed(l, reg + bank->regs->clr_dataout);
+	bank->context.dataout &= ~l;
+}
+
+/* set multiple data out values using mask register */
+static void omap_set_gpio_dataout_mask_multiple(struct gpio_bank *bank,
+						unsigned long *mask,
+						unsigned long *bits)
+{
+	void __iomem *reg = bank->base + bank->regs->dataout;
+	u32 l = (readl_relaxed(reg) & ~*mask) | (*bits & *mask);
+
+	writel_relaxed(l, reg);
+	bank->context.dataout = l;
+}
+
+static unsigned long omap_get_gpio_datain_multiple(struct gpio_bank *bank,
+					      unsigned long *mask)
+{
+	void __iomem *reg = bank->base + bank->regs->datain;
+
+	return readl_relaxed(reg) & *mask;
+}
+
+static unsigned long omap_get_gpio_dataout_multiple(struct gpio_bank *bank,
+					       unsigned long *mask)
+{
+	void __iomem *reg = bank->base + bank->regs->dataout;
+
+	return readl_relaxed(reg) & *mask;
+}
+
 static inline void omap_gpio_rmw(void __iomem *base, u32 reg, u32 mask, bool set)
 {
 	int l = readl_relaxed(base + reg);
@@ -968,6 +1015,26 @@ static int omap_gpio_output(struct gpio_chip *chip, unsigned offset, int value)
 	return 0;
 }
 
+static int omap_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
+				  unsigned long *bits)
+{
+	struct gpio_bank *bank = gpiochip_get_data(chip);
+	void __iomem *reg = bank->base + bank->regs->direction;
+	unsigned long in = readl_relaxed(reg), l;
+
+	*bits = 0;
+
+	l = in & *mask;
+	if (l)
+		*bits |= omap_get_gpio_datain_multiple(bank, &l);
+
+	l = ~in & *mask;
+	if (l)
+		*bits |= omap_get_gpio_dataout_multiple(bank, &l);
+
+	return 0;
+}
+
 static int omap_gpio_debounce(struct gpio_chip *chip, unsigned offset,
 			      unsigned debounce)
 {
@@ -1012,6 +1079,17 @@ static void omap_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
 }
 
+static void omap_gpio_set_multiple(struct gpio_chip *chip, unsigned long *mask,
+				   unsigned long *bits)
+{
+	struct gpio_bank *bank = gpiochip_get_data(chip);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&bank->lock, flags);
+	bank->set_dataout_multiple(bank, mask, bits);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
+}
+
 /*---------------------------------------------------------------------*/
 
 static void omap_gpio_show_rev(struct gpio_bank *bank)
@@ -1073,9 +1151,11 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
 	bank->chip.get_direction = omap_gpio_get_direction;
 	bank->chip.direction_input = omap_gpio_input;
 	bank->chip.get = omap_gpio_get;
+	bank->chip.get_multiple = omap_gpio_get_multiple;
 	bank->chip.direction_output = omap_gpio_output;
 	bank->chip.set_config = omap_gpio_set_config;
 	bank->chip.set = omap_gpio_set;
+	bank->chip.set_multiple = omap_gpio_set_multiple;
 	if (bank->is_mpuio) {
 		bank->chip.label = "mpuio";
 		if (bank->regs->wkup_en)
@@ -1209,10 +1289,14 @@ static int omap_gpio_probe(struct platform_device *pdev)
 				pdata->get_context_loss_count;
 	}
 
-	if (bank->regs->set_dataout && bank->regs->clr_dataout)
+	if (bank->regs->set_dataout && bank->regs->clr_dataout) {
 		bank->set_dataout = omap_set_gpio_dataout_reg;
-	else
+		bank->set_dataout_multiple = omap_set_gpio_dataout_reg_multiple;
+	} else {
 		bank->set_dataout = omap_set_gpio_dataout_mask;
+		bank->set_dataout_multiple =
+				omap_set_gpio_dataout_mask_multiple;
+	}
 
 	raw_spin_lock_init(&bank->lock);
 	raw_spin_lock_init(&bank->wa_lock);
-- 
2.16.4

