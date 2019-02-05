Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4786FC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF4D217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qp6bICfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbfBEWUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:20:55 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33877 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfBEWUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:20:55 -0500
Received: by mail-pg1-f193.google.com with SMTP id d9so2029003pgl.1;
        Tue, 05 Feb 2019 14:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=VsW4w9Tidh8kQF/wOzdszRJTB9PdDmdFIqsfVlGud5k=;
        b=Qp6bICfo6VCKyysBjCiL+FTycKf9OsHR4/hi5pi1dlZ9iWGuC2QOxdNe5KA/dgaG5R
         unpaRLrfOYGIrknLm8JFsNODvdlGmIq3uyX1f7w9Nza+MwFOnmE87AsPR8FVyZLv/xML
         RSKDSt8GE7zk5DOYwICnOcBw494CBfst4ur8TJXtp0N4oClrJeBht1+vG7L/xgk11P9+
         H2y1dL0xea2b9jfQr7YpbkJeWBze59esLEZnA85ISq+2D2hCIIiUEKmdSJw3rUw6/loo
         eucSmDO9BnmrAqegl7lmVDjAgwjFT2QW8Je+/EwqiFd8eb/qTnFpcNjHHgZTbsy61IkO
         aPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=VsW4w9Tidh8kQF/wOzdszRJTB9PdDmdFIqsfVlGud5k=;
        b=Blr03qQZKQ8wuR9TYauOWbUwLiBFUaNLM+PeOicEeNAcbfKK0Fd0HioNALKQbYhWjO
         6JlXt2A73mlawDLxb0VqTrit9RgyILA6jHS7MMU0BRDeAs7eFav72a96ibosUxSgzN30
         tAAkimdnU+WG24Y6uH1A8lNwjzSXM/IpIzfsq8pL6cN+KhE95cxbAhdO821josvJBNnE
         HxxJskHGB1xmQvqtTcyprHBAEWb/Z3XRYl29WJpvpAMJmUAwxoamHFiFZQugqp4NS9J1
         OCGEE8glQT4ajNH6Y4HSkdeXrzaZWH62sv8HguJZTsqyN3rrtxLe1YZmoBJGUUECmJbl
         +naw==
X-Gm-Message-State: AHQUAuZqd4JImA6qm5M9OtpW8jqhj4xk6PrNybUIiza5H8Piy8QIeVgD
        Prd+kuE7/kqaPk5cQUjIskKy8+ay
X-Google-Smtp-Source: AHgI3IYw2a84v8avU20jClpDYZdXGMBAgRMuWAaIZjV3ziLNMG+cnPvQdIXm2lhSBGlS0JQDeJR1vA==
X-Received: by 2002:a63:9c1a:: with SMTP id f26mr6619274pge.381.1549405253198;
        Tue, 05 Feb 2019 14:20:53 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id r8sm4847051pgr.48.2019.02.05.14.20.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 14:20:52 -0800 (PST)
Date:   Tue, 5 Feb 2019 14:20:50 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: cap11xx - switch to using set_brightness_blocking()
Message-ID: <20190205222050.GA145676@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updating LED state requires access to regmap and therefore we may sleep, so
we could not do that directly form set_brightness() method. Historically
we used private work to adjust the brightness, but with the introduction of
set_brightness_blocking() we no longer need it.

As a bonus, not having our own work item means we do not have
use-after-free issue as we neglected to cancel outstanding work on driver
unbind.

Reported-by: Sven Van Asbroeck <thesven73@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/cap11xx.c | 47 ++++++++++++++------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 312916f99597..c0baf323ddda 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -75,9 +75,8 @@
 struct cap11xx_led {
 	struct cap11xx_priv *priv;
 	struct led_classdev cdev;
-	struct work_struct work;
 	u32 reg;
-	enum led_brightness new_brightness;
+	enum led_brightness brightness;
 };
 #endif
 
@@ -233,30 +232,28 @@ static void cap11xx_input_close(struct input_dev *idev)
 }
 
 #ifdef CONFIG_LEDS_CLASS
-static void cap11xx_led_work(struct work_struct *work)
-{
-	struct cap11xx_led *led = container_of(work, struct cap11xx_led, work);
-	struct cap11xx_priv *priv = led->priv;
-	int value = led->new_brightness;
-
-	/*
-	 * All LEDs share the same duty cycle as this is a HW limitation.
-	 * Brightness levels per LED are either 0 (OFF) and 1 (ON).
-	 */
-	regmap_update_bits(priv->regmap, CAP11XX_REG_LED_OUTPUT_CONTROL,
-				BIT(led->reg), value ? BIT(led->reg) : 0);
-}
-
-static void cap11xx_led_set(struct led_classdev *cdev,
-			   enum led_brightness value)
+static int cap11xx_led_set(struct led_classdev *cdev,
+			    enum led_brightness value)
 {
 	struct cap11xx_led *led = container_of(cdev, struct cap11xx_led, cdev);
+	struct cap11xx_priv *priv = led->priv;
+	int error = 0;
+
+	if (led->brightness != value) {
+		/*
+		 * All LEDs share the same duty cycle as this is a HW
+		 * limitation. Brightness levels per LED are either
+		 * 0 (OFF) and 1 (ON).
+		 */
+		error = regmap_update_bits(priv->regmap,
+					   CAP11XX_REG_LED_OUTPUT_CONTROL,
+					   BIT(led->reg),
+					   value ? BIT(led->reg) : 0);
+		if (!error)
+			led->brightness = value;
+	}
 
-	if (led->new_brightness == value)
-		return;
-
-	led->new_brightness = value;
-	schedule_work(&led->work);
+	return error;
 }
 
 static int cap11xx_init_leds(struct device *dev,
@@ -299,7 +296,7 @@ static int cap11xx_init_leds(struct device *dev,
 		led->cdev.default_trigger =
 			of_get_property(child, "linux,default-trigger", NULL);
 		led->cdev.flags = 0;
-		led->cdev.brightness_set = cap11xx_led_set;
+		led->cdev.brightness_set_blocking = cap11xx_led_set;
 		led->cdev.max_brightness = 1;
 		led->cdev.brightness = LED_OFF;
 
@@ -312,8 +309,6 @@ static int cap11xx_init_leds(struct device *dev,
 		led->reg = reg;
 		led->priv = priv;
 
-		INIT_WORK(&led->work, cap11xx_led_work);
-
 		error = devm_led_classdev_register(dev, &led->cdev);
 		if (error) {
 			of_node_put(child);
-- 
2.20.1.611.gfbb209baf1-goog


-- 
Dmitry
