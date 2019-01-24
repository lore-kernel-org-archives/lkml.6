Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B619C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11ACA20663
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358762;
	bh=18iHws/v8K023HUUZlASxlDZdJ12BEE8wHwLRJukZL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bm+r8OogssiQxaEv1Gk8SQzr4/b7QCMfU/rhUiFDrOx243rBLaTzbe4WbiBMvVJZ1
	 KY6wqTXUnTUsktSVrInAWDzXLqm5bweTtpNLzn6EY7YzvyuxRekoRaazfqnuPlEZuc
	 vXA42B1jdiByJoFodSoezLcKcSGvv4QjXzsMfdoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733039AbfAXTjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:39:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:39362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729654AbfAXTjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:39:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4942F20663;
        Thu, 24 Jan 2019 19:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358753;
        bh=18iHws/v8K023HUUZlASxlDZdJ12BEE8wHwLRJukZL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xQC71huz++Cq5EZ5EQnF7e785r5G8JX64IxLiKy0F0jsQv2H0gWxgza+BicQDjr19
         WqWbY0c9TbuUEGhRis23uTJRG+aKbnelrny/kIx+aMN+QWj/J8p7eIGNdFznRL5+Z7
         guYSI0A3eqWeRliPKVFT7sub4KPJLxmcUey3Ue5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 015/127] gpio: pl061: Move irq_chip definition inside struct pl061
Date:   Thu, 24 Jan 2019 20:19:21 +0100
Message-Id: <20190124190212.819891794@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ed8dce4c6f726b7f3c6bf40859b92a9e32f189c1 ]

Keeping the irq_chip definition static will make it shared with multiple
giochips in the system. This practice is considered to be bad and now we
will get the below warning from gpiolib core:

"detected irqchip that is shared with multiple gpiochips: please fix the
driver."

Hence, move the irq_chip definition from static to `struct pl061` for
using a unique irq_chip for each gpiochip.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-pl061.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index 2afd9de84a0d..dc42571e6fdc 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -54,6 +54,7 @@ struct pl061 {
 
 	void __iomem		*base;
 	struct gpio_chip	gc;
+	struct irq_chip		irq_chip;
 	int			parent_irq;
 
 #ifdef CONFIG_PM
@@ -281,15 +282,6 @@ static int pl061_irq_set_wake(struct irq_data *d, unsigned int state)
 	return irq_set_irq_wake(pl061->parent_irq, state);
 }
 
-static struct irq_chip pl061_irqchip = {
-	.name		= "pl061",
-	.irq_ack	= pl061_irq_ack,
-	.irq_mask	= pl061_irq_mask,
-	.irq_unmask	= pl061_irq_unmask,
-	.irq_set_type	= pl061_irq_type,
-	.irq_set_wake	= pl061_irq_set_wake,
-};
-
 static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	struct device *dev = &adev->dev;
@@ -328,6 +320,13 @@ static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 	/*
 	 * irq_chip support
 	 */
+	pl061->irq_chip.name = dev_name(dev);
+	pl061->irq_chip.irq_ack	= pl061_irq_ack;
+	pl061->irq_chip.irq_mask = pl061_irq_mask;
+	pl061->irq_chip.irq_unmask = pl061_irq_unmask;
+	pl061->irq_chip.irq_set_type = pl061_irq_type;
+	pl061->irq_chip.irq_set_wake = pl061_irq_set_wake;
+
 	writeb(0, pl061->base + GPIOIE); /* disable irqs */
 	irq = adev->irq[0];
 	if (irq < 0) {
@@ -336,14 +335,14 @@ static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 	pl061->parent_irq = irq;
 
-	ret = gpiochip_irqchip_add(&pl061->gc, &pl061_irqchip,
+	ret = gpiochip_irqchip_add(&pl061->gc, &pl061->irq_chip,
 				   0, handle_bad_irq,
 				   IRQ_TYPE_NONE);
 	if (ret) {
 		dev_info(&adev->dev, "could not add irqchip\n");
 		return ret;
 	}
-	gpiochip_set_chained_irqchip(&pl061->gc, &pl061_irqchip,
+	gpiochip_set_chained_irqchip(&pl061->gc, &pl061->irq_chip,
 				     irq, pl061_irq_handler);
 
 	amba_set_drvdata(adev, pl061);
-- 
2.19.1



