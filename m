Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF56C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A432087C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bLMAZoW6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bLMAZoW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfBVWTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:19:07 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44198 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfBVWTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:19:05 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DDE6460915; Fri, 22 Feb 2019 22:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550873944;
        bh=9t2SZ7zrd35gVahSxst8gxZJ86btG0fsUgholHi5jrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bLMAZoW6R5D6Ac32ebAKqLlC+5XQ6icyhJ1xKaVT8vPOsY0wm4sm0AUKfUPMhGzGi
         3A0O0N5PQnI+1CGw+dnedUj7oEkWWar2y5tC8DxZoc00ZIdwU/8lkXUWlgycma2nwH
         dh6rBgfrLv1tIXteAgr+IVZIwv6VWDCvmCbQQ78g=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1BB476034F;
        Fri, 22 Feb 2019 22:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550873944;
        bh=9t2SZ7zrd35gVahSxst8gxZJ86btG0fsUgholHi5jrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bLMAZoW6R5D6Ac32ebAKqLlC+5XQ6icyhJ1xKaVT8vPOsY0wm4sm0AUKfUPMhGzGi
         3A0O0N5PQnI+1CGw+dnedUj7oEkWWar2y5tC8DxZoc00ZIdwU/8lkXUWlgycma2nwH
         dh6rBgfrLv1tIXteAgr+IVZIwv6VWDCvmCbQQ78g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1BB476034F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     swboyd@chromium.org, evgreen@chromium.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org, Thierry Reding <treding@nvidia.com>,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v3 1/9] gpio: Add support for hierarchical IRQ domains
Date:   Fri, 22 Feb 2019 15:18:42 -0700
Message-Id: <20190222221850.26939-2-ilina@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222221850.26939-1-ilina@codeaurora.org>
References: <20190222221850.26939-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Hierarchical IRQ domains can be used to stack different IRQ controllers
on top of each other. One specific use-case where this can be useful is
if a power management controller has top-level controls for wakeup
interrupts. In such cases, the power management controller can be a
parent to other interrupt controllers and program additional registers
when an IRQ has its wake capability enabled or disabled.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/gpio/gpiolib.c      | 15 +++++++++++----
 include/linux/gpio/driver.h |  6 ++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index d1adfdf50fb3..46ccb9b174b9 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1895,7 +1895,9 @@ static int gpiochip_add_irqchip(struct gpio_chip *gpiochip,
 		type = IRQ_TYPE_NONE;
 	}
 
-	gpiochip->to_irq = gpiochip_to_irq;
+	if (!gpiochip->to_irq)
+		gpiochip->to_irq = gpiochip_to_irq;
+
 	gpiochip->irq.default_type = type;
 	gpiochip->irq.lock_key = lock_key;
 	gpiochip->irq.request_key = request_key;
@@ -1905,9 +1907,14 @@ static int gpiochip_add_irqchip(struct gpio_chip *gpiochip,
 	else
 		ops = &gpiochip_domain_ops;
 
-	gpiochip->irq.domain = irq_domain_add_simple(np, gpiochip->ngpio,
-						     gpiochip->irq.first,
-						     ops, gpiochip);
+	if (gpiochip->irq.parent_domain)
+		gpiochip->irq.domain = irq_domain_add_hierarchy(gpiochip->irq.parent_domain,
+								0, gpiochip->ngpio,
+								np, ops, gpiochip);
+	else
+		gpiochip->irq.domain = irq_domain_add_simple(np, gpiochip->ngpio,
+							     gpiochip->irq.first,
+							     ops, gpiochip);
 	if (!gpiochip->irq.domain)
 		return -EINVAL;
 
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 07cddbf45186..88ef196f96ec 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -48,6 +48,12 @@ struct gpio_irq_chip {
 	 */
 	const struct irq_domain_ops *domain_ops;
 
+	/**
+	 * @parent_domain:
+	 *
+	 */
+	struct irq_domain *parent_domain;
+
 	/**
 	 * @handler:
 	 *
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

