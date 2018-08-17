Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87597C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 19:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3912F21581
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 19:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KIpjLjmi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X19HZdfI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3912F21581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbeHQWQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 18:16:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36804 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbeHQWPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 18:15:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0E08C625B6; Fri, 17 Aug 2018 19:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534533042;
        bh=A1m7dwJP0HaSMmBsNDShWpIcs+BVZ/gRO/YlBTgCbDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KIpjLjmi7wR9F3MZpiyDv+3K7R93Ogj4ezML9aS1afdMtTMj8o3vpG2MDzpRY1SVt
         EhzgkMsCyLwdn/TtuGpAGDI3qFq8X7CGgbBucjYn7WuBymVMogllEuoc23WuLGYDqZ
         oEa6RhiFcG6X51U2j3iH31HmthdECZXUtRQjGBIY=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B3D8B62572;
        Fri, 17 Aug 2018 19:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534533041;
        bh=A1m7dwJP0HaSMmBsNDShWpIcs+BVZ/gRO/YlBTgCbDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X19HZdfIbp0jq8yV3XQ2kmdRBE2XfXkJVG4DDKzGIDKsq3et6xJhoUjjU5f6KQqPa
         6UxU2ZFHADtHvC9waAZYaOQDHkuSe27nA6G2QiJ7k4caH8iaad55cB7ldP/3IF6Yf+
         JTMcTaluoEQh59fyMqGwuTEMiU65W3lp251jeqiU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B3D8B62572
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     marc.zyngier@arm.com, bjorn.andersson@linaro.org, sboyd@kernel.org,
        evgreen@chromium.org, linus.walleij@linaro.org
Cc:     rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        dianders@chromium.org
Subject: [PATCH RESEND v1 5/5] irqchip/gic-v3: Allow interrupt to be configured as wake-up sources
Date:   Fri, 17 Aug 2018 13:10:26 -0600
Message-Id: <20180817191026.32245-6-ilina@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817191026.32245-1-ilina@codeaurora.org>
References: <20180817191026.32245-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <marc.zyngier@arm.com>

Although GICv3 doesn't directly offers support for wake-up interrupts
and relies on external HW for this, it shouldn't prevent the driver
for such HW from doing it work.

Let's set the required flags on the irq_chip structures.

Reported-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 76ea56d779a1..2d71c79bc698 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -861,7 +861,9 @@ static struct irq_chip gic_chip = {
 	.irq_set_affinity	= gic_set_affinity,
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
-	.flags			= IRQCHIP_SET_TYPE_MASKED,
+	.flags			= IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_MASK_ON_SUSPEND,
 };
 
 static struct irq_chip gic_eoimode1_chip = {
@@ -874,7 +876,9 @@ static struct irq_chip gic_eoimode1_chip = {
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
 	.irq_set_vcpu_affinity	= gic_irq_set_vcpu_affinity,
-	.flags			= IRQCHIP_SET_TYPE_MASKED,
+	.flags			= IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_MASK_ON_SUSPEND,
 };
 
 #define GIC_ID_NR		(1U << gic_data.rdists.id_bits)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

