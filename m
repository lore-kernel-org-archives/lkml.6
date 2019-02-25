Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007F1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C477021841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129644;
	bh=PtLY7atGHTSi9HYAze4BeUTZ33eLO4v97v8MwOFM7Jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p4gdmEmCMuQIA7sYmy/T+ujVDt9UII7pAVo81DN0cTkgIoDiVlXDErl3aNFXtKk60
	 SzcXt88+lSfde6kKFcJCB7UITjdnnLs2rKNBiGYKQAGoAnfjvk/2TQ8uuvXaCZUiJA
	 SSyXcqPhfvmlAoaEPJSaGTPyYdeIPogwjLi/G5oQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbfBYVUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:20:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:54092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728929AbfBYVUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:20:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37F772183F;
        Mon, 25 Feb 2019 21:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129639;
        bh=PtLY7atGHTSi9HYAze4BeUTZ33eLO4v97v8MwOFM7Jc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vceyKxBs0AU1aNIpm65BDPSAOmzfv3q1xKaoPZmMZGI/5JqHMRO98AATcXTLZj7y1
         1cfMBIk9lfhnB29RaQe88dHhO8z4AgxwF3T07P9QJVZUybYRL/JQQX7lLevTe2asIZ
         jF6Yz6tOxoqPbN3gPWEBJl1XZy4DBfUS3ZEVXy+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ren=C3=A9=20van=20Dorst?= <opensource@vdorst.com>,
        linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Greg Ungerer <gerg@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.19 004/152] gpio: MT7621: use a per instance irq_chip structure
Date:   Mon, 25 Feb 2019 22:09:56 +0100
Message-Id: <20190225195043.950408230@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

From: René van Dorst <opensource@vdorst.com>

commit fa84667b98fd1a191b2465d66b440bda6714b3bf upstream.

This fixes the kernel complains:
gpio gpiochip1: (1e000600.gpio-bank1): detected irqchip that is shared
	    with multiple gpiochips: please fix the driver.
gpio gpiochip2: (1e000600.gpio-bank2): detected irqchip that is shared
	    with multiple gpiochips: please fix the driver.

Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")
Cc: stable@vger.kernel.org
Signed-off-by: René van Dorst <opensource@vdorst.com>
Cc: linux-gpio@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org
Tested-by: Greg Ungerer <gerg@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpio-mt7621.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- a/drivers/gpio/gpio-mt7621.c
+++ b/drivers/gpio/gpio-mt7621.c
@@ -30,6 +30,7 @@
 #define GPIO_REG_EDGE		0xA0
 
 struct mtk_gc {
+	struct irq_chip irq_chip;
 	struct gpio_chip chip;
 	spinlock_t lock;
 	int bank;
@@ -189,13 +190,6 @@ mediatek_gpio_irq_type(struct irq_data *
 	return 0;
 }
 
-static struct irq_chip mediatek_gpio_irq_chip = {
-	.irq_unmask		= mediatek_gpio_irq_unmask,
-	.irq_mask		= mediatek_gpio_irq_mask,
-	.irq_mask_ack		= mediatek_gpio_irq_mask,
-	.irq_set_type		= mediatek_gpio_irq_type,
-};
-
 static int
 mediatek_gpio_xlate(struct gpio_chip *chip,
 		    const struct of_phandle_args *spec, u32 *flags)
@@ -254,6 +248,13 @@ mediatek_gpio_bank_probe(struct device *
 		return ret;
 	}
 
+	rg->irq_chip.name = dev_name(dev);
+	rg->irq_chip.parent_device = dev;
+	rg->irq_chip.irq_unmask = mediatek_gpio_irq_unmask;
+	rg->irq_chip.irq_mask = mediatek_gpio_irq_mask;
+	rg->irq_chip.irq_mask_ack = mediatek_gpio_irq_mask;
+	rg->irq_chip.irq_set_type = mediatek_gpio_irq_type;
+
 	if (mtk->gpio_irq) {
 		/*
 		 * Manually request the irq here instead of passing
@@ -270,14 +271,14 @@ mediatek_gpio_bank_probe(struct device *
 			return ret;
 		}
 
-		ret = gpiochip_irqchip_add(&rg->chip, &mediatek_gpio_irq_chip,
+		ret = gpiochip_irqchip_add(&rg->chip, &rg->irq_chip,
 					   0, handle_simple_irq, IRQ_TYPE_NONE);
 		if (ret) {
 			dev_err(dev, "failed to add gpiochip_irqchip\n");
 			return ret;
 		}
 
-		gpiochip_set_chained_irqchip(&rg->chip, &mediatek_gpio_irq_chip,
+		gpiochip_set_chained_irqchip(&rg->chip, &rg->irq_chip,
 					     mtk->gpio_irq, NULL);
 	}
 
@@ -310,7 +311,6 @@ mediatek_gpio_probe(struct platform_devi
 	mtk->gpio_irq = irq_of_parse_and_map(np, 0);
 	mtk->dev = dev;
 	platform_set_drvdata(pdev, mtk);
-	mediatek_gpio_irq_chip.name = dev_name(dev);
 
 	for (i = 0; i < MTK_BANK_CNT; i++) {
 		ret = mediatek_gpio_bank_probe(dev, np, i);


