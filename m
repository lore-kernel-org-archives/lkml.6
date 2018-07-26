Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22C4C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1D320673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="SUr+BkJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1D320673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbeGZRAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:00:20 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:57672 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731721AbeGZRAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:00:19 -0400
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 5E76C5C21F8;
        Thu, 26 Jul 2018 17:42:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1532619773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=h8U3CnkoFMKT1i1yIuUZum9/1P/lyHhs+Q+sLSHT8BY=;
        b=SUr+BkJQuL4ifMz7gTa5cwQU8bFmRx13vjvCZAxtIm/KqvsVIzFUm12r2aEC0Cbyk1cHHl
        9b2MZY8GqS0riegonUijdoelUJsucYtDpx5bgmFCl+D8koxWVm/RnFlfjK5Eln1r0cPBiM
        aANr3B5Kfsk3uYmqh3RYrmaUMqZe1A0=
From:   Stefan Agner <stefan@agner.ch>
To:     linus.walleij@linaro.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH] gpio: tegra: drop tegra specific GPIO lockdep classes
Date:   Thu, 26 Jul 2018 17:42:52 +0200
Message-Id: <20180726154252.14137-1-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
X-Spamd-Result: default: False [-0.60 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         SUSPICIOUS_RECIPS(1.50)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:6830, ipnet:46.140.0.0/17, country:AT];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit e45d1c80c0ee ("gpio: put GPIO IRQs into their own lock
class") and commit a0a8bcf4670c ("gpiolib: irqchip: use different
lockdep class for each gpio irqchip") GPIO lib takes care of lockdep
classes. In fact, gpiochip_irq_map() overwrites the class anyway, so
the lockdep class set by the driver is useless. Remove it.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpio/gpio-tegra.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 94396caaca75..e5fcc012179e 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -550,13 +550,6 @@ static const struct dev_pm_ops tegra_gpio_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(tegra_gpio_suspend, tegra_gpio_resume)
 };
 
-/*
- * This lock class tells lockdep that GPIO irqs are in a different category
- * than their parents, so it won't report false recursion.
- */
-static struct lock_class_key gpio_lock_class;
-static struct lock_class_key gpio_request_class;
-
 static int tegra_gpio_probe(struct platform_device *pdev)
 {
 	struct tegra_gpio_info *tgi;
@@ -661,8 +654,6 @@ static int tegra_gpio_probe(struct platform_device *pdev)
 
 		bank = &tgi->bank_info[GPIO_BANK(gpio)];
 
-		irq_set_lockdep_class(irq, &gpio_lock_class,
-				      &gpio_request_class);
 		irq_set_chip_data(irq, bank);
 		irq_set_chip_and_handler(irq, &tgi->ic, handle_simple_irq);
 	}
-- 
2.18.0

