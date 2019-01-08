Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29418C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED65B20665
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546975948;
	bh=aKX+5uJ9oJTJFJDlew8Ko2+8aMEMSjTRYRglabgiQ94=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2wQWUXTOolUL0tYwv3W3u5s9YZLXhpPzAm97rhDaYlFYY2cQQsFndBm+k6Eon7TtP
	 /0Zk9f7os8eBmGxVy5em25VdQquxcKk2Haa19rg8SI1qUt4wqahKTKtrdWz0eZSN8w
	 pOHc6TevsTj72ym1meA/5Pn2+2BPh2i4lHI1Civ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbfAHTc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:32:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:40940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730270AbfAHTcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:32:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 255F020645;
        Tue,  8 Jan 2019 19:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975943;
        bh=aKX+5uJ9oJTJFJDlew8Ko2+8aMEMSjTRYRglabgiQ94=;
        h=From:To:Cc:Subject:Date:From;
        b=rnpCEzFJk7srqHI1Lgn4sTUZokYtQ0ZYcJq5bbaLz7KpT2/3rLJ2lVURkBzZV7JOt
         qLe8yTYLCSI+XQXGvK0ILaGhKHJVhkYdeLjV3rKyZU+SBlu41PsaT7Skc4T0gCllzg
         cMqaXE/L01kXDLwv3VALnIFtQsosja1HCuNcWZyM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 01/53] gpio: pl061: Move irq_chip definition inside struct pl061
Date:   Tue,  8 Jan 2019 14:31:29 -0500
Message-Id: <20190108193222.123316-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

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
index 6aaaab79c205..f6e1e0e306a3 100644
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

