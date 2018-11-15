Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB88C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72792087A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72792087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388853AbeKPDZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:25:28 -0500
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:57291 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388798AbeKPDZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:25:27 -0500
Received: from belgarion.home ([90.89.234.36])
        by mwinf5d51 with ME
        id 0HGf1z00S0nnJME03HGjey; Thu, 15 Nov 2018 18:16:44 +0100
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Thu, 15 Nov 2018 18:16:44 +0100
X-ME-IP: 90.89.234.36
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: pxa: fix legacy non pinctrl aware builds again
Date:   Thu, 15 Nov 2018 18:16:38 +0100
Message-Id: <20181115171638.5704-1-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As pointed out by Gregor, spitz keyboard matrix is broken, with or
without CONFIG_PINCTRL set, quoting :
"The gpio matrix keypard on the Zaurus C3x00 (see spitz.c) does not work
properly. Noticeable are that rshift+c does nothing where as lshift+c
creates C.  Opposite it is for rshift+a vs lshift+a, here only rshift
works. This affects a few other combinations using the rshift or lshift
buttons."

As a matter of fact, as for platform_data based builds CONFIG_PINCTRL=n
is required for now (as opposed for devicetree builds where it should be
set), this means gpio driver should change the direction, which is what
was attempted by commit c4e5ffb6f224 ("gpio: pxa: fix legacy non pinctrl
aware builds").

Unfortunately, the input case was inverted, and the direction change was
never done. This wasn't seen up until now because the initial platform
setup (MFP) was setting this direction. Yet in Gregory's case, the
matrix-keypad driver changes back and forth the direction dynamically,
and this is why he's the first to report it.

Fixes: c4e5ffb6f224 ("gpio: pxa: fix legacy non pinctrl aware builds")
Tested-by: Greg <greguu@null.net>
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/gpio/gpio-pxa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 63536655f274..501147c5f3ca 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -268,8 +268,8 @@ static int pxa_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 
 	if (pxa_gpio_has_pinctrl()) {
 		ret = pinctrl_gpio_direction_input(chip->base + offset);
-		if (!ret)
-			return 0;
+		if (ret)
+			return ret;
 	}
 
 	spin_lock_irqsave(&gpio_lock, flags);
-- 
2.11.0

