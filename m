Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FB3C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890452086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890452086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbeKGXPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:15:31 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:54919 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727350AbeKGXPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:15:31 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id wA7DEbCo011300;
        Wed, 7 Nov 2018 15:14:37 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 8C8F2630CB; Wed,  7 Nov 2018 15:44:35 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     linus.walleij@linaro.org, yuenn@google.com, venture@google.com,
        benjaminfair@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au, kunyi@google.com
Cc:     linux-gpio@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 1/1] pinctrl: nuvoton: modify NPCM7xx pin configuration function
Date:   Wed,  7 Nov 2018 15:44:34 +0200
Message-Id: <20181107134434.354795-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20181107134434.354795-1-tmaimon77@gmail.com>
References: <20181107134434.354795-1-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify GPIO direction setting in pin configuration function by using
generic GPIO functions to set the GPIO direction instead of direct
access to the GPIO direction register.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
index 7ad50d9268aa..b455209382a5 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -1799,19 +1799,12 @@ static int npcm7xx_config_set_one(struct npcm7xx_pinctrl *npcm,
 		npcm_gpio_set(&bank->gc, bank->base + NPCM7XX_GP_N_PU, gpio);
 		break;
 	case PIN_CONFIG_INPUT_ENABLE:
-		if (arg) {
-			iowrite32(gpio, bank->base + NPCM7XX_GP_N_OEC);
-			npcm_gpio_set(&bank->gc, bank->base + NPCM7XX_GP_N_IEM,
-				      gpio);
-		} else
-			npcm_gpio_clr(&bank->gc, bank->base + NPCM7XX_GP_N_IEM,
-				      gpio);
+		iowrite32(gpio, bank->base + NPCM7XX_GP_N_OEC);
+		bank->direction_input(&bank->gc, pin % bank->gc.ngpio);
 		break;
 	case PIN_CONFIG_OUTPUT:
-		npcm_gpio_clr(&bank->gc, bank->base + NPCM7XX_GP_N_IEM, gpio);
-		iowrite32(gpio, arg ? bank->base + NPCM7XX_GP_N_DOS :
-			  bank->base + NPCM7XX_GP_N_DOC);
 		iowrite32(gpio, bank->base + NPCM7XX_GP_N_OES);
+		bank->direction_output(&bank->gc, pin % bank->gc.ngpio, arg);
 		break;
 	case PIN_CONFIG_DRIVE_PUSH_PULL:
 		npcm_gpio_clr(&bank->gc, bank->base + NPCM7XX_GP_N_OTYP, gpio);
-- 
2.14.1

