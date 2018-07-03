Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014F4C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B5124B1C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B5124B1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932350AbeGCOL1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:11:27 -0400
Received: from foss.arm.com ([217.140.101.70]:49792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932085AbeGCOLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:11:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C9187A9;
        Tue,  3 Jul 2018 07:11:25 -0700 (PDT)
Received: from approximate.cambridge.arm.com (approximate.cambridge.arm.com [10.1.206.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D4D23F5AD;
        Tue,  3 Jul 2018 07:11:24 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     ulf.hansson@linaro.org, linus.walleij@linaro.org,
        shawn.lin@rock-chips.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: core: Fix struct mmc_gpio corruption
Date:   Tue,  3 Jul 2018 15:11:14 +0100
Message-Id: <20180703141114.11609-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I recently realised that something was amiss with /proc/interrupts
on my cubietruck:

 51:          0          0     GICv2  41 Level     mv64xxx_i2c
 59:       1047          0     GICv2 117 Level     eth0
 66:          2          0  sunxi_pio_edge   1 Edge   XXXXX

where XXXXX has some non-ASCII characters, while I was expecting:

 66:          0          0  sunxi_pio_edge   1 Edge      1c0f000.mmc cd

It turns out that the cd_debounce_delay_ms field was recently to
struct mmc_gpio, and carefully placed at the one spot where it could
cause damage: right *after* the zero-sized array that contains the
associated label. This label ends up being passed to the IRQ
subsystem, and then overwritten by the cd_debounce_delay_ms field.

Funky!

Let's move that field to a less crowded location.

Fixes: bfd694d5e21c ("mmc: core: Add tunable delay before detecting card after card is inserted")
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/mmc/core/slot-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index ef05e0039378..1ccf9dc07395 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -27,8 +27,8 @@ struct mmc_gpio {
 	bool override_cd_active_level;
 	irqreturn_t (*cd_gpio_isr)(int irq, void *dev_id);
 	char *ro_label;
-	char cd_label[0];
 	u32 cd_debounce_delay_ms;
+	char cd_label[0];
 };
 
 static irqreturn_t mmc_gpio_cd_irqt(int irq, void *dev_id)
-- 
2.17.1

