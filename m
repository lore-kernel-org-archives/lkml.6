Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DBDC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53E924139
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="SpGnCyiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C53E924139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754177AbeF0Lzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 07:55:37 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:36006 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934011AbeF0LzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 07:55:05 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/5] pinctrl: Add core function pinmux_gpio_get_direction
Date:   Wed, 27 Jun 2018 13:49:00 +0200
Message-Id: <20180627114904.10890-2-paul@crapouillou.net>
In-Reply-To: <20180627114904.10890-1-paul@crapouillou.net>
References: <20180627114904.10890-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1530100162; bh=IxEG0iiUDOF0wQpHEcPKWXX6wP2KoQPi3uZa1sN3P+M=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SpGnCyiAE6tA+y5ZfvXOWfR9QJCRxOx2QRAsJdqPVNvNHc6vBKkYnNaWZDjvg1PFwWalAFkQ9KckCiRpa+KFRIgsbf/T9o32qt9aMrK4XeQgZrxPxZ1Tmr8Z5VKctGEWyzCTdSPpRHRo4NlRmTsZb6+Lzg2BqA0GA4xAxr9lqZE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now there is a core function to set the direction (input or output)
of a GPIO, pinmux_gpio_set_direction(). This function is provided to the
consumers with two wrappers, pinctrl_gpio_direction_input() /
pinctrl_gpio_direction_output(). Typically, these functions are used
within GPIO drivers, where the .direction_input/.direction_output
callbacks of the "gpio_chip" simply call into these pinctrl functions.

However, until now there was no corresponding pinmux_get_direction()
core function (nor pinctrl_gpio_get_direction), which means that it was
not possible to call into the pinctrl subsystem for the .get_direction
callback of the "gpio_chip".

Here, we introduce the pinmux_gpio_get_direction() core function, as
well as the .gpio_get_direction callback in the pinmux_ops structure.
Now it's up to the pinctrl drivers to implement that callback.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pinctrl/pinmux.c       | 17 +++++++++++++++++
 drivers/pinctrl/pinmux.h       |  3 +++
 include/linux/pinctrl/pinmux.h |  5 +++++
 3 files changed, 25 insertions(+)

diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index b8e9bda8ec98..e502a4f5be6f 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -291,6 +291,23 @@ int pinmux_gpio_direction(struct pinctrl_dev *pctldev,
 	return ret;
 }
 
+int pinmux_gpio_get_direction(struct pinctrl_dev *pctldev,
+			      struct pinctrl_gpio_range *range,
+			      unsigned int pin)
+{
+	const struct pinmux_ops *ops;
+	int ret;
+
+	ops = pctldev->desc->pmxops;
+
+	if (ops->gpio_get_direction)
+		ret = ops->gpio_get_direction(pctldev, range, pin);
+	else
+		ret = -ENXIO;
+
+	return ret;
+}
+
 static int pinmux_func_name_to_selector(struct pinctrl_dev *pctldev,
 					const char *function)
 {
diff --git a/drivers/pinctrl/pinmux.h b/drivers/pinctrl/pinmux.h
index a331fcdbedd9..8cdab9e71870 100644
--- a/drivers/pinctrl/pinmux.h
+++ b/drivers/pinctrl/pinmux.h
@@ -24,6 +24,9 @@ void pinmux_free_gpio(struct pinctrl_dev *pctldev, unsigned pin,
 int pinmux_gpio_direction(struct pinctrl_dev *pctldev,
 			  struct pinctrl_gpio_range *range,
 			  unsigned pin, bool input);
+int pinmux_gpio_get_direction(struct pinctrl_dev *pctldev,
+			  struct pinctrl_gpio_range *range,
+			  unsigned pin);
 
 int pinmux_map_to_setting(const struct pinctrl_map *map,
 			  struct pinctrl_setting *setting);
diff --git a/include/linux/pinctrl/pinmux.h b/include/linux/pinctrl/pinmux.h
index ace60d775b20..b3e73deffb49 100644
--- a/include/linux/pinctrl/pinmux.h
+++ b/include/linux/pinctrl/pinmux.h
@@ -56,6 +56,8 @@ struct pinctrl_dev;
  *	depending on whether the GPIO is configured as input or output,
  *	a direction selector function may be implemented as a backing
  *	to the GPIO controllers that need pin muxing.
+ * @gpio_get_direction: Return the direction (input or output) of the given
+ *	GPIO.
  * @strict: do not allow simultaneous use of the same pin for GPIO and another
  *	function. Check both gpio_owner and mux_owner strictly before approving
  *	the pin request.
@@ -82,6 +84,9 @@ struct pinmux_ops {
 				   struct pinctrl_gpio_range *range,
 				   unsigned offset,
 				   bool input);
+	int (*gpio_get_direction) (struct pinctrl_dev *pctrldev,
+				   struct pinctrl_gpio_range *range,
+				   unsigned int offset);
 	bool strict;
 };
 
-- 
2.11.0

