Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46601C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E08208E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E08208E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967946AbeFRIfo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:35:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36078 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967323AbeFRIfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:35:41 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EDD1AC8A;
        Mon, 18 Jun 2018 08:35:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 111/189] ARM: OMAP1: ams-delta: fix deferred_fiq handler
Date:   Mon, 18 Jun 2018 10:13:27 +0200
Message-Id: <20180618081213.726548876@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Janusz Krzysztofik <jmkrzyszt@gmail.com>

[ Upstream commit baf64250b4a513bf4ac226fd938692dc1836f4f6 ]

The deferred_fiq handler used to limit hardware operations to IRQ
unmask only, relying on gpio-omap assigned handler performing the ACKs.
Since commit 80ac93c27441 ("gpio: omap: Fix lost edge interrupts") this
is no longer the case as handle_edge_irq() has been replaced with
handle_simmple_irq() which doesn't touch the hardware.

Add single ACK operation per each active IRQ pin to the handler. While
being at it, move unmask operation out of irq_counter loop so it is
also called only once for each active IRQ pin.

Fixes: 80ac93c27441 ("gpio: omap: Fix lost edge interrupts")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-omap1/ams-delta-fiq.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

--- a/arch/arm/mach-omap1/ams-delta-fiq.c
+++ b/arch/arm/mach-omap1/ams-delta-fiq.c
@@ -58,22 +58,24 @@ static irqreturn_t deferred_fiq(int irq,
 		irq_num = gpio_to_irq(gpio);
 		fiq_count = fiq_buffer[FIQ_CNT_INT_00 + gpio];
 
-		while (irq_counter[gpio] < fiq_count) {
-			if (gpio != AMS_DELTA_GPIO_PIN_KEYBRD_CLK) {
-				struct irq_data *d = irq_get_irq_data(irq_num);
+		if (irq_counter[gpio] < fiq_count &&
+				gpio != AMS_DELTA_GPIO_PIN_KEYBRD_CLK) {
+			struct irq_data *d = irq_get_irq_data(irq_num);
 
-				/*
-				 * It looks like handle_edge_irq() that
-				 * OMAP GPIO edge interrupts default to,
-				 * expects interrupt already unmasked.
-				 */
-				if (irq_chip && irq_chip->irq_unmask)
+			/*
+			 * handle_simple_irq() that OMAP GPIO edge
+			 * interrupts default to since commit 80ac93c27441
+			 * requires interrupt already acked and unmasked.
+			 */
+			if (irq_chip) {
+				if (irq_chip->irq_ack)
+					irq_chip->irq_ack(d);
+				if (irq_chip->irq_unmask)
 					irq_chip->irq_unmask(d);
 			}
-			generic_handle_irq(irq_num);
-
-			irq_counter[gpio]++;
 		}
+		for (; irq_counter[gpio] < fiq_count; irq_counter[gpio]++)
+			generic_handle_irq(irq_num);
 	}
 	return IRQ_HANDLED;
 }


