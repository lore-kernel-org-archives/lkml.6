Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B69C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A949F21570
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhQd+HDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A949F21570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbeHTV3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 17:29:21 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44349 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbeHTV3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 17:29:19 -0400
Received: by mail-lf1-f66.google.com with SMTP id g6-v6so11601186lfb.11;
        Mon, 20 Aug 2018 11:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gfupvttg31c1aYTw/7RZmPdZ03ABXSWuZu+liq+qhKI=;
        b=rhQd+HDk2S+4SX7FJNRZaYhS5JapSnAZNfVkJChLnHKatb4BohrGxJWH+Q4jdcHIoJ
         iv0OF/KvhAWEMNm1cnnQYdohnRqJ4uv73/7ZGRd7Av+hobJHody6jctCaJ8PTyMJrII7
         X9wGulDH1bKBMXVOCn+WBBU+uTNz5dSHAsin7SgdC/XYmf9rG0bI9BdtiBOg7R6Rg1mG
         aCK5/BPs1Tu97yVGIf4OntqEcXFfvy7E7YdOgzIe69e985f53tYPWqNzRMIm9iwZxkRt
         Pa5GZ3EZMQr05kT8gYZpPaXxK1kb76hmzinDwJQCCPZ18Eli+8UzWP6fB3lmAw+SM4Kq
         u5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gfupvttg31c1aYTw/7RZmPdZ03ABXSWuZu+liq+qhKI=;
        b=oCZwDA9dScRL5Gan2ZC9mKy2zE7LAIHZJH9g5+78rm9yzEPKpIl7MqD3ndO5aByn3O
         dTbnj4yQxd04696brY0Vf6q6sGa+/UTzbpLYvSjEFVj5udUvgCNFSOqP4yQMa8503U/P
         NDuNkDElv9mw/vq8jORomYtjXCHVov4Y5nJpJRcy6E5xbCE2o3sSkgWyLwSZF6v0POYN
         s1YbZmxic4icobM1QvP7KucyPOaWKMh/51jsgQ8j0HQ9bZxohiMEwV4c2+L9syZJWoO6
         Sw2+zgdFf25WBIJHsljHwmmFCIIesemLMDjn2g/elstBPGV2CVKpwD9HAjxItTHSaQ/D
         cmoQ==
X-Gm-Message-State: AOUpUlFFd6+i3pykMJIXXCjYBkYhL/sby2a4vIsPmUNv1hxco1fEQLPb
        O6nUBaKP6QKMmd4p02ofI9c=
X-Google-Smtp-Source: AA+uWPz5SzY8Uj9T3YclS1cXRXYP1mhXxSq2/wEgCcvh4lMH276VbwBSkOZJG4QJmjcmqyhr08f4YQ==
X-Received: by 2002:a19:93d6:: with SMTP id w83-v6mr5260470lfk.63.1534788757432;
        Mon, 20 Aug 2018 11:12:37 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id g16-v6sm379918lfb.5.2018.08.20.11.12.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 11:12:36 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 1/3] ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO descriptor
Date:   Mon, 20 Aug 2018 20:13:31 +0200
Message-Id: <20180820181333.2527-2-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180820181333.2527-1-jmkrzyszt@gmail.com>
References: <20180820181333.2527-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't request MODEM IRQ GPIO by its global number in
ams_delta_modem_init().  Instead, obtain its GPIO descriptor
and assign related IRQ to the MODEM.  Do that from
omap_gpio_deps_init(), where the chip is already looked up.  Then, in
ams_delta_modem_init(), just check for the IRQ number having been
already assigned.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 46 ++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 34cb63ff45b3..b3fe515b6f49 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -630,6 +630,28 @@ static struct gpiod_hog ams_delta_gpio_hogs[] = {
 	{},
 };
 
+static struct plat_serial8250_port ams_delta_modem_ports[];
+
+/*
+ * Obtain MODEM IRQ GPIO descriptor using its hardware pin
+ * number and assign related IRQ number to the MODEM port.
+ * Keep the GPIO descriptor open so nobody steps in.
+ */
+static void __init modem_assign_irq(struct gpio_chip *chip)
+{
+	struct gpio_desc *gpiod;
+
+	gpiod = gpiochip_request_own_desc(chip, AMS_DELTA_GPIO_PIN_MODEM_IRQ,
+					  "modem_irq");
+	if (IS_ERR(gpiod)) {
+		pr_err("%s: modem IRQ GPIO request failed (%ld)\n", __func__,
+		       PTR_ERR(gpiod));
+	} else {
+		gpiod_direction_input(gpiod);
+		ams_delta_modem_ports[0].irq = gpiod_to_irq(gpiod);
+	}
+}
+
 /*
  * The purpose of this function is to take care of proper initialization of
  * devices and data structures which depend on GPIO lines provided by OMAP GPIO
@@ -649,7 +671,13 @@ static void __init omap_gpio_deps_init(void)
 		return;
 	}
 
+	/*
+	 * Start with FIQ initialization as it may have to request
+	 * and release successfully each OMAP GPIO pin in turn.
+	 */
 	ams_delta_init_fiq(chip, &ams_delta_serio_device);
+
+	modem_assign_irq(chip);
 }
 
 static void __init ams_delta_init(void)
@@ -844,20 +872,18 @@ static int __init modem_nreset_init(void)
 }
 
 
+/*
+ * This function expects MODEM IRQ number already assigned to the port
+ * and fails if it's not.
+ */
 static int __init ams_delta_modem_init(void)
 {
 	int err;
 
-	omap_cfg_reg(M14_1510_GPIO2);
-	ams_delta_modem_ports[0].irq =
-			gpio_to_irq(AMS_DELTA_GPIO_PIN_MODEM_IRQ);
+	if (ams_delta_modem_ports[0].irq < 0)
+		return ams_delta_modem_ports[0].irq;
 
-	err = gpio_request(AMS_DELTA_GPIO_PIN_MODEM_IRQ, "modem");
-	if (err) {
-		pr_err("Couldn't request gpio pin for modem\n");
-		return err;
-	}
-	gpio_direction_input(AMS_DELTA_GPIO_PIN_MODEM_IRQ);
+	omap_cfg_reg(M14_1510_GPIO2);
 
 	/* Initialize the modem_nreset regulator consumer before use */
 	modem_priv.regulator = ERR_PTR(-ENODEV);
@@ -866,8 +892,6 @@ static int __init ams_delta_modem_init(void)
 			AMS_DELTA_LATCH2_MODEM_CODEC);
 
 	err = platform_device_register(&ams_delta_modem_device);
-	if (err)
-		gpio_free(AMS_DELTA_GPIO_PIN_MODEM_IRQ);
 
 	return err;
 }
-- 
2.16.4

