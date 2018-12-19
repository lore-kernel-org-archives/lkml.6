Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35DFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F4D20879
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VA870PGR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AVM0Aw3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbeLSWLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:11:34 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44474 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729587AbeLSWLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:11:31 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C8362608C5; Wed, 19 Dec 2018 22:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545257490;
        bh=vgKObgUP3PBENRIoVDIXRGSK16opUVYnkrhtJlTmOTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VA870PGRcX8Fz5IANYo5J6ouj/C9w5RXqAtgZ6t3ylpPxVWTMKpFm1S5XPmAHXm8L
         IjFz5zIG1PDpmf6f9/UvzCW9BceZcJf27qDw11xdtTO0LpDXZDZrI/4nMLRR1uQC5y
         YILZjPNFdI1ZetYu+a9Kje5w0Usy7QcbPMMSsz2U=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C5CC1606FC;
        Wed, 19 Dec 2018 22:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545257489;
        bh=vgKObgUP3PBENRIoVDIXRGSK16opUVYnkrhtJlTmOTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AVM0Aw3dxc1UA4m1uW4Fc6ps/Fd25wa0zyZUVBlh2SSeDZfUyyAmEs5rfwjAXWM+E
         oQNwD8zrkihqheiMQk0D8VpZuckz7xtM4SWYpzZ3jFQmBFMbSqDDc7rwyxBXLIoAOv
         fIJWvSfr/P0WAVeRJ4bsYJCiz667WTo9e0GfPxO4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C5CC1606FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     sboyd@kernel.org, evgreen@chromium.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, Thierry Reding <treding@nvidia.com>
Subject: [PATCH 1/7] gpio: Add support for hierarchical IRQ domains
Date:   Wed, 19 Dec 2018 15:10:59 -0700
Message-Id: <20181219221105.3004-2-ilina@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181219221105.3004-1-ilina@codeaurora.org>
References: <20181219221105.3004-1-ilina@codeaurora.org>
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
---
 drivers/gpio/gpiolib.c      | 15 +++++++++++----
 include/linux/gpio/driver.h |  6 ++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 230e41562462..eb08de2e7c1d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1917,7 +1917,9 @@ static int gpiochip_add_irqchip(struct gpio_chip *gpiochip,
 		type = IRQ_TYPE_NONE;
 	}
 
-	gpiochip->to_irq = gpiochip_to_irq;
+	if (!gpiochip->to_irq)
+		gpiochip->to_irq = gpiochip_to_irq;
+
 	gpiochip->irq.default_type = type;
 	gpiochip->irq.lock_key = lock_key;
 	gpiochip->irq.request_key = request_key;
@@ -1927,9 +1929,14 @@ static int gpiochip_add_irqchip(struct gpio_chip *gpiochip,
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
index 2db62b550b95..abcdb0c25a93 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -47,6 +47,12 @@ struct gpio_irq_chip {
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

