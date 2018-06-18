Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23270C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BB220864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BB220864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935936AbeFRJne (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:43:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55506 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965449AbeFRIWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:22:21 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 77BFCC7F;
        Mon, 18 Jun 2018 08:22:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sultan Alsawaf <sultanxda@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 154/279] pinctrl: cherryview: Associate IRQ descriptors to irqdomain
Date:   Mon, 18 Jun 2018 10:12:19 +0200
Message-Id: <20180618080615.206240615@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit 83b9dc11312f48a561594a895672abb6cb2a2250 ]

When we dropped the custom Linux GPIO translation it resulted that the
IRQ numbers changed slightly as well. Normally this would be fine
because everyone is expected to use controller relative GPIO numbers and
ACPI GpioIo/GpioInt resources. However, there is a certain set of
Intel_Strago based Chromebooks where i8042 keyboard controller IRQ
number is hardcoded be 182 (this is corrected with newer coreboot but
the older ones still have the hardcoded Linux IRQ number). Because of
this hardcoded IRQ number keyboard on those systems accidentally broke
again.

Fix this by iteratively associating IRQ descriptors to the chip irqdomain
so that there are no gaps on those systems. Other systems are not
affected.

Fixes: 03c4749dd6c7 ("gpio / ACPI: Drop unnecessary ACPI GPIO to Linux GPIO translation")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=199463
Reported-by: Sultan Alsawaf <sultanxda@gmail.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/intel/pinctrl-cherryview.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1622,22 +1622,30 @@ static int chv_gpio_probe(struct chv_pin
 
 	if (!need_valid_mask) {
 		irq_base = devm_irq_alloc_descs(pctrl->dev, -1, 0,
-						chip->ngpio, NUMA_NO_NODE);
+						community->npins, NUMA_NO_NODE);
 		if (irq_base < 0) {
 			dev_err(pctrl->dev, "Failed to allocate IRQ numbers\n");
 			return irq_base;
 		}
-	} else {
-		irq_base = 0;
 	}
 
-	ret = gpiochip_irqchip_add(chip, &chv_gpio_irqchip, irq_base,
+	ret = gpiochip_irqchip_add(chip, &chv_gpio_irqchip, 0,
 				   handle_bad_irq, IRQ_TYPE_NONE);
 	if (ret) {
 		dev_err(pctrl->dev, "failed to add IRQ chip\n");
 		return ret;
 	}
 
+	if (!need_valid_mask) {
+		for (i = 0; i < community->ngpio_ranges; i++) {
+			range = &community->gpio_ranges[i];
+
+			irq_domain_associate_many(chip->irq.domain, irq_base,
+						  range->base, range->npins);
+			irq_base += range->npins;
+		}
+	}
+
 	gpiochip_set_chained_irqchip(chip, &chv_gpio_irqchip, irq,
 				     chv_gpio_irq_handler);
 	return 0;


