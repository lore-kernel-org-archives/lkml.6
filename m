Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF50BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9034A20841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9034A20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732695AbeHAUOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:14:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46148 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404272AbeHATDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:37 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9FEC5126D;
        Wed,  1 Aug 2018 17:09:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.17 308/336] gpio: uniphier: set legitimate irq trigger type in .to_irq hook
Date:   Wed,  1 Aug 2018 18:50:43 +0200
Message-Id: <20180801165040.830290788@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <yamada.masahiro@socionext.com>

commit bbfbf04c2d4ef673f657175456f6693c9225748a upstream.

If a GPIO chip is a part of a hierarchy IRQ domain, there is no
way to specify the trigger type when gpio(d)_to_irq() allocates an
interrupt on-the-fly.

Currently, uniphier_gpio_to_irq() sets IRQ_TYPE_NONE, but it causes
an error in the .alloc() hook of the parent domain.
(drivers/irq/irq-uniphier-aidet.c)

Even if we change irq-uniphier-aidet.c to accept the NONE type,
GIC complains about it since commit 83a86fbb5b56 ("irqchip/gic:
Loudly complain about the use of IRQ_TYPE_NONE").

Instead, use IRQ_TYPE_LEVEL_HIGH as a temporary value when an irq
is allocated.  irq_set_irq_type() will override it when the irq is
really requested.

Fixes: dbe776c2ca54 ("gpio: uniphier: add UniPhier GPIO controller driver")
Reported-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Tested-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpio-uniphier.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/gpio/gpio-uniphier.c
+++ b/drivers/gpio/gpio-uniphier.c
@@ -181,7 +181,11 @@ static int uniphier_gpio_to_irq(struct g
 	fwspec.fwnode = of_node_to_fwnode(chip->parent->of_node);
 	fwspec.param_count = 2;
 	fwspec.param[0] = offset - UNIPHIER_GPIO_IRQ_OFFSET;
-	fwspec.param[1] = IRQ_TYPE_NONE;
+	/*
+	 * IRQ_TYPE_NONE is rejected by the parent irq domain. Set LEVEL_HIGH
+	 * temporarily. Anyway, ->irq_set_type() will override it later.
+	 */
+	fwspec.param[1] = IRQ_TYPE_LEVEL_HIGH;
 
 	return irq_create_fwspec_mapping(&fwspec);
 }


