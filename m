Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E78ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5D0206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HsDFzDP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5D0206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeJYB60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:58:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39855 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbeJYB6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:58:25 -0400
Received: by mail-pl1-f195.google.com with SMTP id e67-v6so2547145plb.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 10:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=oLtwJjIz/IU8OXu+/CrIVG1zsDaxMtMaiIL2AWF5Eug=;
        b=HsDFzDP7ERvGcsVIxM6lWMjFUa/fqNXf+wpoxF57dtUziMk6ZkgJhKUbhM7NkP5PE6
         8TC8TeN0zTipMR0Vx7h9TjiPSsE86eF4j6Cv78qXIIavv832BjtzEy0ZiFOa3IxOjUNR
         f3D4y7q3dbS7FQKPUfESPhjQZ3gR+Jac/3NXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oLtwJjIz/IU8OXu+/CrIVG1zsDaxMtMaiIL2AWF5Eug=;
        b=MYaksIJWpq/1+yrYK+Ev2+AcPHDl/HbSbaLujYJko+oJ5dsMGY3Fbq5f7aAD4kX+mp
         ZIgkFWmkQyTwoTzX0jndpQL+kqlNBPJesbTZVtmD2n/JEKUrtoJOhpY2cPTKWESmGLeP
         IsKgjnp7TYprOzXDgENLlsJhTQRsM81c6RWPwFcqEvWyJEmEzen40VT32dz7ncvtD7aL
         Zf8gH5KJt4bqVwafg6TQK7FdCrrXTARpSct3mCVPqN+FlHr+MP80ST1HtO1H38wnnzhF
         qScF8HklbmirYL/7hETyezI3LFW+1BACXKi2Qkp49THe00sqZ8J5esdyTLCS+CDG3LZo
         j4eA==
X-Gm-Message-State: AGRZ1gLy+etZg2ayH2yrnsHpcJ++3bVR8ksLq4N4yHticiEuCF26L8Be
        PTWxRNBU7teEr/H5Xo5b4a2s
X-Google-Smtp-Source: AJdET5dpA/9WZYlmHK/OS7tylzfJ6tWgpx1fur4Vg4eJuWKoq91Rfv0f/NOKDez8RTYFBpZZzPWevw==
X-Received: by 2002:a17:902:8b8a:: with SMTP id ay10-v6mr3325306plb.130.1540402170776;
        Wed, 24 Oct 2018 10:29:30 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:609e:d62f:18fd:8436:e2d2:50c6])
        by smtp.gmail.com with ESMTPSA id m11-v6sm3922849pfi.102.2018.10.24.10.29.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 10:29:29 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] gpio: pl061: Move irq_chip definition inside struct pl061
Date:   Wed, 24 Oct 2018 22:59:15 +0530
Message-Id: <20181024172915.15544-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keeping the irq_chip definition static will make it shared with multiple
giochips in the system. This practice is considered to be bad and now we
will get the below warning from gpiolib core:

"detected irqchip that is shared with multiple gpiochips: please fix the
driver."

Hence, move the irq_chip definition from static to `struct pl061` for
using a unique irq_chip for each gpiochip.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
2.17.1

