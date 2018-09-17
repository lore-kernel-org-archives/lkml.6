Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BADECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F2C2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F2C2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733066AbeIREo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:44:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51272 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730352AbeIREoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:44:25 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C238E707;
        Mon, 17 Sep 2018 23:14:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 116/158] pinctrl/amd: only handle irq if it is pending and unmasked
Date:   Tue, 18 Sep 2018 00:42:26 +0200
Message-Id: <20180917211716.603337282@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Kurtz <djkurtz@chromium.org>

[ Upstream commit 8bbed1eef001fdfc0ee9595f64cc4f769d265af4 ]

The AMD pinctrl driver demultiplexes GPIO interrupts and fires off their
individual handlers.

If one of these GPIO irqs is configured as a level interrupt, and its
downstream handler is a threaded ONESHOT interrupt, the GPIO interrupt
source is masked by handle_level_irq() until the eventual return of the
threaded irq handler.  During this time the level GPIO interrupt status
will still report as high until the actual gpio source is cleared - both
in the individual GPIO interrupt status bit (INTERRUPT_STS_OFF) and in
its corresponding "WAKE_INT_STATUS_REG" bit.

Thus, if another GPIO interrupt occurs during this time,
amd_gpio_irq_handler() will see that the (masked-and-not-yet-cleared)
level irq is still pending and incorrectly call its handler again.

To fix this, have amd_gpio_irq_handler() check for both interrupts status
and mask before calling generic_handle_irq().

Note: Is it possible that this bug was the source of the interrupt storm
on Ryzen when using chained interrupts before commit ba714a9c1dea85
("pinctrl/amd: Use regular interrupt instead of chained")?

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/pinctrl-amd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -552,7 +552,8 @@ static irqreturn_t amd_gpio_irq_handler(
 		/* Each status bit covers four pins */
 		for (i = 0; i < 4; i++) {
 			regval = readl(regs + i);
-			if (!(regval & PIN_IRQ_PENDING))
+			if (!(regval & PIN_IRQ_PENDING) ||
+			    !(regval & BIT(INTERRUPT_MASK_OFF)))
 				continue;
 			irq = irq_find_mapping(gc->irq.domain, irqnr + i);
 			generic_handle_irq(irq);


