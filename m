Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2FDB4C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D422A208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="SSlY01Q0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D422A208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeFNF2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 01:28:52 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:18255 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeFNF2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 01:28:51 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w5E5RuGd013676;
        Thu, 14 Jun 2018 14:27:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w5E5RuGd013676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528954077;
        bh=eqYtAnV/+K9nYMuCa/VpRmWKdlqJ+MYvrJcN4pfytH0=;
        h=From:To:Cc:Subject:Date:From;
        b=SSlY01Q0hFe8Q4dSsFuGlGrcMA4+EIFidmDrteSTfoPI4BvHfgYdUuhKvQoQCFRIt
         P8GOgVniuU14TRAiJWcxhLmqKFefPKSGLez+g6kP3OwNmWbJplJzANXyN35U08exsk
         XNmrHHiBqK6IgivAbzaNZR1u4e3mh/u9J8yWG3Z0r6xtnsYBtrL//t8M1WcLDPK6xh
         i3RBW0Zd5pIHmDJQ24UUXVDEQtAwOStnt7s39P1W1dzK7Gakk+or70WxlU7iwUAStZ
         mrkEO2Lfn62jmhuaWo8lWl8Jmer8L5hKFrCcgOJ0KuKNrH/Jecs2LEtZ6PwxGjiipP
         9Q/hHEsmHc0IA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: uniphier: set legitimate irq trigger type in .to_irq hook
Date:   Thu, 14 Jun 2018 14:27:45 +0900
Message-Id: <1528954065-25563-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---

 drivers/gpio/gpio-uniphier.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-uniphier.c b/drivers/gpio/gpio-uniphier.c
index d3cf950..58faeb1 100644
--- a/drivers/gpio/gpio-uniphier.c
+++ b/drivers/gpio/gpio-uniphier.c
@@ -181,7 +181,11 @@ static int uniphier_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
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
-- 
2.7.4

